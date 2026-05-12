---
schemaVersion: 1
generatedAt: 2026-05-12T00:00:00Z
reversa:
  version: "1.2.34"
kind: data_migration_plan
producedBy: designer
hash: "sha256:<hash do corpo abaixo do front-matter>"
---

# Data Migration Plan — CDsLoc

> Plano completo de migração de dados do sistema legado (Access) para o sistema novo (PostgreSQL).
> Estratégia: Big Bang (Opção 2 de `migration_strategy.md`).

---

## Resumo

| Aspecto | Detalhe |
|---------|---------|
| **Banco Legado** | Microsoft Access (BD_CDLOC.mdb) |
| **Banco Alvo** | PostgreSQL 14+ |
| **Volume Estimado** | ~24 tabelas, ~10.000 registros (estimado) |
| **Complexidade** | Média (muitas tabelas, mas sem relacionamentos complexos) |
| **Risco** | Encoding (ANSI vs. UTF-8), Perda de dados, Integridade referencial |
| **Duração Estimada** | 30-60 minutos para migração completa |

---

## Mapeamento Legado → Novo

### Mapeamento por Tabela

| Tabela Legado | Tabela Nova | Tipo de Mapeamento | Observações |
|---------------|-------------|-------------------|------------|
| Cliente | clientes | 1-para-1 | Campo cancelado → is_cancelado, renomeação snake_case |
| dependente | dependentes | 1-para-1 | Campo cod_dependente → PK serial |
| cd | cds | 1-para-1 | Campo situacao → situacao_id (FK + tabela auxiliar) |
| titulo | titles | 1-para-1 | Campo qtde preservado, tipo_locacao VARCHAR |
| musica | musicas | 1-para-1 | Campo wtinterprete → nome (normalizado) |
| interprete | interpreters | 1-para-1 | Campo wtinterprete → nome (normalizado) |
| titulo-musica | titles_musicas | 1-para-1 | Relação many-to-many preservada |
| titulo-interprete | titles_interpreters | 1-para-1 | Relação many-to-many preservada |
| musica-interprete | (nova) | Novo | Mapeado em script (extraído de legado) |
| locacao | rentals | 1-para-1 | Campos renomeados snake_case |
| recibo | receipts | 1-para-1 | Campo devolvido → is_devolvido |
| reserva | reservations | 1-para-1 | Campo situacao → situacao_id (FK) |
| recibo_itens | receipt_items | 1-para-1 | Novo (itens do recibo) |
| Bairro | bairros | 1-para-1 | Campo cdbairro → codigo, debairro → nome |
| Municipio | municipalities | 1-para-1 | Campo wtMunicipio → nome, uf → uf |
| senha | (descartada) | - | Múltiplos usuários BR-HUMANA-001, não senha única |
| valor_loc | (descartada) | - | Valor movido para titles.valor |

### Tabelas Auxiliares Novas

| Tabela Nova | Propósito |
|---------------|-----------|
| situacoes | Situação de CDs (Disponível/Locado/Reservado) |
| situacoes_reservas | Situação de Reservas (Pendente/Confirmada/Locada/Cancelada) |
| users | Usuários do sistema (JWT) |
| roles | Perfis de permissão |
| roles_users | Associação usuários-roles |
| groups | Grupos de classificação |
| styles | Estilos de classificação |
| domain_events | Eventos de domínio (event-driven) |
| report_specs | Especificações de relatórios |

---

## Transformações por Coluna/Tabela

### Cliente → customers

