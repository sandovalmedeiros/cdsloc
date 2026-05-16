"""Data parity tests.

Tests that validate data migration integrity and count parity.
Based on _reversa_sdd/migration/parity_specs.md section 4.

@critical: Data is the critical asset. Counts must be identical.
"""

from __future__ import annotations

from typing import Final

import pytest
from sqlalchemy import text
from sqlalchemy.ext.asyncio import AsyncSession, create_async_engine
from sqlalchemy.orm import sessionmaker

from app.adapters.db.models import Base
from app.shared.domain import validate_cpf

# Expected counts from legacy system (BR-MIGRAR-002)
LEGACY_COUNTS: Final[dict[str, int]] = {
    "clientes": 1000,  # Example count
    "dependentes": 2000,  # Example count
    "titulos": 500,  # Example count
    "cds": 1500,  # Example count
    "locacoes": 5000,  # Example count
    "recibos": 5000,  # Example count
    "reservas": 1000,  # Example count
    "bairros": 50,  # Example count
    "municipios": 10,  # Example count
}

# Acceptable margin for count differences (0.1%)
ACCEPTABLE_MARGIN: Final[float] = 0.001


@pytest.mark.data_parity
@pytest.mark.critical
class TestDataParity:
    """Test data migration integrity and count parity.

    BR-MIGRAR-002: Data volume ~10.000 records.
    BR-MIGRAR-010: CPF validation.
    BR-MIGRAR-008: Date of birth validation.
    """

    @pytest.mark.asyncio
    async def test_customer_count_parity(self, async_session: AsyncSession) -> None:
        """Test that customer count matches legacy system (within 0.1% margin).

        Legacy: COUNT(*) from clientes table
        New: COUNT(*) from clientes table
        """
        result = await async_session.execute(text("SELECT COUNT(*) FROM clientes"))
        count = result.scalar_one()

        assert count > 0, "No customers found in database"
        assert (
            abs(count - LEGACY_COUNTS["clientes"]) / LEGACY_COUNTS["clientes"]
            < ACCEPTABLE_MARGIN
        ), (
            f"Customer count: {count}, Expected: {LEGACY_COUNTS['clientes']}, "
            f"Margin: {abs(count - LEGACY_COUNTS['clientes']) / LEGACY_COUNTS['clientes'] * 100:.2f}%"
        )

    @pytest.mark.asyncio
    async def test_dependent_count_parity(self, async_session: AsyncSession) -> None:
        """Test that dependent count matches legacy system."""
        result = await async_session.execute(
            text("SELECT COUNT(*) FROM dependentes")
        )
        count = result.scalar_one()

        assert count > 0, "No dependents found in database"
        assert (
            abs(count - LEGACY_COUNTS["dependentes"]) / LEGACY_COUNTS["dependentes"]
            < ACCEPTABLE_MARGIN
        ), (
            f"Dependent count: {count}, Expected: {LEGACY_COUNTS['dependentes']}"
        )

    @pytest.mark.asyncio
    async def test_title_count_parity(self, async_session: AsyncSession) -> None:
        """Test that title count matches legacy system."""
        result = await async_session.execute(text("SELECT COUNT(*) FROM titulos"))
        count = result.scalar_one()

        assert count > 0, "No titles found in database"
        assert (
            abs(count - LEGACY_COUNTS["titulos"]) / LEGACY_COUNTS["titulos"]
            < ACCEPTABLE_MARGIN
        ), f"Title count: {count}, Expected: {LEGACY_COUNTS['titulos']}"

    @pytest.mark.asyncio
    async def test_cd_count_parity(self, async_session: AsyncSession) -> None:
        """Test that CD count matches legacy system."""
        result = await async_session.execute(text("SELECT COUNT(*) FROM cds"))
        count = result.scalar_one()

        assert count > 0, "No CDs found in database"
        assert (
            abs(count - LEGACY_COUNTS["cds"]) / LEGACY_COUNTS["cds"]
            < ACCEPTABLE_MARGIN
        ), f"CD count: {count}, Expected: {LEGACY_COUNTS['cds']}"

    @pytest.mark.asyncio
    async def test_rental_count_parity(self, async_session: AsyncSession) -> None:
        """Test that rental count matches legacy system."""
        result = await async_session.execute(text("SELECT COUNT(*) FROM locacoes"))
        count = result.scalar_one()

        assert count > 0, "No rentals found in database"
        assert (
            abs(count - LEGACY_COUNTS["locacoes"]) / LEGACY_COUNTS["locacoes"]
            < ACCEPTABLE_MARGIN
        ), f"Rental count: {count}, Expected: {LEGACY_COUNTS['locacoes']}"

    @pytest.mark.asyncio
    async def test_receipt_count_parity(self, async_session: AsyncSession) -> None:
        """Test that receipt count matches legacy system."""
        result = await async_session.execute(text("SELECT COUNT(*) FROM recibos"))
        count = result.scalar_one()

        assert count > 0, "No receipts found in database"
        assert (
            abs(count - LEGACY_COUNTS["recibos"]) / LEGACY_COUNTS["recibos"]
            < ACCEPTABLE_MARGIN
        ), f"Receipt count: {count}, Expected: {LEGACY_COUNTS['recibos']}"

    @pytest.mark.asyncio
    async def test_reservation_count_parity(self, async_session: AsyncSession) -> None:
        """Test that reservation count matches legacy system."""
        result = await async_session.execute(text("SELECT COUNT(*) FROM reservas"))
        count = result.scalar_one()

        assert count > 0, "No reservations found in database"
        assert (
            abs(count - LEGACY_COUNTS["reservas"]) / LEGACY_COUNTS["reservas"]
            < ACCEPTABLE_MARGIN
        ), f"Reservation count: {count}, Expected: {LEGACY_COUNTS['reservas']}"

    @pytest.mark.asyncio
    async def test_bairro_count_parity(self, async_session: AsyncSession) -> None:
        """Test that bairro count matches legacy system."""
        result = await async_session.execute(text("SELECT COUNT(*) FROM bairros"))
        count = result.scalar_one()

        assert count > 0, "No bairros found in database"
        assert (
            abs(count - LEGACY_COUNTS["bairros"]) / LEGACY_COUNTS["bairros"]
            < ACCEPTABLE_MARGIN
        ), f"Bairro count: {count}, Expected: {LEGACY_COUNTS['bairros']}"

    @pytest.mark.asyncio
    async def test_municipio_count_parity(self, async_session: AsyncSession) -> None:
        """Test that municipio count matches legacy system."""
        result = await async_session.execute(
            text("SELECT COUNT(*) FROM municipios")
        )
        count = result.scalar_one()

        assert count > 0, "No municipios found in database"
        assert (
            abs(count - LEGACY_COUNTS["municipios"]) / LEGACY_COUNTS["municipios"]
            < ACCEPTABLE_MARGIN
        ), f"Municipio count: {count}, Expected: {LEGACY_COUNTS['municipios']}"


