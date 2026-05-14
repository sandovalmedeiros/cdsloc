"""Reservation repository ports.

Defines interfaces for reservations data access following hexagonal architecture.
"""

from __future__ import annotations

from abc import ABC, abstractmethod
from typing import TYPE_CHECKING, AsyncIterable, Iterable

from app.bounded_contexts.reservations.domain.entities import Reserva
from app.shared.domain.events import DomainEvent

if TYPE_CHECKING:
    from app.bounded_contexts.catalog.ports.repositories import TitleRepositoryPort
    from app.bounded_contexts.customers.ports.repositories import CustomerRepositoryPort


class ReservationRepositoryPort(ABC):
    """Repository interface for Reserva aggregate."""

    @abstractmethod
    async def get_by_id(self, codreserva: int) -> Reserva | None:
        """Get reservation by ID."""
        pass

    @abstractmethod
    async def get_all(
        self, skip: int = 0, limit: int = 100
    ) -> AsyncIterable[Reserva]:
        """Get all reservations with pagination."""
        pass

    @abstractmethod
    async def get_by_customer_id(
        self, codcliente: int
    ) -> AsyncIterable[Reserva]:
        """Get all reservations for a customer."""
        pass

    @abstractmethod
    async def get_by_title_id(
        self, codtitulo: int
    ) -> AsyncIterable[Reserva]:
        """Get all reservations for a title."""
        pass

    @abstractmethod
    async def find_pending_by_customer_and_title(
        self, codcliente: int, codtitulo: int
    ) -> Reserva | None:
        """Find pending reservation for customer and title (RESV-004)."""
        pass

    @abstractmethod
    async def save(self, reserva: Reserva) -> DomainEvent:
        """Save reservation and emit ReservaCriada event if new."""
        pass

    @abstractmethod
    async def update(self, reserva: Reserva) -> DomainEvent | None:
        """Update reservation and emit event if needed."""
        pass

    @abstractmethod
    async def delete(self, codreserva: int) -> None:
        """Delete reservation by ID."""
        pass
