"""Catalog domain entities.

Implements Title, CdFisico, Musica, and Interprete entities
following the hexagonal architecture pattern.
"""

from __future__ import annotations

from dataclasses import dataclass
from datetime import date
from decimal import Decimal
from enum import Enum

from app.shared.domain import DomainEvent, cd_status_changed, stock_updated, title_created


class TipoLocacao(str, Enum):
    """Rental type (BR-MIGRAR-019)."""

    H24 = "24h"
    H48 = "48h"


class SituacaoCd(str, Enum):
    """CD physical status (BR-MIGRAR-021)."""

    DISPONIVEL = "Disponível"
    LOCADO = "Locado"
    RESERVADO = "Reservado"


@dataclass(slots=True)
class Interprete:
    """Music interpreter/artist.

    Agregate: No (part of Title aggregate)
    Invariant: Nome não vazio
    """

    id: int
    nome: str

    def __post_init__(self):
        if not self.nome or not self.nome.strip():
            raise ValueError("Nome do intérprete não pode ser vazio")


@dataclass(slots=True)
class Musica:
    """Music track.

    Agregate: No (part of Title aggregate)
    Invariant: Tempo opcional (>= 0 se informado)
    """

    id: int
    nome: str
    tempo: int  # segundos

    def __post_init__(self):
        if self.tempo < 0:
            raise ValueError("Tempo não pode ser negativo")


@dataclass(slots=True)
class CdFisico:
    """Physical CD instance.

    Agregate: No (part of Title aggregate)
    Invariant: Situação válida (Disponível/Locado/Reservado)
    Events: cd_registered, cd_status_changed
    """

    codigo: int
    numcd: str
    codtitulo: int
    situacao: SituacaoCd
    locado: bool
    data_compra: date | None = None
    valor_compra: Decimal | None = None

    def __post_init__(self):
        # Initialize locado based on situacao if needed
        if self.situacao == SituacaoCd.LOCADO:
            object.__setattr__(self, "locado", True)
        elif self.situacao in (SituacaoCd.DISPONIVEL, SituacaoCd.RESERVADO):
            object.__setattr__(self, "locado", False)

    def marcar_locado(self) -> DomainEvent:
        """Mark CD as rented (BR-MIGRAR-029)."""
        if self.situacao != SituacaoCd.DISPONIVEL:
            raise ValueError(f"CD {self.codigo} não está disponível para locação")

        situacao_anterior = self.situacao
        object.__setattr__(self, "situacao", SituacaoCd.LOCADO)
        object.__setattr__(self, "locado", True)

        return cd_status_changed(
            cd_codigo=self.codigo,
            titulo_id=self.codtitulo,
            situacao_anterior=str(situacao_anterior),
            situacao_nova=str(SituacaoCd.LOCADO),
        )

    def marcar_disponivel(self) -> DomainEvent:
        """Mark CD as available (after return)."""
        situacao_anterior = self.situacao
        object.__setattr__(self, "situacao", SituacaoCd.DISPONIVEL)
        object.__setattr__(self, "locado", False)

        return cd_status_changed(
            cd_codigo=self.codigo,
            titulo_id=self.codtitulo,
            situacao_anterior=str(situacao_anterior),
            situacao_nova=str(SituacaoCd.DISPONIVEL),
        )

    def marcar_reservado(self) -> DomainEvent:
        """Mark CD as reserved."""
        if self.situacao != SituacaoCd.DISPONIVEL:
            raise ValueError(f"CD {self.codigo} não está disponível para reserva")

        situacao_anterior = self.situacao
        object.__setattr__(self, "situacao", SituacaoCd.RESERVADO)

        return cd_status_changed(
            cd_codigo=self.codigo,
            titulo_id=self.codtitulo,
            situacao_anterior=str(situacao_anterior),
            situacao_nova=str(SituacaoCd.RESERVADO),
        )


