"""Test fixtures for parity tests.

Provides reusable test data and configuration.
"""

from __future__ import annotations

import pytest
from datetime import date, datetime
from sqlalchemy.ext.asyncio import AsyncSession, async_sessionmaker, create_async_engine

from app.adapters.db.models import Base
from app.bounded_contexts.auth.domain.entities import User, Role
from app.bounded_contexts.catalog.domain.entities import CdFisico, SituacaoCd, Title
from app.bounded_contexts.customers.domain.entities import Cliente, Dependente
from app.bounded_contexts.rentals.domain.entities import Locacao, Recibo
from app.bounded_contexts.rentals.services.rental_service import RentalService
from app.bounded_contexts.catalog.ports.repositories import (
    CdFisicoRepositoryPort,
    TitleRepositoryPort,
)
from app.bounded_contexts.customers.ports.repositories import CustomerRepositoryPort
from app.bounded_contexts.rentals.ports.repositories import (
    ReceiptRepositoryPort,
    RentalRepositoryPort,
)
from app.tests.conftest import TEST_DATABASE_URL


# Database fixtures


@pytest.fixture
async def async_engine():
    """Create async engine for tests."""
    engine = create_async_engine(TEST_DATABASE_URL, echo=False)
    async with engine.begin() as conn:
        await conn.run_sync(Base.metadata.create_all)
    yield engine
    async with engine.begin() as conn:
        await conn.run_sync(Base.metadata.drop_all)
    await engine.dispose()


@pytest.fixture
async def async_session(async_engine):
    """Create async session for tests."""
    async_session_maker = async_sessionmaker(
        async_engine,
        class_=AsyncSession,
        expire_on_commit=False,
    )
    async with async_session_maker() as session:
        yield session
        await session.rollback()


# Repository fixtures (mock implementations for testing)


@pytest.fixture
def mock_customer_repository():
    """Mock customer repository for testing."""
    from unittest.mock import AsyncMock

    repo = AsyncMock(spec=CustomerRepositoryPort)
    return repo


@pytest.fixture
def mock_cd_repository():
    """Mock CD repository for testing."""
    from unittest.mock import AsyncMock

    repo = AsyncMock(spec=CdFisicoRepositoryPort)
    return repo


@pytest.fixture
def mock_rental_repository():
    """Mock rental repository for testing."""
    from unittest.mock import AsyncMock

    repo = AsyncMock(spec=RentalRepositoryPort)
    return repo


@pytest.fixture
def mock_receipt_repository():
    """Mock receipt repository for testing."""
    from unittest.mock import AsyncMock

    repo = AsyncMock(spec=ReceiptRepositoryPort)
    return repo


@pytest.fixture
def mock_title_repository():
    """Mock title repository for testing."""
    from unittest.mock import AsyncMock

    repo = AsyncMock(spec=TitleRepositoryPort)
    return repo


# Service fixture


@pytest.fixture
def rental_service(
    mock_rental_repository,
    mock_receipt_repository,
    mock_cd_repository,
    mock_customer_repository,
):
    """Create rental service with mocked repositories."""
    return RentalService(
        rental_repo=mock_rental_repository,
        receipt_repo=mock_receipt_repository,
        cd_repo=mock_cd_repository,
        customer_repo=mock_customer_repository,
    )


# Domain entity fixtures


@pytest.fixture
def active_customer():
    """Create an active customer for testing."""
    return Cliente(
        codcliente=1,
        nome="João Silva",
        endereco="Rua Teste, 123",
        bairro="Centro",
        telefone="(11) 99999-9999",
        cpf="12345678901",
        datanasc=date(1980, 1, 1),
        cancelado=False,
        dependentes=[],
    )


@pytest.fixture
def another_active_customer():
    """Create another active customer for testing."""
    return Cliente(
        codcliente=2,
        nome="Maria Santos",
        endereco="Rua Exemplo, 456",
        bairro="Centro",
        telefone="(11) 88888-8888",
        cpf="98765432109",
        datanasc=date(1985, 1, 1),
        cancelado=False,
        dependentes=[],
    )


@pytest.fixture
def cancelled_customer():
    """Create a cancelled customer for testing."""
    return Cliente(
        codcliente=3,
        nome="Pedro Cancelado",
        endereco="Rua Cancelado, 789",
        bairro="Centro",
        telefone="(11) 77777-7777",
        cpf="11111111111",
        datanasc=date(1990, 1, 1),
        cancelado=True,
        dependentes=[],
    )


@pytest.fixture
def available_cd():
    """Create an available CD for testing."""
    return CdFisico(
        codigo=1001,
        id_titulo=1,
        situacao=SituacaoCd.DISPONIVEL,
        is_locado=False,
    )


@pytest.fixture
def rented_cd():
    """Create a rented CD for testing."""
    return CdFisico(
        codigo=1002,
        id_titulo=1,
        situacao=SituacaoCd.LOCADO,
        is_locado=True,
    )


@pytest.fixture
def reserved_cd():
    """Create a reserved CD for testing."""
    return CdFisico(
        codigo=1003,
        id_titulo=1,
        situacao=SituacaoCd.RESERVADO,
        is_locado=False,
    )


@pytest.fixture
def title_24h():
    """Create a 24h title for testing."""
    return Title(
        id=1,
        nome="Álbum Teste 24h",
        valor=5.00,
        tipo_locacao="24h",
    )


@pytest.fixture
def title_48h():
    """Create a 48h title for testing."""
    return Title(
        id=2,
        nome="Álbum Teste 48h",
        valor=8.00,
        tipo_locacao="48h",
    )


@pytest.fixture
def pending_rental():
    """Create a pending rental for testing."""
    return Locacao(
        id=1,
        id_cliente=1,
        codcd=1001,
        data_locacao=datetime.now(),
        data_prevista=date.today(),
        valor_locacao=5.00,
        coddependente=None,
        codrecibo=1,
        recibo=None,
    )


@pytest.fixture
def pending_receipt():
    """Create a pending receipt for testing."""
    from app.shared.domain import Money

    return Recibo(
        codrecibo=1,
        codcliente=1,
        valor_total=Money(5.00),
        devolvido=False,
        locacoes=[],
    )


@pytest.fixture
def active_user():
    """Create an active user for testing."""
    return User(
        id=1,
        username="admin",
        email="admin@cdloc.com",
        hashed_password="hashed_password_here",
        is_active=True,
        role=Role.ADMIN,
    )


@pytest.fixture
def regular_user():
    """Create a regular user for testing."""
    return User(
        id=2,
        username="user",
        email="user@cdloc.com",
        hashed_password="hashed_password_here",
        is_active=True,
        role=Role.USER,
    )