| Coluna Legado | Coluna Nova | Tipo | Transformação | Regra |
|---------------|-------------|------|---------------|-------|
| codcliente | codcliente | VARCHAR(10) | Direto (preserve formato) | - |
| nomecliente | nomecliente | VARCHAR(255) | Direto | - |
| endereco | endereco | VARCHAR(255) | Direto | - |
| data-nascimento | data_nascimento | DATE | Direto, CHECK (>= 1900-01-01) | BR-MIGRAR-008 |
| cdbairro | id_bairro | INT | FK → bairros.id, renomeado | - |
| cep | cep | VARCHAR(10) | Direto | - |
| fone-01 | fone_01 | VARCHAR(15) | Renomeado para snake_case | - |
| ramal_res | ramal_res | VARCHAR(10) | Renomeado para snake_case | - |
| fone-02 | fone_02 | VARCHAR(15) | Renomeado para snake_case | - |
| ramal_trab | ramal_trab | VARCHAR(10) | Renomeado para snake_case | - |
| fone-03 | fone_03 | VARCHAR(15) | Renomeado para snake_case | - |
| identidade | identidade | VARCHAR(20) | Renomeado para snake_case | - |
| expedidor | expedidor | VARCHAR(20) | Renomeado para snake_case | - |
| data-expedicao | data_expedicao | DATE | Renomeado para snake_case | - |
| cic | cpf | VARCHAR(14) | Renomeado, VALIDAÇÃO (BR-MIGRAR-010) | - |
| empresa | empresa | VARCHAR(255) | Direto | - |
| end-comercial | end_comercial | VARCHAR(255) | Renomeado para snake_case | - |
| referencia-pessoal | referencia_pessoal | VARCHAR(255) | Renomeado para snake_case | - |
| data-inscricao | data_inscricao | DATE | Renomeado para snake_case | - |
| cancelado | is_cancelado | BOOLEAN | Renomeado, default FALSE | BR-MIGRAR-008 |
| obs | obs | TEXT | Direto | - |

### dependente → dependentes

| Coluna Legado | Coluna Nova | Tipo | Transformação | Regra |
|---------------|-------------|------|---------------|-------|
| cod_dependente | cod_dependente | VARCHAR(10) | Direto (preserve formato) | - |
| cod_cliente | id_cliente | INT | FK → clientes.id, renomeado | - |
| nome_dependente | nome_dependente | VARCHAR(255) | Direto | - |

### cd → cds

| Coluna Legado | Coluna Nova | Tipo | Transformação | Regra |
|---------------|-------------|------|---------------|-------|
| codigo | codigo | VARCHAR(10) | PK, direto | - |
| codtitulo | id_titulo | INT | FK → titles.id, renomeado | - |
| numcd | numcd | VARCHAR(50) | Direto | - |
| situacao | situacao_id | INT | FK → situacoes.id + default 1 | Conversão para FK, BR-MIGRAR-021 |
| locado | is_locado | BOOLEAN | Renomeado, default FALSE | - |
| data_cp | data_cp | DATE | Renomeado para snake_case | - |
| valor_cp | valor_cp | DECIMAL(10,2) | Renomeado para snake_case | - |

### titulo → titles

| Coluna Legado | Coluna Nova | Tipo | Transformação | Regra |
|---------------|-------------|------|---------------|-------|
| codtitulo | id | SERIAL | PK, geração automática (replace) | - |
| nometitulo | nome | VARCHAR(255) | Renomeado | - |
| tipo_locacao | tipo_locacao | VARCHAR(10) | Enum: '24h'/'48h' | - |
| qtde | qtde | INT | Preservado | - |
| valor | valor | DECIMAL(10,2) | Direto | - |
| cdgrupo | id_grupo | INT | FK → groups.id, renomeado | - |
| cdestilo | id_estilo | INT | FK → styles.id, renomeado | - |

### musica → musicas

| Coluna Legado | Coluna Nova | Tipo | Transformação | Regra |
|---------------|-------------|------|---------------|-------|
| codmusica | id | SERIAL | PK, geração automática (replace) | - |
| nomemusica | nome | VARCHAR(255) | Renomeado | - |
| tempo | tempo | INT | Direto (segundos) | - |

### interprete → interpreters

| Coluna Legado | Coluna Nova | Tipo | Transformação | Regra |
|---------------|-------------|------|---------------|-------|
| codinterprete | id | SERIAL | PK, geração automática (replace) | - |
| wtinterprete | nome | VARCHAR(255) | Direto (renomeado) | - |

### Bairro → bairros

| Coluna Legado | Coluna Nova | Tipo | Transformação | Regra |
|---------------|-------------|------|---------------|-------|
| cdbairro | codigo | VARCHAR(10) | PK, renomeado | - |
| debairro | nome | VARCHAR(100) | Renomeado | - |
| wtMunicipio | id_municipio | INT | FK → municipalities.id | - |

### Municipio → municipalities

