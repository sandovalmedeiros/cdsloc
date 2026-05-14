"""Catalog domain module."""

from .entities import CdFisico, Interprete, Musica, SituacaoCd, Title, TipoLocacao

__all__ = [
    "CdFisico",
    "Interprete",
    "Musica",
    "SituacaoCd",
    "Title",
    "TipoLocacao",
]

# Re-export for use by other bounded contexts (Rentals needs Title)
Title.__module__ = __name__
