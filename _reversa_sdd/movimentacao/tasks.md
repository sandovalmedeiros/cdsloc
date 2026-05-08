# Movimentação, Tarefas de Implementação

> Tarefas executáveis para reimplementar a feature de movimentação (locação e devolução)
> Gerado pelo Reversa em 2026-05-08

---

## Pré-requisitos

- [ ] Tabelas `locacao`, `recibo`, `cd`, `Cliente`, `dependente` existem no banco
- [ ] Recordsets globais `Wlocacao`, `Wrecibo` disponíveis
- [ ] Funções globais `geracod()`, `LimpaCampos()` e `trata_errobd()` implementadas
- [ ] Feature cadastro-clientes implementada (para pesquisar clientes)
- [ ] Feature cadastro-cds implementada (para pesquisar CDs disponíveis)

---

## Tarefas

### Tarefas de Implementação

#### Locação

- [ ] T-01, Criar formulário principal de movimentação com SSTab (3 abas)
  - Origem no legado: `LOCDEVOL.FRM:Form_Load`
  - Critério de pronto: Formulário carrega com 3 abas: Locação, Devolução, Recibo
  - Confiança: 🟢 CONFIRMADO

- [ ] T-02, Implementar pesquisa de cliente para locação
  - Origem no legado: `LOCDEVOL.FRM:pesquisa_cliente()`
  - Critério de pronto: Cliente encontrado por código ou nome, dados populados, dependentes carregados
  - Confiança: 🟢 CONFIRMADO

- [ ] T-03, Implementar verificação de cliente ativo
  - Origem no legado: `LOCDEVOL.FRM` (flag cancelado)
  - Critério de pronto: Se cliente cancelado, exibe mensagem e impede locação
  - Confiança: 🟢 CONFIRMADO

- [ ] T-04, Implementar seleção de dependente autorizado
  - Origem no legado: `LOCDEVOL.FRM:ChkDependente`, `CboDependente`
  - Critério de pronto: Checkbox habilita ComboBox, dependente vinculado à locação
  - Confiança: 🟢 CONFIRMADO

- [ ] T-05, Implementar listagem de CDs disponíveis
  - Origem no legado: `LOCDEVOL.FRM:CboCD`
  - Critério de pronto: ComboBox populada apenas com CDs `situacao = "Disponível"`
  - Confiança: 🟢 CONFIRMADO

- [ ] T-06, Implementar adição de CD à lista de locação
  - Origem no legado: `LOCDEVOL.FRM:BtnAddItem`
  - Critério de pronto: CD adicionado à lista, valor total atualizado
  - Confiança: 🟢 CONFIRMADO

- [ ] T-07, Implementar cálculo de data prevista de devolução
  - Origem no legado: `LOCDEVOL.FRM` (lógica de cálculo)
  - Critério de pronto: Data calculada conforme tipo (24h/48h), ajuste de domingo
  - Confiança: 🟢 CONFIRMADO

- [ ] T-08, Implementar gravação de locação (múltiplos itens)
  - Origem no legado: `LOCDEVOL.FRM:SSCmdGrava_Loc_Click`
  - Critério de pronto: Todos os itens gravados na tabela locacao, recibo criado
  - Confiança: 🟢 CONFIRMADO

- [ ] T-09, Implementar atualização de situação dos CDs para "Locado"
  - Origem no legado: `LOCDEVOL.FRM:SSCmdGrava_Loc_Click` (atualização de cd)
  - Critério de pronto: Todos os CDs locados marcados como `situacao = "Locado"`
  - Confiança: 🟢 CONFIRMADO

- [ ] T-10, Implementar emissão de recibo
  - Origem no legado: `LOCDEVOL.FRM:SSCmdGrava_Loc_Click` (criação de recibo)
  - Critério de pronto: Recibo criado na tabela recibo, valor total calculado
  - Confiança: 🟢 CONFIRMADO

- [ ] T-11, Implementar consulta de reservas do cliente
  - Origem no legado: `LOCDEVOL.FRM:pesquisa_reserva()`
  - Critério de pronto: Reservas do cliente exibidas, opção de converter em locação
  - Confiança: 🟢 CONFIRMADO

#### Devolução

- [ ] T-12, Implementar pesquisa de recibos pendentes
  - Origem no legado: `LOCDEVOL.FRM:cons_recibo()`
  - Critério de pronto: Recibos não baixados do cliente exibidos na ComboBox
  - Confiança: 🟢 CONFIRMADO

- [ ] T-13, Implementar carregamento de itens do recibo
  - Origem no legado: `LOCDEVOL.FRM:LstItensDev`
  - Critério de pronto: Itens da locação do recibo exibidos na lista
  - Confiança: 🟢 CONFIRMADO

- [ ] T-14, Implementar cálculo de dias de atraso
  - Origem no legado: `LOCDEVOL.FRM:SSCmdBaixa_Click`
  - Critério de pronto: Dias de atraso calculados vs data prevista
  - Confiança: 🟢 CONFIRMADO

- [ ] T-15, Implementar cálculo de multa por atraso
  - Origem no legado: `LOCDEVOL.FRM:SSCmdBaixa_Click`
  - Critério de pronto: Multa calculada conforme dias de atraso (FÓRMULA A DEFINIR)
  - Confiança: 🔴 LACUNA

