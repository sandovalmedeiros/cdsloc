"""Shared domain events for the CDsLoc system.

Domain events represent something that has happened in the domain.
They are immutable and contain all the data necessary for consumers.
Events are published to Redis for event-driven communication between bounded contexts.
"""

from __future__ import annotations

import json
from dataclasses import asdict, dataclass
from datetime import datetime, timezone
from decimal import Decimal
from enum import StrEnum
from typing import Any, Final
from uuid import UUID, uuid4


class EventType(StrEnum):
    """Enumeration of all domain event types."""

    # Auth events
    USER_CREATED = "user.created"
    USER_ACTIVATED = "user.activated"
    ROLE_ASSIGNED = "role.assigned"

    # Catalog events
    TITLE_CREATED = "title.created"
    CD_REGISTERED = "cd.registered"
    STOCK_UPDATED = "stock.updated"
    CD_STATUS_CHANGED = "cd.status_changed"

    # Customers events
    CUSTOMER_CREATED = "customer.created"
    CUSTOMER_ACTIVATED = "customer.activated"
    CUSTOMER_CANCELLED = "customer.cancelled"
    DEPENDENT_ADDED = "dependent.added"

    # Rentals events
    LOCACAO_CRIADA = "locacao.criada"
    DEVOLUCAO_REGISTRADA = "devolucao.registrada"
    MULTA_CALCULADA = "multa.calculada"
    RECIBO_GERADO = "recibo.gerado"

    # Reservations events
    RESERVA_CRIADA = "reserva.criada"
    RESERVA_CONFIRMADA = "reserva.confirmada"
    RESERVA_CANCELADA = "reserva.cancelada"
    RESERVA_CONVERTIDA = "reserva.convertida"

    # Reports events
    REPORT_REQUESTED = "report.requested"


class EventMetadata:
    """Metadata for domain events."""

    def __init__(
        self,
        correlation_id: UUID | None = None,
        causation_id: UUID | None = None,
        event_timestamp: datetime | None = None,
    ) -> None:
        self.correlation_id = correlation_id or uuid4()
        self.causation_id = causation_id
        self.event_timestamp = event_timestamp or datetime.now(tz=datetime.timezone.utc)


@dataclass(frozen=True, slots=True)
class DomainEvent:
    """Base class for all domain events.

    Events are immutable and contain:
    - event_type: The type of event (from EventType enum)
    - aggregate_id: ID of aggregate that generated this event
    - aggregate_type: Type of aggregate (User, Cliente, Locacao, etc.)
    - event_id: Unique identifier for this event instance
    - occurred_at: When the event occurred
    - data: Event payload (all necessary data for consumers)
    - metadata: Event metadata for tracing
    """

    event_type: EventType
    aggregate_id: int | str
    aggregate_type: str
    event_id: UUID
    occurred_at: datetime
    data: dict[str, Any]
    metadata: dict[str, Any]

    def __post_init__(self):
        # Ensure occurred_at has timezone info
        if self.occurred_at.tzinfo is None:
            object.__setattr__(
                self,
                "occurred_at",
                self.occurred_at.replace(tzinfo=datetime.timezone.utc),
            )

    @classmethod
    def create(
        cls,
        event_type: EventType,
        aggregate_id: int | str,
        aggregate_type: str,
        data: dict[str, Any],
        correlation_id: UUID | None = None,
        causation_id: UUID | None = None,
        occurred_at: datetime | None = None,
    ) -> DomainEvent:
        """Factory method to create a domain event."""
        event_id = uuid4()
        meta = EventMetadata(correlation_id, causation_id, occurred_at)

        return cls(
            event_type=event_type,
            aggregate_id=aggregate_id,
            aggregate_type=aggregate_type,
            event_id=event_id,
            occurred_at=meta.event_timestamp,
            data=data,
            metadata={
                "correlation_id": str(meta.correlation_id),
                "causation_id": str(meta.causation_id) if meta.causation_id else None,
            },
        )

    def to_json(self) -> str:
        """Serialize event to JSON."""
        event_dict = asdict(self)
        event_dict["event_type"] = self.event_type.value
        event_dict["occurred_at"] = self.occurred_at.isoformat()
        return json.dumps(event_dict)

    def get_correlation_id(self) -> UUID:
        """Get correlation ID for event tracing."""
        return UUID(self.metadata.get("correlation_id", ""))


