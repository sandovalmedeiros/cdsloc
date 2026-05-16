# GUIA DE DEBUG - FRONTEND CLIENTES

## Data: 2026-05-16

---

## ✅ Status: API FUNCIONANDO 100%

**Via curl, todos os endpoints funcionam:**
```bash
# Criar cliente
curl -X POST http://localhost:8001/customers \
  -H "Content-Type: application/json" \
  -d '{"nomecliente":"Maria Silva","endereco":"Rua Teste","data_nascimento":"1990-01-01","cep":"12345-678","fone_01":"11999999999","cdbairro":1,"identidade":"123456789"}'

# Listar clientes
curl http://localhost:8001/customers

# Atualizar cliente
curl -X PUT http://localhost:8001/customers/2 \
  -H "Content-Type: application/json" \
  -d '{"nomecliente":"Maria Silva Atualizado"}'

# Deletar cliente
curl -X DELETE http://localhost:8001/customers/2
```

**Todos retornam sucesso!**

---

## 🔧 DEBUG NO NAVEGADOR

### Passo 1: Abrir DevTools

1. Acesse: **http://localhost:3001**
2. Aperte **F12** (abra DevTools)
3. Vá para aba **"Console"**

### Passo 2: Monitorar Requisições

No console, você deve ver logs como:
```javascript
API Request: GET http://localhost:8001/dashboard/stats
API Request: GET http://localhost:8001/customers
```

**Se a URL não for `localhost:8001`, há problema de configuração.**

### Passo 3: Aba "Network" (F12)

1. Clique em aba **"Network"**
2. Filtre por **"customers"**
3. Tente criar um novo cliente

**O que deve aparecer:**
- `POST http://localhost:8001/customers`
- Status: **201 Created** (verde)
- Response: JSON com dados do cliente

**Se aparecer 404:**
- Anote qual URL está sendo acessada
- Copie a URL completa para mim

### Passo 4: Teste Completo

1. **Limpe o cache**: Ctrl+Shift+R
2. **Vá para aba "Console"** (F12)
3. **Clique em "Clientes"** no menu
4. **Clique em "Novo Cliente"**
5. **Preencha:**
   - Nome: João Teste
   - Endereço: Rua Teste, 123
   - CEP: 12345678
   - Data Nascimento: 01/01/1990
   - Telefone: 11999999999
6. **Clique em "Salvar Cliente"**

**No Console (F12) deve aparecer:**
```
API Request: POST http://localhost:8001/customers
Saving customer: {nomecliente: "João Teste", ...}
```

**No Network (F12) deve aparecer:**
- Requisição: `POST http://localhost:8001/customers`
- Status: **201 Created**
- Response: Cliente criado

---

## 🐛 Possíveis Problemas

### Problema 1: Cache do Navegador

**Sintoma:** Mesmo após correções, ainda dá erro
**Solução:**
- Ctrl+Shift+R (hard reload)
- Ou abrir em aba anônima: Ctrl+Shift+N

### Problema 2: URL Errada no Console

**Sintoma:** Console mostra URL diferente de `localhost:8001`
**Exemplo:** `http://app:8000/customers`

**Causa:** Frontend não foi reconstruído corretamente
**Solução:**
```bash
docker-compose up -d --build frontend
```

### Problema 3: CORS

**Sintoma:** Console mostra erro de CORS
**Solução:** Verificar logs da API:
```bash
docker logs app --tail 50
```

### Problema 4: Formulário Não Abre

**Sintoma:** Modal não aparece
**Solução:**
1. Verificar Console (F12) por erros JS
2. Verificar se botão "Novo Cliente" é clicável
3. Tentar em outro navegador (Chrome/Firefox)

---

## 📊 Checklist de Verificação

Antes de reportar erro, verifique:

- [ ] Docker containers rodando (`docker ps`)
- [ ] API acessível (`curl http://localhost:8001/health`)
- [ ] Frontend acessível (`curl http://localhost:3001`)
- [ ] Console (F12) não mostra erros vermelhos
- [ ] Network (F12) mostra requisições para `localhost:8001`
- [ ] Cache limpo (Ctrl+Shift+R)
- [ ] Testado em aba anônima (Ctrl+Shift+N)

---

## 🎯 Teste Rápido

**Para verificar se tudo funciona, execute:**

```bash
# 1. Verificar containers
docker ps | grep -E "app|frontend"

# 2. Testar API
curl http://localhost:8001/customers

# 3. Criar cliente via curl
curl -X POST http://localhost:8001/customers \
  -H "Content-Type: application/json" \
  -d '{"nomecliente":"Teste Final","endereco":"Rua Teste","data_nascimento":"1990-01-01","cep":"12345-678","fone_01":"11999999999","cdbairro":1,"identidade":"123456789"}'

# 4. Verificar se cliente foi criado
curl http://localhost:8001/customers | grep "Teste Final"
```

**Se tudo isso funcionar, o problema está no navegador.**

---

## 💡 Informações a Coletar

Se ainda der erro 404, por favor:

1. **Abra Console (F12)**
2. **Tente criar um cliente**
3. **Copie TODO que aparece no Console** (logs coloridos)
4. **Vá para aba Network (F12)**
5. **Clique na requisição que deu erro (vermelho)**
6. **Copie:**
   - URL completa sendo acessada
   - Status code
   - Response (aba "Response")
   - Headers (aba "Headers")

**Cole essas informações aqui para eu debugar.**

---

## ✅ Resumo

**Backend (API):** ✅ **100% FUNCIONANDO**
- Todos os endpoints CRUD testados via curl
- POST, GET, PUT, DELETE funcionando

**Frontend:** ✅ **RECONSTRUÍDO** 
- VITE_API_URL configurado para localhost:8001
- Formulário expandido com 10 campos
- Máscaras aplicadas

**Próximo:** Testar no navegador seguindo os passos acima.
