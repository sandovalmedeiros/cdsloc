"""Rental repository implementations (adapters) for PostgreSQL.

Implements RentalRepositoryPort and ReceiptRepositoryPort using SQLAlchemy async.
"""

from __future__ import annotations

from datetime import date, datetime
from decimal import Decimal
from typing import TYPE_CHECKING, Iterable

from sqlalchemy import select
from sqlalchemy.ext.asyncio import AsyncSession

from app.adapters.db.models import (
    Cliente,
    Dependente,
    Locacao,
    LocacaoItem,
    Recibo,
)
from app.bounded_contexts.catalog.domain.entities import SituacaoCd
from app.bounded_contexts.catalog.ports.repositories import (
    CdFisicoRepositoryPort,
    TitleRepositoryPort,
)
from app.bounded_contexts.customers.ports.repositories import (
    CustomerRepositoryPort,
    DependentRepositoryPort,
)
from app.bounded_contexts.rentals.domain.entities import Locacao as LocacaoDomain
from app.bounded_contexts.rentals.domain.entities import Recibo as ReciboDomain
from app.bounded_contexts.rentals.ports.repositories import (
    ReceiptRepositoryPort,
    RentalRepositoryPort,
)
from app.shared.domain import DomainEvent, locacao_criada, recibo_gerado

if TYPE_CHECKING:
    from app.bounded_contexts.catalog.domain.entities import CdFisico, Title


