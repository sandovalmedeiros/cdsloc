"""Catalog application service.

Implements use cases for catalog bounded context.
"""

from __future__ import annotations

from decimal import Decimal
from typing import Iterable

from app.bounded_contexts.catalog.domain.entities import (
    CdFisico,
    Interprete,
    Musica,
    SituacaoCd,
    Title,
    TipoLocacao,
)
from app.bounded_contexts.catalog.ports.repositories import (
    CdFisicoRepositoryPort,
    InterpreteRepositoryPort,
    MusicaRepositoryPort,
    TitleRepositoryPort,
)
from app.shared.domain.events import DomainEvent


class CatalogService:
    """Application service for catalog operations."""

    def __init__(
        self,
        title_repo: TitleRepositoryPort,
        cd_repo: CdFisicoRepositoryPort,
        musica_repo: MusicaRepositoryPort,
        interprete_repo: InterpreteRepositoryPort,
    ) -> None:
        self._title_repo = title_repo
        self._cd_repo = cd_repo
        self._musica_repo = musica_repo
        self._interprete_repo = interprete_repo

    # Title operations

    async def create_title(
        self,
        nome: str,
        tipo_locacao: TipoLocacao,
        valor: Decimal,
        qtde: int,
        cdgrupo: int | None = None,
        cdestilo: int | None = None,
    ) -> tuple[Title, DomainEvent]:
        """Create a new title (BR-MIGRAR-018, BR-MIGRAR-019, BR-MIGRAR-020)."""
        title, event = Title.create(
            nome=nome,
            tipo_locacao=tipo_locacao,
            valor=valor,
            qtde=qtde,
            cdgrupo=cdgrupo,
            cdestilo=cdestilo,
        )
        saved_event = await self._title_repo.save(title)
        return title, saved_event or event

    async def update_title(
        self,
        title_id: int,
        nome: str | None = None,
        tipo_locacao: TipoLocacao | None = None,
        valor: Decimal | None = None,
        qtde: int | None = None,
        cdgrupo: int | None = None,
        cdestilo: int | None = None,
    ) -> tuple[Title, list[DomainEvent]]:
        """Update an existing title."""
        title = await self._title_repo.get_by_id(title_id)
        if not title:
            raise ValueError(f"Título {title_id} não encontrado")

        events: list[DomainEvent] = []

        if nome is not None:
            object.__setattr__(title, "nome", nome)
        if tipo_locacao is not None:
            object.__setattr__(title, "tipo_locacao", tipo_locacao)
        if valor is not None:
            object.__setattr__(title, "valor", valor)
        if cdgrupo is not None:
            object.__setattr__(title, "cdgrupo", cdgrupo)
        if cdestilo is not None:
            object.__setattr__(title, "cdestilo", cdestilo)
        if qtde is not None and qtde != title.qtde:
            events.append(title.atualizar_estoque(qtde))

        saved_events = await self._title_repo.update(title)
        return title, events + saved_events

    async def get_title(self, title_id: int) -> Title | None:
        """Get title by ID."""
        return await self._title_repo.get_by_id(title_id)

    async def list_titles(
        self, skip: int = 0, limit: int = 100
    ) -> Iterable[Title]:
        """List all titles with pagination."""
        return await self._title_repo.get_all(skip=skip, limit=limit)

    async def search_titles(self, name: str) -> Iterable[Title]:
        """Search titles by name."""
        return await self._title_repo.search_by_name(name)

    async def delete_title(self, title_id: int) -> None:
        """Delete title by ID."""
        await self._title_repo.delete(title_id)

    # CD operations

    async def register_cd(
        self,
        numcd: str,
        title_id: int,
        data_compra: str | None = None,
        valor_compra: Decimal | None = None,
    ) -> tuple[CdFisico, DomainEvent]:
        """Register a new physical CD."""
        title = await self._title_repo.get_by_id(title_id)
        if not title:
            raise ValueError(f"Título {title_id} não encontrado")

        # Validate stock (BR-MIGRAR-017)
        cd_count = await self._cd_repo.count_by_title(title_id)
        if cd_count >= title.qtde:
            raise ValueError(
                f"Limite de CDs ({title.qtde}) atingido para título {title_id}"
            )

        cd = CdFisico(
            codigo=0,  # Will be set by repository
            numcd=numcd,
            codtitulo=title_id,
            situacao=SituacaoCd.DISPONIVEL,
            locado=False,
            data_compra=None,
            valor_compra=None,
        )

        event = await self._cd_repo.save(cd)
        return cd, event

    async def get_cd(self, cd_codigo: int) -> CdFisico | None:
        """Get CD by codigo."""
        return await self._cd_repo.get_by_codigo(cd_codigo)

    async def get_cds_by_title(
        self, title_id: int
    ) -> Iterable[CdFisico]:
        """Get all CDs for a title."""
        return await self._cd_repo.get_by_title_id(title_id)

    async def get_available_cds(
        self, title_id: int
    ) -> Iterable[CdFisico]:
        """Get available CDs for a title (for rental)."""
        return await self._title_repo.get_available_cds(title_id)

    async def mark_cd_rented(self, cd_codigo: int) -> DomainEvent:
        """Mark CD as rented (atomic operation - BR-MIGRAR-029)."""
        cd = await self._cd_repo.get_by_codigo(cd_codigo)
        if not cd:
            raise ValueError(f"CD {cd_codigo} não encontrado")

        if cd.situacao != SituacaoCd.DISPONIVEL:
            raise ValueError(f"CD {cd_codigo} não está disponível para locação")

        event = cd.marcar_locado()
        await self._cd_repo.update(cd)
        return event

    async def mark_cd_available(self, cd_codigo: int) -> DomainEvent:
        """Mark CD as available (after return)."""
        cd = await self._cd_repo.get_by_codigo(cd_codigo)
        if not cd:
            raise ValueError(f"CD {cd_codigo} não encontrado")

        event = cd.marcar_disponivel()
        await self._cd_repo.update(cd)
        return event

    async def mark_cd_reserved(self, cd_codigo: int) -> DomainEvent:
        """Mark CD as reserved."""
        cd = await self._cd_repo.get_by_codigo(cd_codigo)
        if not cd:
            raise ValueError(f"CD {cd_codigo} não encontrado")

        if cd.situacao != SituacaoCd.DISPONIVEL:
            raise ValueError(f"CD {cd_codigo} não está disponível para reserva")

        event = cd.marcar_reservado()
        await self._cd_repo.update(cd)
        return event

    async def delete_cd(self, cd_codigo: int) -> None:
        """Delete CD by codigo."""
        await self._cd_repo.delete(cd_codigo)

    # Music operations

    async def create_music(
        self,
        nome: str,
        tempo: int,
        title_id: int,
    ) -> Musica:
        """Create a new music track."""
        musica = Musica(id=0, nome=nome, tempo=tempo)
        await self._musica_repo.save(musica)
        await self._musica_repo.add_to_title(title_id, musica.id)
        return musica

    async def add_music_to_title(
        self, musica_id: int, title_id: int
    ) -> None:
        """Add existing music to a title."""
        await self._musica_repo.add_to_title(title_id, musica_id)

    async def remove_music_from_title(
        self, musica_id: int, title_id: int
    ) -> None:
        """Remove music from a title."""
        await self._musica_repo.remove_from_title(title_id, musica_id)

    async def get_music_by_title(
        self, title_id: int
    ) -> Iterable[Musica]:
        """Get all music tracks for a title."""
        return await self._musica_repo.get_by_title_id(title_id)

    # Interpreter operations

    async def create_interpreter(self, nome: str) -> Interprete:
        """Create a new interpreter."""
        interprete = Interprete(id=0, nome=nome)
        await self._interprete_repo.save(interprete)
        return interprete

    async def list_interpreters(
        self, skip: int = 0, limit: int = 100
    ) -> Iterable[Interprete]:
        """List all interpreters with pagination."""
        return await self._interprete_repo.get_all(skip=skip, limit=limit)

    async def search_interpreters(self, name: str) -> Iterable[Interprete]:
        """Search interpreters by name."""
        return await self._interprete_repo.search_by_name(name)

    async def add_interpreter_to_title(
        self, interprete_id: int, title_id: int
    ) -> None:
        """Add interpreter to a title."""
        await self._interprete_repo.add_to_title(title_id, interprete_id)

    async def remove_interpreter_from_title(
        self, interprete_id: int, title_id: int
    ) -> None:
        """Remove interpreter from a title."""
        await self._interprete_repo.remove_from_title(
            title_id, interprete_id
        )
