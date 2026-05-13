# Frontend Specification — CDsLoc

> Especificação completa da interface do usuário para o sistema novo de locação de CDs.
> Baseado na análise dos formulários legado (.frm) e nos fluxos de usuário documentados.

---

## Visão Geral

O sistema CDsLoc é uma aplicação web moderna para gestão de locação de CDs musicais, substituindo a aplicação desktop VB6 legada. A interface deve ser limpa, intuitiva e responsiva.

### Stack Tecnológica Sugerida

| Camada | Tecnologia | Versão |
|--------|-----------|--------|
| **Frontend Framework** | Vue.js 3 ou React 18 | Latest |
| **UI Framework** | Element Plus (Vue) ou Material-UI (React) | Latest |
| **State Management** | Pinia (Vue) ou Redux Toolkit (React) | Latest |
| **Router** | Vue Router ou React Router | Latest |
| **HTTP Client** | Axios | Latest |
| **Form Validation** | VeeValidate (Vue) ou Formik/Yup (React) | Latest |
| **Charts** | Chart.js ou ECharts | Latest |
| **Icons** | Phosphor Icons ou Heroicons | Latest |
| **CSS** | Tailwind CSS | Latest |

---

## Arquitetura de Frontend

```
┌─────────────────────────────────────────────────────────────────┐
│                        Browser Client                         │
├─────────────────────────────────────────────────────────────────┤
│  Presentation Layer (Vue/React Components)                    │
│  ├─ Layouts                                                  │
│  │  ├─ AuthLayout (login)                                    │
│  │  ├─ MainLayout (sidebar + header + content)                 │
│  │  └─ EmptyLayout (público)                                 │
│  ├─ Pages (rotas)                                             │
│  │  ├─ Auth (login)                                           │
│  │  ├─ Dashboard                                              │
│  │  ├─ Clients                                                │
│  │  ├─ Catalog (CDs, Titles, Interpreters, etc.)              │
│  │  ├─ Rentals                                                │
│  │  ├─ Reservations                                           │
│  │  ├─ Queries                                                │
│  │  ├─ Reports                                                │
│  │  └─ Settings (tabelas auxiliares)                          │
│  └─ Shared Components                                         │
│     ├─ DataGrid (tabela genérica)                             │
│     ├─ SearchInput (input com debounce)                        │
│     ├─ DatePicker (data única ou range)                        │
│     ├─ MaskedInput (CPF, telefone, CEP)                      │
│     ├─ StatusBadge (badges de status)                         │
│     ├─ ConfirmDialog (diálogos de confirmação)               │
│     └─ Toast (notificações)                                   │
├─────────────────────────────────────────────────────────────────┤
│  State Management (Pinia/Redux)                                │
│  ├─ authStore (usuário, token, permissões)                    │
│  ├─ uiStore (tema, sidebar, loading)                         │
│  └─ cacheStore (cache de queries)                             │
├─────────────────────────────────────────────────────────────────┤
│  Services Layer                                                │
│  ├─ apiClient (configuração Axios)                           │
│  ├─ authService (login, logout, refresh token)                │
│  ├─ clientsService (CRUD clientes)                            │
│  ├─ catalogService (CRUD catálogo)                           │
│  ├─ rentalsService (CRUD locações)                            │
│  └─ ... (outros serviços)                                     │
├─────────────────────────────────────────────────────────────────┤
│  HTTP Client (Axios)                                          │
└─────────────────────────────────────────────────────────────────┘
                              │
                              │ HTTP/JSON
                              ▼
┌─────────────────────────────────────────────────────────────────┐
│                      FastAPI Backend                        │
└─────────────────────────────────────────────────────────────────┘
```

---

## Mapeamento Legado → Novo

| Formulário Legado | Página Nova | Notas |
|-------------------|-------------|-------|
| frmPainel.frm | `/` (Landing/Login) | Splash screen não necessário no web |
| cliente.frm | `/clients` | Cadastro e edição de clientes |
| tabelas.frm (abas) | `/settings/*` | Tabelas auxiliares em settings |
| reservcd.frm | `/reservations/new` | Formulário de reserva |
| frmConsulta.frm | `/queries` | Consultas avançadas |
| (não encontrado) | `/rentals/new` | Locação (precisa ser criada) |
| (não encontrado) | `/catalog` | Catálogo de CDs (precisa ser criado) |

---

## Princípios de Design

1. **Consistência**: Mesmos padrões visuais em todas as telas
2. **Eficiência**: Atalhos de teclado (F10, Enter, Esc) devem ser preservados
3. **Feedback Imediato**: Validações em tempo real, carregamentos visíveis
4. **Mobile-First**: Responsivo, otimizado para tablets (uso em balcão)
5. **Acessibilidade**: WCAG 2.1 AA, suporte a leitores de tela
6. **Performance**: Lazy loading de componentes, otimização de imagens

---

## Documentação

- [Design System](./design-system.md) — Cores, tipografia, componentes base
- [Navegação](./navigation.md) — Estrutura de rotas e menus
- [Telas](./screens.md) — Especificação detalhada de cada tela

---

## Convenções de Nomenclatura

| Tipo | Convenção | Exemplo |
|------|------------|---------|
| Componentes | PascalCase | `ClientForm`, `DataGrid` |
| Composables/Services | camelCase | `useClients`, `clientService` |
| Eventos | kebab-case | `@client-saved`, `@form-submit` |
| Classes CSS | kebab-case | `.client-form`, `.status-badge` |
| Arquivos | kebab-case | `client-form.vue`, `client-service.ts` |

---

## Status de Confiança

🟢 **CONFIRMADO** — Extraído diretamente dos formulários .frm
🟡 **INFERIDO** — Baseado em padrões modernos de UX
🔴 **LACUNA** — Requer decisão humana

---

## Referências

- Formulários VB6 analisdos: `*.frm`
- User Stories: `_reversa_sdd/user-stories/`
- Target Architecture: `_reversa_sdd/migration/target_architecture.md`
