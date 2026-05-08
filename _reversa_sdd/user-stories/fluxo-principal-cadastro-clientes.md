# User Story: Fluxo Principal de Cadastro de Clientes

> Como atendente da locadora de CDs, quero poder cadastrar novos clientes para poder atendê-los nas locações

---

## Ator

**Atendente da Locadora**

---

## Cenário Principal

Como atendente, quero cadastrar um novo cliente da seguinte forma:

1. Acesso o formulário de cadastro de clientes
2. Informo os dados pessoais do cliente:
   - Nome completo
   - Endereço
   - Data de nascimento
   - Identidade (RG)
   - Bairro (seleciono da lista)
   - CPF (opcional)
3. Informo os dados de contato:
   - Telefone residencial
   - Telefone comercial (opcional)
   - Telefone de referência (opcional)
4. Informo dados profissionais (opcional):
   - Empresa onde trabalha
   - Endereço comercial
5. Clico em salvar
6. Sistema gera automaticamente o código do cliente
7. Sistema salva o registro no banco de dados
8. Sistema me confirma que o cadastro foi realizado
9. Registro é imediatamente disponível para consultas e locações

---

## Critérios de Aceite

- [ ] Campos obrigatórios devem ser preenchidos: nome, endereço, data de nascimento, bairro e identidade
- [ ] Sistema gera código sequencial automaticamente
- [ ] Bairro deve ser selecionado de lista pré-cadastrada
- [ ] Data de nascimento deve ser válida
- [ ] CPF é opcional
- [ ] Pesquisa por nome funciona como substring case-insensitive
- [ ] Cliente pode ser consultado após cadastro
- [ ] Cliente pode fazer locações imediatamente após cadastro

---

## Cenários Alternativos

### Cenário: Cadastro com Campo Obrigatório Vazio

**Quando:** Atendente tenta salvar sem preencher campo obrigatório

**Então:**
- Sistema impede o salvamento
- Sistema exibe mensagem: "[Campo] não pode ficar em branco"
- Sistema posiciona o cursor no campo inválido

### Cenário: Data de Nascimento Inválida

**Quando:** Atendente informa uma data inválida

**Então:**
- Sistema impede o salvamento
- Sistema valida via `IsDate()`
- Sistema exibe mensagem de erro

### Cenário: Edição de Cliente Existente

**Quando:** Atendente seleciona um cliente já cadastrado

**Então:**
- Sistema carrega os dados do cliente no formulário
- Sistema permite edição de campos
- Sistema salva alterações sem criar novo registro

---

## Exceções

| Exceção | Descrição | Tratamento |
|----------|-----------|-------------|
| Bairro não cadastrado | Lista de bairros está vazia | Sistema exibe erro ao selecionar bairro |
| Erro no banco de dados | Falha ao salvar registro | Sistema exibe mensagem de erro genérica |
| Cliente já cadastrado | Tentativa de duplicar cadastro | Sistema permite (não há verificação de CPF único) |

---

## Requisitos Relacionados

- RF-CC-01: Incluir novo cliente
- RF-CC-02: Alterar cliente existente
- RF-CC-03: Pesquisar cliente por nome
- RF-CC-04: Cancelar cliente
