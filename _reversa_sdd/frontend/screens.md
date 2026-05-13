# Telas — CDsLoc

> Especificação detalhada de todas as telas da aplicação CDsLoc.

---

## 1. Login (`/auth/login`)

### Layout
```
┌─────────────────────────────────────────────────────────────┐
│                                                             │
│            [Logo CDsLoc]                                  │
│                                                             │
│          Bem-vindo ao CDsLoc                              │
│                                                             │
│  ┌─────────────────────────────────────┐                   │
│  │ Usuário                          │                   │
│  └─────────────────────────────────────┘                   │
│                                                             │
│  ┌─────────────────────────────────────┐                   │
│  │ Senha          [👁️]             │                   │
│  └─────────────────────────────────────┘                   │
│                                                             │
│  [☐ Lembrar-me]   Esqueci minha senha                      │
│                                                             │
│              [  Entrar  ]                                  │
│                                                             │
└─────────────────────────────────────────────────────────────┘
```

### Campos
| Campo | Tipo | Validação | Confiança |
|-------|------|-----------|-----------|
| Usuário | Text | Obrigatório, min 3 caracteres | 🟡 INFERIDO |
| Senha | Password | Obrigatório, min 6 caracteres | 🟡 INFERIDO |

### Ações
| Botão | Ação |
|--------|------|
| Entrar | Autenticar usuário, redirecionar para `/dashboard` |
| Esqueci minha senha | Abrir modal de recuperação (tbd) |

### Atalhos
- `Enter` — Submeter formulário

---

## 2. Dashboard (`/dashboard`)

### Layout
```
┌─────────────────────────────────────────────────────────────┐
│  🏠 Dashboard                                              │
├─────────────────────────────────────────────────────────────┤
│  Acesso Rápido                                           │
│  ┌──────────┐  ┌──────────┐  ┌──────────┐             │
│  │👥 Cliente│  │📥 Locação│  │📅 Reserva│             │
│  └──────────┘  └──────────┘  └──────────┘             │
│                                                             │
│  Estatísticas                                            │
│  ┌─────────────────────────────────────────────────────────┐│
│  │ 📚 CDs Cadastrados        1,234                       ││
│  │ 👥 Clientes Ativos         456                        ││
│  │ 📥 Locações Hoje          23                         ││
│  │ 📅 Reservas Pendentes     12                         ││
│  └─────────────────────────────────────────────────────────┘│
│                                                             │
│  Locações em Atraso                                     │
│  ┌─────────────────────────────────────────────────────────┐│
│  │ Cliente          | Título     | Data Dev.  | Atraso    ││
│  │ João Silva      | Thriller   | 10/05/2026 | 2 dias   ││
│  │ Maria Santos    | Pop        | 09/05/2026 | 3 dias   ││
│  └─────────────────────────────────────────────────────────┘│
└─────────────────────────────────────────────────────────────┘
```

### Componentes
- Cards de estatísticas com ícones e números
- Tabela de locações em atraso (top 5)
- Gráfico de locações por dia (últimos 7 dias)

---

## 3. Lista de Clientes (`/clients`)

### Layout
```
┌─────────────────────────────────────────────────────────────🔍─┐
│  👥 Clientes                                  [Buscar...]  │
├─────────────────────────────────────────────────────────────┤
│  Filtros                                                │
│  ☐ Apenas ativos  ☐ Apenas cancelados                    │
│  [🔽] Ordenar por: Nome ▼                              │
│                                                         │
│  ┌─────────────────────────────────────────────────────────┐│
│  │ [+ Novo Cliente]                                      ││
│  └─────────────────────────────────────────────────────────┘│
│                                                         │
│  ┌─────────────────────────────────────────────────────────┐│
│  │ Código │ Nome          │ Situação │ Ações             ││
│  ├─────────┼───────────────┼──────────┼───────────────────┤│
│  │ 000001  │ João Silva   │ [● Ativo]│ [✏️] [🗑️]       ││
│  │ 000002  │ Maria Santos │ [● Ativo]│ [✏️] [🗑️]       ││
│  │ 000003  │ Pedro Costa  │ [◌ Cancel]│ [✏️] [🗑️]       ││
│  └─────────────────────────────────────────────────────────┘│
│                                            [1][2][3]...  │
└─────────────────────────────────────────────────────────────┘
```

