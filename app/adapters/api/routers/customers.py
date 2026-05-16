"""FastAPI router for Customers bounded context.

Endpoints for customers and dependents.
"""

from __future__ import annotations

from datetime import date
from typing import AsyncIterable, Iterable

from fastapi import APIRouter, Depends, HTTPException, Query, status

from app.adapters.api.schemas.customers import (
    ClienteCreate,
    ClienteResponse,
    ClienteUpdate,
    DependenteCreate,
    DependenteResponse,
    DependenteUpdate,
)
from app.bounded_contexts.customers.ports.repositories import (
    CustomerRepositoryPort,
    DependentRepositoryPort,
)

router = APIRouter(prefix="/customers", tags=["customers"])


async def get_customer_repo() -> AsyncIterable[CustomerRepositoryPort]:
    """Dependency injection for CustomerRepositoryPort."""
    from app.adapters.db.repositories.customers_repository import PostgresCustomerRepository
    from app.adapters.db.base import get_db

    async for db in get_db():
        yield PostgresCustomerRepository(db)


async def get_dependent_repo() -> AsyncIterable[DependentRepositoryPort]:
    """Dependency injection for DependentRepositoryPort."""
    from app.adapters.db.repositories.customers_repository import PostgresDependentRepository
    from app.adapters.db.base import get_db

    async for db in get_db():
        yield PostgresDependentRepository(db)


# Customer endpoints


@router.post("", response_model=ClienteResponse, status_code=status.HTTP_201_CREATED)
async def create_customer(
    data: ClienteCreate,
    customer_repo: CustomerRepositoryPort = Depends(get_customer_repo),
):
    """Create a new customer."""
    from app.bounded_contexts.customers.domain.entities import Cliente

    # Provide default values for required fields
    cep = data.cep or "00000-000"
    fone_01 = data.fone_01 or "0000000000"

    # Create customer using factory method
    cliente, event = Cliente.create(
        nomecliente=data.nomecliente,
        endereco=data.endereco,
        data_nascimento=data.data_nascimento,
        cep=cep,
        fone_01=fone_01,
        cdbairro=data.cdbairro,
        identidade=data.identidade or "000000000",
        cic=data.cic,
        ramal_res=data.ramal_res,
        fone_02=data.fone_02,
        ramal_trab=data.ramal_trab,
        fone_03=data.fone_03,
        expedidor=data.expedidor,
        data_expedicao=data.data_expedicao,
        empresa=data.empresa,
        end_comercial=data.end_comercial,
        referencia_pessoal=data.referencia_pessoal,
        data_inscricao=date.today(),
        obs=data.obs,
    )

    # Save
    await customer_repo.save(cliente)

    # Return response manually (avoid model_validate issues)
    return ClienteResponse(
        id=cliente.codcliente,
        codcliente=str(cliente.codcliente),
        nomecliente=cliente.nomecliente,
        endereco=cliente.endereco,
        data_nascimento=cliente.data_nascimento,
        cdbairro=cliente.cdbairro or 1,
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
        data_inscricao=cliente.data_inscricao or date.today(),
        is_cancelado=cliente.cancelado,
        obs=cliente.obs,
        dependentes=[],
    )


@router.get("/{customer_id}", response_model=ClienteResponse)
async def get_customer(
    customer_id: int,
    customer_repo: CustomerRepositoryPort = Depends(get_customer_repo),
):
    """Get a customer by ID."""
    cliente = await customer_repo.get_by_id(customer_id)
    if not cliente:
        raise HTTPException(
            status_code=status.HTTP_404_NOT_FOUND,
            detail=f"Cliente {customer_id} não encontrado",
        )

    # Manually construct response
    return ClienteResponse(
        id=cliente.codcliente,
        codcliente=str(cliente.codcliente),
        nomecliente=cliente.nomecliente,
        endereco=cliente.endereco,
        data_nascimento=cliente.data_nascimento,
        cdbairro=cliente.cdbairro or 1,
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
        data_inscricao=cliente.data_inscricao or date.today(),
        is_cancelado=cliente.cancelado,
        obs=cliente.obs,
        dependentes=[],
    )


