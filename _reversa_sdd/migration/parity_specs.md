---
schemaVersion: 1
generatedAt: 2026-05-12T00:00:00Z
reversa:
  version: "1.2.34"
kind: parity_specs
producedBy: inspector
hash: "sha256:<hash do corpo abaixo do front-matter>"
---

# Parity Specs — CDsLoc

> Especificação de como provar equivalência comportamental entre legado e novo sistema.
> Adaptação ao paradigma alvo (OO + DI + event-driven + async) definida em `paradigm_decision.md`.

---

## Resumo

| Aspecto | Estratégia Legada | Estratégia Novo (Alvo) | Modos de Paridade |
|---------|------------------|---------------------|------------------|
| **Paradigma** | Procedural (VB6) | OO + DI + Event-driven | Shadow mode, Characterization tests, Contract tests |
| **Banco de Dados** | Access (DAO síncrono) | PostgreSQL (async SQLAlchemy) | Data parity, Integrity parity, CRUD parity |
| **API** | Desktop MDI (forms) | REST API (FastAPI async) | Endpoint parity, Response parity |
| **Autenticação** | Senha única global (XOR) | JWT com múltiplos usuários | Auth parity (claims, tokens) |
| **Relatórios** | Crystal Reports (.rpt) | HTML/PDF dinâmico | Report parity (conteúdo, layout) |
| **Cálculos** | Funções VB6 (geracod, cálculos) | Serviços Python (repositories, services) | Calculation parity |
| **Validações** | MsgBox + IsDate() | Pydantic schemas + Domain validators | Validation parity |
| **Transações** | Acesso direto (sem controle explícito) | BEGIN...COMMIT (atomic) | Transaction parity |

---

## Estratégia de Paridade

### Abordagem Geral

**Princípio:** *Equivalência funcional > Fidelidade estrutural*

Objetivo é garantir que o sistema novo se comporte de forma funcionalmente equivalente ao legado nos pontos críticos para o negócio, mesmo que a arquitetura seja completamente diferente (OO + DI + async).

### Modos de Paridade

1. **Shadow Mode (Modo Fantasma):** Sistema legado continua operando normalmente ao lado do novo. Novo sistema lê o mesmo banco (simulado ou backup) e opera paralelamente. Ambos geram eventos/logs para comparação de resultados.
2. **Characterization Tests:**** Testes de características que capturam o comportamento observável do legado (ex: formatos de data, tratamentos de erro) e validam que o novo sistema se comporta de forma compatível.
3. **Contract Tests:**** Contratos explícitos (OpenAPI/Swagger) que definem a interface pública. Contratos do legado (interface gráfica + mensagens) são traduzidos para contratos API.
4. **Data Parity (Snapshot/Checksum):** Comparação de snapshots de dados após migração. Validação de integridade referencial e contagens.
5. **Integrity Parity:**** Validação de que as mesmas regras de negócio (FKs, unique constraints, checks) são aplicadas no sistema novo.
6. **CRUD Parity:**** Testes de Criar, Ler, Atualizar, Deletar para cada entidade principal.
7. **Endpoint Parity:**** Testes de cada endpoint REST contra o fluxo equivalente no legado (abrir formulário, preencher, salvar, excluir).
8. **Response Parity:**** Validação de que respostas JSON correspondem aos dados exibidos nos formulários VB6.
9. **Calculation Parity:**** Testes específicos para cálculos críticos (multa, data prevista, prazos com domingo).
10. **Transaction Parity:**** Validação de que operações de escrita são atômicas e consistentes.

### Priorização

| Tipo de Paridade | Prioridade | Justificativa |
|-----------------|-----------|---------------|
| **Critical** | Cálculo de Multa (financeiro) | BR-MIGRAR-033 define R$ 3,50/dia. Qualquer erro afeta receita. |
| **Critical** | Transação Atômica (locação/devolução) | BR-MIGRAR-029 exige atomicidade. Perda de dados ou inconsistência de estoque é inaceitável. |
| **High** | Estoque de CDs | BR-MIGRAR-017 valida estoque. Erro aqui pode locar CD não disponível. |
| **High** | Validão de CPF e Data Nascimento | BR-MIGRAR-010, BR-MIGRAR-008 definem validações. |
| **Medium** | Autenticação (múltiplos usuários) | BR-HUMANA-001 evolui senha única. Novos usuários devem funcionar. |
| **Medium** | Reservas (bloqueio de duplicatas) | BR-MIGRAR-039 bloqueia reservas duplicadas. Deve funcionar. |
| **Medium** | Relatórios (substituição Crystal Reports) | BR-HUMANA-002 substitui Crystal por HTML/PDF. Conteúdo e layout devem ser equivalentes. |
| **Low** | Consultas (pesquisa substring) | BR-MIGRAR-011 requer substring case-insensitive. Deve funcionar. |

