"""Port interface for User repository.

Defines the contract for User data access.
"""

from abc import ABC, abstractmethod
from datetime import datetime
from typing import AsyncGenerator, List, Optional

from app.bounded_contexts.auth.domain.user import User


class IUserRepository(ABC):
    """Interface for User repository operations."""

    @abstractmethod
    async def create(self, user: User) -> User:
        """Create a new user."""
        pass

    @abstractmethod
    async def get_by_id(self, user_id: int) -> Optional[User]:
        """Get user by ID."""
        pass

    @abstractmethod
    async def get_by_email(self, email: str) -> Optional[User]:
        """Get user by email."""
        pass

    @abstractmethod
    async def get_all(self, limit: int = 100, offset: int = 0) -> List[User]:
        """Get all users with pagination."""
        pass

    @abstractmethod
    async def update(self, user: User) -> User:
        """Update user."""
        pass

    @abstractmethod
    async def delete(self, user_id: int) -> None:
        """Delete user by ID."""
        pass

    @abstractmethod
    async def update_last_login(self, user_id: int) -> None:
        """Update user's last login timestamp."""
        pass

    @abstractmethod
    async def set_active(self, user_id: int, active: bool) -> None:
        """Set user active/inactive."""
        pass

    @abstractmethod
    async def exists_by_email(self, email: str) -> bool:
        """Check if user exists by email."""
        pass

    @abstractmethod
    async def authenticate(self, email: str, password: str) -> Optional[User]:
        """Authenticate user by email and password (bcrypt hash)."""
        pass
