"""Rentals repository ports.

Defines interfaces for rentals data access following hexagonal architecture.
"""

from __future__ import annotations

from abc import ABC, abstractmethod
from typing import TYPE_CHECKING, Iterable

if TYPE_CHECKING:
    from app.bounded_contexts.catalog.domain.entities import Title

from app.bounded_contexts.rentals.domain.entities import Locacao, Recibo
from app.shared.domain.events import DomainEvent


class RentalRepositoryPort(ABC):
    """Repository interface for Locacao entity."""

    @abstractmethod
    async def get_by_id(self, codlocacao: int) -> Locacao | None:
        """Get rental by ID."""
        pass

    @abstractmethod
    async def get_all(
        self, skip: int = 0, limit: int = 100
    ) -> Iterable[Locacao]:
        """Get all rentals with pagination."""
        pass

    @abstractmethod
    async def get_pending(self) -> Iterable[Locacao]:
        """Get rentals that are pending return."""
        pass

    @abstractmethod
    async def get_by_customer_id(
        self, codcliente: int
    ) -> Iterable[Locacao]:
        """Get all rentals for a customer."""
        pass

    @abstractmethod
    async def save(self, locacao: Locacao) -> DomainEvent:
        """Save rental and emit LocacaoCriada event if new."""
        pass

    @abstractmethod
    async def update(self, locacao: Locacao) -> DomainEvent | None:
        """Update rental and emit event if needed."""
        pass

    @abstractmethod
    async def get_title_by_cd(self, cd_codigo: int) -> "Title | None":
        """Get title by CD code (for rental calculation)."""
        pass

    @abstractmethod
    async def delete(self, codlocacao: int) -> None:
        """Delete rental by ID."""
        pass


class ReceiptRepositoryPort(ABC):
    """Repository interface for Recibo entity."""

    @abstractmethod
    async def get_by_id(self, codrecibo: int) -> Recibo | None:
        """Get receipt by ID."""
        pass

    @abstractmethod
    async def get_all(
        self, skip: int = 0, limit: int = 100
    ) -> Iterable[Recibo]:
        """Get all receipts with pagination."""
        pass

    @abstractmethod
    async def get_by_customer_id(
        self, codcliente: int
    ) -> Iterable[Recibo]:
        """Get all receipts for a customer."""
        pass

    @abstractmethod
    async def save(self, recibo: Recibo) -> DomainEvent:
        """Save receipt and emit ReciboGerado event if new."""
        pass

    @abstractmethod
    async def update(self, recibo: Recibo) -> DomainEvent | None:
        """Update receipt."""
        pass

    @abstractmethod
    async def delete(self, codrecibo: int) -> None:
        """Delete receipt by ID."""
        pass
