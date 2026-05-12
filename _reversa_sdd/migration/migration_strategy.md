---
schemaVersion: 1
generatedAt: 2026-05-12T00:00:00Z
reversa:
  version: "1.2.34"
kind: migration_strategy
producedBy: strategist
hash: "sha256:<hash do corpo abaixo do front-matter>"
---

# Migration Strategy — CDsLoc

> Análise de estratégias de migração com trade-offs explícitos
> Decisão final é humana. Este documento informa e orienta.

---

## Contexto da Migração

### Tamanho do Legado

| Aspecto | Detalhe | Impacto |
|---------|---------|---------|
| **Linguagem** | Visual Basic 6.0 (17 formulários, 2 módulos) | ~5.000 linhas estimadas |
| **Banco de Dados** | Microsoft Access (18 tabelas negócio + 6 auxiliares) | ~24 tabelas |
| **Relatórios** | 12 relatórios Crystal Reports | Tecnologia obsoleta a substituir |
| **Integrações** | Nenhuma (banco local + Crystal Reports apenas) | Baixa complexidade de integração |
| **Usuários** | Single-user por estação (banco local) | Sem concorrência significativa |
| **Classificação** | Sistema pequeno/medium | ~70 arquivos no total |

### Apetite Derivado

- **derived_appetite**: `transformational`
- **Origem**: `paradigm_decision.md` — decisão do usuário para adotar paradigma natural da stack (OO + DI + async)
- **Implicação**: Aceita mudança significativa de paradigma; aborda refactoring profundo como feature, não bug.

### Severidade do Gap de Paradigma

| Aspecto Legado | Paradigma Alvo | Gap | Implicação |
|----------------|----------------|-----|------------|
| Procedural (VB6) | OO com DI (Python/FastAPI) | **Alto** | Requer refactoring de funções globais para services |
| Síncrono (DAO direto) | Async (repository pattern) | **Alto** | Toda operação de banco precisa de async/await |
| Tratamento imperativo (On Error GoTo) | Exceções estruturadas + HTTP status codes | **Médio** | Novo padrão de erro para aprender |
| Desktop MDI | REST API + Frontend separado | **Alto** | Separação completa de frontend/backend |

### Restrições do Brief

| Tipo | Valor | Implicação |
|------|-------|-----------|
| **Prazo** | Não há (experimento) | Flexibilidade total |
| **Orçamento** | Sem restrição | Sem limitação de investimento |
| **Técnicas** | Sem restrição | Stack livre |
| **Operacionais** | Sem restrição | Sem paralisão de produção |

### Regras de Negócio Críticas

| Regra | Tipo | Motivo da criticidade |
|-------|------|---------------------|
| Cálculo de multa (R$ 3,50/dia) | Financeira | Impacto direto em receita |
| Transação atômica na locação | Integridade de dados | Evita inconsistência entre CD e locação |
| Validação de CPF e data de nascimento | Regulatória | Integridade de cadastro |
| Controle de estoque de CDs | Negócio | Base do modelo de negócio |

---

## Estratégias Avaliadas

### 1. Big Bang

**Descrição:** Sistema legado é substituído completamente pelo sistema novo em um único evento de cutover. Não há período de coexistência.

| Critério | Avaliação | Justificativa |
|----------|-----------|---------------|
| **Adequação ao apetite** | ✅ Excelente | Apetite transformational em sistema pequeno favorece abordagem direta |
| **Adequação ao gap de paradigma** | ✅ Excelente | Quebra limpa permite aplicar novo paradigma sem workaround |
| **Custo** | ✅ Baixo | Sem investimento em infraestrutura de coexistência |
| **Risco** | ⚠️ Alto | Sem rollback gradual; erros não descobertos afetam todo o sistema |
| **Tempo** | ✅ Curto | Sem necessidade de sincronização de sistemas |
| **Prós** | Simplicidade de execução; sem manutenção de dois sistemas; foco total no novo |
| **Contras** | Sem período de validação; rollback complexo; pressão no go-live |

**Viabilidade:** Viável. Sistema é pequeno, sem integrações externas, e não há restrições operacionais que impeçam paralisação.

---

### 2. Parallel Run

**Descrição:** Sistema legado e novo operam simultaneamente por um período, com validação de paridade entre ambos. Migração gradual de usuários (caso houvesse).

