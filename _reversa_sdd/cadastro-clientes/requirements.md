# Cadastro de Clientes, Requisitos

> Especificação funcional da feature de cadastro de clientes do sistema CDsLoc
> Gerado pelo Reversa em 2026-05-08

---

## Visão Geral

Feature responsável pelo gerenciamento completo de clientes da locadora, incluindo cadastro, alteração, pesquisa, cancelamento e gerenciamento de dependentes autorizados. É a base operacional do sistema, pois todas as locações e reservas exigem um cliente ativo.

---

## Responsabilidades

- Cadastro de novos clientes com validação de campos obrigatórios
- Edição de clientes existentes
- Pesquisa de clientes por nome (substring case-insensitive)
- Cancelamento de clientes (soft-delete)
- Cadastro e gerenciamento de dependentes
- Validação de integridade referencial antes de exclusões

---

## Regras de Negócio

### Cadastro de Clientes

| Regra | Descrição | Confiança |
|--------|-----------|-----------|
| **Código Sequencial** | Código de cliente gerado automaticamente via `geracod()` | 🟢 CONFIRMADO |
| **Campos Obrigatórios** | Nome, endereço, data de nascimento, bairro e identidade são obrigatórios | 🟢 CONFIRMADO |
| **Validação de Data** | Data de nascimento deve ser válida (`IsDate()`) | 🟢 CONFIRMADO |
| **Bairro Selecionável** | Bairro deve ser escolhido de lista pré-cadastrada via DBCombo | 🟢 CONFIRMADO |
| **CPF Opcional** | CPF não é obrigatório para cadastro | 🟢 CONFIRMADO |
| **Pesquisa Flexível** | Pesquisa por nome funciona como substring case-insensitive | 🟢 CONFIRMADO |

### Cancelamento

| Regra | Descrição | Confiança |
|--------|-----------|-----------|
| **Soft Delete** | Cliente marcado como `cancelado = True` permanece no banco | 🟢 CONFIRMADO |
| **Bloqueio de Locação** | Cliente cancelado não pode fazer novas locações | 🟢 CONFIRMADO |
| **Bloqueio de Reserva** | Cliente cancelado não pode fazer reservas | 🟢 CONFIRMADO |
| **Bloqueio de Dependentes** | Cliente cancelado não pode cadastrar novos dependentes | 🟡 INFERIDO |

### Dependentes

| Regra | Descrição | Confiança |
|--------|-----------|-----------|
| **Quantidade Ilimitada** | Cliente ativo pode cadastrar dependentes ilimitados | 🟢 CONFIRMADO |
| **Nome Obrigatório** | Apenas nome do dependente é obrigatório | 🟢 CONFIRMADO |
| **Vinculação ao Titular** | Dependente vinculado via `cod_cliente` | 🟢 CONFIRMADO |
| **Retirada Autorizada** | Dependente pode retirar CDs em nome do titular | 🟢 CONFIRMADO |

---

## Requisitos Funcionais

| ID | Requisito | Prioridade | Critério de Aceite |
|----|-----------|-----------|-------------------|
| RF-CC-01 | Incluir novo cliente | Must | Cliente cadastrado com código sequencial, todos os campos obrigatórios preenchidos |
| RF-CC-02 | Alterar cliente existente | Must | Alterações persistidas, campos obrigatórios mantidos |
| RF-CC-03 | Pesquisar cliente por nome | Must | Lista exibe clientes cujo nome contém o termo buscado (case-insensitive) |
| RF-CC-04 | Cancelar cliente | Must | Flag `cancelado` marcada como True, cliente bloqueado para novas operações |
| RF-CC-05 | Cadastrar dependente | Must | Dependente vinculado ao cliente titular com código único |
| RF-CC-06 | Excluir dependente | Should | Dependente removido do banco, integridade referencial mantida |
| RF-CC-07 | Consultar dependentes de cliente | Should | Lista todos os dependentes de um cliente específico |

---

## Requisitos Não Funcionais

