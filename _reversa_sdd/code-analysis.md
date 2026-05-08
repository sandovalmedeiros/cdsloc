# Análise de Código — CDsLoc

> Gerado pelo Reversa em 2026-05-08
> Análise técnica do sistema de locação de CDs em Visual Basic 6.0

---

## Resumo Executivo

**Linguagem:** Visual Basic 6.0 (VB6)
**Paradigma:** Procedural com interface gráfica MDI
**Banco de Dados:** Microsoft Access via DAO 2.5
**Total de Módulos:** 9
**Total de Formulários:** 17
**Total de Módulos de Código:** 3

---

## Arquitetura Geral

O sistema segue uma arquitetura **cliente-servidor 2-tier** típica de aplicações VB6:

1. **Camada de Apresentação (Frontend):** Formulários VB6 (.frm) com controles ActiveX
2. **Camada de Acesso a Dados (Backend):** Acesso direto ao banco Access via DAO

Não há camada de negócio separada — a lógica de negócio está embutida nos formulários e módulos.

---

## Módulos de Código (Modules)

### DECLARA.BAS
Módulo global contendo declarações de variáveis e funções utilitárias usadas em todo o sistema.

**Variáveis Globais (Conexão com Banco):**
```vb
Public wbanco As Database                ' Conexão principal com o banco
Public wclien As Recordset               ' Tabela Cliente
Public Wdependente As Recordset          ' Tabela Dependente
Public Wcdfisico As Recordset            ' Tabela CD
Public Westilo As Recordset              ' Tabela Estilo
Public wMunic As Recordset               ' Tabela Município
Public wBairro As Recordset              ' Tabela Bairro
Public Wgrupo As Recordset               ' Tabela Grupo
Public Winterprete As Recordset          ' Tabela Intérprete
Public wtinterprete As Recordset         ' Tabela Título-Intérprete
Public Wlocacao As Recordset             ' Tabela Locação
Public wmusica As Recordset              ' Tabela Música
Public Wminterprete As Recordset         ' Tabela Música-Intérprete
Public Wrecibo As Recordset              ' Tabela Recibo
Public Wreserva As Recordset             ' Tabela Reserva
Public Wtitulo As Recordset              ' Tabela Título
Public Wtmusica As Recordset             ' Tabela Título-Música
Public tabsenha As Recordset             ' Tabela Senha
Public wvalor_loc As Recordset           ' Tabela Valor de Locação
```

**Funções Globais:**

| Função | Descrição | Parâmetros | Retorno | Confiança |
|--------|-----------|------------|---------|-----------|
| `geracod()` | Gera próximo código sequencial | Usa VTb, VIx, VCt globais | Long | 🟢 CONFIRMADO |
| `imprimir_recibo()` | Imprimir recibo | - | - | 🔴 LACUNA (vazio) |
| `limpacampos1()` | Limpa campos do formulário de cliente | - | - | 🟢 CONFIRMADO |
| `limpacampos2()` | Limpa campos do formulário de cliente (alternativo) | - | - | 🟢 CONFIRMADO |
| `SetaBanco()` | Inicializa conexão e abre recordsets | - | - | 🟢 CONFIRMADO |
| `trata_errobd()` | Tratamento de erro de banco de dados | - | - | 🟢 CONFIRMADO |
| `LimpaCampos()` | Limpa todos os controles do formulário | vformu (Form) | - | 🟢 CONFIRMADO |

**Algoritmo `geracod()`:**
```vb
Static Function geracod() As Long
    If VTb.RecordCount <> 0 Then
        VTb.Index = VIx
        VTb.MoveLast
        geracod = VTb(VCt).Value + 1
    Else
        geracod = 1
    End If
End Function
```
🟢 **CONFIRMADO** — Algoritmo simples de auto-incremento usando o último registro.

---

### ARQUIMSG.BAS
Módulo para exibição de mensagens externas formatadas.

**Função Principal:**

| Função | Descrição | Parâmetros | Retorno | Confiança |
|--------|-----------|------------|---------|-----------|
| `ARQUIMSG(NomeArq$, Secao%)` | Exibe mensagens de arquivo externo | Nome do arquivo, Seção | - | 🟢 CONFIRMADO |

