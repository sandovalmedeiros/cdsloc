# Cadastro de Clientes, Design Técnico

> Design técnico da feature de cadastro de clientes do sistema CDsLoc
> Gerado pelo Reversa em 2026-05-08

---

## Interface

### Formulário Principal (CLIENTE.FRM)

O formulário de clientes é uma janela MDI child com os seguintes componentes:

| Componente | Tipo | Descrição | Confiança |
|------------|------|-----------|-----------|
| `TxtCod_Cli` | TextBox | Código do cliente (somente leitura, formatado 0000) | 🟢 |
| `TxtNom_Cli` | TextBox | Nome do cliente (com pesquisa via F10) | 🟢 |
| `TxtEnd_Cli` | TextBox | Endereço do cliente | 🟢 |
| `MskDta_Nasc` | MaskedTextBox | Data de nascimento (formato dd/mm/yyyy) | 🟢 |
| `dbcBairro` | DBCombo | Combo vinculado à tabela Bairro | 🟢 |
| `txtMunicCli` | TextBox | Nome do município (somente leitura, preenchido via lookup) | 🟢 |
| `MskCep_Cli` | MaskedTextBox | CEP (formato #####-###) | 🟢 |
| `MskTel1_Cli` | MaskedTextBox | Telefone residencial (formato ####-####) | 🟢 |
| `txtRamalRes` | TextBox | Ramal residencial | 🟢 |
| `MskTel2_Cli` | MaskedTextBox | Telefone comercial (formato ####-####) | 🟢 |
| `txtRamalTrab` | TextBox | Ramal do trabalho | 🟢 |
| `MskTel3_Cli` | MaskedTextBox | Telefone de referência (formato ####-####) | 🟢 |
| `TxtIdent_Cli` | TextBox | Identidade/RG | 🟢 |
| `TxtExp_Cli` | TextBox | Órgão expedidor | 🟢 |
| `MskDta_Exp` | MaskedTextBox | Data de expedição | 🟢 |
| `MskCpf_Cli` | MaskedTextBox | CPF (formato ###.###.###-##) | 🟢 |
| `TxtEmp_Cli` | TextBox | Empresa onde trabalha | 🟢 |
| `TxtEndEmp_Cli` | TextBox | Endereço comercial | 🟢 |
| `TxtRef_Cli` | TextBox | Referência pessoal | 🟢 |
| `MskDta_Cad` | MaskedTextBox | Data de inscrição | 🟢 |
| `TxtObs_Cli` | TextBox | Observações | 🟢 |
| `OptAtivo_Cli` | OptionButton | Cliente ativo | 🟢 |
| `OptCanc_Cli` | OptionButton | Cliente cancelado | 🟢 |
| `LstNom_Cli` | ListBox | Lista de resultados de pesquisa | 🟢 |
| `SSCmdGrava_Cli` | CommandButton | Gravar cliente | 🟢 |
| `SSCmdExc_Cli` | CommandButton | Excluir cliente | 🟢 |
| `SSCmdCons_Cli` | CommandButton | Consultar dependentes | 🟢 |

### Aba de Dependentes

| Componente | Tipo | Descrição | Confiança |
|------------|------|-----------|-----------|
| `TxtCodCli_Dep` | TextBox | Código do cliente titular (somente leitura) | 🟢 |
| `TxtNom_Dep` | TextBox | Nome do dependente | 🟢 |
| `LstNom_Dep` | ListBox | Lista de dependentes cadastrados | 🟢 |
| `SSCmdGrava_Dep` | CommandButton | Gravar dependente | 🟢 |

---

## Fluxo Principal

### 1. Inicialização do Formulário (Form_Load)

1. Define posição do formulário na tela
2. Define `vformu = Clientes` para uso em funções globais
3. Define `msgI = "Inclusão"` (modo padrão)
4. Configura recordset global `wclien` para tabela Cliente
5. Define índice primary e campo de contagem
6. Gera código via `geracod()` e formata como 0000
7. Monta SQL para carregar bairros: `SELECT cdbairro, debairro FROM bairro ORDER BY debairro`
8. Configura DataControl `dtaBairro` e executa Refresh

### 2. Gravação de Cliente (SSCmdGrava_Cli_Click)

1. **Validação de campos obrigatórios:**
   - Código não vazio
   - Nome não vazio
   - Endereço não vazio
   - Data de nascimento válida (`IsDate()`)
   - Bairro selecionado (`cdBairro ≠ 0`)
   - Identidade não vazia

2. Se algum campo inválido: exibe MsgBox e seta foco no campo

3. **Confirmação:** MsgBox "Confirme a " + msgI + " Inclusão/Atualização"

4. Se resposta = Não: cancela operação e limpa campos

5. **Persistência:**
   - Se `Atualiza = Sim`: `DSCliente.Edit`
   - Se não: `DSCliente.AddNew`

6. Popula campos do recordset:
   - `codcliente = Format(TxtCod_Cli, "0000")`
   - `nomecliente = TxtNom_Cli`
   - `endereco = TxtEnd_Cli`
   - `data-nascimento = MskDta_Nasc` (se não vazio)
   - `cdbairro = cdbairro`
   - `cep = MskCep_Cli`
   - `fone-01 = MskTel1_Cli`
   - `ramal_res = txtRamalRes`
   - `fone-02 = MskTel2_Cli`
   - `ramal_trab = txtRamalTrab`
   - `fone-03 = MskTel3_Cli`
   - `identidade = TxtIdent_Cli`
   - `expedidor = TxtExp_Cli`
   - `data-expedicao = MskDta_Exp` (se não vazio)
   - `cic = MskCpf_Cli`
   - `empresa = TxtEmp_Cli`
   - `end-comercial = TxtEndEmp_Cli`
   - `referencia-pessoal = TxtRef_Cli`
   - `data-inscricao = MskDta_Cad` (se não vazio)
   - `obs = TxtObs_Cli`
   - `cancelado = NOT OptAtivo_Cli`

7. Executa `DSCliente.Update`

8. Requery e MoveFirst

### 3. Pesquisa de Cliente (F10 em TxtNom_Cli)

1. Exibe InputBox: "Digite o Nome/Sobrenome"

2. Se vazio: cancela e volta

3. Limpa lista de resultados (`LstNom_Cli.Clear`)

4. Percorre recordset `wclien`:
   - `pesquisa = InStr(UCase(wclien.nomecliente), UCase(Pesq_Nome))`
   - `pesquisa2 = InStr(wclien.nomecliente, Pesq_Nome)`
   - Se qualquer um ≠ 0: adiciona `nomecliente` à lista

5. MoveNext até EOF

### 4. Exclusão de Cliente (SSCmdExc_Cli_Click)

1. Confirmação: MsgBox "Deseja realmente Excluir?"

2. Se não: cancela

3. Se recordset vazio: erro "Não existe registro para EXCLUIR"

4. Usa índice primary e Seek para localizar cliente

5. Se NoMatch: erro "SELECIONE registro para EXCLUIR"

6. Executa `wclien.Delete`

7. Limpa campos e gera novo código

8. **Tratamento de erro 3200:** Violação de integridade referencial
   - Mensagem: "Você não pode EXCLUIR este registro - Integridade Referencial"
   - Isso ocorre quando cliente tem dependentes ou locações

### 5. Gravação de Dependente (SSCmdGrava_Dep_Click)

1. Valida: `TxtNom_Dep` não vazio

2. Confirmação: "Confirma a Inclusão/Alteração do Dependente?"

3. Se não: cancela

4. **Persistência:**
   - Se `mensagem = ""`: `Wdependente.AddNew`
   - Se `mensagem = "Alterar"`: `Wdependente.Edit`

5. Atualiza ListBox de dependentes (remove nome anterior se existente)

6. Popula recordset:
   - `cod_cliente = TxtCodCli_Dep`
   - `nome_dependente = TxtNom_Dep`

7. Executa `Wdependente.Update`

8. Limpa campo de nome

---

## Fluxos Alternativos

### Edição de Cliente Existente

1. Usuário seleciona cliente da lista de pesquisa ou insere código existente

2. Evento `TxtCod_Cli_LostFocus` chama `Dados_Cliente2()`

3. Carrega dados via QueryDef `Cs_Clientes` com parâmetro `cdcliente`

4. `msgI = "Atualização"` e `Atualiza = Sim`

5. Popula todos os campos do formulário

6. Define opção Ativo/Cancelado com base em campo `cancelado`

7. Habilita botão de consulta de dependentes se cliente ativo

### Edição de Dependente

1. Usuário clica em item da lista `LstNom_Dep`

2. Carrega nome no campo `TxtNom_Dep`

3. Define `mensagem = "Alterar"`

4. Ao gravar, usa `.Edit` em vez de `.AddNew`

---

## Dependências

| Dependência | Motivo | Como Usa |
|-------------|--------|----------|
| **DECLARA.BAS** | Funções globais utilitárias | `geracod()`, `LimpaCampos()`, `trata_errobd()` |
| **Tabela Bairro** | Lista de bairros disponíveis | DBCombo `dbcBairro` populada via SQL |
| **Tabela Cliente** | Persistência de clientes | Recordset global `wclien` |
| **Tabela dependente** | Persistência de dependentes | Recordset global `Wdependente` |
| **QueryDef Cs_Clientes** | Consulta parametrizada | Carrega cliente com informações de bairro/município |
| **QueryDef Cs_Dependente** | Consulta de dependentes | Carrega dependentes de um cliente específico |

---

## Decisões de Design Identificadas

| Decisão | Evidência no código | Confiança |
|---------|---------------------|-----------|
| **Soft-delete em vez de hard-delete** | Flag `cancelado` em vez de exclusão física | 🟢 CONFIRMADO |
| **Pesquisa case-insensitive via duplo InStr** | `InStr(UCase(...))` e `InStr(...)` | 🟢 CONFIRMADO |
| **Código sequencial gerado em memória** | Função `geracod()` usa MoveLast | 🟢 CONFIRMADO |
| **Validação de integridade referencial no banco** | Tratamento de erro 3200 | 🟢 CONFIRMADO |
| **Bairro vinculado via DBCombo** | Uso de DataControl para tabela Bairro | 🟢 CONFIRMADO |
| **Nome anterior do dependente armazenado para edição** | Variável `nome_anterior` | 🟢 CONFIRMADO |

---

## Estado Interno

### Variáveis Globais (DECLARA.BAS)

```vb
Public wbanco As Database        ' Conexão principal
Public wclien As Recordset       ' Tabela Cliente
Public Wdependente As Recordset  ' Tabela Dependente
```

### Variáveis Locais (CLIENTE.FRM)

| Variável | Tipo | Descrição | Escopo |
|----------|------|-----------|--------|
| `vformu` | Form | Referência ao formulário atual | Global (módulo) |
| `msgI` | String | "Inclusão" ou "Atualização" | Local |
| `Atualiza` | Boolean | Indica se está em modo de edição | Local |
| `pesq_cli` | String | Flag para pesquisa de cliente | Local |
| `pesq_dep` | String | Flag para pesquisa de dependente | Local |
| `mensagem` | String | "Incluir" ou "Alterar" | Local |
| `nome_anterior` | String | Nome anterior do dependente | Local |
| `cdBairro` | Integer | Código do bairro selecionado | Local |
| `cod_dependente` | String | Código do dependente selecionado | Local |
| `gravou` | Boolean | Indica se gravou com sucesso | Local |

### Estados do Formulário

| Estado | Descrição | Flags Setadas |
|--------|-----------|---------------|
| **Novo Cliente** | Formulário em modo de inclusão | `msgI = "Inclusão"`, `Atualiza = False` |
| **Edição de Cliente** | Carregou cliente existente | `msgI = "Atualização"`, `Atualiza = True` |
| **Cliente Cancelado** | Cliente marcado como cancelado | `OptCanc_Cli = True`, botão consulta desabilitado |
| **Cliente Ativo** | Cliente com `cancelado = False` | `OptAtivo_Cli = True`, botão consulta habilitado |

---

## Observabilidade

### Tratamento de Erros

O sistema usa `On Error GoTo ErrorHandler` com tratamento específico:

| Erro | Descrição | Ação |
|------|-----------|------|
| 3200 | Violação de integridade referencial | Mensagem específica sobre exclusão bloqueada |
| Outros | Erro genérico | "Ocorreu Erro No. [número] - ligue p/Sandoval" |

### Mensagens ao Usuário

| Situação | Mensagem |
|----------|----------|
| Campo obrigatório vazio | "[Campo] não pode ficar em branco" |
| Confirmação de gravação | "Confirme a Inclusão/Atualização" |
| Operação cancelada | "Operação Cancelada" |
| Confirmação de exclusão | "Deseja realmente Excluir?" |
| Sem registro para excluir | "Não existe registro para EXCLUIR" |
| Selecionar registro para excluir | "SELECIONE registro para EXCLUIR" |
| Integridade referencial | "Você não pode EXCLUIR este registro - Integridade Referencial" |
| Nome de dependente vazio | "Nome do Dependente não pode ficar vazio" |
| Confirmação de dependente | "Confirma a Inclusão/Alteração do Dependente?" |

---

## Riscos e Lacunas

- 🔴 **Código sequencial gerado em memória:** Em ambiente multiusuário, pode causar colisões se dois usuários gerarem código ao mesmo tempo
- 🟡 **Sem validação de CPF:** CPF não é validado, apenas formatado
- 🟡 **Data de inscrição não preenchida automaticamente:** Campo `data-inscricao` pode ficar vazio
- 🔴 **Exclusão de cliente com locações pendentes:** Comportamento não confirmado no código (deve falhar com erro 3200)
- 🔴 **Impedir cadastro de dependente em cliente cancelado:** Lógica não explicitamente encontrada no código
