# Navegação — CDsLoc

> Estrutura de rotas, menus e navegação da aplicação CDsLoc.

---

## 1. Estrutura de Rotas

### 1.1 Árvore de Rotas

```
/                           → Landing/Login
/auth
  /login                   → Login
  /logout                  → Logout (redireciona para /)

/dashboard                  → Dashboard

/clients
  /                         → Lista de clientes (com busca)
  /new                      → Novo cliente
  /:id                      → Detalhes/edição do cliente
  /:id/dependents           → Gerenciar dependentes do cliente

/catalog
  /                         → Catálogo geral (títulos, CDs)
  /titles                   → Lista de títulos
  /titles/new               → Novo título
  /titles/:id               → Detalhes/edição do título
  /cds                      → Lista de CDs físicos
  /cds/new                 → Novo CD físico
  /cds/:id                 → Detalhes/edição do CD
  /interpreters             → Lista de intérpretes
  /groups                  → Lista de grupos musicais
  /styles                  → Lista de estilos musicais
  /music                   → Lista de músicas

/rentals
  /                         → Lista de locações
  /new                      → Nova locação
  /:id                      → Detalhes da locação
  /:id/return              → Devolução de locação
  /receipts                 → Lista de recibos
  /receipts/:id             → Detalhes/impressão do recibo

/reservations
  /                         → Lista de reservas
  /new                      → Nova reserva
  /:id                      → Detalhes da reserva
  /:id/convert              → Converter reserva em locação

/queries                    → Consultas avançadas

/reports
  /                         → Lista de relatórios disponíveis
  /clients                  → Relatório de clientes
  /cds                      → Relatório de CDs
  /rentals                  → Relatório de locações
  /reservations             → Relatório de reservas
  /financial                → Relatório financeiro

/settings
  /                         → Configurações gerais
  /neighborhoods            → Tabela de bairros
  /neighborhoods/new        → Novo bairro
  /municipalities          → Tabela de municípios
  /municipalities/new      → Novo município
  /interpreters             → Tabela de intérpretes
  /interpreters/new         → Novo intérprete
  /groups                  → Tabela de grupos
  /groups/new              → Novo grupo
  /styles                  → Tabela de estilos
  /styles/new              → Novo estilo
```

---

## 2. Estrutura de Menus

### 2.1 Menu Principal (Sidebar)

```
┌─────────────────────────────────────┐
│  🏠 Dashboard                     │
├─────────────────────────────────────┤
│  👥 Clientes                      │
│  📀 Catálogo                      │
│  📥 Locações                     │
│  📅 Reservas                     │
│  🔍 Consultas                    │
│  📊 Relatórios                   │
├─────────────────────────────────────┤
│  ⚙️ Configurações                 │
├─────────────────────────────────────┤
│  👤 Usuário                      │
│  🚪 Sair                         │
└─────────────────────────────────────┘
```

### 2.2 Menu Clientes (Submenu)

```
┌─────────────────────────────────────┐
│  👥 Clientes            ▼         │
│     • Listar todos                 │
│     • Novo cliente               │
│     • Clientes cancelados         │
│     • Pesquisar                   │
└─────────────────────────────────────┘
```

### 2.3 Menu Catálogo (Submenu)

```
┌─────────────────────────────────────┐
│  📀 Catálogo            ▼         │
│     • Títulos                     │
│     • CDs Físicos                 │
│     • Intérpretes                │
│     • Grupos musicais             │
│     • Estilos musicais            │
│     • Músicas                    │
└─────────────────────────────────────┘
```

### 2.4 Menu Locações (Submenu)

```
┌─────────────────────────────────────┐
│  📥 Locações            ▼         │
│     • Nova locação                │
│     • Locações ativas             │
│     • Histórico                   │
│     • Devoluções pendentes        │
│     • Recibos                    │
└─────────────────────────────────────┘
```

### 2.5 Menu Relatórios (Submenu)

```
┌─────────────────────────────────────┐
│  📊 Relatórios          ▼         │
│     • Clientes                    │
│     • CDs                         │
│     • Locações                    │
│     • Reservas                    │
│     • Financeiro                  │
│     • Movimentações               │
└─────────────────────────────────────┘
```

### 2.6 Menu Configurações (Submenu)

```
┌─────────────────────────────────────┐
│  ⚙️ Configurações       ▼         │
│     • Bairros                     │
│     • Municípios                  │
│     • Intérpretes                │
│     • Grupos                      │
│     • Estilos                     │
│     • Usuários                   │
└─────────────────────────────────────┘
```

---

## 3. Breadcrumbs

Para telas com mais de 2 níveis de profundidade, mostrar breadcrumb:

```
Home > Clientes > Novo Cliente
Home > Catálogo > Títulos > Detalhes
Home > Locações > Nova Locação
Home > Relatórios > Locações > Filtros
```

---

## 4. Layouts

### 4.1 AuthLayout

Usado em `/auth/*`
- Sem sidebar
- Sem header
- Conteúdo centralizado verticalmente
- Background com gradiente

### 4.2 MainLayout

Usado em todas as telas autenticadas
- Sidebar fixo à esquerda (desktop) / drawer (mobile)
- Header fixo no topo
- Área de conteúdo com scroll
- Toast container no canto superior direito

