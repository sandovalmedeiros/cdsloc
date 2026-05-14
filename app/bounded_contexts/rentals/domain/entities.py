"""Rentals domain entities.

Implements Locacao and Recibo entities following hexagonal architecture.
"""

from __future__ import annotations

from dataclasses import dataclass, field
from datetime import date, datetime
from decimal import Decimal

from app.shared.domain import (
    DiasAtraso,
    DomainEvent,
    Multa,
    devolucao_registrada,
    locacao_criada,
    multa_calculada,
    recibo_gerado,
)


@dataclass(slots=True)
class Locacao:
    """Rental aggregate root.

    Agregate: Yes (root aggregate)
    Invariant: CD disponível, cliente ativo, recibo associado
    Events: LocacaoCriada, DevolucaoRegistrada, MultaCalculada

    BR-MIGRAR-032: Dias de atraso.
    BR-MIGRAR-033: Cálculo de multa (R$ 3,50/dia).
    BR-MIGRAR-029: Transação atômica com CD.

    RENT-001: Locação exige cliente ativo.
    RENT-002: Locação permite retirada por dependente.
    RENT-003: Apenas CDs disponíveis podem ser locados.
    RENT-004: Data prevista 24h + 1 dia (2 se domingo).
    RENT-005: Data prevista 48h + 2 dias (3 se domingo).
    RENT-008: Devolução exige recibo pendente.
    RENT-009: Cálculo de dias de atraso.
    RENT-010: Cálculo de multa.
    RENT-013: Transação atômica.
    """

    codlocacao: int
    codcliente: int
    coddependente: int | None
    codcd: int
    data_locacao: datetime
    data_prevista: date
    valor_locacao: Decimal
    situacao: str
    valor_multa: Decimal = Decimal("0")
    data_devolucao: date | None = None
    codrecibo: int | None = None
    recibo: "Recibo | None" = None

    def __post_init__(self):
        # Validate valor_multa is non-negative
        if self.valor_multa < Decimal("0"):
            raise ValueError("Valor da multa não pode ser negativo")

    @classmethod
    def create(
        cls,
        codcliente: int,
        codcd: int,
        data_locacao: datetime,
        data_prevista: date,
        valor_locacao: Decimal,
        coddependente: int | None = None,
        codrecibo: int | None = None,
    ) -> tuple["Locacao", DomainEvent]:
        """Create a new rental."""
        locacao = cls(
            codlocacao=0,  # Will be set by repository
            codcliente=codcliente,
            coddependente=coddependente,
            codcd=codcd,
            data_locacao=data_locacao,
            data_prevista=data_prevista,
            valor_locacao=valor_locacao,
            situacao="Pendente",
            valor_multa=Decimal("0"),
            data_devolucao=None,
            codrecibo=codrecibo,
            recibo=None,
        )

        event = locacao_criada(
            codlocacao=locacao.codlocacao,
            codcliente=codcliente,
            cd_codigo=codcd,
            data_locacao=data_locacao,
            data_prevista=data_prevista,
            valor=valor_locacao,
        )

        return locacao, event

    def calcular_devolucao(
        self, data_devolucao: date
    ) -> tuple[Multa, DomainEvent, DomainEvent]:
        """Calculate penalty for late return (BR-MIGRAR-032, BR-MIGRAR-033).

        Returns: (multa, multa_calculada_event, devolucao_registrada_event)
        """
        # RENT-008: Devolução exige recibo pendente
        if self.recibo and self.recibo.devolvido:
            raise ValueError("Recibo já foi baixado")

        # RENT-009: Cálculo de dias de atraso
        dias_atraso_vo = DiasAtraso.calculate(
            data_atual=data_devolucao,
            data_prevista=self.data_prevista,
        )

        # RENT-010: Cálculo de multa
        multa_vo = Multa.calculate(dias_atraso_vo.valor)

        object.__setattr__(
            self,
            "valor_multa",
            multa_vo.valor.valor,
        )
        object.__setattr__(self, "data_devolucao", data_devolucao)

        multa_event = multa_calculada(
            codlocacao=self.codlocacao,
            dias_atraso=dias_atraso_vo.valor,
            valor=multa_vo.valor.valor,
        )

        devolucao_event = devolucao_registrada(
            codlocacao=self.codlocacao,
            data_devolucao=datetime.combine(
                data_devolucao, datetime.min.time()
            ),
            dias_atraso=dias_atraso_vo.valor,
            multa_valor=multa_vo.valor.valor,
        )

        return multa_vo, multa_event, devolucao_event

    @property
    def is_devolvido(self) -> bool:
        """Check if rental has been returned."""
        return self.data_devolucao is not None

    @property
    def total_com_multa(self) -> Decimal:
        """Return total value including penalty."""
        return self.valor_locacao + self.valor_multa


@dataclass(slots=True)
class Recibo:
    """Receipt aggregate.

    Agregate: Yes (root aggregate)
    Invariant: Valor total = soma valores + multa, itens associados
    Events: ReciboGerado

    RENT-012: Recibo marcado como devolvido após baixa.
    """

    codrecibo: int
    codcliente: int
    data_emissao: datetime
    valor_total: Decimal
    devolvido: bool = False
    locacoes: list[Locacao] = field(default_factory=list)

    def __post_init__(self):
        # Validate valor_total is non-negative
        if self.valor_total < Decimal("0"):
            raise ValueError("Valor total do recibo não pode ser negativo")

    @classmethod
    def create(
        cls,
        codcliente: int,
        valor_total: Decimal,
    ) -> tuple["Recibo", DomainEvent]:
        """Create a new receipt."""
        agora = datetime.now()
        recibo = cls(
            codrecibo=0,  # Will be set by repository
            codcliente=codcliente,
            data_emissao=agora,
            valor_total=valor_total,
            devolvido=False,
            locacoes=[],
        )

        event = recibo_gerado(
            codrecibo=recibo.codrecibo,
            codlocacao=0,  # Will be set when rental is added
            valor_total=valor_total,
        )

        return recibo, event

    def adicionar_locacao(self, locacao: Locacao) -> None:
        """Add a rental to this receipt."""
        if locacao.codrecibo != self.codrecibo:
            raise ValueError(
                "Locação não pertence a este recibo"
            )

        object.__setattr__(locacao, "recibo", self)
        self.locacoes.append(locacao)

        # Recalculate total
        novo_total = sum(l.valor_locacao for l in self.locacoes)
        object.__setattr__(self, "valor_total", novo_total)

    def baixar(self) -> None:
        """Mark receipt as returned (RENT-012)."""
        if self.devolvido:
            raise ValueError("Recibo já está baixado")

        object.__setattr__(self, "devolvido", True)

        # Mark all rentals as returned
        for locacao in self.locacoes:
            object.__setattr__(locacao, "data_devolucao", self.data_emissao.date())

    @property
    def pode_fazer_locacao(self) -> bool:
        """Check if new rentals can be made on this receipt."""
        return not self.devolvido
