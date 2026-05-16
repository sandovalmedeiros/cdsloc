"""ORM models for Catalog bounded context.

Tables: grupos, estilos, titulos, musicas, interpretes,
         titulos_musicas, titulos_interpretes, cds
"""

from datetime import datetime
from typing import Optional

from sqlalchemy import (
    Column,
    Integer,
    String,
    Text,
    Date,
    Boolean,
    Numeric,
    ForeignKey,
    CheckConstraint,
)
from sqlalchemy.orm import (
    Mapped,
    mapped_column,
    relationship,
)
from sqlalchemy.dialects.postgresql import JSONB

from app.adapters.db.base import Base


class Grupo(Base):
    """Grupo table (music classification)."""

    __tablename__ = "grupos"

    id: Mapped[int] = mapped_column(Integer, primary_key=True)
    nome: Mapped[str] = mapped_column(String(100), unique=True, nullable=False)
    descricao: Mapped[str | None] = mapped_column(Text, nullable=True)
    created_at: Mapped[datetime] = mapped_column(Date, nullable=False, default=datetime.utcnow)
    updated_at: Mapped[datetime] = mapped_column(Date, nullable=False, default=datetime.utcnow)

    # Relationships
    titulos: Mapped[list["Titulo"]] = relationship(
        "Titulo",
        back_populates="grupo",
        lazy="selectin",
    )

    def __repr__(self) -> str:
        return f"<Grupo id={self.id} nome={self.nome}>"


class Estilo(Base):
    """Estilo table (music style classification)."""

    __tablename__ = "estilos"

    id: Mapped[int] = mapped_column(Integer, primary_key=True)
    nome: Mapped[str] = mapped_column(String(100), unique=True, nullable=False)
    descricao: Mapped[str | None] = mapped_column(Text, nullable=True)
    created_at: Mapped[datetime] = mapped_column(Date, nullable=False, default=datetime.utcnow)
    updated_at: Mapped[datetime] = mapped_column(Date, nullable=False, default=datetime.utcnow)

    # Relationships
    titulos: Mapped[list["Titulo"]] = relationship(
        "Titulo",
        back_populates="estilo",
        lazy="selectin",
    )

    def __repr__(self) -> str:
        return f"<Estilo id={self.id} nome={self.nome}>"


class Titulo(Base):
    """Titulo (album) table.

    Business rules:
    - BR-CAT-004: tipo_locacao is '24h' or '48h'
    - BR-CAT-005: classification (grupo, estilo) is optional
    """

    __tablename__ = "titulos"

    id: Mapped[int] = mapped_column(Integer, primary_key=True)
    nome: Mapped[str] = mapped_column(String(255), nullable=False)
    tipo_locacao: Mapped[str] = mapped_column(
        String(10),
        nullable=False,
        default="24h",
    )
    valor: Mapped[Numeric] = mapped_column(
        Numeric(10, 2),
        nullable=False,
        default=0,
    )
    qtde: Mapped[int] = mapped_column(Integer, nullable=False, default=0)

    # Foreign keys
    id_grupo: Mapped[int | None] = mapped_column(
        Integer,
        ForeignKey("grupos.id", ondelete="SET NULL"),
        nullable=True,
    )
    id_estilo: Mapped[int | None] = mapped_column(
        Integer,
        ForeignKey("estilos.id", ondelete="SET NULL"),
        nullable=True,
    )
    created_at: Mapped[datetime] = mapped_column(Date, nullable=False, default=datetime.utcnow)
    updated_at: Mapped[datetime] = mapped_column(Date, nullable=False, default=datetime.utcnow)

    # Relationships
    grupo: Mapped[Optional["Grupo"]] = relationship(
        "Grupo",
        back_populates="titulos",
        lazy="selectin",
    )
    estilo: Mapped[Optional["Estilo"]] = relationship(
        "Estilo",
        back_populates="titulos",
        lazy="selectin",
    )
    musicas: Mapped[list["Musica"]] = relationship(
        "Musica",
        secondary="titulos_musicas",
        back_populates="titulos",
        lazy="selectin",
    )
    interpretes: Mapped[list["Interprete"]] = relationship(
        "Interprete",
        secondary="titulos_interpretes",
        back_populates="titulos",
        lazy="selectin",
    )
    cds: Mapped[list["Cd"]] = relationship(
        "Cd",
        back_populates="titulo",
        lazy="selectin",
    )

    def __repr__(self) -> str:
        return f"<Titulo id={self.id} nome={self.nome} tipo={self.tipo_locacao}>"


