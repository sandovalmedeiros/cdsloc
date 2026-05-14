"""Customers application service.

Implements use cases for customers bounded context.
"""

from __future__ import annotations

from datetime import date
from typing import Iterable

from app.bounded_contexts.customers.domain.entities import (
    Cliente,
    Dependente,
)
from app.bounded_contexts.customers.ports.repositories import (
    CustomerRepositoryPort,
    DependentRepositoryPort,
)
from app.shared.domain.events import DomainEvent


class CustomerService:
    """Application service for customer operations."""

    def __init__(
        self,
        customer_repo: CustomerRepositoryPort,
        dependent_repo: DependentRepositoryPort,
    ) -> None:
        self._customer_repo = customer_repo
        self._dependent_repo = dependent_repo

    # Customer operations

    async def create_customer(
        self,
        nomecliente: str,
        endereco: str,
        data_nascimento: date,
        cep: str,
        fone_01: str,
        cic: str | None = None,
        cdbairro: int | None = None,
        ramal_res: str | None = None,
        fone_02: str | None = None,
        ramal_trab: str | None = None,
        fone_03: str | None = None,
        identidade: str | None = None,
        expedidor: str | None = None,
        data_expedicao: date | None = None,
        empresa: str | None = None,
        end_comercial: str | None = None,
        referencia_pessoal: str | None = None,
        data_inscricao: date | None = None,
        obs: str | None = None,
    ) -> tuple[Cliente, DomainEvent]:
        """Create a new customer."""
        cliente, event = Cliente.create(
            nomecliente=nomecliente,
            endereco=endereco,
            data_nascimento=data_nascimento,
            cdbairro=cdbairro,
            cep=cep,
            fone_01=fone_01,
            ramal_res=ramal_res,
            fone_02=fone_02,
            ramal_trab=ramal_trab,
            fone_03=fone_03,
            identidade=identidade,
            expedidor=expedidor,
            data_expedicao=data_expedicao,
            cic=cic,
            empresa=empresa,
            end_comercial=end_comercial,
            referencia_pessoal=referencia_pessoal,
            data_inscricao=data_inscricao,
            obs=obs,
        )

        saved_event = await self._customer_repo.save(cliente)
        return cliente, saved_event or event

    async def update_customer(
        self,
        codcliente: int,
        nomecliente: str | None = None,
        endereco: str | None = None,
        data_nascimento: date | None = None,
        cep: str | None = None,
        fone_01: str | None = None,
        cic: str | None = None,
        cdbairro: int | None = None,
        ramal_res: str | None = None,
        fone_02: str | None = None,
        ramal_trab: str | None = None,
        fone_03: str | None = None,
        identidade: str | None = None,
        expedidor: str | None = None,
        data_expedicao: date | None = None,
        empresa: str | None = None,
        end_comercial: str | None = None,
        referencia_pessoal: str | None = None,
        data_inscricao: date | None = None,
        obs: str | None = None,
    ) -> Cliente:
        """Update an existing customer."""
        cliente = await self._customer_repo.get_by_id(codcliente)
        if not cliente:
            raise ValueError(f"Cliente {codcliente} não encontrado")

        if nomecliente is not None:
            object.__setattr__(cliente, "nomecliente", nomecliente)
        if endereco is not None:
            object.__setattr__(cliente, "endereco", endereco)
        if data_nascimento is not None:
            object.__setattr__(cliente, "data_nascimento", data_nascimento)
        if cep is not None:
            object.__setattr__(cliente, "cep", cep)
        if fone_01 is not None:
            object.__setattr__(cliente, "fone_01", fone_01)
        if cic is not None:
            object.__setattr__(cliente, "cic", cic)
        if cdbairro is not None:
            object.__setattr__(cliente, "cdbairro", cdbairro)
        if ramal_res is not None:
            object.__setattr__(cliente, "ramal_res", ramal_res)
        if fone_02 is not None:
            object.__setattr__(cliente, "fone_02", fone_02)
        if ramal_trab is not None:
            object.__setattr__(cliente, "ramal_trab", ramal_trab)
        if fone_03 is not None:
            object.__setattr__(cliente, "fone_03", fone_03)
        if identidade is not None:
            object.__setattr__(cliente, "identidade", identidade)
        if expedidor is not None:
            object.__setattr__(cliente, "expedidor", expedidor)
        if data_expedicao is not None:
            object.__setattr__(cliente, "data_expedicao", data_expedicao)
        if empresa is not None:
            object.__setattr__(cliente, "empresa", empresa)
        if end_comercial is not None:
            object.__setattr__(cliente, "end_comercial", end_comercial)
        if referencia_pessoal is not None:
            object.__setattr__(
                cliente, "referencia_pessoal", referencia_pessoal
            )
        if data_inscricao is not None:
            object.__setattr__(cliente, "data_inscricao", data_inscricao)
        if obs is not None:
            object.__setattr__(cliente, "obs", obs)

        await self._customer_repo.update(cliente)
        return cliente

    async def get_customer(self, codcliente: int) -> Cliente | None:
        """Get customer by ID."""
        return await self._customer_repo.get_by_id(codcliente)

    async def list_customers(
        self, skip: int = 0, limit: int = 100
    ) -> Iterable[Cliente]:
        """List all customers with pagination."""
        return await self._customer_repo.get_all(skip=skip, limit=limit)

    async def search_customers_by_name(
        self, name: str
    ) -> Iterable[Cliente]:
        """Search customers by name (case-insensitive, CUST-003)."""
        return await self._customer_repo.search_by_name(name)

    async def search_customers_by_cpf(
        self, cpf: str
    ) -> Iterable[Cliente]:
        """Search customers by CPF."""
        return await self._customer_repo.search_by_cpf(cpf)

    async def cancel_customer(self, codcliente: int) -> DomainEvent:
        """Cancel customer (CUST-001)."""
        cliente = await self._customer_repo.get_by_id(codcliente)
        if not cliente:
            raise ValueError(f"Cliente {codcliente} não encontrado")

        event = cliente.cancelar()
        await self._customer_repo.update(cliente)
        return event

    async def activate_customer(self, codcliente: int) -> DomainEvent:
        """Activate customer."""
        cliente = await self._customer_repo.get_by_id(codcliente)
        if not cliente:
            raise ValueError(f"Cliente {codcliente} não encontrado")

        event = cliente.ativar()
        await self._customer_repo.update(cliente)
        return event

    async def delete_customer(self, codcliente: int) -> None:
        """Delete customer by ID."""
        await self._customer_repo.delete(codcliente)

    async def can_customer_rent(self, codcliente: int) -> bool:
        """Check if customer can make rentals (CUST-001)."""
        cliente = await self._customer_repo.get_by_id(codcliente)
        return cliente.pode_fazer_locacao() if cliente else False

    # Dependent operations

    async def add_dependent(
        self, cod_cliente: int, nome_dependente: str
    ) -> tuple[Dependente, DomainEvent]:
        """Add a dependent to a customer (BR-MIGRAR-014, CUST-002)."""
        cliente = await self._customer_repo.get_by_id(cod_cliente)
        if not cliente:
            raise ValueError(f"Cliente {cod_cliente} não encontrado")

        if not cliente.pode_cadastrar_dependente():
            raise ValueError("Cliente cancelado não pode cadastrar dependentes")

        dependente = Dependente(
            cod_dependente=0,  # Will be set by repository
            cod_cliente=cod_cliente,
            nome_dependente=nome_dependente,
        )

        await self._dependent_repo.save(dependente)
        event = cliente.adicionar_dependente(dependente)
        await self._customer_repo.update(cliente)

        return dependente, event

    async def update_dependent(
        self, cod_dependente: int, nome_dependente: str
    ) -> Dependente:
        """Update dependent name."""
        dependente = await self._dependent_repo.get_by_id(cod_dependente)
        if not dependente:
            raise ValueError(f"Dependente {cod_dependente} não encontrado")

        object.__setattr__(
            dependente, "nome_dependente", nome_dependente
        )

        await self._dependent_repo.update(dependente)
        return dependente

    async def get_dependents(
        self, cod_cliente: int
    ) -> Iterable[Dependente]:
        """Get all dependents for a customer."""
        return await self._dependent_repo.get_by_customer_id(cod_cliente)

    async def delete_dependent(self, cod_dependente: int) -> None:
        """Delete dependent by ID."""
        await self._dependent_repo.delete(cod_dependente)
