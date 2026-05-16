"""Configuration for test environment.

Uses separate database instance to avoid affecting production data.
"""

from __future__ import annotations

import os
from pathlib import Path
from typing import Final

# Test database URL (separate from production)
TEST_DATABASE_URL: Final = "postgresql+asyncpg://test_user:test_pass@localhost:5433/cdloc_test"

# Test Redis URL (separate from production)
TEST_REDIS_URL: Final = "redis://localhost:6380/1"

# Test secret key
TEST_SECRET_KEY: Final = "test-secret-key-for-jwt-tokens"

# Test JWT algorithm
TEST_ALGORITHM: Final = "HS256"

# Test JWT expiration (1 hour)
TEST_ACCESS_TOKEN_EXPIRE_MINUTES: Final = 60

# Base directory for test files
BASE_DIR: Final = Path(__file__).resolve().parent.parent

# Test data directory
TEST_DATA_DIR: Final = BASE_DIR / "tests" / "fixtures" / "data"

# Legacy database path (for parity tests)
LEGACY_DATABASE_PATH: Final = BASE_DIR / "BD_CDLOC.mdb"

# Test fixtures directory
FIXTURES_DIR: Final = BASE_DIR / "tests" / "fixtures"

# Test results directory
TEST_RESULTS_DIR: Final = BASE_DIR / "tests" / "results"

# Create directories if they don't exist
TEST_DATA_DIR.mkdir(parents=True, exist_ok=True)
TEST_RESULTS_DIR.mkdir(parents=True, exist_ok=True)

# Environment variables for tests
os.environ.setdefault("DATABASE_URL", TEST_DATABASE_URL)
os.environ.setdefault("REDIS_URL", TEST_REDIS_URL)
os.environ.setdefault("SECRET_KEY", TEST_SECRET_KEY)
os.environ.setdefault("ALGORITHM", TEST_ALGORITHM)
os.environ.setdefault("ACCESS_TOKEN_EXPIRE_MINUTES", str(TEST_ACCESS_TOKEN_EXPIRE_MINUTES))