# Domínio — CDsLoc

> Gerado pelo Reversa em 2026-05-08
> Glossário, regras de negócio e conceitos do sistema de locação de CDs

---

## Glossário de Negócio

| Termo | Definição | Confiança |
|--------|-----------|-----------|
| **Cliente** | Pessoa física cadastrada que pode alugar CDs na locadora | 🟢 CONFIRMADO |
| **Dependente** | Pessoa autorizada pelo cliente titular a retirar CDs em seu nome | 🟢 CONFIRMADO |
| **Título** | CD de música (álbum) cadastrado no sistema. Várias cópias físicas podem existir do mesmo título | 🟢 CONFIRMADO |
| **CD Físico** | Exemplar individual de um título. Cada CD físico tem um código único e situação independente | 🟢 CONFIRMADO |
| **Locação** | Registro de aluguel de um CD físico a um cliente/dependente | 🟢 CONFIRMADO |
| **Devolução** | Retorno do CD alugado, com possível aplicação de multa por atraso | 🟢 CONFIRMADO |
| **Reserva** | Registro de interesse em um título. Não garante disponibilidade física | 🟢 CONFIRMADO |
| **Recibo** | Documento fiscal emitido ao realizar locação, contendo itens e valores | 🟢 CONFIRMADO |
| **Locação 24h** | Modalidade de locação com prazo de devolução de 24 horas (1 dia) | 🟢 CONFIRMADO |
| **Locação 48h** | Modalidade de locação com prazo de devolução de 48 horas (2 dias) | 🟢 CONFIRMADO |
| **Cliente Cancelado** | Cliente marcado como inativo, não pode fazer novas locações ou cadastrar dependentes | 🟢 CONFIRMADO |
| **Multa** | Valor adicional cobrado por devolução após o prazo estipulado | 🟡 INFERIDO |

---

## Regras de Negócio

### Autenticação e Acesso

| Regra | Descrição | Confiança |
|--------|-----------|-----------|
| **Senha Global** | Sistema possui uma única senha para acesso (tabela `senha`) | 🟢 CONFIRMADO |
| **Máximo 3 Tentativas** | Após 3 tentativas de senha incorreta, sistema encerra | 🟢 CONFIRMADO |
| **Troca de Senha** | Usuário pode alterar senha se checkbox marcado durante login | 🟢 CONFIRMADO |
| **Confirmação Dupla** | Alteração de senha requer digitação duas vezes idênticas | 🟢 CONFIRMADO |
| **Limite de Senha** | Senha máxima de 10 caracteres | 🟢 CONFIRMADO |
| **Criptografia XOR** | Senha armazenada codificada com XOR chave 255 (inseguro) | 🟢 CONFIRMADO |

---

### Cadastro de Clientes

| Regra | Descrição | Confiança |
|--------|-----------|-----------|
| **Código Sequencial** | Código de cliente gerado automaticamente (sequencial) | 🟢 CONFIRMADO |
| **Campos Obrigatórios** | Código, nome, endereço, data de nascimento, bairro e identidade (RG) são obrigatórios | 🟢 CONFIRMADO |
| **Data de Nascimento** | Deve ser uma data válida (`IsDate()`) | 🟢 CONFIRMADO |
| **Bairro Selecionável** | Bairro deve ser escolhido de lista (DBCombo) pré-cadastrada | 🟢 CONFIRMADO |
| **CPF/CIC Opcional** | CPF não é obrigatório para cadastro | 🟢 CONFIRMADO |
| **Pesquisa Flexível** | Pesquisa por nome funciona como substring case-insensitive | 🟢 CONFIRMADO |
| **Cancelamento** | Cliente marcado como cancelado não pode fazer novas locações | 🟢 CONFIRMADO |
| **Dependentes** | Cliente ativo pode cadastrar dependentes ilimitados | 🟢 CONFIRMADO |
| **Dependente Nome Obrigatório** | Apenas nome do dependente é obrigatório | 🟢 CONFIRMADO |

---

### Dependentes

| Regra | Descrição | Confiança |
|--------|-----------|-----------|
| **Vinculação ao Titular** | Dependente está vinculado a um cliente (cod_cliente) | 🟢 CONFIRMADO |
| **Retirada Autorizada** | Dependente pode retirar CDs em nome do titular | 🟢 CONFIRMADO |
| **Cadastramento Bloqueado** | Cliente cancelado não pode cadastrar novos dependentes | 🟡 INFERIDO (pela lógica de negação de locação a cancelados) |

---

### Catálogo de CDs

