---
schemaVersion: 1
generatedAt: 2026-05-12T00:00:00Z
reversa:
  version: "1.2.34"
kind: target_data_model
producedBy: designer
hash: "sha256:<hash do corpo abaixo do front-matter>"
---

# Target Data Model — CDsLoc

> Esquema de dados PostgreSQL do sistema novo.
> Topologia: Hexagonal com Bounded Contexts (Opção 2 de `topology_decision.md`).

---

## Resumo

| Bounded Context | Tabelas Principais | Tabelas Auxiliares | Total |
|----------------|---------------------|---------------------|-------|
| **Auth** | users, roles, roles_users | - | 3 |
| **Catalog** | titles, musicas, interpreters, titulos_musicas, titulos_interpretes, cds | grupos, estilos | 8 |
| **Customers** | clientes, dependentes, bairros, municipios | - | 4 |
| **Rentals** | locacoes, locacoes_itens, recibos, recibo_itens | - | 4 |
| **Reservations** | reservas | - | 1 |
| **Reports** | relatorio_specs | - | 1 |
| **Shared** | domain_events | - | 1 |
| **TOTAL** | 18 | 4 | 22 |

---

## Convenções de Nomenclatura

| Tipo | Convenção | Exemplo |
|------|-----------|---------|
| Tabelas | Plural, minúsculas, underscore separador | `clientes`, `locacoes_itens` |
| Colunas PK | `id` + nome da tabela | `clientes.id` |
| Colunas FK | `id` + nome da tabela referenciada | `locacoes.id_cliente` |
| Colunas timestamp | `_at` sufixo | `created_at`, `data_locacao_at` |
| Colunas boolean | prefixo `is_` ou sufixo `_bool` | `is_cancelado`, `locado_bool` |
| Colunas enum | `_id` sufixo para ID | `situacao_id` |

---

## Bounded Context: Auth

### Tabela: users

| Coluna | Tipo | PK/FK | Descrição | Default | Check |
|---------|------|--------|-----------|----------|-------|
| id | SERIAL | PK | Auto-incremento | - | NOT NULL |
| email | VARCHAR(255) | UNIQUE | Email do usuário | - | NOT NULL, CHECK (email LIKE '%@%') |
| password_hash | VARCHAR(255) | - | Hash bcrypt da senha | - | NOT NULL |
| salt | VARCHAR(64) | - | Salt bcrypt | - | NOT NULL |
| active | BOOLEAN | - | Usuário ativo | TRUE | NOT NULL |
| created_at | TIMESTAMP | - | Data/hora de criação | NOW() | NOT NULL |
| last_login_at | TIMESTAMP | - | Último login | NULL | - |
| updated_at | TIMESTAMP | - | Data/hora de atualização | NOW() | - |

**Índices:**
- `idx_users_email`: `email` (UNIQUE)
- `idx_users_active`: `active` (para login)

---

### Tabela: roles

| Coluna | Tipo | PK/FK | Descrição | Default | Check |
|---------|------|--------|-----------|----------|-------|
| id | SERIAL | PK | Auto-incremento | - | NOT NULL |
| nome | VARCHAR(100) | UNIQUE | Nome da role | - | NOT NULL |
| permissions | JSONB | - | Lista de permissões (ex: ["rentals:read", "rentals:write"]) | '[]'::jsonb | NOT NULL |
| created_at | TIMESTAMP | - | Data/hora de criação | NOW() | NOT NULL |
| updated_at | TIMESTAMP | - | Data/hora de atualização | NOW() | - |

**Índices:**
- `idx_roles_nome`: `nome` (UNIQUE)

---

### Tabela: roles_users

| Coluna | Tipo | PK/FK | Descrição | Default |
|---------|------|--------|-----------|----------|
| id | SERIAL | PK | Auto-incremento | - | NOT NULL |
| id_user | INT | FK → users.id | ID do usuário | - | NOT NULL, FK (users.id ON DELETE CASCADE) |
| id_role | INT | FK → roles.id | ID da role | - | NOT NULL, FK (roles.id ON DELETE CASCADE) |
| assigned_at | TIMESTAMP | - | Data/hora de atribuição | NOW() | NOT NULL |
| revoked_at | TIMESTAMP | - | Data/hora de revogação | NULL | - |
| created_at | TIMESTAMP | - | Data/hora de criação | NOW() | NOT NULL |

**Índices:**
- `idx_roles_users_user_role`: `id_user, id_role` (UNIQUE)
- `idx_roles_users_revoked`: `revoked_at` (para ativas)

---

## Bounded Context: Catalog

### Tabela: grupos

| Coluna | Tipo | PK/FK | Descrição | Default |
|---------|------|--------|-----------|----------|
| id | SERIAL | PK | Auto-incremento | - | NOT NULL |
| nome | VARCHAR(100) | UNIQUE | Nome do grupo | - | NOT NULL |
| descricao | TEXT | - | Descrição | NULL | - |
| created_at | TIMESTAMP | - | Data/hora de criação | NOW() | NOT NULL |
| updated_at | TIMESTAMP | - | Data/hora de atualização | NOW() | - |

**Índices:**
- `idx_grupos_nome`: `nome` (UNIQUE)

---

### Tabela: estilos

| Coluna | Tipo | PK/FK | Descrição | Default |
|---------|------|--------|-----------|----------|
| id | SERIAL | PK | Auto-incremento | - | NOT NULL |
| nome | VARCHAR(100) | UNIQUE | Nome do estilo | - | NOT NULL |
| descricao | TEXT | - | Descrição | NULL | - |
| created_at | TIMESTAMP | - | Data/hora de criação | NOW() | NOT NULL |
| updated_at | TIMESTAMP | - | Data/hora de atualização | NOW() | - |

**Índices:**
- `idx_estilos_nome`: `nome` (UNIQUE)

---

### Tabela: titulos

| Coluna | Tipo | PK/FK | Descrição | Default | Check |
|---------|------|--------|-----------|----------|-------|
| id | SERIAL | PK | Auto-incremento | - | NOT NULL |
| nome | VARCHAR(255) | - | Nome do título (álbum) | - | NOT NULL |
| tipo_locacao | VARCHAR(10) | - | Tipo de locação (24h/48h) | - | NOT NULL, CHECK (tipo_locacao IN ('24h', '48h')) |
| valor | DECIMAL(10,2) | - | Valor de locação | - | NOT NULL, CHECK (valor > 0) |
| qtde | INT | - | Quantidade de CDs físicos deste título | 0 | NOT NULL, CHECK (qtde >= 0) |
| id_grupo | INT | FK → grupos.id | Grupo (opcional) | NULL | FK (grupos.id ON DELETE SET NULL) |
| id_estilo | INT | FK → estilos.id | Estilo (opcional) | NULL | FK (estilos.id ON DELETE SET NULL) |
| created_at | TIMESTAMP | - | Data/hora de criação | NOW() | NOT NULL |
| updated_at | TIMESTAMP | - | Data/hora de atualização | NOW() | - |