---

## Cobertura Adaptada ao Paradigma

### 1. Async Throughout

**Implicação do Paradigma:** Todo acesso ao banco deve ser async.

| Modo de Paridade | Descrição | Implementação |
|----------------|-----------|---------------|
| **Repository Parity** | CRUD de repositórios deve usar `async def` | Testes de repository devem ser assíncronos (pytest-asyncio) |
| **Endpoint Parity** | Endpoints devem ser `async def` | Testes de endpoint devem ser assíncronos |
| **Data Parity** | Script de migração pode usar pyodbc síncrono, mas queries no novo sistema devem ser async | Scripts de validação de paridade podem ser assíncronos |

**Estratégia:** Comparar resultados de métodos async do novo sistema com métodos síncronos do legado, garantindo que o estado final seja equivalente.

---

### 2. OO com DI (Dependency Injection)

**Implicação do Paradigma:** Separação de camadas, interfaces (ports), e injeção de dependências.

| Modo de Paridade | Descrição | Implementação |
|----------------|-----------|---------------|
| **Domain Parity** | Lógica de negócio isolada em agregados, sem dependência de infraestrutura | Testes de domain devem mockar adapters (repositories) |
| **Contract Parity** | Interfaces Python (ABC) definem contratos de repositórios e serviços | Testes devem validar que implementações satisfazem contratos |
| **Service Parity** | Serviços de aplicação orquestram agregados e coordenam transações | Testes devem validar casos de uso (happy path + edge cases) |
| **Adapter Parity** | Implementações de ports (ex: SQLAlchemyRepository) devem ser substituíveis | Testes devem usar mocks |

**Estratégia:** Validar que o design Hexagonal (ports/adapters) permite testar domain em isolamento completo.

---

### 3. Event-Driven

**Implicação do Paradigma:** Sistema usa eventos para desacoplamento entre bounded contexts e consistência eventual.

| Modo de Paridade | Descrição | Implementação |
|----------------|-----------|---------------|
| **Event Parity** | Eventos de domínio devem ser publicados em bus de eventos | Testes devem validar que eventos são publicados quando estado muda |
| **Projection Parity** | Opcional em fase 1: leitura otimizada de eventos para Views (reports) | Não implementado inicialmente, mas arquitetura suporta |
| **Consistency Parity** | Eventos devem eventualmente propagar mudanças de estado (ex: `CdStatusChanged` atualiza estoque em projections) | Testes devem validar eventualidade (tolerância aceitável) |
| **Idempotency** | Operações que consomem eventos devem ser idempotentes por construção (ex: reprocessar evento não muda resultado) | Testes devem validar idempotência |

**Estratégia:** Validar que eventos são imutáveis e contêm todos os dados necessários. Usar IDs de correlação para tracing.

---

## Especificação de Modos

### 1. Shadow Mode (Data Parity)

| Aspecto | Detalhe | Critério de Aceitação |
|---------|---------|---------------------|
| **Banco de Dados** | PostgreSQL (novo) lê banco Access (legado) ou snapshot migrado | Comparação de contagens de tabelas, integridade referencial |
| **Volume** | ~10.000 registros estimados | Diferença < 0.1% aceitável |
| **Snapshot** | Backup de Access migrado para PostgreSQL antes do cutover | Snapshot deve ser tomado após migração completa e antes de iniciar Shadow Mode |
| **Duração** | 1-2 semanas de operação paralela (legado + novo simultâneos) | Ambos sistemas aceitam solicitações |
| **Janela de Sincronização** | Sistema legado continua recebendo atualizações? Não — Big Bang (legado para de cutover) |
| **Rollback** | Se Shadow Mode revelar problemas críticos, novo sistema é desligado e legado retoma | Backup do Access deve ser preservado |

