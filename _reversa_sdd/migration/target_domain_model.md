---
schemaVersion: 1
generatedAt: 2026-05-12T00:00:00Z
reversa:
  version: "1.2.34"
kind: target_domain_model
producedBy: designer
hash: "sha256:<hash do corpo abaixo do front-matter>"
---

# Target Domain Model — CDsLoc

> Modelo de domínio alvo do sistema novo: agregados, entidades, value objects, eventos e regras de negócio.
> Topologia: Hexagonal com Bounded Contexts (Opção 2 de `topology_decision.md`).

---

## Resumo

| Bounded Context | Agregados Raiz | Entidades | Value Objects | Eventos de Domínio |
|-----------------|-----------------|-----------|----------------|---------------------|
| **Auth** | User, Role | - | CPF, Email, HashedPassword, Token | UserCreated, UserActivated, RoleAssigned |
| **Catalog** | Title, CdFisico | Musica, Interprete | Money, Duration (segundos) | TitleCreated, CdRegistered, StockUpdated, CdStatusChanged |
| **Customers** | Cliente | Dependente | CEP, Endereco, Telefone, DataNascimento | ClienteCreated, ClienteActivated, ClienteCancelled, DependenteAdded |
| **Rentals** | Locacao, Recibo | - | Money, DataPrevista, DataDevolucao, Multa | LocacaoCriada, DevolucaoRegistrada, MultaCalculada, ReciboGerado |
| **Reservations** | Reserva | - | DataReserva | ReservaCriada, ReservaConfirmada, ReservaCancelada, ReservaConvertida |
| **Reports** | ReportSpecification | - | DateRange, Periodo, FiltroCliente | ReportRequested |

---

## Bounded Context: Auth

### Agregados

| Agregado | Raiz | Invariantes | Ações/Comandos | Eventos Publicados |
|----------|------|------------|------------------|---------------------|
| **User** | id: int | email único, password hash válida | CreateUser, ActivateUser, UpdatePassword, AssignRole | UserCreated, UserActivated |
| **Role** | id: int | nome único, nível de permissão único | CreateRole, UpdatePermissions, AssignPermission | RoleAssigned |

### Entidades

| Entidade | Atributos | Relacionamentos |
|----------|-----------|-----------------|
| **User** | id: int, email: str, password_hash: str, active: bool, created_at: datetime, last_login: datetime | many-to-many Role |
| **Role** | id: int, nome: str, permissions: list[str] (ex: "rentals:read", "rentals:write") | many-to-many User |
| **Password** | (entidade de valor, não tabela) | hash: str, salt: str, created_at: datetime, expires_at: datetime | - |

### Value Objects

| Value Object | Atributos | Validação |
|-------------|-----------|------------|
| **CPF** | valor: str (11 dígitos) | Algoritmo do dígito verificador (BR-MIGRAR-010) |
| **Email** | valor: str | Formato RFC5322 |
| **HashedPassword** | hash: str (bcrypt), salt: str | Tamanho mínimo 8 caracteres, hash válido |
| **Token** | valor: str, expires_at: datetime | JWT válido, não expirado |

### Regras de Domínio

| ID | Regra | Invariante | Origem |
|----|-------|-----------|--------|
| **AUTH-001** | Senha máxima de 10 caracteres (legado) → Mínimo 8 caracteres (novo) | Tamanho de senha >= 8 | `domain.md` (evolução BR-HUMANA-001) |
| **AUTH-002** | Máximo 3 tentativas de login | Bloqueio após 3 falhas consecutivas | `domain.md` |
| **AUTH-003** | Confirmação dupla de senha (alteração) | Senhas devem ser idênticas | `domain.md` |
| **AUTH-004** | Múltiplos usuários com JWT | Sistema suporta múltiplos usuários (evolução BR-HUMANA-001) | `target_business_rules.md` |

---

## Bounded Context: Catalog

### Agregados

