"""Reports domain entities.

Implements ReportSpecification entity following hexagonal architecture.

REP-001: Crystal Reports substituído por HTML/PDF dinâmico.
REP-002: Relatórios aceitam filtros parametrizados.
"""

from __future__ import annotations

from dataclasses import dataclass, field
from datetime import date
from enum import Enum
from typing import Any

from app.shared.domain import DomainEvent, report_requested


class ReportTipo(str, Enum):
    """Report types available in the system."""

    CLIENTES_SINTETICO = "clientes_sintetico"
    CLIENTES_ANALITICO = "clientes_analitico"
    DEPENDENTES = "dependentes"
    MUSICAS = "musicas"
    CDS = "cds"
    TITULOS = "titulos"
    RESERVAS = "reservas"
    ANIVERSARIANTES = "aniversariantes"
    RECEBIMENTOS = "recebimentos"
    LOCACOES = "locacoes"


class Periodo(str, Enum):
    """Predefined time periods for reports (REP-002)."""

    HOJE = "hoje"
    ONTEM = "ontem"
    ESTA_SEMANA = "esta_semana"
    ESTE_MES = "este_mes"
    ULTIMO_MES = "ultimo_mes"
    ULTIMO_TRIMESTRE = "ultimo_trimestre"
    ESTE_ANO = "este_ano"
    PERSONALIZADO = "personalizado"


@dataclass(slots=True)
class DateRange:
    """Date range value object (REP-002)."""

    data_inicio: date
    data_fim: date

    def __post_init__(self):
        if self.data_inicio > self.data_fim:
            raise ValueError(
                f"Data inicial ({self.data_inicio}) deve ser anterior ou igual à data final ({self.data_fim})"
            )

    @property
    def dias(self) -> int:
        """Return number of days in range."""
        return (self.data_fim - self.data_inicio).days + 1


@dataclass(slots=True)
class FiltroCliente:
    """Customer filter value object (REP-002)."""

    codcliente: int
    cancelado: bool = False


@dataclass(slots=True)
class ReportSpecification:
    """Report specification aggregate root.

    Agregate: Yes (root aggregate)
    Invariant: Template deve existir, parâmetros válidos
    Events: ReportRequested

    REP-001: Crystal Reports substituído por HTML/PDF dinâmico.
    REP-002: Relatórios aceitam filtros parametrizados.
    """

    id: int
    tipo: ReportTipo
    template: str
    filtros: dict[str, Any] = field(default_factory=dict)

    def __post_init__(self):
        # Validate tipo is valid
        if not isinstance(self.tipo, ReportTipo):
            try:
                object.__setattr__(
                    self,
                    "tipo",
                    ReportTipo(self.tipo) if isinstance(self.tipo, str) else self.tipo,
                )
            except ValueError:
                raise ValueError(f"Tipo de relatório inválido: {self.tipo}")

    @classmethod
    def create(
        cls,
        tipo: str | ReportTipo,
        template: str,
        filtros: dict[str, Any] | None = None,
    ) -> tuple["ReportSpecification", DomainEvent]:
        """Create a new report specification.

        Args:
            tipo: Report type
            template: Template path for HTML/PDF generation
            filtros: Optional filters (periodo, data range, customer, etc.)

        Returns:
            (spec, event)
        """
        if isinstance(tipo, str):
            tipo_enum = ReportTipo(tipo)
        else:
            tipo_enum = tipo

        spec = cls(
            id=0,  # Will be set by repository
            tipo=tipo_enum,
            template=template,
            filtros=filtros or {},
        )

        event = report_requested(
            report_id=spec.id,
            report_tipo=str(spec.tipo),
            filtros=spec.filtros,
        )

        return spec, event

    def add_filtro(self, chave: str, valor: Any) -> None:
        """Add a filter to the report specification (REP-002)."""
        self.filtros[chave] = valor

    def get_filtro(self, chave: str, default: Any = None) -> Any:
        """Get a filter value."""
        return self.filtros.get(chave, default)

    def has_filtro(self, chave: str) -> bool:
        """Check if a filter exists."""
        return chave in self.filtros

    def remove_filtro(self, chave: str) -> None:
        """Remove a filter."""
        self.filtros.pop(chave, None)

    @property
    def requires_date_range(self) -> bool:
        """Check if report requires date range filter."""
        date_dependent_types = [
            ReportTipo.LOCACOES,
            ReportTipo.RECEBIMENTOS,
            ReportTipo.RESERVAS,
        ]
        return self.tipo in date_dependent_types

    @property
    def requires_customer_filter(self) -> bool:
        """Check if report requires customer filter."""
        customer_dependent_types = [
            ReportTipo.LOCACOES,
            ReportTipo.RECEBIMENTOS,
        ]
        return self.tipo in customer_dependent_types