class Musica(Base):
    """Musica (track) table.

    Business rules:
    - Duration (tempo) in seconds, optional (>= 0 if provided).
    """

    __tablename__ = "musicas"

    id: Mapped[int] = mapped_column(Integer, primary_key=True)
    nome: Mapped[str] = mapped_column(String(255), nullable=False)
    tempo: Mapped[int | None] = mapped_column(
        Integer,
        nullable=True,
    )
    created_at: Mapped[datetime] = mapped_column(Date, nullable=False, default=datetime.utcnow)
    updated_at: Mapped[datetime] = mapped_column(Date, nullable=False, default=datetime.utcnow)

    # Relationships
    titulos: Mapped[list["Titulo"]] = relationship(
        "Titulo",
        secondary="titulos_musicas",
        back_populates="musicas",
        lazy="selectin",
    )
    interpretes: Mapped[list["Interprete"]] = relationship(
        "Interprete",
        secondary="musicas_interpretes",
        back_populates="musicas",
        lazy="selectin",
    )

    def __repr__(self) -> str:
        return f"<Musica id={self.id} nome={self.nome} tempo={self.tempo}s>"


class Interprete(Base):
    """Interprete (artist) table."""

    __tablename__ = "interpretes"

    id: Mapped[int] = mapped_column(Integer, primary_key=True)
    nome: Mapped[str] = mapped_column(String(255), nullable=False)
    created_at: Mapped[datetime] = mapped_column(Date, nullable=False, default=datetime.utcnow)
    updated_at: Mapped[datetime] = mapped_column(Date, nullable=False, default=datetime.utcnow)

    # Relationships
    titulos: Mapped[list["Titulo"]] = relationship(
        "Titulo",
        secondary="titulos_interpretes",
        back_populates="interpretes",
        lazy="selectin",
    )
    musicas: Mapped[list["Musica"]] = relationship(
        "Musica",
        secondary="musicas_interpretes",
        back_populates="interpretes",
        lazy="selectin",
    )

    def __repr__(self) -> str:
        return f"<Interprete id={self.id} nome={self.nome}>"


class TituloMusica(Base):
    """Association table for many-to-many Titulo <-> Musica."""

    __tablename__ = "titulos_musicas"

    id: Mapped[int] = mapped_column(Integer, primary_key=True)
    id_titulo: Mapped[int] = mapped_column(
        Integer,
        ForeignKey("titulos.id", ondelete="CASCADE"),
        nullable=False,
    )
    id_musica: Mapped[int] = mapped_column(
        Integer,
        ForeignKey("musicas.id", ondelete="CASCADE"),
        nullable=False,
    )
    created_at: Mapped[datetime] = mapped_column(Date, nullable=False, default=datetime.utcnow)

    # Relationships
    titulo: Mapped["Titulo"] = relationship("Titulo", lazy="selectin")
    musica: Mapped["Musica"] = relationship("Musica", lazy="selectin")

    def __repr__(self) -> str:
        return f"<TituloMusica id={self.id} titulo_id={self.id_titulo} musica_id={self.id_musica}>"


class TituloInterprete(Base):
    """Association table for many-to-many Titulo <-> Interprete."""

    __tablename__ = "titulos_interpretes"

    id: Mapped[int] = mapped_column(Integer, primary_key=True)
    id_titulo: Mapped[int] = mapped_column(
        Integer,
        ForeignKey("titulos.id", ondelete="CASCADE"),
        nullable=False,
    )
    id_interprete: Mapped[int] = mapped_column(
        Integer,
        ForeignKey("interpretes.id", ondelete="CASCADE"),
        nullable=False,
    )
    created_at: Mapped[datetime] = mapped_column(Date, nullable=False, default=datetime.utcnow)

    # Relationships
    titulo: Mapped["Titulo"] = relationship("Titulo", lazy="selectin")
    interprete: Mapped["Interprete"] = relationship("Interprete", lazy="selectin")

    def __repr__(self) -> str:
        return f"<TituloInterprete id={self.id} titulo_id={self.id_titulo} interprete_id={self.id_interprete}>"