| Tipo | Requisito inferido | Evidência no código | Confiança |
|------|--------------------|---------------------|-----------|
| Performance | Consulta de cliente deve ser imediata | Uso de índice `nomecliente` | 🟢 CONFIRMADO |
| Integridade | Exclusão bloqueada se há dependentes | Tratamento de erro 3200 (integridade referencial) | 🟢 CONFIRMADO |
| Validação | Data de nascimento deve ser válida | `IsDate()` em CLIENTE.FRM | 🟢 CONFIRMADO |
| Usabilidade | Limpeza automática de campos | Função `limpacampos1()` e `limpacampos2()` | 🟢 CONFIRMADO |

---

## Critérios de Aceitação

```gherkin
# Cadastro de Cliente

Dado que o usuário está autenticado no sistema
E acessou o formulário de cadastro de clientes
Quando preenche todos os campos obrigatórios (nome, endereço, data de nascimento, bairro, identidade)
E clica em salvar
Então o cliente é cadastrado com um código sequencial automático
E os dados persistem no banco de dados

# Cadastro de Cliente - Validação

Dado que o usuário está no formulário de cadastro de clientes
Quando tenta salvar sem preencher campo obrigatório
Então o sistema exibe mensagem de erro
E não salva o registro

# Pesquisa de Cliente

Dado que existem clientes cadastrados no sistema
Quando o usuário digita um termo de pesquisa no campo de busca
Então o sistema exibe todos os clientes cujo nome contém o termo (case-insensitive)
E a pesquisa funciona como substring

# Cancelamento de Cliente

Dado que existe um cliente ativo cadastrado
Quando o usuário marca o cliente como cancelado
E salva a alteração
Então o flag `cancelado` é marcado como True
E o cliente não aparece mais nas operações de locação

# Integridade Referencial

Dado que existe um cliente com dependentes cadastrados
Quando o usuário tenta excluir o cliente
Então o sistema bloqueia a exclusão
E exibe mensagem de erro de integridade referencial

# Cadastro de Dependente

Dado que existe um cliente ativo
E o usuário acessa a tela de dependentes
Quando informa o nome do dependente
E clica em salvar
Então o dependente é cadastrado vinculado ao cliente titular
```

---

## Prioridade (MoSCoW)

| Requisito | MoSCoW | Justificativa |
|-----------|--------|---------------|
| Incluir/Alterar cliente | Must | Base operacional do sistema - sem clientes, não há locação |
| Pesquisar cliente | Must | Operação essencial para qualquer fluxo que envolva clientes |
| Cancelar cliente | Must | Necessário para gestão da base de clientes |
| Cadastrar dependente | Should | Funcionalidade importante mas não crítica para operação básica |
| Excluir dependente | Should | Gestão de dependentes, operação menos frequente |
| Consultar dependentes | Should | Operação de consulta, útil mas não bloqueante |

---

## Rastreabilidade de Código

| Arquivo | Função / Classe | Cobertura |
|---------|-----------------|-----------|
| `CLIENTE.FRM` | Formulário principal de clientes | 🟢 CONFIRMADO |
| `CLIENTE.FRM` | `limpacampos1()`, `limpacampos2()` | 🟢 CONFIRMADO |
| `DECLARA.BAS` | `geracod()` | 🟢 CONFIRMADO |
| `DECLARA.BAS` | `LimpaCampos()` | 🟢 CONFIRMADO |
| `DECLARA.BAS` | `trata_errobd()` | 🟢 CONFIRMADO |
| Tabela `Cliente` | Persistência de dados | 🟢 CONFIRMADO |
| Tabela `dependente` | Persistência de dependentes | 🟢 CONFIRMADO |
| Tabela `Bairro` | Lista de bairros disponíveis | 🟢 CONFIRMADO |
| QueryDef `Cs_Clientes` | Consulta parametrizada de cliente | 🟢 CONFIRMADO |
| QueryDef `Cs_Dependente` | Consulta parametrizada de dependentes | 🟢 CONFIRMADO |

---

## Lacunas Pendentes (🔴)

- 🔴 Comportamento de tentativa de exclusão de cliente com locações pendentes não foi confirmado no código
- 🔴 Validação de CPF (se houver) não foi identificada no código analisado
- 🔴 Lógica para impedir cadastro de dependentes em cliente cancelado não foi explicitamente encontrada
