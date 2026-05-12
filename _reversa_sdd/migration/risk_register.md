---
schemaVersion: 1
generatedAt: 2026-05-12T00:00:00Z
reversa:
  version: "1.2.34"
kind: risk_register
producedBy: strategist
hash: "sha256:<hash do corpo abaixo do front-matter>"
---

# Risk Register — CDsLoc

> Registro de riscos da migração, com probabilidade, impacto, mitigação e planos de contingência.
> Estratégia: Big Bang (recomendada)

---

## Resumo

- Total de riscos identificados: 12
- Críticos: 2
- Altos: 5
- Médios: 4
- Baixos: 1

---

## Riscos da Estratégia (Big Bang)

### RISK-001 - Rollback Complexo sem Coexistência

| Campo | Valor |
|-------|-------|
| **Descrição** | Big Bang não permite rollback gradual. Erro no go-live pode deixar sistema indisponível sem caminho de retorno simples. |
| **Probabilidade** | Média |
| **Impacto** | Alto |
| **Categoria** | Operacional |
| **Mitigação** |
| - Backup completo do banco Access antes do cutover |
| - Plano de rollback testado (restaurar backup + executável legado) |
| - Janela de cutover com usuários de teste |
| - Checklist de validação pós-cutover antes de liberar produção |
| **Contingência** | Se cutover falhar: (1) Notificar usuários, (2) Restaurar backup do Access, (3) Distribuir executável legado, (4) Retomar operação no legado |
| **Owner** | Operações / DevOps |
| **Status** | Aberto |

---

### RISK-002 - Erros Descobertos Somente em Produção

| Campo | Valor |
|-------|-------|
| **Descrição** | Sem período de coexistência, erros podem ser descobertos apenas quando usuários reais começarem a usar o sistema novo. |
| **Probabilidade** | Alta |
| **Impacto** | Alto |
| **Categoria** | Operacional |
| **Mitigação** |
| - Período de "piloto" com usuários de teste em ambiente de staging |
| - Testes de paridade automatizados (agente Inspector) |
| - Validação intensiva de fluxos críticos (locação, devolução com multa) |
| - Plano de suporte intensivo nas primeiras 48h pós-cutover |
| **Contingência** | Se erros críticos em produção: (1) Isolar funcionalidade afetada, (2) Implementar hotfix, (3) Testar em staging, (4) Deploy emergencial |
| **Owner** | QA / Engenharia |
| **Status** | Aberto |

---

## Riscos de Paradigma

### RISK-003 - Async/Await em Todo o Stack Pode Causar Bugs

| Campo | Valor |
|-------|-------|
| **Descrição** | Paradigma alvo exige async/await em toda operação de banco. Bugs comuns: esquecer await, bloquear event loop, race conditions. |
| **Origem** | `paradigm_decision.md` § Implicações pendentes |
| **Probabilidade** | Alta |
| **Impacto** | Médio |
| **Categoria** | Técnica |
| **Mitigação** |
| - Linting rigoroso (ruff com regras async-specific) |
| - Type hints obrigatórios em todos os métodos de repository |
| - Testes automatizados cobrindo todos os endpoints async |
| - Code review focado em async/await patterns |
| **Contingência** | Se bug async em produção: (1) Adicionar logging detalhado, (2) Corrigir e deploy hotfix |
| **Owner** | Engenharia |
| **Status** | Aberto |

---

### RISK-004 - Pydantic Validation Pode Diferir do Legado

| Campo | Valor |
|-------|-------|
| **Descrição** | Validação declarativa via Pydantic pode ser mais estrita ou mais flexível que as validações imperativas do VB6. Usuário pode perceber diferenças. |
| **Origem** | `paradigm_decision.md` § Validação de campos |
| **Probabilidade** | Média |
| **Impacto** | Baixo |
| **Categoria** | Técnica |
| **Mitigação** |
| - Documentar diferenças de validação em release notes |
| - Testes de paridade focados em edge cases de validação |
| - Feedback de usuário nos primeiros dias pós-cutover |
| **Contingência** | Se reclamações frequentes: ajustar validadores Pydantic e deploy |
| **Owner** | Engenharia / Produto |
| **Status** | Aberto |

---

### RISK-005 - Tratamento de Erros HTTP vs. MsgBox

| Campo | Valor |
|-------|-------|
| **Descrição** | Legado usa MsgBox imperativo. Novo sistema retorna HTTP status codes. Usuários esperam mensagens amigáveis em vez de códigos de erro. |
| **Origem** | `paradigm_decision.md` § Tratamento de erro |
| **Probabilidade** | Média |
| **Impacto** | Médio |
| **Categoria** | UX |
| **Mitigação** |
| - Middleware global para converter HTTPException em mensagens amigáveis |
| - Testes focados em UX de erro (mensagens claras, não 400/500 crus) |
| - Guia de migração para usuários documentando mudanças de UX |
| **Contingência** | Se reclamações de UX de erro: ajustar middleware e deploy |
| **Owner** | Engenharia / UX |
| **Status** | Aberto |

