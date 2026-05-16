"""Test database connection."""
import asyncio
from app.adapters.db.base import engine

async def test_connection():
    """Test database connection."""
    try:
        async with engine.connect() as conn:
            print("✓ Database connection successful!")
            return True
    except Exception as e:
        print(f"✗ Database connection failed: {e}")
        return False

if __name__ == "__main__":
    result = asyncio.run(test_connection())
    exit(0 if result else 1)