class PostgresRentalRepository(RentalRepositoryPort):
    """PostgreSQL implementation of RentalRepositoryPort."""

    def __init__(self, session: AsyncSession) -> None:
        self._session = session

    async def get_by_id(self, codlocacao: int) -> LocacaoDomain | None:
        """Get rental by ID."""
        stmt = select(Locacao).where(Locacao.id == codlocacao)
        result = await self._session.execute(stmt)
        locacao_model = result.scalar_one_or_none()

        if not locacao_model:
            return None

        return self._model_to_domain(locacao_model)

    async def get_all(
        self, skip: int = 0, limit: int = 100
    ) -> Iterable[LocacaoDomain]:
        """Get all rentals with pagination."""
        stmt = select(Locacao).offset(skip).limit(limit).order_by(Locacao.id)
        result = await self._session.execute(stmt)
        locacoes = result.scalars().all()

        return [self._model_to_domain(loc) for loc in locacoes]

    async def get_pending(self) -> Iterable[LocacaoDomain]:
        """Get rentals that are pending return."""
        # A rental is pending if its receipt is not returned
        stmt = (
            select(Locacao)
            .join(Recibo, Locacao.id == Recibo.id_locacao)
            .where(Recibo.is_devolvido == False)
            .order_by(Locacao.data_prevista)
        )
        result = await self._session.execute(stmt)
        locacoes = result.scalars().all()

        return [self._model_to_domain(loc) for loc in locacoes]

    async def get_by_customer_id(
        self, codcliente: int
    ) -> Iterable[LocacaoDomain]:
        """Get all rentals for a customer."""
        stmt = (
            select(Locacao)
            .where(Locacao.id_cliente == codcliente)
            .order_by(Locacao.data_locacao.desc())
        )
        result = await self._session.execute(stmt)
        locacoes = result.scalars().all()

        return [self._model_to_domain(loc) for loc in locacoes]

    async def save(self, locacao: LocacaoDomain) -> DomainEvent:
        """Save rental and emit LocacaoCriada event if new."""
        # Check if it's a new rental (id == 0)
        is_new = locacao.codlocacao == 0

        locacao_model = self._domain_to_model(locacao)

        self._session.add(locacao_model)

        # If new, we need to flush to get the ID
        if is_new:
            await self._session.flush()
            object.__setattr__(locacao, "codlocacao", locacao_model.id)

            # Create rental item for the CD
            item = LocacaoItem(
                id_locacao=locacao_model.id,
                id_cd=str(locacao.codcd),
                valor_item=locacao.valor_locacao,
            )
            self._session.add(item)

        # Emit event only for new rentals
        if is_new:
            cd_codigo = locacao.codcd
            event = locacao_criada(
                codlocacao=locacao_model.id,
                codcliente=locacao.codcliente,
                cd_codigo=cd_codigo,
                data_locacao=locacao.data_locacao,
                data_prevista=locacao.data_prevista,
                valor=locacao.valor_locacao,
            )
            return event

        return None

    async def update(self, locacao: LocacaoDomain) -> DomainEvent | None:
        """Update rental and emit event if needed."""
        stmt = select(Locacao).where(Locacao.id == locacao.codlocacao)
        result = await self._session.execute(stmt)
        locacao_model = result.scalar_one_or_none()

        if not locacao_model:
            return None

        # Update fields
        locacao_model.valor_multa = locacao.valor_multa
        locacao_model.updated_at = datetime.utcnow()

        return None

    async def get_title_by_cd(self, cd_codigo: int) -> "Title | None":
        """Get title by CD code (for rental calculation)."""
        from app.adapters.db.models import Cd, Title as TitleModel

        stmt = (
            select(TitleModel)
            .join(Cd, Cd.id_titulo == TitleModel.id)
            .where(Cd.codigo == str(cd_codigo))
        )
        result = await self._session.execute(stmt)
        title_model = result.scalar_one_or_none()

        if not title_model:
            return None

        # Import here to avoid circular dependency
        from app.bounded_contexts.catalog.domain.entities import Title, TipoLocacao

        return Title(
            id=title_model.id,
            nome=title_model.nome,
            tipo_locacao=TipoLocacao(title_model.tipo_locacao),
            valor=Decimal(title_model.valor),
            qtde=title_model.qtde,
            cdgrupo=title_model.id_grupo,
            cdestilo=title_model.id_estilo,
            cds=[],
            musicas=[],
            interpretes=[],
        )

    async def delete(self, codlocacao: int) -> None:
        """Delete rental by ID."""
        stmt = select(Locacao).where(Locacao.id == codlocacao)
        result = await self._session.execute(stmt)
        locacao = result.scalar_one_or_none()

        if locacao:
            await self._session.delete(locacao)

    def _model_to_domain(self, locacao: Locacao) -> LocacaoDomain:
        """Convert ORM model to domain entity."""
        # Get recibo if available
        recibo_domain = None
        if hasattr(locacao, "recibo") and locacao.recibo:
            recibo_domain = self._recibo_model_to_domain(locacao.recibo)

        # Get CD code from first item
        cd_codigo = 0
        if hasattr(locacao, "itens") and locacao.itens:
            cd_codigo = int(locacao.itens[0].id_cd) if locacao.itens[0].id_cd else 0

        return LocacaoDomain(
            codlocacao=locacao.id,
            codcliente=locacao.id_cliente,
            coddependente=locacao.id_dependente,
            codcd=cd_codigo,
            data_locacao=locacao.data_locacao,
            data_prevista=locacao.data_prevista,
            valor_locacao=Decimal(locacao.valor_locacao),
            situacao="Pendente" if not locacao.recibo or not locacao.recibo.is_devolvido else "Devolvido",
            valor_multa=Decimal(locacao.valor_multa),
            data_devolucao=locacao.recibo.data_devolucao.date() if locacao.recibo and locacao.recibo.data_devolucao else None,
            codrecibo=locacao.recibo.id if locacao.recibo else None,
            recibo=recibo_domain,
        )

    def _domain_to_model(self, locacao: LocacaoDomain) -> Locacao:
        """Convert domain entity to ORM model."""
        return Locacao(
            id=locacao.codlocacao if locacao.codlocacao != 0 else None,
            id_cliente=locacao.codcliente,
            id_dependente=locacao.cddependente,
            data_locacao=locacao.data_locacao,
            data_prevista=locacao.data_prevista,
            valor_locacao=locacao.valor_locacao,
            valor_multa=locacao.valor_multa,
            data_devolucao=locacao.data_devolucao,
        )

    def _recibo_model_to_domain(self, recibo: Recibo) -> ReciboDomain:
        """Convert receipt ORM model to domain entity."""
        return ReciboDomain(
            codrecibo=recibo.id,
            codcliente=recibo.id_cliente,
            data_emissao=recibo.data_emissao,
            valor_total=Decimal(recibo.valor_total),
            devolvido=recibo.is_devolvido,
            locacoes=[],
        )


