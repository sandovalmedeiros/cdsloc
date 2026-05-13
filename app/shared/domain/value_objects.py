"""Shared value objects for the CDsLoc domain.

Value objects are immutable objects defined by their attributes rather than identity.
They ensure invariants are maintained and are reusable across bounded contexts.
"""

from __future__ import annotations

import re
from dataclasses import dataclass
from datetime import date, datetime, timedelta
from decimal import Decimal, ROUND_HALF_UP
from typing import Annotated, Final, Self

from pydantic import (
    BaseModel,
    ConfigDict,
    EmailStr,
    Field,
    ValidationInfo,
    WrapValidator,
    field_validator,
)

# Constants
CURRENCY_BRL: Final = "BRL"
CPF_LENGTH: Final = 11
CEP_LENGTH: Final = 5
MIN_PASSWORD_LENGTH: Final = 8
MAX_RETRIES: Final = 3


def _validate_cpf(value: str) -> str:
    """Validate Brazilian CPF using digit verification algorithm (BR-MIGRAR-010)."""
    if not value:
        return value

    # Remove non-digits
    cpf = re.sub(r"[^\d]", "", value)

    # Check length
    if len(cpf) != CPF_LENGTH:
        raise ValueError(f"CPF deve ter {CPF_LENGTH} dígitos")

    # Check for invalid CPFs (all same digits)
    if cpf == cpf[0] * CPF_LENGTH:
        raise ValueError("CPF inválido")

    # Calculate verification digits
    for i in range(9, 11):
        total = sum(int(cpf[j]) * (i + 1 - j) for j in range(0, i))
        digit = (total * 10) % 11
        if digit == 10:
            digit = 0
        if digit != int(cpf[i]):
            raise ValueError("CPF inválido")

    return cpf


def _validate_cep(value: str) -> str:
    """Validate Brazilian CEP (5 digits)."""
    if not value:
        return value

    cep = re.sub(r"[^\d]", "", value)

    if len(cep) != CEP_LENGTH:
        raise ValueError(f"CEP deve ter {CEP_LENGTH} dígitos")

    return cep


def _validate_date_range(value: tuple[date, date]) -> tuple[date, date]:
    """Validate that start date is before or equal to end date."""
    start, end = value

    if start > end:
        raise ValueError("Data inicial deve ser anterior ou igual à data final")

    return (start, end)


def _validate_duration(value: int) -> int:
    """Validate duration in seconds."""
    if value < 0:
        raise ValueError("Duração não pode ser negativa")

    return value


# Type aliases for Annotated validators
CPF = Annotated[str, WrapValidator(_validate_cpf)]
CEP = Annotated[str, WrapValidator(_validate_cep)]
DateRangeTuple = Annotated[tuple[date, date], WrapValidator(_validate_date_range)]
DurationSeconds = Annotated[int, WrapValidator(_validate_duration)]

# Domain Value Objects (immutable, dataclass-based)


@dataclass(frozen=True, slots=True)
class Money:
    """Monetary value in BRL.

    Invariant: Value >= 0, exactly 2 decimal places.
    """

    valor: Decimal
    moeda: str = CURRENCY_BRL

    def __post_init__(self):
        object.__setattr__(
            self,
            "valor",
            self.valor.quantize(Decimal("0.01"), rounding=ROUND_HALF_UP),
        )

        if self.valor < Decimal("0"):
            raise ValueError("Valor monetário não pode ser negativo")

    def __add__(self, other: Money) -> Money:
        if not isinstance(other, Money):
            return NotImplemented

        if self.moeda != other.moeda:
            raise ValueError("Não é possível somar moedas diferentes")

        return Money(self.valor + other.valor, self.moeda)

    def __sub__(self, other: Money) -> Money:
        if not isinstance(other, Money):
            return NotImplemented

        if self.moeda != other.moeda:
            raise ValueError("Não é possível subtrair moedas diferentes")

        result = self.valor - other.valor

        if result < Decimal("0"):
            raise ValueError("Resultado da subtração não pode ser negativo")

        return Money(result, self.moeda)

    def __mul__(self, other: int | Decimal) -> Money:
        if not isinstance(other, (int, Decimal)):
            return NotImplemented

        if isinstance(other, int) and other < 0:
            raise ValueError("Multiplicador não pode ser negativo")

        return Money(self.valor * Decimal(other), self.moeda)

    def is_zero(self) -> bool:
        return self.valor == Decimal("0")

    def is_positive(self) -> bool:
        return self.valor > Decimal("0")

    def to_float(self) -> float:
        return float(self.valor)

    def __str__(self) -> str:
        return f"R$ {self.valor:.2f}"


