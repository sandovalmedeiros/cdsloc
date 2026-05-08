# Reservas, Tarefas de Implementação

> Tarefas executáveis para reimplementar a feature de reservas
> Gerado pelo Reversa em 2026-05-08

---

## Pré-requisitos

- [ ] Tabelas `reserva`, `titulo`, `Cliente`, `cd` existem no banco
- [ ] Recordset global `Wreserva` disponível
- [ ] Funções globais `geracod()`, `LimpaCampos()` e `trata_errobd()` implementadas
- [ ] Feature cadastro-clientes implementada (para pesquisar clientes)
- [ ] Feature cadastro-cds implementada (para pesquisar títulos)

---

## Tarefas

### Tarefas de Implementação

- [ ] T-01, Criar formulário principal de reservas
  - Origem no legado: `reservcd.frm:Form_Load`
  - Critério de pronto: Formulário carrega com campos para cliente, título e reserva
  - Confiança: 🟢 CONFIRMADO

- [ ] T-02, Implementar pesquisa de cliente
  - Origem no legado: `reservcd.frm:pesquisa_cliente()`
  - Critério de pronto: Cliente encontrado por código ou nome, dados populados
  - Confiança: 🟢 CONFIRMADO

- [ ] T-03, Implementar verificação de cliente ativo
  - Origem no legado: `reservcd.frm` (flag cancelado)
  - Critério de pronto: Se cliente cancelado, exibe mensagem e impede reserva
  - Confiança: 🟢 CONFIRMADO

- [ ] T-04, Implementar pesquisa de título
  - Origem no legado: `reservcd.frm:pesquisa_titulo()`
  - Critério de pronto: Título encontrado, dados populados
  - Confiança: 🟢 CONFIRMADO

- [ ] T-05, Implementar verificação de disponibilidade de CDs do título
  - Origem no legado: `reservcd.frm` (contagem de CDs)
  - Critério de pronto: Quantidade de CDs `situacao = "Disponível"` exibida
  - Confiança: 🟡 INFERIDO

- [ ] T-06, Implementar gravação de nova reserva
  - Origem no legado: `reservcd.frm:SSCmdGrava_Res_Click`
  - Critério de pronto: Reserva criada na tabela reserva, situação = "Pendente"
  - Confiança: 🟢 CONFIRMADO

- [ ] T-07, Implementar listagem de reservas do cliente
  - Origem no legado: `reservcd.frm:LstReservas`
  - Critérito de pronto: Todas as reservas pendentes do cliente exibidas na ListBox
  - Confiança: 🟢 CONFIRMADO

- [ ] T-08, Implementar exclusão de reserva
  - Origem no legado: `reservcd.frm:SSCmdExc_Res_Click`
  - Critério de pronto: Reserva removida da tabela reserva e da ListBox
  - Confiança: 🟢 CONFIRMADO

- [ ] T-09, Implementar limpeza de campos
  - Origem no legado: `reservcd.frm:SSCmdLimpa`
  - Critério de pronto: Campos de título limpos, cliente mantido
  - Confiança: 🟢 CONFIRMADO

- [ ] T-10, Implementar conversão de reserva em locação
  - Origem no legado: `LOCDEVOL.FRM:pesquisa_reserva()`
  - Critério de pronto: Reserva convertida em locação, situação atualizada
  - Confiança: 🟡 INFERIDO

- [ ] T-11, Implementar atualização de situação da reserva
  - Origem no legado: N/A (lacuna no código)
  - Critério de pronto: Situação da reserva atualizada para "Confirmada" ou "Locada" ao converter
  - Confiança: 🔴 LACUNA

---

## Tarefas de Teste

- [ ] TT-01, Testar reserva de título com cliente ativo
  - Critério de pronto: Reserva criada, situação = "Pendente"
  - Confiança: 🟢 CONFIRMADO

- [ ] TT-02, Testar tentativa de reserva com cliente cancelado
  - Critério de pronto: Reserva bloqueada, mensagem exibida
  - Confiança: 🟢 CONFIRMADO

- [ ] TT-03, Testar listagem de reservas do cliente
  - Critério de pronto: Todas as reservas pendentes exibidas
  - Confiança: 🟢 CONFIRMADO

- [ ] TT-04, Testar exclusão de reserva
  - Critério de pronto: Reserva removida da tabela e da lista
  - Confiança: 🟢 CONFIRMADO

- [ ] TT-05, Testar conversão de reserva em locação
  - Critério de pronto: Reserva convertida, locação criada, situação atualizada
  - Confiança: 🟢 CONFIRMADO

- [ ] TT-06, Testar verificação de disponibilidade de CDs
  - Critério de pronto: Quantidade de CDs disponíveis exibida corretamente
  - Confiança: 🟢 CONFIRMADO

- [ ] TT-07, Testar múltiplas reservas simultâneas
  - Critério de pronto: Sistema permite várias reservas para o mesmo título
  - Confiança: 🟢 CONFIRMADO

---

## Tarefas de Migração de Dados

- [ ] TM-01, Migrar tabela `reserva` com todos os campos
  - Origem no legado: Tabela `reserva` em BD_CDLOC.mdb
  - Critério de pronto: Todas as reservas migradas, estrutura preservada
  - Confiança: 🟢 CONFIRMADO

---

## Ordem Sugerida

1. **Infraestrutura:** T-01 (formulário), T-05 (verificar disponibilidade), T-11 (definir atualização de situação)
2. **CRUD Reservas:** T-02 (pesquisar cliente), T-03 (verificar ativo), T-04 (pesquisar título), T-06 (gravar), T-07 (listar), T-08 (excluir), T-09 (limpar)
3. **Conversão em Locação:** T-10 (converter), T-11 (atualizar situação)
4. **Testes:** TT-01 a TT-07

**Bloqueios:**
- T-02, T-03 dependem de feature cadastro-clientes
- T-04, T-05 dependem de feature cadastro-cds
- T-06 a T-08 dependem de TM-01 (tabela reserva migrada)

---

## Lacunas Pendentes (🔴)

- 🔴 **Atualização de situação da reserva ao converter em locação:** Não confirmado no código - deve ser implementada para manter consistência
- 🔴 **Verificação de disponibilidade de CDs ao reservar:** Lógica não confirmada - deve ser implementada se desejado
- 🔴 **Múltiplas reservas simultâneas:** Comportamento não confirmado se há alerta ao reservar título já reservado pelo mesmo cliente - requer decisão
- 🔴 **Exclusão de reservas convertidas em locação:** Comportamento não confirmado - deve ser definido se reservas confirmadas podem ser excluídas
- 🔴 **Data prevista da reserva:** Campo existe na tabela mas uso não confirmado - requer decisão se é informado manualmente ou calculado automaticamente
