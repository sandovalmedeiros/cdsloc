"""Domain entities for Auth bounded context.

Replaces legacy 'senha' single password (BR-HUMANA-001).
Supports multiple users with JWT tokens.
"""

from datetime import datetime

from sqlalchemy.orm import Mapped, mapped_column
from sqlalchemy import String, Boolean, DateTime
from sqlalchemy.dialects.postgresql import JSONB

from app.adapters.db.base import Base


class User(Base):
    """User entity.

    Business rules:
    - AUTH-001: Senha tem mínimo 8 caracteres (evoluido de 1→n)
    - AUTH-002: Máximo 3 tentativas de login (implementado no adapter)
    - AUTH-003: Confirmação dupla de senha (implementado no adapter)
    - AUTH-004: Sistema suporta múltiplos usuários (evolução BR-HUMANA-001)
    """

    __tablename__ = "users"

    id: Mapped[int] = mapped_column(primary_key=True)
    email: Mapped[str] = mapped_column(String(255), unique=True, nullable=False, index=True)
    password_hash: Mapped[str] = mapped_column(String(255), nullable=False)
    active: Mapped[bool] = mapped_column(Boolean, nullable=False, default=True, index=True)
    created_at: Mapped[datetime] = mapped_column(DateTime, nullable=False, default=datetime.utcnow)
    last_login_at: Mapped[datetime | None] = mapped_column(DateTime, nullable=True)

    def __repr__(self) -> str:
        return f"<User id={self.id} email={self.email} active={self.active}>"


class Role(Base):
    """Role entity with permissions.

    Permissions are JSONB arrays (ex: ["rentals:read", "rentals:write"]).
    """

    __tablename__ = "roles"

    id: Mapped[int] = mapped_column(primary_key=True)
    nome: Mapped[str] = mapped_column(String(100), unique=True, nullable=False)
    permissions: Mapped[dict[str, list[str]]] = mapped_column(
        JSONB, nullable=False, default=lambda: [], server_default="'[]'::jsonb",
    )
    created_at: Mapped[datetime] = mapped_column(DateTime, nullable=False, default=datetime.utcnow)
    updated_at: Mapped[datetime] = mapped_column(DateTime, nullable=False, default=datetime.utcnow)

    def __repr__(self) -> str:
        return f"<Role id={self.id} nome={self.nome}>"
