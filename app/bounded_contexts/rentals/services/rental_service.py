"""Rentals application service.

Implements use cases for rentals bounded context.
"""

from __future__ import annotations

from datetime import date, datetime
from typing import Iterable

from app.bounded_contexts.customers.domain.entities import Cliente
from app.bounded_contexts.catalog.domain.entities import CdFisico, SituacaoCd, Title
from app.bounded_contexts.rentals.domain.entities import Locacao, Recibo
from app.bounded_contexts.rentals.ports.repositories import (
    CdFisicoRepositoryPort,
    CustomerRepositoryPort,
    ReceiptRepositoryPort,
    RentalRepositoryPort,
)
from app.bounded_contexts.rentals.services.calculation_service import (
    CalculationService,
)
from app.shared.domain import DomainEvent


class RentalService:
    """Application service for rental operations.

    BR-MIGRAR-029: Transação atômica entre locação e atualização do CD.
    RENT-001: Locação exige cliente ativo.
    RENT-002: Locação permite retirada por dependente.
    RENT-003: Apenas CDs disponíveis podem ser locados.
    RENT-006: Ao locar, CD marca situacao = "Locado".
    RENT-013: Transação atômica.
    """

    def __init__(
        self,
        rental_repo: RentalRepositoryPort,
        receipt_repo: ReceiptRepositoryPort,
        cd_repo: CdFisicoRepositoryPort,
        customer_repo: CustomerRepositoryPort,
    ) -> None:
        self._rental_repo = rental_repo
        self._receipt_repo = receipt_repo
        self._cd_repo = cd_repo
        self._customer_repo = customer_repo

    async def create_rental(
        self,
        codcliente: int,
        cd_codigo: int,
        data_locacao: datetime | None = None,
        coddependente: int | None = None,
    ) -> tuple[Locacao, Recibo, list[DomainEvent]]:
        """Create a new rental with receipt (atomic operation).

        Args:
            codcliente: Customer ID
            cd_codigo: Physical CD code
            data_locacao: Rental datetime (defaults to now)
            coddependente: Dependent ID (optional, RENT-002)

        Returns:
            (locacao, recibo, events)

        BR-MIGRAR-029: Transação atômica.
        RENT-001: Cliente deve estar ativo.
        RENT-003: CD deve estar disponível.
        RENT-006: CD marca situacao = "Locado".
        """
        # RENT-001: Validate customer is active
        cliente = await self._customer_repo.get_by_id(codcliente)
        if not cliente or cliente.cancelado:
            raise ValueError(
                f"Cliente {codcliente} não encontrado ou está cancelado"
            )

        # RENT-002: Validate dependent if provided
        if coddependente:
            if not any(
                d.cod_dependente == coddependente
                for d in cliente.dependentes
            ):
                raise ValueError(f"Dependente {coddependente} não encontrado")

        # RENT-003: Get CD and validate availability
        cd = await self._cd_repo.get_by_codigo(cd_codigo)
        if not cd:
            raise ValueError(f"CD {cd_codigo} não encontrado")

        if cd.situacao != SituacaoCd.DISPONIVEL:
            raise ValueError(f"CD {cd_codigo} não está disponível")

        # Get title for rental type
        title = await self._rental_repo.get_title_by_cd(cd_codigo)
        if not title:
            raise ValueError("Título não encontrado")

        # Calculate expected return date
        data_locacao_vo = data_locacao or datetime.now()
        data_prevista = CalculationService.calculate_data_prevista(
            data_locacao_vo.date(),
            title.tipo_locacao,
        )

        # Create receipt
        recibo, recibo_event = Recibo.create(
            codcliente=codcliente,
            valor_total=title.valor,
        )
        saved_recibo_event = await self._receipt_repo.save(recibo)

        # Create rental
        locacao, locacao_event = Locacao.create(
            codcliente=codcliente,
            codcd=cd_codigo,
            data_locacao=data_locacao_vo,
            data_prevista=data_prevista,
            valor_locacao=title.valor,
            coddependente=coddependente,
            codrecibo=recibo.codrecibo,
        )

        # Add rental to receipt
        recibo.adicionar_locacao(locacao)
        await self._receipt_repo.update(recibo)

        # Save rental
        saved_locacao_event = await self._rental_repo.save(locacao)

        # RENT-006: Mark CD as rented (atomic - BR-MIGRAR-029)
        cd_status_event = await self._cd_repo.mark_cd_rented(cd_codigo)

        events: list[DomainEvent] = [
            recibo_event or saved_recibo_event,
            locacao_event or saved_locacao_event,
            cd_status_event,
        ]

        return locacao, recibo, events

    async def return_rental(
        self, codlocacao: int, data_devolucao: date | None
    ) -> tuple[Locacao, list[DomainEvent]]:
        """Return a rental (calculate penalty, mark CD available, close receipt).

        Args:
            codlocacao: Rental ID
            data_devolucao: Return date (defaults to today)

        Returns:
            (locacao, events)

        RENT-008: Devolução exige recibo pendente.
        BR-MIGRAR-032: Cálculo de dias de atraso.
        BR-MIGRAR-033: Cálculo de multa.
        RENT-011: Ao devolver, CD marca situacao = "Disponível".
        RENT-012: Recibo marcado como devolvido.
        BR-MIGRAR-029: Transação atômica.
        """
        locacao = await self._rental_repo.get_by_id(codlocacao)
        if not locacao:
            raise ValueError(f"Locação {codlocacao} não encontrada")

        # RENT-008: Validate receipt is not already returned
        recibo = locacao.recibo
        if not recibo:
            raise ValueError("Recibo não encontrado para esta locação")

        if recibo.devolvido:
            raise ValueError("Recibo já foi baixado")

        # Calculate return date
        data_devolucao_vo = data_devolucao or date.today()

        # Calculate penalty (BR-MIGRAR-032, BR-MIGRAR-033)
        multa_vo, multa_event, devolucao_event = (
            locacao.calcular_devolucao(data_devolucao_vo)
        )

        # Update rental
        await self._rental_repo.update(locacao)

        # RENT-011: Mark CD as available (atomic - BR-MIGRAR-029)
        cd_status_event = await self._cd_repo.mark_cd_available(
            locacao.codcd
        )

        # RENT-012: Close receipt
        recibo.baixar()
        await self._receipt_repo.update(recibo)

        events = [multa_event, devolucao_event, cd_status_event]

        return locacao, events

    async def get_rental(self, codlocacao: int) -> Locacao | None:
        """Get rental by ID."""
        return await self._rental_repo.get_by_id(codlocacao)

    async def list_rentals(
        self, skip: int = 0, limit: int = 100
    ) -> Iterable[Locacao]:
        """List all rentals with pagination."""
        return await self._rental_repo.get_all(skip=skip, limit=limit)

    async def get_pending_rentals(self) -> Iterable[Locacao]:
        """Get rentals that are pending return."""
        return await self._rental_repo.get_pending()

    async def get_receipt(self, codrecibo: int) -> Recibo | None:
        """Get receipt by ID."""
        return await self._receipt_repo.get_by_id(codrecibo)