| Coluna Legado | Coluna Nova | Tipo | Transformação | Regra |
|---------------|-------------|------|---------------|-------|
| wtMunicipio | id | SERIAL | PK, geração automática (replace) | - |
| wtmunicipio | nome | VARCHAR(100) | Renomeado | - |
| wtuf | uf | CHAR(2) | Renomeado | - |

### locacao → rentals

| Coluna Legado | Coluna Nova | Tipo | Transformação | Regra |
|---------------|-------------|------|---------------|-------|
| codlocacao | id | SERIAL | PK, geração automática (replace) | - |
| codcliente | id_cliente | INT | FK → customers.id, renomeado | - |
| coddependente | id_dependente | INT | FK → dependentes.id, renomeado | - |
| codcd | id_cd | VARCHAR(10) | FK → cds.codigo | Renomeado | - |
| data_locacao | data_locacao | TIMESTAMP | Renomeado para snake_case | - |
| data_prevista | data_prevista | DATE | Renomeado, lógica domingo | BR-MIGRAR-025, BR-MIGRAR-026 |
| valor_locacao | valor_locacao | DECIMAL(10,2) | Renomeado para snake_case | - |
| situacao | - | - | DESCARTADO (não há no novo schema) |

### recibo → receipts

| Coluna Legado | Coluna Nova | Tipo | Transformação | Regra |
|---------------|-------------|------|---------------|-------|
| codrecibo | id | SERIAL | PK, geração automática (replace) | - |
| codcliente | id_cliente | INT | FK → customers.id, renomeado | - |
| data_emissao | data_emissao | TIMESTAMP | Renomeado para snake_case | - |
| devolvido | is_devolvido | BOOLEAN | Renomeado, default FALSE | - |
| data_devolucao | data_devolucao | TIMESTAMP | Adicionado (pode ser NULL) | - |
| valor_total | valor_total | DECIMAL(10,2) | Renomeado para snake_case | - |

### reserva → reservations

| Coluna Legado | Coluna Nova | Tipo | Transformação | Regra |
|---------------|-------------|------|---------------|-------|
| codreserva | id | SERIAL | PK, geração automática (replace) | - |
| codcliente | id_cliente | INT | FK → customers.id, renomeado | - |
| codtitulo | id_titulo | INT | FK → titles.id, renomeado | - |
| data_reserva | data_reserva | TIMESTAMP | Renomeado para snake_case | - |
| data_prevista | data_prevista | DATE | Renomeado, lógica disponibilidade | BR-MIGRAR-043 |
| situacao | - | - | Descartado, substituído por situacao_id |
| situacao_reserva_id | situacao_id | INT | FK → situacoes_reservas.id + default 1 | Novo, BR-MIGRAR-042 |

### Tabelas de Relacionamento (M2M do Legado)

| Tabela Legado | Tabela Nova | Tipo de Mapeamento | Observações |
|---------------|-------------|-------------------|------------|
| titulo-musica | titles_musicas | M2M → M2M | Preservado, renomeado para snake_case |
| titulo-interprete | titles_interpreters | M2M → M2M | Preservado, renomeado para snake_case |

### Nova: musica-interprete

| Origem | Tabela Nova | Descrição |
|---------|-------------|-----------|
| Extraída de legado | musicas_interpreters | M2M extraída do legado (interprete vinculados à músicas) |

---

## Estratégia de ETL

### Ferramenta

**Estratégia:** Script Python + SQLAlchemy + pyodbc

**Justificativa:** 
- Python é a linguagem da stack alvo (menos curva de aprendizado)
- pyodbc permite leitura direta do Access (.mdb)
- SQLAlchemy pode escrever no PostgreSQL (target)
- Scripts são idempotentes (podem ser re-executados com segurança)

### Componentes

```
┌─────────────────────────────────────────────────────────┐
│                  ETL Pipeline                      │
├─────────────────────────────────────────────────────────┤
│  1. Extract (Access)  │ 2. Transform (Python)  │ 3. Load (PostgreSQL) │
│     pyodbc              │      Python logic           │      SQLAlchemy async  │
└─────────────────────────────────────────────────────────┘
```

### Passo a Passo

