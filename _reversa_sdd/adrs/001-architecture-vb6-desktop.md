# ADR 001: Arquitetura Desktop Visual Basic 6.0

**Status:** Aceito
**Data:** 1998 (inferido da tecnologia)
**Decisão:** Utilizar Visual Basic 6.0 como linguagem de desenvolvimento para sistema de locação de CDs
**Contexto:** Sistemas de gestão de locadora de CDs na década de 1990

## Contexto

A locadora necessitava de um sistema para gerenciar:

- Cadastro de clientes e dependentes
- Controle de catálogo de CDs (títulos, músicas, intérpretes)
- Controle de locação e devolução
- Emissão de recibos
- Relatórios gerenciais

Requisitos não funcionais inferidos:
- **Sistema monoposto:** Uma única estação de trabalho
- **Interface amigável:** Necessário baixa curva de aprendizado
- **Custo de desenvolvimento:** Restrição de orçamento
- **Disponibilidade de profissionais:** Desenvolvedores com conhecimento VB6

## Decisão

Utilizar **Visual Basic 6.0** com arquitetura **2-tier Cliente-Servidor**:

- **Camada de Apresentação:** Formulários VB6 (MDI)
- **Camada de Acesso a Dados:** DAO 2.5 direto ao Microsoft Access
- **Interface Gráfica:** Controls ActiveX (Sheridan 3D, MSFlexGrid)
- **Relatórios:** Crystal Reports

## Consequências

### Positivas

- ✅ **Desenvolvimento rápido:** VB6 permitia prototipagem rápida
- ✅ **Interface consistente:** Look & feel padrão Windows da época
- ✅ **Banco de dados integrado:** Access sem necessidade de servidor separado
- ✅ **Baixo custo:** Ferramentas disponíveis no Visual Studio
- ✅ **Facilidade de manutenção:** Código procedimental fácil de entender

### Negativas

- ❌ **Escala limitada:** Não suporta múltiplos usuários simultâneos
- ❌ **Sem camada de negócio:** Lógica misturada com interface
- ❌ **Dificuldade de testes:** Sem framework de testes automático
- ❌ **Obsolescência:** VB6 descontinuado pela Microsoft
- ❌ **Segurança:** Criptografia fraca (XOR)

---

## ADR 002: Persistência via Microsoft Access e DAO 2.5

**Status:** Aceito
**Data:** 1998 (inferido da tecnologia)
**Decisão:** Utilizar Microsoft Access como banco de dados com DAO 2.5 para acesso
**Contexto:** Necessidade de persistência de dados sem servidor de banco de dados

## Contexto

Sistema necessitava persistência de dados com requisitos:

- **Baixo custo de infraestrutura:** Sem necessidade de servidor dedicado
- **Fácil deploy:** Arquivo único MDB
- **Performance adequada:** Volume de dados esperado pequeno/médio
- **Manutenção simples:** Backup cópia de arquivo

## Decisão

Utilizar **Microsoft Access (.mdb)** como banco de dados, acessado via **DAO (Data Access Objects) 2.5**:

- Conexão global: `wbanco` (variável pública)
- Recordsets globais para cada tabela
- Queries pré-definidas (QueryDefs)
- Acesso direto sem abstração

## Consequências

### Positivas

- ✅ **Zero infraestrutura:** Arquivo único funciona localmente
- ✅ **Backup simples:** Cópia do arquivo .mdb
- ✅ **Integração nativa:** DAO é nativo do Access
- ✅ **Performance aceitável** para volumes pequenos/médios

### Negativas

- ❌ **Sem concorrência:** Locks simples, pode corromper dados
- ❌ **Escalabilidade:** Limitado a tamanho de arquivo (2GB)
- ❌ **Sem transações complexas:** Controle manual de rollback
- ❌ **Acoplamento:** Código diretamente acoplado ao DAO
- ❌ **Suporte encerrado:** DAO e Jet descontinuados

---

## ADR 003: Criptografia de Senha via XOR

**Status:** Aceito
**Data:** 1998 (inferido da tecnologia)
**Decisão:** Utilizar XOR bit-a-bit com chave 255 para criptografia de senha
**Contexto:** Necessidade de proteger senha de acesso ao sistema

## Contexto

Sistema possuía uma senha única de acesso. Requisito:

- **Proteção básica:** Senha não legível diretamente
- **Simplicidade:** Implementação fácil e rápida
- **Reversibilidade:** Necessário comparar senhas

## Decisão

Implementar criptografia XOR:

```vb
Private Function codigo(went)
    wsai = ""
    For i = 1 To Len(went)
       wsai = wsai & Chr(Asc(Mid(went, i, 1)) Xor 255)
    Next
    codigo = wsai
End Function
```

## Consequências

### Positivas

- ✅ **Simples de implementar:** Poucas linhas de código
- ✅ **Rápido:** Operação O(n) simples
- ✅ **Reversível:** Permite comparação direta

### Negativas

- ❌ **Segurança nula:** XOR com chave constante é facilmente reversível
- ❌ **Sem salt:** Mesma senha produz mesma saída sempre
- ❌ **Reversível:** Qualquer pessoa pode decodificar
- ❌ **Não atende padrões:** Criptografia de senha deve usar hash unidirecional

---

## ADR 004: Geração de Códigos Sequenciais

**Status:** Aceito
**Data:** 1998 (inferido da tecnologia)
**Decisão:** Utilizar geração sequencial de códigos para chaves primárias
**Contexto:** Necessidade de IDs únicos para todas as entidades

## Contexto

Sistema necessitava identificar unicamente:

- Clientes
- CDs Físicos
- Títulos
- Locações
- Reservas
- Etc.

Requisitos:

- **Simplicidade:** Fácil de entender e implementar
- **Unicidade:** Garantia de não colisão
- **Legibilidade:** Códigos numéricos formatados

## Decisão

Implementar função global `geracod()`:

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

Utilizar variáveis globais:
- `VTb`: Tabela (Recordset)
- `VIx`: Nome do índice
- `VCt`: Campo contendo o código

## Consequências

### Positivas

- ✅ **Simples:** Poucas linhas, fácil de manter
- ✅ **Legível:** Códigos numéricos sequenciais
- ✅ **Padrão consistente:** Mesma função para todas as tabelas
- ✅ **Sem lacunas:** Sequência contígua (1, 2, 3, ...)

### Negativas

- ❌ **Sem paralelismo:** Não funciona com múltiplos usuários
- ❌ **Race condition:** Entre MoveLast e Update pode haver colisão
- ❌ **Previsibilidade:** Fácil adivinhar próximo código
- ❌ **Sem reuso:** Códigos deletados nunca são reutilizados
- ❌ **Variáveis globais:** Dificulta teste e manutenção

---

## ADR 005: Interface MDI com SSTab

**Status:** Aceito
**Data:** 1998 (inferido da tecnologia)
**Decisão:** Utilizar MDI (Multiple Document Interface) com abas para organizar funcionalidades
**Contexto:** Organização da interface do sistema

## Contexto

Sistema possuía múltiplas funcionalidades que precisavam coexistir:

- Cadastros (Clientes, CDs, Tabelas)
- Movimentação (Locação, Devolução, Recibos)
- Consultas
- Reservas

Requisitos:

- **Múltiplos formulários abertos:** Usuário pode ter várias janelas
- **Organização lógica:** Agrupamento por função
- **Uso eficiente de espaço:** Não encher tela com formulários

## Decisão

Utilizar **MDI (Multiple Document Interface)** com **SSTab**:

- Formulário MDI principal (`MENU02.FRM`)
- Formulários filhos abertos dentro do MDI
- Controle SSTab para organizar sub-funcionalidades em abas

Exemplos:
- **LOCDEVOL.FRM:** 3 abas (Locação, Devolução, Recibo)
- **CDS.FRM:** 3 abas (Títulos, Músicas, CDs Físicos)
- **TABELAS.FRM:** 5 abas (Intérprete, Grupo, Estilo, Bairro, Município)

## Consequências

### Positivas

- ✅ **Organização clara:** Abas agrupam funcionalidades relacionadas
- ✅ **MDI permite múltiplas janelas:** Usuário pode ter mais de um formulário aberto
- ✅ **Espaço eficiente:** Apenas aba ativa visível
- ✅ **Padrão Windows:** Familiar aos usuários da época

### Negativas

- ❌ **Complexidade de código:** Eventos de abas precisam gerenciar estado
- ❌ **Dificuldade de navegação:** Usuário precisa lembrar onde está cada função
- ❌ **MDI descontinuado:** Padrão MDI abandonado pela Microsoft

---

