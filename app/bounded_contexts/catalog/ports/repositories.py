"""Catalog repository ports.

Defines interfaces for catalog data access following hexagonal architecture.
Repositories are implemented in adapters layer.
"""

from __future__ import annotations

from abc import ABC, abstractmethod
from typing import Iterable

from app.bounded_contexts.catalog.domain.entities import (
    CdFisico,
    Interprete,
    Musica,
    SituacaoCd,
    Title,
    TipoLocacao,
)
from app.shared.domain.events import DomainEvent


class TitleRepositoryPort(ABC):
    """Repository interface for Title aggregate."""

    @abstractmethod
    async def get_by_id(self, title_id: int) -> Title | None:
        """Get title by ID with all nested entities."""
        pass

    @abstractmethod
    async def get_all(
        self, skip: int = 0, limit: int = 100
    ) -> Iterable[Title]:
        """Get all titles with pagination."""
        pass

    @abstractmethod
    async def search_by_name(self, name: str) -> Iterable[Title]:
        """Search titles by name (case-insensitive)."""
        pass

    @abstractmethod
    async def save(self, title: Title) -> DomainEvent:
        """Save title and emit TitleCreated event if new."""
        pass

    @abstractmethod
    async def update(self, title: Title) -> list[DomainEvent]:
        """Update title and emit events."""
        pass

    @abstractmethod
    async def delete(self, title_id: int) -> None:
        """Delete title by ID."""
        pass

    @abstractmethod
    async def get_available_cds(
        self, title_id: int
    ) -> Iterable[CdFisico]:
        """Get available CDs for a title."""
        pass


class CdFisicoRepositoryPort(ABC):
    """Repository interface for CdFisico entity."""

    @abstractmethod
    async def get_by_codigo(self, codigo: int) -> CdFisico | None:
        """Get CD by its codigo."""
        pass

    @abstractmethod
    async def get_by_numcd(self, numcd: str) -> CdFisico | None:
        """Get CD by its numcd."""
        pass

    @abstractmethod
    async def get_by_title_id(
        self, title_id: int
    ) -> Iterable[CdFisico]:
        """Get all CDs for a title."""
        pass

    @abstractmethod
    async def get_all(
        self, skip: int = 0, limit: int = 100
    ) -> Iterable[CdFisico]:
        """Get all CDs with pagination."""
        pass

    @abstractmethod
    async def save(self, cd: CdFisico) -> DomainEvent:
        """Save CD and emit CdRegistered event if new."""
        pass

    @abstractmethod
    async def update(self, cd: CdFisico) -> DomainEvent:
        """Update CD and emit CdStatusChanged event."""
        pass

    @abstractmethod
    async def delete(self, cd_codigo: int) -> None:
        """Delete CD by codigo."""
        pass

    @abstractmethod
    async def count_by_title(self, title_id: int) -> int:
        """Count CDs for a title (BR-MIGRAR-017)."""
        pass

    @abstractmethod
    async def mark_cd_rented(self, codigo: int | str) -> DomainEvent:
        """Mark CD as rented (RENT-006)."""
        pass

    @abstractmethod
    async def mark_cd_available(self, codigo: int | str) -> DomainEvent:
        """Mark CD as available (RENT-011)."""
        pass


class MusicaRepositoryPort(ABC):
    """Repository interface for Musica entity."""

    @abstractmethod
    async def get_by_id(self, musica_id: int) -> Musica | None:
        """Get music by ID."""
        pass

    @abstractmethod
    async def get_by_title_id(
        self, title_id: int
    ) -> Iterable[Musica]:
        """Get all music tracks for a title."""
        pass

    @abstractmethod
    async def save(self, musica: Musica) -> None:
        """Save music track."""
        pass

    @abstractmethod
    async def update(self, musica: Musica) -> None:
        """Update music track."""
        pass

    @abstractmethod
    async def delete(self, musica_id: int) -> None:
        """Delete music track by ID."""
        pass

    @abstractmethod
    async def add_to_title(
        self, title_id: int, musica_id: int
    ) -> None:
        """Associate music with title (many-to-many)."""
        pass

    @abstractmethod
    async def remove_from_title(
        self, title_id: int, musica_id: int
    ) -> None:
        """Remove association between music and title."""
        pass


class InterpreteRepositoryPort(ABC):
    """Repository interface for Interprete entity."""

    @abstractmethod
    async def get_by_id(self, interprete_id: int) -> Interprete | None:
        """Get interpreter by ID."""
        pass

    @abstractmethod
    async def get_all(self, skip: int = 0, limit: int = 100) -> Iterable[Interprete]:
        """Get all interpreters with pagination."""
        pass

    @abstractmethod
    async def search_by_name(self, name: str) -> Iterable[Interprete]:
        """Search interpreters by name (case-insensitive)."""
        pass

    @abstractmethod
    async def save(self, interprete: Interprete) -> None:
        """Save interpreter."""
        pass

    @abstractmethod
    async def update(self, interprete: Interprete) -> None:
        """Update interpreter."""
        pass

    @abstractmethod
    async def delete(self, interprete_id: int) -> None:
        """Delete interpreter by ID."""
        pass

    @abstractmethod
    async def add_to_title(
        self, title_id: int, interprete_id: int
    ) -> None:
        """Associate interpreter with title (many-to-many)."""
        pass

    @abstractmethod
    async def remove_from_title(
        self, title_id: int, interprete_id: int
    ) -> None:
        """Remove association between interpreter and title."""
        pass