### Colunas da Tabela
| Coluna | Largura | Alinhamento | Confiança |
|--------|---------|-------------|-----------|
| Código | 80px | Centro | 🟢 CONFIRMADO |
| Nome | 250px | Esquerda | 🟢 CONFIRMADO |
| Situação | 100px | Centro | 🟢 CONFIRMADO |
| Ações | 120px | Centro | 🟡 INFERIDO |

### Filtros
- Busca por nome (F10 no legado)
- Status: Ativo/Cancelado
- Ordenação: Nome, Código, Data Cadastro

### Ações
| Botão | Ação | Atalho |
|--------|------|--------|
| [+ Novo Cliente] | Navegar para `/clients/new` | Ctrl+N |
| [Buscar...] | Filtro por nome | F10 |
| [✏️] | Navegar para `/clients/:id` | Ctrl+E |
| [🗑️] | Abrir modal de confirmação de exclusão | Ctrl+D |

---

## 4. Novo/Editar Cliente (`/clients/new`, `/clients/:id`)

### Layout (Baseado em cliente.frm)
```
┌─────────────────────────────────────────────────────────────┐
│  👥 Cliente                              [Cancelar] [Salvar]│
├─────────────────────────────────────────────────────────────┤
│  [ Dados Pessoais ] [ Dados Comerciais ] [ Dependentes ]│
├─────────────────────────────────────────────────────────────┤
│  Dados Pessoais                                        │
│  ┌─────────────────────────────────────────────────────────┐│
│  │ Código: [000001  ]   Nome: [João Silva__________]   ││
│  │ (autogerado)          (F10 para pesquisar)          ││
│  │                                                         ││
│  │ Data Nasc: [__/__/____]  Bairro: [Centro     ▼]    ││
│  │ CEP:       [_____-___]  Munic: [São Paulo___]       ││
│  │ Endereço:  [Rua Exemplo, 123_____________________]    ││
│  │                                                         ││
│  │ CPF:        [___.___.___-__]   Tel: [____-____]     ││
│  │ Identidade: [1234567890_     ]   Ramal: [___]       ││
│  │ Expedidor:  [SSP_______]      Data: [__/__/____]     ││
│  └─────────────────────────────────────────────────────────┘│
│                                                         │
│  Situação: ◉ Ativo  ◌ Cancelado                         │
└─────────────────────────────────────────────────────────────┘
```

### Campos (Aba Dados Pessoais)
| Campo | Tipo | Máscara | Obrigatório | Confiança |
|-------|------|---------|-------------|-----------|
| Código | Text | 000000 | Não (autogerado) | 🟢 CONFIRMADO |
| Nome | Text | - | Sim | 🟢 CONFIRMADO |
| Data Nascimento | Data | dd/MM/yyyy | Sim | 🟢 CONFIRMADO |
| Endereço | Text | - | Sim | 🟢 CONFIRMADO |
| Bairro | Select | - | Sim | 🟢 CONFIRMADO |
| Município | Text | - | Não (auto) | 🟢 CONFIRMADO |
| CEP | Text | #####-### | Não | 🟢 CONFIRMADO |
| CPF | Text | ###.###.###-## | Não | 🟢 CONFIRMADO |
| Identidade | Text | - | Sim | 🟢 CONFIRMADO |
| Expedidor | Text | - | Não | 🟢 CONFIRMADO |
| Data Expedição | Data | dd/MM/yyyy | Não | 🟢 CONFIRMADO |
| Telefone Residencial | Text | ####-#### | Não | 🟢 CONFIRMADO |
| Ramal Residencial | Text | - | Não | 🟢 CONFIRMADO |
| Situação | Radio | - | Sim | 🟢 CONFIRMADO |

### Campos (Aba Dados Comerciais)
| Campo | Tipo | Obrigatório | Confiança |
|-------|------|-------------|-----------|
| Empresa | Text | Não | 🟢 CONFIRMADO |
| Endereço Comercial | Text | Não | 🟢 CONFIRMADO |
| Telefone Comercial | Text | ####-#### | Não | 🟢 CONFIRMADO |
| Ramal Trabalho | Text | Não | 🟢 CONFIRMADO |

