"""Transaction parity tests.

Tests that validate atomic transactions for critical operations.
Based on _reversa_sdd/migration/parity_specs.md section 10.

@critical: Transaction atomicity affects data consistency and stock management.
"""

from __future__ import annotations

from datetime import date, datetime

import pytest
from sqlalchemy import text
from sqlalchemy.ext.asyncio import AsyncSession

from app.bounded_contexts.catalog.domain.entities import SituacaoCd


@pytest.mark.transaction_parity
@pytest.mark.critical
class TestTransactionParity:
    """Test transaction atomicity for critical operations.

    BR-MIGRAR-029: Transaction atomicity between rental and CD update.
    BR-MIGRAR-017: Stock validation.
    """

    @pytest.mark.asyncio
    async def test_rental_transaction_atomicity(
        self,
        async_session: AsyncSession,
        rental_service,
        available_cd,
        active_customer,
    ) -> None:
        """Test that rental creation is atomic (BR-MIGRAR-029).

        If any part fails, entire transaction should rollback.
        Operations involved:
        - CREATE locacao
        - INSERT items
        - UPDATE cd situacao
        - UPDATE recibo

        All must happen atomically or none.
        """
        cd_codigo = available_cd.codigo
        codcliente = active_customer.codcliente

        # Verify initial state
        cd_before = await rental_service._cd_repo.get_by_codigo(cd_codigo)
        assert cd_before.situacao == SituacaoCd.DISPONIVEL

        # Create rental
        locacao, recibo, events = await rental_service.create_rental(
            codcliente=codcliente,
            cd_codigo=cd_codigo,
            data_locacao=datetime.now(),
        )

        # Verify atomicity: all or nothing
        assert locacao is not None, "Location should be created"
        assert recibo is not None, "Receipt should be created"
        assert len(events) > 0, "Events should be published"

        # Verify CD status changed atomically
        cd_after = await rental_service._cd_repo.get_by_codigo(cd_codigo)
        assert cd_after.situacao == SituacaoCd.LOCADO, "CD should be marked as rented"

        # Verify database state
        result = await async_session.execute(
            text("SELECT COUNT(*) FROM locacoes WHERE id = :id"),
            {"id": locacao.id},
        )
        rental_count = result.scalar_one()
        assert rental_count == 1, "Rental should exist in database"

        result = await async_session.execute(
            text("SELECT COUNT(*) FROM recibos WHERE codrecibo = :codrecibo"),
            {"codrecibo": recibo.codrecibo},
        )
        receipt_count = result.scalar_one()
        assert receipt_count == 1, "Receipt should exist in database"

    @pytest.mark.asyncio
    async def test_rental_transaction_rollback_on_error(
        self,
        async_session: AsyncSession,
        rental_service,
        available_cd,
        active_customer,
    ) -> None:
        """Test that rental transaction rolls back on error (BR-MIGRAR-029).

        If any operation fails, database should remain in initial state.
        """
        cd_codigo = available_cd.codigo
        codcliente = active_customer.codcliente

        # Verify initial state
        cd_before = await rental_service._cd_repo.get_by_codigo(cd_codigo)
        assert cd_before.situacao == SituacaoCd.DISPONIVEL

        # Try to create rental with non-existent dependent (should fail)
        with pytest.raises(ValueError, match="Dependente .* não encontrado"):
            await rental_service.create_rental(
                codcliente=codcliente,
                cd_codigo=cd_codigo,
                data_locacao=datetime.now(),
                coddependente=999999,  # Non-existent
            )

        # Verify rollback: CD should still be available
        cd_after = await rental_service._cd_repo.get_by_codigo(cd_codigo)
        assert cd_after.situacao == SituacaoCd.DISPONIVEL, (
            "CD should remain available after failed rental"
        )

        # Verify no rental was created
        result = await async_session.execute(
            text("SELECT COUNT(*) FROM locacoes WHERE id_cliente = :id_cliente"),
            {"id_cliente": codcliente},
        )
        rental_count = result.scalar_one()
        # Rental count should be same as before (no new rental)

    @pytest.mark.asyncio
    async def test_return_transaction_atomicity(
        self,
        async_session: AsyncSession,
        rental_service,
        pending_rental,
    ) -> None:
        """Test that return operation is atomic (BR-MIGRAR-029).

        Operations involved:
        - UPDATE cd situacao (to available)
        - UPDATE recibo devolvido
        - UPDATE locacao (multa, data_devolucao)

        All must happen atomically or none.
        """
        codlocacao = pending_rental.id
        cd_codigo = pending_rental.codcd

        # Verify initial state
        cd_before = await rental_service._cd_repo.get_by_codigo(cd_codigo)
        assert cd_before.situacao == SituacaoCd.LOCADO

        # Return rental (on time, no penalty)
        locacao, events = await rental_service.return_rental(
            codlocacao=codlocacao,
            data_devolucao=date.today(),
        )

        # Verify atomicity
        assert locacao is not None, "Location should be updated"
        assert len(events) > 0, "Events should be published"

        # Verify CD status changed atomically
        cd_after = await rental_service._cd_repo.get_by_codigo(cd_codigo)
        assert cd_after.situacao == SituacaoCd.DISPONIVEL, (
            "CD should be marked as available"
        )

        # Verify receipt is marked as returned
        recibo = await rental_service.get_receipt(locacao.codrecibo)
        assert recibo.devolvido, "Receipt should be marked as returned"

    @pytest.mark.asyncio
    async def test_return_transaction_rollback_on_error(
        self,
        async_session: AsyncSession,
        rental_service,
        pending_rental,
    ) -> None:
        """Test that return transaction rolls back on error (BR-MIGRAR-029)."""
        codlocacao = pending_rental.id
        cd_codigo = pending_rental.codcd

        # Verify initial state
        cd_before = await rental_service._cd_repo.get_by_codigo(cd_codigo)
        assert cd_before.situacao == SituacaoCd.LOCADO

        # Try to return non-existent rental (should fail)
        with pytest.raises(ValueError, match="Locação .* não encontrada"):
            await rental_service.return_rental(
                codlocacao=999999,
                data_devolucao=date.today(),
            )

        # Verify rollback: CD should remain rented
        cd_after = await rental_service._cd_repo.get_by_codigo(cd_codigo)
        assert cd_after.situacao == SituacaoCd.LOCADO, (
            "CD should remain rented after failed return"
        )

    @pytest.mark.asyncio
    async def test_concurrent_rental_prevents_double_booking(
        self,
        async_session: AsyncSession,
        rental_service,
        available_cd,
        active_customer,
        another_active_customer,
    ) -> None:
        """Test that concurrent rentals don't cause double booking (BR-MIGRAR-017).

        Two transactions should not be able to rent the same CD simultaneously.
        """
        cd_codigo = available_cd.codigo

        # First rental
        locacao1, recibo1, events1 = await rental_service.create_rental(
            codcliente=active_customer.codcliente,
            cd_codigo=cd_codigo,
            data_locacao=datetime.now(),
        )

        assert locacao1 is not None
        assert cd_codigo == locacao1.codcd

        # Second rental should fail (CD already rented)
        with pytest.raises(ValueError, match="CD .* não está disponível"):
            await rental_service.create_rental(
                codcliente=another_active_customer.codcliente,
                cd_codigo=cd_codigo,
                data_locacao=datetime.now(),
            )

        # Verify only one rental exists
        result = await async_session.execute(
            text("SELECT COUNT(*) FROM locacoes WHERE codcd = :cd_codigo"),
            {"cd_codigo": cd_codigo},
        )
        rental_count = result.scalar_one()
        assert rental_count == 1, "Only one rental should exist for the CD"

    @pytest.mark.asyncio
    async def test_rental_creates_linked_records(
        self,
        async_session: AsyncSession,
        rental_service,
        available_cd,
        active_customer,
    ) -> None:
        """Test that rental creates all linked records correctly.

        A rental creates:
        - 1 locacao record
        - 1 recibo record (with rental added)
        - CD status update

        All should exist and be linked.
        """
        cd_codigo = available_cd.codigo
        codcliente = active_customer.codcliente

        # Create rental
        locacao, recibo, events = await rental_service.create_rental(
            codcliente=codcliente,
            cd_codigo=cd_codigo,
            data_locacao=datetime.now(),
        )

        # Verify linkage
        assert locacao.codrecibo == recibo.codrecibo, (
            "Location should be linked to receipt"
        )
        assert locacao.codcd == cd_codigo, "Location should be linked to CD"
        assert locacao.id_cliente == codcliente, (
            "Location should be linked to customer"
        )

        # Verify receipt contains the rental
        assert recibo.locacoes, "Receipt should have rentals"
        assert any(
            l.codcd == cd_codigo for l in recibo.locacoes
        ), "Receipt should contain the CD rental"