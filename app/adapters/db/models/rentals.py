"""ORM models for Rentals bounded context.

Tables: locacoes, locacoes_itens, recibos, recibo_itens

Business rules:
- RENT-006: Locação marca CD como Locado
- RENT-011: Devolução marca CD como Disponível
- RENT-012: Recibo marcado como devolvido após baixa
- BR-MIGRAR-029: Transação atômica entre locação e CD
- BR-MIGRAR-033: Cálculo de multa (R$ 3,50/dia)
"""

from datetime import datetime, date
from typing import Optional

from sqlalchemy import (
    Column,
    Integer,
    String,
    ForeignKey,
    Boolean,
    Numeric,
    CheckConstraint,
)
from sqlalchemy.orm import Mapped, mapped_column, relationship

from app.adapters.db.base import Base


class Locacao(Base):
    """Locacao (rental) table.

    Agregate root for rentals bounded context.

    Business rules:
    - RENT-001: Locação exige cliente ativo
    - RENT-002: Locação permite retirada por dependente
    - RENT-004: Cálculo de data prevista 24h
    - RENT-005: Cálculo de data prevista 48h
    - RENT-009: Cálculo de dias de atraso
    - RENT-010: Cálculo de multa
    """

    __tablename__ = "locacoes"

    id: Mapped[int] = mapped_column(Integer, primary_key=True)
    id_cliente: Mapped[int] = mapped_column(
        Integer,
        ForeignKey("clientes.id", ondelete="CASCADE"),
        nullable=False,
    )
    id_dependente: Mapped[Optional[int]] = mapped_column(
        Integer,
        ForeignKey("dependentes.id", ondelete="SET NULL"),
        nullable=True,
    )
    data_locacao: Mapped[datetime] = mapped_column(
        nullable=False,
        default=datetime.utcnow,
    )
    data_prevista: Mapped[date] = mapped_column(
        nullable=False,
    )
    valor_locacao: Mapped[Numeric] = mapped_column(
        Numeric(10, 2),
        nullable=False,
    )
    valor_multa: Mapped[Numeric] = mapped_column(
        Numeric(10, 2),
        nullable=False,
        default=0,
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
    dependente: Mapped[Optional["Dependente"]] = relationship(
        "Dependente",
        lazy="selectin",
    )
    itens: Mapped[list["LocacaoItem"]] = relationship(
        "LocacaoItem",
        back_populates="locacao",
        lazy="selectin",
    )
    recibo: Mapped["Recibo"] = relationship(
        "Recibo",
        back_populates="locacao",
        uselist=False,
        lazy="selectin",
    )

    # Constraints
    __table_args__ = (
        CheckConstraint("valor_multa >= 0", name="ck_locacoes_valor_multa_non_negative"),
    )

    def __repr__(self) -> str:
        return f"<Locacao id={self.id} cliente_id={self.id_cliente} valor={self.valor_locacao}>"


class LocacaoItem(Base):
    """LocacaoItem (rental item) table.

    Associates a rental with a physical CD.
    """

    __tablename__ = "locacoes_itens"

    id: Mapped[int] = mapped_column(Integer, primary_key=True)
    id_locacao: Mapped[int] = mapped_column(
        Integer,
        ForeignKey("locacoes.id", ondelete="CASCADE"),
        nullable=False,
    )
    id_cd: Mapped[str] = mapped_column(
        String(10),
        ForeignKey("cds.codigo", ondelete="CASCADE"),
        nullable=False,
    )
    valor_item: Mapped[Numeric] = mapped_column(
        Numeric(10, 2),
        nullable=False,
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
    locacao: Mapped["Locacao"] = relationship(
        "Locacao",
        back_populates="itens",
        lazy="selectin",
    )
    cd: Mapped["Cd"] = relationship(
        "Cd",
        lazy="selectin",
    )

    def __repr__(self) -> str:
        return f"<LocacaoItem id={self.id} cd_codigo={self.id_cd} valor={self.valor_item}>"


class Recibo(Base):
    """Recibo (receipt) table.

    Represents a receipt for rentals.
    A receipt can have multiple rental items.

    Business rules:
    - RENT-012: Recibo marcado como devolvido após baixa
    """

    __tablename__ = "recibos"

    id: Mapped[int] = mapped_column(Integer, primary_key=True)
    id_locacao: Mapped[int] = mapped_column(
        Integer,
        ForeignKey("locacoes.id", ondelete="CASCADE"),
        nullable=False,
    )
    id_cliente: Mapped[int] = mapped_column(
        Integer,
        ForeignKey("clientes.id", ondelete="CASCADE"),
        nullable=False,
    )
    data_emissao: Mapped[datetime] = mapped_column(
        nullable=False,
        default=datetime.utcnow,
    )
    valor_total: Mapped[Numeric] = mapped_column(
        Numeric(10, 2),
        nullable=False,
    )
    is_devolvido: Mapped[bool] = mapped_column(
        Boolean,
        nullable=False,
        default=False,
    )
    data_devolucao: Mapped[Optional[datetime]] = mapped_column(
        nullable=True,
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
    locacao: Mapped["Locacao"] = relationship(
        "Locacao",
        back_populates="recibo",
        uselist=False,
        lazy="selectin",
    )
    cliente: Mapped["Cliente"] = relationship(
        "Cliente",
        lazy="selectin",
    )
    itens: Mapped[list["ReciboItem"]] = relationship(
        "ReciboItem",
        back_populates="recibo",
        lazy="selectin",
    )

    @property
    def devolvido(self) -> bool:
        """Alias for is_devolvido for domain compatibility."""
        return self.is_devolvido

    def __repr__(self) -> str:
        return f"<Recibo id={self.id} valor_total={self.valor_total} devolvido={self.is_devolvido}>"


class ReciboItem(Base):
    """ReciboItem (receipt item) table.

    Associates a receipt with a physical CD.
    Used for historical tracking.
    """

    __tablename__ = "recibo_itens"

    id: Mapped[int] = mapped_column(Integer, primary_key=True)
    id_recibo: Mapped[int] = mapped_column(
        Integer,
        ForeignKey("recibos.id", ondelete="CASCADE"),
        nullable=False,
    )
    id_cd: Mapped[str] = mapped_column(
        String(10),
        ForeignKey("cds.codigo", ondelete="CASCADE"),
        nullable=False,
    )
    valor_item: Mapped[Numeric] = mapped_column(
        Numeric(10, 2),
        nullable=False,
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
    recibo: Mapped["Recibo"] = relationship(
        "Recibo",
        back_populates="itens",
        lazy="selectin",
    )
    cd: Mapped["Cd"] = relationship(
        "Cd",
        lazy="selectin",
    )

    def __repr__(self) -> str:
        return f"<ReciboItem id={self.id} cd_codigo={self.id_cd} valor={self.valor_item}>"