| Agregado | Raiz | Invariantes | Ações/Comandos | Eventos Publicados |
|----------|------|------------|------------------|---------------------|
| **Title** | id: int | qtde >= cd_count | CreateTitle, UpdateTitle, DeleteTitle, UpdateStock, AddMusica, AddInterprete, RemoveMusica | TitleCreated, StockUpdated |
| **CdFisico** | codigo: int | Situação válida (Disponível/Locado/Reservado) | CreateCd, UpdateSituacao, DeleteCd | CdRegistered, CdStatusChanged |
| **Musica** | id: int | Tempo opcional (>= 0 se informado) | CreateMusica, UpdateTempo, DeleteMusica | - |
| **Interprete** | id: int | Nome não vazio | CreateInterprete, UpdateNome, DeleteInterprete | - |

### Entidades

| Entidade | Atributos | Relacionamentos |
|----------|-----------|-----------------|
| **Title** | id: int, nome: str, tipo_locacao: '24h'|'48h', valor: Decimal(10,2), qtde: int, cdgrupo: FK, cdestilo: FK | one-to-many CdFisico, one-to-many Musica (via titulo-musica), many-to-many Interprete (via titulo-interprete) |
| **CdFisico** | codigo: int, numcd: str, codtitulo: FK, situacao: 'Disponível'|'Locado'|'Reservado', locado: bool, data_compra: Date, valor_compra: Decimal | many-to-one Title |
| **Musica** | id: int, nome: str, tempo: int (segundos) | many-to-many Title (via titulo-musica), many-to-many Interprete (via musica-interprete) |
| **Interprete** | id: int, nome: str | many-to-many Title (via titulo-interprete), many-to-many Musica (via musica-interprete) |

### Value Objects

| Value Object | Atributos | Validação |
|-------------|-----------|------------|
| **Money** | valor: Decimal(10,2), moeda: str = 'BRL' | Valor >= 0, 2 casas decimais |
| **Duration** | segundos: int | Segundos >= 0 |

### Regras de Domínio

| ID | Regra | Invariante | Origem |
|----|-------|-----------|--------|
| **CAT-001** | Situação "Reservado" é válida | Cd pode ter situação 'Reservado' (BR-MIGRAR-021) | `target_business_rules.md` |
| **CAT-002** | Estoque validado ao cadastrar CD | COUNT(cd por título) <= titulo.qtde (BR-MIGRAR-017) | `target_business_rules.md` |
| **CAT-003** | Estoque atualizado automaticamente | titulo.qtde = COUNT(cd por titulo) (BR-MIGRAR-017) | `target_business_rules.md` |
| **CAT-004** | Tipo de locação é 24h ou 48h | tipo_locacao IN ('24h', '48h') | `domain.md` |
| **CAT-005** | Classificação opcional | cdgrupo, cdestilo podem ser NULL | `domain.md` |

---

## Bounded Context: Customers

### Agregados

| Agregado | Raiz | Invariantes | Ações/Comandos | Eventos Publicados |
|----------|------|------------|------------------|---------------------|
| **Cliente** | codcliente: int | CPF válido se informado, data de nascimento razoável (>= 1900, não futuro) | CreateCliente, UpdateCliente, CancelCliente, AddDependente, RemoveDependente | ClienteCreated, ClienteActivated, ClienteCancelled |
| **Dependente** | cod_dependente: int | Vinculado a cliente ativo | CreateDependente, UpdateNome, DeleteDependente | DependenteAdded |

### Entidades

| Entidade | Atributos | Relacionamentos |
|----------|-----------|-----------------|
| **Cliente** | codcliente: int, nomecliente: str, endereco: str, data_nascimento: Date, cdbairro: FK, cep: str, fone_01: str, ramal_res: str, fone_02: str, ramal_trab: str, fone_03: str, identidade: str, expedidor: str, data_expedicao: Date, cic: str (CPF), empresa: str, end_comercial: str, referencia_pessoal: str, data_inscricao: Date, cancelado: bool, obs: str | one-to-many Dependente, one-to-one Bairro, one-to-one Municipio |
| **Dependente** | cod_dependente: int, cod_cliente: FK, nome_dependente: str | many-to-one Cliente |

### Value Objects

| Value Object | Atributos | Validação |
|-------------|-----------|------------|
| **CEP** | valor: str (5 dígitos) | 5 dígitos numéricos |
| **Endereco** | logradouro: str, numero: str, complemento: str, bairro: str, cidade: str, uf: str | Campos obrigatórios conforme contexto |
| **Telefone** | ddd: str (2-3 dígitos), numero: str (7-8 dígitos) | Formato válido de telefone brasileiro |
| **DataNascimento** | valor: Date | >= 1900, <= data atual | `target_business_rules.md` (BR-MIGRAR-008) |
| **CPF** | valor: str (11 dígitos) | Algoritmo do dígito verificador (BR-MIGRAR-010) |