**Índices:**
- `idx_titulos_grupo`: `id_grupo`
- `idx_titulos_estilo`: `id_estilo`
- `idx_titulos_tipo`: `tipo_locacao`

---

### Tabela: musicas

| Coluna | Tipo | PK/FK | Descrição | Default |
|---------|------|--------|-----------|----------|
| id | SERIAL | PK | Auto-incremento | - | NOT NULL |
| nome | VARCHAR(255) | - | Nome da música | - | NOT NULL |
| tempo | INT | - | Duração em segundos (opcional) | NULL | CHECK (tempo >= 0) |
| created_at | TIMESTAMP | - | Data/hora de criação | NOW() | NOT NULL |
| updated_at | TIMESTAMP | - | Data/hora de atualização | NOW() | - |

**Índices:**
- `idx_musicas_nome`: `nome` (para busca)

---

### Tabela: interpretes

| Coluna | Tipo | PK/FK | Descrição | Default |
|---------|------|--------|-----------|----------|
| id | SERIAL | PK | Auto-incremento | - | NOT NULL |
| nome | VARCHAR(255) | - | Nome do intérprete | - | NOT NULL |
| created_at | TIMESTAMP | - | Data/hora de criação | NOW() | NOT NULL |
| updated_at | TIMESTAMP | - | Data/hora de atualização | NOW() | - |

**Índices:**
- `idx_interpretes_nome`: `nome` (UNIQUE)

---

### Tabela: titulos_musicas

| Coluna | Tipo | PK/FK | Descrição | Default |
|---------|------|--------|-----------|----------|
| id | SERIAL | PK | Auto-incremento | - | NOT NULL |
| id_titulo | INT | FK → titulos.id | ID do título | - | NOT NULL, FK (titulos.id ON DELETE CASCADE) |
| id_musica | INT | FK → musicas.id | ID da música | - | NOT NULL, FK (musicas.id ON DELETE CASCADE) |
| created_at | TIMESTAMP | - | Data/hora de criação | NOW() | NOT NULL |

**Índices:**
- `idx_titulos_musicas_titulo_musica`: `id_titulo, id_musica` (UNIQUE)

---

### Tabela: titulos_interpretes

| Coluna | Tipo | PK/FK | Descrição | Default |
|---------|------|--------|-----------|----------|
| id | SERIAL | PK | Auto-incremento | - | NOT NULL |
| id_titulo | INT | FK → titulos.id | ID do título | - | NOT NULL, FK (titulos.id ON DELETE CASCADE) |
| id_interprete | INT | FK → interpretes.id | ID do intérprete | - | NOT NULL, FK (interpretes.id ON DELETE CASCADE) |
| created_at | TIMESTAMP | - | Data/hora de criação | NOW() | NOT NULL |

**Índices:**
- `idx_titulos_interpretes_titulo_interprete`: `id_titulo, id_interprete` (UNIQUE)

---

### Tabela: cds

| Coluna | Tipo | PK/FK | Descrição | Default | Check |
|---------|------|--------|-----------|----------|-------|
| codigo | VARCHAR(10) | UNIQUE | Código do CD físico (herança legado) | - | NOT NULL |
| id_titulo | INT | FK → titulos.id | ID do título | - | NOT NULL, FK (titulos.id ON DELETE CASCADE) |
| numcd | VARCHAR(50) | - | Número de identificação do CD | - | NOT NULL |
| situacao_id | INT | - | Situação (Disponível/Locado/Reservado) | 1 | NOT NULL, FK (situacoes.id) |
| is_locado | BOOLEAN | - | CD está locado | FALSE | NOT NULL |
| data_cp | DATE | - | Data de compra | NULL | - |
| valor_cp | DECIMAL(10,2) | - | Valor de compra | NULL | - |
| created_at | TIMESTAMP | - | Data/hora de criação | NOW() | NOT NULL |
| updated_at | TIMESTAMP | - | Data/hora de atualização | NOW() | - |

**Índices:**
- `idx_cds_codigo`: `codigo` (UNIQUE)
- `idx_cds_titulo`: `id_titulo`
- `idx_cds_situacao`: `situacao_id`
- `idx_cds_locado`: `is_locado` (para disponíveis)

**Origem Legado:** Campo `situacao` (VARCHAR) → `situacao_id` (INT FK) com tabela auxiliar `situacoes`.

---

### Tabela: situacoes

| Coluna | Tipo | PK/FK | Descrição | Default |
|---------|------|--------|-----------|----------|
| id | INT | PK | ID da situação | - | NOT NULL |
| nome | VARCHAR(50) | UNIQUE | Nome da situação | - | NOT NULL |
| descricao | TEXT | - | Descrição | - | - |

**Dados iniciais:**
- (1, 'Disponível', 'CD disponível para locação')
- (2, 'Locado', 'CD está com cliente')
- (3, 'Reservado', 'CD reservado para retirada')

---

## Bounded Context: Customers

### Tabela: bairros

| Coluna | Tipo | PK/FK | Descrição | Default |
|---------|------|--------|-----------|----------|
| id | SERIAL | PK | Auto-incremento | - | NOT NULL |
| cdbairro | VARCHAR(10) | UNIQUE | Código do bairro (herança legado) | - | NOT NULL |
| debairro | VARCHAR(100) | - | Nome do bairro | - | NOT NULL |
| id_municipio | INT | FK → municipios.id | ID do município | NULL | FK (municipios.id ON DELETE SET NULL) |
| created_at | TIMESTAMP | - | Data/hora de criação | NOW() | NOT NULL |
| updated_at | TIMESTAMP | - | Data/hora de atualização | NOW() | - |

**Índices:**
- `idx_bairros_codigo`: `cdbairro` (UNIQUE)
- `idx_bairros_municipio`: `id_municipio`

---

### Tabela: municipios

| Coluna | Tipo | PK/FK | Descrição | Default |
|---------|------|--------|-----------|----------|
| id | SERIAL | PK | Auto-incremento | - | NOT NULL |
| nome | VARCHAR(100) | - | Nome do município | - | NOT NULL |
| uf | CHAR(2) | - | UF (sigla) | - | NOT NULL, CHECK (uf ~ '[A-Z]{2}') |
| created_at | TIMESTAMP | - | Data/hora de criação | NOW() | NOT NULL |
| updated_at | TIMESTAMP | - | Data/hora de atualização | NOW() | - |

**Índices:**
- `idx_municipios_uf`: `uf`
- `idx_municipios_nome`: `nome` (para busca)

---

### Tabela: clientes

