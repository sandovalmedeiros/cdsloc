"""Customer repository implementations (adapters) for PostgreSQL.

Implements CustomerRepositoryPort and DependentRepositoryPort using SQLAlchemy async.
"""

from __future__ import annotations

from datetime import date
from typing import TYPE_CHECKING, Iterable

from sqlalchemy import select, or_
from sqlalchemy.ext.asyncio import AsyncSession

from app.adapters.db.models import (
    Bairro,
    Cliente,
    Dependente,
    Municipio,
)
from app.bounded_contexts.customers.domain.entities import (
    Cliente as ClienteDomain,
    Dependente as DependenteDomain,
)
from app.bounded_contexts.customers.ports.repositories import (
    CustomerRepositoryPort,
    DependentRepositoryPort,
)

if TYPE_CHECKING:
    from app.bounded_contexts.customers.domain.entities import Cliente


class PostgresCustomerRepository(CustomerRepositoryPort):
    """PostgreSQL implementation of CustomerRepositoryPort."""

    def __init__(self, session: AsyncSession) -> None:
        self._session = session

    async def get_by_id(self, codcliente: int) -> ClienteDomain | None:
        """Get customer by ID."""
        stmt = select(Cliente).where(Cliente.id == codcliente)
        result = await self._session.execute(stmt)
        cliente_model = result.scalar_one_or_none()

        if not cliente_model:
            return None

        return self._model_to_domain(cliente_model)

    async def get_all(
        self, skip: int = 0, limit: int = 100
    ) -> Iterable[ClienteDomain]:
        """Get all customers with pagination."""
        stmt = (
            select(Cliente)
            .offset(skip)
            .limit(limit)
            .order_by(Cliente.nomecliente)
        )
        result = await self._session.execute(stmt)
        clientes = result.scalars().all()

        return [self._model_to_domain(cliente) for cliente in clientes]

    async def search_by_name(self, name: str) -> Iterable[ClienteDomain]:
        """Search customers by name (case-insensitive substring).

        Business Rule: BR-CUST-003
        """
        stmt = select(Cliente).where(
            or_(
                Cliente.nomecliente.ilike(f"%{name}%"),
                Cliente.codcliente.ilike(f"%{name}%"),
            )
        )
        result = await self._session.execute(stmt)
        clientes = result.scalars().all()

        return [self._model_to_domain(cliente) for cliente in clientes]

    async def search_by_cpf(self, cpf: str) -> Iterable[ClienteDomain]:
        """Search customers by CPF."""
        stmt = select(Cliente).where(Cliente.cic == cpf)
        result = await self._session.execute(stmt)
        clientes = result.scalars().all()

        return [self._model_to_domain(cliente) for cliente in clientes]

    async def save(self, cliente: ClienteDomain) -> DomainEvent:
        """Save customer (create or update) and emit event."""
        from app.shared.domain import cliente_created, DomainEvent, EventType

        is_new = cliente.codcliente == 0

        if is_new:
            # Generate codcliente as string for new customers
            import random
            codcliente_str = f"{random.randint(100000, 999999)}"

            # Create model with explicit codcliente value
            cliente_model = Cliente()
            cliente_model.codcliente = codcliente_str  # Set explicitly
            cliente_model.nomecliente = cliente.nomecliente
            cliente_model.endereco = cliente.endereco
            cliente_model.data_nascimento = cliente.data_nascimento
            cliente_model.cdbairro = cliente.cdbairro
            cliente_model.cep = cliente.cep or "00000"
            cliente_model.fone_01 = cliente.fone_01 or "0000000000"
            cliente_model.ramal_res = cliente.ramal_res
            cliente_model.fone_02 = cliente.fone_02
            cliente_model.ramal_trab = cliente.ramal_trab
            cliente_model.fone_03 = cliente.fone_03
            cliente_model.identidade = cliente.identidade or "000000000"
            cliente_model.expedidor = cliente.expedidor
            cliente_model.data_expedicao = cliente.data_expedicao
            cliente_model.cic = cliente.cic
            cliente_model.empresa = cliente.empresa
            cliente_model.end_comercial = cliente.end_comercial
            cliente_model.referencia_pessoal = cliente.referencia_pessoal
            cliente_model.data_inscricao = cliente.data_inscricao or date.today()
            cliente_model.is_cancelado = cliente.cancelado
            cliente_model.obs = cliente.obs
            cliente_model.created_at = date.today()
            cliente_model.updated_at = date.today()

            self._session.add(cliente_model)
            await self._session.flush()

            # Update domain entity with generated ID (use model.id as internal ID)
            object.__setattr__(cliente, "codcliente", cliente_model.id)
        else:
            stmt = select(Cliente).where(Cliente.id == cliente.codcliente)
            result = await self._session.execute(stmt)
            cliente_model = result.scalar_one_or_none()

            if cliente_model:
                self._update_model_from_domain(cliente_model, cliente)

        await self._session.commit()

        if is_new:
            return cliente_created(
                codcliente=cliente.codcliente,
                nome=cliente.nomecliente,
                email=None,  # Not stored in domain
            )
        else:
            return DomainEvent.create(
                event_type=EventType.STOCK_UPDATED,  # Placeholder
                aggregate_id=cliente.codcliente,
                aggregate_type="Cliente",
                data={"codcliente": cliente.codcliente},
            )

    async def update(self, cliente: ClienteDomain) -> None:
        """Update customer."""
        stmt = select(Cliente).where(Cliente.id == cliente.codcliente)
        result = await self._session.execute(stmt)
        cliente_model = result.scalar_one_or_none()

        if cliente_model:
            self._update_model_from_domain(cliente_model, cliente)
            await self._session.commit()

    async def delete(self, codcliente: int) -> None:
        """Delete customer by ID."""
        stmt = select(Cliente).where(Cliente.id == codcliente)
        result = await self._session.execute(stmt)
        cliente = result.scalar_one_or_none()

        if cliente:
            await self._session.delete(cliente)
            await self._session.commit()

    def _model_to_domain(self, cliente: Cliente) -> ClienteDomain:
        """Convert ORM model to domain entity."""
        return ClienteDomain(
            codcliente=cliente.id,
            nomecliente=cliente.nomecliente,
            endereco=cliente.endereco,
            data_nascimento=cliente.data_nascimento,
            cdbairro=cliente.cdbairro,
            cep=cliente.cep,
            fone_01=cliente.fone_01,
            ramal_res=cliente.ramal_res,
            fone_02=cliente.fone_02,
            ramal_trab=cliente.ramal_trab,
            fone_03=cliente.fone_03,
            identidade=cliente.identidade,
            expedidor=cliente.expedidor,
            data_expedicao=cliente.data_expedicao,
            cic=cliente.cic,
            empresa=cliente.empresa,
            end_comercial=cliente.end_comercial,
            referencia_pessoal=cliente.referencia_pessoal,
            data_inscricao=cliente.data_inscricao,
            cancelado=cliente.is_cancelado,
            obs=cliente.obs,
        )

    def _domain_to_model(self, cliente: ClienteDomain) -> Cliente:
        """Convert domain entity to ORM model."""
        return Cliente(
            id=cliente.codcliente if cliente.codcliente != 0 else None,
            codcliente=str(cliente.codcliente) if cliente.codcliente != 0 else None,
            nomecliente=cliente.nomecliente,
            endereco=cliente.endereco,
            data_nascimento=cliente.data_nascimento,
            cdbairro=cliente.cdbairro,
            cep=cliente.cep,
            fone_01=cliente.fone_01,
            ramal_res=cliente.ramal_res,
            fone_02=cliente.fone_02,
            ramal_trab=cliente.ramal_trab,
            fone_03=cliente.fone_03,
            identidade=cliente.identidade,
            expedidor=cliente.expedidor,
            data_expedicao=cliente.data_expedicao,
            cic=cliente.cic,
            empresa=cliente.empresa,
            end_comercial=cliente.end_comercial,
            referencia_pessoal=cliente.referencia_pessoal,
            data_inscricao=cliente.data_inscricao,
            is_cancelado=cliente.cancelado,
            obs=cliente.obs,
            created_at=date.today(),
            updated_at=date.today(),
        )

    def _update_model_from_domain(self, cliente_model: Cliente, cliente: ClienteDomain) -> None:
        """Update ORM model from domain entity."""
        if cliente.nomecliente is not None:
            cliente_model.nomecliente = cliente.nomecliente
        if cliente.endereco is not None:
            cliente_model.endereco = cliente.endereco
        if cliente.data_nascimento is not None:
            cliente_model.data_nascimento = cliente.data_nascimento
        if cliente.cdbairro is not None:
            cliente_model.cdbairro = cliente.cdbairro
        if cliente.cep is not None:
            cliente_model.cep = cliente.cep
        if cliente.fone_01 is not None:
            cliente_model.fone_01 = cliente.fone_01
        if cliente.ramal_res is not None:
            cliente_model.ramal_res = cliente.ramal_res
        if cliente.fone_02 is not None:
            cliente_model.fone_02 = cliente.fone_02
        if cliente.ramal_trab is not None:
            cliente_model.ramal_trab = cliente.ramal_trab
        if cliente.fone_03 is not None:
            cliente_model.fone_03 = cliente.fone_03
        if cliente.identidade is not None:
            cliente_model.identidade = cliente.identidade
        if cliente.expedidor is not None:
            cliente_model.expedidor = cliente.expedidor
        if cliente.data_expedicao is not None:
            cliente_model.data_expedicao = cliente.data_expedicao
        if cliente.cic is not None:
            cliente_model.cic = cliente.cic
        if cliente.empresa is not None:
            cliente_model.empresa = cliente.empresa
        if cliente.end_comercial is not None:
            cliente_model.end_comercial = cliente.end_comercial
        if cliente.referencia_pessoal is not None:
            cliente_model.referencia_pessoal = cliente.referencia_pessoal
        if cliente.obs is not None:
            cliente_model.obs = cliente.obs
        cliente_model.updated_at = date.today()


