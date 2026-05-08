# Dicionário de Dados — CDsLoc

> Gerado pelo Reversa em 2026-05-08
> Documentação completa das entidades do banco de dados

---

## Resumo

| Entidade | Tabela | Tipo | Descrição |
|----------|--------|------|-----------|
| Cliente | Cliente | Cadastro | Informações de clientes da locadora |
| Dependente | dependente | Cadastro | Dependentes autorizados de clientes |
| Bairro | Bairro | Cadastro | Lista de bairros disponíveis |
| Senha | senha | Sistema | Senha de acesso ao sistema |

---

## Entidade: Cliente

**Nome da Tabela:** `Cliente`
**Descrição:** Cadastro completo de clientes da locadora de CDs
**Confiança:** 🟢 CONFIRMADO

### Campos

| Campo | Tipo de Dado | Tamanho | Obrigatório | Descrição | Valor Padrão | Confiança |
|-------|--------------|---------|-------------|-----------|--------------|-----------|
| codcliente | Numeric | - | Sim | Código único do cliente (Primary Key) | Auto | 🟢 |
| nomecliente | Text | 50+ | Sim | Nome completo do cliente | - | 🟢 |
| endereco | Text | 100+ | Sim | Endereço residencial completo | - | 🟢 |
| data-nascimento | Date/Time | - | Sim | Data de nascimento do cliente | - | 🟢 |
| cdbairro | Numeric | - | Sim | Código do bairro (Foreign Key → Bairro) | - | 🟢 |
| debairro | Text | 50 | Não | Nome do bairro (campos de query) | - | 🟢 |
| deMunic | Text | 50 | Não | Nome do município (campos de query) | - | 🟢 |
| cep | Text | 9 | Não | CEP formatado (#####-###) | - | 🟢 |
| fone-01 | Text | 9 | Não | Telefone residencial (####-####) | - | 🟢 |
| ramal_res | Text | 10 | Não | Ramal residencial | - | 🟢 |
| fone-02 | Text | 9 | Não | Telefone comercial (####-####) | - | 🟢 |
| ramal_trab | Text | 10 | Não | Ramal do trabalho | - | 🟢 |
| fone-03 | Text | 9 | Não | Telefone de referência (####-####) | - | 🟢 |
| identidade | Text | 20 | Sim | RG / Identidade | - | 🟢 |
| expedidor | Text | 10 | Não | Órgão expedidor do documento | - | 🟢 |
| data-expedicao | Date/Time | - | Não | Data de expedição do documento | - | 🟢 |
| cic | Text | 14 | Não | CPF formatado (###.###.###-##) | - | 🟢 |
| empresa | Text | 50 | Não | Nome da empresa onde trabalha | - | 🟢 |
| end-comercial | Text | 100 | Não | Endereço comercial completo | - | 🟢 |
| referencia-pessoal | Text | 50 | Não | Nome de pessoa de referência | - | 🟢 |
| data-inscricao | Date/Time | - | Não | Data de cadastro no sistema | Data atual | 🟡 |
| cancelado | Boolean | - | Não | Indica se cliente foi cancelado | False | 🟢 |
| obs | Text | 255 | Não | Observações gerais sobre o cliente | - | 🟢 |

### Índices

| Nome | Campos | Tipo | Confiança |
|------|---------|------|-----------|
| primarykey | codcliente | Unique/Primary | 🟢 |
| nomecliente | nomecliente | Non-Unique | 🟢 |

### Relacionamentos

| Tabela | Campo | Tipo | Cardinalidade | Confiança |
|--------|-------|------|---------------|-----------|
| Bairro | cdbairro | Foreign Key | N:1 | 🟢 |
| dependente | cod_cliente | Primary Key (1:N) | 1:N | 🟢 |

### Restrições de Negócio

- **codcliente:** Gerado automaticamente pelo sistema (sequencial)
- **data-nascimento:** Deve ser uma data válida
- **cancelado:** Quando True, cliente não pode realizar novas locações ou cadastrar dependentes

---

## Entidade: Dependente

**Nome da Tabela:** `dependente`
**Descrição:** Cadastro de dependentes autorizados de clientes (podem retirar CDs em nome do titular)
**Confiança:** 🟢 CONFIRMADO

### Campos

| Campo | Tipo de Dado | Tamanho | Obrigatório | Descrição | Valor Padrão | Confiança |
|-------|--------------|---------|-------------|-----------|--------------|-----------|
| cod_dependente | Numeric | - | Sim | Código único do dependente (Primary Key) | Auto | 🟢 |
| cod_cliente | Numeric | - | Sim | Código do cliente titular (Foreign Key → Cliente) | - | 🟢 |
| nome_dependente | Text | 50 | Sim | Nome completo do dependente | - | 🟢 |

### Índices

| Nome | Campos | Tipo | Confiança |
|------|---------|------|-----------|
| nome_dependente | nome_dependente | Non-Unique | 🟢 |
| cod_cliente | cod_cliente, cod_dependente | Composite | 🟡 |

### Relacionamentos

| Tabela | Campo | Tipo | Cardinalidade | Confiança |
|--------|-------|------|---------------|-----------|
| Cliente | cod_cliente | Foreign Key | N:1 | 🟢 |

### Restrições de Negócio

- **nome_dependente:** Campo obrigatório, não pode estar vazio
- Dependente só pode ser cadastrado se o cliente estiver ativo (`cancelado = False`)

---

## Entidade: Bairro

**Nome da Tabela:** `Bairro`
**Descrição:** Lista de bairros disponíveis para cadastro de clientes
**Confiança:** 🟢 CONFIRMADO

### Campos

| Campo | Tipo de Dado | Tamanho | Obrigatório | Descrição | Valor Padrão | Confiança |
|-------|--------------|---------|-------------|-----------|--------------|-----------|
| cdbairro | Numeric | - | Sim | Código único do bairro (Primary Key) | Auto | 🟢 |
| debairro | Text | 50 | Sim | Nome do bairro | - | 🟢 |

### Índices

| Nome | Campos | Tipo | Confiança |
|------|---------|------|-----------|
| primarykey | cdbairro | Unique/Primary | 🟡 |

### Relacionamentos

| Tabela | Campo | Tipo | Cardinalidade | Confiança |
|--------|-------|------|---------------|-----------|
| Cliente | cdbairro | Foreign Key | 1:N | 🟢 |

---

## Entidade: Senha

**Nome da Tabela:** `senha`
**Descrição:** Armazena a senha codificada para acesso ao sistema
**Confiança:** 🟢 CONFIRMADO

### Campos

| Campo | Tipo de Dado | Tamanho | Obrigatório | Descrição | Valor Padrão | Confiança |
|-------|--------------|---------|-------------|-----------|--------------|-----------|
| id-senha | Text | 10 | Sim | Senha codificada usando XOR | - | 🟢 |

### Índices

| Nome | Campos | Tipo | Confiança |
|------|---------|------|-----------|
| Não especificado | - | - | 🔴 |

### Observações

- A tabela parece conter apenas um registro (única senha do sistema)
- Senha é armazenada codificada usando XOR com chave fixa 255
- Máximo de 10 caracteres para a senha

---

## Entidades Não Analisadas

As seguintes entidades foram identificadas no código mas não tiveram sua estrutura completa analisada:

| Entidade | Tabela | Descrição | Confiança |
|----------|--------|-----------|-----------|
| CD | cd | Catálogo de CDs físicos disponíveis | 🟡 |
| Locação | locacao | Registro de locações ativas | 🟡 |
| Reserva | reserva | Reservas de CDs | 🟡 |
| Música | musica | Catálogo de músicas | 🟡 |
| Intérprete | interprete | Catálogo de intérpretes | 🟡 |
| Título | titulo | Títulos de CDs | 🟡 |
| Título-Intérprete | titulo-interprete | Relacionamento Título ↔ Intérprete | 🟡 |
| Música-Intérprete | musica-interprete | Relacionamento Música ↔ Intérprete | 🟡 |
| Título-Música | titulo-musica | Relacionamento Título ↔ Música | 🟡 |
| Município | Municipio | Lista de municípios | 🟡 |
| Grupo | grupo | Grupos de classificação | 🟡 |
| Estilo | estilo | Estilos musicais | 🟡 |
| Recibo | recibo | Recibos emitidos | 🟡 |
| Valor de Locação | valor_loc | Tabela de preços de locação | 🟡 |

**Nota:** Estas entidades requerem análise adicional do Data Master Agent para documentação completa.

---

## Queries e QueryDefs Identificados

### QueryDef: Cs_Clientes

**Descrição:** Consulta parametrizada para buscar cliente com informações de bairro e município
**Parâmetro:** `cdcliente` (código do cliente)
**Campos:** Todos da tabela Cliente + `debairro`, `deMunic` (JOIN com Bairro)
**Arquivo:** cliente.frm:1692-1694

### QueryDef: Cs_Dependente

**Descrição:** Consulta parametrizada para buscar dependentes de um cliente específico
**Parâmetro:** `cdcliente` (código do cliente)
**Campos:** `cod_dependente`, `nome_dependente`
**Arquivo:** cliente.frm:2458-2460

---

## Padrões de Nomenclatura

- **Tabelas:** Nome em minúsculas, sem acentos (ex: `Cliente`, `dependente`, `Bairro`)
- **Campos:** snake_case com hífen para compostos (ex: `data-nascimento`, `fone-01`, `end-comercial`)
- **Campos de lookup:** prefixo `de` (ex: `debairro`, `deMunic`)
- **Códigos:** prefixo `cd` (ex: `codcliente`, `cdbairro`)
- **Flags booleanos:** adjetivo em particípio (ex: `cancelado`)
- **Datas:** prefixo `data` (ex: `data-nascimento`, `data-expedicao`, `data-inscricao`)
