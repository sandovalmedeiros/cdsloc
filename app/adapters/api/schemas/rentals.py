"""Pydantic schemas for Rentals bounded context.

Request/response models for API validation.
"""

from __future__ import annotations

from datetime import date, datetime
from decimal import Decimal
from enum import Enum
from typing import Any

from pydantic import BaseModel, Field, field_validator


class SituacaoLocacaoEnum(str, Enum):
    """Situação da locação enum."""

    PENDENTE = "Pendente"
    DEVOLVIDO = "Devolvido"


# Request schemas


class LocacaoCreate(BaseModel):
    """Schema for creating a new rental.

    RENT-001: Cliente deve estar ativo.
    RENT-002: Retirada por dependente opcional.
    RENT-003: Apenas CDs disponíveis podem ser locados.
    """

    id_cliente: int = Field(..., gt=0)
    id_cd: int = Field(..., gt=0)
    id_dependente: int | None = Field(None, gt=0)
    data_locacao: datetime | None = None


class LocacaoUpdate(BaseModel):
    """Schema for updating a rental."""

    valor_multa: Decimal | None = Field(None, ge=0, decimal_places=2, max_digits=10)
    data_devolucao: date | None = None


class DevolucaoCreate(BaseModel):
    """Schema for registering a return (devolução).

    BR-MIGRAR-032: Cálculo de dias de atraso.
    BR-MIGRAR-033: Cálculo de multa.
    """

    data_devolucao: date = Field(..., le=date.today())


# Response schemas


class LocacaoItemResponse(BaseModel):
    """Schema for rental item response."""

    id: int
    id_locacao: int
    id_cd: str
    valor_item: Decimal

    model_config = {"from_attributes": True}


class LocacaoResponse(BaseModel):
    """Schema for rental response."""

    id: int
    id_cliente: int
    id_dependente: int | None
    data_locacao: datetime
    data_prevista: date
    valor_locacao: Decimal
    valor_multa: Decimal
    data_devolucao: date | None
    situacao: SituacaoLocacaoEnum
    itens: list[LocacaoItemResponse] = []

    model_config = {"from_attributes": True}


class ReciboResponse(BaseModel):
    """Schema for receipt response."""

    id: int
    id_locacao: int
    id_cliente: int
    data_emissao: datetime
    valor_total: Decimal
    is_devolvido: bool
    data_devolucao: datetime | None

    model_config = {"from_attributes": True}


class DevolucaoResponse(BaseModel):
    """Schema for return (devolução) response."""

    locacao: LocacaoResponse
    dias_atraso: int
    valor_multa: Decimal
    valor_total: Decimal