**Justificativa:** Big Bang não permite operação paralela. Shadow Mode é opcional mas recomendado para validação intensiva de regras críticas (multa, estoque).

---

### 2. Characterization Tests

| Aspecto | Comportamento Legado | Especificação Novo | Critério de Aceitação |
|---------|------------------|---------------------|---------------------|
| **Formato de Data** | `dd/mm/yyyy` (máscarado) | `YYYY-MM-DD` (ISO 8601) | Novo sistema usa ISO, mas converte para exibição legado-style |
| **Tratamento de Erro** | MsgBox "Ocorreu Erro No. [número] - ligue p/Sandoval" | HTTPException com status code (400, 404, 500) | Novo sistema deve ser mais descritivo, mas código de erro é aceitável |
| **Validação de CPF** | Sem validação, apenas formatação | Algoritmo do dígito verificador (BR-MIGRAR-010) | Novo sistema implementa validação completa |
| **Validação de Data Nascimento** | `IsDate()` apenas (pode ser futuro) | >= 1900, <= data atual (BR-MIGRAR-008) | Novo sistema valida intervalo |
| **Calculo de Data Prevista** | 24h: +1 dia; 48h: +2 dias; se domingo: +1 dia extra (BR-MIGRAR-025, BR-MIGRAR-026) | Novo sistema usa mesma lógica (service `CalculationService.calcular_data_prevista()`) |

**Justificativa:** Legado é permissivo em alguns pontos; novo sistema é mais estrito (validações), o que é aceitável e benéfico para integridade de dados.

---

### 3. Contract Tests

| Aspecto | Legado | Novo | Critério de Aceitação |
|---------|--------|------|---------------------|
| **API vs Desktop** | Formulários VB6 com campos | OpenAPI (FastAPI) com Pydantic schemas | Schemas devem cobrir todos os campos obrigatórios do legado |
| **Autenticação** | Senha única (tabela `senha`) | JWT com múltiplos usuários | Endpoint `/auth/login` deve aceitar credenciais; endpoint `/auth/refresh` para renew token |
| **Autorização** | Implicita (usuário logado tem acesso a tudo) | Claims-based (roles no JWT token) | Novo sistema deve autorizar baseado em roles (ex: `rentals:read` vs `rentals:write`) |
| **Respostas** | Mensagens de sucesso/erro em MsgBox | JSON responses com `detail`, `status_code`, `message` | JSON deve conter informações equivalentes |

**Justificativa:** Legado não tinha contrato explícito. Novo sistema define contrato via OpenAPI, o que é benéfico.

---

### 4. Data Parity (Snapshot/Checksum)

| Tabela | Contagem Legado | Contagem Novo | Margem Aceitável | Validação |
|--------|---------------|---------------|------------------|----------|
| `clientes` | COUNT(*) | COUNT(*) | < 0.1% | - |
| `dependentes` | COUNT(*) | COUNT(*) | < 0.1% | - |
| `titulos` | COUNT(*) | COUNT(*) | < 0.1% | - |
| `cds` | COUNT(*) | COUNT(*) | < 0.1% | - |
| `locacoes` | COUNT(*) | COUNT(*) | < 0.1% | - |
| `recibos` | COUNT(*) | COUNT(*) | < 0.1% | - |
| `reservas` | COUNT(*) | COUNT(*) | < 0.1% | - |
| `bairros` | COUNT(*) | COUNT(*) | < 0.1% | - |
| `municipios` | COUNT(*) | COUNT(*) | < 0.1% | - |
| Total | ~10.000 | ~10.000 | - | |

**Validação de Integridade Referencial:**
- Todos os clientes têm bairro válido (`id_bairro` em `bairros`)
- Todos os dependentes têm cliente válido (`id_cliente` em `clientes`)
- Todos os CDs têm título válido (`id_titulo` em `titulos`)
- Todas as locações têm cliente válido (`id_cliente` em `clientes`)
- Todas as locações têm recibo válido (`id_locacao` em `recibos`)

**Validação de Transformações de Dados:**
- CPF: formato 11 dígitos (BR-MIGRAR-010)
- Data de nascimento: >= 1900 e <= data atual (BR-MIGRAR-008)
- Situação de CD: valores em `situacoes` (1=Disponível, 2=Locado, 3=Reservado)
- Cancelamento de cliente: `is_cancelado` boolean

