"""Catalog repository implementations.

PostgreSQL async repository implementations for catalog bounded context.
"""

from __future__ import annotations

from typing import AsyncIterable, Iterable
from sqlalchemy import select, func, and_, or_, delete as sql_delete
from sqlalchemy.ext.asyncio import AsyncSession

from app.bounded_contexts.catalog.ports.repositories import (
    CdFisicoRepositoryPort,
    InterpreteRepositoryPort,
    MusicaRepositoryPort,
    TitleRepositoryPort,
)
from app.bounded_contexts.catalog.domain.entities import (
    CdFisico,
    Interprete,
    Musica,
    SituacaoCd,
    Title,
)
from app.adapters.db.models import Cd as CdModel, Titulo as TituloModel
from app.shared.domain.events import DomainEvent


class PostgresTitleRepository(TitleRepositoryPort):
    """PostgreSQL async repository for Title aggregate."""

    def __init__(self, session: AsyncSession) -> None:
        self._session = session

    async def get_by_id(self, title_id: int) -> Title | None:
        """Get title by ID with all nested entities."""
        result = await self._session.execute(
            select(TituloModel).where(TituloModel.id == title_id)
        )
        model = result.scalar_one_or_none()
        if not model:
            return None

        return self._model_to_domain(model)

    async def get_all(
        self, skip: int = 0, limit: int = 100
    ) -> AsyncIterable[Title]:
        """Get all titles with pagination."""
        result = await self._session.execute(
            select(TituloModel).offset(skip).limit(limit)
        )
        for model in result.scalars():
            yield self._model_to_domain(model)

    async def search_by_name(self, name: str) -> AsyncIterable[Title]:
        """Search titles by name (case-insensitive)."""
        result = await self._session.execute(
            select(TituloModel).where(
                TituloModel.nome.ilike(f"%{name}%")
            )
        )
        for model in result.scalars():
            yield self._model_to_domain(model)

    async def save(self, title: Title) -> DomainEvent:
        """Save title and emit TitleCreated event if new."""
        from app.shared.domain import title_created, EventType

        is_new = title.id == 0

        if is_new:  # New title
            model = TituloModel(
                nome=title.nome,
                valor=float(title.valor),
                tipo_locacao=title.tipo_locacao,
                qtde=title.qtde,
                id_grupo=title.cdgrupo,
                id_estilo=title.cdestilo,
            )
            self._session.add(model)
            await self._session.flush()
            title.id = model.id

            # Create physical CDs if qtde > 0
            if title.qtde and title.qtde > 0:
                for i in range(1, title.qtde + 1):
                    cd_model = CdModel(
                        codigo=str(title.id).zfill(6) + str(i).zfill(3),  # Format: TITULO_ID + CD_NUM
                        numcd=f"{title.nome} - CD {i}",
                        id_titulo=title.id,
                        situacao_id=1,  # 1 = Available
                    )
                    self._session.add(cd_model)
                await self._session.flush()  # Flush CDs to ensure they're saved
        else:  # Update existing title
            result = await self._session.execute(
                select(TituloModel).where(TituloModel.id == title.id)
            )
            model = result.scalar_one_or_none()
            if model:
                old_qtde = model.qtde or 0
                new_qtde = title.qtde or 0

                model.nome = title.nome
                model.valor = float(title.valor)
                model.tipo_locacao = title.tipo_locacao
                model.qtde = title.qtde
                model.id_grupo = title.cdgrupo
                model.id_estilo = title.cdestilo

                # Handle CD quantity changes
                if new_qtde != old_qtde:
                    # Get current CDs for this title
                    cds_result = await self._session.execute(
                        select(CdModel).where(CdModel.id_titulo == title.id)
                    )
                    current_cds = list(cds_result.scalars().all())
                    current_count = len(current_cds)

                    if new_qtde > current_count:
                        # Create additional CDs
                        for i in range(current_count + 1, new_qtde + 1):
                            cd_model = CdModel(
                                codigo=str(title.id).zfill(6) + str(i).zfill(3),
                                numcd=f"{title.nome} - CD {i}",
                                id_titulo=title.id,
                                situacao_id=1,  # 1 = Available
                            )
                            self._session.add(cd_model)
                    elif new_qtde < current_count:
                        # Remove excess CDs (only if not rented)
                        # Extract CD number from numcd (format: "Title Name - CD X")
                        import re

                        def extract_cd_num(cd):
                            match = re.search(r'CD (\d+)$', cd.numcd)
                            return int(match.group(1)) if match else 0

                        # Sort by CD number descending to remove the last ones
                        sorted_cds = sorted(current_cds, key=extract_cd_num, reverse=True)
                        cds_to_remove = current_count - new_qtde

                        for cd in sorted_cds[:cds_to_remove]:
                            if cd.situacao_id == 1:  # Only remove if available
                                await self._session.execute(
                                    sql_delete(CdModel).where(CdModel.codigo == cd.codigo)
                                )
                            else:
                                raise ValueError(
                                    f"Não é possível reduzir a quantidade. CD {cd.codigo} está locado."
                                )

        await self._session.commit()

        if is_new:
            return title_created(
                titulo_id=title.id,
                nome=title.nome,
                tipo_locacao=str(title.tipo_locacao),
                valor=title.valor,
            )
        else:
            # For updates, we could emit a different event type
            # For now, just return a minimal event
            return DomainEvent.create(
                event_type=EventType.STOCK_UPDATED,  # Using existing event type for simplicity
                aggregate_id=title.id,
                aggregate_type="Title",
                data={
                    "titulo_id": title.id,
                    "nome": title.nome,
                },
            )

    async def update(self, title: Title) -> list[DomainEvent]:
        """Update title and emit events."""
        event = await self.save(title)
        return [event]

    async def delete(self, title_id: int) -> None:
        """Delete title by ID.

        Uses raw DELETE to respect database CASCADE constraints.
        """
        from sqlalchemy import delete as sql_delete

        # First check if title exists
        result = await self._session.execute(
            select(TituloModel).where(TituloModel.id == title_id)
        )
        model = result.scalar_one_or_none()
        if not model:
            return

        # Use raw DELETE statement to let database handle CASCADE
        await self._session.execute(
            sql_delete(TituloModel).where(TituloModel.id == title_id)
        )
        await self._session.commit()

    async def get_available_cds(
        self, title_id: int
    ) -> AsyncIterable[CdFisico]:
        """Get available CDs for a title."""
        result = await self._session.execute(
            select(CdModel).where(
                and_(
                    CdModel.id_titulo == title_id,
                    CdModel.situacao_id == 1  # 1 = Available
                )
            )
        )
        for model in result.scalars():
            yield CdFisico(
                codigo=int(model.codigo) if model.codigo.isdigit() else 0,
                numcd=model.numcd,
                codtitulo=model.id_titulo,
                locado=(model.situacao_id == 2),  # 2 = Rented
                situacao=SituacaoCd.DISPONIVEL if model.situacao_id == 1 else (
                    SituacaoCd.LOCADO if model.situacao_id == 2 else SituacaoCd.RESERVADO
                ),
            )

    def _model_to_domain(self, model: TituloModel) -> Title:
        """Convert ORM model to domain entity."""
        from app.adapters.db.models import Musica as MusicaModel, Interprete as InterpreteModel

        # Load musicas from relationship
        musicas_domain = [
            Musica(id=m.id, nome=m.nome, tempo=m.tempo or 0)
            for m in model.musicas
        ] if model.musicas else []

        # Load interpretes from relationship
        interpretes_domain = [
            Interprete(id=i.id, nome=i.nome)
            for i in model.interpretes
        ] if model.interpretes else []

        return Title(
            id=model.id,
            nome=model.nome,
            valor=model.valor,
            tipo_locacao=model.tipo_locacao,
            qtde=model.qtde,
            cdgrupo=model.id_grupo,
            cdestilo=model.id_estilo,
            cds=[],  # CDs are loaded separately via CdFisicoRepository
            musicas=musicas_domain,
            interpretes=interpretes_domain,
        )


