"""FastAPI router for Catalog bounded context.

Endpoints for titles, CDs, music tracks, and interpreters.
"""

from __future__ import annotations

from typing import AsyncIterable, Iterable

from fastapi import APIRouter, Depends, HTTPException, Query, status
from sqlalchemy import select
from sqlalchemy.ext.asyncio import AsyncSession

from app.adapters.api.schemas.catalog import (
    CdCreate,
    CdResponse,
    CdUpdate,
    InterpreteCreate,
    InterpreteResponse,
    MusicaCreate,
    MusicaResponse,
    TitleCreate,
    TitleResponse,
    TitleUpdate,
)
from app.bounded_contexts.catalog.ports.repositories import (
    CdFisicoRepositoryPort,
    InterpreteRepositoryPort,
    MusicaRepositoryPort,
    TitleRepositoryPort,
)


async def get_db_session():
    """Dependency injection for AsyncSession."""
    from app.adapters.db.base import get_db
    async for session in get_db():
        yield session


router = APIRouter(prefix="/catalog", tags=["catalog"])


def map_situacao_to_enum(situacao):
    """Map SituacaoCd domain enum to API enum."""
    from app.bounded_contexts.catalog.domain.entities import SituacaoCd
    from app.adapters.api.schemas.catalog import SituacaoCdEnum

    if situacao == SituacaoCd.DISPONIVEL:
        return SituacaoCdEnum.DISPONIVEL
    elif situacao == SituacaoCd.LOCADO:
        return SituacaoCdEnum.LOCADO
    elif situacao == SituacaoCd.RESERVADO:
        return SituacaoCdEnum.RESERVADO
    return SituacaoCdEnum.DISPONIVEL  # Default


async def get_title_repo() -> AsyncIterable[TitleRepositoryPort]:
    """Dependency injection for TitleRepositoryPort."""
    from app.adapters.db.repositories.catalog_repository import PostgresTitleRepository
    from app.adapters.db.base import get_db

    async for db in get_db():
        yield PostgresTitleRepository(db)


async def get_cd_repo() -> AsyncIterable[CdFisicoRepositoryPort]:
    """Dependency injection for CdFisicoRepositoryPort."""
    from app.adapters.db.repositories.catalog_repository import PostgresCdFisicoRepository
    from app.adapters.db.base import get_db

    async for db in get_db():
        yield PostgresCdFisicoRepository(db)


async def get_musica_repo() -> AsyncIterable[MusicaRepositoryPort]:
    """Dependency injection for MusicaRepositoryPort."""
    from app.adapters.db.repositories.catalog_repository import PostgresMusicaRepository
    from app.adapters.db.base import get_db

    async for db in get_db():
        yield PostgresMusicaRepository(db)


async def get_interprete_repo() -> AsyncIterable[InterpreteRepositoryPort]:
    """Dependency injection for InterpreteRepositoryPort."""
    from app.adapters.db.repositories.catalog_repository import PostgresInterpreteRepository
    from app.adapters.db.base import get_db

    async for db in get_db():
        yield PostgresInterpreteRepository(db)


# Title endpoints


@router.post("/titulos", response_model=TitleResponse, status_code=status.HTTP_201_CREATED)
async def create_title(
    data: TitleCreate,
    title_repo: TitleRepositoryPort = Depends(get_title_repo),
):
    """Create a new title."""
    from app.bounded_contexts.catalog.domain.entities import TipoLocacao, Title

    # Convert Pydantic enum to domain enum
    tipo_locacao = TipoLocacao(data.tipo_locacao.value)

    # Create title using domain entity factory
    title, event = Title.create(
        nome=data.nome,
        tipo_locacao=tipo_locacao,
        valor=data.valor,
        qtde=data.qtde,
        cdgrupo=data.id_grupo,
        cdestilo=data.id_estilo,
    )

    # Save
    await title_repo.save(title)

    return TitleResponse.model_validate(title)


