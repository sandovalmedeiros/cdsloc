"""ORM models for Auth bounded context.

Tables: users, roles, roles_users
"""

from datetime import datetime

from sqlalchemy import (
    Column,
    Integer,
    String,
    Boolean,
    DateTime,
    ForeignKey,
    text,
)
from sqlalchemy.orm import (
    Mapped,
    mapped_column,
    relationship,
)
from sqlalchemy.dialects.postgresql import JSONB

from app.adapters.db.base import Base


class User(Base):
    """User table (replaces legacy 'senha' single password - BR-HUMANA-001)."""

    __tablename__ = "users"

    id: Mapped[int] = mapped_column(Integer, primary_key=True)
    email: Mapped[str] = mapped_column(String(255), unique=True, nullable=False)
    password_hash: Mapped[str] = mapped_column(String(255), nullable=False)
    salt: Mapped[str] = mapped_column(String(64), nullable=False)
    active: Mapped[bool] = mapped_column(Boolean, nullable=False, default=True)
    created_at: Mapped[datetime] = mapped_column(DateTime, nullable=False, default=datetime.utcnow)
    last_login_at: Mapped[datetime | None] = mapped_column(DateTime, nullable=True)
    updated_at: Mapped[datetime] = mapped_column(DateTime, nullable=False, default=datetime.utcnow)

    # Relationships
    roles: Mapped[list["Role"]] = relationship(
        "Role",
        secondary="roles_users",
        primaryjoin="User.id == UserRole.id_user",
        secondaryjoin="Role.id == UserRole.id_role",
        back_populates="users",
        lazy="selectin",
    )

    def __repr__(self) -> str:
        return f"<User id={self.id} email={self.email} active={self.active}>"


class Role(Base):
    """Role table with permissions (e.g., rentals:read, rentals:write)."""

    __tablename__ = "roles"

    id: Mapped[int] = mapped_column(Integer, primary_key=True)
    nome: Mapped[str] = mapped_column(String(100), unique=True, nullable=False)
    permissions: Mapped[dict[str, list[str]]] = mapped_column(
        JSONB, nullable=False, default=lambda: [], server_default=text("'[]'::jsonb")
    )
    created_at: Mapped[datetime] = mapped_column(DateTime, nullable=False, default=datetime.utcnow)
    updated_at: Mapped[datetime] = mapped_column(DateTime, nullable=False, default=datetime.utcnow)

    # Relationships
    users: Mapped[list["User"]] = relationship(
        "User",
        secondary="roles_users",
        primaryjoin="Role.id == UserRole.id_role",
        secondaryjoin="User.id == UserRole.id_user",
        back_populates="roles",
        lazy="selectin",
    )

    def __repr__(self) -> str:
        return f"<Role id={self.id} nome={self.nome}>"


class UserRole(Base):
    """Association table for many-to-many relationship between users and roles."""

    __tablename__ = "roles_users"

    id: Mapped[int] = mapped_column(Integer, primary_key=True)
    id_user: Mapped[int] = mapped_column(
        Integer,
        ForeignKey("users.id", ondelete="CASCADE"),
        nullable=False,
    )
    id_role: Mapped[int] = mapped_column(
        Integer,
        ForeignKey("roles.id", ondelete="CASCADE"),
        nullable=False,
    )
    assigned_at: Mapped[datetime] = mapped_column(DateTime, nullable=False, default=datetime.utcnow)
    revoked_at: Mapped[datetime | None] = mapped_column(DateTime, nullable=True)
    created_at: Mapped[datetime] = mapped_column(DateTime, nullable=False, default=datetime.utcnow)

    # Relationships
    user: Mapped["User"] = relationship("User")
    role: Mapped["Role"] = relationship("Role")

    def __repr__(self) -> str:
        return f"<UserRole id={self.id} user_id={self.id_user} role_id={self.id_role}>"
