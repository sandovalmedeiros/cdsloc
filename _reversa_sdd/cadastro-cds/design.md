# Cadastro de CDs, Design Técnico

> Design técnico da feature de cadastro de CDs do sistema CDsLoc
> Gerado pelo Reversa em 2026-05-08

---

## Interface

### Formulário Principal (CDS.FRM)

Formulário com controle SSTab contendo 3 abas principais:

#### Aba 1: Títulos

| Componente | Tipo | Descrição | Confiança |
|------------|------|-----------|-----------|
| `TxtCod_Tit` | TextBox | Código do título (somente leitura) | 🟢 |
| `TxtNom_Tit` | TextBox | Nome do título do CD | 🟢 |
| `Opt24h` | OptionButton | Tipo de locação: 24 horas | 🟢 |
| `Opt48h` | OptionButton | Tipo de locação: 48 horas | 🟢 |
| `TxtQtd_Tit` | TextBox | Quantidade de CDs deste título | 🟢 |
| `TxtVal_Tit` | TextBox | Valor de locação | 🟢 |
| `CboGrupo` | ComboBox | Grupo de classificação | 🟢 |
| `CboEstilo` | ComboBox | Estilo musical | 🟢 |
| `LstTit_Comp` | ListBox | Lista de composições (músicas) | 🟢 |
| `LstTit_Interp` | ListBox | Lista de intérpretes | 🟢 |
| `SSCmdGrava_Tit` | CommandButton | Gravar título | 🟢 |
| `SSCmdExc_Tit` | CommandButton | Excluir título | 🟢 |

#### Aba 2: Músicas

| Componente | Tipo | Descrição | Confiança |
|------------|------|-----------|-----------|
| `TxtCod_Mus` | TextBox | Código da música (somente leitura) | 🟢 |
| `TxtNom_Mus` | TextBox | Nome da música | 🟢 |
| `TxtTempo_Mus` | TextBox | Tempo em segundos | 🟢 |
| `TxtTit_Rel` | TextBox | Título relacionado (somente leitura) | 🟢 |
| `LstMus_Interp` | ListBox | Lista de intérpretes da música | 🟢 |
| `SSCmdGrava_Mus` | CommandButton | Gravar música | 🟢 |
| `SSCmdExc_Mus` | CommandButton | Excluir música | 🟢 |

#### Aba 3: CDs Físicos

| Componente | Tipo | Descrição | Confiança |
|------------|------|-----------|-----------|
| `TxtCod_CD` | TextBox | Código do CD (somente leitura) | 🟢 |
| `TxtNum_CD` | TextBox | Número de identificação do CD | 🟢 |
| `TxtTit_Rel_CD` | TextBox | Título relacionado (somente leitura) | 🟢 |
| `OptDisp_CD` | OptionButton | Situação: Disponível | 🟢 |
| `OptLoc_CD` | OptionButton | Situação: Locado | 🟢 |
| `DtaCp_CD` | MaskedTextBox | Data de compra | 🟡 |
| `TxtVal_CD` | TextBox | Valor de compra | 🟡 |
| `SSCmdGrava_CD` | CommandButton | Gravar CD | 🟢 |
| `SSCmdExc_CD` | CommandButton | Excluir CD | 🟢 |

---

## Fluxo Principal

### 1. Inicialização do Formulário (Form_Load)

1. Define posição do formulário na tela
2. Define `vformu = CDS` para uso em funções globais
3. Gera código via `geracod()` para título, música e CD
4. Configura recordsets globais:
   - `Wtitulo` para tabela `titulo`
   - `Wmusica` para tabela `musica`
   - `Wcdfisico` para tabela `cd`
   - `Winterprete` para tabela `interprete`
   - `Westilo` para tabela `estilo`
   - `Wgrupo` para tabela `grupo`
5. Popula ComboBoxes de Grupo e Estilo
6. Limpa campos de todas as abas

### 2. Gravação de Título (SSCmdGrava_Tit_Click)

1. **Validação de campos obrigatórios:**
   - Código não vazio
   - Nome do título não vazio
   - Tipo de locação selecionado (24h ou 48h)
   - Quantidade informada (numeric)
   - Valor informado (currency)

2. Se algum campo inválido: exibe MsgBox e seta foco

3. **Confirmação:** MsgBox "Confirme a Inclusão/Atualização"

4. Se resposta = Não: cancela operação

5. **Persistência:**
   - Se `Atualiza_Tit = Sim`: `Wtitulo.Edit`
   - Se não: `Wtitulo.AddNew`

