# Reservas, Requisitos

> Especificação funcional da feature de reservas do sistema CDsLoc
> Gerado pelo Reversa em 2026-05-08

---

## Visão Geral

Feature responsável pelo gerenciamento de reservas de CDs, permitindo que clientes registrem interesse em títulos antes da locação. Reservas não garantem disponibilidade física, mas servem como sinalização de demanda.

---

## Responsabilidades

- Registrar novas reservas de títulos por cliente
- Pesquisar cliente que fará a reserva
- Pesquisar título desejado
- Verificar disponibilidade de CDs do título
- Informar data de reserva
- Cancelar reservas existentes
- Listar reservas por cliente
- Converter reserva em locação

---

## Regras de Negócio

### Reservas de CDs

| Regra | Descrição | Confiança |
|--------|-----------|-----------|
| **Cliente Ativo** | Reserva exige cliente ativo (não cancelado) | 🟢 CONFIRMADO |
| **Reserva por Título** | Reserva é feita por título, não por CD físico específico | 🟢 CONFIRMADO |
| **Sem Garantia de Disponibilidade** | Reserva não garante disponibilidade física na retirada | 🟢 CONFIRMADO |
| **Duplicidade Permitida** | Múltiplas reservas podem existir para o mesmo título | 🟢 CONFIRMADO |
| **Múltiplas Reservas por Cliente** | Cliente pode ter várias reservas ativas simultaneamente | 🟢 CONFIRMADO |
| **Cancelamento Permitido** | Reservas podem ser canceladas/excluídas | 🟢 CONFIRMADO |
| **Conversão em Locação** | Reserva pode ser convertida em locação ao retirar o CD | 🟢 CONFIRMADO |

---

## Requisitos Funcionais

| ID | Requisito | Prioridade | Critério de Aceite |
|----|-----------|-----------|-------------------|
| RF-RES-01 | Pesquisar cliente para reserva | Must | Cliente encontrado por código ou nome |
| RF-RES-02 | Pesquisar título para reserva | Must | Título encontrado na lista de títulos disponíveis |
| RF-RES-03 | Verificar disponibilidade de CDs do título | Should | Sistema informa quantidade de CDs disponíveis do título |
| RF-RES-04 | Informar data de reserva | Must | Data atual registrada ou data prevista definida |
| RF-RES-05 | Registrar nova reserva | Must | Reserva criada na tabela reserva |
| RF-RES-06 | Cancelar reserva existente | Should | Reserva removida da tabela reserva |
| RF-RES-07 | Listar reservas do cliente | Should | Todas as reservas ativas do cliente exibidas |
| RF-RES-08 | Converter reserva em locação | Should | Reserva vinculada à locação criada |
| RF-RES-09 | Impedir reserva de cliente cancelado | Must | Cliente cancelado não pode fazer reservas |

---

## Requisitos Não Funcionais

| Tipo | Requisito inferido | Evidência no código | Confiança |
|------|--------------------|---------------------|-----------|
| Performance | Consulta de títulos deve ser rápida | Uso de índices em tabela titulo | 🟢 CONFIRMADO |
| Validação | Verificar cliente ativo antes de reservar | Flag `cancelado` bloqueia reserva | 🟢 CONFIRMADO |

---

## Critérios de Aceitação

```gherkin
# Reserva de Título

Dado que o usuário está autenticado no sistema
E acessou o formulário de reservas
Quando pesquisa e seleciona um cliente ativo
E pesquisa e seleciona um título disponível
E clica em reservar
Então a reserva é registrada
E a data da reserva é informada
E a situação é marcada como "Pendente"

# Tentativa de Reserva com Cliente Cancelado

Dado que existe um cliente cancelado
Quando o usuário tenta fazer uma reserva para este cliente
Então o sistema impede a reserva
E exibe mensagem informando que o cliente está cancelado

# Cancelamento de Reserva

Dado que existe uma reserva pendente
Quando o usuário seleciona a reserva
E clica em cancelar
Então a reserva é removida do sistema
E o cliente é notificado do cancelamento

# Listagem de Reservas do Cliente

Dado que um cliente possui várias reservas
Quando o usuário consulta as reservas deste cliente
Então todas as reservas pendentes são exibidas
E os títulos reservados são listados

# Conversão de Reserva em Locação

Dado que existe uma reserva pendente
E o cliente comparece para retirar o CD
E há CDs disponíveis do título reservado
Quando o usuário inicia uma nova locação
E seleciona a reserva
Então a reserva é convertida em locação
E a situação da reserva é atualizada
E o CD é locado normalmente
```

---

## Prioridade (MoSCoW)

| Requisito | MoSCoW | Justificativa |
|-----------|--------|---------------|
| Registrar reserva | Must | Funcionalidade principal - sem registro, não há reservas |
| Pesquisar cliente e título | Must | Necessário para criar reserva |
| Impedir reserva de cliente cancelado | Must | Regra de negócio essencial |
| Cancelar reserva | Should | Operação importante, mas não crítica |
| Listar reservas | Should | Útil para gestão, mas não essencial |
| Verificar disponibilidade | Should | Informação útil, mas reserva não garante disponibilidade |
| Converter reserva em locação | Should | Funcionalidade de conveniência |

---

## Rastreabilidade de Código

| Arquivo | Função / Classe | Cobertura |
|---------|-----------------|-----------|
| `reservcd.frm` | Formulário principal de reservas | 🟢 CONFIRMADO |
| `reservcd.frm` | `dados_tit()` | 🟢 CONFIRMADO |
| `reservcd.frm` | `limpa_reserva()` | 🟢 CONFIRMADO |
| `reservcd.frm` | `pesquisa_cliente()` | 🟢 CONFIRMADO |
| `reservcd.frm` | `pesquisa_titulo()` | 🟢 CONFIRMADO |
| Tabela `reserva` | Persistência de reservas | 🟢 CONFIRMADO |
| Tabela `titulo` | Lista de títulos disponíveis | 🟢 CONFIRMADO |
| Tabela `Cliente` | Dados do cliente | 🟢 CONFIRMADO |

---

## Lacunas Pendentes (🔴)

- 🔴 **Atualização de situação da reserva:** Ao converter em locação, situação da reserva não confirmada no código - deve ser atualizada para "Confirmada" ou "Locada"
- 🔴 **Verificação de disponibilidade de CDs do título:** Lógica não confirmada no código - se há ou não verificação ao reservar
- 🔴 **Múltiplas reservas simultâneas:** Comportamento não confirmado se há alerta ao reservar título já reservado pelo mesmo cliente
