# User Story: Fluxo Principal de Locação

> Como cliente da locadora de CDs, quero poder locar CDs para poder ouvir músicas

---

## Ator

**Cliente da Locadora** (pode ser cliente titular ou dependente autorizado)

---

## Cenário Principal

Como cliente ativo, quero locar CDs da seguinte forma:

1. Meu cadastro é identificado pelo operador do sistema (código ou nome)
2. Se sou dependente, meu nome é selecionado na lista de dependentes do cliente titular
3. O operador busca CDs disponíveis no catálogo
4. O operador seleciona os CDs que desejo locar
5. O operador confirma a locação
6. O sistema calcula a data prevista de devolução baseado no tipo do CD (24h ou 48h)
7. O sistema atualiza a situação dos CDs locados para "Locado"
8. O sistema gera um recibo com os itens locados
9. O sistema me entrega o recibo
10. Levo os CDs para casa

---

## Critérios de Aceite

- [ ] Cliente deve estar ativo (não cancelado) para poder locar
- [ ] Dependentes podem locar CDs em nome do cliente titular
- [ ] Apenas CDs com situação "Disponível" podem ser locados
- [ ] Data prevista de devolução é calculada automaticamente (24h ou 48h)
- [ ] Se data prevista cair em domingo, prazo é prorrogado em 1 dia
- [ ] Vários CDs podem ser locados em uma única locação
- [ ] Situação dos CDs é atualizada para "Locado" após confirmação
- [ ] Um recibo é gerado contendo todos os itens da locação
- [ ] Valor total da locação é exibido no recibo

---

## Cenários Alternativos

### Cenário: Tentativa de Locar com Cliente Cancelado

**Quando:** Cliente está marcado como cancelado

**Então:**
- Sistema impede a locação
- Sistema exibe mensagem: "O Cliente está CANCELADO"
- Operação é cancelada

### Cenário: Tentativa de Locar CD Já Locado

**Quando:** CD selecionado já está com situação "Locado"

**Então:**
- Sistema impede a seleção do CD
- Sistema não exibe o CD na lista de disponíveis
- Operação prossegue sem este item

---

## Exceções

| Exceção | Descrição | Tratamento |
|----------|-----------|-------------|
| Cliente não encontrado | Operador informa código/nome que não existe | Sistema exibe: "Cliente não encontrado" |
| Nenhum CD disponível | Todos os CDs do título estão locados | Sistema não exibe opções de seleção |
| Nenhum item na locação | Operador tenta confirmar sem CDs | Sistema exibe: "Adicione pelo menos um item à locação" |

---

## Requisitos Relacionados

- RF-MOV-01: Pesquisar cliente para locação
- RF-MOV-02: Selecionar dependente autorizado
- RF-MOV-03: Selecionar CD disponível
- RF-MOV-05: Calcular data prevista
- RF-MOV-06: Gerar recibo de locação
- RF-MOV-07: Atualizar situação do CD
- RF-MOV-13: Acumular múltiplos CDs em um recibo
