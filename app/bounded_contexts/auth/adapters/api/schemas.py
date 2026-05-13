"""Pydantic schemas (DTOs) for Auth bounded context API."""

from datetime import datetime
from typing import Optional

from pydantic import BaseModel, EmailStr, Field, ConfigDict


class UserRegisterRequest(BaseModel):
    """Request schema for user registration."""

    model_config = ConfigDict(extra="forbid")

    email: EmailStr = Field(..., description="Email do usuário")
    password: str = Field(..., min_length=8, max_length=64, description="Senha")
    full_name: Optional[str] = Field(None, description="Nome completo (opcional)")


class UserLoginRequest(BaseModel):
    """Request schema for user login."""

    model_config = ConfigDict(extra="forbid")

    email: EmailStr = Field(..., description="Email do usuário")
    password: str = Field(..., description="Senha do usuário")


class UserLoginResponse(BaseModel):
    """Response schema for user login."""

    model_config = ConfigDict(extra="forbid")

    access_token: str = Field(..., description="JWT access token")
    token_type: str = Field(default="bearer", description="Token type")
    expires_in: int = Field(..., description="Token expiration in seconds")
    user_id: int = Field(..., description="User ID")
    email: str = Field(..., description="User email")
    active: bool = Field(..., description="User active status")


class RefreshTokenRequest(BaseModel):
    """Request schema for token refresh."""

    model_config = ConfigDict(extra="forbid")

    user_id: int = Field(..., description="User ID")


class RefreshTokenResponse(BaseModel):
    """Response schema for token refresh."""

    model_config = ConfigDict(extra="forbid")

    access_token: str = Field(..., description="New JWT access token")
    token_type: str = Field(default="bearer", description="Token type")
    expires_in: int = Field(..., description="Token expiration in seconds")


class UserResponse(BaseModel):
    """Response schema for user data."""

    model_config = ConfigDict(extra="forbid")

    id: int = Field(..., description="User ID")
    email: str = Field(..., description="User email")
    active: bool = Field(..., description="User active status")
    created_at: datetime = Field(..., description="Creation timestamp")
    last_login_at: Optional[datetime] = Field(None, description="Last login timestamp")


class RoleResponse(BaseModel):
    """Response schema for role data."""

    model_config = ConfigDict(extra="forbid")

    id: int = Field(..., description="Role ID")
    nome: str = Field(..., description="Role name")
    permissions: list[str] = Field(..., description="Role permissions")


class MessageResponse(BaseModel):
    """Generic message response."""

    message: str = Field(..., description="Response message")
