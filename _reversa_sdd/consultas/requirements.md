# Consultas, Requisitos

> Especificação funcional da feature de consultas do sistema CDsLoc
> Gerado pelo Reversa em 2026-05-08

---

## Visão Geral

Feature responsável por permitir consultas flexíveis em várias tabelas do banco de dados, com modos de pesquisa variados e exibição de resultados em grid. Todas as consultas são read-only (apenas leitura).

---

## Responsabilidades

- Permitir consulta de Títulos de CDs
- Permitir consulta de Músicas
- Permitir consulta de CDs Físicos
- Permitir consulta de Clientes
- Permitir consulta de Locações
- Permitir consulta de Reservas
- Oferecer modos de pesquisa flexíveis
- Exibir resultados em grid navegável
- Contar número de resultados encontrados

---

## Regras de Negócio

### Consultas

| Regra | Descrição | Confiança |
|--------|-----------|-----------|
| **Apenas Leitura** | Consultas não permitem alteração de dados | 🟢 CONFIRMADO |
| **Modo "Todas as Ocorrências"** | Busca substring case-insensitive | 🟢 CONFIRMADO |
| **Modo "Palavras Exatas"** | Busca frase completa | 🟢 CONFIRMADO |
| **Modo "Palavra Inicial + Complemento"** | Busca prefixo e resto | 🟢 CONFIRMADO |
| **Case-Insensitive** | Pesquisas funcionam com maiúsculas e minúsculas | 🟢 CONFIRMADO |
| **Visualização de Locado** | Consultas mostram se CD está locado | 🟢 CONFIRMADO |
| **Contagem de Resultados** | Número de registros exibido | 🟢 CONFIRMADO |
| **Grid Redimensionável** | Colunas podem ser redimensionadas | 🟢 CONFIRMADO |

---

## Requisitos Funcionais

| ID | Requisito | Prioridade | Critério de Aceite |
|----|-----------|-----------|-------------------|
| RF-CON-01 | Selecionar tipo de consulta | Must | Tipos disponíveis: Títulos, Músicas, CDs, Clientes, Locações, Reservas |
| RF-CON-02 | Digitar texto para pesquisa | Must | Campo de texto habilitado para entrada |
| RF-CON-03 | Selecionar modo de pesquisa | Must | Modos: Todas as Ocorrências, Palavras Exatas, Palavra Inicial + Complemento |
| RF-CON-04 | Executar consulta | Must | Sistema constrói SQL dinâmico e executa |
| RF-CON-05 | Exibir resultados em grid | Must | Grid populado com registros encontrados |
| RF-CON-06 | Contar resultados encontrados | Must | Número de registros exibido |
| RF-CON-07 | Navegar pelos resultados | Should | Grid permite seleção e navegação |
| RF-CON-08 | Redimensionar colunas do grid | Should | Usuário pode ajustar largura das colunas |

---

## Requisitos Não Funcionais

| Tipo | Requisito inferido | Evidência no código | Confiança |
|------|--------------------|---------------------|-----------|
| Performance | Consultas devem ser rápidas | Uso de índices nas tabelas | 🟢 CONFIRMADO |
| Segurança | Apenas leitura, sem alteração | Grid configurado como read-only | 🟢 CONFIRMADO |

---

## Critérios de Aceitação

```gherkin
# Consulta de Títulos

Dado que o usuário está autenticado no sistema
E acessou o formulário de consultas
Quando seleciona o tipo "Títulos"
E digita o texto de pesquisa
E seleciona o modo "Todas as Ocorrências"
E clica em pesquisar
Então o sistema constrói o SQL dinâmico
E os resultados são exibidos no grid
E o número de registros encontrados é exibido

# Consulta de Músicas - Palavra Exata

Dado que o usuário acessou o formulário de consultas
E selecionou o tipo "Músicas"
E digitou o texto de pesquisa
E selecionou o modo "Palavras Exatas"
E clica em pesquisar
Então apenas músicas com nome exato são exibidas
E a pesquisa é case-insensitive

# Consulta de CDs Físicos

Dado que o usuário acessou o formulário de consultas
E selecionou o tipo "CDs"
E digitou o texto de pesquisa
E clica em pesquisar
Então os CDs encontrados são exibidos
E a situação (Disponível/Locado) é visível

# Consulta Sem Resultados

Dado que o usuário digitou um texto de pesquisa
E selecionou um tipo de consulta
E clica em pesquisar
E não existem registros que correspondam à pesquisa
Então o grid é exibido vazio
E o contador de resultados mostra "0"
E o sistema exibe mensagem informando que não foram encontrados registros
```

---

## Prioridade (MoSCoW)

| Requisito | MoSCoW | Justificativa |
|-----------|--------|---------------|
| Selecionar tipo e executar consulta | Must | Funcionalidade principal - sem consulta, não há busca |
| Exibir resultados em grid | Must | Essencial para visualizar os dados |
| Modos de pesquisa flexíveis | Should | Melhoria de usabilidade |
| Contar resultados | Should | Informação útil, mas não essencial |
| Redimensionar colunas | Could | Melhoria de usabilidade |

---

## Rastreabilidade de Código

| Arquivo | Função / Classe | Cobertura |
|---------|-----------------|-----------|
| `frmConsulta.frm` | Formulário principal de consultas | 🟢 CONFIRMADO |
| `frmConsulta.frm` | `Form_Load()` | 🟢 CONFIRMADO |
| `frmConsulta.frm` | `executa_consulta()` | 🟢 CONFIRMADO |
| `frmConsulta.frm` | `preenche_grid()` | 🟢 CONFIRMADO |

---

## Lacunas Pendentes (🔴)

Nenhuma lacuna identificada para esta feature.
