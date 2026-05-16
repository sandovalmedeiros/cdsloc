"""Migration script to create tables and setup PostgreSQL in Docker."""

import asyncio
import sys
from pathlib import Path

# Add parent directory to path
sys.path.insert(0, str(Path(__file__).parent))

from sqlalchemy import text
from sqlalchemy.ext.asyncio import create_async_engine, AsyncSession, async_sessionmaker

# Database URL for PostgreSQL in Docker
DOCKER_DB_URL = "postgresql+asyncpg://cdsloc:cdsloc_password@localhost:5434/cdsloc"

async def setup_docker_postgres():
    """Setup PostgreSQL in Docker with tables."""
    print("Setting up PostgreSQL in Docker...")

    engine = create_async_engine(
        DOCKER_DB_URL,
        echo=True,
    )

    try:
        # Test connection
        async with engine.connect() as conn:
            result = await conn.execute(text("SELECT 1"))
            print("✓ Connected to PostgreSQL in Docker")

        # Import Base after connection is successful
        from app.adapters.db.base import Base

        # Drop existing tables
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

        # Insert default data
        print("Inserting default data...")
        await insert_default_data(engine)

        print("✓ PostgreSQL setup completed successfully!")
        return True

    except Exception as e:
        print(f"✗ Error setting up PostgreSQL: {e}")
        import traceback
        traceback.print_exc()
        return False
    finally:
        await engine.dispose()

async def insert_default_data(engine):
    """Insert default data for the application."""
    async with AsyncSession(engine) as session:
        try:
            # Insert roles
            await session.execute(text("""
                INSERT INTO roles (nome, permissions) VALUES
                ('admin', '["*"]'::jsonb),
                ('user', '["rentals:read", "customers:read", "catalog:read"]'::jsonb)
                ON CONFLICT DO NOTHING
            """))

            # Insert default situacoes
            await session.execute(text("""
                INSERT INTO situacoes (id, descricao) VALUES
                (1, 'Disponível'),
                (2, 'Locado'),
                (3, 'Reservado')
                ON CONFLICT DO NOTHING
            """))

            await session.commit()
            print("✓ Default data inserted")

        except Exception as e:
            print(f"✗ Error inserting default data: {e}")
            await session.rollback()

async def test_connection():
    """Test connection to PostgreSQL in Docker."""
    print("Testing connection to PostgreSQL in Docker...")

    try:
        engine = create_async_engine(DOCKER_DB_URL)

        async with engine.connect() as conn:
            result = await conn.execute(text("SELECT 1"))
            print("✓ Connection test successful!")

        # Check if tables exist
        async with engine.connect() as conn:
            result = await conn.execute(
                text("SELECT COUNT(*) FROM pg_tables WHERE schemaname = 'public'")
            )
            count = result.scalar()
            print(f"✓ Found {count} tables in database")

            if count > 0:
                async with engine.connect() as conn:
                    result = await conn.execute(
                        text("SELECT tablename FROM pg_tables WHERE schemaname = 'public' ORDER BY tablename LIMIT 5")
                    )
                    print("  First 5 tables:")
                    for table in result.fetchall():
                        print(f"    - {table[0]}")

        await engine.dispose()
        return True

    except Exception as e:
        print(f"✗ Connection test failed: {e}")
        return False

if __name__ == "__main__":
    import sys

    if len(sys.argv) > 1 and sys.argv[1] == "test":
        # Just test connection
        result = asyncio.run(test_connection())
        exit(0 if result else 1)
    else:
        # Full setup
        result = asyncio.run(setup_docker_postgres())
        exit(0 if result else 1)