| Coluna | Tipo | PK/FK | Descrição | Default | Check |
|---------|------|--------|-----------|----------|-------|
| id | SERIAL | PK | Auto-incremento | - | NOT NULL |
| codcliente | VARCHAR(10) | UNIQUE | Código do cliente (herança legado) | - | NOT NULL |
| nomecliente | VARCHAR(255) | - | Nome do cliente | - | NOT NULL |
| endereco | VARCHAR(255) | - | Endereço | - | NOT NULL |
| data_nascimento | DATE | - | Data de nascimento | - | NOT NULL |
| cdbairro | INT | FK → bairros.id | Bairro | - | NOT NULL, FK (bairros.id) |
| cep | VARCHAR(10) | - | CEP | NULL | - |
| fone_01 | VARCHAR(15) | - | Telefone residencial | NULL | - |
| ramal_res | VARCHAR(10) | - | Ramal residencial | NULL | - |
| fone_02 | VARCHAR(15) | - | Telefone comercial | NULL | - |
| ramal_trab | VARCHAR(10) | - | Ramal trabalho | NULL | - |
| fone_03 | VARCHAR(15) | - | Telefone referencial | NULL | - |
| identidade | VARCHAR(20) | - | RG | - | NOT NULL |
| expedidor | VARCHAR(20) | - | Órgão expedidor | NULL | - |
| data_expedicao | DATE | - | Data de expedição | NULL | - |
| cic | VARCHAR(14) | - | CPF | NULL | CHECK (cic ~ '^\d{11}$') |
| empresa | VARCHAR(255) | - | Empresa | NULL | - |
| end_comercial | VARCHAR(255) | - | Endereço comercial | NULL | - |
| referencia_pessoal | VARCHAR(255) | - | Referência pessoal | NULL | - |
| data_inscricao | DATE | - | Data de inscrição | NOW() | - |
| is_cancelado | BOOLEAN | - | Cliente cancelado | FALSE | NOT NULL |
| obs | TEXT | - | Observações | NULL | - |
| created_at | TIMESTAMP | - | Data/hora de criação | NOW() | NOT NULL |
| updated_at | TIMESTAMP | - | Data/hora de atualização | NOW() | - |

**Índices:**
- `idx_clientes_codcliente`: `codcliente` (UNIQUE)
- `idx_clientes_nome`: `nomecliente` (para busca LIKE)
- `idx_clientes_cpf`: `cic` (para busca)
- `idx_clientes_cancelado`: `is_cancelado` (para ativos)

**Checks:**
- CHECK (data_nascimento >= '1900-01-01' AND data_nascimento <= CURRENT_DATE): Validação de idade mínima (BR-MIGRAR-008)

---

### Tabela: dependentes

| Coluna | Tipo | PK/FK | Descrição | Default |
|---------|------|--------|-----------|----------|
| id | SERIAL | PK | Auto-incremento | - | NOT NULL |
| cod_dependente | VARCHAR(10) | UNIQUE | Código do dependente (herança legado) | - | NOT NULL |
| id_cliente | INT | FK → clientes.id | Cliente titular | - | NOT NULL, FK (clientes.id ON DELETE CASCADE) |
| nome_dependente | VARCHAR(255) | - | Nome do dependente | - | NOT NULL |
| created_at | TIMESTAMP | - | Data/hora de criação | NOW() | NOT NULL |
| updated_at | TIMESTAMP | - | Data/hora de atualização | NOW() | - |

**Índices:**
- `idx_dependentes_coddependente`: `cod_dependente` (UNIQUE)
- `idx_dependentes_id_cliente`: `id_cliente` (para listar por cliente)

**Origem Legado:** Campo `cod_dependente` do legado → PK serial gerada.

---

## Bounded Context: Rentals

### Tabela: locacoes

| Coluna | Tipo | PK/FK | Descrição | Default |
|---------|------|--------|-----------|----------|
| id | SERIAL | PK | Auto-incremento | - | NOT NULL |
| id_cliente | INT | FK → clientes.id | Cliente que locou | - | NOT NULL, FK (clientes.id ON DELETE CASCADE) |
| id_dependente | INT | FK → dependentes.id | Dependente autorizado | NULL | FK (dependentes.id ON DELETE SET NULL) |
| data_locacao | TIMESTAMP | - | Data/hora da locação | NOW() | NOT NULL |
| data_prevista | DATE | - | Data prevista de devolução | - | NOT NULL |
| valor_locacao | DECIMAL(10,2) | - | Valor total da locação | - | NOT NULL |
| valor_multa | DECIMAL(10,2) | - | Valor da multa (se aplicável) | 0.00 | NOT NULL, CHECK (valor_multa >= 0) |
| created_at | TIMESTAMP | - | Data/hora de criação | NOW() | NOT NULL |
| updated_at | TIMESTAMP | - | Data/hora de atualização | NOW() | - |

**Índices:**
- `idx_locacoes_cliente`: `id_cliente`
- `idx_locacoes_dependente`: `id_dependente`
- `idx_locacoes_data_locacao`: `data_locacao`
- `idx_locacoes_data_prevista`: `data_prevista`

**Origem Legado:** Campos `data_locacao`, `data_prevista`, `valor_locacao` do legado. Cálculo de `data_prevista` deve considerar ajuste de domingo (BR-MIGRAR-025, BR-MIGRAR-026). Cálculo de `valor_multa` = dias_atraso * 3.50 (BR-MIGRAR-033).

---

### Tabela: locacoes_itens

| Coluna | Tipo | PK/FK | Descrição | Default |
|---------|------|--------|-----------|----------|
| id | SERIAL | PK | Auto-incremento | - | NOT NULL |
| id_locacao | INT | FK → locacoes.id | ID da locação | - | NOT NULL, FK (locacoes.id ON DELETE CASCADE) |
| id_cd | VARCHAR(10) | FK → cds.codigo | CD locado | - | NOT NULL, FK (cds ON DELETE CASCADE) |
| valor_item | DECIMAL(10,2) | - | Valor do item (de title.valor) | - | NOT NULL |
| created_at | TIMESTAMP | - | Data/hora de criação | NOW() | NOT NULL |
| updated_at | TIMESTAMP | - | Data/hora de atualização | NOW() | - |

**Índices:**
- `idx_locacoes_itens_locacao`: `id_locacao`
- `idx_locacoes_itens_cd`: `id_cd`

**Origem Legado:** Campo `id_cd` vincula à tabela `cds` (legado: Wcdfisico). Valor do item vem de `titulos.valor`.

---

### Tabela: recibos

