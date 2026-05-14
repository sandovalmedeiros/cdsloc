"""ORM models for Reports bounded context.

Tables: relatorio_specs

Business rules:
- REP-001: Crystal Reports substituído por HTML/PDF dinâmico.
- REP-002: Relatórios aceitam filtros parametrizados.
"""

from datetime import datetime

from sqlalchemy import Column, Integer, String, Text, CheckConstraint
from sqlalchemy.orm import Mapped, mapped_column
from sqlalchemy.dialects.postgresql import JSONB

from app.adapters.db.base import Base


class RelatorioSpec(Base):
    """RelatorioSpec (report specification) table.

    Stores report specifications for HTML/PDF generation.

    Business rules:
    - REP-001: Crystal Reports substituído por HTML/PDF dinâmico.
    - REP-002: Relatórios aceitam filtros parametrizados.
    """

    __tablename__ = "relatorio_specs"

    id: Mapped[int] = mapped_column(Integer, primary_key=True)
    tipo: Mapped[str] = mapped_column(
        String(50),
        nullable=False,
    )
    template: Mapped[str] = mapped_column(
        String(255),
        nullable=False,
    )
    descricao: Mapped[str | None] = mapped_column(Text, nullable=True)
    created_at: Mapped[datetime] = mapped_column(
        nullable=False,
        default=datetime.utcnow,
    )
    updated_at: Mapped[datetime] = mapped_column(
        nullable=False,
        default=datetime.utcnow,
    )

    # Constraints
    __table_args__ = (
        CheckConstraint(
            "tipo IN ('clientes_sintetico', 'clientes_analitico', 'dependentes', "
            "'musicas', 'cds', 'titulos', 'reservas', 'aniversariantes', "
            "'recebimentos', 'locacoes')",
            name="ck_relatorio_specs_tipo",
        ),
    )

    def __repr__(self) -> str:
        return f"<RelatorioSpec id={self.id} tipo={self.tipo} template={self.template}>"
