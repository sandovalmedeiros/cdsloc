# Perguntas de Validação — CDsLoc

> Gerado pelo Reversa em 2026-05-11
> Perguntas críticas que requerem validação do usuário

---

## Tema 1: Cálculo de Multa por Atraso (CRÍTICO)

### P-01: Fórmula de Cálculo de Multa

**Contexto:** A feature de movimentação calcula multa por atraso na devolução de CDs, mas a fórmula exata não foi encontrada no código analisado.

**Evidência encontrada:**
- Regra de negócio documenta que multa é aplicada se devolução após data prevista (🟢 CONFIRMADO)
- Design.md: "Fórmula de cálculo de multa por dias de atraso não foi encontrada no código"
- Tasks.md: "FÓRMULA A DEFINIR" marcada como 🔴 LACUNA

**Pergunta:**
Qual é a regra de negócio para cálculo de multa por atraso na devolução de CDs?

**Opções:**
- [X] Valor fixo por dia de atraso (ex: R$ 1,00 por dia)
- [ ] Porcentagem do valor da locação (ex: 10% do valor por dia)
- [ ] Tabela de valores (ex: até 3 dias = X, 4-7 dias = Y, etc.)
- [ ] Multa única independente de dias de atraso
- [ ] Outro (descreva): _______________

**Resposta:**
Valor fixo por dia de atraso: **R$ 3,50**

---

## Tema 2: Controle de Estoque de CDs

### P-02: Validação de Estoque ao Cadastrar CD Físico

**Contexto:** O sistema possui campo `qtde` na tabela `titulo` que define quantos exemplares existem, mas não foi encontrada validação para impedir que quantidade de CDs físicos exceda esse valor.

**Evidência encontrada:**
- Requirements cadastro-cds: "Estoque Limitado por Título: Quantidade de CDs físicos não deve exceder `qtde` do título | 🟡 INFERIDO"
- Design cadastro-cds: "🔴 Validação de estoque: Não há validação para impedir que quantidade de CDs físicos exceda `qtde` do título"

**Pergunta:**
O sistema deve impedir o cadastro de mais CDs físicos do que o especificado no campo `qtde` do título?

**Opções:**
- [X] Sim, bloquear cadastro se `COUNT(cd por titulo) >= titulo.qtde`
- [ ] Não, permitir qualquer quantidade (o campo `qtde` é apenas informativo)
- [ ] Sim, mas com alerta (permite cadastrar mas avisa que excedeu)
- [ ] Outro (descreva): _______________

**Resposta:**
Sim, bloquear cadastro se COUNT(cd por título) >= titulo.qtde

### P-03: Atualização Automática de Estoque

**Contexto:** Não foi confirmado no código se o campo `qtde` do título é atualizado automaticamente ao cadastrar/excluir CDs físicos.

**Evidência encontrada:**
- Design cadastro-cds: "🟡 Atualização de estoque: Lógica para decrementar/incrementar estoque ao cadastrar/excluir CD físico não confirmada"

**Pergunta:**
Ao cadastrar ou excluir um CD físico, o campo `qtde` do título deve ser atualizado automaticamente?

**Opções:**
- [X] Sim, `qtde` deve ser sempre igual ao número de CDs físicos existentes
- [ ] Não, `qtde` é informado manualmente no cadastro do título
- [ ] Outro (descreva): _______________

**Resposta:**
Sim, qtde deve ser sempre igual ao número de CDs físicos existentes

---

## Tema 3: Situação de CDs

### P-04: Situação "Reservado"

**Contexto:** O design menciona situação "Reservado" para CDs, mas essa situação não foi encontrada explicitamente no código.

**Evidência encontrada:**
- Domain.md: "Situação de CD | Reservado | 🟡 INFERIDO (não encontrado explicitamente no código)"
- Design cadastro-cds: "🔴 Situação 'Reservado': Situação inferida mas não encontrada explicitamente no código"

**Pergunta:**
CDs podem ter situação "Reservado" além de "Disponível" e "Locado"?

