"""Repository ports for Auth bounded context."""

from . import user_repository  # noqa: F401
from . import role_repository  # noqa: F401

__all__ = ["IUserRepository", "IRoleRepository"]
