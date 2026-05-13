"""FastAPI router for Auth bounded context.

Provides endpoints:
- POST /auth/register - Register new user
- POST /auth/login - Authenticate user, get JWT token
- POST /auth/refresh - Refresh JWT token
- POST /auth/logout - Invalidate token (not implemented yet)
"""

from typing import Annotated

from fastapi import APIRouter, Depends, HTTPException, status
from pydantic import EmailStr

from app.bounded_contexts.auth.domain.user import User
from app.bounded_contexts.auth.services.auth_service import IAuthService
from app.bounded_contexts.auth.adapters.api.schemas import (
    UserRegisterRequest,
    UserLoginRequest,
    UserLoginResponse,
    RefreshTokenRequest,
    RefreshTokenResponse,
    UserResponse,
    RoleResponse,
    MessageResponse,
)
from app.shared.infrastructure.config import get_settings

router = APIRouter(prefix="/api/v1/auth", tags=["authentication"])
settings = get_settings()


async def get_auth_service() -> IAuthService:
    """Dependency to get auth service instance.

    In production, this would use dependency injection.
    For now, return a mock or placeholder.
    """
    from app.bounded_contexts.auth.adapters.db.user_repository import UserRepository
    from app.bounded_contexts.auth.adapters.db.role_repository import RoleRepository
    from app.bounded_contexts.auth.services.auth_service import AuthService
    from app.adapters.db.base import get_db_no_context

    session = get_db_no_context()
    user_repo = UserRepository(session)
    role_repo = RoleRepository(session)
    return AuthService(user_repo, role_repo)


@router.post("/register", response_model=UserResponse, status_code=status.HTTP_201_CREATED)
async def register(
    user_data: UserRegisterRequest,
    auth_service: Annotated[IAuthService, Depends(get_auth_service)],
) -> UserResponse:
    """Register a new user."""
    try:
        user = await auth_service.register(
            email=user_data.email,
            password=user_data.password,
            full_name=user_data.full_name,
        )
        return UserResponse(
            id=user.id,
            email=user.email,
            active=user.active,
            created_at=user.created_at,
            last_login_at=user.last_login_at,
        )
    except ValueError as e:
        raise HTTPException(status_code=status.HTTP_400_BAD_REQUEST, detail=str(e))


@router.post("/login", response_model=UserLoginResponse, status_code=status.HTTP_200_OK)
async def login(
    user_data: UserLoginRequest,
    auth_service: Annotated[IAuthService, Depends(get_auth_service)],
) -> UserLoginResponse:
    """Authenticate user and return JWT token.

    Replaces legacy single password authentication (BR-HUMANA-001).
    """
    try:
        user, token = await auth_service.login(user_data.email, user_data.password)
        return UserLoginResponse(
            access_token=token,
            token_type="bearer",
            expires_in=settings.jwt_expiration_minutes * 60,
            user_id=user.id,
            email=user.email,
            active=user.active,
        )
    except ValueError as e:
        raise HTTPException(status_code=status.HTTP_401_UNAUTHORIZED, detail=str(e))


@router.post("/refresh", response_model=RefreshTokenResponse, status_code=status.HTTP_200_OK)
async def refresh_token(
    token_data: RefreshTokenRequest,
    auth_service: Annotated[IAuthService, Depends(get_auth_service)],
) -> RefreshTokenResponse:
    """Refresh JWT token."""
    try:
        token = await auth_service.refresh_token(token_data.user_id)
        return RefreshTokenResponse(
            access_token=token,
            token_type="bearer",
            expires_in=settings.jwt_expiration_minutes * 60,
        )
    except ValueError as e:
        raise HTTPException(status_code=status.HTTP_401_UNAUTHORIZED, detail=str(e))


@router.post("/validate", status_code=status.HTTP_200_OK)
async def validate_token(
    token: str,
    auth_service: Annotated[IAuthService, Depends(get_auth_service)],
) -> dict[str, int]:
    """Validate JWT token and return user_id."""
    try:
        user_id = await auth_service.validate_token(token)
        return {"user_id": user_id, "valid": True}
    except ValueError as e:
        raise HTTPException(status_code=status.HTTP_401_UNAUTHORIZED, detail=str(e))


@router.get("/me", response_model=UserResponse, status_code=status.HTTP_200_OK)
async def get_current_user(
    token: str,
    auth_service: Annotated[IAuthService, Depends(get_auth_service)],
) -> UserResponse:
    """Get current authenticated user."""
    try:
        user_id = await auth_service.validate_token(token)
        from app.bounded_contexts.auth.services.auth_service import AuthService

        session = None
        from app.adapters.db.base import get_db_no_context

        session = get_db_no_context()
        user_repo = AuthService.__init__.__dict__["user_repo"]

        user = await user_repo.get_by_id(user_id)

        if not user:
            raise HTTPException(status_code=status.HTTP_404_NOT_FOUND)

        return UserResponse(
            id=user.id,
            email=user.email,
            active=user.active,
            created_at=user.created_at,
            last_login_at=user.last_login_at,
        )
    except ValueError as e:
        raise HTTPException(status_code=status.HTTP_401_UNAUTHORIZED, detail=str(e))


@router.post("/logout", response_model=MessageResponse, status_code=status.HTTP_200_OK)
async def logout() -> MessageResponse:
    """Logout user (invalidate token).

    Not implemented in phase 1 - placeholder.
    """
    return MessageResponse(message="Logout não implementado (placeholder)")
