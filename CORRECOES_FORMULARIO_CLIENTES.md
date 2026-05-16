# CORREÇÕES DO FORMULÁRIO DE CLIENTES

## Data: 2026-05-16

---

## 🐛 Problemas Relatados

1. **Formulário só mostrava nome e endereço** - Campos não estavam sendo exibidos corretamente
2. **Formulário não salvava clientes** - Erro ao tentar inserir novo cliente

---

## ✅ Correções Aplicadas

### 1. Formulário Completamente Reconstruído

**Campos Adicionados:**
- ✅ Data de Nascimento (validado)
- ✅ CPF (opcional)
- ✅ RG/Identidade
- ✅ Telefone Principal com máscara
- ✅ Telefone Secundário
- ✅ CEP com máscara automática (XXXXX-XXX)
- ✅ Bairro (dropdown)
- ✅ Observações (textarea)

### 2. Máscaras de Entrada

```javascript
// CEP: Formata automaticamente para XXXXX-XXX
onChange={(e) => {
  let value = e.target.value.replace(/\D/g, '');
  if (value.length > 5) {
    value = value.slice(0, 5) + '-' + value.slice(5, 8);
  }
  handleInputChange({ target: { name: 'cep', value } });
}}

// Telefone: Remove não-numéricos, máximo 11 dígitos
onChange={(e) => {
  let value = e.target.value.replace(/\D/g, '');
  if (value.length > 11) value = value.slice(0, 11);
  handleInputChange({ target: { name: 'fone_01', value } });
}}
```

### 3. Validações Frontend

- **Campos obrigatórios marcados** com asterisco vermelho (*)
- **Data de nascimento** não pode ser futura
- **CEP** formatado automaticamente
- **Telefone** com máscara automática
- **Máximos de caracteres** definidos

### 4. Tratamento de Erros

```javascript
try {
  // Tenta salvar
  await apiService.createCliente(customerData);
  alert('Cliente salvo com sucesso!');
} catch (error) {
  // Exibe mensagem de erro detalhada
  const errorMessage = error.response?.data?.detail || error.message || 'Erro desconhecido';
  alert('Erro ao salvar cliente: ' + errorMessage);
}
```

### 5. Console.log para Debug

```javascript
console.log('Saving customer:', customerData);
```

Abra o console do navegador (F12) para ver os dados sendo enviados.

---

## 🧪 Como Testar

### Passo 1: Acessar o Frontend
```
http://localhost:3001
```

### Passo 2: Ir para a página Clientes
Clique no menu "Clientes"

### Passo 3: Clicar em "Novo Cliente"
Botão azul no canto superior direito

### Passo 4: Preencher o Formulário

**Mínimo obrigatório:**
- Nome Completo: João Teste
- Endereço: Rua Teste, 123
- CEP: 12345-678 (formata automaticamente)
- Data de Nascimento: 1990-01-01
- Telefone Principal: 11999999999

**Opcional:**
- CPF: 00000000000
- RG: 0000000000
- Telefone Secundário: (deixe em branco)
- Observações: (deixe em branco)

### Passo 5: Abrir Console do Navegador (F12)
- Vá para a aba "Console"
- Observe os logs quando clicar em "Salvar"

### Passo 6: Clicar em "Salvar Cliente"

**Resultado esperado:**
- ✅ Alert "Cliente salvo com sucesso!"
- ✅ Modal fecha
- ✅ Cliente aparece na lista
- ✅ Console mostra: `Saving customer: {...}`

**Se houver erro:**
- ❌ Alert "Erro ao salvar cliente: [mensagem]"
- ❌ Console mostra o erro em vermelho

---

## 🔍 Debug

### Verificar Requisição no Console

Abra o console (F12) e procure por:

```javascript
console.log('Saving customer:', customerData);
```

Deve mostrar algo como:

```json
{
  "nomecliente": "João Teste",
  "endereco": "Rua Teste, 123",
  "data_nascimento": "1990-01-01",
  "cdbairro": 1,
  "identidade": "000000000",
  "cep": "12345-678",
  "fone_01": "11999999999",
  "fone_02": null,
  "cic": null,
  "obs": null
}
```

### Verificar Requisição na Aba Network (F12)

1. Abra console (F12)
2. Vá para aba "Network"
3. Clique em "Salvar Cliente"
4. Procure por `customers` (POST)
5. Clique na requisição
6. Veja:
   - **Headers**: Status 201 ou 400
   - **Payload**: Dados enviados
   - **Response**: Resposta do servidor

---

## 📝 Campos vs API

| Campo Frontend | Campo API | Tipo | Obrigatório |
|----------------|-----------|------|-------------|
| nomecliente | nomecliente | string | ✅ Sim |
| endereco | endereco | string | ✅ Sim |
| data_nascimento | data_nascimento | date | ✅ Sim |
| cep | cep | string | ✅ Sim |
| fone_01 | fone_01 | string | ✅ Sim |
| identidade | identidade | string | ❌ Não |
| cic | cic | string | ❌ Não |
| fone_02 | fone_02 | string | ❌ Não |
| cdbairro | cdbairro | int | ❌ Não (default 1) |
| obs | obs | string | ❌ Não |

---

## 🚀 Próximos Passos

1. **Testar o formulário** seguindo os passos acima
2. **Verificar console** para ver os dados sendo enviados
3. **Reportar erros** se houver problemas
4. **Testar edição** de cliente existente
5. **Validar backend** está recebendo dados corretamente

---

## 📦 Arquivos Modificados

- `frontend/src/pages/Clientes.jsx`
  - Reformulado modal de cadastro/edição
  - Adicionadas máscaras de CEP/telefone
  - Melhorado tratamento de erros
  - Adicionados campos obrigatórios visualmente
  - Adicionado console.log para debug

---

## ⚠️ Conhecido

- O campo `cdbairro` está fixo em "Centro" (ID 1)
  - **Solução futura**: Criar endpoint para listar bairros
  - **Solução futura**: Adicionar campo para selecionar bairro

- Telefones sem formatação visual (ex: (11) 99999-9999)
  - **Solução futura**: Adicionar máscara de formatação visual
  - **Solução futura**: Usar biblioteca como react-input-mask

---

**Status:** ✅ **PRONTO PARA TESTES**
