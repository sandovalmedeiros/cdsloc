# Cadastro de Clientes, Tarefas de Implementação

> Tarefas executáveis para reimplementar a feature de cadastro de clientes
> Gerado pelo Reversa em 2026-05-08

---

## Pré-requisitos

- [ ] Tabelas `Cliente`, `dependente` e `Bairro` existem no banco
- [ ] Recordsets globais `wclien` e `Wdependente` disponíveis
- [ ] Funções globais `geracod()`, `LimpaCampos()` e `trata_errobd()` implementadas
- [ ] QueryDefs `Cs_Clientes` e `Cs_Dependente` configurados

---

## Tarefas

### Tarefas de Implementação

- [ ] T-01, Criar formulário principal de clientes (CLIENTE.FRM)
  - Origem no legado: `CLIENTE.FRM:Form_Load`
  - Critério de pronto: Formulário carrega com campos limpos, bairros populados, código gerado
  - Confiança: 🟢 CONFIRMADO

- [ ] T-02, Implementar validação de campos obrigatórios ao gravar
  - Origem no legado: `CLIENTE.FRM:SSCmdGrava_Cli_Click`
  - Critério de pronto: Valida código, nome, endereço, data-nascimento, bairro e identidade; exibe erro se vazio
  - Confiança: 🟢 CONFIRMADO

- [ ] T-03, Implementar geração automática de código de cliente
  - Origem no legado: `DECLARA.BAS:geracod()`
  - Critério de pronto: Código sequencial gerado via `geracod()`, formatado como 0000
  - Confiança: 🟢 CONFIRMADO

- [ ] T-04, Implementar gravação de novo cliente (AddNew)
  - Origem no legado: `CLIENTE.FRM:SSCmdGrava_Cli_Click` (caminho AddNew)
  - Critério de pronto: Registro inserido na tabela Cliente com todos os campos populados
  - Confiança: 🟢 CONFIRMADO

- [ ] T-05, Implementar atualização de cliente existente (Edit)
  - Origem no legado: `CLIENTE.FRM:SSCmdGrava_Cli_Click` (caminho Edit)
  - Critério de pronto: Registro atualizado na tabela Cliente sem criar duplicata
  - Confiança: 🟢 CONFIRMADO

- [ ] T-06, Implementar pesquisa de cliente por nome (case-insensitive)
  - Origem no legado: `CLIENTE.FRM:TxtNom_Cli_KeyPress (F10)`
  - Critério de pronto: Pesquisa via InStr case-insensitive, resultados em ListBox
  - Confiança: 🟢 CONFIRMADO

- [ ] T-07, Implementar carregamento de dados do cliente selecionado
  - Origem no legado: `CLIENTE.FRM:Dados_Cliente2()`
  - Critério de pronto: Cliente carregado via QueryDef `Cs_Clientes`, todos os campos populados, modo edição ativado
  - Confiança: 🟢 CONFIRMADO

- [ ] T-08, Implementar exclusão de cliente com tratamento de integridade referencial
  - Origem no legado: `CLIENTE.FRM:SSCmdExc_Cli_Click`
  - Critério de pronto: Cliente excluído se não tem dependentes; erro 3200 tratado com mensagem específica
  - Confiança: 🟢 CONFIRMADO

- [ ] T-09, Implementar cancelamento de cliente (soft-delete)
  - Origem no legado: `CLIENTE.FRM:SSCmdGrava_Cli_Click` (flag cancelado)
  - Critério de pronto: Flag `cancelado` marcada como True, cliente bloqueado para operações futuras
  - Confiança: 🟢 CONFIRMADO

- [ ] T-10, Implementar vinculação de bairro via DBCombo
  - Origem no legado: `CLIENTE.FRM:Form_Load` (SQL bairros)
  - Critério de pronto: DBCombo populada com lista de bairros ordenada por nome, código armazenado em `cdbairro`
  - Confiança: 🟢 CONFIRMADO

- [ ] T-11, Implementar aba/seção de dependentes
  - Origem no legado: `CLIENTE.FRM` (frame de dependentes)
  - Critério de pronto: Seção visível com campos para nome do dependente e lista de dependentes
  - Confiança: 🟢 CONFIRMADO

- [ ] T-12, Implementar cadastro de dependente
  - Origem no legado: `CLIENTE.FRM:SSCmdGrava_Dep_Click`
  - Critério de pronto: Dependente inserido na tabela dependente, vinculado ao cliente via `cod_cliente`
  - Confiança: 🟢 CONFIRMADO

- [ ] T-13, Implementar edição de dependente
  - Origem no legado: `CLIENTE.FRM:SSCmdGrava_Dep_Click` (caminho Edit)
  - Critério de pronto: Dependente selecionado editado, nome atualizado na lista
  - Confiança: 🟢 CONFIRMADO

- [ ] T-14, Implementar listagem de dependentes do cliente atual
  - Origem no legado: `CLIENTE.FRM:LstNom_Dep`
  - Critério de pronto: ListBox de dependentes populado via QueryDef `Cs_Dependente` ao carregar cliente
  - Confiança: 🟢 CONFIRMADO

