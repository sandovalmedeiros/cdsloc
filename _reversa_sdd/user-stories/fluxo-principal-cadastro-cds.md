# User Story: Fluxo Principal de Cadastro de CDs

> Como atendente da locadora de CDs, quero poder cadastrar novos CDs (títulos e exemplares físicos) para disponibilizá-los para locação

---

## Ator

**Atendente da Locadora**

---

## Cenário Principal: Cadastro de Título

Como atendente, quero cadastrar um novo título da seguinte forma:

1. Acesso a aba "Títulos" do cadastro de CDs
2. Informo os dados do título:
   - Nome do título (álbum)
   - Tipo de locação (24h ou 48h)
   - Quantidade de CDs disponíveis
   - Valor da locação
3. Informo classificação opcional:
   - Grupo (opcional)
   - Estilo (opcional)
4. Clico em salvar
5. Sistema gera automaticamente o código do título
6. Sistema salva o registro no banco de dados
7. Sistema me confirma que o cadastro foi realizado
8. Registro é imediatamente disponível para locação

---

## Cenário Principal: Cadastro de Música

Como atendente, quero cadastrar músicas de um título da seguinte forma:

1. Acesso a aba "Músicas" do cadastro de CDs
2. Seleciono o título ao qual a música pertence
3. Informo o nome da música
4. Informo o tempo (opcional, em segundos)
5. Clico em salvar
6. Sistema gera automaticamente o código da música
7. Sistema salva o registro e vincula ao título
8. A música aparece na lista de músicas do título

---

## Cenário Principal: Cadastro de CD Físico

Como atendente, quero cadastrar CDs físicos de um título da seguinte forma:

1. Acesso a aba "CDs" do cadastro de CDs
2. Seleciono o título ao qual o CD pertence
3. Informo o número de identificação do CD
4. Defino a situação inicial do CD (Disponível)
5. Informo dados de compra (opcional):
   - Data de compra
   - Valor de compra
6. Clico em salvar
7. Sistema gera automaticamente o código do CD
8. Sistema salva o registro e vincula ao título
9. O CD está imediatamente disponível para locação

---

## Critérios de Aceite

### Para Títulos

- [ ] Campos obrigatórios devem ser preenchidos: nome, tipo de locação, quantidade e valor
- [ ] Sistema gera código sequencial automaticamente
- [ ] Tipo de locação deve ser 24h ou 48h
- [ ] Grupo e Estilo são opcionais
- [ ] Título pode ser consultado após cadastro

### Para Músicas

- [ ] Nome da música é obrigatório
- [ ] Tempo é opcional
- [ ] Música deve ser vinculada a um título
- [ ] Música aparece na lista de músicas do título

### Para CDs Físicos

- [ ] Número do CD é obrigatório
- [ ] CD deve ser vinculado a um título
- [ ] Situação deve ser definida (Disponível/Locado/Reservado)
- [ ] Data de compra e valor de compra são opcionais
- [ ] CD disponível pode ser selecionado para locação

---

## Cenários Alternativos

### Cenário: Exclusão de Título com Músicas Cadastradas

**Quando:** Atendente tenta excluir título que possui músicas

**Então:**
- Sistema impede a exclusão
- Sistema exibe mensagem de erro de integridade referencial
- Registro permanece no banco

### Cenário: Exclusão de CD Físico Locado

**Quando:** Atendente tenta excluir CD que está locado

**Então:**
- Sistema impede a exclusão
- Sistema exibe mensagem: "CD está locado e não pode ser excluído"
- Registro permanece no banco

---

## Exceções

| Exceção | Descrição | Tratamento |
|----------|-----------|-------------|
| Título não encontrado | Ao cadastrar música/CD, título selecionado não existe | Sistema exibe erro |
| Intérprete não cadastrado | Ao vincular intérprete, não há intérpretes cadastrados | Sistema exibe erro |
| Erro no banco de dados | Falha ao salvar registro | Sistema exibe mensagem de erro genérica |

---

## Requisitos Relacionados

### Títulos
- RF-CD-01: Cadastrar título de CD
- RF-CD-02: Alterar título existente
- RF-CD-07: Excluir CD físico (com verificação)

### Músicas
- RF-CD-04: Vincular música a título

### CDs Físicos
- RF-CD-06: Cadastrar CD físico
- RF-CD-08: Consultar disponibilidade de CDs
- RF-CD-09: Excluir CD físico (com verificação)