```
┌─────────────────────────────────────────────────────────────┐
│  Header (logo, busca global, usuário)                    │
├──────────┬──────────────────────────────────────────────────┤
│          │  Breadcrumb (quando aplicável)               │
│  Sidebar │                                                  │
│          │  Conteúdo da página                               │
│  (Menu) │                                                  │
│          │                                                  │
└──────────┴──────────────────────────────────────────────────┘
```

### 4.3 EmptyLayout

Usado em páginas públicas (landing, etc.)
- Sem sidebar
- Sem header
- Conteúdo em tela cheia

---

## 5. Mapeamento Legado → Novo

| Menu Legado | Rota Nova | Confiança |
|-------------|-----------|-----------|
| frmPainel (splash) | `/` (landing/login) | 🟢 CONFIRMADO |
| cliente.frm (aba Clientes) | `/clients` | 🟢 CONFIRMADO |
| cliente.frm (aba Dependentes) | `/clients/:id/dependents` | 🟢 CONFIRMADO |
| tabelas.frm (aba Intérprete) | `/settings/interpreters` | 🟢 CONFIRMADO |
| tabelas.frm (aba Grupo) | `/settings/groups` | 🟢 CONFIRMADO |
| tabelas.frm (aba Estilo) | `/settings/styles` | 🟢 CONFIRMADO |
| tabelas.frm (aba Bairro) | `/settings/neighborhoods` | 🟢 CONFIRMADO |
| tabelas.frm (aba Município) | `/settings/municipalities` | 🟢 CONFIRMADO |
| reservcd.frm | `/reservations/new` | 🟢 CONFIRMADO |
| frmConsulta.frm | `/queries` | 🟢 CONFIRMADO |
| (não encontrado) | `/dashboard` | 🟡 INFERIDO |
| (não encontrado) | `/catalog` | 🟡 INFERIDO |
| (não encontrado) | `/rentals` | 🟡 INFERIDO |
| (não encontrado) | `/reports` | 🟡 INFERIDO |

---

## 6. Guards de Rota

### 6.1 AuthGuard

- Protege todas as rotas exceto `/auth/*`
- Verifica presença de token válido
- Redireciona para `/auth/login` se não autenticado

### 6.2 PermissionGuard

- Protege rotas baseadas em permissões do usuário
- Exemplo: `/settings/users` requer permissão `admin`
- Exibe 403 se sem permissão

---

## 7. Redirecionamentos

| De | Para | Condição |
|----|-----|----------|
| `/` | `/dashboard` | Usuário autenticado |
| `/` | `/auth/login` | Usuário não autenticado |
| `/auth/login` | `/dashboard` | Usuário já autenticado |
| `/auth/logout` | `/auth/login` | Após logout bem-sucedido |
| `/clients/new` | `/clients` | Após salvar com sucesso |
| `/reservations/new` | `/reservations` | Após salvar com sucesso |

---

## 8. Padrões de Navegação

### 8.1 Ações de CRUD

| Ação | Navegação | Confiança |
|-------|-----------|-----------|
| Criar | `/resource/new` → `/resource` (após salvar) | 🟡 INFERIDO |
| Editar | `/resource` → abrir modal de edição | 🟡 INFERIDO |
| Excluir | Confirmar em modal → permanecer na lista | 🟡 INFERIDO |
| Ver detalhes | `/resource/:id` | 🟡 INFERIDO |

### 8.2 Padrão de Voltar

- Botão "Voltar" na parte superior da tela
- Usa `router.back()` quando disponível
- Fallback para rota pai quando não há histórico

---

## 9. Links de Acesso Rápido (Home)

Na página `/dashboard`, exibir cards de acesso rápido:

```
┌─────────────────────────────────────────────────────────────┐
│  Acesso Rápido                                           │
├─────────────────────────────────────────────────────────────┤
│  [👥 Novo Cliente]  [📥 Nova Locação]                │
│  [📅 Nova Reserva]  [🔍 Consultar CDs]                  │
└─────────────────────────────────────────────────────────────┘
```

---

## 10. Estado Global da Navegação

```typescript
interface NavigationState {
  sidebarOpen: boolean;        // Sidebar aberto/fechado
  breadcrumbs: Breadcrumb[];   // Breadcrumbs atuais
  activeRoute: string;         // Rota ativa
  previousRoute: string | null; // Rota anterior (para voltar)
}
```

---

## 11. SEO e Meta Tags (caso aplicável)

Para páginas públicas (landing, etc.):

```html
<title>CDsLoc - Sistema de Locação de CDs</title>
<meta name="description" content="Sistema completo para gestão de locação de CDs musicais" />
<meta name="keywords" content="locação, cds, música, aluguel" />
```

---

## 12. PWA (Progressive Web App)

Considerar implementar PWA para:
- Funcionamento offline (cache de assets)
- Instalação como app nativo
- Push notifications (para lembretes de devolução)

---

## 13. Status de Confiança

🟢 **CONFIRMADO** — Baseado nos formulários legado (.frm)
🟡 **INFERIDO** — Baseado em padrões modernos de UX
🔴 **LACUNA** — Requer decisão humana
