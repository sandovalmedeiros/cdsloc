"""Pydantic schemas for Customers bounded context.

Request/response models for API validation.
"""

from __future__ import annotations

from datetime import date
from decimal import Decimal
from typing import Any

from pydantic import BaseModel, Field, field_validator


# Request schemas


class ClienteCreate(BaseModel):
    """Schema for creating a new customer."""

    nomecliente: str = Field(..., min_length=1, max_length=255)
    endereco: str = Field(..., min_length=1, max_length=255)
    data_nascimento: date = Field(..., le=date.today())
    cdbairro: int = Field(..., gt=0)
    cep: str | None = Field(None, pattern=r"^\d{5}?\-?\d{3}$")
    fone_01: str | None = Field(None, max_length=15)
    ramal_res: str | None = Field(None, max_length=10)
    fone_02: str | None = Field(None, max_length=15)
    ramal_trab: str | None = Field(None, max_length=10)
    fone_03: str | None = Field(None, max_length=15)
    identidade: str = Field(..., max_length=20)
    expedidor: str | Field(None, max_length=20)
    data_expedicao: date | None = None
    cic: str | None = Field(None, pattern=r"^\d{11}$")
    empresa: str = Field(None, max_length=255)
    end_comercial: str = Field(None, max_length=255)
    referencia_pessoal: str = Field(None, max_length=255)
    obs: str = None

    @field_validator("data_nascimento")
    @classmethod
    def validate_nascimento(cls, v: date) -> date:
        """Validate date of birth >= 1900 and not future (BR-MIGRAR-008)."""
        if v.year < 1900:
            raise ValueError("Data de nascimento deve ser a partir de 1900")
        if v > date.today():
            raise ValueError("Data de nascimento não pode ser futura")
        return v


class ClienteUpdate(BaseModel):
    """Schema for updating a customer."""

    nomecliente: str | None = Field(None, min_length=1, max_length=255)
    endereco: str | None = Field(None, min_length=1, max_length=255)
    data_nascimento: date | None = Field(None, le=date.today())
    cdbairro: int | None = Field(None, gt=0)
    cep: str | None = Field(None, pattern=r"^\d{5}?\-?\d{3}$")
    fone_01: str | None = Field(None, max_length=15)
    ramal_res: str | None = Field(None, max_length=10)
    fone_02: str | None = Field(None, max_length=15)
    ramal_trab: str | None = Field(None, max_length=10)
    fone_03: str | None = Field(None, max_length=15)
    identidade: str | None = Field(None, max_length=20)
    expedidor: str | None = Field(None, max_length=20)
    data_expedicao: date | None = None
    cic: str | None = Field(None, pattern=r"^\d{11}$")
    empresa: str | None = Field(None, max_length=255)
    end_comercial: str | None = Field(None, max_length=255)
    referencia_pessoal: str | None = Field(None, max_length=255)
    obs: str = None
    is_cancelado: bool | None = None


class DependenteCreate(BaseModel):
    """Schema for creating a new dependent."""

    nome_dependente: str = Field(..., min_length=1, max_length=255)


class DependenteUpdate(BaseModel):
    """Schema for updating a dependent."""

    nome_dependente: str | None = Field(None, min_length=1, max_length=255)


# Response schemas


class DependenteResponse(BaseModel):
    """Schema for dependent response."""

    id: int
    cod_dependente: str
    id_cliente: int
    nome_dependente: str

    model_config = {"from_attributes": True}


class ClienteResponse(BaseModel):
    """Schema for customer response."""

    id: int
    codcliente: str
    nomecliente: str
    endereco: str
    data_nascimento: date
    cdbairro: int
    cep: str | None
    fone_01: str | None
    ramal_res: str | None
    fone_02: str | None
    ramal_trab: str | None
    fone_03: str | None
    identidade: str
    expedidor: str | None
    data_expedicao: date | None
    cic: str | None
    empresa: str | None
    end_comercial: str | None
    referencia_pessoal: str | None
    data_inscricao: date
    is_cancelado: bool
    obs: str | None
    dependentes: list[DependenteResponse] = []

    model_config = {"from_attributes": True}
