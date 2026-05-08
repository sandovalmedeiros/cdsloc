# Fluxograma: Autenticação

> Módulo: autenticacao (SENHA.FRM)
> Gerado pelo Reversa em 2026-05-08

## Fluxo Principal de Login

```mermaid
flowchart TD
    A[Início: MDIForm_Load] --> B[SetaBanco]
    B --> C[frmPainel.Show]
    C --> D[Senha.Show vbModal]
    D --> E{Usuário digita senha?}
    E -->|Não| E
    E -->|Sim| F[Pressiona Enter]
    F --> G{contador < 3?}
    G -->|Não| H[End - Encerrar Sistema]
    G -->|Sim| I[tabsenha.MoveFirst]
    I --> J{LCase senha = codigo id-senha?}
    J -->|Não| K[MsgBox Senha Inválida]
    K --> L[contador = contador + 1]
    L --> M[Text1 = ]
    M --> N[Text1.SetFocus]
    N --> E
    J -->|Sim| O{muda_senha_check marcado?}
    O -->|Não| P[Unload Me]
    P --> Q[Principal.Show]
    Q --> R[Fim - Sistema Carregado]
    O -->|Sim| S[InputBox Nova Senha 1]
    S --> T[InputBox Nova Senha 2]
    T --> U{Senhas iguais AND Len <= 10?}
    U -->|Não| V[MsgBox Senha Rejeitada]
    V --> W[Encerrar e tentar de novo]
    U -->|Sim| X[tabsenha.Edit]
    X --> Y[tabsenha id-senha = código nova senha]
    Y --> Z[tabsenha.Update]
    Z --> P

    style A fill:#e1f5fe
    style R fill:#c8e6c9
    style H fill:#ffcdd2
    style W fill:#ffcdd2
    style V fill:#fff3e0
    style K fill:#fff3e0
```

## Fluxo de Alteração de Senha

```mermaid
flowchart TD
    A[Usuário marca Muda Senha] --> B[Login com senha atual]
    B --> C[Validação OK]
    C --> D{Checkbox marcado?}
    D -->|Não| E[Login normal]
    D -->|Sim| F[InputBox Forneça a nova senha]
    F --> G[wsenha_atu1 = entrada]
    G --> H[InputBox Forneça a nova senha para confirmar]
    H --> I[wsenha_atu2 = entrada]
    I --> J{wsenha_atu1 = wsenha_atu2?}
    J -->|Não| K[Senhas não conferem]
    K --> L[MsgBox Senha rejeitada por erro na confirmação]
    L --> M[Encerrar programa e tentar de novo]
    J -->|Sim| N{Len wsenha_atu2 < 11?}
    N -->|Não| O[Senha muito longa]
    O --> P[MsgBox Senha rejeitada por possuir mais de 10 caracteres]
    P --> M
    N -->|Sim| Q[tabsenha.Edit]
    Q --> R[tabsenha id-senha = código wsenha_atu2]
    R --> S[tabsenha.Update]
    S --> T[Senha alterada com sucesso]

    style E fill:#c8e6c9
    style T fill:#c8e6c9
    style M fill:#ffcdd2
    style L fill:#fff3e0
    style P fill:#fff3e0
```

## Algoritmo de Codificação (XOR)

```mermaid
flowchart TD
    A[Função codigo went] --> B[wsai = ]
    B --> C[i = 1]
    C --> D{i <= Len went?}
    D -->|Não| E[Retornar wsai]
    D -->|Sim| F[caractere = Mid went i 1]
    F --> G[ascii = Asc caractere]
    G --> H[xor_result = ascii XOR 255]
    H --> I[novo_char = Chr xor_result]
    I --> J[wsai = wsai + novo_char]
    J --> K[i = i + 1]
    K --> D

    style A fill:#e1f5fe
    style E fill:#c8e6c9
```

## Descrição dos Passos

### Login Principal

1. **Inicialização:** O MDIForm_Load conecta ao banco, mostra splash screen e exibe o form de senha como modal
2. **Entrada da Senha:** Usuário digita senha no campo Text1 (máscara `*`)
3. **Validação:** Sistema compara a senha digitada com a senha armazenada usando a função `codigo()`
4. **Contador de Tentativas:** Cada erro incrementa o contador
5. **Limite:** Após 3 tentativas, o sistema encerra
6. **Alteração de Senha:** Se checkbox marcado, permite alteração

### Alteração de Senha

1. **Confirmação:** Usuário deve digitar a senha duas vezes
2. **Validação de Igualdade:** As duas senhas devem ser idênticas
3. **Validação de Tamanho:** Máximo de 10 caracteres
4. **Gravação:** Nova senha é codificada e salva na tabela `senha`

### Função de Codificação

A função `codigo()` aplica XOR bit-a-bit com 255 em cada caractere:
- XOR 255 é equivalente a NOT bit-a-bit (inversão de bits)
- Esta operação é reversível: `codigo(codigo(x)) = x`
- **Nota:** Esta é uma criptografia muito fraca, reversível e não segura por padrões modernos

## Variáveis Locais

| Variável | Tipo | Descrição |
|----------|------|-----------|
| contador | Integer | Contador de tentativas de login |
| went | String | Parâmetro de entrada para função codigo() |
| wsai | String | String resultante da codificação |
| wsenha_atu1 | String | Primeira entrada da nova senha |
| wsenha_atu2 | String | Segunda entrada (confirmação) da nova senha |