@dataclass(frozen=True, slots=True)
class Multa:
    """Penalty for late return.

    Invariant: Calculated as R$ 3.50 per day overdue (BR-MIGRAR-033).
    """

    valor: Money
    dias_atraso: int

    def __post_init__(self):
        if self.dias_atraso < 0:
            raise ValueError("Dias de atraso não pode ser negativo")

        expected = Money(Decimal("3.50") * self.dias_atraso)

        if self.valor.valor != expected.valor:
            raise ValueError(
                f"Valor da multa incorreto. Esperado: {expected.valor}, Recebido: {self.valor.valor}"
            )

    @classmethod
    def zero(cls) -> Self:
        """Create a zero penalty (no late return)."""
        return cls(Money(Decimal("0")), 0)

    @classmethod
    def calculate(cls, dias_atraso: int) -> Self:
        """Calculate penalty based on days overdue."""
        if dias_atraso <= 0:
            return cls.zero()

        valor = Money(Decimal("3.50") * dias_atraso)
        return cls(valor, dias_atraso)


@dataclass(frozen=True, slots=True)
class DataPrevista:
    """Expected return date for a rental.

    Rules (BR-MIGRAR-025, BR-MIGRAR-026):
    - 24h rental: +1 day (2 if Sunday)
    - 48h rental: +2 days (3 if Sunday)
    """

    valor: date

    def __post_init__(self):
        if self.valor < date(1900):
            raise ValueError("Data prevista inválida")

    @classmethod
    def calculate(cls, data_locacao: date, tipo_locacao: str) -> Self:
        """Calculate expected return date based on rental type."""
        if tipo_locacao == "24h":
            days_to_add = 1
        elif tipo_locacao == "48h":
            days_to_add = 2
        else:
            raise ValueError(f"Tipo de locação inválido: {tipo_locacao}")

        result = data_locacao + timedelta(days=days_to_add)

        # Adjust if Sunday (weekday=6)
        if result.weekday() == 6:  # Sunday
            result += timedelta(days=1)

        return cls(result)

    def __str__(self) -> str:
        return self.valor.strftime("%d/%m/%Y")


@dataclass(frozen=True, slots=True)
class DiasAtraso:
    """Days overdue for a rental.

    Invariant: Max(0, current_date - expected_return_date).
    """

    valor: int

    def __post_init__(self):
        if self.valor < 0:
            raise ValueError("Dias de atraso não pode ser negativo")

    @classmethod
    def calculate(cls, data_atual: date, data_prevista: date) -> Self:
        """Calculate days overdue based on current and expected date."""
        delta = data_atual - data_prevista
        dias = delta.days

        if dias < 0:
            return cls(0)

        return cls(dias)

    def is_late(self) -> bool:
        return self.valor > 0


# Pydantic models for request/response validation


class MoneyDTO(BaseModel):
    """Data transfer object for Money."""

    model_config = ConfigDict(frozen=True)

    valor: Decimal = Field(..., ge=0, decimal_places=2, max_digits=10)
    moeda: str = Field(default=CURRENCY_BRL)

    def to_domain(self) -> Money:
        return Money(self.valor, self.moeda)


class MultaDTO(BaseModel):
    """Data transfer object for Multa."""

    model_config = ConfigDict(frozen=True)

    valor: Decimal = Field(..., ge=0, decimal_places=2, max_digits=10)
    dias_atraso: int = Field(..., ge=0)

    def to_domain(self) -> Multa:
        return Multa(Money(self.valor, CURRENCY_BRL), self.dias_atraso)