| Coluna | Tipo | PK/FK | Descrição | Default | Check |
|---------|------|--------|-----------|----------|-------|
| id | SERIAL | PK | Auto-incremento | - | NOT NULL |
| id_locacao | INT | FK → locacoes.id | Locação principal | - | NOT NULL, FK (locacoes.id ON DELETE CASCADE) |
| id_cliente | INT | FK → clientes.id | Cliente da locação | - | NOT NULL, FK (clientes.id ON DELETE CASCADE) |
| data_emissao | TIMESTAMP | - | Data/hora de emissão | NOW() | NOT NULL |
| valor_total | DECIMAL(10,2) | - | Valor total (locação + multa) | - | NOT NULL |
| is_devolvido | BOOLEAN | - | Recibo baixado | FALSE | NOT NULL |
| data_devolucao | TIMESTAMP | - | Data/hora de devolução | NULL | - |
| created_at | TIMESTAMP | - | Data/hora de criação | NOW() | NOT NULL |
| updated_at | TIMESTAMP | - | Data/hora de atualização | NOW() | - |

**Índices:**
- `idx_recibos_locacao`: `id_locacao`
- `idx_recibos_cliente`: `id_cliente`
- `idx_recibos_devolvido`: `is_devolvido` (para pendentes)

**Origem Legado:** Campo `valor_total` = soma dos itens + multa. `data_devolucao` preenchido quando baixado.

---

### Tabela: recibo_itens

| Coluna | Tipo | PK/FK | Descrição | Default |
|---------|------|--------|-----------|----------|
| id | SERIAL | PK | Auto-incremento | - | NOT NULL |
| id_recibo | INT | FK → recibos.id | ID do recibo | - | NOT NULL, FK (recibos.id ON DELETE CASCADE) |
| id_cd | VARCHAR(10) | FK → cds.codigo | CD do item | - | NOT NULL, FK (cds ON DELETE CASCADE) |
| valor_item | DECIMAL(10,2) | - | Valor do item | - | NOT NULL |
| created_at | TIMESTAMP | - | Data/hora de criação | NOW() | NOT NULL |
| updated_at | TIMESTAMP | - | Data/hora de atualização | NOW() | - |

**Índices:**
- `idx_recibo_itens_recibo`: `id_recibo`
- `idx_recibo_itens_cd`: `id_cd`

---

## Bounded Context: Reservations

### Tabela: reservas

| Coluna | Tipo | PK/FK | Descrição | Default | Check |
|---------|------|--------|-----------|----------|-------|
| id | SERIAL | PK | Auto-incremento | - | NOT NULL |
| id_cliente | INT | FK → clientes.id | Cliente que reservou | - | NOT NULL, FK (clientes.id ON DELETE CASCADE) |
| id_titulo | INT | FK → titulos.id | Título reservado | - | NOT NULL, FK (titulos.id ON DELETE CASCADE) |
| data_reserva | TIMESTAMP | - | Data/hora da reserva | NOW() | NOT NULL |
| data_prevista | DATE | - | Data prevista para retirada (baseada na disponibilidade) | - | NOT NULL |
| situacao_id | INT | - | Situação (Pendente/Confirmada/Locada/Cancelada) | 1 | NOT NULL, FK (situacoes_reservas.id) |
| created_at | TIMESTAMP | - | Data/hora de criação | NOW() | NOT NULL |
| updated_at | TIMESTAMP | - | Data/hora de atualização | NOW() | - |

**Índices:**
- `idx_reservas_cliente`: `id_cliente`
- `idx_reservas_titulo`: `id_titulo`
- `idx_reservas_data_reserva`: `data_reserva`
- `idx_reservas_situacao`: `situacao_id`

**Origem Legado:** Campo `situacao` (VARCHAR) → `situacao_id` (INT FK) com tabela auxiliar `situacoes_reservas`. `data_prevista` calculada baseada na disponibilidade (BR-MIGRAR-043).

---

### Tabela: situacoes_reservas

| Coluna | Tipo | PK/FK | Descrição | Default |
|---------|------|--------|-----------|----------|
| id | INT | PK | ID da situação | - | NOT NULL |
| nome | VARCHAR(50) | UNIQUE | Nome da situação | - | NOT NULL |
| descricao | TEXT | - | Descrição | - | - |

**Dados iniciais:**
- (1, 'Pendente', 'Reserva criada, aguardando conversão')
- (2, 'Confirmada', 'Reserva convertida em locação')
- (3, 'Locada', 'CD reservado foi locado')
- (4, 'Cancelada', 'Reserva cancelada')

**Origem Legado:** Novo conceito adicionado para suportar o fluxo completo de reservas (BR-MIGRAR-042, BR-MIGRAR-021).

---

## Bounded Context: Reports

### Tabela: relatorio_specs

| Coluna | Tipo | PK/FK | Descrição | Default |
|---------|------|--------|-----------|----------|
| id | SERIAL | PK | Auto-incremento | - | NOT NULL |
| tipo | VARCHAR(50) | - | Tipo de relatório (clientes_sintetico, clientes_analitico, clientes_dependentes, musicas, cds, titulos, reservas) | - | NOT NULL, CHECK (tipo IN (...)) |
| template | VARCHAR(255) | - | Caminho do template Jinja2 | - | NOT NULL |
| descricao | TEXT | - | Descrição do relatório | - | - |
| created_at | TIMESTAMP | - | Data/hora de criação | NOW() | NOT NULL |
| updated_at | TIMESTAMP | - | Data/hora de atualização | NOW() | - |

**Índices:**
- `idx_relatorio_specs_tipo`: `tipo`

**Origem Legado:** Substitui Crystal Reports (*.rpt) por HTML/PDF dinâmico (BR-DESCARTAR-004, BR-HUMANA-002). Tipos de relatório correspondem aos 8 relatórios legados.

---

## Shared: Domain Events

### Tabela: domain_events

| Coluna | Tipo | PK/FK | Descrição | Default |
|---------|------|--------|-----------|----------|
| id | BIGSERIAL | PK | Auto-incremento | - | NOT NULL |
| event_type | VARCHAR(255) | - | Tipo do evento (ex: LocacaoCriada, DevolucaoRegistrada) | - | NOT NULL |
| event_data | JSONB | - | Payload do evento (serializado) | - | NOT NULL |
| aggregate_type | VARCHAR(100) | - | Tipo do agregado (ex: Locacao, Recibo) | - | NOT NULL |
| aggregate_id | VARCHAR(100) | - | ID do agregado (ex: id da locação) | - | NOT NULL |
| occurred_at | TIMESTAMP | - | Data/hora do evento | NOW() | NOT NULL |
| correlation_id | UUID | - | ID de correlação (para tracing) | NULL | - |
| created_at | TIMESTAMP | - | Data/hora de criação | NOW() | NOT NULL |

**Índices:**
- `idx_domain_events_type`: `event_type`
- `idx_domain_events_aggregate`: `aggregate_type, aggregate_id`
- `idx_domain_events_occurred`: `occurred_at` (para TTL)