**Algoritmo `ARQUIMSG()`:**
1. Abre arquivo de mensagens especificado
2. Localiza seção marcada com `>número`
3. Extrai tipo e título da mensagem
4. Exibe linhas da seção como MsgBox
5. Continua enquanto encontrar seções consecutivas

🟢 **CONFIRMADO** — Sistema de mensagens externalizadas em arquivo texto.

---

### CONSTANT.TXT (Module2)
Arquivo de constantes globais do VB6 (autogerado). Contém todas as constantes padrão do VB6 para:
- Teclas (KEY_*)
- Cores (BLACK, RED, etc.)
- Estilos de janela (NORMAL, MINIMIZED, etc.)
- Valores de retorno de MsgBox (IDOK, IDCANCEL, etc.)
- Controles de diálogo (COMDLG32)
- Constantes do Crystal Reports

🟢 **CONFIRMADO** — Arquivo padrão do VB6, não contém lógica de negócio.

---

## Módulos por Funcionalidade

### 1. Autenticação (SENHA.FRM)

**Objetivo:** Controlar acesso ao sistema através de senha.

**Tabela Relacionada:** `senha`

**Funções Principais:**

| Função | Descrição | Parâmetros | Retorno | Confiança |
|--------|-----------|------------|---------|-----------|
| `codigo(went)` | Codifica/decodifica senha usando XOR | String | String | 🟢 CONFIRMADO |

**Algoritmo de Criptografia (XOR):**
```vb
Private Function codigo(went)
    wsai = ""
    For i = 1 To Len(went)
       wsai = wsai & Chr(Asc(Mid(went, i, 1)) Xor 255)
    Next
    codigo = wsai
End Function
```
🟡 **INFERIDO** — Criptografia XOR simples com chave fixa 255 (fraca, reversível).

**Fluxo de Login:**
1. Usuário digita senha
2. Sistema verifica contra tabela `senha` usando `codigo()`
3. Se correta: verifica checkbox "Muda senha"
4. Se marcado: permite alteração da senha (confirmação dupla)
5. Máximo de 3 tentativas antes de encerrar

**Regras de Negócio:**
- Senha máxima: 10 caracteres
- 3 tentativas permitidas
- Alteração de senha requer confirmação idêntica

---

### 2. Cadastro de Clientes (cliente.frm)

**Objetivo:** Gerenciar cadastro de clientes e seus dependentes.

**Tabelas Relacionadas:** `Cliente`, `dependente`, `Bairro`

**Campos da Entidade Cliente:**

| Campo | Tipo | Obrigatório | Descrição | Confiança |
|-------|------|-------------|-----------|-----------|
| codcliente | Numeric | Sim | Código do cliente (PK) | 🟢 |
| nomecliente | Text | Sim | Nome completo | 🟢 |
| endereco | Text | Sim | Endereço residencial | 🟢 |
| data-nascimento | Date | Sim | Data de nascimento | 🟢 |
| cdbairro | Numeric | Sim | Código do bairro (FK) | 🟢 |
| cep | Text | Não | CEP | 🟢 |
| fone-01 | Text | Não | Telefone residencial | 🟢 |
| ramal_res | Text | Não | Ramal residencial | 🟢 |
| fone-02 | Text | Não | Telefone comercial | 🟢 |
| ramal_trab | Text | Não | Ramal trabalho | 🟢 |
| fone-03 | Text | Não | Telefone referencial | 🟢 |
| identidade | Text | Sim | RG | 🟢 |
| expedidor | Text | Não | Órgão expedidor | 🟢 |
| data-expedicao | Date | Não | Data de expedição | 🟢 |
| cic | Text | Não | CPF | 🟢 |
| empresa | Text | Não | Nome da empresa | 🟢 |
| end-comercial | Text | Não | Endereço comercial | 🟢 |
| referencia-pessoal | Text | Não | Referência pessoal | 🟢 |
| data-inscricao | Date | Não | Data de cadastro | 🟢 |
| cancelado | Boolean | Não | Cliente cancelado | 🟢 |
| obs | Text | Não | Observações | 🟢 |

**Funções Principais (Cliente):**

