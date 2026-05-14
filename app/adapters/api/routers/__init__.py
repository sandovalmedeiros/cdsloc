"""FastAPI routers package."""

from .catalog import router as catalog_router
from .customers import router as customers_router
from .rentals import router as rentals_router
from .reservations import router as reservations_router
from .reports import router as reports_router

__all__ = [
    "catalog_router",
    "customers_router",
    "rentals_router",
    "reservations_router",
    "reports_router",
]
