"""Port interface for Role repository.

Defines contract for Role data access.
"""

from abc import ABC, abstractmethod
from typing import List, Optional

from app.bounded_contexts.auth.domain.user import Role


class IRoleRepository(ABC):
    """Interface for Role repository operations."""

    @abstractmethod
    async def create(self, role: Role) -> Role:
        """Create a new role."""
        pass

    @abstractmethod
    async def get_by_id(self, role_id: int) -> Optional[Role]:
        """Get role by ID."""
        pass

    @abstractmethod
    async def get_by_name(self, nome: str) -> Optional[Role]:
        """Get role by name."""
        pass

    @abstractmethod
    async def get_all(self, limit: int = 100) -> List[Role]:
        """Get all roles with pagination."""
        pass

    @abstractmethod
    async def update(self, role: Role) -> Role:
        """Update role."""
        pass

    @abstractmethod
    async def delete(self, role_id: int) -> None:
        """Delete role by ID."""
        pass

    @abstractmethod
    async def get_by_user_id(self, user_id: int) -> List[Role]:
        """Get all roles assigned to a user."""
        pass

    @abstractmethod
    async def assign_to_user(self, user_id: int, role_id: int) -> None:
        """Assign role to a user."""
        pass

    @abstractmethod
    async def revoke_from_user(self, user_id: int, role_id: int) -> None:
        """Revoke role from a user."""
        pass