6. Popula campos do recordset:
   - `codtitulo = Format(TxtCod_Tit, "0000")`
   - `nometitulo = TxtNom_Tit`
   - `tipo_locacao = "24h"` ou `"48h"` (baseado em OptionButton)
   - `qtde = Val(TxtQtd_Tit)`
   - `valor = CCur(TxtVal_Tit)`
   - `cdgrupo = CboGrupo` (se selecionado)
   - `cdestilo = CboEstilo` (se selecionado)

7. Executa `Wtitulo.Update`

8. Requery e MoveFirst

9. Limpa campos e gera novo código

### 3. Gravação de Música (SSCmdGrava_Mus_Click)

1. Valida: `TxtNom_Mus` não vazio

2. Confirmação: "Confirma a Inclusão/Alteração?"

3. Se não: cancela

4. **Persistência:**
   - Se `Atualiza_Mus = Sim`: `Wmusica.Edit`
   - Se não: `Wmusica.AddNew`

5. Popula recordset:
   - `codmusica = geracod()`
   - `nomemusica = TxtNom_Mus`
   - `tempo = Val(TxtTempo_Mus)` (se não vazio)

6. Executa `Wmusica.Update`

7. **Vinculação ao título (tabela titulo-musica):**
   - Adiciona registro na tabela `titulo-musica`
   - `codtitulo = código do título selecionado`
   - `codmusica = código da música recém-criada`

8. Atualiza ListBox de músicas do título (`LstTit_Comp`)

### 4. Gravação de CD Físico (SSCmdGrava_CD_Click)

1. **Validação de campos obrigatórios:**
   - Código do CD não vazio
   - Número do CD não vazio
   - Título relacionado selecionado
   - Situação definida (Disponível/Locado)

2. Se algum campo inválido: exibe MsgBox

3. Confirmação: "Confirme a Inclusão/Alteração?"

4. Se não: cancela

5. **Persistência:**
   - Se `Atualiza_CD = Sim`: `Wcdfisico.Edit`
   - Se não: `Wcdfisico.AddNew`

6. Popula recordset:
   - `codcd = Format(TxtCod_CD, "0000")`
   - `codtitulo = código do título selecionado`
   - `numcd = TxtNum_CD`
   - `situacao = "Disponível"` ou `"Locado"` (baseado em OptionButton)
   - `data_cp = DtaCp_CD` (se não vazio)
   - `valor_cd = CCur(TxtVal_CD)` (se não vazio)

7. Executa `Wcdfisico.Update`

8. Limpa campos e gera novo código

### 5. Pesquisa de Título (pesq_titulo)

1. Exibe InputBox: "Digite o Nome do Título"

2. Se vazio: cancela

3. Limpa lista `LstTit_Comp`

4. Percorre recordset `Wtitulo`:
   - Busca substring case-insensitive no nome
   - Se encontra: adiciona `nometitulo` à lista

5. Usuário seleciona título da lista

6. Chama `dados_titulo()` para carregar dados

### 6. Carregamento de Dados do Título (dados_titulo)

1. Usa índice para localizar título

2. Se encontrado:
   - Popula todos os campos do formulário
   - Carrega músicas relacionadas na ListBox `LstTit_Comp`
   - Carrega intérpretes relacionados na ListBox `LstTit_Interp`
   - Define `Atualiza_Tit = Sim`
   - Habilita botão de exclusão

3. Se não encontrado: modo de inclusão

---

## Fluxos Alternativos

### Edição de Título Existente

1. Usuário seleciona título da lista de pesquisa

2. Função `dados_titulo()` carrega dados

3. `Atualiza_Tit = Sim`

4. Ao gravar, usa `.Edit` em vez de `.AddNew`

### Exclusão de CD Locado

1. Usuário seleciona CD marcado como "Locado"

2. Tenta excluir

3. Sistema bloqueia exclusão (tratamento de erro)

4. Exibe mensagem: "CD está locado e não pode ser excluído"

### Vinculação de Intérprete a Música

1. Usuário seleciona música

2. Acessa seção de intérpretes

3. Seleciona intérprete da lista disponível

4. Sistema cria registro em `musica-interprete`:
   - `codmusica = código da música selecionada`
   - `codinterprete = código do intérprete selecionado`

5. Atualiza ListBox de intérpretes da música

---

## Dependências