### Campos (Aba Referência Pessoal)
| Campo | Tipo | Obrigatório | Confiança |
|-------|------|-------------|-----------|
| Nome Referência | Text | Não | 🟢 CONFIRMADO |
| Telefone Referência | Text | ####-#### | Não | 🟢 CONFIRMADO |

### Campos (Aba Observações)
| Campo | Tipo | Obrigatório | Confiança |
|-------|------|-------------|-----------|
| Observações | TextArea | Não | 🟢 CONFIRMADO |
| Data Inscrição | Date | dd/MM/yyyy | Não (auto) | 🟢 CONFIRMADO |

### Validações
- Nome: máximo 50 caracteres
- Data Nascimento: data válida, menor que hoje
- CPF: formato válido
- Campos obrigatórios: Nome, Endereço, Data Nasc, Bairro, Identidade

### Atalhos
- `F10` (no Nome) — Abrir pesquisa de clientes
- `Enter` — Navegar para próximo campo
- `Ctrl+S` — Salvar
- `Esc` — Cancelar

---

## 5. Dependentes do Cliente (`/clients/:id/dependents`)

### Layout
```
┌─────────────────────────────────────────────────────────────┐
│  👥 Clientes > João Silva > Dependentes  [Voltar]        │
├─────────────────────────────────────────────────────────────┤
│  Cliente: João Silva (000001)                            │
│                                                         │
│  ┌─────────────────────────────────────────────────────────┐│
│  │ [+ Novo Dependente]                                  ││
│  └─────────────────────────────────────────────────────────┘│
│                                                         │
│  ┌─────────────────────────────────────────────────────────┐│
│  │ Código │ Nome Dependente │ Ações                       ││
│  ├─────────┼─────────────────┼─────────────────────────────┤│
│  │ 001    │ Maria Silva     │ [✏️] [🗑️]                ││
│  │ 002    │ Pedro Silva    │ [✏️] [🗑️]                ││
│  └─────────────────────────────────────────────────────────┘│
└─────────────────────────────────────────────────────────────┘
```

### Campos (Modal de Dependente)
| Campo | Tipo | Máximo | Obrigatório | Confiança |
|-------|------|--------|-------------|-----------|
| Nome | Text | 50 | Sim | 🟢 CONFIRMADO |

---

## 6. Catálogo de Títulos (`/catalog/titles`)

### Layout
```
┌─────────────────────────────────────────────────────────────🔍─┐
│  📀 Catálogo > Títulos                     [Buscar...]  │
├─────────────────────────────────────────────────────────────┤
│  Filtros                                                │
│  Intérprete: [________ ▼]  Grupo: [________ ▼]         │
│  Estilo:     [________ ▼]                                │
│  ☐ Apenas disponíveis  ☐ Apenas locados                 │
│                                                         │
│  ┌─────────────────────────────────────────────────────────┐│
│  │ [+ Novo Título]                                      ││
│  └─────────────────────────────────────────────────────────┘│
│                                                         │
│  ┌─────────────────────────────────────────────────────────┐│
│  │ Código │ Título       │ Intérprete │ Estilo │ CDs │ Ações│
│  ├─────────┼───────────────┼────────────┼────────┼─────┼───────┤│
│  │ 000001 │ Thriller     │ Michael J. │ Pop   │ 3/5 │ [👁️] ││
│  │ 000002 │ Bad          │ Michael J. │ Pop   │ 5/5 │ [👁️] ││
│  └─────────────────────────────────────────────────────────┘│
└─────────────────────────────────────────────────────────────┘
```

---

## 7. Nova Locação (`/rentals/new`)

### Layout
```
┌─────────────────────────────────────────────────────────────┐
│  📥 Nova Locação                      [Cancelar] [Gerar]│
├─────────────────────────────────────────────────────────────┤
│  [ Cliente ] [ CDs ] [ Resumo ]                         │
├─────────────────────────────────────────────────────────────┤
│  Cliente                                                │
│  ┌─────────────────────────────────────────────────────────┐│
│  │ Código: [000001  ]   Nome: [João Silva__________]   ││
│  │ (F10 para pesquisar)                                ││
│  │                                                         ││
│  │ Dependente: [Selecione...              ▼]            ││
│  │ Lista: [Maria Silva______________]                     ││
│  └─────────────────────────────────────────────────────────┘│
│                                                         │
│  Situação: [● Ativo]                                   │
└─────────────────────────────────────────────────────────────┘
```

