# CORREÇÕES FRONTEND → API

## Data: 2026-05-16

---

## 🐛 Problema: Erro 404 ao Salvar Cliente

**Relatado:** "Ao tentar gravar Nome e Endereço do cliente aparece: 404 Not Found"

**Causa Raiz:** O frontend estava configurado para acessar `http://app:8000` (nome do container Docker) em vez de `http://localhost:8001` (URL acessível do navegador).

---

## ✅ Solução Aplicada

### 1. Dockerfile do Frontend

**Antes:**
```dockerfile
FROM node:20 AS builder
WORKDIR /app
...
RUN npm run build
```

**Depois:**
```dockerfile
FROM node:20 AS builder

# Set build argument for API URL
ARG VITE_API_URL=http://localhost:8001
ENV VITE_API_URL=${VITE_API_URL}

WORKDIR /app
...
RUN npm run build
```

### 2. docker-compose.yml

**Antes:**
```yaml
frontend:
  build:
    context: ./frontend
    dockerfile: Dockerfile
  environment:
    - VITE_API_URL=http://app:8000  # ❌ Runtime, não funciona
```

**Depois:**
```yaml
frontend:
  build:
    context: ./frontend
    dockerfile: Dockerfile
    args:
      - VITE_API_URL=http://localhost:8001  # ✅ Build time
```

### 3. Comandos Executados

```bash
# Parar frontend antigo
docker-compose down frontend

# Reconstruir com nova configuração
docker-compose up -d --build frontend

# Verificar novo bundle JS
curl -s http://localhost:3001/assets/index-*.js | grep "8001"
# Resultado: 8001 ✅
```

---

## 🧪 Como Verificar se Funciona

### Teste 1: Verificar Arquivo JS

```bash
curl -s "http://localhost:3001/" | grep -o 'src="[^"]*js"'
# Deve mostrar: src="/assets/index-Ct-gnyfK.js" (nome pode variar)

curl -s "http://localhost:3001/assets/index-Ct-gnyfK.js" | grep "8001"
# Deve mostrar: 8001
```

### Teste 2: Verificar API Diretamente

```bash
curl http://localhost:8001/customers
# Deve mostrar lista de clientes em JSON
```

### Teste 3: Teste no Navegador

1. Acesse: http://localhost:3001
2. Abra Console (F12)
3. Vá para aba "Network"
4. Clique em "Novo Cliente"
5. Preencha formulário
6. Clique "Salvar"

**No Network deve aparecer:**
- `POST http://localhost:8001/customers`
- Status: 201 Created

---

## 📊 URLs Configuradas

| Ambiente | URL |
|-----------|-----|
| Frontend (navegador) | http://localhost:3001 |
| API (navegador → container) | http://localhost:8001 |
| API (container → container) | http://app:8000 (Docker network) |
| PostgreSQL | localhost:5434 |

---

## 🔧 Troubleshooting

### Se ainda der 404:

1. **Limpar cache do navegador:**
   - Ctrl+Shift+R (hard reload)
   - Ou abrir em aba anônima

2. **Verificar Console do Navegador (F12):**
   ```javascript
   // Console deve mostrar:
   API Request: POST http://localhost:8001/customers
   ```

3. **Verificar Network do Navegador (F12):**
   - Procurar por requisições falhando
   - Ver qual URL está sendo chamada

4. **Verificar se containers estão rodando:**
   ```bash
   docker ps | grep -E "frontend|app"
   ```

5. **Reconstruir frontend:**
   ```bash
   docker-compose up -d --build frontend
   ```

---

## 📝 Importante: Build Time vs Runtime

**VITE_API_URL** é uma variável de **build time**, não **runtime**:

❌ **Não funciona (runtime):**
```yaml
environment:
  - VITE_API_URL=http://localhost:8001  # Ignorado!
```

✅ **Funciona (build time):**
```yaml
build:
  args:
    - VITE_API_URL=http://localhost:8001  # Aplicado durante build
```

Isso porque o Vite substitui a variável durante o build do bundle JS, não em runtime.

---

## 🎯 Status Final

✅ Frontend reconstruído com URL correta  
✅ API acessível em http://localhost:8001  
✅ Formulário de clientes expandido (10 campos)  
✅ Máscaras aplicadas (CEP, telefone)  
✅ Validações implementadas  
✅ Tratamento de erros melhorado  

**PRONTO PARA TESTES!**

---

**Próximo passo:** Testar o cadastro de cliente no navegador seguindo as instruções acima.
