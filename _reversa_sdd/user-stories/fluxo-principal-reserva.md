# User Story: Fluxo Principal de Reserva

> Como cliente da locadora de CDs, quero poder reservar CDs antes de vir à loja para garantir que terei o que desejo

---

## Ator

**Cliente da Locadora**

---

## Cenário Principal

Como cliente ativo, quero reservar CDs da seguinte forma:

1. Meu cadastro é identificado pelo operador do sistema (código ou nome)
2. Informo qual título de CD desejo reservar
3. O operador busca o título no catálogo
4. O operador verifica se há CDs disponíveis do título
5. O operador registra a reserva com a data atual
6. O sistema me informa que a reserva foi registrada
7. Recebo confirmação da reserva

---

## Critérios de Aceite

- [ ] Cliente deve estar ativo (não cancelado) para poder reservar
- [ ] Cliente cancelado não pode fazer reservas
- [ ] Reserva é feita por título, não por CD físico específico
- [ ] Sistema informa quantidade de CDs disponíveis do título
- [ ] Várias reservas podem ser feitas para o mesmo título
- [ ] Cliente pode ter múltiplas reservas ativas simultaneamente
- [ ] Reserva é registrada com a data atual

---

## Cenários Alternativos

### Cenário: Reserva de Cliente Cancelado

**Quando:** Cliente está marcado como cancelado

**Então:**
- Sistema impede a reserva
- Sistema exibe mensagem: "O Cliente está CANCELADO"
- Operação é cancelada

### Cenário: Reserva de Título sem Disponibilidade

**Quando:** Todos os CDs do título estão locados

**Então:**
- Sistema permite a reserva (não há bloqueio)
- Sistema exibe quantidade disponível = 0
- Operador é informado que não há disponibilidade física

---

## Exceções

| Exceção | Descrição | Tratamento |
|----------|-----------|-------------|
| Cliente não encontrado | Operador informa código/nome que não existe | Sistema exibe: "Cliente não encontrado" |
| Título não encontrado | Título informado não existe no catálogo | Sistema exibe: "Título não encontrado" |

---

## Observações Importantes

**Aviso de Não-Garantia:** A reserva NÃO garante disponibilidade física do CD na retirada. É apenas um registro de interesse do cliente.

---

## Requisitos Relacionados

- RF-RES-01: Pesquisar cliente para reserva
- RF-RES-02: Pesquisar título para reserva
- RF-RES-03: Verificar disponibilidade de CDs do título
- RF-RES-04: Informar data de reserva
- RF-RES-05: Registrar nova reserva
- RF-RES-09: Impedir reserva de cliente cancelado