- [ ] T-15, Implementar limpeza de campos (limpacampos1/limpacampos2)
  - Origem no legado: `CLIENTE.FRM:limpacampos1()`, `CLIENTE.FRM:limpacampos2()`
  - Critério de pronto: Todos os campos do formulário limpos ao incluir novo ou cancelar operação
  - Confiança: 🟢 CONFIRMADO

- [ ] T-16, Implementar tratamento de erro genérico
  - Origem no legado: `CLIENTE.FRM:ErrorHandler`
  - Critério de pronto: Erros não tratados exibem mensagem com número do erro
  - Confiança: 🟢 CONFIRMADO

---

## Tarefas de Teste

- [ ] TT-01, Testar inclusão de novo cliente com todos os campos obrigatórios
  - Critério de pronto: Cliente cadastrado com código sequencial, dados persistidos
  - Confiança: 🟢 CONFIRMADO

- [ ] TT-02, Testar validação de campos obrigatórios
  - Critério de pronto: Sistema impede gravação e exibe erro se campo obrigatório vazio
  - Confiança: 🟢 CONFIRMADO

- [ ] TT-03, Testar edição de cliente existente
  - Critério de pronto: Alterações persistidas sem criar novo registro
  - Confiança: 🟢 CONFIRMADO

- [ ] TT-04, Testar pesquisa de cliente por nome (substring e case-insensitive)
  - Critérito de pronto: Pesquisa encontra cliente independente de maiúsculas/minúsculas e como substring
  - Confiança: 🟢 CONFIRMADO

- [ ] TT-05, Testar exclusão de cliente com dependentes
  - Critério de pronto: Exclusão bloqueada, mensagem de integridade referencial exibida
  - Confiança: 🟢 CONFIRMADO

- [ ] TT-06, Testar cancelamento de cliente
  - Critério de pronto: Flag `cancelado` marcada, cliente não aparece em operações de locação
  - Confiança: 🟢 CONFIRMADO

- [ ] TT-07, Testar cadastro de dependente
  - Critério de pronto: Dependente vinculado ao cliente, aparece na lista
  - Confiança: 🟢 CONFIRMADO

- [ ] TT-08, Testar edição de dependente
  - Critério de pronto: Nome atualizado, duplicata não criada
  - Confiança: 🟢 CONFIRMADO

---

## Tarefas de Migração de Dados

- [ ] TM-01, Migrar tabela `Cliente` com todos os campos
  - Origem no legado: Tabela `Cliente` em BD_CDLOC.mdb
  - Critério de pronto: Todos os registros migrados, estrutura preservada
  - Confiança: 🟢 CONFIRMADO

- [ ] TM-02, Migrar tabela `dependente`
  - Origem no legado: Tabela `dependente` em BD_CDLOC.mdb
  - Critério de pronto: Todos os dependentes migrados, vínculos com cliente mantidos
  - Confiança: 🟢 CONFIRMADO

- [ ] TM-03, Migrar tabela `Bairro`
  - Origem no legado: Tabela `Bairro` em BD_CDLOC.mdb
  - Critérito de pronto: Todos os bairros migrados, ordem alfabética mantida
  - Confiança: 🟢 CONFIRMADO

- [ ] TM-04, Migrar QueryDef `Cs_Clientes`
  - Origem no legado: QueryDef em BD_CDLOC.mdb
  - Critério de pronto: Consulta parametrizada configurada com JOIN em Bairro
  - Confiança: 🟢 CONFIRMADO

- [ ] TM-05, Migrar QueryDef `Cs_Dependente`
  - Origem no legado: QueryDef em BD_CDLOC.mdb
  - Critério de pronto: Consulta parametrizada configurada para filtrar por `cod_cliente`
  - Confiança: 🟢 CONFIRMADO

---

## Ordem Sugerida

1. **Infraestrutura:** T-01 (formulário), T-03 (geracod), T-16 (tratamento de erro)
2. **Migração de dados:** TM-01, TM-02, TM-03, TM-04, TM-05
3. **CRUD Clientes:** T-02 (validação), T-04 (incluir), T-05 (editar), T-06 (pesquisar), T-07 (carregar), T-08 (excluir), T-09 (cancelar), T-10 (bairro), T-15 (limpar)
4. **CRUD Dependentes:** T-11 (seção), T-12 (cadastrar), T-13 (editar), T-14 (listar)
5. **Testes:** TT-01 a TT-08

**Bloqueios:**
- T-04 a T-10 dependem de TM-01 (tabela Cliente migrada)
- T-12 a T-14 dependem de TM-02 (tabela dependente migrada)
- T-10 depende de TM-03 (tabela Bairro migrada)
- T-07 depende de TM-04 (QueryDef Cs_Clientes)
- T-14 depende de TM-05 (QueryDef Cs_Dependente)

---

## Lacunas Pendentes (🔴)

- 🔴 **Comportamento de exclusão de cliente com locações pendentes:** Não confirmado no código - deve falhar com erro 3200 mas precisa validação
- 🔴 **Lógica para impedir cadastro de dependente em cliente cancelado:** Não encontrada no código - requer decisão de implementação
- 🔴 **Validação de CPF:** Não implementada no legado - definir se deve ser implementada na nova versão
- 🔴 **Auto-preenchimento de data de inscrição:** Campo `data-inscricao` não é preenchido automaticamente no legado - definir comportamento
