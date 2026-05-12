---
schemaVersion: 1
generatedAt: 2026-05-12T00:00:00Z
reversa:
  version: "1.2.34"
kind: topology_decision
producedBy: designer
hash: "sha256:<hash do corpo abaixo do front-matter>"
---

# Topology Decision — CDsLoc

> Decisão sobre a topologia do sistema novo, detectada a partir do legado e proposta moderna.
> Esta decisão fundamenta a decomposição em bounded contexts e arquitetura do Designer.

---

## Paradigma Alvo (do paradigm_decision.md)

| Aspecto | Paradigma | Implicação para topologia |
|---------|-----------|---------------------------|
| **Principal** | OO com DI + Event-driven (async) | Separação de camadas, injeção de dependências, eventos de domínio |
| **Stack** | Python + FastAPI + PostgreSQL | API REST async, banco relacional |
| **Appetite** | Transformational | Aceita mudança significativa |

---

## Topologia do Legado Detectada

### Padrão de Organização

**Tipo:** Monolito Desktop (Package-by-Layer sem separação clara)

**Evidências:** `architecture.md` § "Arquitetura Cliente-Servidor 2-Tier", `inventory.md` § "Estrutura de Pastas"

### Esboço da Árvore Legada

```
CDsLoc (raiz — estrutura plana)
├── Autenticação
│   └── SENHA.FRM (senha única global)
├── Menu Principal
│   └── MENU02.FRM (MDI container)
├── Cadastros
│   ├── cliente.frm (clientes + dependentes)
│   ├── CAD_DEP.FRM (dependentes)
│   ├── CDS.FRM (títulos + músicas + CDs físicos)
│   └── tabelas.frm (tabelas auxiliares)
├── Movimentação
│   └── LOCDEVOL.FRM (locação + devolução)
├── Reservas
│   ├── reservcd.frm (reservas)
│   ├── CONSRES1.frm (consulta v1)
│   ├── CONSRES2.fRM (consulta v2)
│   └── CONSRES3.fRM (consulta v3)
├── Consultas
│   ├── frmConsulta.frm (consultas genéricas)
│   └── CONSREC1.FRM (recebimentos)
├── Painéis
│   ├── frmPainel.frm
│   └── PAINEL.FRM
└── Sobre
    └── SOBRESEN.FRM
```

**Confiança:** 🟢 CONFIRMADO (baseado em análise de 17 formulários + 2 módulos)

---

## Diagnóstico Estrutural

| Aspecto | Diagnóstico | Evidência |
|---------|-------------|-----------|
| **Acoplamento** | Alto — Formulários acessam banco diretamente via DAO | `architecture.md` § "Acesso Direto" |
| **Coesão interna** | Baixo — Lógica de negócio espalhada nos formulários | `architecture.md` § "Sem Camada de Negócio" |
| **Coesão entre módulos** | Baixa — 3 versões de CONSRES duplicadas | `inventory.md` — CONSRES1/2/3 |
| **Separação de responsabilidades** | Inexistente — Formulários = Banco | `architecture.md` § "Sem API" |
| **Abstrações** | Inexistentes — Funções globais utilitárias apenas | `code-analysis.md` — geracod(), limpacampos() |
| **Testabilidade** | Baixa — Acesso direto ao banco, UI acoplada a lógica | `architecture.md` — Monolítico desktop |
| **Fronteiras** | Indefinidas — Módulos não têm limites claros | Esboço da árvore legada acima |

**Conclusão:** SAUDÁVEL, mas com acoplamento significativo (acesso direto ao banco) e falta de abstrações. Não há violações graves de arquitetura, mas o código é procedural embutido em formulários.

---

## Topologia Moderna Proposta

### Padrão de Organização

**Tipo:** Hexagonal Architecture (Ports and Adapters) com Bounded Contexts

**Justificativa:** Adequado ao paradigma OO + DI + event-driven. Separação clara de domínio de infraestrutura, testabilidade por construção, adaptadores externos para banco/APIs.

### Esboço da Árvore Proposta

