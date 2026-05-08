# Fluxograma: Cadastro de Clientes

> Módulo: clientes (cliente.frm)
> Gerado pelo Reversa em 2026-05-08

## Fluxo Principal de Inicialização

```mermaid
flowchart TD
    A[Form_Load] --> B[Define posição do formulário]
    B --> C[Set vformu = Clientes]
    C --> D[msgI = Inclusão]
    D --> E[Set VTb = wclien]
    E --> F[Set VIx = primarykey]
    F --> G[Set VCt = Codcliente]
    G --> H[TxtCod_Cli = geracod]
    H --> I[TxtCod_Cli = Format 0000]
    I --> J[SQLData = SELECT cdbairro, debairro FROM bairro ORDER BY debairro]
    J --> K[dtaBairro.DatabaseName = App.Path + bd_cdloc.mdb]
    K --> L[dtaBairro.RecordSource = SQLData]
    L --> M[dtaBairro.Refresh]
    M --> N[Fim - Formulário Pronto]

    style A fill:#e1f5fe
    style N fill:#c8e6c9
```

## Fluxo de Gravação de Cliente

```mermaid
flowchart TD
    A[SSCmdGrava_Cli_Click] --> B{Validação de Campos Obrigatórios}
    B -->|Campo vazio| C[Identifica campo vazio]
    C --> D[MsgBox Campo X não pode ficar em branco]
    D --> E[MeuObjeto.SetFocus]
    E --> F[Fim com erro]
    B -->|Todos preenchidos| G[MsgBox Confirme a msgI Inclusão/Atualização]
    G --> H{Resposta = Sim?}
    H -->|Não| I[MsgBox Operação Cancelada]
    I --> J[LimpaCampos]
    J --> K[GeraCodigo]
    K --> F
    H -->|Sim| L{Atualiza = Sim?}
    L -->|Sim| M[DSCliente.Edit]
    L -->|Não| N[DSCliente.AddNew]
    N --> O[DSCliente codcliente = Format TxtCod_Cli 0000]
    M --> O
    O --> P[Popula todos os campos do DSCliente]
    P --> Q[DSCliente.Update]
    Q --> R[gravou = Sim]
    R --> S[DSCliente.Requery]
    S --> T[wclien.MoveFirst]
    T --> U[Fim - Registro Salvo]

    P --> P1[nomecliente = TxtNom_Cli]
    P1 --> P2[endereco = TxtEnd_Cli]
    P2 --> P3[data-nascimento = MskDta_Nasc se não vazio]
    P3 --> P4[cdbairro = cdBairro]
    P4 --> P5[cep = MskCep_Cli]
    P5 --> P6[fone-01 = MskTel1_Cli]
    P6 --> P7[ramal_res = txtRamalRes]
    P7 --> P8[ramal_trab = txtRamalTrab]
    P8 --> P9[fone-02 = MskTel2_Cli]
    P9 --> P10[fone-03 = MskTel3_Cli]
    P10 --> P11[identidade = TxtIdent_Cli]
    P11 --> P12[expedidor = TxtExp_Cli]
    P12 --> P13[data-expedicao = MskDta_Exp se não vazio]
    P13 --> P14[cic = MskCpf_Cli]
    P14 --> P15[empresa = TxtEmp_Cli]
    P15 --> P16[end-comercial = TxtEndEmp_Cli]
    P16 --> P17[referencia-pessoal = TxtRef_Cli]
    P17 --> P18[data-inscricao = MskDta_Cad se não vazio]
    P18 --> P19[obs = TxtObs_Cli]
    P19 --> P20[cancelado = NOT OptAtivo_Cli]
    P20 --> Q

    style A fill:#e1f5fe
    style U fill:#c8e6c9
    style F fill:#ffcdd2
    style D fill:#fff3e0
```

## Fluxo de Pesquisa de Cliente

