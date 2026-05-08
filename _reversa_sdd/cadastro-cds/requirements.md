# Cadastro de CDs, Requisitos

> Especificação funcional da feature de cadastro de CDs do sistema CDsLoc
> Gerado pelo Reversa em 2026-05-08

---

## Visão Geral

Feature responsável pelo gerenciamento completo do catálogo de CDs, abrangendo três níveis hierárquicos: Títulos (catálogo de álbuns), Músicas (faixas dos álbuns) e CDs Físicos (exemplares individuais disponíveis para locação). É a base do inventário da locadora.

---

## Responsabilidades

- Cadastro e gestão de Títulos de CDs (catálogo de álbuns)
- Cadastro e gestão de Músicas e suas relações com Títulos e Intérpretes
- Cadastro e gestão de CDs Físicos (exemplares individuais)
- Gerenciamento de Intérpretes, Grupos e Estilos musicais (tabelas auxiliares)
- Controle de estoque por Título
- Controle de disponibilidade de CDs físicos

---

## Regras de Negócio

### Títulos de CDs

| Regra | Descrição | Confiança |
|--------|-----------|-----------|
| **Código Sequencial** | Código de título gerado automaticamente | 🟢 CONFIRMADO |
| **Campos Obrigatórios** | Nome, tipo de locação, quantidade e valor são obrigatórios | 🟢 CONFIRMADO |
| **Tipo de Locação** | Título pode ser 24h ou 48h | 🟢 CONFIRMADO |
| **Quantidade Define Estoque** | Campo `qtde` define quantos exemplares físicos existem do título | 🟢 CONFIRMADO |
| **Valor por Locação** | Cada título tem valor definido para locação | 🟢 CONFIRMADO |
| **Classificação Opcional** | Grupo, Estilo e Intérprete são opcionais | 🟢 CONFIRMADO |

### CDs Físicos

| Regra | Descrição | Confiança |
|--------|-----------|-----------|
| **Código Sequencial** | Código de CD gerado automaticamente | 🟢 CONFIRMADO |
| **Vinculação ao Título** | CD físico está vinculado a um título | 🟢 CONFIRMADO |
| **Identificação Única** | Cada CD tem número de identificação (`numcd`) | 🟢 CONFIRMADO |
| **Situação Controla Disponibilidade** | Apenas CDs com `situacao = "Disponível"` podem ser locados | 🟢 CONFIRMADO |
| **Estoque Limitado por Título** | Quantidade de CDs físicos não deve exceder `qtde` do título | 🟡 INFERIDO |

### Músicas

| Regra | Descrição | Confiança |
|--------|-----------|-----------|
| **Código Sequencial** | Código de música gerado automaticamente | 🟢 CONFIRMADO |
| **Nome Obrigatório** | Nome da música é obrigatório | 🟢 CONFIRMADO |
| **Tempo Opcional** | Duração em segundos é opcional | 🟡 INFERIDO |
| **Múltiplos Intérpretes** | Música pode ter múltiplos intérpretes relacionados | 🟢 CONFIRMADO |
| **Vinculação a Título** | Música está vinculada a um título | 🟢 CONFIRMADO |

---

## Requisitos Funcionais

| ID | Requisito | Prioridade | Critério de Aceite |
|----|-----------|-----------|-------------------|
| RF-CD-01 | Cadastrar título de CD | Must | Título cadastrado com código, nome, tipo, quantidade e valor |
| RF-CD-02 | Alterar título existente | Must | Alterações persistidas, estoque atualizado |
| RF-CD-03 | Cadastrar música | Must | Música cadastrada com nome e código |
| RF-CD-04 | Vincular música a título | Must | Música aparece na lista de músicas do título |
| RF-CD-05 | Vincular intérprete a música/título | Should | Intérprete relacionado corretamente |
| RF-CD-06 | Cadastrar CD físico | Must | CD vinculado a título, com número identificador |
| RF-CD-07 | Excluir CD físico | Should | CD removido se não estiver locado |
| RF-CD-08 | Consultar disponibilidade de CDs | Should | Situação de cada CD exibida corretamente |
| RF-CD-09 | Gerenciar intérpretes | Should | CRUD completo de intérpretes |
| RF-CD-10 | Gerenciar grupos | Should | CRUD completo de grupos |
| RF-CD-11 | Gerenciar estilos | Should | CRUD completo de estilos |

---