```
cdsloc/ (monorepo Python)
├── app/
│   ├── adapters/
│   │   ├── api/ (FastAPI HTTP adapter)
│   │   │   ├── routers/ (endpoints REST)
│   │   │   ├── schemas/ (Pydantic DTOs)
│   │   │   └── middleware/
│   │   ├── db/ (PostgreSQL adapter)
│   │   │   ├── models/ (SQLAlchemy ORM)
│   │   │   ├── repositories/ (repositories concretos)
│   │   │   └── migrations/
│   │   └── reports/ (HTML/PDF adapter)
│   │       └── templates/ (Jinja2)
│   ├── bounded_contexts/
│   │   ├── auth/ (autenticação e autorização)
│   │   │   ├── domain/ (entities, value objects)
│   │   │   ├── services/ (application services)
│   │   │   └── ports/ (repository interfaces)
│   │   ├── catalog/ (catálogo de CDs)
│   │   │   ├── domain/ (títulos, músicas, CDs físicos)
│   │   │   ├── services/
│   │   │   └── ports/
│   │   ├── customers/ (clientes e dependentes)
│   │   │   ├── domain/ (clientes, dependentes)
│   │   │   ├── services/
│   │   │   └── ports/
│   │   ├── rentals/ (locação e devolução)
│   │   │   ├── domain/ (locação, recibo, cálculo de multa)
│   │   │   ├── services/
│   │   │   └── ports/
│   │   ├── reservations/ (reservas)
│   │   │   ├── domain/ (reservas)
│   │   │   ├── services/
│   │   │   └── ports/
│   │   └── reports/ (relatórios)
│   │       ├── domain/ (specs de relatório)
│   │       ├── services/
│   │       └── ports/
│   └── shared/
│       ├── domain/ (eventos de domínio compartilhados)
│       │   ├── events.py (LocacaoCriada, DevolucaoRegistrada, etc.)
│       │   └── value_objects.py (Money, CEP, CPF, etc.)
│       ├── infrastructure/
│       │   ├── messaging.py (event bus para event-driven)
│       │   ├── logging.py
│       │   └── config.py
│       └── tests/
│           ├── unit/
│           ├── integration/
│           └── e2e/
├── scripts/
│   └── migration/ (script Access → PostgreSQL)
├── docker/
│   ├── Dockerfile (app)
│   ├── docker-compose.yml (app + PostgreSQL)
│   └── nginx.conf (proxy reverso opcional)
└── docs/
    ├── api/ (OpenAPI specs)
    └── architecture/ (C4 diagrams)
```

### Bounded Contexts Identificados

| Bounded Context | Responsabilidade | Agregates Raiz | Justificativa |
|------------------|-------------------|-----------------|---------------|
| **Auth** | Autenticação, autorização, gestão de usuários | User, Role | Separação de identidade do domínio de negócio. Decisão BR-HUMANA-001 confirmou múltiplos usuários. |
| **Catalog** | Títulos, músicas, intérpretes, CDs físicos, estoque | Titulo, Musica, CdFisico, Interprete | Domínio catálogo é independente e tem ciclo de vida próprio. |
| **Customers** | Clientes, dependentes, bairros, municípios | Cliente, Dependente, Bairro | Cliente e dependente são agregados distintos mas relacionados. |
| **Rentals** | Locação, devolução, recibo, cálculo de multa | Locacao, Recibo, ItemLocacao | Núcleo do negócio. Requisito de transação atômica (BR-MIGRAR-029). |
| **Reservations** | Reservas, conversão em locação | Reserva | Fluxo relacionado a Rentals mas com ciclo de vida distinto. |
| **Reports** | Relatórios HTML/PDF (clientes, CDs, locações, etc.) | ReportSpecification | Separação de concern (reporting é tecnologia específica). |

**Confiança:** 🟡 INFERIDO (baseado em análise de domínio e regras de negócio)

---

## Opções Apresentadas

### Opção 1: Preservar Topologia Legada (Conservadora)

**Descrição:** Manter organização por funcionalidade (autenticação, cadastros, movimentação, reservas, consultas, relatórios) como pastas no código.

**Estrutura proposta:**
```
app/
├── auth/ (SENHA.FRM)
├── menus/ (MENU02.FRM)
├── cadastros/
│   ├── customers/ (cliente.frm + CAD_DEP.FRM)
│   ├── cds/ (CDS.FRM)
│   └── tables/ (tabelas.frm)
├── rentals/ (LOCDEVOL.FRM)
├── reservations/ (reservcd.frm + CONSRES*)
├── queries/ (frmConsulta.frm + CONSREC1.FRM)
└── reports/ (*.rpt)
```

**Prós:**
- Menor curva de aprendizado (estrutura familiar)
- Esforço inicial menor
- Mapeamento 1:1 com código legado

**Contras:**
- Não aproveita capacidades da stack alvo (OO + DI + event-driven)
- Acoplamento pode ser replicado (acesso direto ao banco)
- Dificuldade de testar (sem bounded contexts claros)

**Ganhos concretos:** Baixos (apenas modernização de linguagem/framework)

**Custos:** Baixos

---

### Opção 2: Adotar Topologia Moderna (Transformational)

**Descrição:** Arquitetura Hexagonal com Bounded Contexts, Ports and Adapters, separação de domínio de infraestrutura. Conforme esboço da árvore proposta acima.