### Regras de Domínio

| ID | Regra | Invariante | Origem |
|----|-------|-----------|--------|
| **CUST-001** | Cliente cancelado não pode fazer novas locações | IF cliente.cancelado = True THEN bloquear locação | `domain.md` |
| **CUST-002** | Cliente cancelado não pode cadastrar novos dependentes | IF cliente.cancelado = True THEN bloquear criação de dependente | `target_business_rules.md` (BR-MIGRAR-014) |
| **CUST-003** | Pesquisa de cliente funciona como substring case-insensitive | nomecliente LIKE LOWER(?termo) | `domain.md` |
| **CUST-004** | Bairro deve ser escolhido de lista pré-cadastrada | cdbairro deve referenciar tabela bairro | `domain.md` |

---

## Bounded Context: Rentals

### Agregados

| Agregado | Raiz | Invariantes | Ações/Comandos | Eventos Publicados |
|----------|------|------------|------------------|---------------------|
| **Locacao** | codlocacao: int | CD disponível, cliente ativo, recibo associado | CreateLocacao, CancelarItem | LocacaoCriada |
| **Recibo** | codrecibo: int | Valor total = soma valores + multa, itens associados | CreateRecibo, AddItem, BaixarRecibo | ReciboGerado |

### Entidades

| Entidade | Atributos | Relacionamentos |
|----------|-----------|-----------------|
| **Locacao** | codlocacao: int, codcliente: FK, coddependente: FK, codcd: FK, data_locacao: DateTime, data_prevista: Date, valor_locacao: Decimal, situacao: str, valor_multa: Decimal, data_devolucao: Date | many-to-one Cliente, many-to-one Dependente, many-to-one CdFisico, many-to-one Recibo |
| **Recibo** | codrecibo: int, codcliente: FK, data_emissao: DateTime, valor_total: Decimal, devolvido: bool | one-to-many Locacao, one-to-one Cliente |

### Value Objects

| Value Object | Atributos | Validação | Cálculo |
|-------------|-----------|------------|----------|
| **DataPrevista** | valor: Date | Se domingo = domingo + 1 dia | `domain.md` (BR-MIGRAR-025, BR-MIGRAR-026) |
| **Multa** | valor: Decimal | = dias_atraso * 3.50 (R$ 3,50/dia) | `target_business_rules.md` (BR-MIGRAR-033) |
| **DiasAtraso** | valor: int | = MAX(0, DateDiff(data_atual, data_prevista)) | `domain.md` (BR-MIGRAR-032) |

### Regras de Domínio

| ID | Regra | Invariante | Origem |
|----|-------|-----------|--------|
| **RENT-001** | Locação exige cliente ativo | IF cliente.cancelado = True THEN erro | `domain.md` |
| **RENT-002** | Locação permite retirada por dependente autorizado | coddependente opcional se cliente titular | `domain.md` |
| **RENT-003** | Apenas CDs com situação "Disponível" podem ser locados | IF cd.situacao != 'Disponível' THEN erro | `domain.md` |
| **RENT-004** | Cálculo de data prevista: 24h + 1 dia (2 se domingo) | Locação 24h: data + 1 dia, ajuste domingo | `domain.md` (BR-MIGRAR-025) |
| **RENT-005** | Cálculo de data prevista: 48h + 2 dias (3 se domingo) | Locação 48h: data + 2 dias, ajuste domingo | `domain.md` (BR-MIGRAR-026) |
| **RENT-006** | Ao locar, CD marca situacao = "Locado" e locado = True | Atualização atômica em transação (BR-MIGRAR-029) | `domain.md` |
| **RENT-007** | Estoque disponível do título decrementado | titulo.qtde-- (inferido, validar na implementação) | `domain.md` |
| **RENT-008** | Devolução exige recibo pendente | IF recibo.devolvido = True THEN erro | `domain.md` |
| **RENT-009** | Devolução calcula dias de atraso | dias_atraso = MAX(0, data_devolucao - data_prevista) | `domain.md` (BR-MIGRAR-032) |
| **RENT-010** | Devolução calcula multa se dias_atraso > 0 | valor_multa = dias_atraso * 3.50 | `target_business_rules.md` (BR-MIGRAR-033) |
| **RENT-011** | Ao devolver, CD marca situacao = "Disponível" e locado = False | Atualização atômica em transação (BR-MIGRAR-029) | `domain.md` |
| **RENT-012** | Recibo marcado como devolvido após baixa | recibo.devolvido = True | `domain.md` |
| **RENT-013** | Transação atômica entre locação e atualização do CD | Ambas as operações devem falhar ou suceder juntas | `target_business_rules.md` (BR-MIGRAR-029) |