```mermaid
flowchart TD
    A[Usuário pressiona F10 em TxtNom_Cli] --> B[pesq_cli = Sim]
    B --> C[pesquisa_cliente]
    C --> D[InputBox Digite o Nome/Sobrenome]
    D --> E{Pesq_Nome = ?}
    E -->|Vazio| F[pesq_cli = ]
    F --> G[Fim]
    E -->|Não vazio| H{pesq_cli = Sim?}
    H -->|Sim| I[LstNom_Cli.Clear]
    H -->|Não| J{pesq_dep = Sim?}
    J -->|Sim| K[LstNomCli_Dep.Clear]
    I --> L[wclien.MoveFirst]
    J --> L
    K --> L
    L --> M{Not wclien.EOF?}
    M -->|Não| G
    M -->|Sim| N[pesquisa = InStr UCase nomecliente UCase Pesq_Nome]
    N --> O[pesquisa2 = InStr nomecliente Pesq_Nome]
    O --> P{pesquisa ≠ 0 OR pesquisa2 ≠ 0?}
    P -->|Não| Q[wclien.MoveNext]
    Q --> M
    P -->|Sim| R{pesq_cli = Sim?}
    R -->|Sim| S[LstNom_Cli.AddItem nomecliente]
    R -->|Não| T[LstNomCli_Dep.AddItem nomecliente]
    S --> Q
    T --> Q

    style A fill:#e1f5fe
    style G fill:#c8e6c9
    style S fill:#c8e6c9
    style T fill:#c8e6c9
```

## Fluxo de Exclusão de Cliente

```mermaid
flowchart TD
    A[SSCmdExc_Cli_Click] --> B[On Error GoTo ErrorHandler]
    B --> C[MsgBox Deseja realmente Excluir?]
    C --> D{Resposta = vbNo?}
    D -->|Sim| E[TxtCod_Cli.SetFocus]
    E --> F[Fim cancelado]
    D -->|Não| G{wclien.RecordCount ≠ 0?}
    G -->|Não| H[MsgBox Não existe registro para EXCLUIR]
    H --> F
    G -->|Sim| I[wclien.Index = primarykey]
    I --> J[wclien.MoveFirst]
    J --> K[wclien.Seek = TxtCod_Cli]
    K --> L{wclien.NoMatch?}
    L -->|Sim| M[MsgBox SELECIONE registro para EXCLUIR]
    M --> F
    L -->|Não| N[wclien.Delete]
    N --> O[LimpaCampos]
    O --> P[GeraCodigo]
    P --> Q[Fim - Registro Excluído]

    Q --> R[ErrorHandler]
    R --> S{Err.Number = 3200?}
    S -->|Sim| T[MsgBox Você não pode EXCLUIR este registro - Integridade Referencial]
    T --> U[TxtCod_Cli.SetFocus]
    S -->|Não| V[MsgBox Ocorreu Erro No. Err.Number - ligue p/Sandoval]
    V --> U
    U --> W[Exit Sub]
    W --> X[Resume]

    style A fill:#e1f5fe
    style Q fill:#c8e6c9
    style F fill:#fff3e0
    style H fill:#fff3e0
    style M fill:#fff3e0
    style T fill:#ffcdd2
    style V fill:#ffcdd2
```

## Fluxo de Gravação de Dependente

```mermaid
flowchart TD
    A[SSCmdGrava_Dep_Click] --> D{TxtNom_Dep = ?}
    D -->|Vazio| B[MsgBox Nome do Dependente não pode ficar vazio]
    B --> C[TxtNom_Dep.SetFocus]
    C --> F[Fim com erro]
    D -->|Não preenchido| E{mensagem = Alterar?}
    E -->|Sim| F1[Msg = Confirma a Alteração do Dependente?]
    E -->|Não| F2[Msg = Confirma a Inclusão do Dependente?]
    F1 --> G[MsgBox Msg Style Critical]
    F2 --> G
    G --> H{resposta = vbYes?}
    H -->|Não| I[MsgBox Operação Cancelada]
    I --> J[TxtNom_Dep = ]
    J --> K[TxtNom_Dep.SetFocus]
    K --> F
    H -->|Sim| L{mensagem ≠ Alterar?}
    L -->|Sim| M[Wdependente.AddNew]
    L -->|Não| N[Wdependente.Edit]
    N --> O{Loop por LstNom_Dep}
    O --> P{LstNom_Dep.List i = nome_anterior?}
    P -->|Sim| Q[LstNom_Dep.RemoveItem i]
    P -->|Não| R[i = i + 1]
    R --> O
    Q --> S[Exit For]
    S --> T[LstNom_Dep.AddItem TxtNom_Dep]
    M --> U[Wdependente cod_cliente = TxtCodCli_Dep]
    U --> V[Wdependente nome_dependente = TxtNom_Dep]
    N --> U
    T --> V
    V --> W[Wdependente.Update]
    W --> X[TxtNom_Dep = ]
    X --> Y[TxtNom_Dep.SetFocus]
    Y --> Z[nome_anterior = ]
    Z --> AA[mensagem = ]
    AA --> AB[Fim - Dependente Salvo]

    style A fill:#e1f5fe
    style AB fill:#c8e6c9
    style F fill:#ffcdd2
    style B fill:#fff3e0
    style I fill:#fff3e0
```