**Prós:**
- Testabilidade por construção (domínio isolado)
- Separação clara de responsabilidades (domínio vs. infra)
- Aproveita capacidades da stack alvo (OO + DI + async)
- Escalabilidade melhor (bounded contexts podem ser microserviços futuramente)
- Event-driven habilitado por design

**Contras:**
- Maior curva de aprendizado (novos conceitos: ports, adapters, bounded contexts)
- Mais código boilerplate inicial
- Curva de desenvolvimento maior

**Ganhos concretos:** Altos (qualidade de código, testabilidade, manutenibilidade)

**Custos:** Médios

---

### Opção 3: Híbrida (Equilibrada)

**Descrição:** Bounded Contexts mas sem Hexagonal completa. Camadas clássicas (routes → services → repositories) sem ports/adapters explícitos.

**Estrutura proposta:**
```
app/
├── bounded_contexts/
│   ├── auth/ (domain + services + repositories)
│   ├── catalog/ (domain + services + repositories)
│   ├── customers/ (domain + services + repositories)
│   ├── rentals/ (domain + services + repositories)
│   ├── reservations/ (domain + services + repositories)
│   └── reports/ (services + HTML/PDF templates)
├── shared/ (domain events, value objects)
└── api/ (FastAPI routers + Pydantic schemas)
```

**Prós:**
- Bounded contexts trazem benefícios de separação
- Menos boilerplate que Hexagonal completa
- Ainda aproveita OO + DI

**Contras:**
- Event-driven mais difícil (sem ports explícitos para adapters de mensageria)
- Acoplamento ainda existe (services dependem diretamente de repositories)

**Ganhos concretos:** Médios (separação de domínio, mas menos isolamento que Hexagonal)

**Custos:** Médios

---

## Decisão do Usuário

**Estratégia escolhida:** Opção 2 — Adotar Topologia Moderna  
**Decisor:** Sandoval  
**Data:** 2026-05-12  
**Justificativa:** Aproveitar capacidades da stack alvo (Python/FastAPI/PostgreSQL) e honrar paradigma transformational. Bounded Contexts trazem separação de domínio, testabilidade e escalabilidade.

---

## Mapeamento Legado → Novo (Rascunho)

**Qual opção você escolhe para a topologia do sistema novo?**

1. **Preservar Topologia Legada** (Conservadora)
2. **Adotar Topologia Moderna** (Transformational) — **Recomendada**
3. **Híbrida** (Equilibrada)

Digite 1, 2 ou 3 — ou apenas ENTER para confirmar a opção **Recomendada (2)**.

---

## Mapeamento Legado → Novo (Rascunho)

> Este mapeamento será expandido na Fase 2 após aprovação da topologia.

| Legado | Bounded Context Novo | Tipo de Mapeamento |
|--------|---------------------|---------------------|
| SENHA.FRM | Auth (bounded context) | Refundido (senha única → múltiplos usuários) |
| cliente.frm + CAD_DEP.FRM | Customers (bounded context) | 1-para-1 (mesmo contexto) |
| CDS.FRM | Catalog (bounded context) | 1-para-1 (mesmo contexto) |
| LOCDEVOL.FRM | Rentals (bounded context) | 1-para-1 (mesmo contexto) |
| reservcd.frm + CONSRES* | Reservations (bounded context) | Múltiplos → 1 (CONSRES fundidos em Reservations) |
| frmConsulta.frm + CONSREC1.FRM | Catalog + Customers (shared query) | Múltiplos → shared (queries distribuídos) |
| *.rpt | Reports (bounded context) | Tecnologia substituída, contexto preservado |
| tabelas.frm | Catalog (bounded context) | 1-para-1 (tabelas auxiliares no catálogo) |

---

## Implicações para Próximas Etapas do Designer

### Se Opção 1 (Preservar Legado) for escolhida:

- `target_architecture.md`: Arquitetura 3-layer clássica (routes → services → repositories)
- `target_domain_model.md`: Sem bounded contexts explícitos; entidades por funcionalidade
- `target_data_model.md`: Mesmo mapeamento 1-para-1 da estrutura
- `data_migration_plan.md`: Simples (copy columns, renomear tabelas)

### Se Opção 2 (Topologia Moderna) for escolhida:

- `target_architecture.md`: Hexagonal com ports/adapters, bounded contexts
- `target_domain_model.md`: Agregados por bounded context, eventos de domínio
- `target_data_model.md`: Schema por bounded context, relacionamentos respeitados
- `data_migration_plan.md`: Mais complexo (transformações por bounded context)

### Se Opção 3 (Híbrida) for escolhida:

- `target_architecture.md`: 3-layer com bounded contexts (sem ports/adapters)
- `target_domain_model.md`: Bounded contexts, mas sem eventos explícitos
- `target_data_model.md`: Schema por bounded context
- `data_migration_plan.md`: Média complexidade
