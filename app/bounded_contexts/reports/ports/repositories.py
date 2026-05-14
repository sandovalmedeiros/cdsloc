"""Report repository ports.

Defines interfaces for reports data access following hexagonal architecture.
"""

from __future__ import annotations

from abc import ABC, abstractmethod
from typing import Any, AsyncIterable

from app.bounded_contexts.reports.domain.entities import ReportSpecification
from app.shared.domain.events import DomainEvent


class ReportRepositoryPort(ABC):
    """Repository interface for ReportSpecification aggregate."""

    @abstractmethod
    async def get_by_id(self, report_id: int) -> ReportSpecification | None:
        """Get report specification by ID."""
        pass

    @abstractmethod
    async def get_by_tipo(self, tipo: str) -> ReportSpecification | None:
        """Get report specification by type."""
        pass

    @abstractmethod
    async def get_all(
        self, skip: int = 0, limit: int = 100
    ) -> AsyncIterable[ReportSpecification]:
        """Get all report specifications with pagination."""
        pass

    @abstractmethod
    async def save(self, spec: ReportSpecification) -> DomainEvent:
        """Save report specification and emit ReportRequested event if new."""
        pass

    @abstractmethod
    async def update(self, spec: ReportSpecification) -> DomainEvent | None:
        """Update report specification."""
        pass

    @abstractmethod
    async def delete(self, report_id: int) -> None:
        """Delete report specification by ID."""
        pass


class ReportGeneratorPort(ABC):
    """Port for generating report output (HTML/PDF)."""

    @abstractmethod
    async def generate_html(
        self, spec: ReportSpecification, data: list[dict[str, Any]]
    ) -> str:
        """Generate HTML report from specification and data.

        Args:
            spec: Report specification
            data: Report data rows

        Returns:
            HTML string
        """
        pass

    @abstractmethod
    async def generate_pdf(
        self, spec: ReportSpecification, data: list[dict[str, Any]]
    ) -> bytes:
        """Generate PDF report from specification and data.

        Args:
            spec: Report specification
            data: Report data rows

        Returns:
            PDF bytes
        """
        pass
