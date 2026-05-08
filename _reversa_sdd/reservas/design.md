# Reservas, Design Técnico

> Design técnico da feature de reservas do sistema CDsLoc
> Gerado pelo Reversa em 2026-05-08

---

## Interface

### Formulário Principal (reservcd.frm)

| Componente | Tipo | Descrição | Confiança |
|------------|------|-----------|-----------|
| `TxtCod_Cli` | TextBox | Código do cliente (somente leitura após seleção) | 🟢 |
| `TxtNom_Cli` | TextBox | Nome do cliente | 🟢 |
| `BtnPesq_Cli` | CommandButton | Botão de pesquisa de cliente | 🟢 |
| `TxtCod_Tit` | TextBox | Código do título (somente leitura após seleção) | 🟢 |
| `TxtNom_Tit` | TextBox | Nome do título | 🟢 |
| `BtnPesq_Tit` | CommandButton | Botão de pesquisa de título | 🟢 |
| `TxtQtd_Disponivel` | TextBox | Quantidade de CDs disponíveis do título | 🟡 INFERIDO |
| `DtaData_Reserva` | MaskedTextBox | Data da reserva | 🟢 |
| `TxtData_Prevista` | TextBox | Data prevista para retirada | 🟡 INFERIDO |
| `LstReservas` | ListBox | Lista de reservas do cliente atual | 🟢 |
| `SSCmdGrava_Res` | CommandButton | Gravar reserva | 🟢 |
| `SSCmdExc_Res` | CommandButton | Excluir reserva selecionada | 🟢 |
| `SSCmdLimpa` | CommandButton | Limpar campos | 🟢 |

---

## Fluxo Principal

### 1. Pesquisar Cliente (pesquisa_cliente)

1. Usuário clica em botão de pesquisa de cliente

2. Sistema exibe InputBox ou modal para busca

3. Usuário informa código ou nome do cliente

4. Sistema busca na tabela Cliente:
   - Se código: busca exata via índice primarykey
   - Se nome: busca substring case-insensitive

5. Se encontrado:
   - Popula campos do cliente (`TxtCod_Cli`, `TxtNom_Cli`)
   - Verifica se cliente está ativo (`cancelado = False`)
   - Se cancelado: exibe erro e impede reserva
   - Carrega reservas existentes na ListBox `LstReservas`

6. Se não encontrado: exibe mensagem de erro

### 2. Pesquisar Título (pesquisa_titulo)

1. Usuário clica em botão de pesquisa de título

2. Sistema exibe lista de títulos disponíveis

3. Usuário seleciona título

4. Sistema:
   - Popula campos do título (`TxtCod_Tit`, `TxtNom_Tit`)
   - Verifica disponibilidade de CDs:
     - SQL: `SELECT COUNT(*) FROM cd WHERE codtitulo = ? AND situacao = "Disponível"`
   - Exibe quantidade disponível em `TxtQtd_Disponivel`

### 3. Gravar Reserva (SSCmdGrava_Res_Click)

1. **Validação de campos obrigatórios:**
   - Cliente selecionado
   - Título selecionado
   - Data de reserva informada

2. Se algum campo inválido: exibe MsgBox e seta foco

3. **Confirmação:** MsgBox "Confirma a Reserva?"

4. Se não: cancela operação

5. **Persistência:**

   a. Cria registro na tabela `reserva`:
      - `codreserva = geracod()`
      - `codcliente = código do cliente`
      - `codtitulo = código do título`
      - `data_reserva = Now()` (ou data informada)
      - `data_prevista = ` (opcional, pode ser calculado ou informado)
      - `situacao = "Pendente"`

6. Adiciona reserva à ListBox `LstReservas`

7. Limpa campos do título (mantém cliente)

8. Exibe mensagem de sucesso

### 4. Excluir Reserva (SSCmdExc_Res_Click)

1. **Validação:**
   - Reserva selecionada na ListBox `LstReservas`

2. Se nenhuma selecionada: exibe erro

3. **Confirmação:** MsgBox "Deseja realmente Excluir esta Reserva?"

4. Se não: cancela

5. **Exclusão:**

   a. Localiza reserva na tabela `reserva`:
      - Usa índice para buscar por `codreserva`

   b. Executa `Wreserva.Delete`

6. Remove reserva da ListBox `LstReservas`

7. Exibe mensagem de sucesso

### 5. Listar Reservas do Cliente

1. Quando cliente é selecionado:

   a. Sistema busca reservas do cliente:
      - SQL: `SELECT reserva.*, titulo.nometitulo FROM reserva INNER JOIN titulo ON reserva.codtitulo = titulo.codtitulo WHERE reserva.codcliente = ? AND reserva.situacao = "Pendente"`

   b. Limpa ListBox `LstReservas`

   c. Para cada reserva encontrada:
      - Adiciona à ListBox: `data_reserva - nometitulo`

2. Usuário pode selecionar reserva para exibir detalhes ou excluir

### 6. Converter Reserva em Locação

1. Usuário acessa formulário de locação

2. Seleciona cliente que possui reservas

