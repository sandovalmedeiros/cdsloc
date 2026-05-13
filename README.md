# CDsLoc

Sistema de Locação de CDs - Migrado de VB6/Access para Python/FastAPI/PostgreSQL.

## Stack Tecnológica

- **Linguagem**: Python 3.11+
- **Framework Web**: FastAPI 0.104+
- **Banco de Dados**: PostgreSQL 15+
- **ORM**: SQLAlchemy 2.0 (async)
- **Validação**: Pydantic v2
- **Autenticação**: JWT (python-jose) + bcrypt
- **Event Bus**: Redis 7+
- **Relatórios**: Jinja2 + WeasyPrint
- **Containerização**: Docker + docker-compose

## Arquitetura

Arquitetura Hexagonal (Ports and Adapters) com Bounded Contexts:

```
app/
├── adapters/          # Ports implementations
│   ├── api/          # FastAPI routers + Pydantic schemas
│   ├── db/           # SQLAlchemy repositories + migrations
│   └── reports/      # HTML/PDF templates
├── bounded_contexts/  # Domain boundaries
│   ├── auth/         # Autenticação e autorização
│   ├── catalog/      # Títulos, músicas, CDs
│   ├── customers/    # Clientes e dependentes
│   ├── rentals/     # Locações e devoluções
│   ├── reservations/ # Reservas
│   └── reports/     # Especificações de relatório
└── shared/           # Cross-cutting concerns
    ├── domain/       # Value objects + Domain events
    └── infrastructure/ # Config, logging, messaging
```

## Bounded Contexts

1. **Auth**: Usuários, roles, JWT tokens
2. **Catalog**: Títulos, músicas, intérpretes, CDs físicos
3. **Customers**: Clientes, dependentes, bairros, municípios
4. **Rentals**: Locações, recibos, cálculo de multa
5. **Reservations**: Reservas, conversão em locação
6. **Reports**: Relatórios HTML/PDF

## Como Executar

### Local (com Docker)

1. Copiar variáveis de ambiente:
   ```bash
   cp .env.example .env
   ```

2. Subir containers:
   ```bash
   docker-compose up -d
   ```

3. Acessar API: http://localhost:8000
   - Docs: http://localhost:8000/docs
   - Health: http://localhost:8000/health

### Local (sem Docker)

1. Criar virtual environment:
   ```bash
   python -m venv venv
   source venv/bin/activate  # Linux/Mac
   venv\Scripts\activate   # Windows
   ```

2. Instalar dependências:
   ```bash
   pip install -r requirements.txt
   ```

3. Configurar PostgreSQL e Redis (ver `.env.example`)

4. Executar:
   ```bash
   uvicorn app.main:app --reload
   ```

## Migração do Legado

Este projeto foi gerado a partir de uma análise de engenharia reversa do sistema legado (VB6 + Access).

Especificações completas em: `_reversa_sdd/migration/`

## Status da Migração

- [x] Engenharia Reversa concluída
- [x] Time de Migração concluído
- [ ] Implementação em andamento

## Licença

MIT