| Função | Descrição | Parâmetros | Retorno | Confiança |
|--------|-----------|------------|---------|-----------|
| `dados_cliente()` | Carrega dados do cliente para os campos | - | - | 🟢 |
| `Dados_Cliente2()` | Carrega dados usando QueryDef | - | - | 🟢 |
| `pesquisa_cliente()` | Pesquisa cliente por nome/parte do nome | - | - | 🟢 |
| `GeraCodigo()` | Gera novo código para cliente | - | - | 🟢 |
| `EncheGrid()` | Popula grid de dependentes | - | - | 🟢 |

**Fluxo de Gravação de Cliente:**
1. Valida campos obrigatórios (código, nome, endereço, data nasc, bairro, identidade)
2. Se inclusão: gera código via `geracod()`
3. Confirmação via MsgBox
4. Se atualização: `DSCliente.Edit`
5. Se inclusão: `DSCliente.AddNew` + atribui código
6. Popula todos os campos
7. `DSCliente.Update`
8. Requery do recordset

**Regras de Negócio (Cliente):**
- Código gerado automaticamente
- Data de nascimento obrigatória
- Bairro selecionado de lista (DBCombo)
- Clientes cancelados não podem cadastrar dependentes

**Campos da Entidade Dependente:**

| Campo | Tipo | Obrigatório | Descrição | Confiança |
|-------|------|-------------|-----------|-----------|
| cod_dependente | Numeric | Sim | Código do dependente (PK) | 🟢 |
| cod_cliente | Numeric | Sim | Código do cliente (FK) | 🟢 |
| nome_dependente | Text | Sim | Nome do dependente | 🟢 |

**Fluxo de Gravação de Dependente:**
1. Valida nome não vazio
2. Confirmação (Inclusão/Alteração)
3. Se alteração: remove nome anterior da lista
4. Se inclusão: `Wdependente.AddNew`
5. Se alteração: `Wdependente.Edit`
6. Atribui `cod_cliente` e `nome_dependente`
7. `Wdependente.Update`
8. Atualiza lista visual

**Validações:**
- Data de nascimento: `IsDate()`
- Data de expedição: `IsDate()`
- Código do cliente: `IsNumeric()`

---

### 3. Menu Principal (MENU02.FRM)

**Objetivo:** Formulário MDI principal que orquestra toda a aplicação.

**Função de Inicialização:**
```vb
Private Sub MDIForm_Load()
    SetaBanco()              ' Conecta ao banco
    frmPainel.Show          ' Tela de abertura
    DoEvents
    Senha.Show vbModal      ' Login
    Unload frmPainel        ' Remove splash
End Sub
```

**Itens de Menu Organizados por Categoria:**

| Categoria | Itens | Ação |
|-----------|-------|------|
| Cadastro | Clientes, Dependentes, CD's, Tabelas | Abre formulários correspondentes |
| Consultas | - | Abre frmConsulta |
| Movimentação | - | Abre LocDevol (Locação/Devolução) |
| Reserva | - | Abre ReservCD |
| Imprimir | Configurar Impressora, Clientes, Dependentes, Músicas, CD's | Relatórios Crystal Reports |
| Janelas | Lado a Lado, Cascata, Janelas Ativas | Organização MDI |
| Finaliza | - | Confirma e encerra aplicação |

**Relatórios (Crystal Reports):**
- `clien01.rpt` - Clientes Sintético
- `clien02.rpt` - Clientes Analítico
- `depend.rpt` - Dependentes
- `musicas.rpt` - Músicas/Intérpretes
- `musicas1.rpt` - Apenas Músicas
- `cds.rpt` - CDs Físicos
- `titulos.rpt` - Títulos
- `reserva.rpt` - Reservas

---

## Fluxo de Controle Principal

### Inicialização do Sistema

```
MDIForm_Load (MENU02.FRM)
    ↓
SetaBanco() [DECLARA.BAS]
    ↓
Abre BD_CDLOC.mdb
    ↓
Inicializa todos os Recordsets globais
    ↓
frmPainel.Show (Splash Screen)
    ↓
Senha.Show vbModal (Autenticação)
    ↓
[Validação de senha com XOR]
    ↓
Unload frmPainel
    ↓
Sistema pronto para uso
```

### Padrão de CRUD (Create-Read-Update-Delete)

O sistema usa um padrão consistente em todos os formulários:

1. **Inclusão:**
   - `GeraCodigo()` gera novo código
   - `LimpaCampos()` limpa formulário
   - Usuário preenche campos
   - `SSCmdGrava_Click()` valida e salva

2. **Consulta:**
   - Pesquisa por nome via `InputBox()` + F10
   - Lista preenchida em `ListBox`
   - Seleção preenche formulário via `Seek()`

3. **Alteração:**
   - Registro carregado define `Atualiza = "Sim"`
   - `SSCmdGrava_Click()` usa `Edit()` em vez de `AddNew()`

4. **Exclusão:**
   - `SSCmdExc_Click()` pede confirmação
   - Usa `wclien.Delete()`
   - Tratamento de erro 3200 (integridade referencial)

---

## Tratamento de Erros

### Padrão de Tratamento

```vb
On Error GoTo ErrorHandler
' ... código ...
ErrorHandler:
    Select Case Err.Number
        Case 3200  ' Integridade referencial
            MsgBox "Não pode EXCLUIR este registro!"
        Case Is <> 0
            MsgBox "Erro No. " & Err.Number
    End Select
```

**Códigos de Erro Conhecidos:**
- `3200` - Violação de integridade referencial

---

## Tabelas do Banco de Dados (Resumo)

| Tabela | Propósito | Relacionamentos |
|--------|-----------|-----------------|
| Cliente | Cadastro de clientes | → dependente |
| dependente | Dependentes de clientes | ← Cliente |
| cd | Catálogo de CDs físicos | → locacao, reserva |
| locacao | Locações ativas | ← Cliente, ← cd |
| reserva | Reservas de CDs | ← Cliente, ← cd |
| musica | Catálogo de músicas | → musica-interprete, titulo-musica |
| interprete | Intérpretes musicais | → titulo-interprete, musica-interprete |
| titulo | Títulos de CDs | → titulo-interprete, titulo-musica |
| titulo-interprete | Relacionamento título ↔ intérprete | ← titulo, ← interprete |
| musica-interprete | Relacionamento música ↔ intérprete | ← musica, ← interprete |
| titulo-musica | Relacionamento título ↔ música | ← titulo, ← musica |
| Bairro | Lista de bairros | ← Cliente |
| Municipio | Lista de municípios | ← Bairro (provável) |
| grupo | Grupos de classificação | 🟡 |
| estilo | Estilos musicais | 🟡 |
| recibo | Recibos emitidos | 🟡 |
| valor_loc | Tabela de valores de locação | 🟡 |
| senha | Senha de acesso ao sistema | 🟡 |

---

## Complexidade por Módulo

| Módulo | Complexidade | Motivo |
|--------|-------------|--------|
| Autenticação | Baixa | Lógica simples com XOR |
| Clientes | Alta | Múltiplos campos, dependentes, validações |
| CDs (CDS.FRM) | Alta | 3 abas (Títulos, Músicas, CDs Físicos), CRUD múltiplo |
| Locação (LOCDEVOL.FRM) | Alta | 3 abas (Locação, Devolução, Recibos), lógica complexa |
| Reserva (reservcd.frm) | Média | Gerenciamento de reservas de CDs por cliente |
| Consultas (frmConsulta.frm) | Média | Consulta genérica com múltiplos tipos |
| Tabelas (tabelas.frm) | Baixa | CRUD simples para tabelas auxiliares |
| Relatórios | Baixa | Apenas chamadas Crystal Reports |

---

## Módulos por Funcionalidade (Continuação)

### 4. Catálogo de CDs (CDS.FRM)

**Objetivo:** Gerenciar catálogo completo de CDs, incluindo Títulos, Músicas e CDs Físicos.

**Estrutura do Formulário (SSTab com 3 abas):**
1. **Aba Títulos:** Cadastro de títulos de CDs
2. **Aba Músicas:** Cadastro de músicas e suas relações
3. **Aba CDs:** Cadastro de CDs físicos disponíveis para locação

**Tabelas Relacionadas:**
- `titulo` — Títulos de CDs
- `musica` — Músicas individuais
- `titulo-interprete` — Relacionamento título ↔ intérprete
- `titulo-musica` — Relacionamento título ↔ música
- `cd` — CDs físicos
- `interprete` — Intérpretes (tabela auxiliar)
- `estilo` — Estilos musicais (tabela auxiliar)
- `grupo` — Grupos de classificação (tabela auxiliar)