---

## Bounded Context: Reservations

### Agregados

| Agregado | Raiz | Invariantes | Ações/Comandos | Eventos Publicados |
|----------|------|------------|------------------|---------------------|
| **Reserva** | codreserva: int | Cliente ativo, reserva não duplicada pelo mesmo cliente para o mesmo título | CreateReserva, CancelReserva, ConfirmarReserva, ConverterParaLocacao | ReservaCriada, ReservaConfirmada, ReservaCancelada, ReservaConvertida |

### Entidades

| Entidade | Atributos | Relacionamentos |
|----------|-----------|-----------------|
| **Reserva** | codreserva: int, codcliente: FK, codtitulo: FK, data_reserva: DateTime, data_prevista: Date, situacao: str ('Pendente'|'Confirmada'|'Cancelada'|'Locada') | many-to-one Cliente, many-to-one Title |

### Value Objects

| Value Object | Atributos | Validação |
|-------------|-----------|------------|
| **DataPrevista** | valor: Date | Calculada baseada na disponibilidade do título | `target_business_rules.md` (BR-MIGRAR-043) |

### Regras de Domínio

| ID | Regra | Invariante | Origem |
|----|-------|-----------|--------|
| **RESV-001** | Reserva exige cliente ativo | IF cliente.cancelado = True THEN erro | `domain.md` |
| **RESV-002** | Reserva por título, não por CD físico específico | Reserva vincula a titulo, não a cd | `domain.md` |
| **RESV-003** | Reserva não garante disponibilidade física na retirada | Não há reserva automática de CD físico | `domain.md` |
| **RESV-004** | Bloqueio de reserva duplicada pelo mesmo cliente para o mesmo título | Não é permitido múltiplas reservas para o mesmo título pelo mesmo cliente | `target_business_rules.md` (BR-MIGRAR-039) |
| **RESV-005** | Ao converter reserva em locação, situação marcada como "Confirmada" | reserva.situacao = 'Confirmada' | `target_business_rules.md` (BR-MIGRAR-042) |
| **RESV-006** | Data prevista calculada baseada na disponibilidade do título | Algoritmo de disponibilidade do catálogo | `target_business_rules.md` (BR-MIGRAR-043) |

---

## Bounded Context: Reports

### Agregados

| Agregado | Raiz | Invariantes | Ações/Comandos | Eventos Publicados |
|----------|------|------------|------------------|---------------------|
| **ReportSpecification** | id: int, tipo: str | Template deve existir, parâmetros válidos | GenerateReport | ReportRequested |

### Entidades

| Entidade | Atributos | Relacionamentos |
|----------|-----------|-----------------|
| **ReportSpecification** | id: int, tipo: str ('clientes_sintetico'|'clientes_analitico'|'dependentes'|'musicas'|'cds'|'titulos'|'reservas'|'aniversariantes'), template: str, filtros: dict | - |

### Value Objects

| Value Object | Atributos | Validação |
|-------------|-----------|------------|
| **DateRange** | data_inicio: Date, data_fim: Date | data_inicio <= data_fim |
| **Periodo** | valor: str ('hoje'|'ontem'|'esta_semana'|'este_mes'|'ultimo_mes') | Enum válido |
| **FiltroCliente** | codcliente: int, cancelado: bool | Cliente válido se existir |

### Regras de Domínio

