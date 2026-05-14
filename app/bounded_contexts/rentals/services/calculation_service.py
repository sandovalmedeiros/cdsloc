"""Calculation service for rentals domain.

Implements business rules for calculating expected return date and penalties.
"""

from __future__ import annotations

from datetime import date

from app.shared.domain import DataPrevista, Multa


class CalculationService:
    """Domain service for rental calculations.

    BR-MIGRAR-025: Cálculo de data prevista 24h.
    BR-MIGRAR-026: Cálculo de data prevista 48h.
    BR-MIGRAR-033: Cálculo de multa (R$ 3,50/dia).
    """

    @staticmethod
    def calculate_data_prevista(
        data_locacao: date, tipo_locacao: str
    ) -> date:
        """Calculate expected return date (RENT-004, RENT-005).

        Args:
            data_locacao: Rental start date
            tipo_locacao: '24h' or '48h'

        Returns:
            Expected return date

        BR-MIGRAR-025: 24h rental + 1 day (2 if Sunday)
        BR-MIGRAR-026: 48h rental + 2 days (3 if Sunday)
        """
        data_prevista_vo = DataPrevista.calculate(
            data_locacao=data_locacao,
            tipo_locacao=tipo_locacao,
        )
        return data_prevista_vo.valor

    @staticmethod
    def calculate_multa(dias_atraso: int) -> Multa:
        """Calculate penalty for late return (RENT-010).

        Args:
            dias_atraso: Number of days overdue

        Returns:
            Multa value object

        BR-MIGRAR-033: Multa = R$ 3,50 × dias_atraso
        """
        return Multa.calculate(dias_atraso)

    @staticmethod
    def calculate_dias_atraso(
        data_atual: date, data_prevista: date
    ) -> int:
        """Calculate days overdue (RENT-009).

        Args:
            data_atual: Current date
            data_prevista: Expected return date

        Returns:
            Number of days overdue (0 if not overdue)

        BR-MIGRAR-032: dias_atraso = MAX(0, data_atual - data_prevista)
        """
        from app.shared.domain import DiasAtraso

        dias_vo = DiasAtraso.calculate(
            data_atual=data_atual,
            data_prevista=data_prevista,
        )
        return dias_vo.valor
