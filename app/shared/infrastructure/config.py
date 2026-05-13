"""Application configuration using Pydantic Settings."""

from functools import lru_cache
from typing import Literal

from pydantic import Field
from pydantic_settings import BaseSettings, SettingsConfigDict


class Settings(BaseSettings):
    """Application settings loaded from environment variables."""

    model_config = SettingsConfigDict(
        env_file=".env",
        env_file_encoding="utf-8",
        case_sensitive=False,
    )

    # Database
    database_url: str = Field(
        default="postgresql+asyncpg://cdsloc:cdsloc_password@localhost:5432/cdsloc",
        description="PostgreSQL async connection URL",
    )

    # Redis
    redis_url: str = Field(
        default="redis://localhost:6379/0",
        description="Redis connection URL for event bus and cache",
    )

    # JWT
    jwt_secret_key: str = Field(
        default="change-this-in-production",
        description="Secret key for JWT token signing",
    )
    jwt_algorithm: Literal["HS256", "RS256"] = Field(
        default="HS256",
        description="JWT algorithm",
    )
    jwt_expiration_minutes: int = Field(
        default=30,
        description="JWT token expiration time in minutes",
    )

    # Application
    app_name: str = Field(default="CDsLoc", description="Application name")
    app_version: str = Field(default="0.1.0", description="Application version")
    debug: bool = Field(default=False, description="Debug mode")

    # CORS
    cors_origins: list[str] = Field(
        default=["http://localhost:3000", "http://localhost:8080"],
        description="Allowed CORS origins",
    )


@lru_cache
def get_settings() -> Settings:
    """Get cached settings instance."""
    return Settings()
