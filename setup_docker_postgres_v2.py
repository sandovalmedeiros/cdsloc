"""Migration script to create tables in PostgreSQL in Docker with forced Base reimport."""

import asyncio
import sys
from pathlib import Path
from importlib import reload

# Add parent directory to path
sys.path.insert(0, str(Path(__file__).parent))

from sqlalchemy import text
from sqlalchemy.ext.asyncio import create_async_engine, AsyncSession, async_sessionmaker
from sqlalchemy.orm import DeclarativeBase

# Database URL for PostgreSQL in Docker
DOCKER_DB_URL = "postgresql+asyncpg://cdsloc:cdsloc_password@localhost:5434/cdsloc"

async def setup_docker_postgres():
    """Setup PostgreSQL in Docker with tables."""
    print("Setting up PostgreSQL in Docker with forced reimport...")

    # Force reimport Base to clear cache
    import app.adapters.db.base as base_module
    reload(base_module)
    from app.adapters.db.base import Base

    engine = create_async_engine(
        DOCKER_DB_URL,
        echo=True,
    )

    try:
        # Test connection
        async with engine.connect() as conn:
            result = await conn.execute(text("SELECT 1"))
            print("✓ Connected to PostgreSQL in Docker")

        # Force reimport models to ensure correct Base
        print("Forcing models reimport...")
        import app.adapters.db.models as models_module
        reload(models_module)

        # Drop all tables
        print("Dropping existing tables...")
        async with engine.begin() as conn:
            await conn.run_sync(Base.metadata.drop_all)

        # Create all tables
        print("Creating tables...")
        async with engine.begin() as conn:
            await conn.run_sync(Base.metadata.create_all)

        # List created tables
        async with engine.connect() as conn:
            result = await conn.execute(
                text("SELECT tablename FROM pg_tables WHERE schemaname = 'public' ORDER BY tablename")
            )
            tables = result.fetchall()
            print(f"✓ Created {len(tables)} tables:")
            for table in tables:
                print(f"  - {table[0]}")

        if len(tables) == 0:
            print("✗ WARNING: No tables were created!")
            return False

        print("✓ PostgreSQL setup completed successfully!")
        return True

    except Exception as e:
        print(f"✗ Error setting up PostgreSQL: {e}")
        import traceback
        traceback.print_exc()
        return False
    finally:
        await engine.dispose()

if __name__ == "__main__":
    result = asyncio.run(setup_docker_postgres())
    exit(0 if result else 1)