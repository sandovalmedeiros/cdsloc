"""Calculation parity tests.

Tests that compare calculation logic between legacy and new system.
Based on _reversa_sdd/migration/parity_specs.md section 9.

@critical: Penalty calculation affects revenue. Any error is unacceptable.
@critical: Expected return date affects stock management.
"""

from __future__ import annotations

from datetime import date, timedelta

import pytest

from app.bounded_contexts.rentals.services.calculation_service import (
    CalculationService,
)
from app.shared.domain import Multa
from app.tests.parity import ParityTag


class TestCalculationParity:
    """Test calculation parity for critical business rules.

    BR-MIGRAR-025: Expected return date calculation for 24h rental.
    BR-MIGRAR-026: Expected return date calculation for 48h rental.
    BR-MIGRAR-033: Penalty calculation (R$ 3,50/day overdue).
    """

    @pytest.mark.parametrize(
        "tipo_locacao, data_locacao, dias_esperados",
        [
            ("24h", date(2024, 1, 8), 1),  # Monday -> Tuesday (+1)
            ("24h", date(2024, 1, 9), 1),  # Tuesday -> Wednesday (+1)
            ("24h", date(2024, 1, 10), 1),  # Wednesday -> Thursday (+1)
            ("24h", date(2024, 1, 11), 1),  # Thursday -> Friday (+1)
            ("24h", date(2024, 1, 12), 1),  # Friday -> Saturday (+1)
            ("24h", date(2024, 1, 13), 2),  # Saturday -> Monday (+2, skip Sunday)
            ("24h", date(2024, 1, 14), 2),  # Sunday -> Tuesday (+2, skip Sunday)
            ("48h", date(2024, 1, 8), 2),  # Monday -> Wednesday (+2)
            ("48h", date(2024, 1, 9), 2),  # Tuesday -> Thursday (+2)
            ("48h", date(2024, 1, 10), 2),  # Wednesday -> Friday (+2)
            ("48h", date(2024, 1, 11), 2),  # Thursday -> Saturday (+2)
            ("48h", date(2024, 1, 12), 3),  # Friday -> Monday (+3, skip Sunday)
            ("48h", date(2024, 1, 13), 3),  # Saturday -> Tuesday (+3, skip Sunday)
            ("48h", date(2024, 1, 14), 3),  # Sunday -> Wednesday (+3, skip Sunday)
        ],
        ids=[
            "24h_monday",
            "24h_tuesday",
            "24h_wednesday",
            "24h_thursday",
            "24h_friday",
            "24h_saturday",
            "24h_sunday",
            "48h_monday",
            "48h_tuesday",
            "48h_wednesday",
            "48h_thursday",
            "48h_friday",
            "48h_saturday",
            "48h_sunday",
        ],
    )
    @pytest.mark.critical
    def test_expected_return_date_sunday_adjustment(
        self,
        tipo_locacao: str,
        data_locacao: date,
        dias_esperados: int,
    ) -> None:
        """Test that expected return date skips Sunday (BR-MIGRAR-025, BR-MIGRAR-026).

        Legacy behavior: If expected return date is Sunday, add 1 extra day.
        New system: Same logic via CalculationService.
        """
        data_prevista = CalculationService.calculate_data_prevista(
            data_locacao,
            tipo_locacao,
        )

        delta = data_prevista - data_locacao
        dias_adicionados = delta.days

        assert (
            dias_adicionados == dias_esperados
        ), f"Expected {dias_esperados} days, got {dias_adicionados}"

        # Verify that result is never Sunday
        assert data_prevista.weekday() != 6, "Expected return date cannot be Sunday"

    @pytest.mark.parametrize(
        "tipo_locacao, data_locacao, data_prevista_legada",
        [
            # 24h rentals
            ("24h", date(2024, 1, 15), date(2024, 1, 16)),  # Monday -> Tuesday
            ("24h", date(2024, 1, 16), date(2024, 1, 17)),  # Tuesday -> Wednesday
            ("24h", date(2024, 1, 17), date(2024, 1, 18)),  # Wednesday -> Thursday
            ("24h", date(2024, 1, 18), date(2024, 1, 19)),  # Thursday -> Friday
            ("24h", date(2024, 1, 19), date(2024, 1, 20)),  # Friday -> Saturday
            ("24h", date(2024, 1, 20), date(2024, 1, 22)),  # Saturday -> Monday (skip Sunday)
            # 48h rentals
            ("48h", date(2024, 1, 15), date(2024, 1, 17)),  # Monday -> Wednesday
            ("48h", date(2024, 1, 16), date(2024, 1, 18)),  # Tuesday -> Thursday
            ("48h", date(2024, 1, 17), date(2024, 1, 19)),  # Wednesday -> Friday
            ("48h", date(2024, 1, 18), date(2024, 1, 20)),  # Thursday -> Saturday
            ("48h", date(2024, 1, 19), date(2024, 1, 22)),  # Friday -> Monday (skip Sunday)
        ],
        ids=[
            "24h_monday_tuesday",
            "24h_tuesday_wednesday",
            "24h_wednesday_thursday",
            "24h_thursday_friday",
            "24h_friday_saturday",
            "24h_saturday_monday",
            "48h_monday_wednesday",
            "48h_tuesday_thursday",
            "48h_wednesday_friday",
            "48h_thursday_saturday",
            "48h_friday_monday",
        ],
    )
    @pytest.mark.critical
    def test_expected_return_date_parity(
        self,
        tipo_locacao: str,
        data_locacao: date,
        data_prevista_legada: date,
    ) -> None:
        """Test expected return date matches legacy system (BR-MIGRAR-025, BR-MIGRAR-026).

        Legacy expected return dates are known and documented.
        New system must produce identical results.
        """
        data_prevista_novo = CalculationService.calculate_data_prevista(
            data_locacao,
            tipo_locacao,
        )

        assert (
            data_prevista_novo == data_prevista_legada
        ), f"New system: {data_prevista_novo}, Legacy: {data_prevista_legada}"

    @pytest.mark.parametrize(
        "dias_atraso, multa_esperada",
        [
            (0, 0),  # No delay, no penalty
            (1, 3.50),  # 1 day overdue
            (2, 7.00),  # 2 days overdue
            (3, 10.50),  # 3 days overdue
            (5, 17.50),  # 5 days overdue
            (7, 24.50),  # 1 week overdue
            (10, 35.00),  # 10 days overdue
            (30, 105.00),  # 1 month overdue
        ],
        ids=[
            "on_time",
            "1_day_late",
            "2_days_late",
            "3_days_late",
            "5_days_late",
            "7_days_late",
            "10_days_late",
            "30_days_late",
        ],
    )
    @pytest.mark.critical
    def test_penalty_calculation(
        self,
        dias_atraso: int,
        multa_esperada: float,
    ) -> None:
        """Test penalty calculation matches R$ 3,50/day (BR-MIGRAR-033).

        Legacy behavior: Not specified in code (LACUNA), but requirement states R$ 3,50/dia.
        New system: Implements exactly R$ 3.50 per day overdue.
        """
        multa = CalculationService.calculate_multa(dias_atraso)

        assert multa.valor.to_float() == multa_esperada, (
            f"Penalty: R$ {multa.valor.to_float():.2f}, Expected: R$ {multa_esperada:.2f}"
        )
        assert multa.dias_atraso == dias_atraso

    @pytest.mark.parametrize(
        "data_atual, data_prevista, dias_atraso_esperado",
        [
            # On-time returns
            (date(2024, 1, 16), date(2024, 1, 16), 0),  # Exactly on expected date
            (date(2024, 1, 15), date(2024, 1, 16), 0),  # One day before expected date
            (date(2024, 1, 10), date(2024, 1, 16), 0),  # Several days before expected date
            # Late returns
            (date(2024, 1, 17), date(2024, 1, 16), 1),  # 1 day late
            (date(2024, 1, 18), date(2024, 1, 16), 2),  # 2 days late
            (date(2024, 1, 20), date(2024, 1, 16), 4),  # 4 days late
            (date(2024, 1, 26), date(2024, 1, 16), 10),  # 10 days late
        ],
        ids=[
            "exactly_on_time",
            "one_day_early",
            "several_days_early",
            "1_day_late",
            "2_days_late",
            "4_days_late",
            "10_days_late",
        ],
    )
    @pytest.mark.critical
    def test_days_overdue_calculation(
        self,
        data_atual: date,
        data_prevista: date,
        dias_atraso_esperado: int,
    ) -> None:
        """Test days overdue calculation (BR-MIGRAR-032).

        Legacy behavior: dias_atraso = MAX(0, data_atual - data_prevista)
        New system: Same logic via DiasAtraso value object.
        """
        dias_atraso = CalculationService.calculate_dias_atraso(
            data_atual,
            data_prevista,
        )

        assert (
            dias_atraso == dias_atraso_esperado
        ), f"Days overdue: {dias_atraso}, Expected: {dias_atraso_esperado}"

    @pytest.mark.critical
    def test_penalty_zero_when_on_time(self) -> None:
        """Test that penalty is zero when returned on time (BR-MIGRAR-033).

        No penalty should be charged if item is returned on or before expected date.
        """
        dias_atraso = 0  # On time
        multa = CalculationService.calculate_multa(dias_atraso)

        assert multa.valor.is_zero(), "Penalty should be zero when on time"
        assert multa.dias_atraso == 0

    @pytest.mark.critical
    def test_penalty_invariant(self) -> None:
        """Test that penalty calculation maintains invariant.

        Invariant: penalty = R$ 3.50 × days_overdue (BR-MIGRAR-033).
        This should never produce inconsistent values.
        """
        for dias_atraso in range(0, 100):  # Test 0 to 99 days
            multa = CalculationService.calculate_multa(dias_atraso)

            expected_value = 3.50 * dias_atraso
            actual_value = multa.valor.to_float()

            assert (
                actual_value == expected_value
            ), f"Days overdue: {dias_atraso}, Expected: R$ {expected_value:.2f}, Actual: R$ {actual_value:.2f}"

    @pytest.mark.high
    def test_invalid_rental_type_raises_error(self) -> None:
        """Test that invalid rental type raises error.

        Only "24h" and "48h" are valid rental types.
        """
        with pytest.raises(ValueError, match="Tipo de locação inválido"):
            CalculationService.calculate_data_prevista(date(2024, 1, 15), "72h")

        with pytest.raises(ValueError, match="Tipo de locação inválido"):
            CalculationService.calculate_data_prevista(date(2024, 1, 15), "1 semana")

    @pytest.mark.high
    def test_negative_overdue_days_handled(self) -> None:
        """Test that negative overdue days are handled gracefully.

        If returned early, days overdue should be 0.
        """
        data_atual = date(2024, 1, 15)
        data_prevista = date(2024, 1, 20)  # Expected in future

        dias_atraso = CalculationService.calculate_dias_atraso(
            data_atual,
            data_prevista,
        )

        assert dias_atraso == 0, "Negative overdue days should be treated as 0"
        assert (
            CalculationService.calculate_multa(dias_atraso).valor.to_float() == 0
        ), "No penalty for early return"

    @pytest.mark.high
    def test_large_overdue_periods(self) -> None:
        """Test penalty calculation for large overdue periods.

        Some rentals might be returned months late. System should handle this.
        """
        # Test 30, 60, 90, 180, 365 days overdue
        for dias_atraso in [30, 60, 90, 180, 365]:
            multa = CalculationService.calculate_multa(dias_atraso)
            expected_value = 3.50 * dias_atraso

            assert (
                multa.valor.to_float() == expected_value
            ), f"Days overdue: {dias_atraso}, Expected: R$ {expected_value:.2f}"