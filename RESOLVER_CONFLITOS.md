# Como Executar o Sistema CDsLoc (Conflitos Resolvidos)

> Guia para executar o sistema CDsLoc com portas alternativas e PostgreSQL compartilhado.

---

## ✅ Conflitos Resolvidos

### Portas Alternativas

| Serviço | Porta Original | Porta Alternativa | Motivo |
|---------|---------------|-------------------|--------|
| Backend API (FastAPI) | 8000 | **8001** | Conflito com backend existente |
| Frontend (React) | 3000 | **3001** | Conflito com frontend existente |
| PostgreSQL (container) | 5432 | **5433** | Conflito com postgres existente |
| Redis | 6379 | **6380** | Conflito com redis existente (rag-redis, zazus_redis) |

### PostgreSQL Compartilhado

O sistema está configurado para usar o **PostgreSQL existente** (porta 5432) no database `cdsloc`.

**Connection String:**
```
postgresql+asyncpg://postgres:postgres@host.docker.internal:5432/cdsloc
```

---

## 🚀 Como Executar

### Opção 1: Usar PostgreSQL Existente (Recomendado)

Esta opção usa o PostgreSQL que já está rodando na porta 5432, com o database `cdsloc` que você já migrou.

```bash
# 1. Iniciar apenas os serviços necessários (sem postgres container)
docker compose up -d redis app

# 2. Verificar se os containers estão rodando
docker compose ps

# 3. Acessar a API
curl http://localhost:8001/health
```

**Portas usadas:**
- API: `http://localhost:8001`
- Redis: `localhost:6380`

---

### Opção 2: Usar PostgreSQL Próprio (Se não quiser compartilhar)

Esta opção usa um PostgreSQL separado para o CDsLoc (porta 5433).

```bash
# 1. Iniciar todos os serviços (incluindo postgres)
docker compose up -d

# 2. Verificar se os containers estão rodando
docker compose ps

# 3. Acessar a API
curl http://localhost:8001/health
```

**Portas usadas:**
- API: `http://localhost:8001`
- PostgreSQL: `localhost:5433`
- Redis: `localhost:6380`

---

## 🔧 Configuração

### Variáveis de Ambiente

O arquivo `.env.example` já está configurado com as portas alternativas:

```bash
# Copiar .env.example para .env
cp .env.example .env

# Editar .env se necessário
# DATABASE_URL=postgresql+asyncpg://postgres:postgres@host.docker.internal:5432/cdsloc
# REDIS_URL=redis://localhost:6380/0
```

### Connection String para PostgreSQL Existente

No `.env`, configure:

```bash
DATABASE_URL=postgresql+asyncpg://postgres:postgres@host.docker.internal:5432/cdsloc
```

**Nota:** `host.docker.internal` permite que o container Docker resolva o IP da máquina host.

---

## 📦 Comandos Úteis

### Iniciar Serviços

```bash
# Iniciar com PostgreSQL existente
docker compose up -d redis app

# Iniciar com PostgreSQL próprio
docker compose up -d
```

### Parar Serviços

```bash
# Parar todos os serviços
docker compose down

# Parar apenas app e redis
docker compose stop app redis
```

### Verificar Logs

```bash
# Logs de todos os serviços
docker compose logs

# Logs específicos
docker compose logs app
docker compose logs redis
```

### Acessar o Banco de Dados

```bash
# Usando PostgreSQL existente (porta 5432)
docker exec -it postgres psql -U postgres -d cdsloc

# Usando PostgreSQL próprio (porta 5433)
docker exec -it cdsloc-postgres psql -U cdsloc -d cdsloc
```

---

## 🌐 Acessar o Sistema

### API REST

```
http://localhost:8001
```

- Swagger UI: `http://localhost:8001/docs`
- ReDoc: `http://localhost:8001/redoc`
- Health Check: `http://localhost:8001/health`

### Frontend (se criado)

```
http://localhost:3001
```

---

## ⚠️ Solução de Problemas

### Erro: "port is already allocated"

**Causa:** A porta já está em uso por outro serviço.

**Solução:**
- Verificar quais portas estão em uso: `netstat -ano | findstr :8001`
- Parar o serviço conflitante: `docker stop backend` (se não estiver usando)

### Erro: "connection refused" ao conectar no PostgreSQL

**Causa:** Connection string incorreta ou PostgreSQL não está rodando.

**Solução:**
- Verificar se PostgreSQL está rodando: `docker ps | grep postgres`
- Testar conexão: `docker exec -it postgres psql -U postgres -d cdsloc`
- Verificar se database `cdsloc` existe: `\l` no psql

### Erro: "Cannot connect to Redis"

**Causa:** Redis não está rodando ou porta incorreta.

**Solução:**
- Verificar se Redis está rodando: `docker ps | grep redis`
- Verificar porta: `docker ps | grep 6380`

---

## 📝 Resumo

✅ **Conflitos resolvidos:**
- Backend: 8000 → 8001
- Frontend: 3000 → 3001
- PostgreSQL (container): 5432 → 5433
- Redis: 6379 → 6380

✅ **PostgreSQL compartilhado configurado:**
- Database: `cdsloc`
- Porta: 5432 (existente)
- Connection string: `postgresql+asyncpg://postgres:postgres@host.docker.internal:5432/cdsloc`

🚀 **Pronto para executar:**
```bash
docker compose up -d redis app
curl http://localhost:8001/health
```