## Fluxo de Carregamento de Dados do Cliente (Dados_Cliente2)

```mermaid
flowchart TD
    A[Dados_Cliente2] --> B[Set QDCliente = wbanco.QueryDefs Cs_Clientes]
    B --> C[QDCliente cdcliente = TxtCod_Cli.Text]
    C --> D[Set DSCliente = QDCliente.OpenRecordset dbOpenDynaset]
    D --> E{DSCliente.RecordCount ≠ 0?}
    E -->|Não| F[msgI = Inclusão]
    F --> G[Atualiza = Não]
    G --> H[Fim - Novo Cliente]
    E -->|Sim| I[EncheGrid]
    I --> J[msgI = Atualização]
    J --> K[Atualiza = Sim]
    K --> L[Carrega campos do DSCliente para o formulário]
    L --> M{DSCliente cancelado = False?}
    M -->|Sim| N[OptAtivo_Cli = True]
    M -->|Não| O[OptCanc_Cli = True]
    N --> P[SSCmdCons_Cli.Enabled = True]
    O --> Q[SSCmdCons_Cli.Enabled = False]
    P --> R[Fim - Dados Carregados]
    Q --> R

    L --> L1[TxtCod_Cli = Format DSCliente codcliente 0000]
    L1 --> L2[TxtNom_Cli = DSCliente nomecliente]
    L2 --> L3[MskDta_Nasc = Format data-nascimento dd/mm/yyyy se não nulo]
    L3 --> L4[TxtEnd_Cli = DSCliente endereco]
    L4 --> L5[dbcBairro.Text = DSCliente debairro]
    L5 --> L6[cdBairro = DSCliente cdbairro]
    L6 --> L7[txtMunicCli.Text = DSCliente deMunic]
    L7 --> L8[TxtIdent_Cli = DSCliente identidade]
    L8 --> L9[Demais campos...]
    L9 --> M

    style A fill:#e1f5fe
    style H fill:#c8e6c9
    style R fill:#c8e6c9
    style Q fill:#fff3e0
```

## Descrição dos Passos

### Validação de Campos

Antes de gravar, o sistema verifica:
1. Código do cliente não vazio
2. Nome do cliente não vazio
3. Endereço não vazio
4. Data de nascimento não vazia
5. Bairro selecionado (cdBairro ≠ 0)
6. Identidade não vazia

### Pesquisa Flexível

A pesquisa de clientes usa `InStr()` duas vezes:
- Uma com `UCase()` para buscar maiúsculas
- Uma sem conversão para buscar minúsculas
- Isso torna a busca case-insensitive

### Tratamento de Erro na Exclusão

O erro 3200 indica violação de integridade referencial, ou seja:
- O cliente possui dependentes cadastrados
- O cliente possui locações ativas
- O cliente possui reservas

### Geração de Código

O código é gerado pela função `geracod()` que:
1. Move para o último registro
2. Lê o valor atual do campo especificado
3. Retorna valor + 1
4. Retorna 1 se tabela vazia

## Variáveis Locais

| Variável | Tipo | Descrição |
|----------|------|-----------|
| pesq_dep | String | Flag indicando pesquisa para dependente |
| pesq_cli | String | Flag indicando pesquisa para cliente |
| mensagem | String | "Incluir" ou "Alterar" |
| nome_anterior | String | Nome anterior do dependente (para alteração) |
| cdBairro | Integer | Código do bairro selecionado |
| cod_dependente | String | Código do dependente selecionado |
