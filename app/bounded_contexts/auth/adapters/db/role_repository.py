"""PostgreSQL repository implementation for Role entity.

Implements IRoleRepository port.
"""

from typing import List, Optional

from sqlalchemy import select
from sqlalchemy.ext.asyncio import AsyncSession
from sqlalchemy.orm import selectinload

from app.bounded_contexts.auth.domain.user import Role
from app.bounded_contexts.auth.ports.role_repository import IRoleRepository


class RoleRepository(IRoleRepository):
    """PostgreSQL async repository for Role entity."""

    def __init__(self, session: AsyncSession):
        self.session = session

    async def create(self, role: Role) -> Role:
        """Create a new role."""
        self.session.add(role)
        await self.session.commit()
        await self.session.refresh(role)
        return role

    async def get_by_id(self, role_id: int) -> Optional[Role]:
        """Get role by ID."""
        result = await self.session.execute(
            select(Role).where(Role.id == role_id)
        )
        return result.scalar_one_or_none()

    async def get_by_name(self, nome: str) -> Optional[Role]:
        """Get role by name."""
        result = await self.session.execute(
            select(Role).where(Role.nome == nome)
        )
        return result.scalar_one_or_none()

    async def get_all(self, limit: int = 100) -> List[Role]:
        """Get all roles with pagination."""
        result = await self.session.execute(
            select(Role).order_by(Role.nome).limit(limit)
        )
        return list(result.scalars().all())

    async def update(self, role: Role) -> Role:
        """Update role."""
        self.session.add(role)
        await self.session.commit()
        await self.session.refresh(role)
        return role

    async def delete(self, role_id: int) -> None:
        """Delete role by ID."""
        role = await self.get_by_id(role_id)
        if role:
            await self.session.delete(role)
            await self.session.commit()

    async def get_by_user_id(self, user_id: int) -> List[Role]:
        """Get all roles assigned to a user."""
        result = await self.session.execute(
            select(Role)
            .options(selectinload("users"))
            .join("roles_users", Role.id == "roles_users".id_role)
            .where("roles_users".id_user == user_id)
        )
        return list(result.scalars().unique().all())

    async def assign_to_user(self, user_id: int, role_id: int) -> None:
        """Assign role to a user."""
        from app.adapters.db.models.auth import UserRole

        user_role = UserRole(
            id_user=user_id,
            id_role=role_id,
        )
        self.session.add(user_role)
        await self.session.commit()

    async def revoke_from_user(self, user_id: int, role_id: int) -> None:
        """Revoke role from a user."""
        from app.adapters.db.models.auth import UserRole

        result = await self.session.execute(
            select(UserRole)
            .where(
                and_(
                    UserRole.id_user == user_id,
                    UserRole.id_role == role_id,
                    UserRole.revoked_at == None,
                )
            )
        )
        user_role = result.scalar_one_or_none()

        if user_role:
            user_role.revoked_at = datetime.utcnow()
            await self.session.commit()