class MusicaInterprete(Base):
    """Association table for many-to-many Musica <-> Interprete."""

    __tablename__ = "musicas_interpretes"

    id: Mapped[int] = mapped_column(Integer, primary_key=True)
    id_musica: Mapped[int] = mapped_column(
        Integer,
        ForeignKey("musicas.id", ondelete="CASCADE"),
        nullable=False,
    )
    id_interprete: Mapped[int] = mapped_column(
        Integer,
        ForeignKey("interpretes.id", ondelete="CASCADE"),
        nullable=False,
    )
    created_at: Mapped[datetime] = mapped_column(Date, nullable=False, default=datetime.utcnow)

    # Relationships
    musica: Mapped["Musica"] = relationship("Musica", lazy="selectin")
    interprete: Mapped["Interprete"] = relationship("Interprete", lazy="selectin")

    def __repr__(self) -> str:
        return f"<MusicaInterprete id={self.id} musica_id={self.id_musica} interprete_id={self.id_interprete}>"


class Situacao(Base):
    """Situacao (status) table for CDs and other entities."""

    __tablename__ = "situacoes"

    id: Mapped[int] = mapped_column(Integer, primary_key=True)
    descricao: Mapped[str] = mapped_column(String(50), unique=True, nullable=False)
    tipo: Mapped[str] = mapped_column(
        String(20),
        nullable=False,
        default="cd",  # cd, reserva, etc.
    )
    created_at: Mapped[datetime] = mapped_column(Date, nullable=False, default=datetime.utcnow)

    # Relationships
    cds: Mapped[list["Cd"]] = relationship(
        "Cd",
        back_populates="situacao",
        lazy="selectin",
    )

    def __repr__(self) -> str:
        return f"<Situacao id={self.id} descricao={self.descricao} tipo={self.tipo}>"


class Cd(Base):
    """Cd (physical CD) table.

    Business rules:
    - BR-CAT-001: situacao (Available/Rented/Reserved) is valid
    - BR-CAT-002: stock validation on CD registration
    - BR-CAT-003: stock auto-updated (handled by trigger)
    """

    __tablename__ = "cds"

    codigo: Mapped[str] = mapped_column(
        String(10),
        primary_key=True,
        unique=True,
        nullable=False,
    )
    id_titulo: Mapped[int] = mapped_column(
        Integer,
        ForeignKey("titulos.id", ondelete="CASCADE"),
        nullable=False,
    )
    numcd: Mapped[str] = mapped_column(String(50), nullable=False)
    situacao_id: Mapped[int] = mapped_column(
        Integer,
        ForeignKey("situacoes.id"),
        nullable=False,
        default=1,  # 1 = Disponível
    )
    is_locado: Mapped[bool] = mapped_column(Boolean, nullable=False, default=False)
    data_cp: Mapped[datetime | None] = mapped_column(Date, nullable=True)
    valor_cp: Mapped[Numeric | None] = mapped_column(
        Numeric(10, 2),
        nullable=True,
    )
    created_at: Mapped[datetime] = mapped_column(Date, nullable=False, default=datetime.utcnow)
    updated_at: Mapped[datetime] = mapped_column(Date, nullable=False, default=datetime.utcnow)

    # Relationships
    titulo: Mapped["Titulo"] = relationship(
        "Titulo",
        back_populates="cds",
        lazy="selectin",
    )
    situacao: Mapped["Situacao"] = relationship(
        "Situacao",
        back_populates="cds",
        lazy="selectin",
    )

    @property
    def situacao_descricao(self) -> str:
        """Get situacao string based on id or relationship."""
        if self.situacao:
            return self.situacao.descricao
        # Fallback mapping
        situacoes = {1: "Disponível", 2: "Locado", 3: "Reservado"}
        return situacoes.get(self.situacao_id, "Desconhecido")

    @property
    def is_disponivel(self) -> bool:
        """Check if CD is available for rental."""
        return self.situacao_id == 1

    @property
    def is_reserved(self) -> bool:
        """Check if CD is reserved."""
        return self.situacao_id == 3

    def __repr__(self) -> str:
        return f"<Cd codigo={self.codigo} situacao={self.situacao_id}>"
