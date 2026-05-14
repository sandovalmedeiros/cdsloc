"""Reservation repository implementations (adapters) for PostgreSQL.

Implements ReservationRepositoryPort using SQLAlchemy async.
"""

from __future__ import annotations

from datetime import datetime
from typing import AsyncIterable

from sqlalchemy import select, and_
from sqlalchemy.ext.asyncio import AsyncSession

from app.adapters.db.models import Reserva
from app.bounded_contexts.reservations.domain.entities import Reserva as ReservaDomain, SituacaoReserva
from app.bounded_contexts.reservations.ports.repositories import ReservationRepositoryPort
from app.shared.domain import DomainEvent, reserva_criada, reserva_confirmada, reserva_cancelada


class PostgresReservationRepository(ReservationRepositoryPort):
    """PostgreSQL implementation of ReservationRepositoryPort."""

    def __init__(self, session: AsyncSession) -> None:
        self._session = session

    async def get_by_id(self, codreserva: int) -> ReservaDomain | None:
        """Get reservation by ID."""
        stmt = select(Reserva).where(Reserva.id == codreserva)
        result = await self._session.execute(stmt)
        reserva_model = result.scalar_one_or_none()

        if not reserva_model:
            return None

        return self._model_to_domain(reserva_model)

    async def get_all(
        self, skip: int = 0, limit: int = 100
    ) -> AsyncIterable[ReservaDomain]:
        """Get all reservations with pagination."""
        stmt = select(Reserva).offset(skip).limit(limit).order_by(Reserva.id)
        result = await self._session.execute(stmt)
        reservas = result.scalars().all()

        for reserva in reservas:
            yield self._model_to_domain(reserva)

    async def get_by_customer_id(
        self, codcliente: int
    ) -> AsyncIterable[ReservaDomain]:
        """Get all reservations for a customer."""
        stmt = (
            select(Reserva)
            .where(Reserva.id_cliente == codcliente)
            .order_by(Reserva.data_reserva.desc())
        )
        result = await self._session.execute(stmt)
        reservas = result.scalars().all()

        for reserva in reservas:
            yield self._model_to_domain(reserva)

    async def get_by_title_id(
        self, codtitulo: int
    ) -> AsyncIterable[ReservaDomain]:
        """Get all reservations for a title."""
        stmt = (
            select(Reserva)
            .where(Reserva.id_titulo == codtitulo)
            .order_by(Reserva.data_reserva.desc())
        )
        result = await self._session.execute(stmt)
        reservas = result.scalars().all()

        for reserva in reservas:
            yield self._model_to_domain(reserva)

    async def find_pending_by_customer_and_title(
        self, codcliente: int, codtitulo: int
    ) -> ReservaDomain | None:
        """Find pending reservation for customer and title (RESV-004)."""
        stmt = (
            select(Reserva)
            .where(
                and_(
                    Reserva.id_cliente == codcliente,
                    Reserva.id_titulo == codtitulo,
                    Reserva.situacao_id == 1,  # Pendente
                )
            )
            .order_by(Reserva.data_reserva.desc())
            .limit(1)
        )
        result = await self._session.execute(stmt)
        reserva_model = result.scalar_one_or_none()

        if not reserva_model:
            return None

        return self._model_to_domain(reserva_model)

    async def save(self, reserva: ReservaDomain) -> DomainEvent:
        """Save reservation and emit ReservaCriada event if new."""
        # Check if it's a new reservation (id == 0)
        is_new = reserva.codreserva == 0

        reserva_model = self._domain_to_model(reserva)

        self._session.add(reserva_model)

        # If new, we need to flush to get the ID
        if is_new:
            await self._session.flush()
            object.__setattr__(reserva, "codreserva", reserva_model.id)

            # Emit event for new reservation
            event = reserva_criada(
                codreserva=reserva_model.id,
                codcliente=reserva.codcliente,
                codtitulo=reserva.codtitulo,
                data_reserva=reserva.data_reserva,
            )
            return event

        return None

    async def update(self, reserva: ReservaDomain) -> DomainEvent | None:
        """Update reservation and emit event if needed."""
        stmt = select(Reserva).where(Reserva.id == reserva.codreserva)
        result = await self._session.execute(stmt)
        reserva_model = result.scalar_one_or_none()

        if not reserva_model:
            return None

        # Track old situacao for event
        old_situacao_id = reserva_model.situacao_id

        # Map situacao string to id
        situacao_map = {
            "Pendente": 1,
            "Confirmada": 2,
            "Locada": 3,
            "Cancelada": 4,
        }

        # Update fields
        reserva_model.situacao_id = situacao_map.get(
            reserva.situacao.value if isinstance(reserva.situacao, SituacaoReserva) else reserva.situacao,
            1,
        )
        reserva_model.updated_at = datetime.utcnow()

        # Emit event based on situacao change
        event = None
        if old_situacao_id == 1 and reserva_model.situacao_id == 2:
            # Pendente -> Confirmada
            event = reserva_confirmada(
                codreserva=reserva_model.id,
                codcliente=reserva.codcliente,
                codtitulo=reserva.codtitulo,
            )
        elif old_situacao_id in (1, 2) and reserva_model.situacao_id == 4:
            # Pendente/Confirmada -> Cancelada
            event = reserva_cancelada(
                codreserva=reserva_model.id,
                codcliente=reserva.codcliente,
                codtitulo=reserva.codtitulo,
                motivo="Cancelamento solicitado",
            )

        return event

    async def delete(self, codreserva: int) -> None:
        """Delete reservation by ID."""
        stmt = select(Reserva).where(Reserva.id == codreserva)
        result = await self._session.execute(stmt)
        reserva = result.scalar_one_or_none()

        if reserva:
            await self._session.delete(reserva)

    def _model_to_domain(self, reserva: Reserva) -> ReservaDomain:
        """Convert ORM model to domain entity."""
        situacao_map = {
            "Pendente": SituacaoReserva.PENDENTE,
            "Confirmada": SituacaoReserva.CONFIRMADA,
            "Locada": SituacaoReserva.LOCADA,
            "Cancelada": SituacaoReserva.CANCELADA,
        }

        return ReservaDomain(
            codreserva=reserva.id,
            codcliente=reserva.id_cliente,
            codtitulo=reserva.id_titulo,
            data_reserva=reserva.data_reserva,
            data_prevista=reserva.data_prevista,
            situacao=situacao_map.get(reserva.situacao, SituacaoReserva.PENDENTE),
        )

    def _domain_to_model(self, reserva: ReservaDomain) -> Reserva:
        """Convert domain entity to ORM model."""
        situacao_map = {
            SituacaoReserva.PENDENTE: 1,
            SituacaoReserva.CONFIRMADA: 2,
            SituacaoReserva.LOCADA: 3,
            SituacaoReserva.CANCELADA: 4,
        }

        return Reserva(
            id=reserva.codreserva if reserva.codreserva != 0 else None,
            id_cliente=reserva.codcliente,
            id_titulo=reserva.codtitulo,
            data_reserva=reserva.data_reserva,
            data_prevista=reserva.data_prevista,
            situacao_id=situacao_map.get(reserva.situacao, 1),
        )
