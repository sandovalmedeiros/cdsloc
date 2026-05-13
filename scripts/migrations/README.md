# Migração de Dados — CDsLoc

> Ambiente de desenvolvimento e instruções para executar a migração do banco legado Access para PostgreSQL.
> Estratégia: Big Bang (Opção 2 de `migration_strategy.md`).

---

## Visão Geral

| Aspecto | Legado | Alvo |
|---------|--------|------|
| **SGBD** | Microsoft Access (.mdb) | PostgreSQL 14+ |
| **Localização** | `D:\Legados\Apps\Cd-Loc32\BD_CDLOC.mdb` | `localhost:5432/cdsloc` |
| **Codificação** | Windows-1252/ANSI | UTF-8 |
| **Script** | Python + pyodbc + SQLAlchemy (async) | - |
| **DDL** | Arquivo `ddl_postgres.sql` | - |

---

## Pré-requisitos

### 1. Ambiente de Desenvolvimento

| Componente | Versão | Instalação |
|------------|--------|-------------|
| **Python** | 3.11+ | [python.org](https://www.python.org/downloads/) |
| **PostgreSQL** | 14+ | [postgresql.org](https://www.postgresql.org/download/) |
| **Driver ODBC** | Microsoft Access Driver | Incluído no Windows |
| **pip** | Último | `pip install pyodbc sqlalchemy[async] asyncpg` |

### 2. Bibliotecas Python

```bash
# Instalar dependências
pip install pyodbc sqlalchemy[async] asyncpg
```

---

## Estrutura de Diretórios

```
D:\Legados\Apps\Cd-Loc32\
├── scripts\
│   └── migrations\
│       ├── README.md                    # Este arquivo
│       ├── ddl_postgres.sql            # DDL PostgreSQL completo
│       ├── migrate_access_to_postgres.py  # Script de migração Python
│       └── migration.log                 # Log da migração (gerado)
├── BD_CDLOC.mdb                           # Banco legado Access
└── _reversa_sdd\
    └── migration\
        ├── target_data_model.md         # Especificação do schema alvo
        └── data_migration_plan.md        # Plano detalhado de migração
```

---

## Passo a Passo

### 1. Configurar PostgreSQL

```bash
# 1. Criar banco de dados
createdb cdsloc

# 2. Criar usuário (opcional, pode usar postgres)
# psql -U postgres
# CREATE USER cdsloc WITH PASSWORD 'sua_senha';
# GRANT ALL PRIVILEGES ON DATABASE cdsloc TO cdsloc;

# 3. Verificar conexão
psql -U postgres -d cdsloc
```

### 2. Executar o DDL

```bash
# Via psql
psql -U postgres -d cdsloc -f scripts/migrations/ddl_postgres.sql

# Ou via pgAdmin
# 1. Abra pgAdmin
# 2. Conecte ao servidor `cdsloc`
# 3. Clique com botão direito em `cdsloc` → Query Tool
# 4. Abra `ddl_postgres.sql` e execute
```

**Resultado esperado:** 22 tabelas criadas, including:
- Tabelas auxiliares (`situacoes`, `situacoes_reservas`)
- Tabelas de bounded contexts (`clientes`, `cds`, `titulos`, etc.)
- Funções (`calcular_data_prevista`, `calcular_dias_atraso`)
- Views (`vw_clientes_ativos`)
- Triggers para atualização automática de estoque

### 3. Executar o Script de Migração

```bash
# Navegar para o diretório de scripts
cd D:\Legados\Apps\Cd-Loc32\scripts\migrations

# Executar o script de migração
python migrate_access_to_postgres.py
```

**Fluxo do script:**
1. Conecta ao Access via pyodbc
2. Conecta ao PostgreSQL via SQLAlchemy (async)
3. Cria tabelas via DDL
4. Migra tabelas na ordem correta (dependências primeiro)
5. Valida contagens Access vs. PostgreSQL
6. Exibe resumo da migração

**Resultado esperado:**
```
======================================================================
INICIANDO MIGRAÇÃO DE DADOS: ACCESS → POSTGRESQL
Banco legado: D:\Legados\Apps\Cd-Loc32\BD_CDLOC.mdb
Banco alvo: PostgreSQL
Timestamp: 2026-05-12 10:00:00
======================================================================

[1/5] Criando tabelas no PostgreSQL...
✅ DDL executado com sucesso

[2/5] Migrando dados...
→ Migrando tabelas de dependência...
✅ Municipio: 5 registros migrados
✅ Bairro: 20 registros migrados
→ Migrando tabelas de catálogo...
✅ interprete: 250 registros migrados
✅ musica: 1500 registros migrados
✅ titulo: 800 registros migrados
✅ titulo-musica: 3500 registros migrados
✅ titulo-interprete: 1200 registros migrados
→ Migrando tabelas de negócio...
✅ Cliente: 456 registros migrados
✅ dependente: 120 registros migrados
✅ cd: 2500 registros migrados
✅ locacao: 5000 registros migrados
✅ recibo: 5000 registros migrados
✅ reserva: 50 registros migrados
✅ 10 tabelas migradas

[3/5] Validando migração...

📊 Resultados da Validação:
  ✅ Municipio: 5 registros
  ✅ Bairro: 20 registros
  ✅ Cliente: 456 registros
  ✅ dependente: 120 registros
  ✅ interprete: 250 registros
  ✅ musica: 1500 registros
  ✅ titulo: 800 registros
  ✅ cd: 2500 registros
  ✅ locacao: 5000 registros
  ✅ recibo: 5000 registros
  ✅ reserva: 50 registros

✅ Validação concluída sem erros

[4/5] Resumo da Migração:
  Tabelas migradas: 10
  Total de registros: 15046
  Tempo decorrido: 45.2 segundos

======================================================================
🎉 MIGRAÇÃO CONCLUÍDA COM SUCESSO!
======================================================================

Próximos passos:
  1. Valide os dados no PostgreSQL
  2. Execute smoke tests na API
  3. Valide funcionalidades críticas
  4. Planeje o cutover
```

---

## Solução de Problemas

### Erro: Driver ODBC não encontrado

**Mensagem:**
```
pyodbc.InterfaceError: ('IM002] [Microsoft][ODBC Driver Manager] Data source name not found')
```

**Solução:**
```bash
# Instalar Microsoft Access Database Engine 2016 Redistributable
# Download: https://www.microsoft.com/en-us/download/details.aspx/53320

# Ou usar driver de 64-bit (para Python 64-bit)
# Verificar versão do Python (python --version)
```

### Erro: Codificação de caracteres

**Sintoma:** Acentos e cedilhas aparecem corrompidos ou como `?`

**Solução:**
- Verifique se o encoding legado está correto (`LEGACY_ENCODING = "latin1"`)
- Verifique se a conversão está sendo aplicada
- Consulte o `migration.log` para warnings de encoding

### Erro: Conexão PostgreSQL recusada

**Mensagem:**
```
sqlalchemy.exc.OperationalError: (psycopg2.OperationalError) FATAL: password authentication failed for user "postgres"
```

**Solução:**
```bash
# Verifique a URI de conexão no script
POSTGRES_URI = "postgresql+asyncpg://postgres:sua_senha@localhost:5432/cdsloc"

# Ou configure autenticação trust no PostgreSQL (para desenvolvimento apenas)
# Editar pg_hba.conf:
# local   all             postgres                                trust
```

---

## Validação Pós-Migração

### Consultas SQL de Validação

```sql
-- 1. Contar clientes
SELECT COUNT(*) FROM clientes;
-- Esperado: ~456

-- 2. Contar CDs
SELECT COUNT(*) FROM cds;
-- Esperado: ~2500

-- 3. Contar CDs locados
SELECT COUNT(*) FROM cds WHERE is_locado = TRUE;
-- Esperado: ~quantidade de CDs alugados atualmente

-- 4. Contar clientes ativos
SELECT COUNT(*) FROM clientes WHERE is_cancelado = FALSE;
-- Esperado: ~clientes não cancelados

-- 5. Verificar integridade referencial (clientes → bairros)
SELECT COUNT(*) FROM clientes c LEFT JOIN bairros b ON c.id_bairro = b.id WHERE b.id IS NULL;
-- Esperado: 0 (sem clientes com bairro inválido)

-- 6. Verificar integridade referencial (cds → titulos)
SELECT COUNT(*) FROM cds c LEFT JOIN titulos t ON c.id_titulo = t.id WHERE t.id IS NULL;
-- Esperado: 0 (sem CDs com título inválido)

-- 7. Verificar estoque consistente
SELECT t.nome, t.qtde, (SELECT COUNT(*) FROM cds WHERE id_titulo = t.id) as cds_count
FROM titulos t
WHERE t.qtde != (SELECT COUNT(*) FROM cds WHERE id_titulo = t.id);
-- Esperado: 0 (qtde consistente com CDs)

-- 8. Verificar datas futuras
SELECT codcliente, nomecliente, data_nascimento
FROM clientes
WHERE data_nascimento > CURRENT_DATE;
-- Esperado: 0 (sem datas de nascimento futuras)
```

---

## Pós-Migração

### Tarefas de Verificação

- [ ] Validar contagens de todas as tabelas
- [ ] Verificar integridade referencial
- [ ] Verificar encoding de caracteres (acentos ok)
- [ ] Testar funcionalidades críticas via API
- [ ] Validar cálculos de data prevista e multas
- [ ] Verificar estoque consistente (titulos.qtde == count(cds))
- [ ] Executar smoke tests
- [ ] Documentar anomalias encontradas

---

## Rollback

Se necessário, para reverter a migração:

```sql
-- Drop todas as tabelas (ordem inversa das FKs)
DROP TABLE IF EXISTS domain_events CASCADE;
DROP TABLE IF EXISTS relatorio_specs CASCADE;
DROP TABLE IF EXISTS reservas CASCADE;
DROP TABLE IF EXISTS recibo_itens CASCADE;
DROP TABLE IF EXISTS recibos CASCADE;
DROP TABLE IF EXISTS locacoes_itens CASCADE;
DROP TABLE IF EXISTS locacoes CASCADE;
DROP TABLE IF EXISTS dependentes CASCADE;
DROP TABLE IF EXISTS clientes CASCADE;
DROP TABLE IF EXISTS titulos_musicas CASCADE;
DROP TABLE IF EXISTS titulos_interpretes CASCADE;
DROP TABLE IF EXISTS titulos CASCADE;
DROP TABLE IF EXISTS musicas CASCADE;
DROP TABLE IF EXISTS interpretes CASCADE;
DROP TABLE IF EXISTS cds CASCADE;
DROP TABLE IF EXISTS estilos CASCADE;
DROP TABLE IF EXISTS grupos CASCADE;
DROP TABLE IF EXISTS bairros CASCADE;
DROP TABLE IF EXISTS municipios CASCADE;
DROP TABLE IF EXISTS situacoes CASCADE;
DROP TABLE IF EXISTS situacoes_reservas CASCADE;
DROP TABLE IF EXISTS roles_users CASCADE;
DROP TABLE IF EXISTS roles CASCADE;
DROP TABLE IF EXISTS users CASCADE;
DROP FUNCTION IF EXISTS calcular_dias_atraso;
DROP FUNCTION IF EXISTS calcular_data_prevista;
DROP VIEW IF EXISTS vw_clientes_ativos;

-- Recriar banco vazio
DROP DATABASE IF EXISTS cdsloc;
CREATE DATABASE cdsloc;
```

---

## Documentos Relacionados

- `target_data_model.md` — Especificação do schema PostgreSQL
- `data_migration_plan.md` — Plano detalhado de migração
- `migration_strategy.md` — Estratégia Big Bang
- `erd-complete.md` — Diagrama ERD do legado

---

## Status Atual

| Status | Descrição |
|--------|-----------|
| ✅ DDL PostgreSQL | Criado (22 tabelas, funções, views, triggers) |
| ✅ Script Python de Migração | Criado (640 linhas, idempotente) |
| ✅ Mapeamento Legado→Novo | Documentado (10 tabelas) |
| ✅ Validações | Implementadas (encoding, datas, CPF) |
| 🔴 Execução | Pendente (requer PostgreSQL instalado) |

---

## Responsável

**Reversa Designer** — Geração da especificação e scripts
**Engenheiro de Migração** — Execução e validação da migração

---

**Última atualização:** 2026-05-12
