# Architecture Decision Records (ADRs)

> Decisões arquiteturais inferidas do sistema CDsLoc
> Gerado pelo Reversa em 2026-05-08

---

## Índice de ADRs

| ID | Título | Data | Status |
|----|--------|------|--------|
| [001](001-architecture-vb6-desktop.md) | Arquitetura Desktop Visual Basic 6.0 | 1998 (inferido) | Aceito |
| [002](001-architecture-vb6-desktop.md) | Persistência via Microsoft Access e DAO 2.5 | 1998 (inferido) | Aceito |
| [003](001-architecture-vb6-desktop.md) | Criptografia de Senha via XOR | 1998 (inferido) | Aceito |
| [004](001-architecture-vb6-desktop.md) | Geração de Códigos Sequenciais | 1998 (inferido) | Aceito |
| [005](001-architecture-vb6-desktop.md) | Interface MDI com SSTab | 1998 (inferido) | Aceito |
| [006](001-architecture-vb6-desktop.md) | Sem Autenticação por Usuário | 1998 (inferido) | Aceito |
| [007](001-architecture-vb6-desktop.md) | Mensagens Externalizadas em Arquivo Texto | 1998 (inferido) | Aceito |
| [008](001-architecture-vb6-desktop.md) | Limpeza de Controles via Tag = "N" | 1998 (inferido) | Aceito |

---

## Sobre os ADRs

Como o sistema **não possui histórico Git** (repositório criado em 2026), estes ADRs são **inferidos retroativamente** a partir de:

- Análise do código fonte (VB6)
- Padrões arquiteturais observados
- Decisões de design evidenciadas na implementação

### Método de Inferência

1. **Identificação:** Padrão recorrente no código
2. **Contextualização:** Análise do problema que o padrão resolve
3. **Documentação:** Registro da decisão, consequências e alternativas

### Notas

- 🟡 **Confiança inferida:** As datas e contexto são inferidos, não confirmados
- 🔴 **Lacunas:** Algumas decisões podem não estar completas devido à ausência de documentação original
- ✅ **Confirmado:** Padrões de código são confirmados pela análise do Archaeologist

---

## Recomendações para Re-implementação

Estes ADRs servem como base para decisões futuras em uma re-implementação:

- ✅ Manter padrões válidos (MDI, SSTab)
- ❌ Substituir padrões obsoletos (XOR, DAO)
- 🔄 Modernizar conceitos (RBAC, Hash de senha)
- 📝 Considerar requisitos modernos (concorrência, auditoria)
