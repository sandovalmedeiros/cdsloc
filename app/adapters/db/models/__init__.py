"""ORM models for all bounded contexts.

All SQLAlchemy async models representing the target data model.
Tables are organized by bounded context following hexagonal architecture.
"""

# Auth bounded context
from .auth import User  # noqa: F401

# Catalog bounded context
from .catalog import (  # noqa: F401
    Cd,
    Estilo,
    Grupo,
    Interprete,
    Musica,
    MusicaInterprete,
    Situacao,
    Titulo,
    TituloInterprete,
    TituloMusica,
)

# Customers bounded context
from .customers import (  # noqa: F401
    Bairro,
    Cliente,
    Dependente,
    Municipio,
)

# Rentals bounded context
from .rentals import (  # noqa: F401
    Locacao,
    LocacaoItem,
    Recibo,
)

# Reservations bounded context
from .reservations import (  # noqa: F401
    Reserva,
)

# Reports bounded context
from .reports import (  # noqa: F401
    RelatorioSpec,
)

__all__ = [
    # Auth
    "User",
    # Catalog
    "Titulo",
    "Cd",
    "Musica",
    "MusicaInterprete",
    "Interprete",
    "Grupo",
    "Estilo",
    "Situacao",
    "TituloMusica",
    "TituloInterprete",
    # Customers
    "Municipio",
    "Bairro",
    "Cliente",
    "Dependente",
    # Rentals
    "Locacao",
    "LocacaoItem",
    "Recibo",
    # Reservations
    "Reserva",
    # Reports
    "RelatorioSpec",
]
