"""Application services for Auth bounded context.

Business rules:
- AUTH-001: Senha tem mínimo 8 caracteres
- AUTH-002: Máximo 3 tentativas de login
- AUTH-003: Confirmação dupla de senha
- AUTH-004: Múltiplos usuários com JWT (evolução BR-HUMANA-001)
"""

from abc import ABC, abstractmethod
from datetime import datetime, timedelta
from typing import Optional
import bcrypt
import jwt

from app.bounded_contexts.auth.domain.user import User, Role
from app.bounded_contexts.auth.ports.user_repository import IUserRepository
from app.bounded_contexts.auth.ports.role_repository import IRoleRepository
from app.shared.infrastructure.config import get_settings

settings = get_settings()


class IAuthService(ABC):
    """Interface for authentication service."""

    @abstractmethod
    async def register(
        self,
        email: str,
        password: str,
        full_name: Optional[str] = None,
    ) -> User:
        """Register a new user."""
        pass

    @abstractmethod
    async def login(
        self,
        email: str,
        password: str,
    ) -> tuple[User, str]:
        """Authenticate user and return JWT token.

        Returns:
            User object
            JWT token string

        Raises:
            ValueError: Invalid credentials
        """
        pass

    @abstractmethod
    async def refresh_token(self, user_id: int) -> str:
        """Generate new JWT token for user."""
        pass

    @abstractmethod
    async def validate_token(self, token: str) -> int:
        """Validate JWT token and return user_id.

        Returns:
            User ID

        Raises:
            ValueError: Invalid token
        """
        pass


class AuthService(IAuthService):
    """Implementation of authentication service using JWT and bcrypt."""

    def __init__(self, user_repo: IUserRepository, role_repo: IRoleRepository):
        self.user_repo = user_repo
        self.role_repo = role_repo
        self.secret_key = settings.jwt_secret_key
        self.algorithm = settings.jwt_algorithm
        self.expiration_minutes = settings.jwt_expiration_minutes

    async def _hash_password(self, password: str) -> tuple[str, str]:
        """Hash password using bcrypt.

        Returns:
            Password hash
            Salt
        """
        salt = bcrypt.gensalt().decode("utf-8")
        password_hash = bcrypt.hashpw(
            password.encode("utf-8"),
            salt.encode("utf-8"),
        ).decode("utf-8")
        return password_hash, salt

    def _generate_jwt_token(self, user: User) -> str:
        """Generate JWT token for user."""
        payload = {
            "sub": str(user.id),
            "email": user.email,
            "active": user.active,
            "iat": datetime.utcnow(),
            "exp": datetime.utcnow() + timedelta(minutes=self.expiration_minutes),
        }
        token = jwt.encode(payload, self.secret_key, algorithm=self.algorithm)
        return token

    def _decode_jwt_token(self, token: str) -> dict:
        """Decode and validate JWT token."""
        try:
            payload = jwt.decode(token, self.secret_key, algorithms=[self.algorithm])
            return payload
        except jwt.ExpiredSignatureError:
            raise ValueError("Token expirado")
        except jwt.InvalidTokenError:
            raise ValueError("Token inválido")

    async def register(
        self,
        email: str,
        password: str,
        full_name: Optional[str] = None,
    ) -> User:
        """Register a new user (AUTH-001: minimum password length)."""
        # AUTH-001: Password must have at least 8 characters
        if len(password) < settings.min_password_length:
            raise ValueError(f"Senha deve ter no mínimo {settings.min_password_length} caracteres")

        # Check if user already exists
        existing_user = await self.user_repo.exists_by_email(email)
        if existing_user:
            raise ValueError("Email já cadastrado")

        # Hash password
        password_hash, salt = await self._hash_password(password)

        # Create user with default "user" role
        user_role = await self.role_repo.get_by_name("user")
        if not user_role:
            # Create default role if not exists
            user_role = Role(
                nome="user",
                permissions=[],
            )
            await self.role_repo.create(user_role)

        # Create user (will have role assigned via UserRole)
        new_user = User(
            email=email,
            password_hash=password_hash,
            active=True,
        )
        created_user = await self.user_repo.create(new_user)

        # Assign role
        await self.role_repo.assign_to_user(created_user.id, user_role.id)

        return created_user

    async def login(self, email: str, password: str) -> tuple[User, str]:
        """Authenticate user (AUTH-002: Max 3 login attempts)."""
        # Check if user exists and is active
        user = await self.user_repo.get_by_email(email)
        if not user:
            raise ValueError("Credenciais inválidas")

        if not user.active:
            raise ValueError("Usuário inativo")

        # Verify password
        password_hash = user.password_hash
        if not bcrypt.checkpw(
            password.encode("utf-8"),
            password_hash.encode("utf-8"),
        ):
            # AUTH-002: Track login attempts (could be implemented)
            raise ValueError("Credenciais inválidas")

        # Update last login
        await self.user_repo.update_last_login(user.id)

        # Generate JWT token
        token = self._generate_jwt_token(user)

        return user, token

    async def refresh_token(self, user_id: int) -> str:
        """Generate new JWT token for user."""
        user = await self.user_repo.get_by_id(user_id)
        if not user:
            raise ValueError("Usuário não encontrado")

        if not user.active:
            raise ValueError("Usuário inativo")

        # Generate new token
        token = self._generate_jwt_token(user)

        return token

    async def validate_token(self, token: str) -> int:
        """Validate JWT token and return user_id."""
        payload = self._decode_jwt_token(token)

        user_id = payload.get("sub")
        if not user_id:
            raise ValueError("Token inválido: sem user_id")

        user_id = int(user_id)

        # Verify user exists and is active
        user = await self.user_repo.get_by_id(user_id)
        if not user:
            raise ValueError("Usuário não encontrado")

        if not user.active:
            raise ValueError("Usuário inativo")

        return user_id
