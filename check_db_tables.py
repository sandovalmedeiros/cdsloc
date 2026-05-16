"""Check database tables."""
import asyncio
from sqlalchemy import text
from app.adapters.db.base import engine

async def check_tables():
    """Check if tables exist in database."""
    try:
        async with engine.connect() as conn:
            result = await conn.execute(text(
                "SELECT tablename FROM pg_tables WHERE schemaname = 'public' ORDER BY tablename"
            ))
            tables = [row[0] for row in result.fetchall()]
            print(f"Found {len(tables)} tables:")
            for table in tables:
                print(f"  - {table}")
            return len(tables) > 0
    except Exception as e:
        print(f"✗ Error checking tables: {e}")
        return False

if __name__ == "__main__":
    result = asyncio.run(check_tables())
    exit(0 if result else 1)