@router.get("", response_model=list[ClienteResponse])
async def list_customers(
    skip: int = Query(0, ge=0),
    limit: int = Query(100, ge=1, le=100),
    search: str | None = Query(None, description="Search by name (CUST-003)"),
    customer_repo: CustomerRepositoryPort = Depends(get_customer_repo),
):
    """List all customers with optional search."""
    if search:
        clientes = await customer_repo.search_by_name(search)
    else:
        clientes = await customer_repo.get_all(skip=skip, limit=limit)

    # Manually construct responses to avoid model_validate issues
    return [
        ClienteResponse(
            id=c.codcliente,
            codcliente=str(c.codcliente),
            nomecliente=c.nomecliente,
            endereco=c.endereco,
            data_nascimento=c.data_nascimento,
            cdbairro=c.cdbairro or 1,
            cep=c.cep,
            fone_01=c.fone_01,
            ramal_res=c.ramal_res,
            fone_02=c.fone_02,
            ramal_trab=c.ramal_trab,
            fone_03=c.fone_03,
            identidade=c.identidade,
            expedidor=c.expedidor,
            data_expedicao=c.data_expedicao,
            cic=c.cic,
            empresa=c.empresa,
            end_comercial=c.end_comercial,
            referencia_pessoal=c.referencia_pessoal,
            data_inscricao=c.data_inscricao or date.today(),
            is_cancelado=c.cancelado,
            obs=c.obs,
            dependentes=[],
        )
        for c in clientes
    ]


@router.put("/{customer_id}", response_model=ClienteResponse)
async def update_customer(
    customer_id: int,
    data: ClienteUpdate,
    customer_repo: CustomerRepositoryPort = Depends(get_customer_repo),
):
    """Update a customer."""
    cliente = await customer_repo.get_by_id(customer_id)
    if not cliente:
        raise HTTPException(
            status_code=status.HTTP_404_NOT_FOUND,
            detail=f"Cliente {customer_id} não encontrado",
        )

    # Update fields if provided
    if data.nomecliente is not None:
        cliente.nomecliente = data.nomecliente
    if data.endereco is not None:
        cliente.endereco = data.endereco
    if data.data_nascimento is not None:
        cliente.data_nascimento = data.data_nascimento
    if data.cdbairro is not None:
        cliente.cdbairro = data.cdbairro
    if data.cep is not None:
        cliente.cep = data.cep
    if data.is_cancelado is not None:
        cliente.cancelado = data.is_cancelado
    if data.obs is not None:
        cliente.obs = data.obs

    await customer_repo.update(cliente)

    # Manually construct response to avoid model_validate issues
    return ClienteResponse(
        id=cliente.codcliente,
        codcliente=str(cliente.codcliente),
        nomecliente=cliente.nomecliente,
        endereco=cliente.endereco,
        data_nascimento=cliente.data_nascimento,
        cdbairro=cliente.cdbairro or 1,
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
        data_inscricao=cliente.data_inscricao or date.today(),
        is_cancelado=cliente.cancelado,
        obs=cliente.obs,
        dependentes=[],
    )


@router.delete("/{customer_id}", status_code=status.HTTP_204_NO_CONTENT)
async def delete_customer(
    customer_id: int,
    customer_repo: CustomerRepositoryPort = Depends(get_customer_repo),
):
    """Delete a customer."""
    cliente = await customer_repo.get_by_id(customer_id)
    if not cliente:
        raise HTTPException(
            status_code=status.HTTP_404_NOT_FOUND,
            detail=f"Cliente {customer_id} não encontrado",
        )

    await customer_repo.delete(customer_id)


# Dependent endpoints


@router.post("/{customer_id}/dependentes", status_code=status.HTTP_201_CREATED)
async def create_dependent(
    customer_id: int,
    data: DependenteCreate,
    dependent_repo: DependentRepositoryPort = Depends(get_dependent_repo),
    customer_repo: CustomerRepositoryPort = Depends(get_customer_repo),
):
    """Create a new dependent for a customer."""
    from app.bounded_contexts.customers.domain.entities import Dependente

    # Validate customer exists and is not canceled (CUST-002)
    cliente = await customer_repo.get_by_id(customer_id)
    if not cliente:
        raise HTTPException(
            status_code=status.HTTP_404_NOT_FOUND,
            detail=f"Cliente {customer_id} não encontrado",
        )

    if cliente.cancelado:
        raise HTTPException(
            status_code=status.HTTP_400_BAD_REQUEST,
            detail="Cliente cancelado não pode cadastrar dependentes (CUST-002)",
        )

    # Create dependent
    dependente = Dependente(
        cod_dependente=0,
        cod_cliente=customer_id,
        nome_dependente=data.nome_dependente,
    )

    await dependent_repo.save(dependente)

    return {"message": "Dependente cadastrado com sucesso"}


@router.get("/{customer_id}/dependentes", response_model=list[DependenteResponse])
async def list_dependents(
    customer_id: int,
    dependent_repo: DependentRepositoryPort = Depends(get_dependent_repo),
):
    """List all dependents for a customer."""
    dependentes = [
        d
        async for d in dependent_repo.get_by_customer_id(customer_id)
    ]

    return [DependenteResponse.model_validate(d) for d in dependentes]


@router.delete("/dependentes/{dependent_id}", status_code=status.HTTP_204_NO_CONTENT)
async def delete_dependent(
    dependent_id: int,
    dependent_repo: DependentRepositoryPort = Depends(get_dependent_repo),
):
    """Delete a dependent."""
    await dependent_repo.delete(dependent_id)
