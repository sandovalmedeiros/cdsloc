# Plano de Exploração — CDsLoc

> Criado pelo Reversa em 2026-05-12
> Marque cada tarefa com ✅ quando concluída.
> Você pode editar este plano antes de iniciar: adicione, remova ou reordene tarefas conforme necessário.

---

## Fase 1: Reconhecimento 🔍

- [x] **Scout** — Mapeamento de estrutura de pastas e tecnologias
- [x] **Scout** — Análise de dependências e gerenciadores de pacotes
- [x] **Scout** — Identificação de entry points, CI/CD e configurações

## Fase 2: Decisão de Organização das Specs 🗂️

> Entre o Scout e o Arqueólogo, o Reversa pergunta como você quer organizar as specs (por módulo, caso de uso, endpoint, híbrida, por features ou customizada). A escolha fica persistida em `.reversa/config.toml` na seção `[specs]` e não será reperguntada em execuções futuras. Para reapresentar o menu, remova manualmente a seção `[specs]` do arquivo.

**Decisão confirmada:** Topologia Hexagonal com Bounded Contexts (Opção 2 do Designer)

## Fase 3: Escavação 🏗️

- [x] **Arqueólogo** — Análise do módulo `autenticacao`
- [x] **Arqueólogo** — Análise do módulo `cadastro-clientes`
- [x] **Arqueólogo** — Análise do módulo `cadastro-cds`
- [x] **Arqueólogo** — Análise do módulo `movimentacao`
- [x] **Arqueólogo** — Análise do módulo `reservas`
- [x] **Arqueólogo** — Análise do módulo `consultas`
- [x] **Arqueólogo** — Análise do módulo `relatorios`
- [x] **Arqueólogo** — Análise do módulo `modulo-global`
- [x] **Arqueólogo** — Análise do módulo `tabelas-auxiliares`
- [x] **Arqueólogo** — Análise do módulo `dependentes` (integrado em clientes)

## Fase 4: Interpretação 🧠

- [x] **Detetive** — Arqueologia Git e ADRs retroativos
- [x] **Detetive** — Regras de negócio implícitas e máquinas de estado
- [x] **Detetive** — Matriz de permissões (RBAC/ACL)
- [x] **Arquiteto** — Diagramas C4 (Contexto, Containers, Componentes)
- [x] **Arquiteto** — ERD completo e integrações externas
- [x] **Arquiteto** — Spec Impact Matrix

## Fase 5: Geração 📝

- [x] **Redator** — Specs SDD por componente
- [x] **Redator** — Code/Spec Matrix
- [x] **Redator** — User Stories (se aplicável)

## Fase 6: Revisão ✅

- [x] **Revisor** — Revisão cruzada de specs
- [x] **Revisor** — Resolução de lacunas com o usuário (questions.md → gaps.md)
- [x] **Revisor** — Relatório de confiança final

---

## Time de Migração (conforme topology_decision.md: Opção 2: Modernizar)

- [x] **Paradigm Advisor** — Detecta paradigma e força decisão consciente
- [x] **Curator** — Decide o que migra, o que descarta e o que precisa de decisão humana
- [x] **Strategist** — Propõe estratégias de migração com trade-offs explícitos (Big Bang confirmada)
- [x] **Designer** — Desenha a arquitetura do sistema novo (topologia, bounded contexts, domínio, dados)
- [x] **Inspector** — Define como provar equivalência comportamental entre legado e novo sistema (parity specs)

---

## Fases do Designer (conforme topology_decision.md: Opção 2: Modernizar)

- [x] **Fase 1: Topologia** — Decidiu a topologia do sistema novo (Opção 2: Hexagonal com Bounded Contexts)
- [x] **Fase 2: Arquitetura, Domain Model e Data Model** — Desenhou o sistema novo sob a topologia escolhida

---

## Agentes Independentes

> Execute estes agentes quando os recursos estiverem disponíveis — podem rodar em qualquer fase.

- [ ] **Visor** — Análise de interface via screenshots
- [ ] **Data Master** — Análise completa do banco de dados
- [ ] **Design System** — Extração de tokens de design
- [ ] **Tracer** — Análise dinâmica (requer sistema acessível)
- [ ] **Reconstructor** — Gera plano bottom-up para reimplementar o software (uma tarefa por sessão)

---

## Próximo passo

Após o Time de Descoberta concluir e o `_reversa_sdd/` estar populado, você pode disparar um dos fluxos seguintes:

- `/reversa-migrate`: orquestrador do **Time de Migração** (Paradigm Advisor → Curator → Strategist → Designer → Inspector). Gera as specs do sistema novo. Saída em `_reversa_sdd/migration/`.
- `/reversa-reconstructor`: gera plano bottom-up para reimplementar o software a partir das specs do legado (uma tarefa por sessão).

---

## Decisão de Organização das Specs (Time de Descoberta)

**Decisão confirmada:** Bounded Contexts (Hexagonal) com Organização por Feature + Domain Layers

**Justificativa:** A decisão de topologia (Opção 2 do Designer) definiu bounded contexts separados. As specs do sistema novo (`_reversa_sdd/migration/`) organizam os bounded contexts (Auth, Catalog, Customers, Rentals, Reservations, Reports), mas mantêm a separação em domínio e camadas.

**Consequência para este plano:**
- O Time de Descoberta está completo ✅
- O Time de Migração foi iniciado e todos os agentes concluíram ✅
- O próximo passo é: `/reversa-migrate` (migrate orquestrador gera handoff.md para implementação)

---

## Time de Migração Completo ✅

**Paradigm Advisor:** Detectou paradigma procedural (VB6) → Decisão: OO + DI + event-driven (async)  
**Curator:** Analisou 58 regras → 52 MIGRAR, 4 DESCARTAR, 2 DECISÃO HUMANA (todas resolvidas)  
**Strategist:** Avaliou 3 estratégias → Big Bang recomendada (confirmada)  
**Designer:** Desenhou arquitetura hexagonal com 6 bounded contexts, 14 agregados, 22 tabelas (DDL completo), plano de migração  
**Inspector:** Definiu 10 modos de paridade, cobriu 22 fluxos críticos, adaptou cobertura ao paradigma OO + DI + event-driven

**Estratégia confirmada:** Big Bang  
**Topologia confirmada:** Hexagonal com Bounded Contexts  
**Cutover:** Domingo 8h-12h (4 horas)  
**Janela de observação:** 7 dias pós-cutover

**Riscos críticos identificados:** 2 (perda de dados, cálculo de multa divergente)  
**Planos de mitigação definidos:** Transações atômicas, validações de CPF/data, backups, testes de paridade

**Artefatos de migração gerados:** 12
- paradigm_decision.md
- target_business_rules.md
- discard_log.md
- ambiguity_log.md (ambas resolvidas)
- migration_strategy.md
- risk_register.md
- cutover_plan.md
- topology_decision.md
- target_architecture.md
- target_domain_model.md
- target_data_model.md
- data_migration_plan.md
- parity_specs.md