3. Sistema verifica reservas do cliente

4. Usuário clica em botão de consulta de reservas

5. Sistema exibe lista de reservas

6. Usuário seleciona reserva para converter

7. Sistema:
   - Popula campos do título da reserva
   - Verifica disponibilidade de CDs do título
   - Se disponível: segue fluxo normal de locação
   - Se não disponível: exibe aviso e sugere outra reserva

8. Ao confirmar locação:
   - Sistema atualiza situação da reserva para `"Confirmada"` ou `"Locada"`
   - Ou exclui reserva e cria locação

---

## Fluxos Alternativos

### Cancelamento de Reserva (Exclusão)

1. Usuário seleciona reserva na ListBox

2. Clica em botão de exclusão

3. Sistema pede confirmação

4. Se confirmado:
   - Remove registro da tabela `reserva`
   - Remove da ListBox

### Tentativa de Reservar com Cliente Cancelado

1. Usuário seleciona cliente com `cancelado = True`

2. Sistema detecta flag

3. Exibe mensagem: "Cliente está CANCELADO"

4. Impede continuação da reserva

### Limpar Campos

1. Usuário clica em botão de limpar

2. Sistema:
   - Limpa campos de título
   - Limpa data de reserva
   - Não limpa cliente (mantém seleção)

---

## Dependências

| Dependência | Motivo | Como Usa |
|-------------|--------|----------|
| **DECLARA.BAS** | Funções globais utilitárias | `geracod()`, `LimpaCampos()` |
| **Tabela Cliente** | Dados do cliente | Verifica se está ativo, busca reservas |
| **Tabela titulo** | Lista de títulos disponíveis | Verifica disponibilidade de CDs |
| **Tabela cd** | Verificação de estoque | Conta CDs disponíveis por título |
| **Tabela reserva** | Persistência de reservas | Cria, exclui e lista reservas |

---

## Decisões de Design Identificadas

| Decisão | Evidência no código | Confiança |
|---------|---------------------|-----------|
| **Reserva por título, não por CD** | Tabela reserva vincula a titulo, não a cd | 🟢 CONFIRMADO |
| **Sem garantia de disponibilidade** | Documentado nas regras de negócio | 🟢 CONFIRMADO |
| **Duplicidade permitida** | Documentado nas regras de negócio | 🟢 CONFIRMADO |
| **Situacao = "Pendente" para novas reservas** | Documentado na tabela reserva | 🟢 CONFIRMADO |

---

## Estado Interno

### Variáveis Globais

```vb
Public Wreserva As Recordset   ' Tabela Reserva
```

### Variáveis Locais (reservcd.frm)

| Variável | Tipo | Descrição | Escopo |
|----------|------|-----------|--------|
| `cod_cliente_selec` | Long | Código do cliente selecionado | Local |
| `cod_titulo_selec` | Long | Código do título selecionado | Local |
| `cod_reserva_selec` | Long | Código da reserva selecionada | Local |
| `lista_reservas` | Collection/Array | Lista de reservas do cliente | Local |

### Estados do Formulário

| Estado | Descrição | Flags/Ações |
|--------|-----------|-------------|
| **Início** | Formulário limpo, aguardando cliente | Campos vazios |
| **Cliente Selecionado** | Cliente carregado, reservas listadas | Reservas do cliente exibidas |
| **Título Selecionado** | Título selecionado para reserva | Disponibilidade verificada |
| **Reserva Pendente** | Reserva criada, aguardando conversão | Situação = "Pendente" |
| **Reserva Confirmada/Locada** | Reserva convertida em locação | Situação atualizada |

---

## Observabilidade

### Mensagens ao Usuário

| Situação | Mensagem |
|----------|----------|
| Cliente não encontrado | "Cliente não encontrado" |
| Cliente cancelado | "Cliente está CANCELADO" |
| Título não encontrado | "Título não encontrado" |
| Confirmação de reserva | "Confirma a Reserva?" |
| Reserva realizada com sucesso | "Reserva realizada com sucesso" |
| Confirmação de exclusão | "Deseja realmente Excluir esta Reserva?" |
| Reserva excluída com sucesso | "Reserva excluída com sucesso" |
| Nenhum título disponível | "Não há CDs disponíveis para este título" |
| Reserva convertida em locação | "Reserva convertida em locação" |

---

## Riscos e Lacunas

- 🔴 **Atualização de situação da reserva ao converter em locação:** Não confirmado no código - deve ser atualizada para "Confirmada" ou "Locada"
- 🔴 **Verificação de disponibilidade de CDs ao reservar:** Lógica não confirmada no código - se há ou não verificação
- 🔴 **Múltiplas reservas simultâneas:** Comportamento não confirmado se há alerta ao reservar título já reservado pelo mesmo cliente
- 🟡 **Data prevista:** Campo existe na tabela mas uso não confirmado - pode ser informado manualmente ou calculado automaticamente
- 🔴 **Exclusão de reservas convertidas em locação:** Comportamento não confirmado - se reservas confirmadas podem ser excluídas