### Aba CDs
```
┌─────────────────────────────────────────────────────────────┐
│  📀 CDs Disponíveis                                     │
├─────────────────────────────────────────────────────────────┤
│  Buscar CD: [Thriller______]                             │
│                                                         │
│  ┌─────────────────────────────────────────────────────────┐│
│  │ Código │ Título       │ Intérprete │ [Adicionar]    ││
│  ├─────────┼───────────────┼────────────┼─────────────────┤│
│  │ CD-01  │ Thriller     │ Michael J. │ [+ Adicionar]   ││
│  │ CD-02  │ Bad          │ Michael J. │ [+ Adicionar]   ││
│  └─────────────────────────────────────────────────────────┘│
│                                                         │
│  CDs Selecionados: 0                                     │
└─────────────────────────────────────────────────────────────┘
```

### Aba Resumo
```
┌─────────────────────────────────────────────────────────────┐
│  📋 Resumo da Locação                                 │
├─────────────────────────────────────────────────────────────┤
│  Cliente: João Silva (000001)                           │
│  Dependente: Maria Silva                                 │
│  Data Locação: 12/05/2026                               │
│  Data Devolução: 14/05/2026                              │
│                                                         │
│  Itens                                                  │
│  ┌─────────────────────────────────────────────────────────┐│
│  │ CD-01 │ Thriller  │ Michael J. │ R$ 3,00          ││
│  │ CD-02 │ Bad       │ Michael J. │ R$ 3,00          ││
│  ├─────────┼───────────┼────────────┼───────────────────┤│
│  │                                   Total: R$ 6,00   ││
│  └─────────────────────────────────────────────────────────┘│
└─────────────────────────────────────────────────────────────┘
```

---

## 8. Nova Reserva (`/reservations/new`)

### Layout (Baseado em reservcd.frm)
```
┌─────────────────────────────────────────────────────────────┐
│  📅 Nova Reserva                      [Cancelar] [Gravar]│
├─────────────────────────────────────────────────────────────┤
│  Cliente                                                │
│  ┌─────────────────────────────────────────────────────────┐│
│  │ Código: [000001  ]   Nome: [João Silva__________]   ││
│  │ (F10 para pesquisar)                                ││
│  └─────────────────────────────────────────────────────────┘│
│                                                         │
│  Título                                                │
│  ┌─────────────────────────────────────────────────────────┐│
│  │ Código: [000001  ]   Título: [Thriller_________]   ││
│  │                         (F10 para pesquisar)        ││
│  │                                                         ││
│  │ Intérprete: [Michael Jackson__________]              ││
│  │ Grupo:      [Pop_________________]                   ││
│  │ Estilo:     [Pop_________________]                   ││
│  └─────────────────────────────────────────────────────────┘│
│                                                         │
│  Data Reserva: [12/05/2026]                             │
│                                                         │
│  ⚠️ Reservas não garantem disponibilidade física          │
└─────────────────────────────────────────────────────────────┘
```

### Campos (Baseado em reservcd.frm)
| Campo | Tipo | Obrigatório | Confiança |
|-------|------|-------------|-----------|
| Código Cliente | Text | Sim | 🟢 CONFIRMADO |
| Nome Cliente | Text | Sim | 🟢 CONFIRMADO |
| Código Título | Text | Sim | 🟢 CONFIRMADO |
| Título | Text | Sim | 🟢 CONFIRMADO |
| Intérprete | Text (readonly) | Não | 🟢 CONFIRMADO |
| Grupo | Text (readonly) | Não | 🟢 CONFIRMADO |
| Estilo | Text (readonly) | Não | 🟢 CONFIRMADO |
| Data Reserva | Date | Sim | 🟢 CONFIRMADO |

### Comportamento Especial
Ao selecionar um título, exibir lista de prováveis retornos:

```
┌─────────────────────────────────────────────────────────────┐
│  🔔 Provável Retorno do Título                          │
├─────────────────────────────────────────────────────────────┤
│  Cliente 000001 - Código CD-A → 14/05/2026 → Hoje        │
│  Cliente 000005 - Código CD-B → 15/05/2026 → 2 Dias     │
└─────────────────────────────────────────────────────────────┘
```

---