**Justificativa:** Migração preserva estrutura relacional e aplica transformações de tipo/encoding. Contagens devem ser idênticas.

---

### 5. Integrity Parity

| Regra de Negócio | Legado | Novo | Status |
|-----------------|--------|------|--------|
| Cliente cancelado não pode locar | `cancelado = True` → bloqueio | `is_cancelado = True` → bloqueio | ✅ |
| Cliente cancelado não pode cadastrar dependentes | Bloqueio (implícito) | Bloqueio (regra BR-MIGRAR-014) | ✅ |
| Apenas CDs disponíveis podem ser locados | `situacao = "Disponível"` | `situacao_id = 1` | ✅ |
| CD locado marca estado | `locado = True`, `situacao = "Locado"` | `is_locado = True`, `situacao_id = 2` | ✅ |
| Reserva por título (não CD específico) | Reserva vincula a título | Reserva vincula a título | ✅ |
| Bloqueio de reserva duplicada por mesmo cliente | Sistema alerta se já existe reserva para mesmo título/data | Bloqueio se COUNT > 0 (BR-MIGRAR-039) | ✅ |

**Validação de Constraints:**
- `clientes.email` UNIQUE
- `clientes.codcliente` UNIQUE
- `dependentes.cod_dependente` UNIQUE
- `cds.codigo` UNIQUE
- `titulos.id` PRIMARY KEY
- `locacoes.id_cliente` FK ON DELETE CASCADE
- `locacoes.id_locacao` FK ON DELETE CASCADE
- `recibos.id_locacao` FK ON DELETE CASCADE
- `reservas.id_cliente` FK ON DELETE CASCADE

**Justificativa:** O novo schema impõe as mesmas regras via SQL constraints.

---

### 6. CRUD Parity

| Entidade | Legado | Novo | Status |
|---------|--------|------|--------|
| **Cliente** | AddNew/Edit/Delete via DAO | POST / PUT / DELETE endpoints | ✅ |
| **Dependente** | AddNew/Edit/Delete via DAO | POST / PUT / DELETE endpoints | ✅ |
| **Título** | AddNew/Edit/Delete via DAO | POST / PUT / DELETE endpoints | ✅ |
| **CD Físico** | AddNew/Edit/Delete via DAO | POST / PUT / DELETE endpoints | ✅ |
| **Locação** | AddNew via form + cálculo automático | POST endpoint (service cria locação e recibo) | ✅ |
| **Recibo** | Gerado automaticamente na locação | Criado implicitamente ao criar locação | ✅ |
| **Reserva** | AddNew/Delete via DAO | POST / DELETE endpoints | ✅ |

**Validação de CRUD:**
- CREATE: Validação de campos obrigatórios via Pydantic + Domain validators
- READ: Permissões baseadas em roles (ex: clientes:read vs clientes:write)
- UPDATE: Validação de regras de negócio no Domain/Service
- DELETE: Validação de integridade referencial (SQL constraints)

**Justificativa:** Novo sistema expõe CRUD via REST. Validações são equivalentes ou mais estritas.

---

### 7. Endpoint Parity

