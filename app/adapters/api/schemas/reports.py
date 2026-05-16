"""Pydantic schemas for Reports bounded context.

Request/response models for API validation.
"""

from __future__ import annotations

from datetime import date
from enum import Enum
from typing import Any

from pydantic import BaseModel, Field, field_validator


class ReportTipoEnum(str, Enum):
    """Tipo de relatório enum."""

    CLIENTES_SINTETICO = "clientes_sintetico"
    CLIENTES_ANALITICO = "clientes_analitico"
    DEPENDENTES = "dependentes"
    MUSICAS = "musicas"
    CDS = "cds"
    TITULOS = "titulos"
    RESERVAS = "reservas"
    ANIVERSARIANTES = "aniversariantes"
    RECEBIMENTOS = "recebimentos"
    LOCACOES = "locacoes"


class PeriodoEnum(str, Enum):
    """Período para relatórios."""

    HOJE = "hoje"
    ONTEM = "ontem"
    ESTA_SEMANA = "esta_semana"
    ESTE_MES = "este_mes"
    ULTIMO_MES = "ultimo_mes"
    ULTIMO_TRIMESTRE = "ultimo_trimestre"
    ESTE_ANO = "este_ano"
    PERSONALIZADO = "personalizado"


# Request schemas


class ReportRequest(BaseModel):
    """Schema for requesting a report.

    REP-002: Relatórios aceitam filtros parametrizados.
    """

    tipo: ReportTipoEnum
    formato: str = Field(default="html", pattern=r"^(html|pdf)$")
    periodo: PeriodoEnum | None = None
    data_inicio: date | None = None
    data_fim: date | None = None
    id_cliente: int | None = Field(None, gt=0)

    @field_validator("data_inicio")
    @classmethod
    def validate_date_range(cls, v: date | None, info: Any) -> date | None:
        """Validate data_inicio <= data_fim."""
        if v and "data_fim" in info.data:
            if info.data["data_fim"] < v:
                raise ValueError("Data inicial deve ser anterior ou igual à data final")
        return v


# Response schemas


class ReportResponse(BaseModel):
    """Schema for report response."""

    id: int
    tipo: str
    template: str
    descricao: str | None

    model_config = {"from_attributes": True}
