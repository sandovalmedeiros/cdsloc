"""Pydantic schemas for Catalog bounded context.

Request/response models for API validation.
"""

from __future__ import annotations

from datetime import date
from decimal import Decimal
from enum import Enum
from typing import Any

from pydantic import BaseModel, Field, field_validator


class TipoLocacaoEnum(str, Enum):
    """Tipo de locação enum."""

    H24 = "24h"
    H48 = "48h"


class SituacaoCdEnum(str, Enum):
    """Situação do CD enum."""

    DISPONIVEL = "Disponível"
    LOCADO = "Locado"
    RESERVADO = "Reservado"


# Request schemas


class TitleCreate(BaseModel):
    """Schema for creating a new title."""

    nome: str = Field(..., min_length=1, max_length=255)
    tipo_locacao: TipoLocacaoEnum
    valor: Decimal = Field(..., gt=0, decimal_places=2, max_digits=10)
    qtde: int = Field(..., ge=0)
    id_grupo: int | None = None
    id_estilo: int | None = None


class TitleUpdate(BaseModel):
    """Schema for updating a title."""

    nome: str | None = Field(None, min_length=1, max_length=255)
    tipo_locacao: TipoLocacaoEnum | None = None
    valor: Decimal | None = Field(None, gt=0, decimal_places=2, max_digits=10)
    qtde: int | None = Field(None, ge=0)
    id_grupo: int | None = None
    id_estilo: int | None = None


class CdCreate(BaseModel):
    """Schema for creating a new CD."""

    id_titulo: int = Field(..., gt=0)
    numcd: str = Field(..., min_length=1, max_length=50)
    data_compra: date | None = None
    valor_compra: Decimal | None = Field(None, ge=0, decimal_places=2, max_digits=10)


class CdUpdate(BaseModel):
    """Schema for updating a CD."""

    situacao: SituacaoCdEnum | None = None
    data_compra: date | None = None
    valor_compra: Decimal | None = Field(None, ge=0, decimal_places=2, max_digits=10)


class MusicaCreate(BaseModel):
    """Schema for creating a new music track."""

    nome: str = Field(..., min_length=1, max_length=255)
    tempo: int | None = Field(None, ge=0)


class InterpreteCreate(BaseModel):
    """Schema for creating a new interpreter."""

    nome: str = Field(..., min_length=1, max_length=255)


# Response schemas


class MusicaResponse(BaseModel):
    """Schema for music track response."""

    id: int
    nome: str
    tempo: int | None

    model_config = {"from_attributes": True}


class InterpreteResponse(BaseModel):
    """Schema for interpreter response."""

    id: int
    nome: str

    model_config = {"from_attributes": True}


class CdResponse(BaseModel):
    """Schema for CD response."""

    codigo: str
    numcd: str
    id_titulo: int
    situacao: SituacaoCdEnum
    is_locado: bool
    data_compra: date | None
    valor_compra: Decimal | None

    model_config = {"from_attributes": True}


class TitleResponse(BaseModel):
    """Schema for title response."""

    id: int
    nome: str
    tipo_locacao: TipoLocacaoEnum
    valor: Decimal
    qtde: int
    cdgrupo: int | None = Field(default=None, alias="id_grupo")
    cdestilo: int | None = Field(default=None, alias="id_estilo")
    cds: list[CdResponse] = []
    musicas: list[MusicaResponse] = []
    interpretes: list[InterpreteResponse] = []

    model_config = {"from_attributes": True, "populate_by_name": True}