| Regra | Descrição | Confiança |
|--------|-----------|-----------|
| **Título vs CD Físico** | Título é o catálogo; CD físico é o exemplar individual | 🟢 CONFIRMADO |
| **Quantidade por Título** | Campo `qtde` define quantos exemplares físicos existem do título | 🟢 CONFIRMADO |
| **Valor por Locação** | Cada título tem valor definido para locação | 🟢 CONFIRMADO |
| **Tipo de Locação** | Título pode ser 24h ou 48h | 🟢 CONFIRMADO |
| **Classificação Opcional** | Grupo, Estilo e Intérprete são opcionais | 🟢 CONFIRMADO |

---

### Locação de CDs

| Regra | Descrição | Confiança |
|--------|-----------|-----------|
| **Cliente Necessário** | Locação exige cliente ativo (não cancelado) | 🟢 CONFIRMADO |
| **Dependente Autorizado** | Checkbox permite indicar retirada por dependente | 🟢 CONFIRMADO |
| **CD Disponível** | Apenas CDs com `situacao = "Disponível"` podem ser locados | 🟢 CONFIRMADO |
| **Reserva Prioritária** | Sistema verifica reservas do cliente antes de locação | 🟡 INFERIDO (botão "Consulta Reserva") |
| **Cálculo de Data Prevista** | Locação 24h: data + 1 dia (2 se domingo) | 🟢 CONFIRMADO |
| **Cálculo de Data Prevista** | Locação 48h: data + 2 dias (3 se domingo) | 🟢 CONFIRMADO |
| **Múltiplos Itens** | Locação pode incluir vários CDs (acumulados no recibo) | 🟢 CONFIRMADO |
| **Atualização de Estado** | Ao locar, CD marca `situacao = "Locado"` e `locado = True` | 🟢 CONFIRMADO |
| **Estoque Atualizado** | Quantidade disponível do título é decrementada | 🟡 INFERIDO (pelo padrão de estoque) |

---

### Devolução de CDs

| Regra | Descrição | Confiança |
|--------|-----------|-----------|
| **Recibo Obrigatório** | Devolução exige recibo de locação pendente | 🟢 CONFIRMADO |
| **Múltiplos Recibos** | Cliente pode ter mais de um recibo pendente (exige seleção) | 🟢 CONFIRMADO |
| **Verificação de Atraso** | Sistema calcula dias de atraso ao devolver | 🟡 INFERIDO (cálculo de data vs data_prevista) |
| **Código de Estado** | Erro 3200 indica violação de integridade referencial | 🟢 CONFIRMADO |
| **Atualização de Estado** | Ao devolver, CD marca `situacao = "Disponível"` e `locado = False` | 🟢 CONFIRMADO |
| **Recibo Baixado** | Recibo marcado como `devolvido = True` após baixa | 🟢 CONFIRMADO |

---

### Reservas

| Regra | Descrição | Confiança |
|--------|-----------|-----------|
| **Cliente Ativo** | Cliente cancelado não pode fazer reservas | 🟢 CONFIRMADO |
| **Reserva por Título** | Reserva é feita por título, não por CD físico específico | 🟢 CONFIRMADO |
| **Sem Garantia** | Reserva não garante disponibilidade física na retirada | 🟢 CONFIRMADO |
| **Duplicidade Permitida** | Múltiplas reservas podem existir para o mesmo título | 🟢 CONFIRMADO |
| **Verificação de Data** | Sistema alerta se já existe reserva para o mesmo título/data | 🟢 CONFIRMADO |
| **Cancelamento** | Reservas podem ser canceladas/excluídas | 🟢 CONFIRMADO |
| **Reservas Locadas** | Existe função para deletar reservas que já foram locadas | 🟡 INFERIDO (botão "Deleta Registro" em reservas) |

---

### Consultas

| Regra | Descrição | Confiança |
|--------|-----------|-----------|
| **Pesquisa Substring** | Modo "Todas as Ocorrências" busca parte do texto | 🟢 CONFIRMADO |
| **Pesquisa Exata** | Modo "Palavras Exatas" busca frase completa | 🟢 CONFIRMADO |
| **Pesquisa Prefixo** | Modo "Palavra Inicial" busca começo do texto | 🟢 CONFIRMADO |
| **Case-Insensitive** | Pesquisas funcionam com maiúsculas e minúsculas | 🟢 CONFIRMADO |
| **Visualização de Locado** | Consultas mostram se CD está locado (`locado = True/False`) | 🟢 CONFIRMADO |
| **Somente Leitura** | Consultas não permitem alteração de dados | 🟢 CONFIRMADO |

---

### Regras de Integridade

| Regra | Descrição | Confiança |
|--------|-----------|-----------|
| **Erro 3200** | Violação de integridade referencial ao excluir registro com dependentes | 🟢 CONFIRMADO |
| **Não Excluir em Uso** | Não é possível excluir cliente com locações ativas | 🟡 INFERIDO (pelo erro 3200) |
| **Não Excluir Locado** | Não é possível excluir CD que está locado | 🟡 INFERIDO |

---

## Conceitos de Dados

