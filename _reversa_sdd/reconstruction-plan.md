# Reconstruction Plan — CDsLoc

**Fonte:** migração
**Paradigma alvo:** OO com DI + Event-driven (async)
**Topologia:** Hexagonal Architecture (Ports and Adapters) com Bounded Contexts
**Stack:** Python 3.11+ / FastAPI 0.104+ / PostgreSQL 14+ / SQLAlchemy 2.0 (async) / Pydantic v2 / Jinja2 + WeasyPrint / Redis 7+ / pytest
**Estratégia:** Big Bang
**Gerado em:** 2026-05-12
**Status:** 13 tarefas | 13 concluídas | 0 pendentes

---

## Alertas de pré-voo

> Revise antes de iniciar. Itens REFERIDOS À CODIFICAÇÃO em `ambiguity_log.md` que afetam tarefas específicas estão marcados.

Nenhum item bloqueante. Pode iniciar.

---

## Tarefas

### Tarefa 01 — Setup do Projeto Novo
**Status:** done
**Lê:** `_reversa_sdd/migration/topology_decision.md`, `_reversa_sdd/migration/paradigm_decision.md`, `_reversa_sdd/migration/migration_brief.md`
**Constrói:** estrutura inicial de pastas/módulos, configuração base, dependências mínimas (pyproject.toml, requirements.txt, docker-compose.yml)
**Pronto quando:** Esqueleto do repositório novo bate com a topologia aprovada (bounded contexts: Auth, Catalog, Customers, Rentals, Reservations, Reports) e o paradigma escolhido (async/await, DI)

---

### Tarefa 02 — Shared Domain (Value Objects & Events)
**Status:** done
**Lê:** `_reversa_sdd/migration/target_domain_model.md` (seção Shared), `_reversa_sdd/migration/target_architecture.md` (seção Shared Domain)
**Constrói:** `app/shared/domain/` com value objects (Money, CEP, CPF, DateRange) e domain events (LocacaoCriada, DevolucaoRegistrada, etc.)
**Pronto quando:** Value objects validam invariantes, domain events são imutáveis e contêm todos os dados necessários

---

### Tarefa 03 — Schema do Banco Alvo
**Status:** done
**Lê:** `_reversa_sdd/migration/target_data_model.md`
**Constrói:** migrations, schema, modelos ORM (SQLAlchemy async) para todos os bounded contexts
**Pronto quando:** Todas as tabelas/coleções do modelo de dados alvo existem com tipos, constraints e relações corretos

---

### Tarefa 04 — Plano de Migração de Dados
**Status:** done
**Lê:** `_reversa_sdd/migration/data_migration_plan.md`, `_reversa_sdd/migration/target_data_model.md`
**Constrói:** scripts/jobs de ETL (Access → PostgreSQL), validações de integridade, rollback
**Pronto quando:** Scripts de migração testados em volume representativo, encoding ANSI→UTF8 aplicado, validações batem com o plano

---

### Tarefa 05 — Auth Context
**Status:** done
**Lê:** `_reversa_sdd/migration/target_architecture.md` (seção Auth), `_reversa_sdd/migration/target_domain_model.md`, `_reversa_sdd/migration/target_business_rules.md`
**Constrói:** `app/bounded_contexts/auth/` com domain (User, Role), services, ports, adapters (JWT, OAuth2PasswordBearer)
**Pronto quando:** Endpoints /auth/login e /auth/refresh funcionam com JWT tokens válidos, senha usa bcrypt (não XOR)

---

### Tarefa 06 — Catalog Context
**Status:** done
**Lê:** `_reversa_sdd/migration/target_architecture.md` (seção Catalog), `_reversa_sdd/migration/target_domain_model.md`, `_reversa_sdd/migration/target_business_rules.md`
**Constrói:** `app/bounded_contexts/catalog/` com domain (Title, Musica, Interprete, CdFisico), services, ports, adapters
**Pronto quando:** CRUD de títulos, músicas, intérpretes e CDs funciona, controle de estoque validado (apenas CDs disponíveis podem ser locados)

---

### Tarefa 07 — Customers Context
**Status:** done
**Lê:** `_reversa_sdd/migration/target_architecture.md` (seção Customers), `_reversa_sdd/migration/target_domain_model.md`, `_reversa_sdd/migration/target_business_rules.md`
**Constrói:** `app/bounded_contexts/customers/` com domain (Cliente, Dependente, Bairro, Municipio), services, ports, adapters
**Pronto quando:** CRUD de clientes e dependentes funciona, validação de CPF implementada, clientes cancelados bloqueiam operações

---

### Tarefa 08 — Rentals Context
**Status:** done
**Lê:** `_reversa_sdd/migration/target_architecture.md` (seção Rentals), `_reversa_sdd/migration/target_domain_model.md`, `_reversa_sdd/migration/target_business_rules.md`
**Constrói:** `app/bounded_contexts/rentals/` com domain (Locacao, Recibo, ItemLocacao), services (CalculationService para multa e data prevista), ports, adapters
**Pronto quando:** Locação cria recibo e itens em transação atômica, cálculo de multa (R$ 3,50/dia) implementado, devolução baixa recibo

---

### Tarefa 09 — Reservations Context
**Status:** done
**Lê:** `_reversa_sdd/migration/target_architecture.md` (seção Reservations), `_reversa_sdd/migration/target_domain_model.md`, `_reversa_sdd/migration/target_business_rules.md`
**Constrói:** `app/bounded_contexts/reservations/` com domain (Reserva), services, ports, adapters
**Pronto quando:** Reserva por título funciona, bloqueio de duplicatas implementado, conversão em locação funciona

---

### Tarefa 10 — Reports Context
**Status:** done
**Lê:** `_reversa_sdd/migration/target_architecture.md` (seção Reports), `_reversa_sdd/migration/target_domain_model.md`, `_reversa_sdd/migration/target_business_rules.md`
**Constrói:** `app/bounded_contexts/reports/` com domain (ReportSpecification), services, adapters (Jinja2 + WeasyPrint para HTML/PDF)
**Pronto quando:** Relatórios HTML/PDF geram conteúdo equivalente ao legado, substituindo Crystal Reports

---

### Tarefa 11 — API Adapters Layer
**Status:** done
**Lê:** `_reversa_sdd/migration/target_architecture.md` (seção Adapters Layer, API Layer)
**Constrói:** `app/adapters/api/` com routers, schemas (Pydantic), middleware (auth, CORS, exception handler)
**Pronto quando:** Endpoints REST para todos os bounded contexts funcionam, validação Pydantic aplicada, HTTP status codes corretos

---

### Tarefa 12 — Cutover
**Status:** done
**Lê:** `_reversa_sdd/migration/cutover_plan.md`
**Constrói:** scripts/checklists de cutover, switch de tráfego, plano de rollback executável
**Pronto quando:** Sistema novo recebe tráfego conforme o plano Big Bang, backup do Access preservado, rollback testado

---

### Tarefa 13 — Validação de Paridade
**Status:** pending
**Lê:** `_reversa_sdd/migration/parity_specs.md`
**Constrói:** suíte de testes de paridade (calculation parity, data parity, endpoint parity), relatório de divergências
**Pronto quando:** Todos os fluxos críticos definidos em parity_specs.md (multa, estoque, CPF, data prevista) passam nos testes
