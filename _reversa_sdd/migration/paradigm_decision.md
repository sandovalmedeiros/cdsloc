---
schemaVersion: 1
generatedAt: 2026-05-12T00:00:00Z
reversa:
  version: "1.2.34"
kind: paradigm_decision
producedBy: paradigm_advisor
hash: "sha256:<hash do corpo abaixo do front-matter>"
---

# Paradigm Decision — CDsLoc

> Decisão consciente sobre como tratar a mudança de paradigma entre o legado e a stack alvo.
> Este artefato é leitura obrigatória primeiro para qualquer agente posterior e para o agente de codificação.

---

## Paradigma do legado detectado

- **Paradigma principal**: PROCEDURAL
- **Confiança**: 🟢 CONFIRMADO
- **Evidências**:
  - Não há classes de domínio; entidades são tabelas acessadas via recordsets DAO (`code-analysis.md`, seção "Módulos de Código")
  - 18 recordsets globais em `DECLARA.BAS` (variáveis `wbanco`, `wclien`, `Wcdfisico`, etc.)
  - "Sem Camada de Negócio: Regras de negócio embutidas nos formulários" (`architecture.md`, seção "Características da Arquitetura")
  - Funções utilitárias top-level: `geracod()`, `limpacampos()`, `SetaBanco()` como funções globais (`code-analysis.md`)
  - "Formulários acessam o banco diretamente via DAO" (`architecture.md`)

---

## Stack alvo declarada

- **Linguagem**: Python
- **Framework**: FastAPI
- **Banco**: PostgreSQL
- **Infra**: Docker

---

## Paradigma natural inferido

- **Paradigma**: OO com DI + Event-driven (async)
- **Justificativa**: FastAPI é nativamente async-first e encoraja injeção de dependências via `Depends()`, separação de camadas (services, repositories, DTOs/schemas), e validação via Pydantic. O runtime Python com async/await habilita event-driven de forma ergonômica.
- **Alternativas viáveis**: Procedural rico é possível em Python, mas contradiz as convenções do FastAPI. OO clássico também possível, mas perderia benefícios de DI.

---

## Gap identificado

- **Severidade**: alto
- **Implicações concretas**:

1. **Acesso direto ao banco vira repositório assíncrono**
   - No legado: `cliente.frm` acessa `wclien` (Recordset global) diretamente com `AddNew()`, `Edit()`, `Update()` (`code-analysis.md`, linhas 203-208). Fluxo síncrono, resposta imediata.
   - No alvo: Vira repository assíncrono com `async def`, requerendo `await` em toda operação de banco.

2. **Validação de campos vira Pydantic schemas**
   - No legado: Validações espalhadas nos formulários com `IsDate()`, `IsNumeric()`, checagem imperativa (`code-analysis.md`, linhas 203-207).
   - No alvo: Validação declarativa via Pydantic na entrada da requisição, antes do service.

3. **Tratamento de erro vira exceções estruturadas + HTTP status codes**
   - No legado: `On Error GoTo ErrorHandler` com `Case 3200` para integridade referencial (`code-analysis.md`, linhas 335-345).
   - No alvo: Exceções específicas (`ForeignKeyViolationError`) convertidas em `HTTPException` com status codes apropriados.

4. **Funções globais vira injeção de dependências**
   - No legado: `geracod()` depende de variáveis globais `VTb`, `VIx`, `VCt` (`code-analysis.md`, linhas 70-81).
   - No alvo: Service com dependências injetadas explicitamente, sem estado global compartilhado.

---

## Opções apresentadas ao usuário

1. **Adotar paradigma natural da stack** (transformational)
   - Consequências: Separação completa de camadas (router → service → repository), async em toda a pilha, Pydantic para validação, injeção de dependências. Mais código que o legado, mas mais idiomático e testável.

2. **Forçar paradigma similar ao legado** (conservador)
   - Consequências: Simular acesso direto com "Active Record assíncrono", manter validações imperativas. Menos código, mas dívida técnica e perda de benefícios do FastAPI.

3. **Híbrido** (equilibrado)
   - Consequências: Pydantic para validação + DI para DB, mas services mais procedimentais. Melhor das duas abordagens, evolução gradual possível.

---

## Decisão do usuário

- **Escolha**: 1
- **Justificativa do usuário**: (implícita — opção 1 selecionada)
- **Decidido em**: 2026-05-12T00:00:00Z

---

## Apetite derivado

- `derived_appetite`: **transformational**

---

## Implicações pendentes para próximos agentes

| Agente | Implicação | Como honrar |
|--------|------------|-------------|
| **Curator** | Separação de regras em services | Extrair regras de negócio dos formulários para services de domínio |
| **Strategist** | Mudança síncrono→async afeta estratégia de migração | Considerar async no plano de cutover e testes de paridade |
| **Designer** | Arquitetura deve ser 3-tier (API → Service → Repository) | Desenhar camadas separadas com injeção de dependências |
| **Inspector** | Testes de paridade devem considerar async/await | Especificar como validar comportamento assíncrono equivalente ao síncrono |

---

## Notas

O agente de codificação deve:
- Usar `async/await` em todas as operações de banco
- Implementar Pydantic schemas para validação de entrada
- Separar camadas: routers → services → repositories
- Usar `Depends()` do FastAPI para injeção de dependências
- Substituir criptografia XOR (legado) por bcrypt ou argon2
- Implementar tratamento de exceções adequado com HTTP status codes
- Evitar variáveis globais — usar injeção de dependências para estado compartilhado