## ADR 006: Sem Autenticação por Usuário

**Status:** Aceito
**Data:** 1998 (inferido da tecnologia)
**Decisão:** Utilizar autenticação global via senha única, sem login individual
**Contexto:** Sistema monoposto para locadora

## Contexto

Ambiente da locadora:

- **Única estação de trabalho:** Computador no caixa
- **Poucos operadores:** 1-3 funcionários
- **Ambiente controlado:** Acesso físico restrito ao computador

Requisitos:

- **Simplicidade:** Operadores não precisam lembrar múltiplos logins
- **Rápido acesso:** Mínima fricção para atender clientes
- **Controle básico:** Impedir acesso não autorizado

## Decisão

Implementar **autenticação global via senha única**:

- Tabela `senha` com um registro
- Entrada de senha na inicialização
- 3 tentativas permitidas
- Opção de alteração durante login

## Consequências

### Positivas

- ✅ **Simples:** Operador digita apenas uma senha
- ✅ **Rápido:** Acesso imediato ao sistema
- ✅ **Baixo custo de desenvolvimento:** Sem implementação de RBAC

### Negativas

- ❌ **Sem rastreabilidade:** Impossível saber quem fez cada ação
- ❌ **Sem responsabilidade:** Qualquer operador pode fazer qualquer ação
- ❌ **Sem revogação:** Não é possível bloquear um operador específico
- ❌ **Sem auditoria:** Nenhum log de acessos

---

## ADR 007: Mensagens Externalizadas em Arquivo Texto

**Status:** Aceito
**Data:** 1998 (inferido da tecnologia)
**Decisão:** Armazenar mensagens do sistema em arquivo externo (ARQUIMSG.BAS)
**Contexto:** Facilitar alteração de mensagens sem recompilar

## Contexto

Sistema possuía diversas mensagens de:

- Validação
- Erros
- Informações
- Confirmações

Requisitos:

- **Facilidade de alteração:** Mudar mensagens sem recompilar
- **Centralização:** Um lugar para todas as mensagens
- **Internacionalização:** Potencial suporte a múltiplos idiomas

## Decisão

Implementar sistema de mensagens externalizadas:

- Arquivo de texto com seções marcadas por `>número`
- Função `ARQUIMSG(NomeArq$, Secao%)` para exibir mensagens
- Mensagens formatadas como MsgBox

## Consequências

### Positivas

- ✅ **Sem recompilação:** Mensagens podem ser alteradas por arquivo
- ✅ **Centralizado:** Todas as mensagens em um arquivo
- ✅ **Flexível:** Formato simples e fácil de editar

### Negativas

- ❌ **Sem verificação em tempo de compilação:** Erros em mensagens não detectados
- ❌ **Vinculação fraca:** Número de seção mágico pode quebrar
- ❌ **Sem formatação rica:** Limitado ao que MsgBox suporta

---

## ADR 008: Limpeza de Controles via Tag = "N"

**Status:** Aceito
**Data:** 1998 (inferido da tecnologia)
**Decisão:** Utilizar propriedade Tag para marcar controles que não devem ser limpos
**Contexto:** Função LimpaCampos precisa preservar alguns campos

## Contexto

Sistema possuía função global `LimpaCampos(vformu As Form)` para:

- Limpar formulário após inclusão/alteração
- Preparar formulário para novo registro
- Padronizar comportamento

Problema: Alguns controles não devem ser limpos (código, labels informativos, etc.)

## Decisão

Utilizar **propriedade Tag** para marcar controles:

- Se `Tag = "N"`, controle NÃO é limpo
- Se `Tag` vazio ou diferente, controle é limpo
- Aplicado para TextBox, MaskEdBox, DBCombo, MSFlexGrid, ComboBox, ListBox

```vb
If MeuControle.Tag <> "N" Then
    MeuControle.Text = Empty
End If
```

## Consequências

### Positivas

- ✅ **Flexível:** Qualquer controle pode ser excluído da limpeza
- ✅ **Padrão consistente:** Mesmo mecanismo em todo o sistema
- ✅ **Simples:** Propriedade nativa dos controles

### Negativas

- ❌ **Visual Studio:** Tag não visível na interface (configurar via código)
- ❌ **Sem documentação visual:** Não é óbvio quais controles são preservados
- ❌ **Frágil:** Erro de digitação ("n" vs "N") quebra funcionalidade