**Opções:**
- [X] Sim, quando uma reserva é feita, CDs do título são marcados como "Reservado"
- [ ] Não, o sistema só usa "Disponível" e "Locado"
- [ ] A situação é informacional apenas (calculada dinamicamente, não persistida)
- [ ] Outro (descreva): _______________

**Resposta:**
Sim, quando uma reserva é feita, CDs do título são marcados como "Reservado"

---

## Tema 4: Exclusão com Integridade

### P-05: Exclusão de Cliente com Locações Pendentes

**Contexto:** O sistema trata erro 3200 para integridade referencial ao excluir cliente com dependentes, mas o comportamento para locações pendentes não foi confirmado.

**Evidência encontrada:**
- Requirements cadastro-clientes: "🔴 Comportamento de tentativa de exclusão de cliente com locações pendentes não foi confirmado no código"

**Pergunta:**
Ao tentar excluir um cliente que tem locações pendentes (devolução não realizada), qual deve ser o comportamento?

**Opções:**
- [X] Bloquear exclusão com mensagem de erro (mesmo tratamento de dependentes)
- [ ] Permitir exclusão mas manter histórico de locações
- [ ] Bloquear se houver locações não baixadas, permitir se todas baixadas
- [ ] Outro (descreva): _______________

**Resposta:**
Bloquear exclusão com mensagem de erro

### P-06: Exclusão de Título com CDs Físicos

**Contexto:** Não foi confirmado se exclusão de título com CDs físicos cadastrados é bloqueada.

**Evidência encontrada:**
- Design cadastro-cds: "🔴 Exclusão de título com CDs físicos: Comportamento não confirmado (deve falhar com erro 3200 mas precisa validação)"

**Pergunta:**
Ao tentar excluir um título que possui CDs físicos cadastrados, qual deve ser o comportamento?

**Opções:**
- [X] Bloquear exclusão com mensagem de erro de integridade referencial
- [ ] Permitir exclusão (deleta título e mantém CDs órfãos)
- [ ] Excluir em cascata (deleta título e todos os CDs físicos relacionados)
- [ ] Outro (descreva): _______________

**Resposta:**
Bloquear exclusão com mensagem de erro de integridade referencial

---

## Tema 5: Reservas

### P-07: Conversão de Reserva em Locação

**Contexto:** O sistema permite converter reserva em locação, mas não está claro como a situação da reserva é atualizada após a conversão.

**Evidência encontrada:**
- Requirements reservas: "🔴 Atualização de situação da reserva: Ao converter em locação, situação da reserva não confirmada no código"
- Design reservas: "🔴 Atualização de situação da reserva ao converter em locação: Não confirmado no código - deve ser atualizada para 'Confirmada' ou 'Locada'"

**Pergunta:**
Ao converter uma reserva em locação, qual deve ser o comportamento da reserva?

**Opções:**
- [X] Marcar situação da reserva como "Confirmada" (mantém histórico)
- [ ] Marcar situação da reserva como "Locada"
- [ ] Excluir a reserva (reserva cumprida, não é mais necessária)
- [ ] Outro (descreva): _______________

**Resposta:**
Marcar situação da reserva como "Confirmada" (mantém histórico)

### P-08: Múltiplas Reservas do Mesmo Título pelo Mesmo Cliente

**Contexto:** O sistema permite múltiplas reservas para o mesmo título, mas não está claro se há alerta quando o mesmo cliente faz reservas duplicadas.

**Evidência encontrada:**
- Design reservas: "🔴 Múltiplas reservas simultâneas: Comportamento não confirmado se há alerta ao reservar título já reservado pelo mesmo cliente"

**Pergunta:**
Se um cliente tenta fazer uma segunda reserva do mesmo título, qual deve ser o comportamento?

**Opções:**
- [ ] Permitir sem alerta (múltiplas reservas permitidas)
- [ ] Permitir mas exibir aviso de reserva duplicada
- [X] Bloquear reserva duplicada do mesmo cliente
- [ ] Outro (descreva): _______________

**Resposta:**
Bloquear reserva duplicada do mesmo cliente

