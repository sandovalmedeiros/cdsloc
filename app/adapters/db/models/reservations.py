"""ORM models for Reservations bounded context.

Tables: reservas, situacoes_reservas

Business rules:
- RESV-001: Reserva exige cliente ativo
- RESV-002: Reserva por título, não por CD físico específico
- RESV-003: Reserva não garante disponibilidade física na retirada
- RESV-004: Bloqueio de reserva duplicada
- RESV-005: Ao converter reserva em locação, situação marcada como "Confirmada"
- RESV-006: Data prevista calculada baseada na disponibilidade
"""

from datetime import datetime, date

from sqlalchemy import (
    Column,
    Integer,
    String,
    ForeignKey,
    CheckConstraint,
)
from sqlalchemy.orm import Mapped, mapped_column, relationship

from app.adapters.db.base import Base


class Reserva(Base):
    """Reserva (reservation) table.

    Agregate root for reservations bounded context.

    Business rules:
    - RESV-001: Reserva exige cliente ativo
    - RESV-002: Reserva por título, não por CD físico específico
    - RESV-003: Reserva não garante disponibilidade física na retirada
    - RESV-004: Bloqueio de reserva duplicada
    - RESV-005: Ao converter reserva em locação, situação marcada como "Confirmada"
    - RESV-006: Data prevista calculada baseada na disponibilidade
    """

    __tablename__ = "reservas"

    id: Mapped[int] = mapped_column(Integer, primary_key=True)
    id_cliente: Mapped[int] = mapped_column(
        Integer,
        ForeignKey("clientes.id", ondelete="CASCADE"),
        nullable=False,
    )
    id_titulo: Mapped[int] = mapped_column(
        Integer,
        ForeignKey("titulos.id", ondelete="CASCADE"),
        nullable=False,
    )
    data_reserva: Mapped[datetime] = mapped_column(
        nullable=False,
        default=datetime.utcnow,
    )
    data_prevista: Mapped[date] = mapped_column(
        nullable=False,
    )
    situacao_id: Mapped[int] = mapped_column(
        Integer,
        nullable=False,
        default=1,  # 1 = Pendente
    )
    created_at: Mapped[datetime] = mapped_column(
        nullable=False,
        default=datetime.utcnow,
    )
    updated_at: Mapped[datetime] = mapped_column(
        nullable=False,
        default=datetime.utcnow,
    )

    # Relationships
    cliente: Mapped["Cliente"] = relationship(
        "Cliente",
        lazy="selectin",
    )
    titulo: Mapped["Titulo"] = relationship(
        "Titulo",
        lazy="selectin",
    )

    @property
    def situacao(self) -> str:
        """Get situacao string based on id."""
        situacoes = {
            1: "Pendente",
            2: "Confirmada",
            3: "Locada",
            4: "Cancelada",
        }
        return situacoes.get(self.situacao_id, "Desconhecido")

    @property
    def is_pendente(self) -> bool:
        """Check if reservation is pending."""
        return self.situacao_id == 1

    @property
    def is_confirmada(self) -> bool:
        """Check if reservation is confirmed."""
        return self.situacao_id == 2

    @property
    def is_locada(self) -> bool:
        """Check if reservation was converted to rental."""
        return self.situacao_id == 3

    @property
    def is_cancelada(self) -> bool:
        """Check if reservation is canceled."""
        return self.situacao_id == 4

    @property
    def is_ativa(self) -> bool:
        """Check if reservation is still active (not canceled or converted)."""
        return self.situacao_id in (1, 2)

    def __repr__(self) -> str:
        return f"<Reserva id={self.id} cliente_id={self.id_cliente} titulo_id={self.id_titulo} situacao={self.situacao}>"
