"""Base database configuration for SQLAlchemy async.

Provides engine, session factory, and declarative base for ORM models.
"""

from __future__ import annotations

from datetime import datetime, timezone

from sqlalchemy.ext.asyncio import (
    AsyncSession,
    async_sessionmaker,
    create_async_engine,
)
from sqlalchemy.orm import DeclarativeBase

from app.shared.infrastructure.config import get_settings

settings = get_settings()

# Async engine with PostgreSQL + asyncpg
engine = create_async_engine(
    settings.database_url.replace("postgresql://", "postgresql+asyncpg://"),
    echo=settings.debug,
    # Pool configuration
    pool_size=10,
    max_overflow=20,
    pool_pre_ping=True,
    pool_recycle=3600,
)

# Async session factory
AsyncSessionLocal = async_sessionmaker(
    bind=engine,
    class_=AsyncSession,
    expire_on_commit=False,
    autocommit=False,
    autoflush=False,
)

# Declarative base for ORM models
class Base(DeclarativeBase):
    """Base class for all ORM models."""
    pass


def _now() -> datetime:
    """Get current UTC datetime with timezone awareness."""
    return datetime.now(timezone.utc)


async def get_db() -> AsyncGenerator[AsyncSession, None]:
    """Get async database session with proper cleanup.

    Usage:
        async with get_db() as session:
            await session.execute(query)
    """
    async with AsyncSessionLocal() as session:
        try:
            yield session
        finally:
            await session.close()


async def get_db_no_context() -> AsyncSession:
    """Get async database session without context manager.

    Used for dependency injection in FastAPI.
    Caller is responsible for closing the session.
    """
    return AsyncSessionLocal()


async def init_db() -> None:
    """Initialize database schema (create all tables).

    Use this for testing or development. In production, use Alembic migrations.
    """
    async with engine.begin() as conn:
        await conn.run_sync(Base.metadata.create_all)


async def drop_db() -> None:
    """Drop all tables (use with caution!).

    Use this only for testing.
    """
    async with engine.begin() as conn:
        await conn.run_sync(Base.metadata.drop_all)