## Requisitos Não Funcionais

| Tipo | Requisito inferido | Evidência no código | Confiança |
|------|--------------------|---------------------|-----------|
| Performance | Consulta de CDs deve ser rápida | Uso de índices em tabelas | 🟢 CONFIRMADO |
| Integridade | Não excluir CD locado | Flag `locado` impedindo exclusão | 🟢 CONFIRMADO |
| Consistência | Quantidade física ≤ quantidade do título | Campo `qtde` no título | 🟡 INFERIDO |
| Validação | Tipo de locação deve ser 24h ou 48h | Campo `tipo_locacao` | 🟢 CONFIRMADO |

---

## Critérios de Aceitação

```gherkin
# Cadastro de Título

Dado que o usuário está autenticado no sistema
E acessou a aba Títulos do cadastro de CDs
Quando preenche nome, tipo de locação, quantidade e valor
E clica em salvar
Então o título é cadastrado com código sequencial automático
E os dados persistem no banco de dados

# Vinculação de Música a Título

Dado que existe um título cadastrado
E o usuário acessou a aba Músicas
Quando informa o nome da música
E vincula ao título
Então a música é cadastrada
E aparece na lista de músicas daquele título

# Cadastro de CD Físico

Dado que existe um título cadastrado
E o usuário acessou a aba CDs
Quando informa o número identificador do CD
E vincula ao título
E marca situação como Disponível
Então o CD é cadastrado
E pode ser selecionado para locação

# Exclusão de CD Locado

Dado que existe um CD físico cadastrado
E o CD está com situação "Locado"
Quando o usuário tenta excluir o CD
Então o sistema bloqueia a exclusão
E exibe mensagem de erro

# Consulta de Disponibilidade

Dado que existem CDs físicos cadastrados
E alguns estão locados
Quando o usuário consulta a lista de CDs
Então a situação de cada CD é exibida (Disponível/Locado)
```

---

## Prioridade (MoSCoW)

| Requisito | MoSCoW | Justificativa |
|-----------|--------|---------------|
| Cadastrar título | Must | Base do catálogo - sem títulos, não há CDs |
| Cadastrar CD físico | Must | Exemplares físicos são o que se loca |
| Consultar disponibilidade | Must | Essencial para operação de locação |
| Cadastrar música | Should | Informação de catálogo, não essencial para locação |
| Vincular intérprete | Should | Enriquecimento de catálogo |
| Gerenciar tabelas auxiliares | Should | Classificação, importante mas não crítica |
| Excluir CD físico | Could | Operação de manutenção, raramente usada |

---

## Rastreabilidade de Código

| Arquivo | Função / Classe | Cobertura |
|---------|-----------------|-----------|
| `CDS.FRM` | Formulário principal de CDs | 🟢 CONFIRMADO |
| `CDS.FRM` | `dados_titulo()`, `dados_tit2()`, `dados_tit3()` | 🟢 CONFIRMADO |
| `CDS.FRM` | `dados_cd()` | 🟢 CONFIRMADO |
| `CDS.FRM` | `pesq_titulo()` | 🟢 CONFIRMADO |
| `CDS.FRM` | `limpa_titulo()`, `limpa_musica()`, `limpa_cd()` | 🟢 CONFIRMADO |
| Tabela `titulo` | Persistência de títulos | 🟢 CONFIRMADO |
| Tabela `musica` | Persistência de músicas | 🟢 CONFIRMADO |
| Tabela `cd` | Persistência de CDs físicos | 🟢 CONFIRMADO |
| Tabela `interprete` | Persistência de intérpretes | 🟢 CONFIRMADO |
| Tabela `titulo-interprete` | Relacionamento título ↔ intérprete | 🟢 CONFIRMADO |
| Tabela `musica-interprete` | Relacionamento música ↔ intérprete | 🟢 CONFIRMADO |
| Tabela `titulo-musica` | Relacionamento título ↔ música | 🟢 CONFIRMADO |

---

## Lacunas Pendentes (🔴)

- 🔴 Validação para impedir que quantidade de CDs físicos exceda `qtde` do título não foi encontrada no código
- 🔴 Situação "Reservado" para CDs físicos foi inferida mas não encontrada explicitamente
- 🔴 Lógica de atualização de estoque ao cadastrar/excluir CD físico não foi confirmada
- 🔴 Relacionamento entre Grupo, Estilo e Título não foi totalmente documentado