**Origem Legado:** Novo conceito para suportar event-driven (paradigma escolhido). Eventos podem ser:
- `LocacaoCriada` (quando recibo é gerado)
- `DevolucaoRegistrada` (quando recibo é baixado)
- `MultaCalculada` (quando multa é aplicada)

---

## Tabelas Auxiliares Compartilhadas

### Tabela: situacoes

Já definida no contexto Catalog, mas usada por CDs e Reservations.

---

## Views e Funções

### Função: calcular_data_prevista(data_base, tipo_locacao)

```sql
CREATE OR REPLACE FUNCTION calcular_data_prevista(data_base DATE, tipo_locacao VARCHAR)
RETURNS DATE AS $$
BEGIN
    DECLARE dias INTEGER;
    DECLARE data_prevista DATE;
    
    IF tipo_locacao = '24h' THEN
        dias := 1;
    ELSE
        dias := 2;
    END IF;
    
    data_prevista := data_base + (dias || ' days')::INTERVAL;
    
    -- Ajuste para domingo
    IF EXTRACT(DOW FROM data_prevista) = 0 THEN
        data_prevista := data_prevista + '1 day'::INTERVAL;
    END IF;
    
    RETURN data_prevista;
END;
$$ LANGUAGE plpgsql;
```

**Justificativa:** Implementa regras BR-MIGRAR-025 e BR-MIGRAR-026 com ajuste de domingo.

---

### Função: calcular_dias_atraso(data_devolucao, data_prevista)

```sql
CREATE OR REPLACE FUNCTION calcular_dias_atraso(data_devolucao TIMESTAMP, data_prevista DATE)
RETURNS INTEGER AS $$
BEGIN
    DECLARE dias_atraso INTEGER;
    
    dias_atraso := EXTRACT(DAY FROM DATE(data_devolucao)) - data_prevista;
    
    IF dias_atraso < 0 THEN
        RETURN 0;
    END IF;
    
    RETURN dias_atraso;
END;
$$ LANGUAGE plpgsql;
```

**Justificativa:** Implementa regra BR-MIGRAR-032.

---

### View: vw_clientes_ativos

```sql
CREATE OR REPLACE VIEW vw_clientes_ativos AS
SELECT 
    id,
    codcliente,
    nomecliente,
    endereco,
    data_nascimento,
    cep,
    fone_01,
    fone_02
FROM clientes
WHERE is_cancelado = FALSE;
```

**Justificativa:** View para consultas frequentes de clientes ativos.

---

## Constraints e Triggers

### Trigger: atualizar_qtde_titulo

```sql
CREATE OR REPLACE FUNCTION trg_atualizar_qtde_titulo()
RETURNS TRIGGER AS $$
BEGIN
    UPDATE titulos
    SET qtde = (SELECT COUNT(*) FROM cds WHERE id_titulo = NEW.id_titulo)
    WHERE id = NEW.id_titulo;
    
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER tr_titulos_insert_qtde
AFTER INSERT ON cds
FOR EACH ROW EXECUTE FUNCTION trg_atualizar_qtde_titulo(NEW);

CREATE TRIGGER tr_titulos_delete_qtde
AFTER DELETE ON cds
FOR EACH ROW EXECUTE FUNCTION trg_atualizar_qtde_titulo(OLD);
```

**Justificativa:** Implementa regra BR-MIGRAR-0017 (estoque atualizado automaticamente). Trigger garante atomicidade.

---

## Notas de Migração

### Transformações por Coluna

| Tabela Legado | Tabela Nova | Coluna | Transformação |
|---------------|-------------|--------|----------------|
| Cliente | clientes | nomecliente | Renomeação (sem espaços) |
| Cliente | clientes | data-nascimento | Substituição por underscore (snake_case) |
| Cliente | clientes | cancelado | Renomeação para is_cancelado (boolean) |
| Cliente | clientes | cdbairro | Substituição por id_bairro (FK) |
| cd | cds | situacao | Substituição por situacao_id (FK) + tabela situacoes |
| cd | cds | locado | Renomeação para is_locado (boolean) |
| locacao | locacoes | data-locacao | Renomeação para data_locacao (snake_case) |
| reserva | reservas | situacao | Substituição por situacao_id (FK) + tabela situacoes_reservas |

### Conversão de Tipos

| Tipo Legado (Access) | Tipo PostgreSQL | Justificativa |
|---------------------|-------------------|-------------|
| TEXT | VARCHAR(255) ou TEXT | PostgreSQL não tem TEXT sem limites |
| CURRENCY | DECIMAL(10,2) | PostgreSQL não tem CURRENCY, DECIMAL é padrão financeiro |
| BOOLEAN | BOOLEAN | Compatível |
| DATETIME | TIMESTAMP | Compatível (timezone-aware) |
| LONG | BIGINT ou SERIAL | Long do Access → SERIAL em PostgreSQL |

### Encoding

- **Legado:** Access usa encoding local (provavelmente Windows-1252 ou ANSI)
- **Novo:** PostgreSQL usa UTF-8 por padrão
- **Migração:** Script deve converter explicitamente de latin1 para utf-8
- **Risco:** Caracteres acentuados/cedilhas podem corromper se não tratado (RISK-007)

---

## DDL Completo (PostgreSQL 14)

