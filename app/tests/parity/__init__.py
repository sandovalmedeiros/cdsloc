"""Parity test suite.

Tests that compare the behavior of the new system against the legacy system
to ensure behavioral equivalence.

Based on _reversa_sdd/migration/parity_specs.md
"""

from __future__ import annotations

from datetime import date, datetime
from decimal import Decimal

import pytest

from app.bounded_contexts.rentals.services.calculation_service import (
    CalculationService,
)
from app.shared.domain import DataPrevista, Multa


class ParityTag:
    """Tags for parity test priorities based on parity_specs.md.

    @critical: Blocks cutover if fails. Tests critical functionality (penalty, stock, auth).
    @high: High priority for correction before cutover.
    @medium: Medium priority for correction before cutover.
    @low: Low priority, can be fixed after cutover if it doesn't affect critical functionality.
    """

    CRITICAL = "critical"
    HIGH = "high"
    MEDIUM = "medium"
    LOW = "low"


# Test fixtures


@pytest.fixture
def penalty_rate() -> Decimal:
    """Return the penalty rate defined in BR-MIGRAR-033 (R$ 3,50/dia)."""
    return Decimal("3.50")


@pytest.fixture
def legacy_penalty_rate() -> Decimal:
    """Return the legacy penalty rate (if different from new system)."""
    return Decimal("3.50")