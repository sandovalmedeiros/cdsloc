"""Fix backend and create tables in PostgreSQL."""
import asyncio
from app.adapters.db.base import engine, Base
from sqlalchemy import text

async def create_tables():
    """Create all tables in PostgreSQL."""
    try:
        # Test connection
        async with engine.connect() as conn:
            result = await conn.execute(text("SELECT 1"))
            print("✓ Database connection successful")

        # Drop all tables (clean start)
        print("Dropping existing tables...")
        async with engine.begin() as conn:
            await conn.run_sync(Base.metadata.drop_all)

        # Create all tables
        print("Creating tables...")
        async with engine.begin() as conn:
            await conn.run_sync(Base.metadata.create_all)

        print("✓ Tables created successfully")

        # List created tables
        async with engine.connect() as conn:
            result = await conn.execute(
                text("SELECT tablename FROM pg_tables WHERE schemaname = 'public' ORDER BY tablename")
            )
            tables = result.fetchall()
            print(f"✓ Created {len(tables)} tables:")
            for table in tables:
                print(f"  - {table[0]}")

        return True
    except Exception as e:
        print(f"✗ Error creating tables: {e}")
        import traceback
        traceback.print_exc()
        return False

if __name__ == "__main__":
    result = asyncio.run(create_tables())
    exit(0 if result else 1)