class PostgresCdFisicoRepository(CdFisicoRepositoryPort):
    """PostgreSQL async repository for CdFisico entity."""

    def __init__(self, session: AsyncSession) -> None:
        self._session = session

    async def get_by_codigo(self, codigo: str | int) -> CdFisico | None:
        """Get CD by its codigo."""
        result = await self._session.execute(
            select(CdModel).where(CdModel.codigo == str(codigo))
        )
        model = result.scalar_one_or_none()
        if not model:
            return None

        return CdFisico(
            codigo=int(model.codigo) if model.codigo.isdigit() else hash(model.codigo) % 1000000,
            numcd=model.numcd,
            codtitulo=model.id_titulo,
            locado=(model.situacao_id == 2),
            situacao=SituacaoCd.DISPONIVEL if model.situacao_id == 1 else (
                SituacaoCd.LOCADO if model.situacao_id == 2 else SituacaoCd.RESERVADO
            ),
        )

    async def get_by_numcd(self, numcd: str) -> CdFisico | None:
        """Get CD by its numcd."""
        result = await self._session.execute(
            select(CdModel).where(CdModel.numcd == numcd)
        )
        model = result.scalar_one_or_none()
        if not model:
            return None

        return CdFisico(
            codigo=int(model.codigo) if model.codigo.isdigit() else hash(model.codigo) % 1000000,
            numcd=model.numcd,
            codtitulo=model.id_titulo,
            locado=(model.situacao_id == 2),
            situacao=SituacaoCd.DISPONIVEL if model.situacao_id == 1 else (
                SituacaoCd.LOCADO if model.situacao_id == 2 else SituacaoCd.RESERVADO
            ),
        )

    async def get_all(
        self, skip: int = 0, limit: int = 100
    ) -> AsyncIterable[CdFisico]:
        """Get all CDs with pagination."""
        result = await self._session.execute(
            select(CdModel).offset(skip).limit(limit)
        )
        for model in result.scalars():
            yield CdFisico(
                codigo=int(model.codigo) if model.codigo.isdigit() else hash(model.codigo) % 1000000,
                numcd=model.numcd,
                codtitulo=model.id_titulo,
                locado=(model.situacao_id == 2),
                situacao=SituacaoCd.DISPONIVEL if model.situacao_id == 1 else (
                    SituacaoCd.LOCADO if model.situacao_id == 2 else SituacaoCd.RESERVADO
                ),
            )

    async def get_by_title_id(
        self, title_id: int
    ) -> AsyncIterable[CdFisico]:
        """Get all CDs for a title."""
        result = await self._session.execute(
            select(CdModel).where(CdModel.id_titulo == title_id)
        )
        for model in result.scalars():
            yield CdFisico(
                codigo=int(model.codigo) if model.codigo.isdigit() else hash(model.codigo) % 1000000,
                numcd=model.numcd,
                codtitulo=model.id_titulo,
                locado=(model.situacao_id == 2),
                situacao=SituacaoCd.DISPONIVEL if model.situacao_id == 1 else (
                    SituacaoCd.LOCADO if model.situacao_id == 2 else SituacaoCd.RESERVADO
                ),
            )

    async def save(self, cd: CdFisico) -> DomainEvent:
        """Save CD and emit CdRegistered event if new."""
        if cd.codigo == 0:  # New CD
            model = CdModel(
                codigo=str(cd.codigo),
                numcd=str(cd.codigo),
                id_titulo=cd.codtitulo,
                situacao_id=1,  # Default to Available
            )
            self._session.add(model)
            await self._session.flush()
            cd.codigo = int(model.codigo)
        else:  # Update existing CD
            result = await self._session.execute(
                select(CdModel).where(CdModel.codigo == str(cd.codigo))
            )
            model = result.scalar_one_or_none()
            if model:
                model.id_titulo = cd.codtitulo
                model.situacao_id = 2 if cd.locado else 1

        return DomainEvent(
            event_type="CdRegistered" if cd.codigo == 0 else "CdUpdated",
            aggregate_id=str(cd.codigo),
            aggregate_type="Cd",
            event_id=f"cd_{cd.codigo}",
            occurred_at=None,
            metadata={"cd_codigo": cd.codigo}
        )

    async def update(self, cd: CdFisico) -> DomainEvent:
        """Update CD and emit CdStatusChanged event."""
        return await self.save(cd)

    async def delete(self, cd_codigo: int) -> None:
        """Delete CD by codigo.

        Uses raw DELETE to respect database CASCADE constraints.
        """
        from sqlalchemy import delete as sql_delete

        # Use raw DELETE statement to let database handle CASCADE
        await self._session.execute(
            sql_delete(CdModel).where(CdModel.codigo == str(cd_codigo))
        )
        await self._session.commit()

    async def count_by_title(self, title_id: int) -> int:
        """Count CDs for a title (BR-MIGRAR-017)."""
        result = await self._session.execute(
            select(func.count()).where(CdModel.id_titulo == title_id)
        )
        return result.scalar() or 0

    async def mark_cd_rented(self, codigo: int | str) -> DomainEvent:
        """Mark CD as rented (RENT-006)."""
        result = await self._session.execute(
            select(CdModel).where(CdModel.codigo == str(codigo))
        )
        model = result.scalar_one_or_none()
        if model:
            model.situacao_id = 2  # 2 = Rented
            model.is_locado = True
            await self._session.commit()
            return DomainEvent.create(
                event_type="CdStatusChanged",
                aggregate_id=str(codigo),
                aggregate_type="Cd",
                data={"situacao": "Locado", "codigo": str(codigo)}
            )
        raise ValueError(f"CD {codigo} não encontrado")

    async def mark_cd_available(self, codigo: int | str) -> DomainEvent:
        """Mark CD as available (RENT-011)."""
        result = await self._session.execute(
            select(CdModel).where(CdModel.codigo == str(codigo))
        )
        model = result.scalar_one_or_none()
        if model:
            model.situacao_id = 1  # 1 = Available
            model.is_locado = False
            await self._session.commit()
            return DomainEvent.create(
                event_type="CdStatusChanged",
                aggregate_id=str(codigo),
                aggregate_type="Cd",
                data={"situacao": "Disponível", "codigo": str(codigo)}
            )
        raise ValueError(f"CD {codigo} não encontrado")