| Critério | Avaliação | Justificativa |
|----------|-----------|---------------|
| **Adequação ao apetite** | ⚠️ Médio | Apetite transformational, mas validação de paridade reduz risco |
| **Adequação ao gap de paradigma** | ✅ Excelente | Permite validar novo paradigma antes do cutover definitivo |
| **Custo** | ❌ Alto | Manutenção de dois sistemas + sincronização de dados |
| **Risco** | ✅ Baixo | Erros descobertos afetam apenas um sistema; rollback trivial |
| **Tempo** | ⚠️ Médio | Período de coexistência + validação + migração incremental |
| **Prós** | Validação de regras críticas (multa, estoque); rollback trivial; redução de ansiedade |
| **Contras** | Custo de manutenção; complexidade de sincronização; tempo total maior |

**Viabilidade:** Viável mas custosa. Requer sincronização de dados entre Access (legado) e PostgreSQL (novo), o que pode ser desafiador.

---

## Estratégias Não Aplicáveis

### Strangler Fig

**Razão para descarte:** Requer capacidade de roteamento entre legado e novo (proxy/API gateway) que não existe. Sistema legado é desktop MDI sem API; construir roteamento para formulários desktop não é viável. Além disso, sistema é pequeno — o benefício de migração incremental não justifica o investimento em infraestrutura de roteamento.

---

### Branch by Abstraction

**Razão para descarte:** O paradigma muda completamente (procedural → OO + async). Não há camada de negócio abstraída no legado; regras estão embutidas nos formulários. Criar uma abstração sobre o legado para depois substituir a implementação seria mais trabalho que reescrever diretamente.

---

## Recomendação

### Estratégia Recomendada: Big Bang

**Justificativa rastreável:**

1. **Tamanho do sistema**: Sistema é pequeno (~70 arquivos, 18 tabelas). Big Bang em sistema pequeno é pattern reconhecido em migrações transformationais.

2. **Apetite transformational**: Decisão explícita em `paradigm_decision.md` para adotar paradigma natural. Big Bang permite aplicação completa do novo paradigma sem workaround.

3. **Sem restrições operacionais**: Brief não impõe janelas ou paralisação mínima. Experimento tem flexibilidade total.

4. **Sem integrações externas**: Ausência de APIs, web services ou sistemas dependentes reduz drasticamente o risco de Big Bang.

5. **Custo-benefício**: Custo baixo (sem infraestrutura de coexistência) vs. benefício de simplicidade. Parallel Run teria custo de sincronização Access ↔ PostgreSQL que pode exceder o benefício.

6. **Mitigação de riscos críticos**: Risco de Big Bang (sem validação prévia) pode ser mitigado com:
   - Testes de paridade automatizados (agente Inspector)
   - Backup completo do banco Access antes do cutover
   - Período de "pilot" com usuário de teste
   - Plano de rollback claro (restaurar backup + executável legado)

**Nota importante:** Dada a severidade do gap de paradigma (alto) e a existência de regras de negócio críticas (financeiras), recomenda-se fortemente um período de **validação intensiva** antes do cutover, mesmo com estratégia Big Bang. Isso significa: desenvolvimento completo → testes de paridade → cutover (não desenvolvimento → cutover direto).

---

## Outras Estratégias (Não Recomendadas)

### Parallel Run (NÃO recomendada)

**Justificativa:** Embora seja excelente para mitigar riscos, o custo de manutenção de dois sistemas + sincronização Access ↔ PostgreSQL não se justifica para um sistema pequeno em contexto de experimento. A diferença entre custo alto vs. benefício marginal torna esta estratégia não recomendada para este caso específico.

**Quando reconsiderar:** Se durante o desenvolvimento forem descobertas de complexidade não antecipada (ex: cálculo de multa mais complexo que o documentado, ou regras ocultas no código legado), Parallel Run pode ser revisto como mitigação.

---

## Plano de Execução (Big Bang Recomendado)

1. **Desenvolvimento completo** do sistema novo (Python + FastAPI + PostgreSQL)
2. **Testes de paridade** automatizados (agente Inspector)
3. **Pilot com usuário de teste** (simulação de fluxos críticos)
4. **Backup do banco Access** (ponto de restauração)
5. **Cutover planejado** (janela de 2-4 horas)
6. **Validação pós-cutover** (checar regras críticas: multa, estoque)
7. **Rollback se necessário** (restaurar backup + executável legado)

---

## Decisão do Usuário

**Estratégia escolhida:** Big Bang  
**Decisor:** Sandoval  
**Data:** 2026-05-12  
**Justificativa:** Aceita recomendação baseada em tamanho pequeno do sistema, apetite transformational e ausência de restrições operacionais.

---

## Referências Cruzadas

- `paradigm_decision.md` — Decisão de paradigma transformational
- `target_business_rules.md` — Regras críticas identificadas pelo Curator
- `risk_register.md` — Riscos detalhados da estratégia recomendada
- `cutover_plan.md` — Plano detalhado de cutover para Big Bang