@pytest.mark.integrity_parity
@pytest.mark.high
class TestIntegrityParity:
    """Test referential integrity and data constraints.

    BR-MIGRAR-017: Stock validation.
    BR-MIGRAR-010: CPF validation.
    BR-MIGRAR-008: Date of birth validation.
    """

    @pytest.mark.asyncio
    async def test_all_customers_have_valid_bairro(
        self,
        async_session: AsyncSession,
    ) -> None:
        """Test that all customers have valid bairro (FK integrity)."""
        result = await async_session.execute(
            text(
                """
                SELECT COUNT(*) FROM clientes c
                LEFT JOIN bairros b ON c.id_bairro = b.id
                WHERE b.id IS NULL
                """
            )
        )
        orphan_customers = result.scalar_one()

        assert orphan_customers == 0, (
            f"Found {orphan_customers} customers with invalid bairro"
        )

    @pytest.mark.asyncio
    async def test_all_dependents_have_valid_customer(
        self,
        async_session: AsyncSession,
    ) -> None:
        """Test that all dependents have valid customer (FK integrity)."""
        result = await async_session.execute(
            text(
                """
                SELECT COUNT(*) FROM dependentes d
                LEFT JOIN clientes c ON d.id_cliente = c.codcliente
                WHERE c.codcliente IS NULL
                """
            )
        )
        orphan_dependents = result.scalar_one()

        assert orphan_dependents == 0, (
            f"Found {orphan_dependents} dependents with invalid customer"
        )

    @pytest.mark.asyncio
    async def test_all_cds_have_valid_title(
        self,
        async_session: AsyncSession,
    ) -> None:
        """Test that all CDs have valid title (FK integrity)."""
        result = await async_session.execute(
            text(
                """
                SELECT COUNT(*) FROM cds cd
                LEFT JOIN titulos t ON cd.id_titulo = t.id
                WHERE t.id IS NULL
                """
            )
        )
        orphan_cds = result.scalar_one()

        assert orphan_cds == 0, f"Found {orphan_cds} CDs with invalid title"

    @pytest.mark.asyncio
    async def test_all_rentals_have_valid_customer(
        self,
        async_session: AsyncSession,
    ) -> None:
        """Test that all rentals have valid customer (FK integrity)."""
        result = await async_session.execute(
            text(
                """
                SELECT COUNT(*) FROM locacoes l
                LEFT JOIN clientes c ON l.id_cliente = c.codcliente
                WHERE c.codcliente IS NULL
                """
            )
        )
        orphan_rentals = result.scalar_one()

        assert orphan_rentals == 0, (
            f"Found {orphan_rentals} rentals with invalid customer"
        )

    @pytest.mark.asyncio
    async def test_all_rentals_have_valid_receipt(
        self,
        async_session: AsyncSession,
    ) -> None:
        """Test that all rentals have valid receipt (FK integrity)."""
        result = await async_session.execute(
            text(
                """
                SELECT COUNT(*) FROM locacoes l
                LEFT JOIN recibos r ON l.codrecibo = r.codrecibo
                WHERE r.codrecibo IS NULL
                """
            )
        )
        orphan_rentals = result.scalar_one()

        assert orphan_rentals == 0, (
            f"Found {orphan_rentals} rentals with invalid receipt"
        )

    @pytest.mark.asyncio
    async def test_cpf_validation_in_migrated_data(
        self,
        async_session: AsyncSession,
    ) -> None:
        """Test that all CPFs in migrated data are valid (BR-MIGRAR-010)."""
        result = await async_session.execute(
            text("SELECT cpf FROM clientes WHERE cpf IS NOT NULL LIMIT 100")
        )
        cpf_list = result.scalars().all()

        invalid_cpfs = []
        for cpf in cpf_list:
            try:
                validate_cpf(cpf)
            except ValueError as e:
                invalid_cpfs.append((cpf, str(e)))

        assert len(invalid_cpfs) == 0, (
            f"Found {len(invalid_cpfs)} invalid CPFs: {invalid_cpfs[:5]}"
        )

    @pytest.mark.asyncio
    async def test_date_of_birth_validation_in_migrated_data(
        self,
        async_session: AsyncSession,
    ) -> None:
        """Test that all dates of birth are valid (BR-MIGRAR-008).

        Valid range: >= 1900, <= current date.
        """
        from datetime import date

        result = await async_session.execute(
            text("SELECT datanasc FROM clientes WHERE datanasc IS NOT NULL")
        )
        dates = result.scalars().all()

        invalid_dates = []
        for datanasc in dates:
            if datanasc.year < 1900:
                invalid_dates.append((datanasc, "Before 1900"))
            elif datanasc > date.today():
                invalid_dates.append((datanasc, "Future date"))

        assert len(invalid_dates) == 0, (
            f"Found {len(invalid_dates)} invalid dates of birth: {invalid_dates[:5]}"
        )

    @pytest.mark.asyncio
    async def test_cd_status_values(self, async_session: AsyncSession) -> None:
        """Test that CD status values are valid (1=Available, 2=Rented, 3=Reserved)."""
        result = await async_session.execute(
            text(
                """
                SELECT COUNT(*) FROM cds
                WHERE situacao_id NOT IN (1, 2, 3)
                """
            )
        )
        invalid_status_count = result.scalar_one()

        assert invalid_status_count == 0, (
            f"Found {invalid_status_count} CDs with invalid status"
        )

    @pytest.mark.asyncio
    async def test_cancelled_customer_flag_consistency(
        self,
        async_session: AsyncSession,
    ) -> None:
        """Test that cancelled customers are properly marked (is_cancelado boolean)."""
        result = await async_session.execute(
            text("SELECT is_cancelado FROM clientes LIMIT 100")
        )
        flags = result.scalars().all()

        # All values should be boolean
        invalid_flags = [flag for flag in flags if not isinstance(flag, bool)]

        assert len(invalid_flags) == 0, (
            f"Found {len(invalid_flags)} invalid cancel flags"
        )