@router.get("/titulos/{title_id}", response_model=TitleResponse)
async def get_title(
    title_id: int,
    title_repo: TitleRepositoryPort = Depends(get_title_repo),
):
    """Get a title by ID."""
    title = await title_repo.get_by_id(title_id)
    if not title:
        raise HTTPException(
            status_code=status.HTTP_404_NOT_FOUND,
            detail=f"Título {title_id} não encontrado",
        )

    return TitleResponse.model_validate(title)


@router.get("/titulos", response_model=list[TitleResponse])
async def list_titles(
    skip: int = Query(0, ge=0),
    limit: int = Query(100, ge=1, le=100),
    search: str | None = Query(None, description="Search by name"),
    title_repo: TitleRepositoryPort = Depends(get_title_repo),
):
    """List all titles with optional search."""
    if search:
        titles = await title_repo.search_by_name(search)
    else:
        titles = [t async for t in title_repo.get_all(skip=skip, limit=limit)]

    return [TitleResponse.model_validate(t) for t in titles]


@router.put("/titulos/{title_id}", response_model=TitleResponse)
async def update_title(
    title_id: int,
    data: TitleUpdate,
    title_repo: TitleRepositoryPort = Depends(get_title_repo),
):
    """Update a title."""
    title = await title_repo.get_by_id(title_id)
    if not title:
        raise HTTPException(
            status_code=status.HTTP_404_NOT_FOUND,
            detail=f"Título {title_id} não encontrado",
        )

    # Update fields if provided
    if data.nome is not None:
        title.nome = data.nome
    if data.tipo_locacao is not None:
        from app.bounded_contexts.catalog.domain.entities import TipoLocacao

        title.tipo_locacao = TipoLocacao(data.tipo_locacao.value)
    if data.valor is not None:
        title.valor = data.valor
    if data.qtde is not None:
        title.qtde = data.qtde
    if data.id_grupo is not None:
        title.cdgrupo = data.id_grupo
    if data.id_estilo is not None:
        title.cdestilo = data.id_estilo

    await title_repo.update(title)

    return TitleResponse.model_validate(title)


@router.delete("/titulos/{title_id}", status_code=status.HTTP_204_NO_CONTENT)
async def delete_title(
    title_id: int,
    title_repo: TitleRepositoryPort = Depends(get_title_repo),
    cd_repo: CdFisicoRepositoryPort = Depends(get_cd_repo),
):
    """Delete a title.

    Validates that no CDs are rented before deletion.
    """
    from sqlalchemy import exc as sqlalchemy_exc

    title = await title_repo.get_by_id(title_id)
    if not title:
        raise HTTPException(
            status_code=status.HTTP_404_NOT_FOUND,
            detail=f"Título {title_id} não encontrado",
        )

    # Check if any CDs are rented
    from app.bounded_contexts.catalog.domain.entities import SituacaoCd

    cds = [cd async for cd in cd_repo.get_by_title_id(title_id)]
    rented_cds = [cd for cd in cds if cd.locado or cd.situacao != SituacaoCd.DISPONIVEL]

    if rented_cds:
        raise HTTPException(
            status_code=status.HTTP_400_BAD_REQUEST,
            detail=f"Não é possível excluir título com CDs locados. CDs locados: {[cd.codigo for cd in rented_cds]}",
        )

    try:
        await title_repo.delete(title_id)
    except sqlalchemy_exc.IntegrityError as e:
        raise HTTPException(
            status_code=status.HTTP_400_BAD_REQUEST,
            detail=f"Não é possível excluir este título devido a relacionamentos existentes. Detalhe: {str(e.orig)}",
        )


# CD endpoints