class PostgresMusicaRepository(MusicaRepositoryPort):
    """PostgreSQL async repository for Musica entity."""

    def __init__(self, session: AsyncSession) -> None:
        self._session = session

    async def get_by_id(self, musica_id: int) -> Musica | None:
        """Get music by ID."""
        from app.adapters.db.models import Musica as MusicaModel

        result = await self._session.execute(
            select(MusicaModel).where(MusicaModel.id == musica_id)
        )
        model = result.scalar_one_or_none()
        if not model:
            return None

        return Musica(
            id=model.id,
            nome=model.nome,
            tempo=model.tempo or 0,
        )

    async def get_by_title_id(
        self, title_id: int
    ) -> AsyncIterable[Musica]:
        """Get all music tracks for a title."""
        from app.adapters.db.models import Musica as MusicaModel, TituloMusica

        result = await self._session.execute(
            select(MusicaModel)
            .join(TituloMusica, MusicaModel.id == TituloMusica.id_musica)
            .where(TituloMusica.id_titulo == title_id)
        )
        for model in result.scalars():
            yield Musica(
                id=model.id,
                nome=model.nome,
                tempo=model.tempo or 0,
            )

    async def save(self, musica: Musica) -> None:
        """Save music track."""
        from app.adapters.db.models import Musica as MusicaModel

        if musica.id == 0:  # New music
            model = MusicaModel(
                nome=musica.nome,
                tempo=musica.tempo,
            )
            self._session.add(model)
            await self._session.flush()
            await self._session.commit()  # Add commit to persist
            musica.id = model.id
        else:  # Update existing music
            result = await self._session.execute(
                select(MusicaModel).where(MusicaModel.id == musica.id)
            )
            model = result.scalar_one_or_none()
            if model:
                model.nome = musica.nome
                model.tempo = musica.tempo

    async def update(self, musica: Musica) -> None:
        """Update music track."""
        await self.save(musica)

    async def delete(self, musica_id: int) -> None:
        """Delete music track by ID."""
        from app.adapters.db.models import Musica as MusicaModel

        result = await self._session.execute(
            select(MusicaModel).where(MusicaModel.id == musica_id)
        )
        model = result.scalar_one_or_none()
        if model:
            await self._session.delete(model)

    async def add_to_title(
        self, title_id: int, musica_id: int
    ) -> None:
        """Associate music with title (many-to-many)."""
        from app.adapters.db.models import TituloMusica
        from datetime import datetime

        association = TituloMusica(
            id_titulo=title_id,
            id_musica=musica_id,
            created_at=datetime.utcnow()
        )
        self._session.add(association)
        await self._session.commit()  # Add commit to persist

    async def remove_from_title(
        self, title_id: int, musica_id: int
    ) -> None:
        """Remove association between music and title."""
        from app.adapters.db.models import TituloMusica

        result = await self._session.execute(
            select(TituloMusica).where(
                and_(
                    TituloMusica.id_titulo == title_id,
                    TituloMusica.id_musica == musica_id
                )
            )
        )
        model = result.scalar_one_or_none()
        if model:
            await self._session.delete(model)
            await self._session.commit()  # Add commit to persist


