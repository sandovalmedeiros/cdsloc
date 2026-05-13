"""PostgreSQL repository implementation for User entity.

Implements IUserRepository port.
Replaces legacy Access DAO operations with async SQLAlchemy.
"""

from typing import List, Optional
from datetime import datetime
import bcrypt

from sqlalchemy import select, and_, or_
from sqlalchemy.ext.asyncio import AsyncSession
from sqlalchemy.orm import selectinload

from app.bounded_contexts.auth.domain.user import User
from app.bounded_contexts.auth.ports.user_repository import IUserRepository
from app.shared.infrastructure.config import get_settings

settings = get_settings()


class UserRepository(IUserRepository):
    """PostgreSQL async repository for User entity."""

    def __init__(self, session: AsyncSession):
        self.session = session

    async def create(self, user: User) -> User:
        """Create a new user."""
        self.session.add(user)
        await self.session.commit()
        await self.session.refresh(user)
        return user

    async def get_by_id(self, user_id: int) -> Optional[User]:
        """Get user by ID."""
        result = await self.session.execute(
            select(User).where(User.id == user_id)
        )
        return result.scalar_one_or_none()

    async def get_by_email(self, email: str) -> Optional[User]:
        """Get user by email."""
        result = await self.session.execute(
            select(User).where(User.email == email)
        )
        return result.scalar_one_or_none()

    async def get_all(
        self, limit: int = 100, offset: int = 0
    ) -> List[User]:
        """Get all users with pagination."""
        result = await self.session.execute(
            select(User)
            .order_by(User.created_at.desc())
            .limit(limit)
            .offset(offset)
        )
        return list(result.scalars().all())

    async def update(self, user: User) -> User:
        """Update user."""
        self.session.add(user)
        await self.session.commit()
        await self.session.refresh(user)
        return user

    async def delete(self, user_id: int) -> None:
        """Delete user by ID."""
        result = await self.session.execute(
            select(User).where(User.id == user_id)
        )
        user = result.scalar_one_or_none()
        if user:
            await self.session.delete(user)
            await self.session.commit()

    async def update_last_login(self, user_id: int) -> None:
        """Update user's last login timestamp."""
        await self.session.execute(
            select(User)
            .where(User.id == user_id)
            .values(last_login_at=datetime.utcnow())
        )
        await self.session.commit()

    async def set_active(self, user_id: int, active: bool) -> None:
        """Set user active/inactive."""
        await self.session.execute(
            select(User)
            .where(User.id == user_id)
            .values(active=active)
        )
        await self.session.commit()

    async def exists_by_email(self, email: str) -> bool:
        """Check if user exists by email."""
        result = await self.session.execute(
            select(User.id)
            .where(User.email == email)
        )
        return result.scalar_one_or_none() is not None

    async def authenticate(
        self, email: str, password: str
    ) -> Optional[User]:
        """Authenticate user by email and password (bcrypt hash)."""
        result = await self.session.execute(
            select(User).where(User.email == email)
        )
        user = result.scalar_one_or_none()

        if not user:
            return None

        if not user.active:
            return None

        # Verify password
        if not bcrypt.checkpw(
            password.encode("utf-8"),
            user.password_hash.encode("utf-8"),
        ):
            return None

        return user