class PostgresDependentRepository(DependentRepositoryPort):
    """PostgreSQL implementation of DependentRepositoryPort."""

    def __init__(self, session: AsyncSession) -> None:
        self._session = session

    async def get_by_id(self, cod_dependente: int) -> DependenteDomain | None:
        """Get dependent by ID."""
        stmt = select(Dependente).where(Dependente.id == cod_dependente)
        result = await self._session.execute(stmt)
        dependente_model = result.scalar_one_or_none()

        if not dependente_model:
            return None

        return self._model_to_domain(dependente_model)

    async def get_all(
        self, skip: int = 0, limit: int = 100
    ) -> Iterable[DependenteDomain]:
        """Get all dependents with pagination."""
        stmt = (
            select(Dependente)
            .offset(skip)
            .limit(limit)
            .order_by(Dependente.nome_dependente)
        )
        result = await self._session.execute(stmt)
        dependentes = result.scalars().all()

        return [self._model_to_domain(dep) for dep in dependentes]

    async def get_by_customer_id(
        self, cod_cliente: int
    ) -> Iterable[DependenteDomain]:
        """Get all dependents for a customer."""
        stmt = (
            select(Dependente)
            .where(Dependente.id_cliente == cod_cliente)
            .order_by(Dependente.nome_dependente)
        )
        result = await self._session.execute(stmt)
        dependentes = result.scalars().all()

        return [self._model_to_domain(dep) for dep in dependentes]

    async def save(self, dependente: DependenteDomain) -> None:
        """Save dependent (create or update)."""
        is_new = dependente.cod_dependente == 0

        if is_new:
            dependente_model = self._domain_to_model(dependente)
            self._session.add(dependente_model)
            await self._session.flush()
            object.__setattr__(dependente, "cod_dependente", dependente_model.id)
        else:
            stmt = select(Dependente).where(
                Dependente.id == dependente.cod_dependente
            )
            result = await self._session.execute(stmt)
            dependente_model = result.scalar_one_or_none()

            if dependente_model:
                self._update_model_from_domain(dependente_model, dependente)

    async def update(self, dependente: DependenteDomain) -> None:
        """Update dependent."""
        stmt = select(Dependente).where(
            Dependente.id == dependente.cod_dependente
        )
        result = await self._session.execute(stmt)
        dependente_model = result.scalar_one_or_none()

        if dependente_model:
            self._update_model_from_domain(dependente_model, dependente)

    async def delete(self, cod_dependente: int) -> None:
        """Delete dependent by ID."""
        stmt = select(Dependente).where(Dependente.id == cod_dependente)
        result = await self._session.execute(stmt)
        dependente = result.scalar_one_or_none()

        if dependente:
            await self._session.delete(dependente)

    def _model_to_domain(self, dependente: Dependente) -> DependenteDomain:
        """Convert ORM model to domain entity."""
        return DependenteDomain(
            cod_dependente=dependente.id,
            cod_cliente=dependente.id_cliente,
            nome_dependente=dependente.nome_dependente,
        )

    def _domain_to_model(self, dependente: DependenteDomain) -> Dependente:
        """Convert domain entity to ORM model."""
        return Dependente(
            id=dependente.cod_dependente
            if dependente.cod_dependente != 0
            else None,
            cod_dependente=str(dependente.cod_dependente)
            if dependente.cod_dependente != 0
            else None,
            id_cliente=dependente.cod_cliente,
            nome_dependente=dependente.nome_dependente,
            created_at=date.today(),
            updated_at=date.today(),
        )

    def _update_model_from_domain(
        self, dependente_model: Dependente, dependente: DependenteDomain
    ) -> None:
        """Update ORM model from domain entity."""
        if dependente.nome_dependente is not None:
            dependente_model.nome_dependente = dependente.nome_dependente
        if dependente.cod_cliente is not None:
            dependente_model.id_cliente = dependente.cod_cliente
        dependente_model.updated_at = date.today()
