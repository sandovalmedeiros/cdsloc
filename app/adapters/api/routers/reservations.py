"""FastAPI router for Reservations bounded context.

Endpoints for reservations.
"""

from __future__ import annotations

from typing import AsyncIterable

from fastapi import APIRouter, Depends, HTTPException, Query, status

from app.adapters.api.schemas.reservations import (
    ReservaCreate,
    ReservaResponse,
    ReservaUpdate,
)
from app.bounded_contexts.customers.ports.repositories import CustomerRepositoryPort
from app.bounded_contexts.reservations.ports.repositories import ReservationRepositoryPort
from app.bounded_contexts.reservations.services.reservation_service import ReservationService

router = APIRouter(prefix="/reservas", tags=["reservations"])


async def get_reservation_repo() -> AsyncIterable[ReservationRepositoryPort]:
    """Dependency injection for ReservationRepositoryPort."""
    from app.adapters.db.repositories.reservations_repository import PostgresReservationRepository
    from app.adapters.db.base import get_db_no_context

    async for db in get_db_no_context:
        yield PostgresReservationRepository(db)


async def get_customer_repo() -> AsyncIterable[CustomerRepositoryPort]:
    """Dependency injection for CustomerRepositoryPort."""
    from app.adapters.db.repositories.customers_repository import PostgresCustomerRepository
    from app.adapters.db.base import get_db_no_context

    async for db in get_db_no_context:
        yield PostgresCustomerRepository(db)


async def get_title_repo() -> AsyncIterable:
    """Dependency injection for TitleRepositoryPort."""
    from app.adapters.db.repositories.catalog_repository import PostgresTitleRepository
    from app.adapters.db.base import get_db_no_context

    async for db in get_db_no_context:
        yield PostgresTitleRepository(db)


async def get_reservation_service(
    reservation_repo: ReservationRepositoryPort = Depends(get_reservation_repo),
    customer_repo: CustomerRepositoryPort = Depends(get_customer_repo),
    title_repo = Depends(get_title_repo),
) -> ReservationService:
    """Dependency injection for ReservationService."""
    return ReservationService(
        reservation_repo=reservation_repo,
        customer_repo=customer_repo,
        title_repo=title_repo,
    )


# Reservation endpoints


@router.post("", response_model=ReservaResponse, status_code=status.HTTP_201_CREATED)
async def create_reservation(
    data: ReservaCreate,
    service: ReservationService = Depends(get_reservation_service),
):
    """Create a new reservation.

    RESV-001: Reserva exige cliente ativo.
    RESV-004: Bloqueio de reserva duplicada.
    """
    reserva, events = await service.create_reservation(
        codcliente=data.id_cliente,
        codtitulo=data.id_titulo,
    )

    return ReservaResponse(
        id=reserva.codreserva,
        id_cliente=reserva.codcliente,
        id_titulo=reserva.codtitulo,
        data_reserva=reserva.data_reserva,
        data_prevista=reserva.data_prevista,
        situacao=ReservaResponse.model_fields["situacao"].default,
    )


@router.get("/{reserva_id}", response_model=ReservaResponse)
async def get_reservation(
    reserva_id: int,
    service: ReservationService = Depends(get_reservation_service),
):
    """Get a reservation by ID."""
    reserva = await service.get_reservation(reserva_id)
    if not reserva:
        raise HTTPException(
            status_code=status.HTTP_404_NOT_FOUND,
            detail=f"Reserva {reserva_id} não encontrada",
        )

    return ReservaResponse(
        id=reserva.codreserva,
        id_cliente=reserva.codcliente,
        id_titulo=reserva.codtitulo,
        data_reserva=reserva.data_reserva,
        data_prevista=reserva.data_prevista,
        situacao=ReservaResponse.model_fields["situacao"].default,
    )


@router.get("", response_model=list[ReservaResponse])
async def list_reservations(
    skip: int = Query(0, ge=0),
    limit: int = Query(100, ge=1, le=100),
    service: ReservationService = Depends(get_reservation_service),
):
    """List all reservations with pagination."""
    reservas = await service.list_reservations(skip=skip, limit=limit)

    return [
        ReservaResponse(
            id=res.codreserva,
            id_cliente=res.codcliente,
            id_titulo=res.codtitulo,
            data_reserva=res.data_reserva,
            data_prevista=res.data_prevista,
            situacao=ReservaResponse.model_fields["situacao"].default,
        )
        for res in reservas
    ]


@router.get("/clientes/{customer_id}", response_model=list[ReservaResponse])
async def list_customer_reservations(
    customer_id: int,
    service: ReservationService = Depends(get_reservation_service),
):
    """List all reservations for a customer."""
    reservas = await service.list_pending_by_customer(customer_id)

    return [
        ReservaResponse(
            id=res.codreserva,
            id_cliente=res.codcliente,
            id_titulo=res.codtitulo,
            data_reserva=res.data_reserva,
            data_prevista=res.data_prevista,
            situacao=ReservaResponse.model_fields["situacao"].default,
        )
        for res in reservas
    ]


@router.post("/{reserva_id}/confirmar", response_model=ReservaResponse)
async def confirm_reservation(
    reserva_id: int,
    service: ReservationService = Depends(get_reservation_service),
):
    """Confirm a reservation (convert to rental).

    RESV-005: Ao converter reserva em locação, situação marcada como "Confirmada".
    """
    reserva, event = await service.confirm_reservation(reserva_id)

    return ReservaResponse(
        id=reserva.codreserva,
        id_cliente=reserva.codcliente,
        id_titulo=reserva.codtitulo,
        data_reserva=reserva.data_reserva,
        data_prevista=reserva.data_prevista,
        situacao=ReservaResponse.model_fields["situacao"].default,
    )


@router.post("/{reserva_id}/cancelar", response_model=ReservaResponse)
async def cancel_reservation(
    reserva_id: int,
    service: ReservationService = Depends(get_reservation_service),
):
    """Cancel a reservation."""
    reserva, event = await service.cancel_reservation(reserva_id)

    return ReservaResponse(
        id=reserva.codreserva,
        id_cliente=reserva.codcliente,
        id_titulo=reserva.codtitulo,
        data_reserva=reserva.data_reserva,
        data_prevista=reserva.data_prevista,
        situacao=ReservaResponse.model_fields["situacao"].default,
    )