### P-09: Data Prevista da Reserva

**Contexto:** A tabela `reserva` tem campo `data_prevista` mas não foi confirmado se é informado manualmente ou calculado automaticamente.

**Evidência encontrada:**
- Design reservas: "🟡 Data prevista: Campo existe na tabela mas uso não confirmado - pode ser informado manualmente ou calculado automaticamente"

**Pergunta:**
Como a data prevista da reserva deve ser definida?

**Opções:**
- [ ] Informada manualmente pelo usuário
- [ ] Calculada automaticamente como data atual + X dias
- [X] Calculada baseada na disponibilidade do título
- [ ] Não utilizada (campo pode ser removido)
- [ ] Outro (descreva): _______________

**Resposta:**
Calculada baseada na disponibilidade do título

---

## Tema 6: Relatórios

### P-10: Estrutura dos Relatórios

**Contexto:** Os arquivos `.rpt` do Crystal Reports não foram analisados, então os campos exibidos em cada relatório não foram documentados.

**Evidência encontrada:**
- Design relatorios: "🔴 Estrutura dos relatórios não analisada: Campos exibidos em cada relatório não foram documentados"
- Tasks relatorios: "🔴 Estrutura dos relatórios não analisada: Campos exibidos em cada relatório não foram documentados - requer análise dos arquivos `.rpt`"

**Pergunta:**
Deseja que eu analise os arquivos `.rpt` para documentar a estrutura de cada relatório?

**Opções:**
- [X] Sim, análise detalhada dos campos de cada relatório
- [ ] Não, estrutura atual (listagem por relatório) é suficiente
- [ ] Priorizar apenas relatórios principais (Clientes, CDs, Locações)
- [ ] Outro (descreva): _______________

**Resposta:**
Sim, análise detalhada dos campos de cada relatório

### P-11: Parâmetros de Relatório

**Contexto:** Não foi confirmado se os relatórios aceitam parâmetros (filtro por período, cliente específico, etc.).

**Evidência encontrada:**
- Design relatorios: "🔴 Parâmetros de relatório: Não confirmado se os relatórios aceitam parâmetros (filtro por período, cliente específico, etc.)"

**Pergunta:**
Os relatórios devem aceitar parâmetros/filtros?

**Opções:**
- [X] Sim, permitir filtros por período, cliente, status, etc.
- [ ] Não, relatórios sem filtro (mostram todos os registros)
- [ ] Alguns relatórios com filtro, outros sem (especificar quais)
- [ ] Outro (descreva): _______________

**Resposta:**
Sim, permitir filtros por período, cliente, status, etc.

### P-12: Motor de Relatórios na Nova Implementação

**Contexto:** O legado usa Crystal Reports, que é uma tecnologia obsoleta.

**Evidência encontrada:**
- Design relatorios: "🔴 Dependência de Crystal Reports: Sistema depende de Crystal Reports instalado - pode não funcionar sem a instalação"
- Tasks relatorios: "🔴 Dependência de Crystal Reports: Sistema depende de Crystal Reports instalado - pode não funcionar sem a instalação; requer decisão sobre motor de relatórios alternativo"

**Pergunta:**
Na nova implementação, qual motor de relatórios deve ser utilizado?

**Opções:**
- [ ] Manter Crystal Reports (requer instalação)
- [ ] Migrar para JasperReports/iReport
- [ ] Migrar para ReportViewer (Microsoft)
- [X] Implementar relatórios como HTML/PDF gerados dinamicamente
- [ ] Outro (descreva): _______________

**Resposta:**
Implementar relatórios como HTML/PDF gerados dinamicamente

---

## Tema 7: Validações de Dados

### P-13: Validação de CPF

**Contexto:** O sistema permite informar CPF mas não valida o dígito verificador.

**Evidência encontrada:**
- Requirements cadastro-clientes: "🔴 Validação de CPF (se houver) não foi identificada no código analisado"
- Domain.md: "🔴 Validação de Data de Nascimento: Não há validação se data de nascimento é válida (futura, muito antiga)"

