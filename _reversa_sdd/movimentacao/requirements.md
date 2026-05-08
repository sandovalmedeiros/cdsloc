# Movimentação, Requisitos

> Especificação funcional da feature de movimentação (locação e devolução) do sistema CDsLoc
> Gerado pelo Reversa em 2026-05-08

---

## Visão Geral

Feature responsável pelo gerenciamento completo do ciclo de locação e devolução de CDs, incluindo emissão de recibos, cálculo de multas e controle de prazos. É a operação central de negócio da locadora.

---

## Responsabilidades

- Registrar novas locações de CDs para clientes
- Pesquisar cliente e selecionar dependente autorizado
- Selecionar CDs disponíveis para locação
- Calcular data prevista de devolução (24h ou 48h)
- Gerar recibos de locação
- Registrar devoluções de CDs
- Calcular multas por atraso
- Atualizar situação dos CDs (Disponível ↔ Locado)
- Baixar recibos pendentes

---

## Regras de Negócio

### Locação de CDs

| Regra | Descrição | Confiança |
|--------|-----------|-----------|
| **Cliente Necessário** | Locação exige cliente ativo (não cancelado) | 🟢 CONFIRMADO |
| **Dependente Autorizado** | Checkbox permite indicar retirada por dependente | 🟢 CONFIRMADO |
| **CD Disponível** | Apenas CDs com `situacao = "Disponível"` podem ser locados | 🟢 CONFIRMADO |
| **Tipo de Locação** | Prazo definido pelo tipo do título (24h ou 48h) | 🟢 CONFIRMADO |
| **Cálculo de Data Prevista (24h)** | Data + 1 dia (2 se domingo) | 🟢 CONFIRMADO |
| **Cálculo de Data Prevista (48h)** | Data + 2 dias (3 se domingo) | 🟢 CONFIRMADO |
| **Múltiplos Itens** | Locação pode incluir vários CDs (acumulados no recibo) | 🟢 CONFIRMADO |
| **Atualização de Estado** | Ao locar, CD marca `situacao = "Locado"` | 🟢 CONFIRMADO |

### Devolução de CDs

| Regra | Descrição | Confiança |
|--------|-----------|-----------|
| **Recibo Obrigatório** | Devolução exige recibo de locação pendente | 🟢 CONFIRMADO |
| **Múltiplos Recibos** | Cliente pode ter mais de um recibo pendente | 🟢 CONFIRMADO |
| **Verificação de Atraso** | Sistema calcula dias de atraso ao devolver | 🟢 CONFIRMADO |
| **Multa por Atraso** | Multa aplicada se devolução após data prevista | 🟢 CONFIRMADO |
| **Atualização de Estado** | Ao devolver, CD marca `situacao = "Disponível"` | 🟢 CONFIRMADO |
| **Recibo Baixado** | Recibo marcado como `devolvido = True` após baixa | 🟢 CONFIRMADO |
| **Recibo Único** | Recibo só pode ser baixado uma vez | 🟢 CONFIRMADO |

### Recibos

| Regra | Descrição | Confiança |
|--------|-----------|-----------|
| **Emissão na Locação** | Recibo gerado ao registrar locação | 🟢 CONFIRMADO |
| **Valor Total** | Soma de valores de locação + multa (se aplicável) | 🟢 CONFIRMADO |
| **Baixa na Devolução** | Recibo marcado como devolvido ao baixar | 🟢 CONFIRMADO |

---

## Requisitos Funcionais

| ID | Requisito | Prioridade | Critério de Aceite |
|----|-----------|-----------|-------------------|
| RF-MOV-01 | Pesquisar cliente para locação | Must | Cliente encontrado por código ou nome |
| RF-MOV-02 | Selecionar dependente autorizado (opcional) | Should | Dependente vinculado ao cliente titular |
| RF-MOV-03 | Selecionar CD disponível para locação | Must | Apenas CDs com situação "Disponível" |
| RF-MOV-04 | Definir tipo de locação (24h/48h) | Must | Tipo herdado do título do CD |
| RF-MOV-05 | Calcular data prevista de devolução | Must | Data calculada conforme tipo (considerando domingo) |
| RF-MOV-06 | Gerar recibo de locação | Must | Recibo criado com todos os itens da locação |
| RF-MOV-07 | Atualizar situação do CD para "Locado" | Must | Situação atualizada no registro do CD |
| RF-MOV-08 | Pesquisar recibo pendente para devolução | Must | Recibo não baixado encontrado |
| RF-MOV-09 | Verificar atraso na devolução | Must | Sistema calcula dias de atraso vs data prevista |
| RF-MOV-10 | Calcular multa por atraso | Should | Multa calculada conforme dias de atraso |
| RF-MOV-11 | Baixar recibo de devolução | Must | Recibo marcado como devolvido |
| RF-MOV-12 | Atualizar situação do CD para "Disponível" | Must | Situação atualizada no registro do CD |
| RF-MOV-13 | Acumular múltiplos CDs em um recibo | Should | Recibo contém vários itens da locação |

