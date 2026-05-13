---
schemaVersion: 1
generatedAt: 2026-05-12T00:00:00Z
reversa:
  version: "1.2.34"
kind: handoff
producedBy: orchestrator
hash: "sha256:<hash do corpo abaixo do front-matter>"
---

# Handoff para o Agente de Codificação

> Este documento é a porta de entrada para o agente de codificação (Claude Code, Codex, Cursor, Antigravity, etc.) que vai escrever o sistema novo a partir das specs.

## ⚠️ Leitura obrigatória primeiro

1. **`paradigm_decision.md`**, leitura inegociável. O paradigma alvo molda como toda a codificação deve acontecer.
2. **`topology_decision.md`**, leitura inegociável. A topologia escolhida (preservar / modernizar / híbrido) define a árvore de pastas e a fronteira entre módulos.

## Ordem de leitura recomendada

1. `paradigm_decision.md` (obrigatório, primeiro)
2. `topology_decision.md` (obrigatório, segundo)
3. `migration_brief.md`
4. `target_business_rules.md`
5. `migration_strategy.md`
6. `target_architecture.md`
7. `target_domain_model.md`
8. `target_data_model.md`
9. `data_migration_plan.md`
10. `parity_specs.md`
11. `risk_register.md` + `cutover_plan.md`
12. `discard_log.md` (consultivo)
13. `ambiguity_log.md` (consultivo)

## Lista de artefatos produzidos

| Artefato | Produzido por | Status |
|---|---|---|
| migration_brief.md | orchestrator | criado |
| paradigm_decision.md | paradigm_advisor | criado |
| target_business_rules.md | curator | criado |
| discard_log.md | curator | criado |
| migration_strategy.md | strategist | criado |
| risk_register.md | strategist | criado |
| cutover_plan.md | strategist | criado |
| topology_decision.md | designer (Fase 1) | criado |
| target_architecture.md | designer | criado |
| target_domain_model.md | designer | criado |
| target_data_model.md | designer | criado |
| data_migration_plan.md | designer | criado |
| parity_specs.md | inspector | criado |
| ambiguity_log.md | orchestrator | consolidado |

## Bloqueadores para começar a implementação
> Itens que precisam de decisão humana antes do agente de codificação começar.

Nenhum bloqueador. Todos os itens foram resolvidos durante o processo de migração.

## Próximos passos para o agente de codificação

1. **Ler `paradigm_decision.md` e internalizar**: o paradigma alvo é **OO com DI + Event-driven (async)**. Toda escolha de código deve honrar esse paradigma.
   - Usar `async/await` em todas as operações de banco
   - Implementar Pydantic schemas para validação de entrada
   - Separar camadas: routers → services → repositories
   - Usar `Depends()` do FastAPI para injeção de dependências
   - Substituir criptografia XOR (legado) por bcrypt ou argon2
   - Implementar tratamento de exceções adequado com HTTP status codes
   - Evitar variáveis globais — usar injeção de dependências para estado compartilhado

2. **Ler `topology_decision.md` e internalizar**: a topologia escolhida é **Hexagonal Architecture (Ports and Adapters) com Bounded Contexts**. Use o esboço da árvore registrado nesse artefato como base para criar a estrutura de pastas do novo repositório.
   - Bounded Contexts: Auth, Catalog, Customers, Rentals, Reservations, Reports
   - Adapters: API (FastAPI), DB (PostgreSQL), Reports (HTML/PDF)
   - Ports: Interfaces de repository (ABC)
   - Shared: Domain events, value objects

3. **Configurar o repositório novo** com a stack declarada em `migration_brief.md` e a topologia decidida.
   - Python + FastAPI + PostgreSQL + Docker
   - Estrutura de pastas conforme `topology_decision.md`
   - pytest para testes assíncronos
   - SQLAlchemy async para ORM
   - Jinja2 + WeasyPrint para relatórios

4. **Implementar bottom-up** seguindo `target_architecture.md` e `target_domain_model.md`:
   - infraestrutura → dados → domínio → aplicação → bordas
   - Começar pelos bounded contexts mais simples (Catalog, Customers)
   - Implementar shared domain events e value objects primeiro
   - Criar adapters de banco (repositories)
   - Criar ports (interfaces) para cada bounded context

5. **Escrever os testes** desde o início:
   - Testes de unit: domain entities e value objects (mocks)
   - Testes de integration: repositories com banco real
   - Testes de e2e: endpoints completos
   - Testes de paridade: validar cálculos críticos (multa, data prevista)
   - Usar pytest-asyncio para testes assíncronos

6. **Para cada componente**, validar que respeita:
   - Paradigma escolhido: async/await, DI, separação de camadas
   - Topologia escolhida: bounded contexts, ports/adapters, shared domain

7. **Para a migração de dados**, seguir `data_migration_plan.md`:
   - Script Access → PostgreSQL
   - Encoding explícito (latin1 → utf-8)
   - Validação de contagens e integridade referencial

8. **Para o cutover**, seguir `cutover_plan.md` e os critérios go/no-go:
   - Backup completo do Access antes do cutover
   - Testes smoke antes de liberar produção
   - Plano de rollback testado

## Itens auto-decididos (apenas se executado em --auto)

Pipeline executado em modo interativo, nenhum item auto-decidido.

## Notas finais

### Pontos críticos da migração

1. **Cálculo de multa (R$ 3,50/dia)**: Esta regra é financeira e crítica. Deve ser testada exaustivamente.
2. **Transação atômica**: Locação deve criar recibo, itens e atualizar situação do CD em uma única transação.
3. **Controle de estoque**: Apenas CDs disponíveis podem ser locados. Validação deve ocorrer antes da transação.
4. **Validação de CPF**: Implementar algoritmo do dígito verificador (BR-MIGRAR-010).
5. **Encoding**: Script de migração deve lidar com encoding ANSI (Access) → UTF-8 (PostgreSQL).

### Itens descartados que não devem ser replicados

- Criptografia XOR: Substituir por bcrypt (hash unidirecional)
- geracod(): Substituir por SERIAL do PostgreSQL
- On Error GoTo: Substituir por try/except + HTTPException
- Crystal Reports: Substituir por HTML/PDF via Jinja2 + WeasyPrint

### Stack técnica definitiva

- **Linguagem**: Python 3.11+
- **Framework Web**: FastAPI 0.100+
- **Banco**: PostgreSQL 15+
- **ORM**: SQLAlchemy 2.0 (async)
- **Validação**: Pydantic v2
- **Relatórios**: Jinja2 + WeasyPrint
- **Autenticação**: OAuth2PasswordBearer + JWT
- **Testes**: pytest + pytest-asyncio
- **Infra**: Docker + docker-compose

### Bounded Contexts implementar

1. **Auth**: Usuários, roles, JWT tokens
2. **Catalog**: Títulos, músicas, intérpretes, CDs físicos
3. **Customers**: Clientes, dependentes, bairros, municípios
4. **Rentals**: Locações, recibos, itens de locação
5. **Reservations**: Reservas, conversão em locação
6. **Reports**: Relatórios HTML/PDF

---

**Handoff gerado em:** 2026-05-12
**Versão do Reversa:** 1.2.34
**Projeto:** CDsLoc
