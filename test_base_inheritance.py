"""Test Base inheritance."""
from app.adapters.db.base import Base
from sqlalchemy import Integer, String
from sqlalchemy.orm import Mapped, mapped_column

# Test 1: Simple class
try:
    class TestModel1(Base):
        __tablename__ = "test1"

        id: Mapped[int] = mapped_column(Integer, primary_key=True)
        name: Mapped[str] = mapped_column(String(50))

    print("✓ TestModel1 created successfully")
except Exception as e:
    print(f"✗ TestModel1 failed: {e}")

# Test 2: Class with default values
try:
    from datetime import datetime

    class TestModel2(Base):
        __tablename__ = "test2"

        id: Mapped[int] = mapped_column(Integer, primary_key=True)
        name: Mapped[str] = mapped_column(String(50))
        created_at: Mapped[datetime] = mapped_column(default=datetime.utcnow)

    print("✓ TestModel2 created successfully")
except Exception as e:
    print(f"✗ TestModel2 failed: {e}")

# Test 3: Try to import the User model directly
try:
    # Import just the Base first
    from app.adapters.db.base import Base as TestBase

    # Then try to create a similar class
    class TestUser(TestBase):
        __tablename__ = "test_users"

        id: Mapped[int] = mapped_column(Integer, primary_key=True)
        email: Mapped[str] = mapped_column(String(255), unique=True, nullable=False)
        password_hash: Mapped[str] = mapped_column(String(255), nullable=False)
        active: Mapped[bool] = mapped_column(default=True)

    print("✓ TestUser created successfully")
except Exception as e:
    print(f"✗ TestUser failed: {e}")