| ID | Regra | Invariante | Origem |
|----|-------|-----------|--------|
| **REP-001** | Crystal Reports substituído por HTML/PDF dinâmico | Tecnologia legada descartada (BR-DESCARTAR-004, BR-HUMANA-002) | `target_business_rules.md` |
| **REP-002** | Relatórios aceitam filtros parametrizados | Filtros por período, cliente, status | `target_business_rules.md` (BR-MIGRAR-052) |

---

## Regras de Domínio Cross-Context

| ID | Regra | Contextos Envolvidos | Invariante |
|----|-------|---------------------|-----------|
| **CROSS-001** | Integridade referencial ao excluir cliente com dependentes | Database constraint (FK ON DELETE RESTRICT) | `domain.md` (BR-MIGRAR-048) |
| **CROSS-002** | Integridade referencial ao excluir título com CDs físicos | Database constraint (FK ON DELETE RESTRICT) | `target_business_rules.md` (BR-MIGRAR-050) |
| **CROSS-003** | Integridade referencial ao excluir cliente com locações pendentes | Bloquear exclusão se locacao não baixada | `target_business_rules.md` (BR-MIGRAR-049) |

---

## Tabela de Mapeamento Legado → Novo

| Legado | Bounded Context Novo | Tipo de Mapeamento | Observação |
|---------|----------------------|---------------------|-----------|
| Cliente | Customers (Cliente) | 1-para-1 | Campos preservados, estrutura normalizada |
| dependente | Customers (Dependente) | 1-para-1 | Campo renomeado (nome_dependente) |
| cd | Catalog (CdFisico) | 1-para-1 | Campo renomeado (situacao) |
| titulo | Catalog (Title) | 1-para-1 | Campo renomeado (qtde) |
| musica | Catalog (Musica) | 1-para-1 | Campo renomeado (nomemusica) |
| interprete | Catalog (Interprete) | 1-para-1 | Campo renomeado (nomeinterprete) |
| titulo-musica | Catalog (Title-Musica) | tabela de ligação (M2M) | Mapeado em ORM |
| titulo-interprete | Catalog (Title-Interprete) | tabela de ligação (M2M) | Mapeado em ORM |
| musica-interprete | Catalog (Musica-Interprete) | tabela de ligação (M2M) | Mapeado em ORM |
| locacao | Rentals (Locacao) | 1-para-1 | Campos preservados |
| recibo | Rentals (Recibo) | 1-para-1 | Campo renomeado (devolvido) |
| reserva | Reservations (Reserva) | 1-para-1 | Campo renomeado (situacao) |
| senha | Auth (User.password) | Fundido → User | Senha única não existe mais |
| Bairro | Customers (Bairro como entidade ou VO) | 1-para-1 | Tabela auxiliar normalizada |
| Municipio | Customers (Municipio como entidade ou VO) | 1-para-1 | Tabela auxiliar normalizada |
| grupo | Catalog (Grupo) | 1-para-1 | Tabela auxiliar normalizada |
| estilo | Catalog (Estilo) | 1-para-1 | Tabela auxiliar normalizada |
| valor_loc | Catalog (Title.valor como atributo) | Fundido | Tabela provavelmente não utilizada |
| *.rpt | Reports (ReportSpecification) | Fundido | Tecnologia substituída por HTML/PDF |

---

## Notas

1. **Evolução de Autenticação**: O legado tinha uma senha global para todos os usuários (SENHA.FRM). O novo sistema usa múltiplos usuários com JWT (BR-HUMANA-001). A tabela `senha` é descartada; a entidade `User` substitui esse conceito.

2. **Situação de CD Reservado**: O legado tinha apenas "Disponível" e "Locado" (inferido). O novo sistema adiciona "Reservado" (BR-MIGRAR-021) para suportar o fluxo completo de reservas.

3. **Validação de CPF**: Implementação do algoritmo de dígito verificador (BR-MIGRAR-010). Campo `cic` no legado era opcional e sem validação; no novo sistema é opcional mas com validação se informado.

4. **Transações Atômicas**: As regras BR-MIGRAR-029 exigem que locação/devolução e atualização do CD sejam atômicas. No PostgreSQL, isso é implementado com `BEGIN...COMMIT` ou `SAVEPOINT`.

5. **Eventos de Domínio**: Eventos são publicados no bus Redis para desacoplamento entre bounded contexts (event-driven). Projeções podem ler eventos de Rentals para atualizar Views de Reports.
