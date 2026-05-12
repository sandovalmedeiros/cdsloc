---
schemaVersion: 1
generatedAt: 2026-05-12T00:00:00Z
reversa:
  version: "1.2.34"
kind: ambiguity_log
producedBy: curator
hash: "sha256:<hash do corpo abaixo do front-matter>"
---

# Ambiguity Log

> Registro de itens ambíguos que requerem decisão humana antes da implementação.

---

## Itens PENDENTES

### ABG-001 - Evolução de Autenticação: Senha Única para Múltiplos Usuários
- **ID relacionado**: BR-HUMANA-001
- **Origem**: `_reversa_sdd/domain.md` § Autenticação e Acesso
- **Tipo**: ⚠️ AMBÍGUA (estratégia evolutiva)
- **Descrição**:
  Sistema legado usa uma única senha global para todos os usuários. Paradigma alvo (OO + async + FastAPI) sugere implementação padrão com JWT, múltiplos usuários e roles.
- **Contexto**:
  - Legado: tabela `senha` com único registro, senha codificada via XOR
  - Alvo: Python + FastAPI + JWT é stack padrão moderno
  - `paradigm_decision.md`: decisão foi "Adotar paradigma natural" (transformational)
- **Opções**:
  1. **Manter senha única** (simplificar migração)
     - Vantagem: menos código, mais rápido de migrar
     - Desvantagem: não aproveita capacidades da stack alvo, limita futuro
  2. **Evoluir para múltiplos usuários** (padrão moderno)
     - Vantagem: padrão FastAPI, escalável, permite roles e permissões
     - Desvantagem: mais código a desenvolver
  3. **Híbrido** (senha única inicial + capacidade de criar usuários)
     - Vantagem: caminho evolutivo
     - Desvantagem: complexidade técnica, dois mecanismos coexistindo
- **Recomendação do Curator**: Opção 2 (Evoluir para múltiplos usuários)
  - Justificativa: Paradigma transformational foi adotado; JWT é padrão em FastAPI; múltiplos usuários é esperado em API REST; investimento inicial beneficia longo prazo
- **Status**: RESOLVIDA
- **Decisão**: Opção 2 - Evoluir para múltiplos usuários com JWT
- **Decisor**: Sandoval
- **Data**: 2026-05-12
- **Cross-reference**: `target_business_rules.md` § BR-HUMANA-001

### ABG-002 - Estrutura Detalhada de Relatórios [RESOLVIDA]
- **ID relacionado**: BR-HUMANA-002
- **Origem**: `_reversa_sdd/questions.md` § P-10
- **Tipo**: ⚠️ AMBÍGUA (escopo de análise)
- **Descrição**:
  Usuário respondeu "Sim, análise detalhada dos campos de cada relatório" para P-10, mas os arquivos `.rpt` do Crystal Reports não foram analisados pelo Time de Descoberta. A tecnologia Crystal Reports está sendo descartada (BR-DESCARTAR-004).
- **Contexto**:
  - Legado: 8 arquivos `.rpt` (clien01.rpt, clien02.rpt, depend.rpt, musicas.rpt, musicas1.rpt, cds.rpt, titulos.rpt, reserva.rpt)
  - Alvo: HTML/PDF gerados dinamicamente (decisão P-12 confirmada)
  - P-10: Usuário quer "análise detalhada dos campos de cada relatório"
  - P-11: Usuário quer filtros parametrizados nos relatórios
- **Opções**:
  1. **Analisar arquivos `.rpt`** para documentar campos exatos do legado
     - Vantagem: fidelidade total ao layout original
     - Desvantagem: Crystal Reports é tecnologia obsoleta sendo descartada; esforço pode não valer
  2. **Definir estrutura baseada em requisitos de negócio** (independente de legado)
     - Vantagem: foca no que o negócio precisa, não no que o legado tinha; layout moderno para HTML/PDF
     - Desvantagem: pode faltar campos que usuário esperava
  3. **Deixar estrutura flexível** para definição durante implementação
     - Vantagem: adaptação incremental
     - Desvantagem: risco de refactoring tardio
- **Recomendação do Curator**: Opção 2 (Definir estrutura baseada em requisitos)
  - Justificativa: Crystal Reports é tecnologia obsoleta sendo descartada; estrutura deve ser definida para HTML/PDF novo, não copiada do legado; requisitos de negócio estão documentados em `relatorios/requirements.md`
- **Status**: RESOLVIDA
- **Decisão**: Opção 2 - Descartar Crystal Reports, definir estrutura baseada em requisitos
- **Decisor**: Sandoval
- **Data**: 2026-05-12
- **Cross-reference**: `target_business_rules.md` § BR-HUMANA-002

---

## Histórico de Decisões

### RESOLVIDA - 2026-05-12

#### ABG-001 - Evolução de Autenticação: Senha Única para Múltiplos Usuários
- **Decisão**: Opção 2 - Evoluir para múltiplos usuários com JWT
- **Decisor**: Sandoval
- **Justificativa**: Aproveitar capacidades da stack alvo (FastAPI + JWT), seguir padrão moderno de APIs REST

#### ABG-002 - Estrutura Detalhada de Relatórios
- **Decisão**: Opção 2 - Descartar Crystal Reports, definir estrutura baseada em requisitos
- **Decisor**: Sandoval
- **Justificativa**: Crystal Reports é tecnologia obsoleta sendo descartada; estrutura deve ser definida para HTML/PDF novo

---

## Estatísticas

- Total de itens: 2
- PENDENTES: 0
- RESOLVIDAS: 2