@dataclass(slots=True)
class Title:
    """Music title/album (aggregate root).

    Agregate: Yes (root aggregate)
    Invariant: qtde >= cd_count
    Events: title_created, stock_updated

    BR-MIGRAR-017: Quantidade por título deve ser validada.
    BR-MIGRAR-018: Valor por locação definido.
    BR-MIGRAR-019: Tipo de locação 24h/48h.
    BR-MIGRAR-020: Classificação opcional (cdgrupo, cdestilo podem ser NULL).
    """

    id: int
    nome: str
    tipo_locacao: TipoLocacao
    valor: Decimal
    qtde: int
    cdgrupo: int | None
    cdestilo: int | None
    cds: list[CdFisico]
    musicas: list[Musica]
    interpretes: list[Interprete]

    def __post_init__(self):
        # Validate qtde vs actual CD count (BR-MIGRAR-017)
        if len(self.cds) > self.qtde:
            raise ValueError(
                f"Quantidade de CDs ({len(self.cds)}) excede qtde definida ({self.qtde})"
            )

    @classmethod
    def create(
        cls,
        nome: str,
        tipo_locacao: TipoLocacao,
        valor: Decimal,
        qtde: int,
        cdgrupo: int | None = None,
        cdestilo: int | None = None,
    ) -> tuple[Title, DomainEvent]:
        """Create a new title."""
        title = cls(
            id=0,  # Will be set by repository
            nome=nome,
            tipo_locacao=tipo_locacao,
            valor=valor,
            qtde=qtde,
            cdgrupo=cdgrupo,
            cdestilo=cdestilo,
            cds=[],
            musicas=[],
            interpretes=[],
        )

        event = title_created(
            titulo_id=title.id,
            nome=nome,
            tipo_locacao=str(tipo_locacao),
            valor=valor,
        )

        return title, event

    def adicionar_cd(
        self, cd: CdFisico
    ) -> DomainEvent | None:
        """Add a physical CD to this title."""
        if len(self.cds) >= self.qtde:
            raise ValueError(
                f"Não é possível adicionar mais CDs. Limite: {self.qtde}"
            )

        if cd.codtitulo != self.id:
            raise ValueError("CD pertence a outro título")

        self.cds.append(cd)

        # If we reached qtde, emit StockUpdated event
        if len(self.cds) == self.qtde:
            return StockUpdated(
                titulo_id=self.id,
                qtde_anterior=len(self.cds) - 1,
                qtde_nova=len(self.cds),
            )
        return None

    def atualizar_estoque(self, nova_qtde: int) -> DomainEvent:
        """Update stock quantity (BR-MIGRAR-017)."""
        if nova_qtde < len(self.cds):
            raise ValueError(
                f"Nova quantidade ({nova_qtde}) é menor que CDs existentes ({len(self.cds)})"
            )

        qtde_anterior = self.qtde
        object.__setattr__(self, "qtde", nova_qtde)

        return stock_updated(
            titulo_id=self.id,
            qtde_anterior=qtde_anterior,
            qtde_nova=nova_qtde,
        )

    def adicionar_musica(self, musica: Musica) -> None:
        """Add a music track."""
        self.musicas.append(musica)

    def remover_musica(self, musica_id: int) -> None:
        """Remove a music track."""
        self.musicas = [m for m in self.musicas if m.id != musica_id]

    def adicionar_interprete(self, interprete: Interprete) -> None:
        """Add an interpreter/artist."""
        self.interpretes.append(interprete)

    def remover_interprete(self, interprete_id: int) -> None:
        """Remove an interpreter/artist."""
        self.interpretes = [i for i in self.interpretes if i.id != interprete_id]

    @property
    def cd_count(self) -> int:
        """Return number of physical CDs."""
        return len(self.cds)

    @property
    def cds_disponiveis(self) -> list[CdFisico]:
        """Return available CDs."""
        return [cd for cd in self.cds if cd.situacao == SituacaoCd.DISPONIVEL]