---

## Requisitos Não Funcionais

| Tipo | Requisito inferido | Evidência no código | Confiança |
|------|--------------------|---------------------|-----------|
| Performance | Consulta de CD disponível deve ser rápida | Uso de índices em tabela cd | 🟢 CONFIRMADO |
| Integridade | Não locar CD já locado | Flag `situacao` bloqueia locação | 🟢 CONFIRMADO |
| Consistência | Atualização atômica de CD e locação | Transação ao locar | 🟡 INFERIDO |
| Validação | Verificar cliente ativo antes de locar | Flag `cancelado` bloqueia locação | 🟢 CONFIRMADO |

---

## Critérios de Aceitação

```gherkin
# Locação de CD

Dado que o usuário está autenticado no sistema
E acessou a aba Locação
Quando pesquisa e seleciona um cliente ativo
E seleciona um CD com situação "Disponível"
E define o tipo de locação
E clica em locar
Então a locação é registrada
E o data prevista de devolução é calculada
E a situação do CD é atualizada para "Locado"
E um recibo é gerado

# Locação com Dependente

Dado que existe um cliente com dependentes cadastrados
E o usuário acessou a aba Locação
Quando seleciona o cliente titular
E marca a opção de retirada por dependente
E seleciona o dependente
E seleciona um CD disponível
E clica em locar
Então a locação é registrada em nome do dependente
E o dependente é vinculado à locação

# Tentativa de Locar CD Já Locado

Dado que existe um CD com situação "Locado"
Quando o usuário tenta selecionar este CD para locação
Então o sistema impede a seleção
E exibe mensagem informando que o CD não está disponível

# Devolução no Prazo

Dado que existe um recibo de locação pendente
E a data atual é menor ou igual à data prevista
Quando o usuário seleciona o recibo para baixar
E clica em devolver
Então a devolução é registrada
E nenhuma multa é cobrada
E a situação do CD é atualizada para "Disponível"
E o recibo é marcado como devolvido

# Devolução com Atraso

Dado que existe um recibo de locação pendente
E a data atual é maior que a data prevista
Quando o usuário seleciona o recibo para baixar
E clica em devolver
Então a devolução é registrada
E o sistema calcula os dias de atraso
E uma multa é aplicada ao valor total
E a situação do CD é atualizada para "Disponível"
E o recibo é marcado como devolvido
```

---

## Prioridade (MoSCoW)

| Requisito | MoSCoW | Justificativa |
|-----------|--------|---------------|
| Locar CD (pesquisar cliente, selecionar CD, gerar recibo) | Must | Operação central de negócio - sem locação, não há receita |
| Devolver CD (baixar recibo, atualizar situação) | Must | Operação essencial para ciclo completo |
| Calcular data prevista | Must | Necessário para controle de prazos |
| Verificar atraso | Should | Importante para controle de multas |
| Calcular multa | Should | Receita adicional da locadora |
| Selecionar dependente | Should | Funcionalidade importante, mas não essencial |
| Acumular múltiplos CDs | Could | Melhoria de usabilidade |

---

## Rastreabilidade de Código

| Arquivo | Função / Classe | Cobertura |
|---------|-----------------|-----------|
| `LOCDEVOL.FRM` | Formulário principal de locação/devolução | 🟢 CONFIRMADO |
| `LOCDEVOL.FRM` | `limpa_loc()`, `limpa_dev()`, `limpa_rec()` | 🟢 CONFIRMADO |
| `LOCDEVOL.FRM` | `pesquisa_cliente()` | 🟢 CONFIRMADO |
| `LOCDEVOL.FRM` | `pesquisa_reserva()` | 🟢 CONFIRMADO |
| `LOCDEVOL.FRM` | `cons_recibo()` | 🟢 CONFIRMADO |
| `LOCDEVOL.FRM` | `grava_recibo()` | 🟢 CONFIRMADO |
| Tabela `locacao` | Persistência de locações | 🟢 CONFIRMADO |
| Tabela `recibo` | Persistência de recibos | 🟢 CONFIRMADO |
| Tabela `cd` | Atualização de situação de CDs | 🟢 CONFIRMADO |
| Tabela `Cliente` | Dados do cliente locador | 🟢 CONFIRMADO |
| Tabela `dependente` | Dados do dependente autorizado | 🟢 CONFIRMADO |

---

## Lacunas Pendentes (🔴)

- 🔴 **Cálculo de multa:** Fórmula de cálculo de multa por dias de atraso não foi encontrada no código
- 🔴 **Tratamento de domingo:** Ajuste de data prevista para domingo está confirmado mas a lógica exata não foi detalhada
- 🔴 **Tabela valor_loc:** Referência a tabela de valores de locação mencionada mas não analisada
- 🔴 **Controle de transação:** Não confirmado se há tratamento de transação para garantir atomicidade entre locação e atualização do CD