| Funcionalidade Legado | Endpoint Novo | Método | Status |
|---------------------|---------------|--------|--------|
| Login (senha única) | `POST /auth/login` | Valida credenciais, retorna JWT | ✅ |
| Login (mudança de senha) | `POST /auth/change-password` | Valida senha atual + nova, atualiza | ✅ |
| Cadastro de Cliente | `POST /clientes` | Cria cliente (repository) | ✅ |
| Consulta de Cliente | `GET /clientes/{id}` | Retorna cliente (repository) | ✅ |
| Atualização de Cliente | `PUT /clientes/{id}` | Atualiza cliente (service) | ✅ |
| Cancelamento de Cliente | `DELETE /clientes/{id}` | Soft delete (is_cancelado = True) | ✅ |
| Lista de Clientes | `GET /clientes` | Lista com filtros (ativo, cancelado) | ✅ |
| Pesquisa de Cliente | `GET /clientes/busca?q={termo}` | Substring case-insensitive | ✅ |
| Cadastro de Dependente | `POST /clientes/{id_cliente}/dependentes` | Cria dependente (repository) | ✅ |
| Consulta de Dependentes | `GET /clientes/{id_cliente}/dependentes/{id}` | Retorna dependente | ✅ |
| Atualização de Dependente | `PUT /clientes/{id_cliente}/dependentes/{id}` | Atualiza nome | ✅ |
| Exclusão de Dependente | `DELETE /clientes/{id_cliente}/dependentes/{id}` | Exclui (repository) | ✅ |
| Cadastro de Título | `POST /catalog/titulos` | Cria título (service) | ✅ |
| Consulta de Título | `GET /catalog/titulos/{id}` | Retorna título (repository) | ✅ |
| Atualização de Título | `PUT /catalog/titulos/{id}` | Atualiza título (service) | ✅ |
| Exclusão de Título | `DELETE /catalog/titulos/{id}` | Verifica estoque antes (service) | ✅ |
| Cadastro de CD Físico | `POST /catalog/cds` | Cria CD (service, valida estoque) | ✅ |
| Atualização de CD | `PUT /catalog/cds/{codigo}` | Atualiza situação (service) | ✅ |
| Exclusão de CD | `DELETE /catalog/cds/{codigo}` | Verifica se não está locado antes (service) | ✅ |
| Consulta de CDs | `GET /catalog/cds` | Lista com filtros (disponível, locado, por título) | ✅ |
| Locação | `POST /rentals` | Cria locação, recibo e itens (service) | ✅ |
| Consulta de Locação | `GET /rentals/{id}` | Retorna locação + itens + recibo | ✅ |
| Devolução | `POST /rentals/{id}/devolucao` | Calcula multa, baixa recibo (service) | ✅ |
| Lista de Locações | `GET /rentals` | Lista com filtros (pendente, baixada) | ✅ |
| Cadastro de Reserva | `POST /reservas` | Cria reserva (service, valida duplicidade) | ✅ |
| Consulta de Reserva | `GET /reservas/{id}` | Retorna reserva | ✅ |
| Cancelamento de Reserva | `DELETE /reservas/{id}` | Exclui (repository) | ✅ |
| Lista de Reservas | `GET /reservas` | Lista com filtros (pendente, confirmada, cancelada) | ✅ |
| Conversão de Reserva em Locação | `POST /reservas/{id}/converter` | Busca disponibilidade, cria locação (service) | ✅ |
| Consulta de Relatórios | `GET /reports/{tipo}` | Gera HTML/PDF (service) | ✅ |

**Validação de Endpoint:**
- Request body validado via Pydantic schemas
- Path parameters validados
- Query parameters validados
- Errors retornados como JSON (`{"detail": "...", "status_code": 400}`)
- HTTP status codes: 200 (OK), 201 (Created), 400 (Bad Request), 404 (Not Found), 500 (Internal Error)

**Justificativa:** REST endpoints fornecem funcionalidade equivalente às operações do legado. JSON responses são mais descritivos que MsgBox.

---

### 8. Response Parity

| Tipo de Operação | Legado | Novo | Status |
|-----------------|--------|------|--------|
| **Sucesso** | MsgBox "Confirme a Inclusão/Atualização" | JSON `{"detail": "Cliente cadastrado", "status_code": 201}` | ✅ |
| **Erro de Validação** | MsgBox "[Campo] não pode ficar em branco" | JSON `{"detail": "Nome do cliente é obrigatório", "status_code": 400}` | ✅ |
| **Erro de Integridade** | MsgBox "Você não pode EXCLUIR este registro - Integridade Referencial" | JSON `{"detail": "Não é possível excluir cliente com dependentes", "status_code": 409}` | ✅ |
| **Erro de Autenticação** | MsgBox (3 tentativas, sistema encerra) | JSON `{"detail": "Credenciais inválidas", "status_code": 401}` | ✅ |
| **Erro de Multa** | MsgBox "Não existe registro para EXCLUIR" (exemplo) | JSON `{"detail": "Devolução após data prevista aplica multa de R$ 3,50/dia", "status_code": 400}` | ✅ |

**Validação de Response:**
- Todas as respostas devem conter `detail` (mensagem amigável)
- Erros de negócio devem ter `status_code` (ex: 409 para conflito, 400 para validação)
- Sucesso deve ter `status_code` 200/201/204