class PostgresInterpreteRepository(InterpreteRepositoryPort):
    """PostgreSQL async repository for Interprete entity."""

    def __init__(self, session: AsyncSession) -> None:
        self._session = session

    async def get_by_id(self, interprete_id: int) -> Interprete | None:
        """Get interpreter by ID."""
        from app.adapters.db.models import Interprete as InterpreteModel

        result = await self._session.execute(
            select(InterpreteModel).where(InterpreteModel.id == interprete_id)
        )
        model = result.scalar_one_or_none()
        if not model:
            return None

        return Interprete(
            id=model.id,
            nome=model.nome,
        )

    async def get_all(
        self, skip: int = 0, limit: int = 100
    ) -> AsyncIterable[Interprete]:
        """Get all interpreters with pagination."""
        from app.adapters.db.models import Interprete as InterpreteModel

        result = await self._session.execute(
            select(InterpreteModel).offset(skip).limit(limit)
        )
        for model in result.scalars():
            yield Interprete(
                id=model.id,
                nome=model.nome,
            )

    async def search_by_name(self, name: str) -> AsyncIterable[Interprete]:
        """Search interpreters by name (case-insensitive)."""
        from app.adapters.db.models import Interprete as InterpreteModel

        result = await self._session.execute(
            select(InterpreteModel).where(
                InterpreteModel.nome.ilike(f"%{name}%")
            )
        )
        for model in result.scalars():
            yield Interprete(
                id=model.id,
                nome=model.nome,
            )

    async def save(self, interprete: Interprete) -> None:
        """Save interpreter."""
        from app.adapters.db.models import Interprete as InterpreteModel

        if interprete.id == 0:  # New interpreter
            model = InterpreteModel(nome=interprete.nome)
            self._session.add(model)
            await self._session.flush()
            await self._session.commit()  # Add commit to persist
            interprete.id = model.id
        else:  # Update existing interpreter
            result = await self._session.execute(
                select(InterpreteModel).where(InterpreteModel.id == interprete.id)
            )
            model = result.scalar_one_or_none()
            if model:
                model.nome = interprete.nome
                await self._session.commit()  # Add commit to persist update

    async def update(self, interprete: Interprete) -> None:
        """Update interpreter."""
        await self.save(interprete)

    async def delete(self, interprete_id: int) -> None:
        """Delete interpreter by ID."""
        from app.adapters.db.models import Interprete as InterpreteModel

        result = await self._session.execute(
            select(InterpreteModel).where(InterpreteModel.id == interprete_id)
        )
        model = result.scalar_one_or_none()
        if model:
            await self._session.delete(model)

    async def add_to_title(
        self, title_id: int, interprete_id: int
    ) -> None:
        """Associate interpreter with title (many-to-many)."""
        from app.adapters.db.models import TituloInterprete
        from datetime import datetime

        association = TituloInterprete(
            id_titulo=title_id,
            id_interprete=interprete_id,
            created_at=datetime.utcnow()
        )
        self._session.add(association)
        await self._session.commit()  # Add commit to persist

    async def remove_from_title(
        self, title_id: int, interprete_id: int
    ) -> None:
        """Remove association between interpreter and title."""
        from app.adapters.db.models import TituloInterprete

        result = await self._session.execute(
            select(TituloInterprete).where(
                and_(
                    TituloInterprete.id_titulo == title_id,
                    TituloInterprete.id_interprete == interprete_id
                )
            )
        )
        model = result.scalar_one_or_none()
        if model:
            await self._session.delete(model)
            await self._session.commit()  # Add commit to persist