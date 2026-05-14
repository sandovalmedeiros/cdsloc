"""FastAPI router for Reports bounded context.

Endpoints for generating HTML/PDF reports.
"""

from __future__ import annotations

from fastapi import APIRouter, Depends, HTTPException, Query, Response, status
from fastapi.responses import StreamingResponse

from app.adapters.api.schemas.reports import (
    PeriodoEnum,
    ReportRequest,
    ReportResponse,
    ReportTipoEnum,
)
from app.bounded_contexts.reports.ports.repositories import (
    ReportGeneratorPort,
    ReportRepositoryPort,
)
from app.bounded_contexts.reports.services.report_service import ReportService

router = APIRouter(prefix="/reports", tags=["reports"])


async def get_report_repo() -> AsyncIterable[ReportRepositoryPort]:
    """Dependency injection for ReportRepositoryPort."""
    from app.adapters.db.repositories.reports_repository import PostgresReportRepository
    from app.adapters.db.base import get_db_no_context

    async for db in get_db_no_context:
        yield PostgresReportRepository(db)


async def get_report_generator() -> ReportGeneratorPort:
    """Dependency injection for ReportGeneratorPort."""
    from app.adapters.reports.jinja_report_generator import JinjaReportGenerator

    return JinjaReportGenerator()


async def get_report_service(
    report_repo: ReportRepositoryPort = Depends(get_report_repo),
    report_generator: ReportGeneratorPort = Depends(get_report_generator),
) -> ReportService:
    """Dependency injection for ReportService."""
    return ReportService(
        report_repo=report_repo,
        report_generator=report_generator,
    )


# Report endpoints


@router.post("/gerar", response_class=Response)
async def generate_report(
    data: ReportRequest,
    service: ReportService = Depends(get_report_service),
):
    """Generate a report (HTML or PDF).

    REP-001: Crystal Reports substituído por HTML/PDF dinâmico.
    REP-002: Relatórios aceitam filtros parametrizados.
    """
    # Prepare filters
    filtros = {}

    if data.periodo:
        period = service.parse_periodo(data.periodo.value)
        filtros["periodo"] = data.periodo.value
        filtros["data_inicio"] = period.data_inicio.isoformat()
        filtros["data_fim"] = period.data_fim.isoformat()
    elif data.data_inicio and data.data_fim:
        filtros["data_inicio"] = data.data_inicio.isoformat()
        filtros["data_fim"] = data.data_fim.isoformat()

    if data.id_cliente:
        filtros["id_cliente"] = data.id_cliente

    # Mock data for report (in production, this would query from bounded contexts)
    report_data = _get_mock_report_data(data.tipo.value, filtros)

    if data.formato == "pdf":
        # Generate PDF
        pdf_bytes = await service.generate_report_pdf(
            tipo=data.tipo.value,
            data=report_data,
            filtros=filtros,
        )

        return Response(
            content=pdf_bytes,
            media_type="application/pdf",
            headers={
                "Content-Disposition": f'attachment; filename="{data.tipo.value}.pdf"'
            },
        )
    else:
        # Generate HTML
        html = await service.generate_report_html(
            tipo=data.tipo.value,
            data=report_data,
            filtros=filtros,
        )

        return Response(
            content=html,
            media_type="text/html",
        )


@router.get("/tipos", response_model=list[ReportResponse])
async def list_report_types(
    skip: int = Query(0, ge=0),
    limit: int = Query(100, ge=1, le=100),
    repo: ReportRepositoryPort = Depends(get_report_repo),
):
    """List all available report types."""
    specs = [s async for s in repo.get_all(skip=skip, limit=limit)]

    return [
        ReportResponse(
            id=spec.id,
            tipo=spec.tipo.value,
            template=spec.template,
            descricao=spec.descricao,
        )
        for spec in specs
    ]


@router.get("/tipos/{tipo}", response_model=ReportResponse)
async def get_report_type(
    tipo: str,
    repo: ReportRepositoryPort = Depends(get_report_repo),
):
    """Get a report type by name."""
    spec = await repo.get_by_tipo(tipo)
    if not spec:
        raise HTTPException(
            status_code=status.HTTP_404_NOT_FOUND,
            detail=f"Tipo de relatório {tipo} não encontrado",
        )

    return ReportResponse(
        id=spec.id,
        tipo=spec.tipo.value,
        template=spec.template,
        descricao=spec.descricao,
    )


# Helper function for mock data (in production, this would query bounded contexts)


def _get_mock_report_data(tipo: str, filtros: dict) -> list[dict]:
    """Generate mock report data for testing.

    In production, this would query from the appropriate bounded context.
    """
    if tipo == "clientes_sintetico":
        return [
            {
                "ID": 1,
                "Nome": "João Silva",
                "Endereço": "Rua A, 123",
                "Telefone": "(11) 99999-9999",
                "Cadastro": "2023-01-15",
            },
            {
                "ID": 2,
                "Nome": "Maria Santos",
                "Endereço": "Av. B, 456",
                "Telefone": "(21) 88888-8888",
                "Cadastro": "2023-02-20",
            },
        ]
    elif tipo == "cds":
        return [
            {
                "Código": "CD001",
                "Título": "Thriller",
                "Intérprete": "Michael Jackson",
                "Situação": "Disponível",
                "Data Compra": "2023-01-10",
            },
            {
                "Código": "CD002",
                "Título": "Bad",
                "Intérprete": "Michael Jackson",
                "Situação": "Locado",
                "Data Compra": "2023-02-15",
            },
        ]
    elif tipo == "locacoes":
        return [
            {
                "Locação": 1,
                "Cliente": "João Silva",
                "CD": "CD001",
                "Data Locação": "2023-03-01",
                "Data Prevista": "2023-03-02",
                "Valor": "5.00",
                "Situação": "Devolvido",
            },
            {
                "Locação": 2,
                "Cliente": "Maria Santos",
                "CD": "CD003",
                "Data Locação": "2023-03-05",
                "Data Prevista": "2023-03-07",
                "Valor": "8.00",
                "Situação": "Pendente",
            },
        ]
    else:
        return []
