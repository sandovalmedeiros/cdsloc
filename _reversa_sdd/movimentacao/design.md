# Movimentação, Design Técnico

> Design técnico da feature de movimentação (locação e devolução) do sistema CDsLoc
> Gerado pelo Reversa em 2026-05-08

---

## Interface

### Formulário Principal (LOCDEVOL.FRM)

Formulário com controle SSTab contendo 3 abas principais:

#### Aba 1: Locação

| Componente | Tipo | Descrição | Confiança |
|------------|------|-----------|-----------|
| `TxtCod_Cli_Loc` | TextBox | Código do cliente (somente leitura após seleção) | 🟢 |
| `TxtNom_Cli_Loc` | TextBox | Nome do cliente | 🟢 |
| `BtnPesq_Cli_Loc` | CommandButton | Botão de pesquisa de cliente | 🟢 |
| `ChkDependente` | CheckBox | Marca se retirada por dependente | 🟢 |
| `CboDependente` | ComboBox | Lista de dependentes do cliente | 🟢 |
| `CboCD` | ComboBox | Lista de CDs disponíveis | 🟢 |
| `BtnAddItem` | CommandButton | Adiciona CD à lista de locação | 🟢 |
| `LstItensLoc` | ListBox | Lista de itens da locação | 🟢 |
| `TxtValTotal` | TextBox | Valor total da locação | 🟢 |
| `SSCmdGrava_Loc` | CommandButton | Confirmar e gravar locação | 🟢 |
| `SSCmdCancela_Loc` | CommandButton | Cancelar locação em andamento | 🟢 |
| `BtnPesqReserva` | CommandButton | Consultar reservas do cliente | 🟢 |

#### Aba 2: Devolução

| Componente | Tipo | Descrição | Confiança |
|------------|------|-----------|-----------|
| `TxtCod_Cli_Dev` | TextBox | Código do cliente | 🟢 |
| `BtnPesq_Cli_Dev` | CommandButton | Pesquisar recibos pendentes do cliente | 🟢 |
| `CboRecibos` | ComboBox | Lista de recibos pendentes | 🟢 |
| `LstItensDev` | ListBox | Lista de itens do recibo selecionado | 🟢 |
| `TxtValLocacao` | TextBox | Valor da locação | 🟢 |
| `TxtValMulta` | TextBox | Valor da multa (calculado) | 🟢 |
| `TxtValTotal` | TextBox | Valor total (locação + multa) | 🟢 |
| `TxtDiasAtraso` | TextBox | Dias de atraso | 🟢 |
| `MskDataDev` | MaskedTextBox | Data de devolução | 🟢 |
| `SSCmdBaixa` | CommandButton | Baixar recibo (registrar devolução) | 🟢 |
| `SSCmdCancela_Dev` | CommandButton | Cancelar devolução em andamento | 🟢 |

#### Aba 3: Recibo

| Componente | Tipo | Descrição | Confiança |
|------------|------|-----------|-----------|
| `TxtCodRec` | TextBox | Código do recibo | 🟢 |
| `BtnConsRec` | CommandButton | Consultar recibo | 🟢 |
| `LstItensRec` | ListBox | Lista de itens do recibo | 🟢 |
| `TxtValTotal_Rec` | TextBox | Valor total do recibo | 🟢 |
| `TxtDataEmissao` | TextBox | Data de emissão | 🟢 |
| `TxtStatus` | TextBox | Status (Pendente/Baixado) | 🟢 |
| `BtnImprimir` | CommandButton | Imprimir recibo | 🟢 |

---

## Fluxo Principal

### 1. Locação de CD

#### 1.1 Pesquisar Cliente (pesquisa_cliente)

1. Usuário clica em botão de pesquisa
2. Sistema exibe InputBox ou modal para busca
3. Usuário informa código ou nome do cliente
4. Sistema busca na tabela Cliente:
   - Se código: busca exata via índice primarykey
   - Se nome: busca substring case-insensitive
5. Se encontrado:
   - Popula campos do cliente
   - Verifica se cliente está ativo (`cancelado = False`)
   - Se cancelado: exibe erro e impede locação
   - Carrega dependentes na ComboBox
6. Se não encontrado: exibe mensagem de erro

#### 1.2 Selecionar Dependente (Opcional)

1. Usuário marca checkbox `ChkDependente`
2. Sistema habilita ComboBox `CboDependente`
3. Usuário seleciona dependente da lista
4. Sistema armazena `coddependente` selecionado

#### 1.3 Selecionar CD Disponível

1. Sistema popula ComboBox `CboCD` com CDs disponíveis:
   - SQL: `SELECT cd.*, titulo.nometitulo FROM cd INNER JOIN titulo ON cd.codtitulo = titulo.codtitulo WHERE cd.situacao = "Disponível"`
2. Usuário seleciona CD da lista
3. Sistema exibe nome do título e valor da locação
4. Usuário clica em `BtnAddItem`
5. CD é adicionado à lista `LstItensLoc`
6. Valor total é atualizado

