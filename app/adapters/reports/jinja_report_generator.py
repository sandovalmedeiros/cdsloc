"""Jinja2-based report generator adapter.

Implements ReportGeneratorPort using Jinja2 for HTML and WeasyPrint for PDF.

REP-001: Crystal Reports substituído por HTML/PDF dinâmico.
REP-002: Relatórios aceitam filtros parametrizados.
"""

from __future__ import annotations

from datetime import date
from pathlib import Path
from typing import Any

from jinja2 import Environment, FileSystemLoader, select_autoescape

from app.bounded_contexts.reports.domain.entities import ReportSpecification
from app.bounded_contexts.reports.ports.repositories import ReportGeneratorPort


class JinjaReportGenerator(ReportGeneratorPort):
    """Report generator using Jinja2 templates.

    REP-001: HTML dinâmico substitui Crystal Reports.
    """

    def __init__(self, templates_dir: str | None = None) -> None:
        """Initialize Jinja2 environment with templates directory.

        Args:
            templates_dir: Path to templates directory (defaults to app/adapters/reports/templates)
        """
        if templates_dir:
            self._env = Environment(
                loader=FileSystemLoader(templates_dir),
                autoescape=select_autoescape(["html", "xml"]),
            )
        else:
            # Use default templates directory
            templates_path = Path(__file__).parent / "templates"
            self._env = Environment(
                loader=FileSystemLoader(templates_path),
                autoescape=select_autoescape(["html", "xml"]),
            )

        # Add custom filters
        self._env.filters["format_date"] = self._format_date
        self._env.filters["format_currency"] = self._format_currency
        self._env.filters["format_phone"] = self._format_phone

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
        # Get template
        template_name = Path(spec.template).name
        template = self._env.get_template(template_name)

        # Prepare context
        context = {
            "data": data,
            "report_type": spec.tipo.value,
            "report_name": self._get_report_name(spec.tipo),
            "generated_at": date.today(),
            "filters": spec.filtros,
        }

        # Render template
        html = template.render(**context)

        return html

    async def generate_pdf(
        self, spec: ReportSpecification, data: list[dict[str, Any]]
    ) -> bytes:
        """Generate PDF report from specification and data.

        Args:
            spec: Report specification
            data: Report data rows

        Returns:
            PDF bytes

        REP-001: PDF dinâmico substitui Crystal Reports.
        """
        # First generate HTML
        html = await self.generate_html(spec, data)

        # Convert HTML to PDF using WeasyPrint
        try:
            from weasyprint import HTML

            pdf_bytes = HTML(string=html).write_pdf()
            return pdf_bytes
        except ImportError:
            raise RuntimeError(
                "WeasyPrint not installed. Install it with: pip install weasyprint"
            )

    def _get_report_name(self, tipo: Any) -> str:
        """Get human-readable report name."""
        from app.bounded_contexts.reports.domain.entities import ReportTipo

        names = {
            ReportTipo.CLIENTES_SINTETICO: "Relatório de Clientes (Sintético)",
            ReportTipo.CLIENTES_ANALITICO: "Relatório de Clientes (Analítico)",
            ReportTipo.DEPENDENTES: "Relatório de Dependentes",
            ReportTipo.MUSICAS: "Relatório de Músicas",
            ReportTipo.CDS: "Relatório de CDs Físicos",
            ReportTipo.TITULOS: "Relatório de Títulos",
            ReportTipo.RESERVAS: "Relatório de Reservas",
            ReportTipo.ANIVERSARIANTES: "Relatório de Aniversariantes",
            ReportTipo.RECEBIMENTOS: "Relatório de Recebimentos",
            ReportTipo.LOCACOES: "Relatório de Locações",
        }

        return names.get(tipo, "Relatório")

    def _format_date(self, value: Any, format_str: str = "%d/%m/%Y") -> str:
        """Format date value."""
        if value is None:
            return ""
        if isinstance(value, str):
            return value
        return value.strftime(format_str)

    def _format_currency(self, value: Any) -> str:
        """Format value as Brazilian currency."""
        if value is None:
            return "R$ 0,00"
        return f"R$ {float(value):.2f}".replace(".", ",")

    def _format_phone(self, value: Any) -> str:
        """Format phone number."""
        if value is None:
            return ""
        phone = str(value)
        # Remove non-digits
        phone = "".join(c for c in phone if c.isdigit())
        # Format as (XX) XXXXX-XXXX or (XX) XXXX-XXXX
        if len(phone) == 10:
            return f"({phone[:2]}) {phone[2:6]}-{phone[6:]}"
        elif len(phone) == 11:
            return f"({phone[:2]}) {phone[2:7]}-{phone[7:]}"
        return value
