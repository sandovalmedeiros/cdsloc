"""Pydantic schemas for Reservations bounded context.

Request/response models for API validation.
"""

from __future__ import annotations

from datetime import date, datetime
from enum import Enum
from typing import Any

from pydantic import BaseModel, Field


class SituacaoReservaEnum(str, Enum):
    """Situação da reserva enum."""

    PENDENTE = "Pendente"
    CONFIRMADA = "Confirmada"
    CANCELADA = "Cancelada"
    LOCADA = "Locada"


# Request schemas


class ReservaCreate(BaseModel):
    """Schema for creating a new reservation.

    RESV-001: Reserva exige cliente ativo.
    RESV-002: Reserva por título, não por CD físico específico.
    RESV-004: Bloqueio de reserva duplicada.
    """

    id_cliente: int = Field(..., gt=0)
    id_titulo: int = Field(..., gt=0)
    data_reserva: datetime | None = None
    data_prevista: date | None = None


class ReservaUpdate(BaseModel):
    """Schema for updating a reservation."""

    situacao: SituacaoReservaEnum | None = None


# Response schemas


class ReservaResponse(BaseModel):
    """Schema for reservation response."""

    id: int
    id_cliente: int
    id_titulo: int
    data_reserva: datetime
    data_prevista: date
    situacao: SituacaoReservaEnum

    model_config = {"from_attributes": True}