- [ ] T-16, Implementar baixa de recibo (devolução)
  - Origem no legado: `LOCDEVOL.FRM:SSCmdBaixa_Click`
  - Critério de pronto: Locações atualizadas com data_devolucao, recibo marcado como devolvido
  - Confiança: 🟢 CONFIRMADO

- [ ] T-17, Implementar atualização de situação dos CDs para "Disponível"
  - Origem no legado: `LOCDEVOL.FRM:SSCmdBaixa_Click` (atualização de cd)
  - Critério de pronto: Todos os CDs devolvidos marcados como `situacao = "Disponível"`
  - Confiança: 🟢 CONFIRMADO

#### Recibo

- [ ] T-18, Implementar consulta de recibo por código
  - Origem no legado: `LOCDEVOL.FRM:BtnConsRec`
  - Critério de pronto: Recibo encontrado, dados populados, status exibido
  - Confiança: 🟢 CONFIRMADO

- [ ] T-19, Implementar exibição de itens do recibo
  - Origem no legado: `LOCDEVOL.FRM:LstItensRec`
  - Critério de pronto: Itens da locação do recibo exibidos na lista
  - Confiança: 🟢 CONFIRMADO

- [ ] T-20, Implementar impressão de recibo
  - Origem no legado: `LOCDEVOL.FRM:BtnImprimir`
  - Critério de pronto: Recibo formatado e enviado para impressora
  - Confiança: 🟡 INFERIDO

---

## Tarefas de Teste

- [ ] TT-01, Testar locação de CD com cliente ativo
  - Critério de pronto: Locação registrada, recibo gerado, CD marcado como Locado
  - Confiança: 🟢 CONFIRMADO

- [ ] TT-02, Testar tentativa de locação com cliente cancelado
  - Critério de pronto: Locação bloqueada, mensagem exibida
  - Confiança: 🟢 CONFIRMADO

- [ ] TT-03, Testar locação com dependente autorizado
  - Critério de pronto: Locação registrada em nome do dependente
  - Confiança: 🟢 CONFIRMADO

- [ ] TT-04, Testar cálculo de data prevista (24h e 48h)
  - Critério de pronto: Data calculada corretamente, ajuste de domingo aplicado
  - Confiança: 🟢 CONFIRMADO

- [ ] TT-05, Testar locação de múltiplos CDs
  - Critério de pronto: Todos os CDs gravados, recibo único criado
  - Confiança: 🟢 CONFIRMADO

- [ ] TT-06, Testar devolução no prazo
  - Critério de pronto: Devolução registrada, sem multa, CD marcado como Disponível
  - Confiança: 🟢 CONFIRMADO

- [ ] TT-07, Testar devolução com atraso
  - Critério de pronto: Devolução registrada, multa calculada e aplicada
  - Confiança: 🟢 CONFIRMADO

- [ ] TT-08, Testar tentativa de locar CD já locado
  - Critério de pronto: CD não aparece na lista de disponíveis ou é bloqueado
  - Confiança: 🟢 CONFIRMADO

---

## Tarefas de Migração de Dados

- [ ] TM-01, Migrar tabela `locacao` com todos os campos
  - Origem no legado: Tabela `locacao` em BD_CDLOC.mdb
  - Critério de pronto: Todas as locações migradas, estrutura preservada
  - Confiança: 🟢 CONFIRMADO

- [ ] TM-02, Migrar tabela `recibo`
  - Origem no legado: Tabela `recibo` em BD_CDLOC.mdb
  - Critério de pronto: Todos os recibos migrados, vínculos com locação mantidos
  - Confiança: 🟢 CONFIRMADO

---

## Ordem Sugerida

1. **Infraestrutura:** T-01 (formulário), T-07 (cálculo data), T-15 (definir fórmula multa)
2. **Locação:** T-02 (pesquisar cliente), T-03 (verificar ativo), T-04 (dependente), T-05 (listar CDs), T-06 (adicionar item), T-08 (gravar), T-09 (atualizar CD), T-10 (emitir recibo), T-11 (reservas)
3. **Devolução:** T-12 (pesquisar recibos), T-13 (carregar itens), T-14 (calcular atraso), T-16 (baixar), T-17 (atualizar CD)
4. **Recibo:** T-18 (consultar), T-19 (exibir itens), T-20 (imprimir)
5. **Testes:** TT-01 a TT-08

**Bloqueios:**
- T-02 a T-11 dependem de feature cadastro-clientes
- T-05, T-09, T-17 dependem de feature cadastro-cds
- T-08 a T-10 dependem de TM-01 (tabela locacao migrada)
- T-12 a T-13, T-18 a T-19 dependem de TM-01 e TM-02 (tabelas locacao e recibo)

---

## Lacunas Pendentes (🔴)

- 🔴 **Fórmula de cálculo de multa:** Não encontrada no código - requer definição da regra de negócio (valor por dia de atraso, porcentagem, etc.)
- 🔴 **Tabela valor_loc:** Referência a tabela de valores de locação mencionada mas não analisada - pode afetar cálculo de valor de locação
- 🔴 **Tratamento de transação:** Não confirmado se há tratamento de transação para garantir atomicidade entre locação e atualização do CD - deve ser implementado
- 🔴 **Exclusão de item da locação:** Comportamento não confirmado no código - se restaura estado do CD ou não
- 🔴 **Conversão de reserva em locação:** Fluxo não detalhado no código analisado
