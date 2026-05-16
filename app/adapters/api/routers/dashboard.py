"""FastAPI router for Dashboard.

Provides statistics and overview data for the system.
"""

from __future__ import annotations

from typing import AsyncIterable

from fastapi import APIRouter, Depends

from app.bounded_contexts.customers.ports.repositories import (
    CustomerRepositoryPort,
)
from app.bounded_contexts.rentals.ports.repositories import RentalRepositoryPort
from app.bounded_contexts.reservations.ports.repositories import (
    ReservationRepositoryPort,
)

router = APIRouter(prefix="/dashboard", tags=["dashboard"])


async def get_customer_repo() -> AsyncIterable[CustomerRepositoryPort]:
    """Dependency injection for CustomerRepositoryPort."""
    from app.adapters.db.repositories.customers_repository import PostgresCustomerRepository
    from app.adapters.db.base import get_db

    async for db in get_db():
        yield PostgresCustomerRepository(db)


async def get_rental_repo() -> AsyncIterable[RentalRepositoryPort]:
    """Dependency injection for RentalRepositoryPort."""
    from app.adapters.db.repositories.rentals_repository import PostgresRentalRepository
    from app.adapters.db.base import get_db

    async for db in get_db():
        yield PostgresRentalRepository(db)


async def get_reservation_repo() -> AsyncIterable[ReservationRepositoryPort]:
    """Dependency injection for ReservationRepositoryPort."""
    from app.adapters.db.repositories.reservations_repository import PostgresReservationRepository
    from app.adapters.db.base import get_db

    async for db in get_db():
        yield PostgresReservationRepository(db)


@router.get("/stats")
async def get_dashboard_stats(
    customer_repo: CustomerRepositoryPort = Depends(get_customer_repo),
    rental_repo: RentalRepositoryPort = Depends(get_rental_repo),
    reservation_repo: ReservationRepositoryPort = Depends(get_reservation_repo),
):
    """Get dashboard statistics."""
    # Get counts
    clientes = await customer_repo.get_all()
    total_clientes = len(clientes)

    # Rental repo returns a list
    locacoes = await rental_repo.get_pending()
    locacoes_pendentes = len(locacoes)

    # Handle reservation repo async generator
    reservas_todas = []
    async for r in reservation_repo.get_all(limit=1000):
        reservas_todas.append(r)
    reservas_pendentes = len([r for r in reservas_todas if r.situacao == "Pendente"])

    # For now, totalCDs is hardcoded as 0 (will be implemented)
    # since we don't have a simple get_all for CDs
    total_cds = 0

    return {
        "totalCDs": total_cds,
        "totalClientes": total_clientes,
        "locacoesAtivas": locacoes_pendentes,
        "reservasPendentes": reservas_pendentes,
    }