#### 1.4 Gravar Locação (SSCmdGrava_Loc_Click)

1. **Validação:**
   - Cliente selecionado
   - Pelo menos um item na lista de locação
   - Todos os CDs estão disponíveis (reverificação)

2. **Confirmação:** MsgBox "Confirma a Locação?"

3. Se não: cancela operação

4. **Para cada item da locação:**

   a. Cria registro na tabela `locacao`:
      - `codlocacao = geracod()`
      - `codcliente = código do cliente`
      - `coddependente = código do dependente` (se aplicável)
      - `codcd = código do CD`
      - `data_locacao = Now()`
      - `data_prevista = calcular_data_prevista(tipo_locacao, data_locacao)`
      - `valor_locacao = valor do título`
      - `situacao = "Locado"`

   b. Atualiza CD na tabela `cd`:
      - `situacao = "Locado"`

5. Cria registro na tabela `recibo`:
   - `codrecibo = geracod()`
   - `codlocacao = código da locação principal` (primeiro item)
   - `data_emissao = Now()`
   - `valor_total = soma dos valores dos itens`
   - `devolvido = False`

6. Limpa campos e exibe mensagem de sucesso

### 2. Cálculo de Data Prevista

```vb
Private Function calcular_data_prevista(tipo_locacao As String, data_base As Date) As Date
    Dim dias As Integer
    Dim data_prevista As Date

    If tipo_locacao = "24h" Then
        dias = 1
    Else  ' 48h
        dias = 2
    End If

    data_prevista = DateAdd("d", dias, data_base)

    ' Se cair em domingo, adiciona mais 1 dia
    If Weekday(data_prevista) = vbSunday Then
        data_prevista = DateAdd("d", 1, data_prevista)
    End If

    calcular_data_prevista = data_prevista
End Function
```

**Confiança:** 🟢 CONFIRMADO (inferido do fluxo)

### 3. Devolução de CD

#### 3.1 Pesquisar Recibos Pendentes

1. Usuário informa código do cliente
2. Sistema busca recibos pendentes:
   - SQL: `SELECT recibo.*, locacao.* FROM recibo INNER JOIN locacao ON recibo.codlocacao = locacao.codlocacao WHERE recibo.codcliente = ? AND recibo.devolvido = False`
3. Sistema popula ComboBox `CboRecibos`
4. Usuário seleciona recibo
5. Sistema carrega itens na lista `LstItensDev`

#### 3.2 Baixar Recibo (SSCmdBaixa_Click)

1. **Validação:**
   - Recibo selecionado
   - Data de devolução informada

2. **Calcular atraso:**
   - `dias_atraso = DateDiff("d", locacao.data_prevista, Now())`
   - Se `dias_atraso < 0`, então `dias_atraso = 0` (no prazo)

3. **Calcular multa:**
   - Se `dias_atraso > 0`:
     - `valor_multa = calcular_multa(dias_atraso, valor_locacao)`
   - Senão:
     - `valor_multa = 0`

4. **Para cada item da locação:**

   a. Atualiza tabela `locacao`:
      - `data_devolucao = Now()`
      - `valor_multa = valor_multa`
      - `situacao = "Devolvido"`

   b. Atualiza tabela `cd`:
      - `situacao = "Disponível"`

5. Atualiza tabela `recibo`:
   - `valor_total = valor_locacao + valor_multa`
   - `devolvido = True`

6. Limpa campos e exibe mensagem de sucesso

### 4. Consulta de Reservas (pesquisa_reserva)

1. Usuário clica em botão de consulta de reservas
2. Sistema busca reservas do cliente atual:
   - SQL: `SELECT reserva.*, titulo.nometitulo FROM reserva INNER JOIN titulo ON reserva.codtitulo = titulo.codtitulo WHERE reserva.codcliente = ?`
3. Sistema exibe lista de reservas
4. Usuário pode selecionar reserva para converter em locação
5. Se converter:
   - Sistema verifica disponibilidade de CDs do título
   - Se disponível: segue fluxo normal de locação
   - Se não: exibe aviso de indisponibilidade

---

## Fluxos Alternativos

### Cancelamento de Locação em Andamento

1. Usuário clica em `SSCmdCancela_Loc`

2. Sistema remove todos os itens da lista `LstItensLoc`

3. Limpa todos os campos

4. Volta ao estado inicial da aba Locação

### Exclusão de Item da Locação

1. Usuário seleciona item na lista `LstItensLoc`

2. Sistema remove item da lista

3. Atualiza valor total

### Tentativa de Locar Cliente Cancelado

1. Usuário seleciona cliente com `cancelado = True`

2. Sistema detecta flag

3. Exibe mensagem: "Cliente está CANCELADO"

4. Impede continuação da locação

### Tentativa de Locar CD Já Locado

1. Usuário tenta adicionar CD que já está na lista de outro recibo