**Justificativa:** Novo sistema usa HTTP status codes padrão. Detalhes devem ser equivalentes ou mais claros que mensagens genéricas do legado.

---

### 9. Calculation Parity

| Cálculo | Legado | Novo | Status |
|----------|--------|------|--------|
| **Data Prevista (24h)** | data + 1 dia; se domingo: +1 dia extra | `CalculationService.calcular_data_prevista(data, "24h")` | ✅ |
| **Data Prevista (48h)** | data + 2 dias; se domingo: +1 dia extra | `CalculationService.calcular_data_prevista(data, "48h")` | ✅ |
| **Multa (por atraso)** | Não especificado no código (LACUNA) | R$ 3,50 * dias_atraso (BR-MIGRAR-033) | ✅ |
| **Valor Total do Recibo** | Soma dos valores dos itens + multa | `ReceiptService.calcular_total(locacao, multa)` | ✅ |

**Validação de Cálculo:**
- Data prevista deve seguir regra de domingo (BR-MIGRAR-025, BR-MIGRAR-026)
- Multa deve ser R$ 3,50 por dia de atraso (BR-MIGRAR-033)
- Zero multa se devolução no prazo

**Justificativa:** Cálculos no novo sistema são implementados em serviços dedicados (`CalculationService`, `ReceiptService`), facilitando testes e manutenção.

---

### 10. Transaction Parity

| Operação | Legado | Novo | Status |
|-----------|--------|------|--------|
| **Locação** | Acesso direto ao banco (DAO) | `async with async_session.begin():` (BR-MIGRAR-029) | ✅ |
| **Atualização de CD** | Acesso direto (sem transação) | Atualização dentro da mesma transação de locação | ✅ |
| **Criação de Recibo** | Acesso direto (sem transação) | Criação dentro da mesma transação de locação | ✅ |
| **Devolução** | Acesso direto (sem transação) | Transação SQL (BEGIN...COMMIT) (BR-MIGRAR-029) | ✅ |

**Validação de Transação:**
- Locação deve ser atômica: `CREATE locacao`, `INSERT items`, `UPDATE cd situacao` e `UPDATE recibo` na mesma transação
- Se falhar em qualquer passo: rollback completo (nenhum registro parcialmente salvo)
- Devolução deve ser atômica: `UPDATE cd situacao`, `UPDATE recibo devolvido`, `UPDATE locacao` na mesma transação

**Justificativa:** O novo sistema usa async transactions do SQLAlchemy, garantindo atomicidade. Legado não tinha controle explícito, o que era gap (BR-MIGRAR-029). Novo sistema preenche esse gap.

---

## Planos de Teste

### 1. Shadow Mode (Opcional)

| Fase | Duração | Responsável | Objetivo |
|------|---------|-------------|----------|
| **Setup** | 1 dia | DevOps | Configurar PostgreSQL como read-replica de Access (ou snapshot) |
| **Operação Paralela** | 7-14 dias | QA | Operar legado e novo simultaneamente, comparar resultados críticos |
| **Validação de Cálculos** | Contínuo | QA | Verificar multa e data prevista em casos reais |
| **Validação de Estoque** | Contínuo | QA | Verificar disponibilidade de CDs em ambos sistemas |
| **Rollback ou Go-Live** | 1 dia | Liderança | Se Shadow Mode OK, novo sistema se torna produtivo; senão, rollback |

**Critérios de Sucesso:**
- Divergência de cálculos < 1%
- Estoque consistente em ambos
- Nenhum erro crítico reportado

---

### 2. Characterization Tests

| Cenário | Modo | Critério de Sucesso | Prioridade |
|----------|------|---------------------|-----------|
| **Formato de Data** | `@characterization` | Data exibida no formato `YYYY-MM-DD` mas convertida para `dd/mm/yyyy` no payload | Alta |
| **Validação de CPF** | `@characterization` | CPF válido (11 dígitos, verificador OK) | Alta |
| **Validação de Data Nascimento** | `@characterization` | Data >= 1900 e <= atual | Alta |
| **Tratamento de Erro** | `@characterization` | Erro retorna HTTP 500 com mensagem descritiva | Média |

---