---

## Riscos de Dados

### RISK-006 - Perda de Dados na Migração Access → PostgreSQL

| Campo | Valor |
|-------|-------|
| **Descrição** | Script de migração pode não migrar todos os dados, ou tipo de dados pode não mapear corretamente. |
| **Probabilidade** | Média |
| **Impacto** | Crítico |
| **Categoria** | Dados |
| **Mitigação** |
| - Backup completo do Access antes da migração |
| - Script de migração com validação de contagem (COUNT legado = COUNT novo) |
| - Testes de migração com dados de produção (cópia anonimizada) |
| - Validação de integridade referencial pós-migração |
| **Contingência** | Se perda de dados detectada: (1) Parar sistema novo, (2) Investigar causa, (3) Corrigir script, (4) Re-migrar, (5) Restaurar backup legado se necessário |
| **Owner** | Engenharia / DBA |
| **Status** | Aberto |

---

### RISK-007 - Codificação de Caracteres (Access ANSI vs. UTF-8)

| Campo | Valor |
|-------|-------|
| **Descrição** | Access usa encoding ANSI/local. PostgreSQL usa UTF-8 por padrão. Caracteres acentuados podem corromper na migração. |
| **Probabilidade** | Média |
| **Impacto** | Alto |
| **Categoria** | Dados |
| **Mitigação** |
| - Script de migração com encoding explícito (latin1 → utf-8) |
| - Testes com nomes de clientes com acentos, cedilhas, etc. |
| - Validação de dados pós-migração (SELECT nomes com acentos) |
| **Contingência** | Se corrompimento detectado: (1) Re-migrar com encoding ajustado, (2) Deploy correção |
| **Owner** | Engenharia |
| **Status** | Aberto |

---

### RISK-008 - Esquema PostgreSQL Não Otimizado

| Campo | Valor |
|-------|-------|
| **Descrição** | Script de migração pode criar tabelas sem índices apropriados. Performance pode ser ruim em comparação ao Access. |
| **Probabilidade** | Baixa |
| **Impacto** | Médio |
| **Categoria** | Dados |
| **Mitigação** |
| - Criar índices para todas as FKs e campos frequentemente consultados (nomecliente, situacao, etc.) |
| - Testes de performance com volume de dados real |
| - Monitor de performance pós-cutover |
| **Contingência** | Se performance ruim: (1) Analisar slow queries, (2) Adicionar índices, (3) Reindexar |
| **Owner** | Engenharia / DBA |
| **Status** | Aberto |

---

## Riscos Operacionais

### RISK-009 - Janela de Cutover Pode Exceder Tempo Planejado

| Campo | Valor |
|-------|-------|
| **Descrição** | Cutover planejado para 2-4 horas pode estender devido a problemas inesperados. Usuários ficam sem sistema. |
| **Probabilidade** | Média |
| **Impacto** | Alto |
| **Categoria** | Operacional |
| **Mitigação** |
| - Comunicar janela de cutover com margem de segurança (ex: "sistema indisponível das 8h às 13h") |
| - Checklist detalhado de cutover com tempos estimados por item |
| - Team de suporte em standby |
| - Plano de contingência (prorrogar janela se necessário) |
| **Contingência** | Se cutover exceder: (1) Comunicar prorrogação, (2) Priorizar funcionalidades críticas, (3) Liberar parcialmente se necessário |
| **Owner** | Operações / DevOps |
| **Status** | Aberto |

---

### RISK-010 - Usuários Não Se Adaptam à Nova Interface

| Campo | Valor |
|-------|-------|
| **Descrição** | Mudança de desktop MDI (VB6) para web/browser (FastAPI) pode causar rejeição ou dificuldade de uso. |
| **Probabilidade** | Baixa |
| **Impacto** | Médio |
| **Categoria** | Organizacional |
| **Mitigação** |
| - Treinamento de usuários antes do cutover (workshop com demonstração) |
| - Guia de migração com screenshots e fluxos passo-a-passo |
| - Período de suporte intensivo nas primeiras 2 semanas |
| - Canal de feedback dedicado para report de UX issues |
| **Contingência** | Se reclamações significativas: (1) Priorizar ajustes de UX, (2) Release incremental com melhorias |
| **Owner** | Produto / Operações |
| **Status** | Aberto |

---

## Riscos Organizacionais

### RISK-011 - Capacidade do Time na Stack Alvo (Python/FastAPI)

