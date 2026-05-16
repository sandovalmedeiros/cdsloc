"""Test different DeclarativeBase patterns."""
from sqlalchemy.orm import DeclarativeBase, Mapped, mapped_column
from sqlalchemy import Integer, String

# Pattern 1: Using DeclarativeBase as a base class directly
print("Pattern 1: Using DeclarativeBase as base class")
try:
    class TestModel1(DeclarativeBase):
        __tablename__ = "test_model1"

        id: Mapped[int] = mapped_column(Integer, primary_key=True)
        name: Mapped[str] = mapped_column(String(50))

    print("✓ TestModel1 created successfully")
except Exception as e:
    print(f"✗ TestModel1 failed: {e}")

# Pattern 2: Creating a Base instance first (original pattern)
print("\nPattern 2: Creating Base instance first")
try:
    Base = DeclarativeBase()

    class TestModel2(Base):
        __tablename__ = "test_model2"

        id: Mapped[int] = mapped_column(Integer, primary_key=True)
        name: Mapped[str] = mapped_column(String(50))

    print("✓ TestModel2 created successfully")
except Exception as e:
    print(f"✗ TestModel2 failed: {e}")

# Pattern 3: Using declarative_base (old style)
print("\nPattern 3: Using declarative_base (old style)")
try:
    from sqlalchemy.orm import declarative_base

    OldBase = declarative_base()

    class TestModel3(OldBase):
        __tablename__ = "test_model3"

        id = mapped_column(Integer, primary_key=True)
        name = mapped_column(String(50))

    print("✓ TestModel3 created successfully")
except Exception as e:
    print(f"✗ TestModel3 failed: {e}")