### 3. Contract Tests (OpenAPI/Swagger)

| Cenário | Modo | Critério de Sucesso | Prioridade |
|----------|------|---------------------|-----------|
| **Autenticação** | `@contract` | Login retorna JWT válido com claims | Crítica |
| **Criação de Cliente** | `@contract` | POST /clientes/ cria cliente e retorna 201 com dados completos | Alta |
| **Bloqueio de Cliente Cancelado** | `@contract` | DELETE /clientes/{id} bloqueado se is_cancelado = True | Alta |
| **Locação** | `@contract` | POST /rentals/ cria locação, recibo e itens, retorna 201 | Crítica |
| **Devolução** | `@contract` | POST /rentals/{id}/devolucao calcula multa e retorna 200 | Crítica |
| **Validação de Campos** | `@contract` | Validação Pydantic executa para todos os campos obrigatórios | Alta |
| **Resposta de Erro** | `@contract` | Erros retornam JSON com `detail` e `status_code` | Alta |

---

### 4. Data Parity

| Tabela | Teste | Critério de Sucesso | Prioridade |
|--------|------|---------------------|-----------|
| `clientes` | `@data_parity` | COUNT(*) legado = COUNT(*) novo | Crítica |
| `cds` | `@data_parity` | COUNT(*) legado = COUNT(*) novo | Crítica |
| `locacoes` | `@data_parity` | COUNT(*) legado = COUNT(*) novo | Crítica |
| `reservas` | `@data_parity` | COUNT(*) legado = COUNT(*) novo | Crítica |

**Justificativa:** Dados são o ativo crítico. Contagens devem ser idênticas.

---

### 5. Integrity Parity

| Cenário | Teste | Critério de Sucesso | Prioridade |
|----------|------|---------------------|-----------|
| **FK: Dependente → Cliente** | `@integrity` | Todos os dependentes têm cliente válido | Alta |
| **FK: CD → Título** | `@integrity` | Todos os CDs têm título válido | Alta |
| **FK: Locação → Cliente** | `@integrity` | Todas as locações têm cliente válido | Alta |
| **FK: Item de Locação → CD** | `@integrity` | Todos os itens têm CD válido | Alta |
| **FK: Recibo → Locação** | `@integrity` | Todos os recibos têm locação válida | Alta |
| **FK: Reserva → Cliente** | `@integrity` | Todas as reservas têm cliente válido | Alta |

**Justificativa:** Integridade referencial é essencial para consistência.

---

## Modos de Validação

| Modo | Descrição | Critérios |
|------|-----------|-----------|
| **`@critical`** | Bloqueia cutover se falhar. Deve ser usado para testes que validam funcionalidade crítica (multa, estoque, autenticação). |
| **`@high`** | Prioridade alta para correção antes do cutover. |
| **`@medium`** | Prioridade média para correção antes do cutover. |
| **`@low`** | Prioridade baixa, pode ser corrigido após cutover se não afeta funcionalidade crítica. |

---

## Rastreabilidade

| Aspecto | Local de Rastreabilidade |
|---------|--------------------------|
| **Testes de Paridade** | `_reversa_sdd/migration/parity_tests/` |
| **Logs de Comparação** | Logs em arquivo ou Sentry |
| **Decisões de Correção** | Documentadas em `parity_tests/` |

---

## Notas

1. **Priorização de Testes:** Testes de cálculo de multa e transação atômica são críticos (afetam receita e estoque). Devem ser validados exaustivamente.

2. **Adaptação de Formatos:** Legado usa `dd/mm/yyyy` exibido em máscaras. Novo sistema usa `YYYY-MM-DD` internamente (ISO 8601). Payloads devem converter para o formato esperado pelo frontend (ou vice-versa) para UX compatível.

3. **Validação de CPF:** Implementar algoritmo do dígito verificador (BR-MIGRAR-010). Validação deve ser feita em Pydantic validator (`CPFValidator`).

4. **Testes de Idempotência:** Como o sistema é event-driven, testes devem validar que consumir o mesmo evento múltiplas vezes não altera o estado final (sem side effects extras).

5. **Cobertura Mínima:** Testes devem cobrir todos os endpoints públicos críticos (autenticação, locação, devolução, clientes) e bounded contexts principais (catalog, customers, rentals).
