"""FastAPI router for Rentals bounded context.

Endpoints for rentals, returns, and receipts.
"""

from __future__ import annotations

from decimal import Decimal
from typing import AsyncIterable

from fastapi import APIRouter, Depends, HTTPException, Query, status

from app.adapters.api.schemas.rentals import (
    DevolucaoCreate,
    DevolucaoResponse,
    LocacaoCreate,
    LocacaoResponse,
    LocacaoUpdate,
    ReciboResponse,
)
from app.bounded_contexts.customers.ports.repositories import CustomerRepositoryPort
from app.bounded_contexts.rentals.ports.repositories import (
    ReceiptRepositoryPort,
    RentalRepositoryPort,
)
from app.bounded_contexts.rentals.services.rental_service import RentalService

router = APIRouter(prefix="/rentals", tags=["rentals"])


async def get_rental_repo() -> AsyncIterable[RentalRepositoryPort]:
    """Dependency injection for RentalRepositoryPort."""
    from app.adapters.db.repositories.rentals_repository import PostgresRentalRepository
    from app.adapters.db.base import get_db

    async for db in get_db():
        yield PostgresRentalRepository(db)


async def get_receipt_repo() -> AsyncIterable[ReceiptRepositoryPort]:
    """Dependency injection for ReceiptRepositoryPort."""
    from app.adapters.db.repositories.rentals_repository import PostgresReceiptRepository
    from app.adapters.db.base import get_db

    async for db in get_db():
        yield PostgresReceiptRepository(db)


async def get_customer_repo() -> AsyncIterable[CustomerRepositoryPort]:
    """Dependency injection for CustomerRepositoryPort."""
    from app.adapters.db.repositories.customers_repository import PostgresCustomerRepository
    from app.adapters.db.base import get_db

    async for db in get_db():
        yield PostgresCustomerRepository(db)


async def get_cd_repo() -> AsyncIterable:
    """Dependency injection for CdFisicoRepositoryPort."""
    from app.adapters.db.repositories.catalog_repository import PostgresCdFisicoRepository
    from app.adapters.db.base import get_db

    async for db in get_db():
        yield PostgresCdFisicoRepository(db)


async def get_rental_service(
    rental_repo: RentalRepositoryPort = Depends(get_rental_repo),
    receipt_repo: ReceiptRepositoryPort = Depends(get_receipt_repo),
    cd_repo = Depends(get_cd_repo),
    customer_repo: CustomerRepositoryPort = Depends(get_customer_repo),
) -> RentalService:
    """Dependency injection for RentalService."""
    return RentalService(
        rental_repo=rental_repo,
        receipt_repo=receipt_repo,
        cd_repo=cd_repo,
        customer_repo=customer_repo,
    )


# Rental endpoints


@router.post("/locacoes", response_model=LocacaoResponse, status_code=status.HTTP_201_CREATED)
async def create_rental(
    data: LocacaoCreate,
    service: RentalService = Depends(get_rental_service),
):
    """Create a new rental.

    RENT-001: Cliente deve estar ativo.
    RENT-003: Apenas CDs disponíveis podem ser locados.
    BR-MIGRAR-029: Transação atômica.
    """
    locacao, recibo, events = await service.create_rental(
        codcliente=data.id_cliente,
        cd_codigo=data.id_cd,
        coddependente=data.id_dependente,
        data_locacao=data.data_locacao,
    )

    # Return combined response
    return LocacaoResponse(
        id=locacao.codlocacao,
        id_cliente=locacao.codcliente,
        id_dependente=locacao.coddependente,
        data_locacao=locacao.data_locacao,
        data_prevista=locacao.data_prevista,
        valor_locacao=locacao.valor_locacao,
        valor_multa=locacao.valor_multa,
        data_devolucao=locacao.data_devolucao,
        situacao=LocacaoResponse.model_fields["situacao"].default,
        itens=[],
    )


@router.get("/locacoes/{locacao_id}", response_model=LocacaoResponse)
async def get_rental(
    locacao_id: int,
    service: RentalService = Depends(get_rental_service),
):
    """Get a rental by ID."""
    locacao = await service.get_rental(locacao_id)
    if not locacao:
        raise HTTPException(
            status_code=status.HTTP_404_NOT_FOUND,
            detail=f"Locação {locacao_id} não encontrada",
        )

    return LocacaoResponse(
        id=locacao.codlocacao,
        id_cliente=locacao.codcliente,
        id_dependente=locacao.coddependente,
        data_locacao=locacao.data_locacao,
        data_prevista=locacao.data_prevista,
        valor_locacao=locacao.valor_locacao,
        valor_multa=locacao.valor_multa,
        data_devolucao=locacao.data_devolucao,
        situacao=LocacaoResponse.model_fields["situacao"].default,
        itens=[],
    )