**Funções Principais:**

| Função | Descrição | Aba | Confiança |
|--------|-----------|-----|-----------|
| `dados_titulo()` | Carrega dados do título para campos | Títulos | 🟢 |
| `dados_tit2()` | Carrega dados usando QueryDef | Títulos | 🟢 |
| `dados_tit3()` | Carrega dados adicional | Títulos | 🟢 |
| `dados_cd()` | Carrega dados do CD físico | CDs | 🟢 |
| `limpa_titulo()` | Limpa campos de título | Títulos | 🟢 |
| `limpa_musica()` | Limpa campos de música | Músicas | 🟢 |
| `limpa_cd()` | Limpa campos de CD | CDs | 🟢 |
| `pesq_titulo()` | Pesquisa título por nome | Títulos | 🟢 |

**Campos da Entidade Título (titulo):**

| Campo | Tipo | Obrigatório | Descrição | Confiança |
|-------|------|-------------|-----------|-----------|
| codtitulo | Numeric | Sim | Código do título (PK) | 🟢 |
| nometitulo | Text | Sim | Nome do título do CD | 🟢 |
| tipo_locacao | Text | Sim | Tipo de locação (24h/48h) | 🟢 |
| qtde | Numeric | Sim | Quantidade de CDs deste título | 🟢 |
| valor | Currency | Sim | Valor de locação | 🟢 |
| cdgrupo | Numeric | Não | Código do grupo (FK) | 🟢 |
| cdestilo | Numeric | Não | Código do estilo (FK) | 🟢 |

**Campos da Entidade Música (musica):**

| Campo | Tipo | Obrigatório | Descrição | Confiança |
|-------|------|-------------|-----------|-----------|
| codmusica | Numeric | Sim | Código da música (PK) | 🟢 |
| nomemusica | Text | Sim | Nome da música | 🟢 |
| tempo | Numeric | Não | Tempo/duração em segundos | 🟡 |

**Campos da Entidade CD Físico (cd):**

| Campo | Tipo | Obrigatório | Descrição | Confiança |
|-------|------|-------------|-----------|-----------|
| codcd | Numeric | Sim | Código do CD (PK) | 🟢 |
| codtitulo | Numeric | Sim | Código do título (FK) | 🟢 |
| numcd | Text | Sim | Número de identificação do CD | 🟢 |
| situacao | Text | Sim | Situação (Disponível/Locado/Reservado) | 🟢 |
| data_cp | Date | Não | Data de compra | 🟡 |
| valor_cd | Currency | Não | Valor de compra | 🟡 |

**Regras de Negócio:**
- Tipo de locação: 24 horas ou 48 horas
- Quantidade de CDs por título define estoque
- CD físico está vinculado a um título
- Situação do CD controla disponibilidade para locação

---

### 5. Locação e Devolução (LOCDEVOL.FRM)

**Objetivo:** Gerenciar todo o ciclo de locação, devolução e emissão de recibos.

**Estrutura do Formulário (SSTab com 3 abas):**
1. **Aba Locação:** Registrar novas locações
2. **Aba Devolução:** Registrar devoluções e calcular multas
3. **Aba Recibo:** Gerar e imprimir recibos

**Tabelas Relacionadas:**
- `locacao` — Registro de locações
- `recibo` — Recibos emitidos
- `cd` — CDs físicos (para verificar disponibilidade)
- `Cliente` — Dados do cliente locador
- `dependente` — Dependentes autorizados

**Funções Principais:**

| Função | Descrição | Aba | Confiança |
|--------|-----------|-----|-----------|
| `limpa_loc()` | Limpa campos de locação | Locação | 🟢 |
| `limpa_dev()` | Limpa campos de devolução | Devolução | 🟢 |
| `limpa_rec()` | Limpa campos de recibo | Recibo | 🟢 |
| `pesquisa_cliente()` | Pesquisa cliente para locação | Locação | 🟢 |
| `pesquisa_reserva()` | Pesquisa reservas do cliente | Locação | 🟢 |
| `cons_recibo()` | Consulta recibos pendentes | Recibo | 🟢 |
| `grava_recibo()` | Grava recibo gerado | Recibo | 🟢 |

**Campos da Entidade Locação (locacao):**