class CPFVO(BaseModel):
    """Value object for CPF with validation."""

    model_config = ConfigDict(frozen=True)

    valor: str = Field(..., min_length=11, max_length=11, pattern=r"^\d{11}$")

    @field_validator("valor")
    @classmethod
    def validate_cpf(cls, v: str) -> str:
        return _validate_cpf(v)

    def mask(self) -> str:
        """Return CPF with standard masking (XXX.XXX.XXX-XX)."""
        return f"{self.valor[:3]}.{self.valor[3:6]}.{self.valor[6:9]}-{self.valor[9:]}"


class CEPVO(BaseModel):
    """Value object for CEP with validation."""

    model_config = ConfigDict(frozen=True)

    valor: str = Field(..., min_length=5, max_length=5, pattern=r"^\d{5}$")

    def mask(self) -> str:
        """Return CEP with standard masking (XXXXX-XXX)."""
        return f"{self.valor[:5]}-{self.valor[5:]}" if len(self.valor) > 5 else self.valor


class TelefoneVO(BaseModel):
    """Value object for Brazilian phone."""

    model_config = ConfigDict(frozen=True)

    ddd: str = Field(..., min_length=2, max_length=3, pattern=r"^\d{2,3}$")
    numero: str = Field(..., min_length=7, max_length=9, pattern=r"^\d{7,9}$")

    def format(self) -> str:
        """Return phone with standard formatting (XX) XXXXX-XXXX or (XX) XXXX-XXXX."""
        if len(self.numero) == 8:
            return f"({self.ddd}) {self.numero[:4]}-{self.numero[4:]}"
        return f"({self.ddd}) {self.numero[:5]}-{self.numero[5:]}"


class DataNascimentoVO(BaseModel):
    """Value object for date of birth (BR-MIGRAR-008)."""

    model_config = ConfigDict(frozen=True)

    valor: date = Field(..., le=date(1900, 1, 1))

    @field_validator("valor")
    @classmethod
    def validate_year(cls, v: date) -> date:
        if v.year < 1900:
            raise ValueError("Data de nascimento deve ser a partir de 1900")
        return v

    @property
    def idade(self) -> int:
        """Calculate age based on current date."""
        today = date.today()
        return today.year - self.valor.year - (
            (today.month, today.day) < (self.valor.month, self.valor.day)
        )


class DateRangeVO(BaseModel):
    """Value object for date range."""

    model_config = ConfigDict(frozen=True)

    data_inicio: date
    data_fim: date

    @field_validator("data_fim")
    @classmethod
    def validate_range(cls, v: date, info: ValidationInfo) -> date:
        if "data_inicio" in info.data:
            if info.data["data_inicio"] > v:
                raise ValueError("Data inicial deve ser anterior ou igual à data final")
        return v

    @property
    def dias(self) -> int:
        """Return number of days in range."""
        return (self.data_fim - self.data_inicio).days + 1


class DurationVO(BaseModel):
    """Value object for duration in seconds (Catalog)."""

    model_config = ConfigDict(frozen=True)

    segundos: int = Field(..., ge=0)

    @property
    def minutos(self) -> float:
        """Return duration in minutes."""
        return self.segundos / 60

    @property
    def formatado(self) -> str:
        """Return duration formatted as MM:SS."""
        minutos = self.segundos // 60
        segundos = self.segundos % 60
        return f"{minutos:02d}:{segundos:02d}"


# Export all value objects
__all__ = [
    # Dataclass-based immutable value objects
    "Money",
    "Multa",
    "DataPrevista",
    "DiasAtraso",
    # Pydantic-based value objects for API
    "MoneyDTO",
    "MultaDTO",
    "CPFVO",
    "CEPVO",
    "TelefoneVO",
    "DataNascimentoVO",
    "DateRangeVO",
    "DurationVO",
    # Type aliases
    "CPF",
    "CEP",
    "DateRangeTuple",
    "DurationSeconds",
    # Constants
    "CURRENCY_BRL",
    "CPF_LENGTH",
    "CEP_LENGTH",
    "MIN_PASSWORD_LENGTH",
    "MAX_RETRIES",
]
