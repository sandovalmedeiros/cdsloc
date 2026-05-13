"""ORM models for all bounded contexts.

All SQLAlchemy async models representing the target data model.
Tables are organized by bounded context following hexagonal architecture.
"""

# Auth bounded context
from . import auth  # noqa: F401

# Catalog bounded context
from . import catalog  # noqa: F401

# Customers bounded context
from . import customers  # noqa: F401

# Rentals bounded context
from . import rentals  # noqa: F401 (to be created)

# Reservations bounded context
from . import reservations  # noqa: F401 (to be created)

# Shared
from . import shared  # noqa: F401 (to be created)

__all__ = [
    # Modules
    "auth",
    "catalog",
    "customers",
    "rentals",
    "reservations",
    "shared",
]