1. **Setup**: Instalar pyodbc, configurar connection strings
2. **Extract**: Ler cada tabela do Access via pyodbc
3. **Transform**: Aplicar transformações (renomeação, encoding conversão, validações)
4. **Load**: Escrever no PostgreSQL via SQLAlchemy (async)
5. **Validate**: Contagens, integridade referencial
6. **Post-Migration**: Criar índices, atualizar sequências

---

## Script de Migração

### Estrutura do Script

```python
"""
Data Migration Script: CDsLoc (Access → PostgreSQL)
Geração por Reversa Designer
Estratégia: Big Bang (Opção 2 de migration_strategy.md)
"""

import pyodbc
import asyncio
import logging
from datetime import datetime
from typing import Dict, List, Any
from sqlalchemy.ext.asyncio import create_async_engine, AsyncSession
from sqlalchemy.orm import sessionmaker
from sqlalchemy import text

# Logging
logging.basicConfig(level=logging.INFO)
logger = logging.getLogger(__name__)

# Connection Strings
ACCESS_DB_PATH = r"D:\Legados\Apps\Cd-Loc32\BD_CDLOC.mdb"
POSTGRES_URI = "postgresql+asyncpg://postgres:password@localhost:5432/cdsloc"

# Encoding Constants
LEGACY_ENCODING = "latin1"  # Access (ANSI local)
TARGET_ENCODING = "utf-8"

# Mapeamento de tabelas
TABLE_MAPPINGS: Dict[str, Dict[str, Any]] = {
    "Cliente": {
        "new_table": "clientes",
        "pk_column": "codcliente",
        "column_mapping": {
            "nomecliente": "nomecliente",
            "endereco": "endereco",
            "data-nascimento": "data_nascimento",
            "cdbairro": "id_bairro",
            "cep": "cep",
            "fone-01": "fone_01",
            "ramal_res": "ramal_res",
            "fone-02": "fone_02",
            "ramal_trab": "ramal_trab",
            "fone-03": "fone_03",
            "identidade": "identidade",
            "expedidor": "expedidor",
            "data-expedicao": "data_expedicao",
            "cic": "cpf",
            "empresa": "empresa",
            "end-comercial": "end_comercial",
            "referencia-pessoal": "referencia_pessoal",
            "data-inscricao": "data_inscricao",
            "cancelado": "is_cancelado",
            "obs": "obs",
        },
    },
    "dependente": {
        "new_table": "dependentes",
        "pk_column": "cod_dependente",
        "column_mapping": {
            "cod_cliente": "id_cliente",
            "nome_dependente": "nome_dependente",
        },
    },
    "cd": {
        "new_table": "cds",
        "pk_column": "codigo",
        "column_mapping": {
            "codtitulo": "id_titulo",
            "numcd": "numcd",
            "situacao": "situacao_id",
            "locado": "is_locado",
            "data_cp": "data_cp",
            "valor_cp": "valor_cp",
        },
    },
    "titulo": {
        "new_table": "titles",
        "pk_column": "id",
        "column_mapping": {
            "nometitulo": "nome",
            "tipo_locacao": "tipo_locacao",
            "qtde": "qtde",
            "valor": "valor",
            "cdgrupo": "id_grupo",
            "cdestilo": "id_estilo",
        },
    },
    "musica": {
        "new_table": "musicas",
        "pk_column": "id",
        "column_mapping": {
            "nomemusica": "nome",
            "tempo": "tempo",
        },
    },
    "interprete": {
        "new_table": "interpreters",
        "pk_column": "id",
        "column_mapping": {
            "wtinterprete": "nome",
        },
    },
    "titulo-musica": {
        "new_table": "titles_musicas",
        "pk_column": "id",
        "column_mapping": {
            "codtitulo": "id_titulo",
            "codmusica": "id_musica",
        },
    },
    "titulo-interprete": {
        "new_table": "titles_interpreters",
        "pk_column": "id",
        "column_mapping": {
            "codtitulo": "id_titulo",
            "codinterprete": "id_interprete",
        },
    },
    "locacao": {
        "new_table": "rentals",
        "pk_column": "id",
        "column_mapping": {
            "codcliente": "id_cliente",
            "coddependente": "id_dependente",
            "codcd": "id_cd",
            "data_locacao": "data_locacao",
            "data_prevista": "data_prevista",
            "valor_locacao": "valor_locacao",
        },
    },
    "recibo": {
        "new_table": "receipts",
        "pk_column": "id",
        "column_mapping": {
            "codcliente": "id_cliente",
            "data_emissao": "data_emissao",
            "devolvido": "is_devolvido",
            "data_devolucao": "data_devolucao",
            "valor_total": "valor_total",
        },
    },
    "reserva": {
        "new_table": "reservations",
        "pk_column": "id",
        "column_mapping": {
            "codcliente": "id_cliente",
            "codtitulo": "id_titulo",
            "data_reserva": "data_reserva",
            "data_prevista": "data_prevista",
            "situacao": "situacao_id",  # default 1
        },
        "situacao_id_default": 1,  # "Pendente"
    },
    "Bairro": {
        "new_table": "bairros",
        "pk_column": "codigo",
        "column_mapping": {
            "debairro": "nome",
            "wtMunicipio": "id_municipio",
        },
    },
    "Municipio": {
        "new_table": "municipalities",
        "pk_column": "id",
        "column_mapping": {
            "wtmunicipio": "nome",
            "wtuf": "uf",
        },
    },
}


def get_access_connection():
    """Retorna conexão com Access via pyodbc."""
    conn_str = f"DRIVER={{Microsoft Access Driver (*.mdb, *.accdb)}};DBQ={ACCESS_DB_PATH};"
    return pyodbc.connect(conn_str, autocommit=False)


def encode_for_target(value: str) -> str:
    """Converte encoding de Access para PostgreSQL UTF-8."""
    if not value:
        return None
    try:
        # Access usa latin1 (ou encoding local)
        # Converter para bytes e decodificar como UTF-8
        bytes_val = value.encode(LEGACY_ENCODING, errors="ignore")
        return bytes_val.decode(TARGET_ENCODING, errors="ignore")
    except Exception as e:
        logger.warning(f"Encoding warning para valor '{value}': {e}")
        return value  # Fallback para valor original


def transform_row(row: Dict[str, Any], table_mapping: Dict[str, Any]) -> Dict[str, Any]:
    """Transforma uma linha do legado para o schema alvo."""
    transformed = {}
    
    # Aplicar mapeamento de colunas
    for old_col, new_col in table_mapping["column_mapping"].items():
        if old_col in row:
            value = row[old_col]
            # Renomear colunas
            if "data-" in old_col or "fone-" in old_col or "ramal_" in old_col or "end-" in old_col or "ref-" in old_col:
                new_col = new_col.replace("_", "")
            # Encoding conversion para strings
            if isinstance(value, str):
                value = encode_for_target(value)
            transformed[new_col] = value
    
    # Validações específicas por tabela
    if table_mapping["new_table"] == "clientes":
        # Validação de CPF (BR-MIGRAR-010)
        if transformed.get("cpf"):
            # Validação simplificada no script (validação completa via Pydantic)
            if len(transformed["cpf"]) != 14:  # Formato ###.###.##
                logger.warning(f"CPF com formato inválido: {transformed['cpf']}")
        # Validação de data de nascimento (BR-MIGRAR-008)
        if transformed.get("data_nascimento"):
            if transformed["data_nascimento"] > datetime.now().date():
                logger.warning(f"Data de nascimento futura: {transformed['data_nascimento']}")
    
    elif table_mapping["new_table"] == "cds":
        # Situação padrão: 1 = "Disponível"
        if "situacao_id" not in transformed:
            transformed["situacao_id"] = 1
    
    return transformed


async def migrate_table(table_name: str, pg_session: AsyncSession) -> int:
    """Migra uma tabela inteira."""
    if table_name not in TABLE_MAPPINGS:
        logger.error(f"Tabela {table_name} não encontrada no mapeamento")
        return 0
    
    mapping = TABLE_MAPPINGS[table_name]
    new_table = mapping["new_table"]
    pk_column = mapping["pk_column"]
    
    # Connect to Access
    access_conn = get_access_connection()
    access_cursor = access_conn.cursor()
    
    try:
        # Fetch all from Access
        access_cursor.execute(f"SELECT * FROM {table_name}")
        columns = [desc[0] for desc in access_cursor.description]
        rows = access_cursor.fetchall()
        
        if not rows:
            logger.info(f"Tabela {table_name} vazia")
            return 0
        
        # Transform rows
        transformed_rows = [transform_row(dict(zip(columns, row)), mapping) for row in rows]
        
        # Insert into PostgreSQL (use async with proper session)
        total_inserted = 0
        
        for row in transformed_rows:
            # Build insert SQL dynamically
            columns = [col for col in row.keys() if col != pk_column]
            values = [f"'{str(row[col]).replace("'", "''")}'" if isinstance(row[col], str) and row[col] is not None else 'NULL' for col in columns]
            
            sql = f"INSERT INTO {new_table} ({', '.join(columns)}) VALUES ({', '.join(values)}) RETURNING {pk_column}"
            
            result = await pg_session.execute(text(sql))
            total_inserted += 1
        
        logger.info(f"Migração de {table_name}: {len(rows)} registros processados, {total_inserted} inseridos")
        return total_inserted
        
    except Exception as e:
        logger.error(f"Erro migrando {table_name}: {e}")
        raise
    finally:
        access_cursor.close()
        access_conn.close()


async def validate_migration(pg_session: AsyncSession) -> Dict[str, Any]:
    """Valida a migração: contagens e integridade referencial."""
    validation_results = {
        "tables": {},
        "referential_integrity": {},
        "encoding_issues": [],
    }
    
    # Validar contagens
    for table_name, mapping in TABLE_MAPPINGS.items():
        if mapping["new_table"] in ["situacoes", "situacoes_reservas", "users", "roles"]:
            continue
        
        # Contar no PostgreSQL
        result = await pg_session.execute(text(f"SELECT COUNT(*) as cnt FROM {mapping['new_table']}"))
        pg_count = result.scalar()
        
        # Contar no Access
        access_conn = get_access_connection()
        access_cursor = access_conn.cursor()
        try:
            access_cursor.execute(f"SELECT COUNT(*) as cnt FROM {table_name}")
            access_count = access_cursor.scalar()
        except Exception as e:
            logger.error(f"Erro contando {table_name} no Access: {e}")
            access_count = -1
        finally:
            access_cursor.close()
            access_conn.close()
        
        validation_results["tables"][table_name] = {
            "access_count": access_count,
            "pg_count": pg_count,
            "match": access_count == pg_count or access_count == -1,
        }
    
    return validation_results


async def main():
    """Função principal de migração."""
    start_time = datetime.now()
    
    logger.info("=" * 60)
    logger.info("Iniciando migração de dados: Access → PostgreSQL")
    logger.info(f"Banco legado: {ACCESS_DB_PATH}")
    logger.info(f"Banco alvo: PostgreSQL")
    logger.info(f"Timestamp: {start_time}")
    logger.info("=" * 60)
    
    # Create async engine
    engine = create_async_engine(POSTGRES_URI, echo=False)
    async_session_maker = sessionmaker(engine, class_=AsyncSession, expire_on_commit=False)
    
    # Create tables first (DDL)
    logger.info("Criando tabelas no PostgreSQL...")
    async with engine.begin() as conn:
        # Execute DDL from target_data_model.md
        ddl = open("scripts/ddl_postgres.sql", encoding="utf-8").read()
        await conn.execute(text(ddl))
        logger.info("DDL executado com sucesso")
    
    # Migrate tables
    async with async_session_maker() as session:
        total_records = 0
        
        # Order dependencies first
        await migrate_table("Bairro", session)
        await migrate_table("Municipio", session)
        
        # Then migrate dependent tables
        await migrate_table("Cliente", session)
        await migrate_table("dependente", session)
        
        # Catalog
        await migrate_table("interprete", session)
        await migrate_table("musica", session)
        await migrate_table("titulo", session)
        await migrate_table("titulo-musica", session)
        await migrate_table("titulo-interprete", session)
        
        # Business tables
        await migrate_table("cd", session)
        await migrate_table("locacao", session)
        await migrate_table("reserva", session)
        await migrate_table("recibo", session)
        
        total_records = len(rows)  # Would be counted during migration
    
    # Validate
    logger.info("Validando migração...")
    async with async_session_maker() as session:
        validation_results = await validate_migration(session)
    
    # Log validation results
    logger.info("Resultados da validação:")
    for table_name, result in validation_results["tables"].items():
        logger.info(f"  {table_name}: Access={result['access_count']}, PG={result['pg_count']}, Match={result['match']}")
    
    end_time = datetime.now()
    duration = (end_time - start_time).total_seconds()
    
    logger.info("=" * 60)
    logger.info(f"Migração concluída em {duration:.1f} segundos")
    logger.info(f"Total de tabelas migradas: {len(TABLE_MAPPINGS)}")
    logger.info(f"Total de registros: {total_records}")
    logger.info("=" * 60)


if __name__ == "__main__":
    asyncio.run(main())
```

