"""Shared domain - value objects and events."""

# Re-export from submodules
from .events import *  # noqa: F401, F403
from .value_objects import *  # noqa: F401, F403

__all__ = [
    # From value_objects
    "Money",
    "Multa",
    "DataPrevista",
    "DiasAtraso",
    "MoneyDTO",
    "MultaDTO",
    "CPFVO",
    "CEPVO",
    "TelefoneVO",
    "DataNascimentoVO",
    "DateRangeVO",
    "DurationVO",
    "EnderecoVO",
    "validate_cpf",
    "validate_cep",
    "CURRENCY_BRL",
    "CPF_LENGTH",
    "CEP_LENGTH",
    "MIN_PASSWORD_LENGTH",
    "MAX_RETRIES",
    # From events
    "EventType",
    "EventMetadata",
    "DomainEvent",
    "user_created",
    "user_activated",
    "role_assigned",
    "title_created",
    "cd_registered",
    "cd_status_changed",
    "stock_updated",
    "cliente_created",
    "cliente_activated",
    "cliente_cancelled",
    "dependente_added",
    "locacao_criada",
    "devolucao_registrada",
    "multa_calculada",
    "recibo_gerado",
    "reserva_criada",
    "reserva_confirmada",
    "reserva_cancelada",
    "reserva_convertida",
    "report_requested",
    "parse_event_from_json",
]
