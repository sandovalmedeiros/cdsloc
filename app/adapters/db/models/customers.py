"""ORM models for Customers bounded context.

Tables: municipios, bairros, clientes, dependentes
"""

from datetime import date

from sqlalchemy import Column, Integer, String, Text, ForeignKey
from sqlalchemy.orm import Mapped, mapped_column, relationship
from sqlalchemy.dialects.postgresql import JSONB

from app.adapters.db.base import Base


class Municipio(Base):
    """Municipio (city) table."""

    __tablename__ = "municipios"

    id: Mapped[int] = mapped_column(Integer, primary_key=True)
    nome: Mapped[str] = mapped_column(String(100), nullable=False)
    uf: Mapped[str] = mapped_column(String(2), nullable=False)
    created_at: Mapped[date] = mapped_column(date, nullable=False)
    updated_at: Mapped[date] = mapped_column(date, nullable=False)

    # Relationships
    bairros: Mapped[list["Bairro"]] = relationship(
        "Bairro",
        back_populates="municipio",
        lazy="selectin",
    )

    def __repr__(self) -> str:
        return f"<Municipio id={self.id} nome={self.nome} uf={self.uf}>"


class Bairro(Base):
    """Bairro (neighborhood) table."""

    __tablename__ = "bairros"

    id: Mapped[int] = mapped_column(Integer, primary_key=True)
    cdbairro: Mapped[str] = mapped_column(String(10), unique=True, nullable=False)
    debairro: Mapped[str] = mapped_column(String(100), nullable=False)
    id_municipio: Mapped[int] = mapped_column(
        Integer,
        ForeignKey("municipios.id", ondelete="SET NULL"),
        nullable=False,
    )
    created_at: Mapped[date] = mapped_column(date, nullable=False)
    updated_at: Mapped[date] = mapped_column(date, nullable=False)

    # Relationships
    municipio: Mapped["Municipio"] = relationship(
        "Municipio",
        back_populates="bairros",
        lazy="selectin",
    )
    clientes: Mapped[list["Cliente"]] = relationship(
        "Cliente",
        back_populates="bairro",
        lazy="selectin",
    )

    def __repr__(self) -> str:
        return f"<Bairro id={self.id} cdbairro={self.cdbairro}>"


class Cliente(Base):
    """Cliente (customer) table.

    Business rules:
    - BR-CUST-001: Cancelado clientes cannot rent (block in rentals)
    - BR-CUST-002: Cancelado clientes cannot add dependents
    - BR-CUST-003: Search by substring case-insensitive
    - BR-CUST-004: Bairro must be chosen from registered list
    """

    __tablename__ = "clientes"

    id: Mapped[int] = mapped_column(Integer, primary_key=True)
    codcliente: Mapped[str] = mapped_column(String(10), unique=True, nullable=False)
    nomecliente: Mapped[str] = mapped_column(String(255), nullable=False)
    endereco: Mapped[str] = mapped_column(String(255), nullable=False)
    data_nascimento: Mapped[date] = mapped_column(date, nullable=False)
    cdbairro: Mapped[int] = mapped_column(
        Integer,
        ForeignKey("bairros.id"),
        nullable=False,
    )
    cep: Mapped[str] = mapped_column(String(10), nullable=True)
    fone_01: Mapped[str] = mapped_column(String(15), nullable=True)
    ramal_res: Mapped[str] = mapped_column(String(10), nullable=True)
    fone_02: Mapped[str] = mapped_column(String(15), nullable=True)
    ramal_trab: Mapped[str] = mapped_column(String(10), nullable=True)
    fone_03: Mapped[str] = mapped_column(String(15), nullable=True)
    identidade: Mapped[str] = mapped_column(String(20), nullable=True)
    expedidor: Mapped[str] = mapped_column(String(20), nullable=True)
    data_expedicao: Mapped[date] = mapped_column(date, nullable=True)
    cic: Mapped[str] = mapped_column(String(14), nullable=True)
    empresa: Mapped[str] = mapped_column(String(255), nullable=True)
    end_comercial: Mapped[str] = mapped_column(String(255), nullable=True)
    referencia_pessoal: Mapped[str] = mapped_column(String(255), nullable=True)
    data_inscricao: Mapped[date] = mapped_column(date, nullable=False)
    is_cancelado: Mapped[bool] = mapped_column(Boolean, nullable=False, default=False)
    obs: Mapped[str | None] = mapped_column(Text, nullable=True)
    created_at: Mapped[date] = mapped_column(date, nullable=False)
    updated_at: Mapped[date] = mapped_column(date, nullable=False)

    # Relationships
    bairro: Mapped["Bairro"] = relationship(
        "Bairro",
        back_populates="clientes",
        lazy="selectin",
    )
    dependentes: Mapped[list["Dependente"]] = relationship(
        "Dependente",
        back_populates="cliente",
        lazy="selectin",
    )

    def __repr__(self) -> str:
        return f"<Cliente id={self.id} codcliente={self.codcliente} nome={self.nomecliente}>"


class Dependente(Base):
    """Dependente (dependent) table."""

    __tablename__ = "dependentes"

    id: Mapped[int] = mapped_column(Integer, primary_key=True)
    cod_dependente: Mapped[str] = mapped_column(String(10), unique=True, nullable=False)
    id_cliente: Mapped[int] = mapped_column(
        Integer,
        ForeignKey("clientes.id", ondelete="CASCADE"),
        nullable=False,
    )
    nome_dependente: Mapped[str] = mapped_column(String(255), nullable=False)
    created_at: Mapped[date] = mapped_column(date, nullable=False)
    updated_at: Mapped[date] = mapped_column(date, nullable=False)

    # Relationships
    cliente: Mapped["Cliente"] = relationship(
        "Cliente",
        back_populates="dependentes",
        lazy="selectin",
    )

    def __repr__(self) -> str:
        return f"<Dependente id={self.id} cod_dependente={self.cod_dependente}>"