**Pergunta:**
A nova implementação deve validar o CPF (dígito verificador)?

**Opções:**
- [X] Sim, validar CPF completo (11 dígitos com verificador)
- [ ] Não, manter comportamento atual (CPF não é obrigatório, não é validado)
- [ ] Sim, mas apenas formato (verifica se tem 11 dígitos, não validação de verificador)
- [ ] Outro (descreva): _______________

**Resposta:**
Sim, validar CPF completo (11 dígitos com verificador)

### P-14: Validação de Data de Nascimento

**Contexto:** O sistema valida se a data é válida (`IsDate()`), mas não verifica se é uma data razoável (futura, muito antiga).

**Evidência encontrada:**
- Domain.md: "🔴 Validação de Data de Nascimento: Não há validação se data de nascimento é válida (futura, muito antiga) | 🟡 Pode aceitar datas inválidas"

**Pergunta:**
A nova implementação deve validar se a data de nascimento é razoável?

**Opções:**
- [X] Sim, não aceitar datas futuras ou anteriores a 1900
- [ ] Não, manter comportamento atual (apenas verifica se é uma data válida)
- [ ] Sim, com regra específica (mínimo 18 anos, etc.): _______________
- [ ] Outro (descreva): _______________

**Resposta:**
Sim, não aceitar datas futuras ou anteriores a 1900

---

## Tema 8: Transações e Atomicidade

### P-15: Tratamento de Transações na Locação

**Contexto:** Ao locar um CD, o sistema cria registro em `locacao` e atualiza `cd`. Não foi confirmado se isso é feito em uma transação atômica.

**Evidência encontrada:**
- Design movimentacao: "🔴 Transação atômica: Não confirmado se há tratamento de transação para garantir consistência entre locação e atualização do CD"
- Requirements movimentacao: "🟡 Atualização atômica de CD e locação | Transação ao locar"

**Pergunta:**
A nova implementação deve garantir atomicidade entre locação e atualização do CD?

**Opções:**
- [X] Sim, usar transação de banco (ambas as operações devem falhar ou suceder juntas)
- [ ] Não, manter comportamento atual (atualizações diretas)
- [ ] Sim, com compensação se falhar (reverter estado do CD se locação falhar)
- [ ] Outro (descreva): _______________

**Resposta:**
Sim, usar transação de banco (ambas as operações devem falhar ou suceder juntas)

---

## Resumo das Decisões Pendentes

| Pergunta | Tema | Prioridade |
|----------|------|------------|
| P-01 | Cálculo de Multa | 🔴 CRÍTICA |
| P-02 | Validação de Estoque | 🟡 ALTA |
| P-03 | Atualização Automática de Estoque | 🟡 ALTA |
| P-04 | Situação "Reservado" | 🟡 ALTA |
| P-05 | Exclusão de Cliente com Locações | 🟡 ALTA |
| P-06 | Exclusão de Título com CDs | 🟡 ALTA |
| P-07 | Conversão de Reserva | 🟡 ALTA |
| P-08 | Múltiplas Reservas | 🟢 MÉDIA |
| P-09 | Data Prevista da Reserva | 🟢 MÉDIA |
| P-10 | Estrutura de Relatórios | 🟢 MÉDIA |
| P-11 | Parâmetros de Relatório | 🟢 MÉDIA |
| P-12 | Motor de Relatórios | 🟡 ALTA |
| P-13 | Validação de CPF | 🟢 MÉDIA |
| P-14 | Validação de Data de Nascimento | 🟢 MÉDIA |
| P-15 | Tratamento de Transações | 🟡 ALTA |

---

## Como Responder

Responda a cada pergunta com:
1. **Opção escolhida** (marque com X)
2. **Detalhes adicionais** (se necessário)

Exemplo de resposta:

```
P-01: [X] Valor fixo por dia de atraso (ex: R$ 1,00 por dia)
Detalhes: R$ 2,00 por dia de atraso, com teto máximo de R$ 30,00
```

Você pode responder individualmente a cada pergunta ou em grupo por tema.