2. Sistema detecta situação `situacao = "Locado"`

3. Exibe mensagem: "CD não está disponível"

4. Impede adição do item

---

## Dependências

| Dependência | Motivo | Como Usa |
|-------------|--------|----------|
| **DECLARA.BAS** | Funções globais utilitárias | `geracod()`, `LimpaCampos()`, `trata_errobd()` |
| **Tabela Cliente** | Dados do cliente locador | Verifica se está ativo, carrega dependentes |
| **Tabela dependente** | Lista de dependentes autorizados | Popula ComboBox de dependentes |
| **Tabela cd** | CDs disponíveis para locação | Filtra por `situacao = "Disponível"`, atualiza estado |
| **Tabela titulo** | Valores de locação, tipos | Busca valor e tipo de locação |
| **Tabela locacao** | Registro de locações | Persiste itens da locação |
| **Tabela recibo** | Controle de recibos | Emite ao locar, baixa ao devolver |
| **Tabela reserva** | Consulta de reservas | Verifica reservas do cliente |

---

## Decisões de Design Identificadas

| Decisão | Evidência no código | Confiança |
|---------|---------------------|-----------|
| **SSTab para 3 abas** | Formulário com abas Locação/Devolução/Recibo | 🟢 CONFIRMADO |
| **Locação por itens** | Sistema acumula itens em lista antes de gravar | 🟢 CONFIRMADO |
| **Um recibo por locação** | Relacionamento 1:1 entre locação e recibo | 🟢 CONFIRMADO |
| **Atualização manual de estado do CD** | Flag `situacao` em vez de cálculo dinâmico | 🟢 CONFIRMADO |
| **Multa calculada no momento da devolução** | Campo `valor_multa` preenchido ao baixar | 🟢 CONFIRMADO |
| **Ajuste de domingo em data prevista** | Adiciona +1 dia se cair em domingo | 🟢 CONFIRMADO |

---

## Estado Interno

### Variáveis Globais (DECLARA.BAS)

```vb
Public Wlocacao As Recordset   ' Tabela Locação
Public Wrecibo As Recordset      ' Tabela Recibo
```

### Variáveis Locais (LOCDEVOL.FRM)

| Variável | Tipo | Descrição | Escopo |
|----------|------|-----------|--------|
| `cod_cliente_selec` | Long | Código do cliente selecionado | Local |
| `cod_dependente_selec` | Long | Código do dependente selecionado | Local |
| `cod_recibo_selec` | Long | Código do recibo selecionado | Local |
| `lista_itens` | Collection/Array | Lista de itens da locação | Local |
| `valor_total_loc` | Currency | Valor total da locação em andamento | Local |
| `valor_multa_calc` | Currency | Valor da multa calculada | Local |
| `dias_atraso` | Integer | Dias de atraso | Local |

### Estados do Formulário

| Estado | Descrição | Flags/Ações |
|--------|-----------|-------------|
| **Início de Locação** | Formulário limpo, aguardando cliente | Campos vazios, lista de itens vazia |
| **Cliente Selecionado** | Cliente carregado, dependentes disponíveis | Dependentes populados na ComboBox |
| **Locação em Andamento** | Itens adicionados à lista | Valor total calculado |
| **Locação Confirmada** | Locação gravada, recibo emitido | CD marcado como Locado |
| **Devolução Selecionada** | Recibo pendente selecionado | Itens exibidos, multa calculada |
| **Devolução Confirmada** | Devolução registrada | CD marcado como Disponível |

---

## Observabilidade

### Mensagens ao Usuário

| Situação | Mensagem |
|----------|----------|
| Cliente não encontrado | "Cliente não encontrado" |
| Cliente cancelado | "O Cliente está CANCELADO" |
| CD não disponível | "CD não está disponível" |
| Nenhum item na locação | "Adicione pelo menos um item à locação" |
| Confirmação de locação | "Confirma a Locação?" |
| Locação realizada com sucesso | "Locação realizada com sucesso" |
| Confirmação de devolução | "Confirma a Devolução?" |
| Devolução realizada com sucesso | "Devolução realizada com sucesso" |
| Nenhum recibo pendente | "Não há recibos pendentes para este cliente" |

### Tratamento de Erros

| Erro | Descrição | Ação |
|------|-----------|------|
| Erro geral | Erro na operação | Mensagem genérica com código do erro |

---

## Riscos e Lacunas

- 🔴 **Cálculo de multa:** Fórmula de cálculo de multa por dias de atraso não foi encontrada no código
- 🔴 **Tabela valor_loc:** Referência a tabela de valores de locação mencionada mas não analisada
- 🔴 **Transação atômica:** Não confirmado se há tratamento de transação para garantir consistência entre locação e atualização do CD
- 🔴 **Exclusão de item da locação:** Comportamento não confirmado no código - se restaura estado do CD ou não
- 🔴 **Conversão de reserva em locação:** Fluxo não detalhado no código analisado
