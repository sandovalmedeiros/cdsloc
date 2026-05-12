---
schemaVersion: 1
generatedAt: 2026-05-12T00:00:00Z
reversa:
  version: "1.2.34"
kind: migration_brief
producedBy: orchestrator
user: Sandoval
---

# Migration Brief — CDsLoc

> Documento de critério de migração coletado em entrevista.
> Consumido pelos cinco agentes do Time de Migração.

---

## Objetivo da migração

A aplicação foi desenvolvida em 1998 como um sistema monolítico utilizando:
- Visual Basic 6 (descontinuado há mais de 15 anos)
- Banco de dados .mdb (Access/Jet Engine, descontinuado)
- Gerador de Relatório Crystal Reports (versão antiga, descontinuado)

Estas tecnologias estão descontinuadas há um bom tempo, tornando o sistema difícil de manter e executar em ambientes modernos. A migração visa atualizar a tecnologia base mantendo a funcionalidade. A mudança seria para melhor caso seja executada.

---

## Métricas de sucesso

- A aplicação deve executar todos os seus módulos como foi planejado inicialmente
- Ganhos de performance em relação ao sistema legado
- Paridade funcional: todos os recursos existentes devem estar presentes no sistema novo

---

## Restrições

- **Prazo**: Não há prazo rígido (experimento de migração usando Reversa)
- **Orçamento**: Sem restrição orçamentária definida
- **Técnicas**: Por se tratar de um experimento, não há restrições técnicas
- **Operacionais**: Sem restrições operacionais

---

## Fatores de risco conhecidos

- **Risco principal**: A migração não ser bem-sucedida por falta de especificação adequada
- Este é um experimento para validar a capacidade do Reversa em documentar e guiar a migração de sistemas legados

---

## Stakeholders

| Nome / papel | Responsabilidade na migração |
|--------------|------------------------------|
| Contratante da solução | Validar resultados, aprovar entregas |

---

## Stack alvo

- **Linguagem**: Python
- **Framework**: FastAPI
- **Banco de dados**: PostgreSQL
- **Infra**: Container Docker
- **Outros componentes**: A definir durante o design

---

## Escopo declarado

- **Incluído**: Todos os módulos do sistema legado (cadastro-clientes, cadastro-cds, movimentação, reservas, consultas, relatórios)
- **Excluído**: Nenhum módulo

---

## Notas livres

Esta é uma migração experimental para validar a capacidade do Reversa em documentar e guiar a migração de um sistema legado descontinuado (VB6 + Access + Crystal Reports) para uma stack moderna (Python + FastAPI + PostgreSQL + Docker).
