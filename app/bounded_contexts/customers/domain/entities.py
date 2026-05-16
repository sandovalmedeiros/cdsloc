"""Customers domain entities.

Implements Cliente and Dependente entities following hexagonal architecture.
"""

from __future__ import annotations

from dataclasses import dataclass, field
from datetime import date

from app.shared.domain import (
    DomainEvent,
    cliente_activated,
    cliente_cancelled,
    cliente_created,
    dependente_added,
)
from app.shared.domain.value_objects import validate_cpf


@dataclass(slots=True)
class Dependente:
    """Customer dependent.

    Agregate: No (part of Cliente aggregate)
    Invariant: Vinculado a cliente ativo
    Events: DependenteAdded (emitted by service)
    """

    cod_dependente: int
    cod_cliente: int
    nome_dependente: str

    def __post_init__(self):
        if not self.nome_dependente or not self.nome_dependente.strip():
            raise ValueError("Nome do dependente não pode ser vazio")


@dataclass(slots=True)
class Cliente:
    """Customer aggregate root.

    Agregate: Yes (root aggregate)
    Invariant: CPF válido se informado, data de nascimento razoável
    Events: ClienteCreated, ClienteActivated, ClienteCancelled

    BR-MIGRAR-008: Data de nascimento >= 1900.
    BR-MIGRAR-010: Validação de CPF.
    BR-MIGRAR-014: Cliente cancelado não pode cadastrar dependentes.
    CUST-001: Cliente cancelado bloqueia locações.
    CUST-002: Cliente cancelado não pode cadastrar dependentes.
    """

    codcliente: int
    nomecliente: str
    endereco: str
    data_nascimento: date
    cdbairro: int | None
    cep: str
    fone_01: str
    ramal_res: str | None = None
    fone_02: str | None = None
    ramal_trab: str | None = None
    fone_03: str | None = None
    identidade: str | None = None
    expedidor: str | None = None
    data_expedicao: date | None = None
    cic: str | None = None  # CPF
    empresa: str | None = None
    end_comercial: str | None = None
    referencia_pessoal: str | None = None
    data_inscricao: date | None = None
    cancelado: bool = False
    obs: str | None = None
    dependentes: list[Dependente] = field(default_factory=list)

    def __post_init__(self):
        # Validate CPF if provided (BR-MIGRAR-010)
        if self.cic:
            validate_cpf(self.cic)

        # Validate data_nascimento (BR-MIGRAR-008)
        if self.data_nascimento.year < 1900:
            raise ValueError(
                f"Data de nascimento inválida: {self.data_nascimento}"
            )

        # Validate CEP (formato XXXXX-XXX ou XXXXXXXX, 5+3 dígitos)
        # Remove traço para validação
        cep_clean = self.cep.replace("-", "")
        if len(cep_clean) != 8 or not cep_clean.isdigit():
            raise ValueError("CEP deve ter 8 dígitos (formato XXXXX-XXX ou XXXXXXXX)")

    @classmethod
    def create(
        cls,
        nomecliente: str,
        endereco: str,
        data_nascimento: date,
        cep: str,
        fone_01: str,
        cic: str | None = None,
        cdbairro: int | None = None,
        ramal_res: str | None = None,
        fone_02: str | None = None,
        ramal_trab: str | None = None,
        fone_03: str | None = None,
        identidade: str | None = None,
        expedidor: str | None = None,
        data_expedicao: date | None = None,
        empresa: str | None = None,
        end_comercial: str | None = None,
        referencia_pessoal: str | None = None,
        data_inscricao: date | None = None,
        obs: str | None = None,
    ) -> tuple[Cliente, DomainEvent]:
        """Create a new customer."""
        cliente = cls(
            codcliente=0,  # Will be set by repository
            nomecliente=nomecliente,
            endereco=endereco,
            data_nascimento=data_nascimento,
            cdbairro=cdbairro,
            cep=cep,
            fone_01=fone_01,
            ramal_res=ramal_res,
            fone_02=fone_02,
            ramal_trab=ramal_trab,
            fone_03=fone_03,
            identidade=identidade,
            expedidor=expedidor,
            data_expedicao=data_expedicao,
            cic=cic,
            empresa=empresa,
            end_comercial=end_comercial,
            referencia_pessoal=referencia_pessoal,
            data_inscricao=data_inscricao,
            cancelado=False,
            obs=obs,
            dependentes=[],
        )

        event = cliente_created(
            codcliente=cliente.codcliente,
            nome=nomecliente,
            email=None,  # Not in original spec
        )

        return cliente, event

    def adicionar_dependente(self, dependente: Dependente) -> DomainEvent:
        """Add a dependent (BR-MIGRAR-014, CUST-002)."""
        if self.cancelado:
            raise ValueError(
                "Cliente cancelado não pode cadastrar dependentes"
            )

        if dependente.cod_cliente != self.codcliente:
            raise ValueError("Dependente pertence a outro cliente")

        self.dependentes.append(dependente)

        return dependente_added(
            cod_dependente=dependente.cod_dependente,
            cod_cliente=self.codcliente,
            nome_dependente=dependente.nome_dependente,
        )

    def remover_dependente(self, cod_dependente: int) -> None:
        """Remove a dependent."""
        self.dependentes = [
            d for d in self.dependentes
            if d.cod_dependente != cod_dependente
        ]

    def cancelar(self) -> DomainEvent:
        """Cancel customer (CUST-001)."""
        if self.cancelado:
            raise ValueError("Cliente já está cancelado")

        object.__setattr__(self, "cancelado", True)

        return cliente_cancelled(
            codcliente=self.codcliente,
            nome=self.nomecliente,
        )

    def ativar(self) -> DomainEvent:
        """Activate customer."""
        if not self.cancelado:
            raise ValueError("Cliente já está ativo")

        object.__setattr__(self, "cancelado", False)

        return cliente_activated(
            codcliente=self.codcliente,
            nome=self.nomecliente,
        )

    def pode_fazer_locacao(self) -> bool:
        """Check if customer can make rentals (CUST-001)."""
        return not self.cancelado

    def pode_cadastrar_dependente(self) -> bool:
        """Check if customer can add dependents (CUST-002)."""
        return not self.cancelado
