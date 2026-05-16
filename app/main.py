"""CDsLoc Main Application Entry Point."""

from contextlib import asynccontextmanager
from typing import AsyncGenerator

from fastapi import FastAPI
from fastapi.middleware.cors import CORSMiddleware
from sqlalchemy import text

from app.shared.infrastructure.config import get_settings
from app.adapters.db.base import engine, Base


@asynccontextmanager
async def lifespan(app: FastAPI) -> AsyncGenerator[None, None]:
    """Application lifespan manager."""
    # Startup
    settings = get_settings()
    print(f"Starting {settings.app_name} v{settings.app_version}")

    # Test database connection and create tables
    try:
        async with engine.connect() as conn:
            await conn.execute(text("SELECT 1"))

        # Create all tables if they don't exist
        async with engine.begin() as conn:
            await conn.run_sync(Base.metadata.create_all)

        print("✓ Database connected and tables created/verified")
    except Exception as e:
        print(f"✗ Database connection/setup failed: {e}")

    yield

    # Shutdown
    try:
        await engine.dispose()
        print(f"Shutting down {settings.app_name}")
    except Exception as e:
        print(f"Error during shutdown: {e}")


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

    # Include routers
    try:
        from app.adapters.api.routers import (
            catalog_router,
            customers_router,
            dashboard_router,
            rentals_router,
            reservations_router,
            reports_router,
        )
        app.include_router(dashboard_router, tags=["dashboard"])
        app.include_router(catalog_router, tags=["catalog"])
        app.include_router(customers_router, tags=["customers"])
        app.include_router(rentals_router, tags=["rentals"])
        app.include_router(reservations_router, tags=["reservations"])
        app.include_router(reports_router, tags=["reports"])
        print("✓ Routers registered successfully")
    except Exception as e:
        print(f"✗ Error registering routers: {e}")
        import traceback
        traceback.print_exc()

    return app


app = create_app()
