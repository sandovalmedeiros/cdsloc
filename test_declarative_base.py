"""Test DeclarativeBase directly."""
from sqlalchemy.orm import DeclarativeBase, Mapped, mapped_column
from sqlalchemy import Integer, String

# Test creating a Base directly
try:
    TestBase = DeclarativeBase()
    print(f"✓ DeclarativeBase() created: {TestBase}")

    # Try to create a model
    class TestModel(TestBase):
        __tablename__ = "test_model"

        id: Mapped[int] = mapped_column(Integer, primary_key=True)
        name: Mapped[str] = mapped_column(String(50))

    print("✓ TestModel created successfully")
    print(f"TestModel type: {type(TestModel)}")
    print(f"TestModel bases: {TestModel.__bases__}")

except Exception as e:
    print(f"✗ Failed: {e}")
    import traceback
    traceback.print_exc()