@router.post("/cds", response_model=CdResponse, status_code=status.HTTP_201_CREATED)
async def create_cd(
    data: CdCreate,
    cd_repo: CdFisicoRepositoryPort = Depends(get_cd_repo),
):
    """Create a new physical CD."""
    from app.bounded_contexts.catalog.domain.entities import CdFisico, SituacaoCd

    # Create CD entity
    cd = CdFisico(
        codigo=0,  # Will be set by repository
        numcd=data.numcd,
        codtitulo=data.id_titulo,
        locado=False,
        situacao=SituacaoCd.DISPONIVEL,
        data_compra=data.data_compra,
        valor_compra=data.valor_compra,
    )

    # Save
    event = await cd_repo.save(cd)

    from app.adapters.api.schemas.catalog import SituacaoCdEnum

    return CdResponse(
        codigo=str(cd.codigo),
        numcd=cd.numcd,
        id_titulo=cd.codtitulo,
        situacao=SituacaoCdEnum.DISPONIVEL,
        is_locado=cd.locado,
        data_compra=cd.data_compra,
        valor_compra=cd.valor_compra,
    )


@router.get("/cds/{cd_codigo}", response_model=CdResponse)
async def get_cd(
    cd_codigo: str,
    cd_repo: CdFisicoRepositoryPort = Depends(get_cd_repo),
):
    """Get a CD by code."""
    cd = await cd_repo.get_by_codigo(int(cd_codigo))
    if not cd:
        raise HTTPException(
            status_code=status.HTTP_404_NOT_FOUND,
            detail=f"CD {cd_codigo} não encontrado",
        )

    from app.adapters.api.schemas.catalog import SituacaoCdEnum

    return CdResponse(
        codigo=str(cd.codigo),
        numcd=cd.numcd,
        id_titulo=cd.codtitulo,
        situacao=SituacaoCdEnum.DISPONIVEL,
        is_locado=cd.locado,
        data_compra=cd.data_compra,
        valor_compra=cd.valor_compra,
    )


@router.get("/cds", response_model=list[CdResponse])
async def list_cds(
    skip: int = Query(0, ge=0),
    limit: int = Query(100, ge=1, le=100),
    cd_repo: CdFisicoRepositoryPort = Depends(get_cd_repo),
):
    """List all physical CDs with pagination."""
    cds = [c async for c in cd_repo.get_all(skip=skip, limit=limit)]

    return [
        CdResponse(
            codigo=str(cd.codigo),
            numcd=cd.numcd,
            id_titulo=cd.codtitulo,
            situacao=map_situacao_to_enum(cd.situacao),
            is_locado=cd.locado,
            data_compra=cd.data_compra,
            valor_compra=cd.valor_compra,
        )
        for cd in cds
    ]


@router.get("/titulos/{title_id}/cds", response_model=list[CdResponse])
async def get_title_cds(
    title_id: int,
    cd_repo: CdFisicoRepositoryPort = Depends(get_cd_repo),
):
    """Get all physical CDs for a title."""
    cds = [c async for c in cd_repo.get_by_title_id(title_id)]

    return [
        CdResponse(
            codigo=str(cd.codigo),
            numcd=cd.numcd,
            id_titulo=cd.codtitulo,
            situacao=map_situacao_to_enum(cd.situacao),
            is_locado=cd.locado,
            data_compra=cd.data_compra,
            valor_compra=cd.valor_compra,
        )
        for cd in cds
    ]


# Music and Interpreter endpoints (simplified)


@router.post("/titulos/{title_id}/musicas", status_code=status.HTTP_201_CREATED)
async def add_music_to_title(
    title_id: int,
    data: MusicaCreate,
    musica_repo: MusicaRepositoryPort = Depends(get_musica_repo),
    session: AsyncSession = Depends(get_db_session),
):
    """Add a music track to a title.

    If music already exists (by name), reuses it. Otherwise creates new.
    """
    from app.bounded_contexts.catalog.domain.entities import Musica
    from app.adapters.db.models import Musica as MusicaModel
    from sqlalchemy import select

    # Check if music already exists by name
    result = await session.execute(
        select(MusicaModel).where(MusicaModel.nome == data.nome)
    )
    existing_model = result.scalar_one_or_none()

    if existing_model:
        # Music exists, just associate with title
        musica_id = existing_model.id
    else:
        # Create new music entity
        musica = Musica(
            id=0,
            nome=data.nome,
            tempo=data.tempo or 0,
        )

        # Save music first to get ID
        await musica_repo.save(musica)
        musica_id = musica.id

    # Then associate with title
    await musica_repo.add_to_title(title_id, musica_id)

    return {"message": "Música adicionada ao título", "id": musica_id, "nome": data.nome}