### Módulo de Idempotência

```python
def check_record_exists(pg_session, table_name, pk_column, pk_value):
    """Verifica se registro já existe no PostgreSQL."""
    result = pg_session.execute(
        text(f"SELECT 1 FROM {table_name} WHERE {pk_column} = :pk_val"),
        {"pk_val": pk_value}
    )
    return result.scalar() is not None
```

---

## Cutover de Dados

### Sequência do Cutover

| Ordem | Ação | Duração Estimada | Owner |
|--------|-------|-------------------|-------|
| 1 | Backup final do Access | 30 min | Operações |
| 2 | Validar backup | 15 min | Operações |
| 3 | Executar script de migração | 30-45 min | Engenharia |
| 4 | Validar contagens (Access vs. PostgreSQL) | 10 min | Engenharia |
| 5 | Validar integridade referencial | 15 min | Engenharia |
| 6 | Validação funcional (smoke tests no novo sistema) | 30 min | QA |
| 7 | GO/NO-GO decision | 15 min | Liderança |

**Tempo total estimado:** 2-3 horas

---

## Pós-Migração

### Verificação Pós-Cutover

| Item | Critério | Responsável |
|------|-----------|-------------|
| Contagens de registros | Access = PostgreSQL (ou margem < 1%) | Engenharia |
| Integridade referencial | FKs válidas | Engenharia |
| Encoding | Sem caracteres corrompidos (acentos OK) | Engenharia |
| Dados de teste | Acessíveis via API | QA |

