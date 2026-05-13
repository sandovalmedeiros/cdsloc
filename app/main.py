"""CDsLoc Main Application Entry Point."""

from contextlib import asynccontextmanager
from typing import AsyncGenerator

from fastapi import FastAPI
from fastapi.middleware.cors import CORSMiddleware

from app.shared.infrastructure.config import get_settings


@asynccontextmanager
async def lifespan(app: FastAPI) -> AsyncGenerator[None, None]:
    """Application lifespan manager."""
    # Startup
    settings = get_settings()
    print(f"Starting {settings.app_name} v{settings.app_version}")
    yield
    # Shutdown
    print(f"Shutting down {settings.app_name}")


def create_app() -> FastAPI:
    """Create and configure FastAPI application."""
    settings = get_settings()

    app = FastAPI(
        title=settings.app_name,
        version=settings.app_version,
        description="Sistema de Locação de CDs - Migrado de VB6/Access",
        lifespan=lifespan,
    )

    # CORS middleware
    app.add_middleware(
        CORSMiddleware,
        allow_origins=settings.cors_origins,
        allow_credentials=True,
        allow_methods=["*"],
        allow_headers=["*"],
    )

    # Health check endpoint
    @app.get("/health")
    async def health_check() -> dict:
        return {"status": "healthy", "version": settings.app_version}

    # Include routers (will be added in future tasks)
    # app.include_router(auth_router, prefix="/api/v1/auth", tags=["auth"])
    # app.include_router(catalog_router, prefix="/api/v1/catalog", tags=["catalog"])
    # app.include_router(customers_router, prefix="/api/v1/customers", tags=["customers"])
    # app.include_router(rentals_router, prefix="/api/v1/rentals", tags=["rentals"])
    # app.include_router(reservations_router, prefix="/api/v1/reservations", tags=["reservations"])
    # app.include_router(reports_router, prefix="/api/v1/reports", tags=["reports"])

    return app


app = create_app()