```sql
-- Extensões (se necessário)
CREATE EXTENSION IF NOT EXISTS "uuid-ossp";

-- Tabelas auxiliares
CREATE TABLE situacoes (
    id SERIAL PRIMARY KEY,
    nome VARCHAR(50) NOT NULL UNIQUE,
    descricao TEXT
);

CREATE TABLE situacoes_reservas (
    id SERIAL PRIMARY KEY,
    nome VARCHAR(50) NOT NULL UNIQUE,
    descricao TEXT
);

-- Dados iniciais
INSERT INTO situacoes (nome) VALUES ('Disponível'), ('Locado'), ('Reservado');
INSERT INTO situacoes_reservas (nome, descricao) VALUES 
    ('Pendente', 'Reserva criada, aguardando conversão'),
    ('Confirmada', 'Reserva convertida em locação'),
    ('Locada', 'CD reservado foi locado'),
    ('Cancelada', 'Reserva cancelada');

-- Bounded Context: Auth
CREATE TABLE users (
    id SERIAL PRIMARY KEY,
    email VARCHAR(255) NOT NULL UNIQUE CHECK (email LIKE '%@%'),
    password_hash VARCHAR(255) NOT NULL,
    salt VARCHAR(64) NOT NULL,
    active BOOLEAN NOT NULL DEFAULT TRUE,
    created_at TIMESTAMP NOT NULL DEFAULT NOW(),
    last_login_at TIMESTAMP,
    updated_at TIMESTAMP NOT NULL DEFAULT NOW()
);

CREATE INDEX idx_users_email ON users(email);
CREATE INDEX idx_users_active ON users(active);

CREATE TABLE roles (
    id SERIAL PRIMARY KEY,
    nome VARCHAR(100) NOT NULL UNIQUE,
    permissions JSONB NOT NULL DEFAULT '[]'::jsonb,
    created_at TIMESTAMP NOT NULL DEFAULT NOW(),
    updated_at TIMESTAMP NOT NULL DEFAULT NOW()
);

CREATE INDEX idx_roles_nome ON roles(nome);

CREATE TABLE roles_users (
    id SERIAL PRIMARY KEY,
    id_user INT NOT NULL REFERENCES users(id) ON DELETE CASCADE,
    id_role INT NOT NULL REFERENCES roles(id) ON DELETE CASCADE,
    assigned_at TIMESTAMP NOT NULL DEFAULT NOW(),
    revoked_at TIMESTAMP,
    created_at TIMESTAMP NOT NULL DEFAULT NOW()
);

CREATE INDEX idx_roles_users_user_role ON roles_users(id_user, id_role);
CREATE INDEX idx_roles_users_revoked ON roles_users(revoked_at);

-- Bounded Context: Catalog
CREATE TABLE grupos (
    id SERIAL PRIMARY KEY,
    nome VARCHAR(100) NOT NULL UNIQUE,
    descricao TEXT,
    created_at TIMESTAMP NOT NULL DEFAULT NOW(),
    updated_at TIMESTAMP NOT NULL DEFAULT NOW()
);

CREATE INDEX idx_grupos_nome ON grupos(nome);

CREATE TABLE estilos (
    id SERIAL PRIMARY KEY,
    nome VARCHAR(100) NOT NULL UNIQUE,
    descricao TEXT,
    created_at TIMESTAMP NOT NULL DEFAULT NOW(),
    updated_at TIMESTAMP NOT NULL DEFAULT NOW()
);

CREATE INDEX idx_estilos_nome ON estilos(nome);

CREATE TABLE titulos (
    id SERIAL PRIMARY KEY,
    nome VARCHAR(255) NOT NULL,
    tipo_locacao VARCHAR(10) NOT NULL CHECK (tipo_locacao IN ('24h', '48h')),
    valor DECIMAL(10,2) NOT NULL CHECK (valor > 0),
    qtde INT NOT NULL DEFAULT 0 CHECK (qtde >= 0),
    id_grupo INT REFERENCES grupos(id) ON DELETE SET NULL,
    id_estilo INT REFERENCES estilos(id) ON DELETE SET NULL,
    created_at TIMESTAMP NOT NULL DEFAULT NOW(),
    updated_at TIMESTAMP NOT NULL DEFAULT NOW()
);

CREATE INDEX idx_titulos_grupo ON titulos(id_grupo);
CREATE INDEX idx_titulos_estilo ON titulos(id_estilo);
CREATE INDEX idx_titulos_tipo ON titulos(tipo_locacao);

CREATE TABLE musicas (
    id SERIAL PRIMARY KEY,
    nome VARCHAR(255) NOT NULL,
    tempo INT CHECK (tempo >= 0),
    created_at TIMESTAMP NOT NULL DEFAULT NOW(),
    updated_at TIMESTAMP NOT NULL DEFAULT NOW()
);

CREATE INDEX idx_musicas_nome ON musicas(nome);

CREATE TABLE interpretes (
    id SERIAL PRIMARY KEY,
    nome VARCHAR(255) NOT NULL UNIQUE,
    created_at TIMESTAMP NOT NULL DEFAULT NOW(),
    updated_at TIMESTAMP NOT NULL DEFAULT NOW()
);

CREATE INDEX idx_interpretes_nome ON interpretes(nome);

CREATE TABLE titulos_musicas (
    id SERIAL PRIMARY KEY,
    id_titulo INT NOT NULL REFERENCES titulos(id) ON DELETE CASCADE,
    id_musica INT NOT NULL REFERENCES musicas(id) ON DELETE CASCADE,
    created_at TIMESTAMP NOT NULL DEFAULT NOW()
);

CREATE INDEX idx_titulos_musicas_titulo_musica ON titulos_musicas(id_titulo, id_musica);

CREATE TABLE titulos_interpretes (
    id SERIAL PRIMARY KEY,
    id_titulo INT NOT NULL REFERENCES titulos(id) ON DELETE CASCADE,
    id_interprete INT NOT NULL REFERENCES interpretes(id) ON DELETE CASCADE,
    created_at TIMESTAMP NOT NULL DEFAULT NOW()
);

CREATE INDEX idx_titulos_interpretes_titulo_interprete ON titulos_interpretes(id_titulo, id_interprete);

CREATE TABLE cds (
    codigo VARCHAR(10) PRIMARY KEY,
    id_titulo INT NOT NULL REFERENCES titulos(id) ON DELETE CASCADE,
    numcd VARCHAR(50) NOT NULL,
    situacao_id INT NOT NULL DEFAULT 1 REFERENCES situacoes(id),
    is_locado BOOLEAN NOT NULL DEFAULT FALSE,
    data_cp DATE,
    valor_cp DECIMAL(10,2),
    created_at TIMESTAMP NOT NULL DEFAULT NOW(),
    updated_at TIMESTAMP NOT NULL DEFAULT NOW()
);

CREATE INDEX idx_cds_titulo ON cds(id_titulo);
CREATE INDEX idx_cds_situacao ON cds(situacao_id);
CREATE INDEX idx_cds_locado ON cds(is_locado);

-- Bounded Context: Customers
CREATE TABLE municipios (
    id SERIAL PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    uf CHAR(2) NOT NULL CHECK (uf ~ '[A-Z]{2}'),
    created_at TIMESTAMP NOT NULL DEFAULT NOW(),
    updated_at TIMESTAMP NOT NULL DEFAULT NOW()
);

CREATE INDEX idx_municipios_uf ON municipios(uf);
CREATE INDEX idx_municipios_nome ON municipios(nome);

CREATE TABLE bairros (
    id SERIAL PRIMARY KEY,
    cdbairro VARCHAR(10) NOT NULL UNIQUE,
    debairro VARCHAR(100) NOT NULL,
    id_municipio INT REFERENCES municipios(id) ON DELETE SET NULL,
    created_at TIMESTAMP NOT NULL DEFAULT NOW(),
    updated_at TIMESTAMP NOT NULL DEFAULT NOW()
);

CREATE INDEX idx_bairros_codigo ON bairros(cdbairro);
CREATE INDEX idx_bairros_municipio ON bairros(id_municipio);

CREATE TABLE clientes (
    id SERIAL PRIMARY KEY,
    codcliente VARCHAR(10) NOT NULL UNIQUE,
    nomecliente VARCHAR(255) NOT NULL,
    endereco VARCHAR(255) NOT NULL,
    data_nascimento DATE NOT NULL CHECK (data_nascimento >= '1900-01-01' AND data_nascimento <= CURRENT_DATE),
    cdbairro INT NOT NULL REFERENCES bairros(id),
    cep VARCHAR(10),
    fone_01 VARCHAR(15),
    ramal_res VARCHAR(10),
    fone_02 VARCHAR(15),
    ramal_trab VARCHAR(10),
    fone_03 VARCHAR(15),
    identidade VARCHAR(20) NOT NULL,
    expedidor VARCHAR(20),
    data_expedicao DATE,
    cic VARCHAR(14) CHECK (cic ~ '^\d{11}$'),
    empresa VARCHAR(255),
    end_comercial VARCHAR(255),
    referencia_pessoal VARCHAR(255),
    data_inscricao DATE DEFAULT CURRENT_DATE,
    is_cancelado BOOLEAN NOT NULL DEFAULT FALSE,
    obs TEXT,
    created_at TIMESTAMP NOT NULL DEFAULT NOW(),
    updated_at TIMESTAMP NOT NULL DEFAULT NOW()
);

CREATE INDEX idx_clientes_codcliente ON clientes(codcliente);
CREATE INDEX idx_clientes_nome ON clientes(nomecliente);
CREATE INDEX idx_clientes_cpf ON clientes(cic);
CREATE INDEX idx_clientes_cancelado ON clientes(is_cancelado);

CREATE TABLE dependentes (
    id SERIAL PRIMARY KEY,
    cod_dependente VARCHAR(10) NOT NULL UNIQUE,
    id_cliente INT NOT NULL REFERENCES clientes(id) ON DELETE CASCADE,
    nome_dependente VARCHAR(255) NOT NULL,
    created_at TIMESTAMP NOT NULL DEFAULT NOW(),
    updated_at TIMESTAMP NOT NULL DEFAULT NOW()
);

CREATE INDEX idx_dependentes_coddependente ON dependentes(cod_dependente);
CREATE INDEX idx_dependentes_id_cliente ON dependentes(id_cliente);

-- Bounded Context: Rentals
CREATE TABLE locacoes (
    id SERIAL PRIMARY KEY,
    id_cliente INT NOT NULL REFERENCES clientes(id) ON DELETE CASCADE,
    id_dependente INT REFERENCES dependentes(id) ON DELETE SET NULL,
    data_locacao TIMESTAMP NOT NULL DEFAULT NOW(),
    data_prevista DATE NOT NULL DEFAULT (calcular_data_prevista(CURRENT_DATE, tipo_locacao)),
    valor_locacao DECIMAL(10,2) NOT NULL,
    valor_multa DECIMAL(10,2) NOT NULL DEFAULT 0.00 CHECK (valor_multa >= 0),
    created_at TIMESTAMP NOT NULL DEFAULT NOW(),
    updated_at TIMESTAMP NOT NULL DEFAULT NOW()
);

CREATE INDEX idx_locacoes_cliente ON locacoes(id_cliente);
CREATE INDEX idx_locacoes_dependente ON locacoes(id_dependente);
CREATE INDEX idx_locacoes_data_locacao ON locacoes(data_locacao);
CREATE INDEX idx_locacoes_data_prevista ON locacoes(data_prevista);

CREATE TABLE locacoes_itens (
    id SERIAL PRIMARY KEY,
    id_locacao INT NOT NULL REFERENCES locacoes(id) ON DELETE CASCADE,
    id_cd VARCHAR(10) NOT NULL REFERENCES cds(codigo) ON DELETE CASCADE,
    valor_item DECIMAL(10,2) NOT NULL,
    created_at TIMESTAMP NOT NULL DEFAULT NOW(),
    updated_at TIMESTAMP NOT NULL DEFAULT NOW()
);

CREATE INDEX idx_locacoes_itens_locacao ON locacoes_itens(id_locacao);
CREATE INDEX idx_locacoes_itens_cd ON locacoes_itens(id_cd);

CREATE TABLE recibos (
    id SERIAL PRIMARY KEY,
    id_locacao INT NOT NULL REFERENCES locacoes(id) ON DELETE CASCADE,
    id_cliente INT NOT NULL REFERENCES clientes(id) ON DELETE CASCADE,
    data_emissao TIMESTAMP NOT NULL DEFAULT NOW(),
    valor_total DECIMAL(10,2) NOT NULL,
    is_devolvido BOOLEAN NOT NULL DEFAULT FALSE,
    data_devolucao TIMESTAMP,
    created_at TIMESTAMP NOT NULL DEFAULT NOW(),
    updated_at TIMESTAMP NOT NULL DEFAULT NOW()
);

CREATE INDEX idx_recibos_locacao ON recibos(id_locacao);
CREATE INDEX idx_recibos_cliente ON recibos(id_cliente);
CREATE INDEX idx_recibos_devolvido ON recibos(is_devolvido);

CREATE TABLE recibo_itens (
    id SERIAL PRIMARY KEY,
    id_recibo INT NOT NULL REFERENCES recibos(id) ON DELETE CASCADE,
    id_cd VARCHAR(10) NOT NULL REFERENCES cds(codigo) ON DELETE CASCADE,
    valor_item DECIMAL(10,2) NOT NULL,
    created_at TIMESTAMP NOT NULL DEFAULT NOW(),
    updated_at TIMESTAMP NOT NULL DEFAULT NOW()
);

CREATE INDEX idx_recibo_itens_recibo ON recibo_itens(id_recibo);
CREATE INDEX idx_recibo_itens_cd ON recibo_itens(id_cd);

-- Bounded Context: Reservations
CREATE TABLE reservas (
    id SERIAL PRIMARY KEY,
    id_cliente INT NOT NULL REFERENCES clientes(id) ON DELETE CASCADE,
    id_titulo INT NOT NULL REFERENCES titulos(id) ON DELETE CASCADE,
    data_reserva TIMESTAMP NOT NULL DEFAULT NOW(),
    data_prevista DATE NOT NULL,
    situacao_id INT NOT NULL DEFAULT 1 REFERENCES situacoes_reservas(id),
    created_at TIMESTAMP NOT NULL DEFAULT NOW(),
    updated_at TIMESTAMP NOT NULL DEFAULT NOW()
);

CREATE INDEX idx_reservas_cliente ON reservas(id_cliente);
CREATE INDEX idx_reservas_titulo ON reservas(id_titulo);
CREATE INDEX idx_reservas_data_reserva ON reservas(data_reserva);
CREATE INDEX idx_reservas_situacao ON reservas(situacao_id);

-- Bounded Context: Reports
CREATE TABLE relatorio_specs (
    id SERIAL PRIMARY KEY,
    tipo VARCHAR(50) NOT NULL,
    template VARCHAR(255) NOT NULL,
    descricao TEXT,
    created_at TIMESTAMP NOT NULL DEFAULT NOW(),
    updated_at TIMESTAMP NOT NULL DEFAULT NOW()
);

CREATE INDEX idx_relatorio_specs_tipo ON relatorio_specs(tipo);

-- Shared: Domain Events
CREATE TABLE domain_events (
    id BIGSERIAL PRIMARY KEY,
    event_type VARCHAR(255) NOT NULL,
    event_data JSONB NOT NULL,
    aggregate_type VARCHAR(100) NOT NULL,
    aggregate_id VARCHAR(100) NOT NULL,
    occurred_at TIMESTAMP NOT NULL DEFAULT NOW(),
    correlation_id UUID,
    created_at TIMESTAMP NOT NULL DEFAULT NOW()
);

CREATE INDEX idx_domain_events_type ON domain_events(event_type);
CREATE INDEX idx_domain_events_aggregate ON domain_events(aggregate_type, aggregate_id);
CREATE INDEX idx_domain_events_occurred ON domain_events(occurred_at);

-- Funções
CREATE OR REPLACE FUNCTION calcular_data_prevista(data_base DATE, tipo_locacao VARCHAR)
RETURNS DATE AS $$
BEGIN
    DECLARE dias INTEGER;
    DECLARE data_prevista DATE;
    
    IF tipo_locacao = '24h' THEN
        dias := 1;
    ELSE
        dias := 2;
    END IF;
    
    data_prevista := data_base + (dias || ' days')::INTERVAL;
    
    IF EXTRACT(DOW FROM data_prevista) = 0 THEN
        data_prevista := data_prevista + '1 day'::INTERVAL;
    END IF;
    
    RETURN data_prevista;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION calcular_dias_atraso(data_devolucao TIMESTAMP, data_prevista DATE)
RETURNS INTEGER AS $$
BEGIN
    DECLARE dias_atraso INTEGER;
    
    dias_atraso := EXTRACT(DAY FROM DATE(data_devolucao)) - data_prevista;
    
    IF dias_atraso < 0 THEN
        RETURN 0;
    END IF;
    
    RETURN dias_atraso;
END;
$$ LANGUAGE plpgsql;

-- Views
CREATE OR REPLACE VIEW vw_clientes_ativos AS
SELECT 
    id,
    codcliente,
    nomecliente,
    endereco,
    data_nascimento,
    cep,
    fone_01,
    fone_02
FROM clientes
WHERE is_cancelado = FALSE;

-- Triggers para atualização automática de estoque
CREATE OR REPLACE FUNCTION trg_atualizar_qtde_titulo()
RETURNS TRIGGER AS $$
BEGIN
    UPDATE titulos
    SET qtde = (SELECT COUNT(*) FROM cds WHERE id_titulo = NEW.id_titulo)
    WHERE id = NEW.id_titulo;
    
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER tr_titulos_insert_qtde
AFTER INSERT ON cds
FOR EACH ROW EXECUTE FUNCTION trg_atualizar_qtde_titulo(NEW);

CREATE TRIGGER tr_titulos_update_qtde
AFTER UPDATE ON cds
FOR EACH ROW EXECUTE FUNCTION trg_atualizar_qtde_titulo(NEW);

CREATE TRIGGER tr_cds_delete_qtde
AFTER DELETE ON cds
FOR EACH ROW EXECUTE FUNCTION trg_atualizar_qtde_titulo(OLD);

-- Dados iniciais de relatórios
INSERT INTO relatorio_specs (tipo, template, descricao) VALUES 
    ('clientes_sintetico', 'reports/clientes_sintetico.html', 'Relatório de clientes - versão sintética'),
    ('clientes_analitico', 'reports/clientes_analitico.html', 'Relatório de clientes - versão analítica'),
    ('clientes_dependentes', 'reports/dependentes.html', 'Relatório de dependentes'),
    ('cds', 'reports/cds.html', 'Relatório de CDs físicos'),
    ('titulos', 'reports/titulos.html', 'Relatório de títulos de catálogo'),
    ('locacoes', 'reports/locacoes.html', 'Relatório de locações'),
    ('reservas', 'reports/reservas.html', 'Relatório de reservas'),
    ('musicas', 'reports/musicas.html', 'Relatório de músicas'),
    ('aniversariantes', 'reports/aniversariantes.html', 'Relatório de aniversariantes do mês'),
    ('recebimentos', 'reports/recebimentos.html', 'Relatório de recebimentos');
```

