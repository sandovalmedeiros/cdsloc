"""Report repository implementations (adapters) for PostgreSQL.

Implements ReportRepositoryPort using SQLAlchemy async.
"""

from __future__ import annotations

from typing import AsyncIterable, Any

from sqlalchemy import select
from sqlalchemy.ext.asyncio import AsyncSession

from app.adapters.db.models import RelatorioSpec
from app.bounded_contexts.reports.domain.entities import ReportSpecification, ReportTipo
from app.bounded_contexts.reports.ports.repositories import ReportRepositoryPort
from app.shared.domain import DomainEvent, report_requested


class PostgresReportRepository(ReportRepositoryPort):
    """PostgreSQL implementation of ReportRepositoryPort."""

    def __init__(self, session: AsyncSession) -> None:
        self._session = session

    async def get_by_id(self, report_id: int) -> ReportSpecification | None:
        """Get report specification by ID."""
        stmt = select(RelatorioSpec).where(RelatorioSpec.id == report_id)
        result = await self._session.execute(stmt)
        spec_model = result.scalar_one_or_none()

        if not spec_model:
            return None

        return self._model_to_domain(spec_model)

    async def get_by_tipo(self, tipo: str) -> ReportSpecification | None:
        """Get report specification by type."""
        stmt = select(RelatorioSpec).where(RelatorioSpec.tipo == tipo)
        result = await self._session.execute(stmt)
        spec_model = result.scalar_one_or_none()

        if not spec_model:
            return None

        return self._model_to_domain(spec_model)

    async def get_all(
        self, skip: int = 0, limit: int = 100
    ) -> AsyncIterable[ReportSpecification]:
        """Get all report specifications with pagination."""
        stmt = select(RelatorioSpec).offset(skip).limit(limit).order_by(RelatorioSpec.id)
        result = await self._session.execute(stmt)
        specs = result.scalars().all()

        for spec in specs:
            yield self._model_to_domain(spec)

    async def save(self, spec: ReportSpecification) -> DomainEvent:
        """Save report specification and emit ReportRequested event if new."""
        # Check if it's a new spec (id == 0)
        is_new = spec.id == 0

        spec_model = self._domain_to_model(spec)

        self._session.add(spec_model)

        # If new, we need to flush to get the ID
        if is_new:
            await self._session.flush()
            object.__setattr__(spec, "id", spec_model.id)

            # Emit event for new spec
            event = report_requested(
                report_id=spec_model.id,
                report_tipo=spec_model.tipo,
                filtros={},
            )
            return event

        return None

    async def update(self, spec: ReportSpecification) -> DomainEvent | None:
        """Update report specification."""
        stmt = select(RelatorioSpec).where(RelatorioSpec.id == spec.id)
        result = await self._session.execute(stmt)
        spec_model = result.scalar_one_or_none()

        if not spec_model:
            return None

        # Update fields
        spec_model.template = spec.template
        spec_model.updated_at = datetime.utcnow()

        return None

    async def delete(self, report_id: int) -> None:
        """Delete report specification by ID."""
        stmt = select(RelatorioSpec).where(RelatorioSpec.id == report_id)
        result = await self._session.execute(stmt)
        spec = result.scalar_one_or_none()

        if spec:
            await self._session.delete(spec)

    def _model_to_domain(self, spec: RelatorioSpec) -> ReportSpecification:
        """Convert ORM model to domain entity."""
        return ReportSpecification(
            id=spec.id,
            tipo=ReportTipo(spec.tipo),
            template=spec.template,
            filtros={},
        )

    def _domain_to_model(self, spec: ReportSpecification) -> RelatorioSpec:
        """Convert domain entity to ORM model."""
        return RelatorioSpec(
            id=spec.id if spec.id != 0 else None,
            tipo=spec.tipo.value,
            template=spec.template,
            descricao=f"Report specification for {spec.tipo.value}",
        )