@router.get("/locacoes", response_model=list[LocacaoResponse])
async def list_rentals(
    skip: int = Query(0, ge=0),
    limit: int = Query(100, ge=1, le=100),
    service: RentalService = Depends(get_rental_service),
):
    """List all rentals with pagination."""
    locacoes = await service.list_rentals(skip=skip, limit=limit)

    return [
        LocacaoResponse(
            id=loc.codlocacao,
            id_cliente=loc.codcliente,
            id_dependente=loc.coddependente,
            data_locacao=loc.data_locacao,
            data_prevista=loc.data_prevista,
            valor_locacao=loc.valor_locacao,
            valor_multa=loc.valor_multa,
            data_devolucao=loc.data_devolucao,
            situacao=LocacaoResponse.model_fields["situacao"].default,
            itens=[],
        )
        for loc in locacoes
    ]


@router.get("/locacoes/pendentes", response_model=list[LocacaoResponse])
async def list_pending_rentals(
    service: RentalService = Depends(get_rental_service),
):
    """List all pending rentals (not returned)."""
    locacoes = await service.get_pending_rentals()

    return [
        LocacaoResponse(
            id=loc.codlocacao,
            id_cliente=loc.codcliente,
            id_dependente=loc.coddependente,
            data_locacao=loc.data_locacao,
            data_prevista=loc.data_prevista,
            valor_locacao=loc.valor_locacao,
            valor_multa=loc.valor_multa,
            data_devolucao=loc.data_devolucao,
            situacao=LocacaoResponse.model_fields["situacao"].default,
            itens=[],
        )
        for loc in locacoes
    ]


@router.post("/locacoes/{locacao_id}/devolucao", response_model=DevolucaoResponse)
async def register_return(
    locacao_id: int,
    data: DevolucaoCreate,
    service: RentalService = Depends(get_rental_service),
):
    """Register a return (devolução) for a rental.

    BR-MIGRAR-032: Cálculo de dias de atraso.
    BR-MIGRAR-033: Cálculo de multa.
    """
    locacao, events = await service.return_rental(
        codlocacao=locacao_id,
        data_devolucao=data.data_devolucao,
    )

    # Calculate days overdue
    from app.shared.domain.value_objects import DiasAtraso

    dias_atraso_vo = DiasAtraso.calculate(
        data_atual=data.data_devolucao,
        data_prevista=locacao.data_prevista,
    )

    return DevolucaoResponse(
        locacao=LocacaoResponse(
            id=locacao.codlocacao,
            id_cliente=locacao.codcliente,
            id_dependente=locacao.coddependente,
            data_locacao=locacao.data_locacao,
            data_prevista=locacao.data_prevista,
            valor_locacao=locacao.valor_locacao,
            valor_multa=locacao.valor_multa,
            data_devolucao=locacao.data_devolucao,
            situacao=LocacaoResponse.model_fields["situacao"].default,
            itens=[],
        ),
        dias_atraso=dias_atraso_vo.valor,
        valor_multa=locacao.valor_multa,
        valor_total=locacao.valor_locacao + locacao.valor_multa,
    )


# Receipt endpoints


@router.get("/recibos/{recibo_id}", response_model=ReciboResponse)
async def get_receipt(
    recibo_id: int,
    service: RentalService = Depends(get_rental_service),
):
    """Get a receipt by ID."""
    recibo = await service.get_receipt(recibo_id)
    if not recibo:
        raise HTTPException(
            status_code=status.HTTP_404_NOT_FOUND,
            detail=f"Recibo {recibo_id} não encontrado",
        )

    return ReciboResponse(
        id=recibo.codrecibo,
        id_locacao=recibo.locacoes[0].codlocacao if recibo.locacoes else 0,
        id_cliente=recibo.codcliente,
        data_emissao=recibo.data_emissao,
        valor_total=recibo.valor_total,
        is_devolvido=recibo.devolvido,
        data_devolucao=None,
    )


@router.get("/clientes/{customer_id}/recibos-pendentes", response_model=list[ReciboResponse])
async def list_pending_receipts(
    customer_id: int,
    service: RentalService = Depends(get_rental_service),
):
    """List all pending receipts for a customer."""
    from app.bounded_contexts.rentals.ports.repositories import ReceiptRepositoryPort

    # Note: This would need a dedicated query in the service
    # For now, return empty list as placeholder
    return []