---

## Origem Legado por Tabela

| Tabela Legado | Tabela Nova | Observações |
|---------------|-------------|------------|
| Cliente | clientes | Campo cancelado → is_cancelado (boolean). Campos renomeados para snake_case. |
| dependente | dependentes | Cod dependente gerado como PK serial. |
| cd | cds | Campo situacao → situacao_id (FK). Campo locado → is_locado (boolean). |
| titulo | titulos | Campo qtde preservado. Campo tipo_locacao mapeado como VARCHAR. |
| locacao | locacoes | Campo data_prevista calculado via função. |
| recibo | recibos | Campo devolvido → is_devolvido (boolean). |
| reserva | reservas | Campo situacao → situacao_id (FK). |
| senha | (descartada) | Substituída por users + roles (BR-HUMANA-001) |
| valor_loc | (descartada) | Campo valor movido para titulos.valor (normalização). |
| Bairro | bairros | Campo cdbairro → id, nome → debairro. FK para municipios. |
| Municipio | municipios | Tabela nova separada (era campo em clientes). |
| Grupo | grupos | Campo cdgrupo, cdestilo extraídos para tabelas normais. |
| Estilo | estilos | Campo cdestilo extraído para tabela normal. |
| Interprete | interpretes | Campo wtinterprete normalizado. |
| Musica | musicas | Campo wtinterprete normalizado. |
| titulo-musica | titulos_musicas | Renomeado (snake_case). |
| titulo-interprete | titulos_interpretes | Renomeado (snake_case). |
| musica-interprete | (nova) | Não existe no legado; M2M criado para suportar múltiplos intérpretes por música. |
| titulo-musica | (nova) | Tabela removida (M2M). |

---

## Referências

- `target_domain_model.md` — Mapeamento de regras para bounded contexts
- `topology_decision.md` — Decisão de topologia (Opção 2: Modernizar)
- `paradigm_decision.md` — Paradigma alvo: OO + DI + event-driven + async
- `target_business_rules.md` — Regras de negócio MIGRAR (52 regras)
- `discard_log.md` — Itens descartados (4 itens)
- `data_migration_plan.md` — Plano detalhado de migração Access → PostgreSQL
