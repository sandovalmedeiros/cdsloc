# Consultas, Design Técnico

> Design técnico da feature de consultas do sistema CDsLoc
> Gerado pelo Reversa em 2026-05-08

---

## Interface

### Formulário Principal (frmConsulta.frm)

| Componente | Tipo | Descrição | Confiança |
|------------|------|-----------|-----------|
| `CboTipo` | ComboBox | Tipo de consulta (Títulos, Músicas, CDs, Clientes, Locações, Reservas) | 🟢 |
| `TxtPesquisa` | TextBox | Campo para digitar texto de pesquisa | 🟢 |
| `CboModo` | ComboBox | Modo de pesquisa (Todas as Ocorrências, Palavras Exatas, Palavra Inicial) | 🟢 |
| `BtnPesquisar` | CommandButton | Executar consulta | 🟢 |
| `BtnLimpar` | CommandButton | Limpar grid e campos | 🟢 |
| `MSFlexGrid1` | MSFlexGrid | Grid para exibir resultados | 🟢 |
| `TxtEncontrou` | TextBox | Número de registros encontrados | 🟢 |

---

## Fluxo Principal

### 1. Inicialização (Form_Load)

1. Sistema carrega tipos de consulta no ComboBox `CboTipo`:
   - "Todos os Títulos"
   - "Todas as Músicas"
   - "Todos os CDs"
   - "Todos os Clientes"
   - "Todas as Locações"
   - "Todas as Reservas"

2. Sistema carrega modos de pesquisa no ComboBox `CboModo`:
   - "Todas as Ocorrências"
   - "Palavras Exatas"
   - "Palavra Inicial + Complemento"

3. Limpa grid e contador de resultados

### 2. Executar Consulta (executa_consulta)

1. Sistema obtém parâmetros:
   - `tipo_consulta = CboTipo.Text`
   - `texto_pesquisa = TxtPesquisa.Text`
   - `modo_pesquisa = CboModo.Text`

2. Sistema constrói SQL dinâmico baseado nos parâmetros:

   **Para "Todas as Ocorrências" (case-insensitive):**
   ```sql
   SELECT * FROM tabela WHERE UCase(campo_busca) LIKE UCase('%texto_pesquisa%')
   ```

   **Para "Palavras Exatas":**
   ```sql
   SELECT * FROM tabela WHERE campo_busca = 'texto_pesquisa'
   ```

   **Para "Palavra Inicial + Complemento":**
   ```sql
   SELECT * FROM tabela WHERE UCase(campo_busca) LIKE UCase('texto_pesquisa%')
   ```

3. Sistema define tabela e campo de busca baseado no tipo:
   - **Títulos:** tabela = `titulo`, campo = `nometitulo`
   - **Músicas:** tabela = `musica`, campo = `nomemusica`
   - **CDs:** tabela = `cd` JOIN `titulo`, campo = `numcd`, `nometitulo`
   - **Clientes:** tabela = `Cliente`, campo = `nomecliente`
   - **Locações:** tabela = `locacao` JOIN `Cliente`, campo = data
   - **Reservas:** tabela = `reserva` JOIN `Cliente`, campo = data

4. Sistema executa SQL via recordset

5. Sistema chama `preenche_grid()` para exibir resultados

### 3. Preencher Grid (preenche_grid)

1. Sistema limpa o grid `MSFlexGrid1`

2. Sistema configura colunas baseado no tipo de consulta:
   - Define número de colunas
   - Define cabeçalhos das colunas

3. Sistema percorre recordset:
   - Para cada registro, adiciona linha ao grid
   - Popula células com os valores dos campos

4. Sistema atualiza contador:
   - `TxtEncontrou.Text = recordset.RecordCount`

5. Se nenhum registro encontrado:
   - Exibe mensagem: "Não foram encontrados registros"

---

## Modos de Pesquisa

### Todas as Ocorrências

Busca substring case-insensitive em qualquer parte do campo.

**Exemplo:** Pesquisar "beat" encontra "Beatles", "Beats", "Heartbeat", etc.

### Palavras Exatas

Busca frase completa, deve corresponder exatamente ao campo.

**Exemplo:** Pesquisar "The Beatles" encontra apenas "The Beatles".

### Palavra Inicial + Complemento

Busca prefixo, deve começar com o texto.

**Exemplo:** Pesquisar "beat" encontra "Beatles", "Beats", mas não "Heartbeat".

---

## Dependências

| Dependência | Motivo | Como Usa |
|-------------|--------|----------|
| **Tabela titulo** | Consulta de títulos | SQL SELECT base |
| **Tabela musica** | Consulta de músicas | SQL SELECT base |
| **Tabela cd** | Consulta de CDs físicos | SQL SELECT base, JOIN com titulo |
| **Tabela Cliente** | Consulta de clientes | SQL SELECT base |
| **Tabela locacao** | Consulta de locações | SQL SELECT base, JOIN com Cliente |
| **Tabela reserva** | Consulta de reservas | SQL SELECT base, JOIN com Cliente |

---

## Decisões de Design Identificadas

| Decisão | Evidência no código | Confiança |
|---------|---------------------|-----------|
| **SQL dinâmico construído em tempo de execução** | Função `executa_consulta()` monta SQL | 🟢 CONFIRMADO |
| **Grid read-only** | Documentado nas regras de negócio | 🟢 CONFIRMADO |
| **Case-insensitive via UCase()** | Uso de `UCase()` em SQL | 🟢 CONFIRMADO |
| **FlexGrid para exibição** | Controle MSFlexGrid utilizado | 🟢 CONFIRMADO |

---

## Estado Interno

### Variáveis Locais (frmConsulta.frm)

| Variável | Tipo | Descrição | Escopo |
|----------|------|-----------|--------|
| `tipo_consulta` | String | Tipo de consulta selecionado | Local |
| `texto_pesquisa` | String | Texto informado pelo usuário | Local |
| `modo_pesquisa` | String | Modo de pesquisa selecionado | Local |
| `sql_dinamico` | String | SQL construído dinamicamente | Local |

### Estados do Formulário

| Estado | Descrição | Flags/Ações |
|--------|-----------|-------------|
| **Início** | Formulário carregado, aguardando seleção | Campos limpos, grid vazio |
| **Consulta Executada** | SQL executado, resultados exibidos | Grid populado, contador atualizado |
| **Sem Resultados** | Nenhum registro encontrado | Grid vazio, contador = 0 |

---

## Observabilidade

### Mensagens ao Usuário

| Situação | Mensagem |
|----------|----------|
| Nenhum resultado encontrado | "Não foram encontrados registros" |
| Campo de pesquisa vazio | "Digite um texto para pesquisar" |
| Tipo de consulta não selecionado | "Selecione um tipo de consulta" |

---

## Riscos e Lacunas

Nenhum risco ou lacuna identificado para esta feature.