@router.post("/titulos/{title_id}/interpretes", status_code=status.HTTP_201_CREATED)
async def add_interprete_to_title(
    title_id: int,
    data: InterpreteCreate,
    interprete_repo: InterpreteRepositoryPort = Depends(get_interprete_repo),
    session: AsyncSession = Depends(get_db_session),
):
    """Add an interpreter to a title.

    If interpreter already exists (by name), reuses it. Otherwise creates new.
    """
    from app.bounded_contexts.catalog.domain.entities import Interprete
    from app.adapters.db.models import Interprete as InterpreteModel
    from sqlalchemy import select

    # Check if interpreter already exists by name
    result = await session.execute(
        select(InterpreteModel).where(InterpreteModel.nome == data.nome)
    )
    existing_model = result.scalar_one_or_none()

    if existing_model:
        # Interpreter exists, just associate with title
        interprete_id = existing_model.id
    else:
        # Create new interpreter entity
        interprete = Interprete(
            id=0,
            nome=data.nome,
        )

        # Save interpreter first to get ID
        await interprete_repo.save(interprete)
        interprete_id = interprete.id

    # Then associate with title
    await interprete_repo.add_to_title(title_id, interprete_id)

    return {"message": "Intérprete adicionado ao título", "id": interprete_id, "nome": data.nome}


@router.get("/titulos/{title_id}/musicas", response_model=list[MusicaResponse])
async def get_title_musicas(
    title_id: int,
    musica_repo: MusicaRepositoryPort = Depends(get_musica_repo),
):
    """Get all music tracks for a title."""
    musicas = [m async for m in musica_repo.get_by_title_id(title_id)]
    return musicas


@router.delete("/titulos/{title_id}/musicas/{musica_id}", status_code=status.HTTP_204_NO_CONTENT)
async def remove_music_from_title(
    title_id: int,
    musica_id: int,
    musica_repo: MusicaRepositoryPort = Depends(get_musica_repo),
):
    """Remove a music track from a title."""
    await musica_repo.remove_from_title(title_id, musica_id)
    await musica_repo.delete(musica_id)


@router.get("/titulos/{title_id}/interpretes", response_model=list[InterpreteResponse])
async def get_title_interpretes(
    title_id: int,
    interprete_repo: InterpreteRepositoryPort = Depends(get_interprete_repo),
    session: AsyncSession = Depends(get_db_session),
):
    """Get all interpreters for a title."""
    from app.adapters.db.models import TituloInterprete

    # Get interprete IDs for this title
    result = await session.execute(
        select(TituloInterprete).where(TituloInterprete.id_titulo == title_id)
    )
    titulo_interpretes = result.scalars().all()

    # Get unique interpretes
    interprete_ids = [ti.id_interprete for ti in titulo_interpretes]

    # Get all interpretes and filter by ids
    interpretes = [i async for i in interprete_repo.get_all(limit=1000)]
    return [i for i in interpretes if i.id in interprete_ids]


@router.delete("/titulos/{title_id}/interpretes/{interprete_id}", status_code=status.HTTP_204_NO_CONTENT)
async def remove_interprete_from_title(
    title_id: int,
    interprete_id: int,
    interprete_repo: InterpreteRepositoryPort = Depends(get_interprete_repo),
):
    """Remove an interpreter from a title."""
    await interprete_repo.remove_from_title(title_id, interprete_id)