### Tipos de Locação

| Tipo | Prazo Padrão | Regra de Cálculo | Confiança |
|------|---------------|------------------|-----------|
| **24 Horas** | 1 dia | `DateAdd("d", 1, data_inicio)` — 2 dias se domingo | 🟢 CONFIRMADO |
| **48 Horas** | 2 dias | `DateAdd("d", 2, data_inicio)` — 3 dias se domingo | 🟢 CONFIRMADO |

### Situação de CD

| Valor | Descrição | Confiança |
|-------|-----------|-----------|
| **Disponível** | CD está na locadora e pode ser locado | 🟢 CONFIRMADO |
| **Locado** | CD está com cliente | 🟢 CONFIRMADO |
| **Reservado** | 🟡 INFERIDO (não encontrado explicitamente no código) |

### Situação de Cliente

| Valor | Descrição | Confiança |
|-------|-----------|-----------|
| **Ativo** (cancelado = False) | Pode fazer locações e cadastrar dependentes | 🟢 CONFIRMADO |
| **Cancelado** (cancelado = True) | Bloqueado para novas operações | 🟢 CONFIRMADO |

### Situação de Recibo

| Valor | Descrição | Confiança |
|-------|-----------|-----------|
| **Pendente** (devolvido = False) | Locação em andamento | 🟢 CONFIRMADO |
| **Baixado** (devolvido = True) | Devolução registrada | 🟢 CONFIRMADO |

---

## Constantes e Limites

| Constante | Valor | Descrição | Confiança |
|-----------|-------|-----------|-----------|
| `MAX_SENHA` | 10 caracteres | Tamanho máximo da senha do sistema | 🟢 CONFIRMADO |
| `MAX_TENTATIVAS` | 3 | Número máximo de tentativas de login | 🟢 CONFIRMADO |
| `LEN_CODIGO` | 6 dígitos | Formato padrão de códigos (cliente, título, CD) | 🟡 INFERIDO |
| `DATA_MASCARA` | "dd/mm/yyyy" | Formato de data em todo o sistema | 🟢 CONFIRMADO |
| `CEP_MASCARA` | "#####-###" | Formato de CEP | 🟢 CONFIRMADO |
| `TELEFONE_MASCARA` | "###-####" | Formato de telefone | 🟢 CONFIRMADO |
| `CPF_MASCARA` | "###.###.###-##" | Formato de CPF | 🟢 CONFIRMADO |

---

## Lacunas (🔴)

| Lacuna | Descrição | Impacto |
|--------|-----------|---------|
| **Cálculo de Multa** | Não encontrado código explícito de cálculo de valor da multa por atraso | 🔴 Sistema pode não cobrar multas |
| **Valor de Locação na Tabela** | Existe tabela `valor_loc` mas seu uso não é claro no código | 🔴 Pode haver tabela de preços dinâmica não implementada |
| **Estado "Reservado" do CD** | Situação de reservado não é visível nas consultas | 🔴 Pode haver estado não implementado |
| **Estoque de Títulos** | Código referencia `qtde_disp` mas a tabela `titulo` não tem este campo claro | 🔴 Controle de estoque pode estar incompleto |
| **Validação de Data de Nascimento** | Não há validação se data de nascimento é válida (futura, muito antiga) | 🟡 Pode aceitar datas inválidas |
| **Limite de CDs por Locação** | Não há limite explícito de quantos CDs podem ser locados de uma vez | 🟡 Dependendo do recibo |

---

## Eventos de Negócio Monitorados

| Evento | Contexto | Confiança |
|---------|-----------|-----------|
| **Login** | Tentativa de acesso ao sistema | 🟢 CONFIRMADO |
| **Troca de Senha** | Alteração da senha de acesso | 🟢 CONFIRMADO |
| **Inclusão de Cliente** | Novo cliente cadastrado | 🟢 CONFIRMADO |
| **Alteração de Cliente** | Dados de cliente atualizados | 🟢 CONFIRMADO |
| **Cancelamento de Cliente** | Cliente marcado como cancelado | 🟢 CONFIRMADO |
| **Inclusão de Dependente** | Novo dependente cadastrado | 🟢 CONFIRMADO |
| **Locação de CD** | CD locado para cliente/dependente | 🟢 CONFIRMADO |
| **Cancelamento de Item de Locação** | Item removido do recibo antes de confirmação | 🟢 CONFIRMADO |
| **Devolução de CD** | CD devolvido pelo cliente | 🟢 CONFIRMADO |
| **Reserva de Título** | Cliente faz reserva de título | 🟢 CONFIRMADO |
| **Cancelamento de Reserva** | Reserva excluída pelo sistema | 🟢 CONFIRMADO |
| **Erro de Integridade** | Tentativa de exclusão violando referências | 🟢 CONFIRMADO |
