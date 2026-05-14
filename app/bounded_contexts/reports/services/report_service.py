"""Reports application service.

Implements use cases for reports bounded context.

REP-001: Crystal Reports substituído por HTML/PDF dinâmico.
REP-002: Relatórios aceitam filtros parametrizados.
"""

from __future__ import annotations

from datetime import date, datetime, timedelta
from typing import Any

from app.bounded_contexts.reports.domain.entities import (
    DateRange,
    Periodo,
    ReportSpecification,
    ReportTipo,
)
from app.bounded_contexts.reports.ports.repositories import (
    ReportGeneratorPort,
    ReportRepositoryPort,
)
from app.shared.domain import DomainEvent, report_requested


class ReportService:
    """Application service for report operations.

    REP-001: Crystal Reports substituído por HTML/PDF dinâmico.
    REP-002: Relatórios aceitam filtros parametrizados.
    """

    def __init__(
        self,
        report_repo: ReportRepositoryPort,
        report_generator: ReportGeneratorPort,
    ) -> None:
        self._report_repo = report_repo
        self._report_generator = report_generator

    async def create_report_spec(
        self,
        tipo: str,
        template: str,
        filtros: dict[str, Any] | None = None,
    ) -> tuple[ReportSpecification, DomainEvent]:
        """Create a new report specification.

        Args:
            tipo: Report type
            template: Template path for HTML/PDF generation
            filtros: Optional filters

        Returns:
            (spec, event)
        """
        # Validate tipo exists
        try:
            ReportTipo(tipo)
        except ValueError:
            raise ValueError(f"Tipo de relatório inválido: {tipo}")

        spec, event = ReportSpecification.create(
            tipo=tipo,
            template=template,
            filtros=filtros or {},
        )

        saved_event = await self._report_repo.save(spec)

        return spec, event or event

    async def generate_report_html(
        self,
        tipo: str,
        data: list[dict[str, Any]],
        filtros: dict[str, Any] | None = None,
    ) -> str:
        """Generate HTML report.

        Args:
            tipo: Report type
            data: Report data rows
            filtros: Optional filters

        Returns:
            HTML string

        REP-001: HTML dinâmico substitui Crystal Reports.
        """
        # Get or create spec
        spec = await self._report_repo.get_by_tipo(tipo)
        if not spec:
            # Create default spec
            template = f"reports/{tipo}.html"
            spec, _ = ReportSpecification.create(tipo, template, filtros or {})
        else:
            # Update filters if provided
            if filtros:
                for chave, valor in filtros.items():
                    spec.add_filtro(chave, valor)

        # Generate HTML
        html = await self._report_generator.generate_html(spec, data)

        return html

    async def generate_report_pdf(
        self,
        tipo: str,
        data: list[dict[str, Any]],
        filtros: dict[str, Any] | None = None,
    ) -> bytes:
        """Generate PDF report.

        Args:
            tipo: Report type
            data: Report data rows
            filtros: Optional filters

        Returns:
            PDF bytes

        REP-001: PDF dinâmico substitui Crystal Reports.
        """
        # Get or create spec
        spec = await self._report_repo.get_by_tipo(tipo)
        if not spec:
            # Create default spec
            template = f"reports/{tipo}.html"
            spec, _ = ReportSpecification.create(tipo, template, filtros or {})
        else:
            # Update filters if provided
            if filtros:
                for chave, valor in filtros.items():
                    spec.add_filtro(chave, valor)

        # Generate PDF
        pdf = await self._report_generator.generate_pdf(spec, data)

        return pdf

    def parse_periodo(self, periodo: str) -> DateRange:
        """Parse period string to DateRange (REP-002).

        Args:
            periodo: Period string (hoje, ontem, esta_semana, etc.)

        Returns:
            DateRange
        """
        hoje = date.today()

        periodo_map = {
            Periodo.HOJE.value: DateRange(hoje, hoje),
            Periodo.ONTEM.value: DateRange(
                hoje - timedelta(days=1), hoje - timedelta(days=1)
            ),
            Periodo.ESTA_SEMANA.value: self._get_week_range(hoje),
            Periodo.ESTE_MES.value: self._get_month_range(hoje.year, hoje.month),
            Periodo.ULTIMO_MES.value: self._get_month_range(
                *self._get_previous_month(hoje.year, hoje.month)
            ),
            Periodo.ULTIMO_TRIMESTRE.value: self._get_quarter_range(hoje),
            Periodo.ESTE_ANO.value: DateRange(
                date(hoje.year, 1, 1), date(hoje.year, 12, 31)
            ),
        }

        if periodo not in periodo_map:
            raise ValueError(f"Período inválido: {periodo}")

        return periodo_map[periodo]

    def _get_week_range(self, data: date) -> DateRange:
        """Get date range for current week."""
        # Monday of the week
        start = data - timedelta(days=data.weekday())
        # Sunday of the week
        end = start + timedelta(days=6)
        return DateRange(start, end)

    def _get_month_range(self, year: int, month: int) -> DateRange:
        """Get date range for a month."""
        import calendar

        last_day = calendar.monthrange(year, month)[1]
        return DateRange(date(year, month, 1), date(year, month, last_day))

    def _get_previous_month(self, year: int, month: int) -> tuple[int, int]:
        """Get previous month year and month."""
        if month == 1:
            return year - 1, 12
        return year, month - 1

    def _get_quarter_range(self, data: date) -> DateRange:
        """Get date range for the current quarter."""
        quarter = (data.month - 1) // 3
        start_month = quarter * 3 + 1
        end_month = start_month + 2

        start_year = data.year
        end_year = data.year

        # Handle year boundary
        if start_month > 12:
            start_month -= 12
            start_year += 1
        if end_month > 12:
            end_month -= 12
            end_year += 1

        import calendar

        end_day = calendar.monthrange(end_year, end_month)[1]

        return DateRange(
            date(start_year, start_month, 1), date(end_year, end_month, end_day)
        )