| Campo | Valor |
|-------|-------|
| **Descrição** | Time pode não ter experiência com Python, FastAPI, PostgreSQL, Docker. Curva de aprendizado pode impactar cronograma. |
| **Probabilidade** | Média |
| **Impacto** | Médio |
| **Categoria** | Organizacional |
| **Mitigação** |
| - Bootcamp técnico com focus em Python/FastAPI antes do início |
| - Pair programming em áreas críticas (autenticação, transações) |
| - Code review rigoroso para compartilhar conhecimento |
| - Consultoria externa se necessário |
| **Contingência** | Se time não conseguir avançar: (1) Ajustar escopo (MVP reduzido), (2) Contratar consultoria, (3) Estender cronograma |
| **Owner** | Liderança técnica / RH |
| **Status** | Aberto |

---

### RISK-012 - Crystal Reports Não Substituído a Tempo

| Campo | Valor |
|-------|-------|
| **Descrição** | Substituição de Crystal Reports por HTML/PDF pode ser mais complexo que antecipado. Relatórios podem não ficar prontos para o cutover. |
| **Probabilidade** | Baixa |
| **Impacto** | Alto |
| **Categoria** | Técnica |
| **Mitigação** |
| - Priorizar relatórios críticos (Clientes, CDs, Locações) |
| - Usar template engine maduro (Jinja2 + WeasyPrint) |
| - Testes de visualização comparativa (legado vs novo) |
| - Contingência: relatórios simples em CSV se HTML/PDF não ficar pronto |
| **Contingência** | Se relatórios não ficarem prontos: (1) Lançar sistema sem relatórios (funcionalidades de CRUD prioritárias), (2) Relatórios em fase 2 |
| **Owner** | Engenharia |
| **Status** | Aberto |

---

## Riscos de Regras de Negócio

### RISK-013 - Cálculo de Multa Diferente do Legado (Financeiro)

| Campo | Valor |
|-------|-------|
| **Descrição** | Multa foi definida como R$ 3,50/dia pelo usuário (P-01), mas pode haver lógica adicional no código legado não documentada (ex: multa não cobrada em feriados). |
| **Origem** | `target_business_rules.md` § BR-MIGRAR-033 |
| **Probabilidade** | Baixa |
| **Impacto** | Crítico |
| **Categoria** | Negócio |
| **Mitigação** |
| - Revisão detalhada do código VB6 de locação/devolução (LOCDEVOL.FRM) em busca de lógica de multa |
| - Testes de paridade com cenários de atraso em feriados/domingos |
| - Validação com usuário de negócio (stakeholder) |
| **Contingência** | Se divergência detectada após cutover: (1) Analisar impacto financeiro, (2) Corrigir lógica, (3) Emitir notas de crédito se necessário |
| **Owner** | Engenharia / Negócio |
| **Status** | Aberto |

---

## Matriz de Riscos

| ID | Descrição Resumida | Probabilidade | Impacto | Categoria | Prioridade |
|----|-------------------|---------------|----------|-----------|------------|
| RISK-001 | Rollback complexo | Média | Alto | Operacional | Alta |
| RISK-002 | Erros só em produção | Alta | Alto | Operacional | Alta |
| RISK-003 | Bugs async/await | Alta | Médio | Técnica | Alta |
| RISK-004 | Validação Pydantic difere | Média | Baixo | Técnica | Média |
| RISK-005 | UX de erro (HTTP vs MsgBox) | Média | Médio | UX | Média |
| RISK-006 | Perda de dados na migração | Média | Crítico | Dados | Crítica |
| RISK-007 | Encoding ANSI vs UTF-8 | Média | Alto | Dados | Alta |
| RISK-008 | Esquema PostgreSQL não otimizado | Baixa | Médio | Dados | Média |
| RISK-009 | Janela de cutover excedida | Média | Alto | Operacional | Alta |
| RISK-010 | Usuários não se adaptam | Baixa | Médio | Organizacional | Média |
| RISK-011 | Capacidade no stack alvo | Média | Médio | Organizacional | Alta |
| RISK-012 | Crystal Reports não substituído | Baixa | Alto | Técnica | Média |
| RISK-013 | Cálculo de multa divergente | Baixa | Crítico | Negócio | Crítica |

---

## Notas

1. **Riscos críticos (RISK-006, RISK-013)**: Ambos envolvem dados e/ou financeiro. Devem ser tratados como top priority. Validação intensiva e testes de paridade são obrigatórios.

2. **Validação de encoding (RISK-007)**: Brasil tem muitos acentos e cedilhas. Encoding é risco real, não teórico. Script de migração deve ter atenção especial.

3. **Capacidade no stack alvo (RISK-011)**: Se time não tem experiência com Python/FastAPI, recomenda-se bootcamp técnico ou contratar consultoria externa para acelerar.

4. **Relatórios (RISK-012)**: Crystal Reports é tecnologia obsoleta; substituição pode ser mais complexa que o antecipado. Recomenda-se priorizar relatórios críticos e deixar relatórios secundários para fase 2 se necessário.