| Campo | Tipo | Obrigatório | Descrição | Confiança |
|-------|------|-------------|-----------|-----------|
| codlocacao | Numeric | Sim | Código da locação (PK) | 🟢 |
| codcliente | Numeric | Sim | Código do cliente (FK) | 🟢 |
| coddependente | Numeric | Não | Código do dependente (FK) | 🟢 |
| codcd | Numeric | Sim | Código do CD locado (FK) | 🟢 |
| data_locacao | Date/Time | Sim | Data/hora da locação | 🟢 |
| data_devolucao | Date/Time | Não | Data/hora da devolução real | 🟢 |
| data_prevista | Date/Time | Sim | Data prevista para devolução | 🟢 |
| valor_locacao | Currency | Sim | Valor cobrado na locação | 🟢 |
| valor_multa | Currency | Não | Valor da multa por atraso | 🟡 |
| situacao | Text | Sim | Situação (Locado/Devolvido) | 🟢 |

**Campos da Entidade Recibo (recibo):**

| Campo | Tipo | Obrigatório | Descrição | Confiança |
|-------|------|-------------|-----------|-----------|
| codrecibo | Numeric | Sim | Código do recibo (PK) | 🟢 |
| codlocacao | Numeric | Sim | Código da locação (FK) | 🟢 |
| data_emissao | Date/Time | Sim | Data de emissão | 🟢 |
| valor_total | Currency | Sim | Valor total (locação + multa) | 🟢 |
| devolvido | Boolean | Sim | Indica se recibo foi baixado | 🟢 |

**Fluxo de Locação:**
1. Pesquisar cliente por código ou nome
2. Pesquisar reservas do cliente (se houver)
3. Selecionar CD disponível para locação
4. Verificar se dependente pode retirar (opcional)
5. Definir tipo de locação (24h/48h)
6. Calcular valor baseado na tabela `valor_loc`
7. Registrar data prevista de devolução
8. Atualizar situação do CD para "Locado"
9. Gravar locação

**Fluxo de Devolução:**
1. Pesquisar recibo ou locação pendente
2. Selecionar recibo para baixar
3. Verificar se está dentro do prazo
4. Se atrasado: calcular multa
5. Registrar data de devolução real
6. Atualizar situação do CD para "Disponível"
7. Gerar recibo definitivo
8. Marcar recibo como devolvido

**Regras de Negócio:**
- CD locado não pode ser locado novamente
- Multa aplicada se devolução após prazo
- Dependentes podem retirar CDs em nome do titular
- Recibo só pode ser baixado uma vez

---

### 6. Reserva de CDs (reservcd.frm)

**Objetivo:** Permitir que clientes reservem CDs antes da locação.

**Tabelas Relacionadas:**
- `reserva` — Registro de reservas
- `titulo` — Títulos disponíveis
- `Cliente` — Dados do cliente

**Funções Principais:**

| Função | Descrição | Confiança |
|--------|-----------|-----------|
| `dados_tit()` | Carrega dados do título selecionado | 🟢 |
| `limpa_reserva()` | Limpa campos de reserva | 🟢 |
| `pesquisa_cliente()` | Pesquisa cliente por nome | 🟢 |
| `pesquisa_titulo()` | Pesquisa título disponível | 🟢 |

**Campos da Entidade Reserva (reserva):**

| Campo | Tipo | Obrigatório | Descrição | Confiança |
|-------|------|-------------|-----------|-----------|
| codreserva | Numeric | Sim | Código da reserva (PK) | 🟢 |
| codcliente | Numeric | Sim | Código do cliente (FK) | 🟢 |
| codtitulo | Numeric | Sim | Código do título (FK) | 🟢 |
| data_reserva | Date/Time | Sim | Data/hora da reserva | 🟢 |
| data_prevista | Date/Time | Não | Data prevista para retirada | 🟡 |
| situacao | Text | Sim | Situação (Pendente/Confirmada/Cancelada) | 🟢 |

**Fluxo de Reserva:**
1. Pesquisar cliente que fará a reserva
2. Pesquisar título desejado
3. Verificar disponibilidade de CDs do título
4. Informar data de reserva
5. Gravar reserva na tabela `reserva`
6. Ao efetivar locação: converter reserva em locação