## 9. Consultas Avançadas (`/queries`)

### Layout (Baseado em frmConsulta.frm)
```
┌─────────────────────────────────────────────────────────────┐
│  🔍 Consultas Avançadas                                  │
├─────────────────────────────────────────────────────────────┤
│  Tipo de Consulta: [Música ▼]                          │
│                                                         │
│  ┌─────────────────────────────────────────────────────────┐│
│  │ Tipo de Pesquisa                                     ││
│  │ ◉ Todas as Ocorrências                              ││
│  │ ◌ Palavras Exatas                                    ││
│  │ ◌ Palavra Inicial + Complemento                       ││
│  └─────────────────────────────────────────────────────────┘│
│                                                         │
│  ☐ Com Músicas (quando CD Físico)                      │
│                                                         │
│  Digite a opção de consulta: [________________]            │
│  [🔍] Pesquisar                                         │
│                                                         │
│  Resultado: Encontrou 000 registros                       │
└─────────────────────────────────────────────────────────────┘
```

### Tipos de Consulta (Baseado em frmConsulta.frm)
| Tipo | Descrição | Colunas do Resultado |
|------|-----------|---------------------|
| Música | Busca por nome da música | Música, Título, Intérprete, Estilo, Grupo, CD, Locado |
| Intérprete | Busca por nome do intérprete | Intérprete, Título, Estilo, Grupo, CD, Locado |
| Título | Busca por nome do título | Título, Intérprete, Estilo, Grupo, CD, Locado |
| Estilo | Busca por estilo musical | Título, Intérprete, Estilo, Grupo, CD, Locado |
| Grupo | Busca por grupo musical | Título, Intérprete, Estilo, Grupo, CD, Locado |
| CD Físico | Busca por código de CD | Código CD, Locado, Cod Tit, Título, Intérprete, Estilo, Grupo |

---

## 10. Tabelas Auxiliares (`/settings/*`)

### Layout (Baseado em tabelas.frm)
```
┌─────────────────────────────────────────────────────────────┐
│  ⚙️ Configurações > Bairros                              │
├─────────────────────────────────────────────────────────────┤
│  [ Bairros ] [ Grupos ] [ Estilos ] [ Intérpretes ]     │
├─────────────────────────────────────────────────────────────┤
│  ┌─────────────────────────────────────────────────────────┐│
│  │ [+ Novo Bairro]                                     ││
│  └─────────────────────────────────────────────────────────┘│
│                                                         │
│  ┌─────────────────────────────────────────────────────────┐│
│  │ Código │ Bairro        │ Município │ Ações            ││
│  ├─────────┼───────────────┼───────────┼───────────────────┤│
│  │ 001    │ Centro        │ SP        │ [✏️] [🗑️]       ││
│  │ 002    │ Mooca         │ SP        │ [✏️] [🗑️]       ││
│  └─────────────────────────────────────────────────────────┘│
└─────────────────────────────────────────────────────────────┘
```

### Campos por Tabela

#### Bairro
| Campo | Tipo | Obrigatório | Confiança |
|-------|------|-------------|-----------|
| Código | Text | Sim (autogerado) | 🟢 CONFIRMADO |
| Nome | Text | Sim | 🟢 CONFIRMADO |
| Município | Select | Sim | 🟢 CONFIRMADO |

#### Município
| Campo | Tipo | Obrigatório | Confiança |
|-------|------|-------------|-----------|
| Código | Text | Sim (autogerado) | 🟢 CONFIRMADO |
| Nome | Text | Sim | 🟢 CONFIRMADO |

#### Intérprete
| Campo | Tipo | Obrigatório | Confiança |
|-------|------|-------------|-----------|
| Código | Text | Sim (autogerado) | 🟢 CONFIRMADO |
| Nome | Text | Sim | 🟢 CONFIRMADO |

#### Grupo
| Campo | Tipo | Obrigatório | Confiança |
|-------|------|-------------|-----------|
| Código | Text | Sim (autogerado) | 🟢 CONFIRMADO |
| Nome | Text | Sim | 🟢 CONFIRMADO |

#### Estilo
| Campo | Tipo | Obrigatório | Confiança |
|-------|------|-------------|-----------|
| Código | Text | Sim (autogerado) | 🟢 CONFIRMADO |
| Nome | Text | Sim | 🟢 CONFIRMADO |