# Event factory functions for each event type


def user_created(user_id: int, email: str, correlation_id: UUID | None = None) -> DomainEvent:
    """Event fired when a new user is created."""
    return DomainEvent.create(
        event_type=EventType.USER_CREATED,
        aggregate_id=user_id,
        aggregate_type="User",
        data={"user_id": user_id, "email": email},
        correlation_id=correlation_id,
    )


def user_activated(user_id: int, correlation_id: UUID | None = None) -> DomainEvent:
    """Event fired when a user is activated."""
    return DomainEvent.create(
        event_type=EventType.USER_ACTIVATED,
        aggregate_id=user_id,
        aggregate_type="User",
        data={"user_id": user_id},
        correlation_id=correlation_id,
    )


def cd_status_changed(
    cd_codigo: int,
    titulo_id: int,
    situacao_anterior: str,
    situacao_nova: str,
    correlation_id: UUID | None = None,
) -> DomainEvent:
    """Event fired when a CD's status changes (Available/Rented/Reserved)."""
    return DomainEvent.create(
        event_type=EventType.CD_STATUS_CHANGED,
        aggregate_id=cd_codigo,
        aggregate_type="CdFisico",
        data={
            "cd_codigo": cd_codigo,
            "titulo_id": titulo_id,
            "situacao_anterior": situacao_anterior,
            "situacao_nova": situacao_nova,
        },
        correlation_id=correlation_id,
    )


def cliente_cancelled(
    codcliente: int,
    nome: str,
    correlation_id: UUID | None = None,
) -> DomainEvent:
    """Event fired when a customer is cancelled."""
    return DomainEvent.create(
        event_type=EventType.CUSTOMER_CANCELLED,
        aggregate_id=codcliente,
        aggregate_type="Cliente",
        data={"codcliente": codcliente, "nome": nome},
        correlation_id=correlation_id,
    )


def locacao_criada(
    codlocacao: int,
    codcliente: int,
    cd_codigo: int,
    data_locacao: datetime,
    data_prevista: date,
    valor: Decimal,
    correlation_id: UUID | None = None,
    causation_id: UUID | None = None,
) -> DomainEvent:
    """Event fired when a rental is created."""
    return DomainEvent.create(
        event_type=EventType.LOCACAO_CRIADA,
        aggregate_id=codlocacao,
        aggregate_type="Locacao",
        data={
            "codlocacao": codlocacao,
            "codcliente": codcliente,
            "cd_codigo": cd_codigo,
            "data_locacao": data_locacao.isoformat(),
            "data_prevista": data_prevista.isoformat(),
            "valor": str(valor),
        },
        correlation_id=correlation_id,
        causation_id=causation_id,
    )


def devolucao_registrada(
    codlocacao: int,
    data_devolucao: datetime,
    dias_atraso: int,
    multa_valor: Decimal,
    correlation_id: UUID | None = None,
    causation_id: UUID | None = None,
) -> DomainEvent:
    """Event fired when a return (devolucao) is registered."""
    return DomainEvent.create(
        event_type=EventType.DEVOLUCAO_REGISTRADA,
        aggregate_id=codlocacao,
        aggregate_type="Locacao",
        data={
            "codlocacao": codlocacao,
            "data_devolucao": data_devolucao.isoformat(),
            "dias_atraso": dias_atraso,
            "multa_valor": str(multa_valor),
        },
        correlation_id=correlation_id,
        causation_id=causation_id,
    )


