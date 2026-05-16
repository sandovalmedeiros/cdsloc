"""Rentals ports module."""

from .repositories import (
    ReceiptRepositoryPort,
    RentalRepositoryPort,
)

__all__ = [
    "RentalRepositoryPort",
    "ReceiptRepositoryPort",
]
