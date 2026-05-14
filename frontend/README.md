# Frontend CDsLoc - React

Frontend React para o sistema de locação de CDs CDsLoc.

## 🚀 Stack Tecnológica

- **React 18** - Framework UI
- **Vite** - Build tool e dev server
- **TailwindCSS** - CSS framework
- **Axios** - Cliente HTTP
- **Lucide React** - Ícones
- **React Router DOM** - Roteamento

## 📁 Estrutura do Projeto

```
frontend/
├── src/
│   ├── components/       # Componentes reutilizáveis
│   │   └── Layout.jsx    # Layout com sidebar
│   ├── pages/            # Páginas principais
│   │   ├── Dashboard.jsx
│   │   ├── Catalogo.jsx
│   │   ├── Clientes.jsx
│   │   ├── Locacoes.jsx
│   │   ├── Reservas.jsx
│   │   └── Relatorios.jsx
│   ├── services/         # API client
│   │   └── api.js
│   ├── App.jsx           # App principal
│   ├── main.jsx          # Entry point
│   └── index.css         # CSS global
├── public/               # Arquivos estáticos
├── package.json          # Dependências
├── vite.config.js        # Configuração Vite
├── tailwind.config.js    # Configuração TailwindCSS
├── postcss.config.js     # Configuração PostCSS
├── Dockerfile            # Imagem Docker
└── nginx.conf            # Configuração Nginx
```

## 🛠️ Como Executar

### Desenvolvimento Local

```bash
# 1. Instalar dependências
cd frontend
npm install

# 2. Iniciar dev server
npm run dev

# 3. Acessar
# http://localhost:3001
```

### Com Docker

```bash
# 1. Construir imagem
docker build -t cdsloc-frontend ./frontend

# 2. Executar container
docker run -p 3001:3001 cdsloc-frontend

# Ou usar docker-compose
docker compose up -d frontend
```

## 📱 Páginas

### Dashboard
- Estatísticas do sistema (CDs, clientes, locações, reservas)
- Atividades recentes

### Catálogo
- Listagem de CDs com filtros
- Visualização por situação (Disponível/Locado/Reservado)

### Clientes
- CRUD de clientes
- Busca por nome
- Status (Ativo/Cancelado)

### Locações
- Listagem de locações
- Criação de novas locações
- Registro de devoluções

### Reservas
- Listagem de reservas
- Criação de reservas
- Confirmação e cancelamento

### Relatórios
- Geração de relatórios HTML/PDF
- Filtros por período
- Tipos disponíveis: clientes, CDs, locações, reservas, etc.

## 🔌 API Integration

O frontend se conecta à API FastAPI na porta 8001:

```javascript
// Configuração da API
const API_BASE_URL = 'http://localhost:8001';

// Exemplo de chamada
const cds = await api.getCDs();
```

## 🎨 Design

- **Cores**: Primary blue (#0ea5e9) com variações
- **Layout**: Sidebar fixo + conteúdo principal
- **Responsivo**: Mobile-friendly

## 📝 Notas

- O frontend usa portas alternativas (3001) para não conflitar
- A API URL é configurável via variável de ambiente `VITE_API_URL`
- As tabelas têm status coloridos para fácil identificação
