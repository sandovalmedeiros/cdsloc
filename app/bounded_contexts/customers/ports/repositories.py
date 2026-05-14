"""Customers repository ports.

Defines interfaces for customers data access following hexagonal architecture.
"""

from __future__ import annotations

from abc import ABC, abstractmethod
from typing import Iterable

from app.bounded_contexts.customers.domain.entities import Cliente, Dependente
from app.shared.domain.events import DomainEvent


class CustomerRepositoryPort(ABC):
    """Repository interface for Cliente aggregate."""

    @abstractmethod
    async def get_by_id(self, codcliente: int) -> Cliente | None:
        """Get customer by ID with all dependents."""
        pass

    @abstractmethod
    async def get_all(
        self, skip: int = 0, limit: int = 100
    ) -> Iterable[Cliente]:
        """Get all customers with pagination."""
        pass

    @abstractmethod
    async def search_by_name(self, name: str) -> Iterable[Cliente]:
        """Search customers by name (case-insensitive, CUST-003)."""
        pass

    @abstractmethod
    async def search_by_cpf(self, cpf: str) -> Iterable[Cliente]:
        """Search customers by CPF."""
        pass

    @abstractmethod
    async def save(self, cliente: Cliente) -> DomainEvent:
        """Save customer and emit ClienteCreated event if new."""
        pass

    @abstractmethod
    async def update(self, cliente: Cliente) -> DomainEvent | None:
        """Update customer and emit event if needed."""
        pass

    @abstractmethod
    async def delete(self, codcliente: int) -> None:
        """Delete customer by ID."""
        pass


class DependentRepositoryPort(ABC):
    """Repository interface for Dependente entity."""

    @abstractmethod
    async def get_by_id(self, cod_dependente: int) -> Dependente | None:
        """Get dependent by ID."""
        pass

    @abstractmethod
    async def get_by_customer_id(
        self, cod_cliente: int
    ) -> Iterable[Dependente]:
        """Get all dependents for a customer."""
        pass

    @abstractmethod
    async def save(self, dependente: Dependente) -> None:
        """Save dependent."""
        pass

    @abstractmethod
    async def update(self, dependente: Dependente) -> None:
        """Update dependent."""
        pass

    @abstractmethod
    async def delete(self, cod_dependente: int) -> None:
        """Delete dependent by ID."""
        pass