**Regras de Negócio:**
- Reserva não garante disponibilidade física na retirada
- Várias reservas podem existir para o mesmo título
- Reservas podem ser canceladas
- Cliente pode ter múltiplas reservas ativas

---

### 7. Consultas Genéricas (frmConsulta.frm)

**Objetivo:** Permitir consultas flexíveis em várias tabelas do banco.

**Tipos de Consulta Suportados:**
- Todos os Títulos
- Todas as Músicas
- Todos os CDs
- Todos os Clientes
- Todas as Locações
- Todas as Reservas

**Modos de Pesquisa:**
- **Todas as Ocorrências:** Busca substring case-insensitive
- **Palavras Exatas:** Busca frase exata
- **Palavra Inicial + Complemento:** Busca prefixo e resto

**Funções Principais:**

| Função | Descrição | Confiança |
|--------|-----------|-----------|
| `Form_Load()` | Carrega tipos de consulta no ComboBox | 🟢 |
| `executa_consulta()` | Executa SQL baseada nos parâmetros | 🟢 |
| `preenche_grid()` | Popula MSFlexGrid com resultados | 🟢 |

**Fluxo de Consulta:**
1. Usuário seleciona tipo de consulta
2. Usuário digita texto para pesquisa
3. Usuário seleciona modo de pesquisa
4. Sistema constrói SQL dinâmico
5. Sistema popula grid com resultados
6. Usuário pode navegar pelos resultados

**Regras de Negócio:**
- Consulta é read-only (apenas leitura)
- Número de resultados exibido no campo `txtEncontrou`
- Grid permite redimensionamento de colunas

---

### 8. Tabelas Auxiliares (tabelas.frm)

**Objetivo:** Gerenciar tabelas auxiliares do sistema.

**Estrutura do Formulário (SSTab com 5 abas):**
1. **Aba Intérprete:** Cadastro de intérpretes musicais
2. **Aba Grupo:** Cadastro de grupos de classificação
3. **Aba Estilo:** Cadastro de estilos musicais
4. **Aba Bairro:** Cadastro de bairros
5. **Aba Município:** Cadastro de municípios

**Tabelas Gerenciadas:**

| Tabela | Descrição | Campos Principais | Confiança |
|--------|-----------|-------------------|-----------|
| interprete | Intérpretes musicais | codinterprete, nomeinterprete | 🟢 |
| grupo | Grupos de classificação | codgrupo, nomegrupo | 🟢 |
| estilo | Estilos musicais | codestilo, nomeestilo | 🟢 |
| Bairro | Bairros disponíveis | cdbairro, debairro | 🟢 |
| Municipio | Municípios | codmunic, nomemunic | 🟢 |

**Funções Principais (padrão para todas as abas):**

| Função | Descrição | Confiança |
|--------|-----------|-----------|
| `SSCmdGrava_X_Click()` | Salva/Atualiza registro da tabela X | 🟢 |
| `SSCmdExc_X_Click()` | Exclui registro da tabela X | 🟢 |
| `SSCmdLimp_X_Click()` | Limpa campos da aba X | 🟢 |
| `GeraCodigo_X()` | Gera novo código para tabela X | 🟢 |

**Fluxo de CRUD (Padrão):**
Mesmo padrão utilizado nos demais módulos (Inclusão, Consulta, Alteração, Exclusão).

**Regras de Negócio:**
- Código gerado automaticamente em todas as tabelas
- Nomes devem ser únicos (exceto Município onde pode haver homônimos)
- Bairro está vinculado a Município (relacionamento não visível na análise)

---

## Observações Técnicas

1. **Acesso Direto ao Banco:** Não há camada de abstração — todos os formulários acessam o banco diretamente
2. **Variáveis Globais:** Uso extensivo de variáveis globais para recordsets
3. **Geração de Código:** Função `geracod()` centralizada gera IDs sequenciais
4. **Validações:** Validações feitas no lado do cliente (VB6)
5. **Criptografia:** Usando XOR com chave 255 (inseguro por padrão moderno)
6. **Navegação:** MDI com formulários filho
7. **Help Externo:** Sistema de mensagens externalizadas em arquivo texto
8. **Controle de Concorrência:** Não há — acesso direto sem locks
9. **Transações:** Não usadas explicitamente (atualizações diretas)
