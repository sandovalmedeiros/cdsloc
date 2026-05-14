"""Reservations domain entities.

Implements Reserva entity following hexagonal architecture.
"""

from __future__ import annotations

from dataclasses import dataclass
from datetime import date, datetime, timedelta
from enum import Enum

from app.shared.domain import DomainEvent, reserva_criada


class SituacaoReserva(str, Enum):
    """Reservation status (BR-MIGRAR-042, BR-MIGRAR-021)."""

    PENDENTE = "Pendente"
    CONFIRMADA = "Confirmada"
    CANCELADA = "Cancelada"
    LOCADA = "Locada"


@dataclass(slots=True)
class Reserva:
    """Reservation aggregate root.

    Agregate: Yes (root aggregate)
    Invariant: Cliente ativo, reserva não duplicada pelo mesmo cliente para o mesmo título
    Events: ReservaCriada, ReservaConfirmada, ReservaCancelada, ReservaConvertida

    RESV-001: Reserva exige cliente ativo.
    RESV-002: Reserva por título, não por CD físico específico.
    RESV-003: Reserva não garante disponibilidade física na retirada.
    RESV-004: Bloqueio de reserva duplicada.
    RESV-005: Ao converter reserva em locação, situação marcada como "Confirmada".
    RESV-006: Data prevista calculada baseada na disponibilidade.
    """

    codreserva: int
    codcliente: int
    codtitulo: int
    data_reserva: datetime
    data_prevista: date
    situacao: SituacaoReserva

    def __post_init__(self):
        # Validate situacao is valid
        if not isinstance(self.situacao, SituacaoReserva):
            raise ValueError(f"Situacao inválida: {self.situacao}")

    @classmethod
    def create(
        cls,
        codcliente: int,
        codtitulo: int,
        data_reserva: datetime | None = None,
        data_prevista: date | None = None,
    ) -> tuple["Reserva", DomainEvent]:
        """Create a new reservation.

        RESV-001: Cliente deve estar ativo (validado no service).
        RESV-004: Bloqueio de reserva duplicada (validado no service).
        RESV-006: Data prevista calculada baseada na disponibilidade.
        """
        agora = data_reserva or datetime.now()

        # Se data_prevista não fornecida, usa data_reserva + 1 dia (padrão)
        if not data_prevista:
            data_prevista = agora.date() + datetime.timedelta(days=1)

        reserva = cls(
            codreserva=0,  # Will be set by repository
            codcliente=codcliente,
            codtitulo=codtitulo,
            data_reserva=agora,
            data_prevista=data_prevista,
            situacao=SituacaoReserva.PENDENTE,
        )

        event = reserva_criada(
            codreserva=reserva.codreserva,
            codcliente=codcliente,
            codtitulo=codtitulo,
            data_reserva=agora,
        )

        return reserva, event

    def confirmar(self) -> None:
        """Mark reservation as confirmed.

        RESV-005: Ao converter reserva em locação, situação marcada como "Confirmada".
        """
        if self.situacao != SituacaoReserva.PENDENTE:
            raise ValueError(
                f"Apenas reservas pendentes podem ser confirmadas. Situação atual: {self.situacao}"
            )

        object.__setattr__(self, "situacao", SituacaoReserva.CONFIRMADA)

    def cancelar(self) -> None:
        """Cancel a reservation."""
        if self.situacao in (SituacaoReserva.LOCADA, SituacaoReserva.CANCELADA):
            raise ValueError(
                f"Reserva {self.situacao} não pode ser cancelada"
            )

        object.__setattr__(self, "situacao", SituacaoReserva.CANCELADA)

    def marcar_como_locada(self) -> None:
        """Mark reservation as converted to rental."""
        if self.situacao not in (SituacaoReserva.PENDENTE, SituacaoReserva.CONFIRMADA):
            raise ValueError(
                f"Apenas reservas pendentes ou confirmadas podem ser convertidas em locação"
            )

        object.__setattr__(self, "situacao", SituacaoReserva.LOCADA)

    @property
    def is_ativa(self) -> bool:
        """Check if reservation is still active (not canceled or converted)."""
        return self.situacao in (SituacaoReserva.PENDENTE, SituacaoReserva.CONFIRMADA)

    @property
    def is_pendente(self) -> bool:
        """Check if reservation is pending."""
        return self.situacao == SituacaoReserva.PENDENTE

    @property
    def is_cancelada(self) -> bool:
        """Check if reservation is canceled."""
        return self.situacao == SituacaoReserva.CANCELADA

    @property
    def is_locada(self) -> bool:
        """Check if reservation was converted to rental."""
        return self.situacao == SituacaoReserva.LOCADA
