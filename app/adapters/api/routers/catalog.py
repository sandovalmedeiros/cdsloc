"""FastAPI router for Catalog bounded context.

Endpoints for titles, CDs, music tracks, and interpreters.
"""

from __future__ import annotations

from typing import AsyncIterable, Iterable

from fastapi import APIRouter, Depends, HTTPException, Query, status

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

router = APIRouter(prefix="/catalog", tags=["catalog"])


async def get_title_repo() -> AsyncIterable[TitleRepositoryPort]:
    """Dependency injection for TitleRepositoryPort."""
    from app.adapters.db.repositories.catalog_repository import PostgresTitleRepository
    from app.adapters.db.base import get_db_no_context

    async for db in get_db_no_context():
        yield PostgresTitleRepository(db)


async def get_cd_repo() -> AsyncIterable[CdFisicoRepositoryPort]:
    """Dependency injection for CdFisicoRepositoryPort."""
    from app.adapters.db.repositories.catalog_repository import PostgresCdRepository
    from app.adapters.db.base import get_db_no_context

    async for db in get_db_no_context:
        yield PostgresCdRepository(db)


async def get_musica_repo() -> AsyncIterable[MusicaRepositoryPort]:
    """Dependency injection for MusicaRepositoryPort."""
    from app.adapters.db.repositories.catalog_repository import PostgresMusicaRepository
    from app.adapters.db.base import get_db_no_context

    async for db in get_db_no_context:
        yield PostgresMusicaRepository(db)


async def get_interprete_repo() -> AsyncIterable[InterpreteRepositoryPort]:
    """Dependency injection for InterpreteRepositoryPort."""
    from app.adapters.db.repositories.catalog_repository import PostgresInterpreteRepository
    from app.adapters.db.base import get_db_no_context

    async for db in get_db_no_context:
        yield PostgresInterpreteRepository(db)


# Title endpoints


@router.post("/titulos", response_model=TitleResponse, status_code=status.HTTP_201_CREATED)
async def create_title(
    data: TitleCreate,
    title_repo: TitleRepositoryPort = Depends(get_title_repo),
):
    """Create a new title."""
    from app.bounded_contexts.catalog.domain.entities import TipoLocacao

    # Convert Pydantic enum to domain enum
    tipo_locacao = TipoLocacao(data.tipo_locacao.value)

    # Create title
    title, event = title_repo.create(
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
):
    """Delete a title."""
    title = await title_repo.get_by_id(title_id)
    if not title:
        raise HTTPException(
            status_code=status.HTTP_404_NOT_FOUND,
            detail=f"Título {title_id} não encontrado",
        )

    await title_repo.delete(title_id)


# CD endpoints


@router.post("/cds", response_model=CdResponse, status_code=status.HTTP_201_CREATED)
async def create_cd(
    data: CdCreate,
    cd_repo: CdFisicoRepositoryPort = Depends(get_cd_repo),
):
    """Create a new physical CD."""
    from app.bounded_contexts.catalog.domain.entities import SituacaoCd

    # Create CD
    cd, event = cd_repo.create(
        codigo=0,  # Will be set by repository
        numcd=data.numcd,
        codtitulo=data.id_titulo,
        situacao=SituacaoCd.DISPONIVEL,
        data_compra=data.data_compra,
        valor_compra=data.valor_compra,
    )

    # Save
    await cd_repo.save(cd)

    return CdResponse(
        codigo=str(cd.codigo),
        numcd=cd.numcd,
        id_titulo=cd.codtitulo,
        situacao=CdResponse.model_fields["situacao"].default,
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

    return CdResponse(
        codigo=str(cd.codigo),
        numcd=cd.numcd,
        id_titulo=cd.codtitulo,
        situacao=CdResponse.model_fields["situacao"].default,
        is_locado=cd.locado,
        data_compra=cd.data_compra,
        valor_compra=cd.valor_compra,
    )


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
            situacao=CdResponse.model_fields["situacao"].default,
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
):
    """Add a music track to a title."""
    from app.bounded_contexts.catalog.domain.entities import Musica

    musica = Musica(
        id=0,
        nome=data.nome,
        tempo=data.tempo or 0,
    )

    await musica_repo.add_to_title(title_id, musica.id)

    return {"message": "Música adicionada ao título"}


@router.post("/titulos/{title_id}/interpretes", status_code=status.HTTP_201_CREATED)
async def add_interprete_to_title(
    title_id: int,
    data: InterpreteCreate,
    interprete_repo: InterpreteRepositoryPort = Depends(get_interprete_repo),
):
    """Add an interpreter to a title."""
    from app.bounded_contexts.catalog.domain.entities import Interprete

    interprete = Interprete(
        id=0,
        nome=data.nome,
    )

    await interprete_repo.add_to_title(title_id, interprete.id)

    return {"message": "Intérprete adicionado ao título"}
