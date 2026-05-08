# Arquitetura — CDsLoc

> Gerado pelo Reversa em 2026-05-08
> Visão arquitetural do sistema de locação de CDs

---

## Resumo Executivo

O **CDsLoc** é um sistema de locação de CDs de música desenvolvido em **Visual Basic 6.0** com arquitetura **cliente-servidor 2-tier** (típica de aplicações desktop da época). O sistema utiliza Microsoft Access como banco de dados através da biblioteca DAO 2.5 e Crystal Reports para geração de relatórios.

| Aspecto | Detalhe | Confiança |
|---------|---------|-----------|
| **Arquitetura** | Cliente-Servidor 2-tier (Desktop) | 🟢 CONFIRMADO |
| **Linguagem** | Visual Basic 6.0 | 🟢 CONFIRMADO |
| **Paradigma** | Procedural com MDI (Multiple Document Interface) | 🟢 CONFIRMADO |
| **Banco de Dados** | Microsoft Access via DAO 2.5 | 🟢 CONFIRMADO |
| **Relatórios** | Crystal Reports 4.6/5.2 | 🟢 CONFIRMADO |
| **Deploy** | Executável Windows (.exe) + banco local | 🟢 CONFIRMADO |

---

## Visão Geral Arquitetural

### Camadas da Aplicação

```
┌─────────────────────────────────────────────────────────────────┐
│                      Camada de Apresentação                      │
│                      (Visual Basic 6.0)                         │
│  ┌──────────────────────────────────────────────────────────┐   │
│  │              Formulários MDI (17 .frm)                    │   │
│  │  - Autenticação (SENHA.FRM)                               │   │
│  │  - Menu Principal (MENU02.FRM)                             │   │
│  │  - Cadastro de Clientes (cliente.frm)                      │   │
│  │  - Locação/Devolução (LOCDEVOL.FRM)                        │   │
│  │  - Catálogo de CDs (CDS.FRM)                               │   │
│  │  - Reservas (reservcd.frm)                                 │   │
│  │  - Consultas (frmConsulta.frm)                             │   │
│  │  - Tabelas Auxiliares (tabelas.frm)                        │   │
│  └──────────────────────────────────────────────────────────┘   │
│  ┌──────────────────────────────────────────────────────────┐   │
│  │              Módulos Globais (3 .bas)                      │   │
│  │  - DECLARA.BAS (funções utilitárias)                       │   │
│  │  - ARQUIMSG.BAS (mensagens externalizadas)                 │   │
│  │  - CONSTANT.TXT (constantes VB6)                           │   │
│  └──────────────────────────────────────────────────────────┘   │
└─────────────────────────────────────────────────────────────────┘
                               │
                               │ DAO 2.5 (Direct Access)
                               │
┌─────────────────────────────────────────────────────────────────┐
│                      Camada de Dados                             │
│                  (Microsoft Access .mdb)                         │
│  ┌──────────────────────────────────────────────────────────┐   │
│  │                    Tabelas de Negócio                      │   │
│  │  - Cliente, dependente, cd, locacao, recibo, reserva      │   │
│  │  - titulo, musica, interprete                             │   │
│  │  - titulo-interprete, musica-interprete, titulo-musica    │   │
│  └──────────────────────────────────────────────────────────┘   │
│  ┌──────────────────────────────────────────────────────────┐   │
│  │                    Tabelas Auxiliares                      │   │
│  │  - Bairro, Municipio, grupo, estilo, senha, valor_loc     │   │
│  └──────────────────────────────────────────────────────────┘   │
└─────────────────────────────────────────────────────────────────┘
```

### Características da Arquitetura

| Característica | Descrição | Confiança |
|----------------|-----------|-----------|
| **Monolítica** | Toda a lógica está nos formulários VB6 | 🟢 CONFIRMADO |
| **Sem Camada de Negócio** | Regras de negócio embutidas nos formulários | 🟢 CONFIRMADO |
| **Acesso Direto** | Formulários acessam o banco diretamente via DAO | 🟢 CONFIRMADO |
| **Sem API** | Não há camada de serviços ou REST API | 🟢 CONFIRMADO |
| **Single User** | Um usuário por estação, banco local | 🟢 CONFIRMADO |
| **Sem Transações** | Atualizações diretas, sem controle de transações explícito | 🟡 INFERIDO |

---

## Padrões Arquiteturais