---

## 11. Modais Comuns

### 11.1 Confirmar Exclusão
```
┌─────────────────────────────────────────────────────────────┐
│  ⚠️ Confirmar Exclusão                                  │
├─────────────────────────────────────────────────────────────┤
│                                                         │
│  Deseja realmente excluir este registro?                  │
│                                                         │
│  Esta ação não pode ser desfeita.                        │
│                                                         │
│  [Cancelar]  [Excluir]                                  │
└─────────────────────────────────────────────────────────────┘
```

### 11.2 Pesquisa (F10)
```
┌─────────────────────────────────────────────────────────────┐
│  🔍 Pesquisar por Nome                                  │
├─────────────────────────────────────────────────────────────┤
│                                                         │
│  Digite o Nome/Sobrenome a ser pesquisado:             │
│  [_______________________________________________]        │
│                                                         │
│  ┌─────────────────────────────────────────────────────────┐│
│  │ Resultados                                          ││
│  ├─────────────────────────────────────────────────────────┤│
│  │ • João Silva                                        ││
│  │ • João Santos                                       ││
│  │ • Maria Silva                                       ││
│  └─────────────────────────────────────────────────────────┘│
│                                                         │
│  [Cancelar]  [Selecionar]                               │
└─────────────────────────────────────────────────────────────┘
```

---

## 12. Notificações (Toasts)

### 12.1 Sucesso
```
┌─────────────────────────────────────────────────────────────┐
│  ✅ Registro salvo com sucesso!                    [X]   │
└─────────────────────────────────────────────────────────────┘
```

### 12.2 Erro
```
┌─────────────────────────────────────────────────────────────┐
│  ❌ Erro ao salvar registro. Tente novamente.    [X]   │
└─────────────────────────────────────────────────────────────┘
```

### 12.3 Aviso
```
┌─────────────────────────────────────────────────────────────┐
│  ⚠️ O Campo [Nome] não pode ficar em branco.      [X]   │
└─────────────────────────────────────────────────────────────┘
```

### 12.4 Informação
```
┌─────────────────────────────────────────────────────────────┐
│  ℹ️ Existem 3 CÓPIAS no ACERVO.                     [X]   │
└─────────────────────────────────────────────────────────────┘
```

---

## 13. Estados de Carregamento

### 13.1 Skeleton de Tabela
```
┌─────────────────────────────────────────────────────────────┐
│  👥 Clientes                                             │
├─────────────────────────────────────────────────────────────┤
│  ═══════════╦═════════════╦══════════╦══════════════╗ │
│  ═══════════╩═════════════╩══════════╩══════════════╗ │
│  ═══════════╦═════════════╦══════════╦══════════════╗ │
│  ═══════════╩═════════════╩══════════╩══════════════╗ │
└─────────────────────────────────────────────────────────────┘
```

### 13.2 Skeleton de Card
```
┌─────────────────────────────────────────────────────────────┐
│  ══════════════════════════════════════════════════  │
│  ══════════════════════════════════════════════════  │
│  ══════════════════════════════════════════════════  │
└─────────────────────────────────────────────────────────────┘
```

---

## 14. Estados Vazios

### 14.1 Lista Vazia
```
┌─────────────────────────────────────────────────────────────┐
│  👥 Clientes                                             │
├─────────────────────────────────────────────────────────────┤
│                                                         │
│                      📭                                 │
│                                                         │
│               Nenhum cliente encontrado                    │
│                                                         │
│              [+ Adicionar Primeiro Cliente]               │
│                                                         │
└─────────────────────────────────────────────────────────────┘
```

### 14.2 Filtro Sem Resultados
```
┌─────────────────────────────────────────────────────────────┐
│  👥 Clientes                                             │
├─────────────────────────────────────────────────────────────┤
│                                                         │
│                      🔍                                 │
│                                                         │
│         Nenhum resultado para "xyz"                       │
│                                                         │
│              [Limpar Filtros]                           │
│                                                         │
└─────────────────────────────────────────────────────────────┘
```

---

## 15. Status de Confiança

🟢 **CONFIRMADO** — Baseado nos formulários legado (.frm)
🟡 **INFERIDO** — Baseado em padrões modernos de UX
🔴 **LACUNA** — Requer decisão humana
