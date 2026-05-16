"""Reservations application service.

Implements use cases for reservations bounded context.
"""

from __future__ import annotations

from datetime import datetime, timedelta

from app.bounded_contexts.customers.domain.entities import Cliente
from app.bounded_contexts.reservations.domain.entities import Reserva, SituacaoReserva
from app.bounded_contexts.reservations.ports.repositories import (
    ReservationRepositoryPort,
)
from app.bounded_contexts.customers.ports.repositories import (
    CustomerRepositoryPort,
)
from app.bounded_contexts.catalog.ports.repositories import (
    TitleRepositoryPort,
)
from app.shared.domain import DomainEvent, reserva_criada, reserva_confirmada, reserva_cancelada


class ReservationService:
    """Application service for reservation operations.

    RESV-001: Reserva exige cliente ativo.
    RESV-004: Bloqueio de reserva duplicada.
    RESV-005: Ao converter reserva em locação, situação marcada como "Confirmada".
    RESV-006: Data prevista calculada baseada na disponibilidade.
    """

    def __init__(
        self,
        reservation_repo: ReservationRepositoryPort,
        customer_repo: CustomerRepositoryPort,
        title_repo: TitleRepositoryPort,
    ) -> None:
        self._reservation_repo = reservation_repo
        self._customer_repo = customer_repo
        self._title_repo = title_repo

    async def create_reservation(
        self,
        codcliente: int,
        codtitulo: int,
    ) -> tuple[Reserva, list[DomainEvent]]:
        """Create a new reservation.

        Args:
            codcliente: Customer ID
            codtitulo: Title ID

        Returns:
            (reserva, events)

        RESV-001: Cliente deve estar ativo.
        RESV-002: Reserva por título, não por CD físico específico.
        RESV-004: Bloqueio de reserva duplicada.
        RESV-006: Data prevista calculada baseada na disponibilidade.
        """
        # RESV-001: Validate customer is active
        cliente = await self._customer_repo.get_by_id(codcliente)
        if not cliente or cliente.cancelado:
            raise ValueError(
                f"Cliente {codcliente} não encontrado ou está cancelado"
            )

        # Validate title exists
        titulo = await self._title_repo.get_by_id(codtitulo)
        if not titulo:
            raise ValueError(f"Título {codtitulo} não encontrado")

        # RESV-004: Check for duplicate reservation
        existing = await self._reservation_repo.find_pending_by_customer_and_title(
            codcliente, codtitulo
        )
        if existing:
            raise ValueError(
                f"Cliente já possui reserva pendente para o título {codtitulo}"
            )

        # RESV-006: Calculate data_prevista based on availability
        data_prevista = await self._calculate_data_prevista(codtitulo)

        # Create reservation
        reserva, event = Reserva.create(
            codcliente=codcliente,
            codtitulo=codtitulo,
            data_reserva=datetime.now(),
            data_prevista=data_prevista,
        )

        saved_event = await self._reservation_repo.save(reserva)

        events = [event or saved_event]

        return reserva, events

    async def cancel_reservation(self, codreserva: int) -> tuple[Reserva, DomainEvent]:
        """Cancel a reservation.

        Args:
            codreserva: Reservation ID

        Returns:
            (reserva, event)
        """
        reserva = await self._reservation_repo.get_by_id(codreserva)
        if not reserva:
            raise ValueError(f"Reserva {codreserva} não encontrada")

        if not reserva.is_ativa:
            raise ValueError(
                f"Reserva não pode ser cancelada. Situação: {reserva.situacao}"
            )

        reserva.cancelar()
        await self._reservation_repo.update(reserva)

        event = reserva_cancelada(
            codreserva=codreserva,
            codcliente=reserva.codcliente,
            codtitulo=reserva.codtitulo,
            motivo="Cancelamento solicitado pelo cliente",
        )

        return reserva, event

    async def confirm_reservation(self, codreserva: int) -> tuple[Reserva, DomainEvent]:
        """Confirm a reservation (convert to rental).

        Args:
            codreserva: Reservation ID

        Returns:
            (reserva, event)

        RESV-005: Ao converter reserva em locação, situação marcada como "Confirmada".
        """
        reserva = await self._reservation_repo.get_by_id(codreserva)
        if not reserva:
            raise ValueError(f"Reserva {codreserva} não encontrada")

        if reserva.situacao != SituacaoReserva.PENDENTE:
            raise ValueError(
                f"Apenas reservas pendentes podem ser confirmadas. Situação: {reserva.situacao}"
            )

        reserva.confirmar()
        await self._reservation_repo.update(reserva)

        event = reserva_confirmada(
            codreserva=codreserva,
            codcliente=reserva.codcliente,
            codtitulo=reserva.codtitulo,
        )

        return reserva, event

    async def mark_as_rented(
        self, codreserva: int
    ) -> tuple[Reserva, DomainEvent | None]:
        """Mark reservation as converted to rental.

        Called by Rentals service when creating a rental from a reservation.

        Args:
            codreserva: Reservation ID

        Returns:
            (reserva, event)
        """
        reserva = await self._reservation_repo.get_by_id(codreserva)
        if not reserva:
            raise ValueError(f"Reserva {codreserva} não encontrada")

        reserva.marcar_como_locada()
        await self._reservation_repo.update(reserva)

        # No specific event for this action; the LocacaoCriada event covers it
        return reserva, None

    async def get_reservation(self, codreserva: int) -> Reserva | None:
        """Get reservation by ID."""
        return await self._reservation_repo.get_by_id(codreserva)

    async def list_reservations(
        self, skip: int = 0, limit: int = 100
    ) -> list[Reserva]:
        """List all reservations with pagination."""
        return [
            r async for r in self._reservation_repo.get_all(skip=skip, limit=limit)
        ]

    async def list_pending_by_customer(self, codcliente: int) -> list[Reserva]:
        """List pending reservations for a customer."""
        return [
            r
            async for r in self._reservation_repo.get_by_customer_id(codcliente)
            if r.is_pendente
        ]

    async def _calculate_data_prevista(self, codtitulo: int) -> datetime.date:
        """Calculate data_prevista based on title availability (RESV-006).

        Simple algorithm: next available day when at least one CD is available.
        In production, this could be more sophisticated based on reservation queue.
        """
        # Get title to check availability
        titulo = await self._title_repo.get_by_id(codtitulo)
        if not titulo:
            raise ValueError(f"Título {codtitulo} não encontrado")

        # Check if there are available CDs now
        from app.bounded_contexts.catalog.domain.entities import SituacaoCd

        available_cds = [cd for cd in titulo.cds if cd.situacao == SituacaoCd.DISPONIVEL]

        if available_cds:
            # Available now - can be picked up tomorrow
            return (datetime.now() + timedelta(days=1)).date()
        else:
            # All CDs are rented - estimate based on average rental period
            # This is a simplification; in production you'd query actual return dates
            return (datetime.now() + timedelta(days=7)).date()