### Padrão de Inicialização

```
MENU02.FRM (MDI)
    ↓
frmPainel.frm (Splash)
    ↓
Senha.frm (Login) → Validação XOR
    ↓
Menu Principal (ativo)
```

### Padrão de CRUD

O sistema utiliza um padrão consistente em todos os formulários:

| Ação | Função | Comportamento |
|------|--------|---------------|
| **Inclusão** | `GeraCodigo()` + `AddNew()` | Gera ID sequencial, limpa campos, grava |
| **Consulta** | `InputBox()` + `Seek()` | Pesquisa por nome, preenche lista, carrega registro |
| **Alteração** | `Edit()` | Flag `Atualiza = "Sim"`, usa `Edit()` em vez de `AddNew()` |
| **Exclusão** | `Delete()` | Confirmação, trata erro 3200 (integridade) |

### Padrão de Tratamento de Erros

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

---

## Componentes Principais

### 1. Subsistema de Autenticação

**Arquivos:** SENHA.FRM, tabela `senha`

| Componente | Responsabilidade | Confiança |
|------------|------------------|-----------|
| Formulário de Login | Capturar senha, validar, permitir troca | 🟢 CONFIRMADO |
| Criptografia XOR | Codificar/decodificar senha (inseguro) | 🟢 CONFIRMADO |
| Controle de Tentativas | Limitar a 3 tentativas antes de encerrar | 🟢 CONFIRMADO |

### 2. Subsistema de Cadastros

**Arquivos:** cliente.frm, CAD_DEP.FRM, CDS.FRM, tabelas.frm

| Componente | Responsabilidade | Confiança |
|------------|------------------|-----------|
| Cadastro de Clientes | CRUD completo de clientes e dependentes | 🟢 CONFIRMADO |
| Cadastro de CDs | Gerenciar títulos, músicas e CDs físicos | 🟢 CONFIRMADO |
| Tabelas Auxiliares | Manter intérpretes, grupos, estilos, bairros, municípios | 🟢 CONFIRMADO |

### 3. Subsistema de Movimentação

**Arquivos:** LOCDEVOL.FRM

| Componente | Responsabilidade | Confiança |
|------------|------------------|-----------|
| Locação | Registrar aluguel de CDs, calcular datas | 🟢 CONFIRMADO |
| Devolução | Registrar retorno, calcular multa | 🟡 INFERIDO |
| Emissão de Recibo | Gerar documento fiscal da locação | 🟢 CONFIRMADO |

### 4. Subsistema de Reservas

**Arquivos:** reservcd.frm, CONSRES1.frm, CONSRES2.frm, CONSRES3.frm

| Componente | Responsabilidade | Confiança |
|------------|------------------|-----------|
| Gestão de Reservas | Criar, consultar e cancelar reservas | 🟢 CONFIRMADO |
| Conversão em Locação | Transformar reserva em locação efetiva | 🟡 INFERIDO |

### 5. Subsistema de Consultas

**Arquivos:** frmConsulta.frm

| Componente | Responsabilidade | Confiança |
|------------|------------------|-----------|
| Consultas Genéricas | Busca em múltiplas tabelas com filtros flexíveis | 🟢 CONFIRMADO |
| Grid de Resultados | Exibição em MSFlexGrid com ordenação | 🟢 CONFIRMADO |

### 6. Subsistema de Relatórios

**Arquivos:** *.rpt (Crystal Reports), menu Imprimir

| Componente | Responsabilidade | Confiança |
|------------|------------------|-----------|
| Relatórios Crystal | 12 relatórios pré-formatados | 🟢 CONFIRMADO |
| Configuração de Impressora | Seleção via CommonDialog | 🟢 CONFIRMADO |

---

## Integrações Externas

O sistema não possui integrações externas (APIs, web services, etc.). Todas as dependências são locais:

| Tipo | Componente | Propósito | Confiança |
|------|------------|-----------|-----------|
| **Banco de Dados** | Microsoft Access (.mdb) | Persistência de dados | 🟢 CONFIRMADO |
| **Relatórios** | Crystal Reports Engine | Geração de relatórios | 🟢 CONFIRMADO |
| **Runtime VB6** | MSVBVM60.DLL | Execução de código VB6 | 🟢 CONFIRMADO |
| **Controles OCX** | 12 controles ActiveX | Interface gráfica | 🟢 CONFIRMADO |

---

