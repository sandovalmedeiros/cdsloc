"""Rentals ports module."""

from .repositories import (
    CdFisicoRepositoryPort,
    CustomerRepositoryPort,
    ReceiptRepositoryPort,
    RentalRepositoryPort,
)

__all__ = [
    "RentalRepositoryPort",
    "ReceiptRepositoryPort",
]