| Dependência | Motivo | Como Usa |
|-------------|--------|----------|
| **DECLARA.BAS** | Funções globais utilitárias | `geracod()`, `LimpaCampos()`, `trata_errobd()` |
| **Tabela titulo** | Persistência de títulos | Recordset global `Wtitulo` |
| **Tabela musica** | Persistência de músicas | Recordset global `Wmusica` |
| **Tabela cd** | Persistência de CDs físicos | Recordset global `Wcdfisico` |
| **Tabela interprete** | Lista de intérpretes | Recordset global `Winterprete` |
| **Tabela titulo-musica** | Relacionamento título ↔ música | Popula ListBox de músicas |
| **Tabela titulo-interprete** | Relacionamento título ↔ intérprete | Popula ListBox de intérpretes do título |
| **Tabela musica-interprete** | Relacionamento música ↔ intérprete | Popula ListBox de intérpretes da música |
| **Tabela grupo** | Classificação de títulos | ComboBox `CboGrupo` |
| **Tabela estilo** | Classificação de títulos | ComboBox `CboEstilo` |

---

## Decisões de Design Identificadas

| Decisão | Evidência no código | Confiança |
|---------|---------------------|-----------|
| **SSTab para 3 níveis hierárquicos** | Formulário com abas Títulos/Músicas/CDs | 🟢 CONFIRMADO |
| **Título vs CD Físico separados** | Tabelas distintas `titulo` e `cd` | 🟢 CONFIRMADO |
| **Relacionamentos many-to-many via tabelas de ligação** | `titulo-musica`, `titulo-interprete`, `musica-interprete` | 🟢 CONFIRMADO |
| **Código sequencial gerado em memória** | Função `geracod()` | 🟢 CONFIRMADO |
| **Situação do CD controlada manualmente** | Flag `situacao` em vez de cálculo dinâmico | 🟢 CONFIRMADO |
| **Grupo e Estilo opcionais** | Campos FK podem ser nulos | 🟢 CONFIRMADO |

---

## Estado Interno

### Variáveis Globais (DECLARA.BAS)

```vb
Public Wtitulo As Recordset      ' Tabela Título
Public Wmusica As Recordset      ' Tabela Música
Public Wcdfisico As Recordset    ' Tabela CD
Public Winterprete As Recordset  ' Tabela Intérprete
Public Westilo As Recordset      ' Tabela Estilo
Public Wgrupo As Recordset       ' Tabela Grupo
```

### Variáveis Locais (CDS.FRM)

| Variável | Tipo | Descrição | Escopo |
|----------|------|-----------|--------|
| `vformu` | Form | Referência ao formulário atual | Global (módulo) |
| `Atualiza_Tit` | Boolean | Indica edição de título | Local |
| `Atualiza_Mus` | Boolean | Indica edição de música | Local |
| `Atualiza_CD` | Boolean | Indica edição de CD | Local |
| `cod_titulo_selec` | Long | Código do título selecionado | Local |
| `cod_musica_selec` | Long | Código da música selecionada | Local |

### Estados do Formulário

| Estado | Descrição | Flags Setadas |
|--------|-----------|---------------|
| **Novo Título** | Formulário em modo de inclusão de título | `Atualiza_Tit = False` |
| **Edição de Título** | Título carregado | `Atualiza_Tit = True` |
| **Nova Música** | Formulário em modo de inclusão de música | `Atualiza_Mus = False` |
| **Edição de Música** | Música carregada | `Atualiza_Mus = True` |
| **Novo CD** | Formulário em modo de inclusão de CD | `Atualiza_CD = False` |
| **Edição de CD** | CD carregado | `Atualiza_CD = True` |

---

## Observabilidade

### Mensagens ao Usuário

| Situação | Mensagem |
|----------|----------|
| Campo obrigatório vazio | "[Campo] não pode ficar em branco" |
| Confirmação de gravação | "Confirme a Inclusão/Atualização" |
| Confirmação de exclusão | "Deseja realmente Excluir?" |
| CD locado não pode ser excluído | "CD está locado e não pode ser excluído" |
| Título com músicas não pode ser excluído | "Não pode EXCLUIR este registro - Integridade Referencial" |

### Tratamento de Erros

| Erro | Descrição | Ação |
|------|-----------|------|
| 3200 | Violação de integridade referencial | Mensagem sobre exclusão bloqueada |
| Outros | Erro genérico | "Ocorreu Erro No. [número] - ligue p/Sandoval" |

---

## Riscos e Lacunas

- 🔴 **Código sequencial gerado em memória:** Em ambiente multiusuário, pode causar colisões
- 🔴 **Validação de estoque:** Não há validação para impedir que quantidade de CDs físicos exceda `qtde` do título
- 🔴 **Situação "Reservado":** Situação inferida mas não encontrada explicitamente no código
- 🟡 **Atualização de estoque:** Lógica para decrementar/incrementar estoque ao cadastrar/excluir CD físico não confirmada
- 🔴 **Exclusão de título com CDs físicos:** Comportamento não confirmado (deve falhar com erro 3200)