class PostgresReceiptRepository(ReceiptRepositoryPort):
    """PostgreSQL implementation of ReceiptRepositoryPort."""

    def __init__(self, session: AsyncSession) -> None:
        self._session = session

    async def get_by_id(self, codrecibo: int) -> ReciboDomain | None:
        """Get receipt by ID."""
        stmt = select(Recibo).where(Recibo.id == codrecibo)
        result = await self._session.execute(stmt)
        recibo_model = result.scalar_one_or_none()

        if not recibo_model:
            return None

        return self._model_to_domain(recibo_model)

    async def get_all(
        self, skip: int = 0, limit: int = 100
    ) -> Iterable[ReciboDomain]:
        """Get all receipts with pagination."""
        stmt = select(Recibo).offset(skip).limit(limit).order_by(Recibo.id)
        result = await self._session.execute(stmt)
        recibos = result.scalars().all()

        return [self._model_to_domain(rec) for rec in recibos]

    async def get_by_customer_id(
        self, codcliente: int
    ) -> Iterable[ReciboDomain]:
        """Get all receipts for a customer."""
        stmt = (
            select(Recibo)
            .where(Recibo.id_cliente == codcliente)
            .order_by(Recibo.data_emissao.desc())
        )
        result = await self._session.execute(stmt)
        recibos = result.scalars().all()

        return [self._model_to_domain(rec) for rec in recibos]

    async def save(self, recibo: ReciboDomain) -> DomainEvent:
        """Save receipt and emit ReciboGerado event if new."""
        # Check if it's a new receipt (id == 0)
        is_new = recibo.codrecibo == 0

        # For new receipt, create it with the rental ID
        if is_new and recibo.locacoes:
            locacao_id = recibo.locacoes[0].codlocacao
        else:
            locacao_id = 0

        recibo_model = Recibo(
            id=recibo.codrecibo if recibo.codrecibo != 0 else None,
            id_locacao=locacao_id,
            id_cliente=recibo.codcliente,
            data_emissao=recibo.data_emissao,
            valor_total=recibo.valor_total,
            is_devolvido=recibo.devolvido,
        )

        self._session.add(recibo_model)

        # If new, we need to flush to get the ID
        if is_new:
            await self._session.flush()
            object.__setattr__(recibo, "codrecibo", recibo_model.id)

        # Emit event only for new receipts
        if is_new:
            event = recibo_gerado(
                codrecibo=recibo_model.id,
                codlocacao=locacao_id,
                valor_total=Decimal(recibo.valor_total),
            )
            return event

        return None

    async def update(self, recibo: ReciboDomain) -> DomainEvent | None:
        """Update receipt."""
        stmt = select(Recibo).where(Recibo.id == recibo.codrecibo)
        result = await self._session.execute(stmt)
        recibo_model = result.scalar_one_or_none()

        if not recibo_model:
            return None

        # Update fields
        recibo_model.is_devolvido = recibo.devolvido
        recibo_model.valor_total = recibo.valor_total
        if recibo.devolvido and not recibo_model.data_devolucao:
            recibo_model.data_devolucao = datetime.utcnow()
        recibo_model.updated_at = datetime.utcnow()

        return None

    async def delete(self, codrecibo: int) -> None:
        """Delete receipt by ID."""
        stmt = select(Recibo).where(Recibo.id == codrecibo)
        result = await self._session.execute(stmt)
        recibo = result.scalar_one_or_none()

        if recibo:
            await self._session.delete(recibo)

    def _model_to_domain(self, recibo: Recibo) -> ReciboDomain:
        """Convert ORM model to domain entity."""
        return ReciboDomain(
            codrecibo=recibo.id,
            codcliente=recibo.id_cliente,
            data_emissao=recibo.data_emissao,
            valor_total=Decimal(recibo.valor_total),
            devolvido=recibo.is_devolvido,
            locacoes=[],
        )