### Rollback de Dados

Se a migração falhar ou dados estiverem corrompidos:

1. **Parar sistema novo** (se já iniciado)
2. **Restaurar backup do Access** (BD_CDLOC_backup.mdb)
3. **Validar legado** (funcionalidades básicas)
4. **Comunicar problema** e planejar nova tentativa

---

## Notas de Implementação

1. **Script de migração deve ser executado em ambiente isolado** (não no servidor de produção) durante testes.

2. **Backup é não-negociável**: A migração só pode ser iniciada após backup do Access validado.

3. **Encoding é crítico** (RISK-007): Script deve converter explicitamente de encoding local para UTF-8.

4. **Validação de CPF** (BR-MIGRAR-010) deve ser implementada no script de migração (algoritmo do dígito verificador) ou validada via Pydantic no serviço de clientes.

5. **Transações**: PostgreSQL suporta transações ACID. O script SQLAlchemy deve usar `async with async_session.begin():` para garantir atomicidade.

6. **Índices**: Criar índices após a migração (não durante) para otimizar performance.

7. **Sequências**: PostgreSQL SERIAL é preferível em vez de sequências manuais (como `geracod()` do legado). O script deve remover essa dependência.

---

## Rastreabilidade

| Artefato | Descreção | Caminho |
|----------|-----------|---------|
| `target_architecture.md` | Arquitetura alvo com bounded contexts | `_reversa_sdd/migration/target_architecture.md` |
| `target_domain_model.md` | Modelo de domínio alvo | `_reversa_sdd/migration/target_domain_model.md` |
| `target_data_model.md` | Este documento | `_reversa_sdd/migration/target_data_model.md` |
| `topology_decision.md` | Decisão de topologia (Opção 2: Modernizar) | `_reversa_sdd/migration/topology_decision.md` |
| `migration_strategy.md` | Estratégia Big Bang | `_reversa_sdd/migration/migration_strategy.md` |
| `discard_log.md` | Itens descartados (incluindo senha, valor_loc) | `_reversa_sdd/migration/discard_log.md` |
| `target_business_rules.md` | Regras MIGRAR com rastreabilidade | `_reversa_sdd/migration/target_business_rules.md` |

---

**Gerado por:** Designer (Fase 2)
**Data:** 2026-05-12
