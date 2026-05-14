"""FastAPI application entry point.

Configures API, routers, middleware, and startup/shutdown events.
"""

from contextlib import asynccontextmanager

from fastapi import FastAPI, Request, Response
from fastapi.middleware.cors import CORSMiddleware

from app.adapters.api.middleware import register_exception_handlers
from app.adapters.api.routers import (
    catalog_router,
    customers_router,
    rentals_router,
    reservations_router,
    reports_router,
)


@asynccontextmanager
async def lifespan(app: FastAPI):
    """Manage application lifespan events.

    - Startup: Initialize database connection
    - Shutdown: Close database connection
    """
    # Startup
    from app.adapters.db.base import engine, AsyncSessionLocal

    # Create tables if they don't exist (for development)
    # In production, use Alembic migrations
    async with engine.begin() as conn:
        await conn.run_sync(lambda: None)  # Placeholder for schema creation

    yield

    # Shutdown
    await engine.dispose()


# Create FastAPI application
app = FastAPI(
    title="CDsLoc API",
    description="API REST para sistema de locação de CDs",
    version="1.0.0",
    docs_url="/docs",
    redoc_url="/redoc",
    lifespan=lifespan,
)


# Configure CORS
app.add_middleware(
    CORSMiddleware,
    allow_origins=["*"],  # In production, specify allowed origins
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)


# Register global exception handlers
register_exception_handlers(app)


# Register routers
app.include_router(catalog_router, tags=["catalog"])
app.include_router(customers_router, tags=["customers"])
app.include_router(rentals_router, tags=["rentals"])
app.include_router(reservations_router, tags=["reservations"])
app.include_router(reports_router, tags=["reports"])


# Root endpoint
@app.get("/", tags=["root"])
async def root() -> dict[str, str]:
    """Root endpoint with API information."""
    return {
        "name": "CDsLoc API",
        "version": "1.0.0",
        "description": "API REST para sistema de locação de CDs",
        "docs": "/docs",
    }


# Health check endpoint
@app.get("/health", tags=["health"])
async def health_check() -> dict[str, str]:
    """Health check endpoint."""
    return {"status": "healthy"}


# Request/response logging middleware
@app.middleware("http")
async def log_requests(request: Request, call_next):
    """Log all requests and responses."""
    import logging

    logger = logging.getLogger(__name__)
    logger.info(f"Request: {request.method} {request.url}")

    response = await call_next(request)

    logger.info(f"Response: {response.status_code}")

    return response


if __name__ == "__main__":
    import uvicorn

    uvicorn.run(
        "app.api:app",
        host="0.0.0.0",
        port=8000,
        reload=True,
    )