def multa_calculada(
    codlocacao: int,
    dias_atraso: int,
    valor: Decimal,
    correlation_id: UUID | None = None,
    causation_id: UUID | None = None,
) -> DomainEvent:
    """Event fired when a penalty (multa) is calculated."""
    return DomainEvent.create(
        event_type=EventType.MULTA_CALCULADA,
        aggregate_id=codlocacao,
        aggregate_type="Locacao",
        data={
            "codlocacao": codlocacao,
            "dias_atraso": dias_atraso,
            "valor": str(valor),
        },
        correlation_id=correlation_id,
        causation_id=causation_id,
    )


def recibo_gerado(
    codrecibo: int,
    codlocacao: int,
    valor_total: Decimal,
    correlation_id: UUID | None = None,
    causation_id: UUID | None = None,
) -> DomainEvent:
    """Event fired when a receipt is generated."""
    return DomainEvent.create(
        event_type=EventType.RECIBO_GERADO,
        aggregate_id=codrecibo,
        aggregate_type="Recibo",
        data={
            "codrecibo": codrecibo,
            "codlocacao": codlocacao,
            "valor_total": str(valor_total),
        },
        correlation_id=correlation_id,
        causation_id=causation_id,
    )


def reserva_criada(
    codreserva: int,
    codcliente: int,
    codtitulo: int,
    data_reserva: datetime,
    correlation_id: UUID | None = None,
) -> DomainEvent:
    """Event fired when a reservation is created."""
    return DomainEvent.create(
        event_type=EventType.RESERVA_CRIADA,
        aggregate_id=codreserva,
        aggregate_type="Reserva",
        data={
            "codreserva": codreserva,
            "codcliente": codcliente,
            "codtitulo": codtitulo,
            "data_reserva": data_reserva.isoformat(),
        },
        correlation_id=correlation_id,
    )


def reserva_convertida(
    codreserva: int,
    codlocacao: int,
    codtitulo: int,
    cd_codigo: int,
    correlation_id: UUID | None = None,
    causation_id: UUID | None = None,
) -> DomainEvent:
    """Event fired when a reservation is converted to a rental."""
    return DomainEvent.create(
        event_type=EventType.RESERVA_CONVERTIDA,
        aggregate_id=codreserva,
        aggregate_type="Reserva",
        data={
            "codreserva": codreserva,
            "codlocacao": codlocacao,
            "codtitulo": codtitulo,
            "cd_codigo": cd_codigo,
        },
        correlation_id=correlation_id,
        causation_id=causation_id,
    )


# Helper functions for consumers


def parse_event_from_json(json_str: str) -> DomainEvent:
    """Parse a domain event from JSON string."""
    event_dict = json.loads(json_str)

    # Convert event_type string to EventType enum
    event_type = EventType(event_dict["event_type"])

    # Extract base fields
    event_id = UUID(event_dict["event_id"])
    aggregate_id = event_dict["aggregate_id"]
    aggregate_type = event_dict["aggregate_type"]
    occurred_at = datetime.fromisoformat(event_dict["occurred_at"])
    data = event_dict["data"]
    metadata = event_dict["metadata"]

    return DomainEvent(
        event_type=event_type,
        aggregate_id=aggregate_id,
        aggregate_type=aggregate_type,
        event_id=event_id,
        occurred_at=occurred_at,
        data=data,
        metadata=metadata,
    )


# Export all events
__all__ = [
    # Enums and metadata
    "EventType",
    "EventMetadata",
    # Base event
    "DomainEvent",
    # Event factory functions
    "user_created",
    "user_activated",
    "cd_status_changed",
    "cliente_cancelled",
    "locacao_criada",
    "devolucao_registrada",
    "multa_calculada",
    "recibo_gerado",
    "reserva_criada",
    "reserva_convertida",
    # Helpers
    "parse_event_from_json",
]