## Fluxo de Dados Principais

### Fluxo de Locação

```
Cliente selecionado → Verifica status ativo
                         ↓
CD selecionado → Verifica disponibilidade
                         ↓
Tipo de locação → Calcula data prevista e valor
                         ↓
Grava locação → Atualiza estado do CD
                         ↓
Emite recibo → Exibe para impressão
```

### Fluxo de Devolução

```
Recibo selecionado → Verifica se pendente
                         ↓
Data de devolução → Compara com data prevista
                         ↓
Se atrasado → Calcula multa (🔴 não encontrado código)
                         ↓
Baixa recibo → Atualiza estado do CD
                         ↓
Exibe recibo final
```

---

## Dívidas Técnicas

| Dívida | Severidade | Descrição | Impacto |
|--------|------------|-----------|---------|
| **Criptografia XOR** | 🔴 CRÍTICA | Senha armazenada com XOR reversível | 🔴 Qualquer pessoa com acesso ao banco pode ler a senha |
| **Sem Camada de Negócio** | 🟡 ALTA | Lógica misturada com apresentação | 🟡 Dificulta manutenção e testes |
| **Falta de Transações** | 🟡 ALTA | Atualizações diretas sem controle de rollback | 🟡 Pode causar inconsistência em caso de erro |
| **Cálculo de Multa** | 🔴 CRÍTICA | Código não encontrado explicitamente | 🔴 Sistema pode não cobrar multas por atraso |
| **Sem Auditoria** | 🔴 CRÍTICA | Não há registro de ações por usuário | 🔴 Impossível investigar uso indevido |
| **Dependências Obsoletas** | 🔴 CRÍTICA | VB6, DAO 2.5, Crystal Reports antigos | 🔴 Difícil executar em Windows modernos |
| **Controles 3D (Sheridan)** | 🟡 ALTA | THREED32.OCX de terceiros | 🟡 Pode não estar disponível em instalações modernas |
| **Sem Validação de Data** | 🟡 MÉDIA | Não valida se data de nascimento é válida | 🟡 Pode aceitar datas impossíveis |

---

## Segurança

| Aspecto | Estado | Avaliação |
|---------|--------|-----------|
| **Autenticação** | Senha única global | 🔴 Fraco |
| **Criptografia de Senha** | XOR (reversível) | 🔴 Muito fraco |
| **Controle de Sessão** | Não existe | 🔴 Ausente |
| **RBAC** | Não existe | 🔴 Ausente |
| **Logs de Auditoria** | Não existem | 🔴 Ausente |
| **Validação de Entrada** | Básica (IsDate, IsNumeric) | 🟡 Parcial |
| **Injeção de SQL** | Risco baixo (DAO parametrizado) | 🟢 Baixo risco |

---

## Limitações do Sistema

| Limitação | Descrição | Confiança |
|-----------|-----------|-----------|
| **Single User** | Apenas um usuário por estação, banco local | 🟢 CONFIRMADO |
| **Sem Conciliação** | Não há controle de concorrência | 🟢 CONFIRMADO |
| **Sem Backup Automático** | Backup deve ser feito manualmente | 🟡 INFERIDO |
| **Limitação de Senha** | Máximo 10 caracteres | 🟢 CONFIRMADO |
| **Sem Validação de CPF** | CPF aceito sem validação de dígito | 🟡 INFERIDO |
| **Sem Limite de CDs** | Não há limite de CDs por locação | 🟡 INFERIDO |

---

## Próximos Passos para Modernização

| Prioridade | Ação | Motivo |
|------------|------|--------|
| 1 | Implementar hash de senha (SHA-256) | Segurança crítica |
| 2 | Migrar para arquitetura 3-tier (apresentação, negócio, dados) | Manutenibilidade |
| 3 | Substituir DAO por ORM ou ADO.NET | Obsolescência |
| 4 | Implementar RBAC | Segurança |
| 5 | Adicionar logs de auditoria | Rastreabilidade |
| 6 | Implementar controle de transações | Consistência de dados |
| 7 | Validar código de cálculo de multa | Lacuna funcional |

---

## Diagramas Relacionados

- **C4 Contexto:** `c4-context.md`
- **C4 Containers:** `c4-containers.md`
- **C4 Components:** `c4-components.md`
- **ERD Completo:** `erd-complete.md`
- **Spec Impact Matrix:** `traceability/spec-impact-matrix.md`
