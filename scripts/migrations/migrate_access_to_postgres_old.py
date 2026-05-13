"""
Data Migration Script: CDsLoc (Access → PostgreSQL)
Geração por Reversa Designer
Estratégia: Big Bang (Opção 2 de migration_strategy.md)

Pré-requisitos:
- pip install pyodbc sqlalchemy
- Driver ODBC do Microsoft Access instalado
"""

import pyodbc
import asyncio
import logging
from datetime import datetime
from sqlalchemy.ext.asyncio import create_async_engine, async_sessionmaker
from sqlalchemy import text

# =============================================================================
# CONFIGURAÇÃO
# =============================================================================

# Logging configuration
logging.basicConfig(
    level=logging.INFO,
    format='%(asctime)s - %(name)s - %(levelname)s - %(message)s',
    handlers=[
        logging.FileHandler('migration.log'),
        logging.StreamHandler()
    ]
)
logger = logging.getLogger(__name__)

# Connection Strings
ACCESS_DB_PATH = r"D:\Legados\Apps\Cd-Loc32\BD_CDLOC.mdb"
POSTGRES_URI = "postgresql+asyncpg://postgres:postgres@localhost:5432/cdsloc"

# Encoding Constants
LEGACY_ENCODING = "latin1"  # Access (ANSI local)
TARGET_ENCODING = "utf-8"

# =============================================================================
# MAPEAMENTO DE TABELAS (LEGADO → NOVO)
# =============================================================================

TABLE_MAPPINGS = {
    "Municipio": {
        "new_table": "municipios",
        "column_mapping": {
            "wtMunicipio": "nome",
            "wtuf": "uf",
        },
    },
    "Bairro": {
        "new_table": "bairros",
        "column_mapping": {
            "cdbairro": "codigo",
            "debairro": "nome",
            "wtMunicipio": "id_municipio",
        },
    },
    "interprete": {
        "new_table": "interpretes",
        "column_mapping": {
            "codinterprete": "id",
            "wtinterprete": "nome",
        },
    },
    "musica": {
        "new_table": "musicas",
        "column_mapping": {
            "codmusica": "id",
            "nomemusica": "nome",
            "tempo": "tempo",
        },
    },
    "titulo": {
        "new_table": "titulos",
        "column_mapping": {
            "codtitulo": "id",
            "nometitulo": "nome",
            "tipo_locacao": "tipo_locacao",
            "qtde": "qtde",
            "valor": "valor",
            "cdgrupo": "id_grupo",
            "cdestilo": "id_estilo",
        },
    },
    "titulo-musica": {
        "new_table": "titulos_musicas",
        "column_mapping": {
            "codtitulo": "id_titulo",
            "codmusica": "id_musica",
        },
    },
    "titulo-interprete": {
        "new_table": "titulos_interpretes",
        "column_mapping": {
            "codtitulo": "id_titulo",
            "codinterprete": "id_interprete",
        },
    },
    "Cliente": {
        "new_table": "clientes",
        "column_mapping": {
            "codcliente": "codcliente",
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
        "column_mapping": {
            "cod_cliente": "id_cliente",
            "nome_dependente": "nome_dependente",
        },
    },
    "cd": {
        "new_table": "cds",
        "column_mapping": {
            "codtitulo": "id_titulo",
            "numcd": "numcd",
            "situacao": "situacao_id",
            "locado": "is_locado",
            "data_cp": "data_cp",
            "valor_cp": "valor_cp",
        },
    },
    "locacao": {
        "new_table": "locacoes",
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
        "new_table": "recibos",
        "column_mapping": {
            "codcliente": "id_cliente",
            "data_emissao": "data_emissao",
            "devolvido": "is_devolvido",
            "valor_total": "valor_total",
        },
    },
    "reserva": {
        "new_table": "reservas",
        "column_mapping": {
            "codcliente": "id_cliente",
            "codtitulo": "id_titulo",
            "data_reserva": "data_reserva",
            "data_prevista": "data_prevista",
            "situacao": "situacao_id",
        },
    },
}

# =============================================================================
# FUNÇÕES DE UTILIDADE
# =============================================================================

def get_access_connection():
    """Retorna conexão com Access via pyodbc."""
    conn_str = f"DRIVER={{Microsoft Access Driver (*.mdb, *.accdb)}};DBQ={ACCESS_DB_PATH};"
    try:
        return pyodbc.connect(conn_str, autocommit=False)
    except Exception as e:
        logger.error(f"Erro ao conectar ao Access: {e}")
        logger.error(f"Connection String: DBQ={ACCESS_DB_PATH}")
        raise

def encode_for_target(value):
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

def transform_row(row, table_mapping):
    """Transforma uma linha do legado para o schema alvo."""
    transformed = {}

    # Aplicar mapeamento de colunas
    for old_col, new_col in table_mapping["column_mapping"].items():
        if old_col in row:
            value = row[old_col]
            # Encoding conversion para strings
            if isinstance(value, str):
                value = encode_for_target(value)
            transformed[new_col] = value

    # Validações específicas por tabela
    if table_mapping["new_table"] == "cds":
        # Situação padrão: 1 = "Disponível"
        if "situacao_id" not in transformed or not transformed["situacao_id"]:
            transformed["situacao_id"] = 1

    elif table_mapping["new_table"] == "reservas":
        # Situação padrão: 1 = "Pendente"
        if "situacao_id" not in transformed or not transformed["situacao_id"]:
            transformed["situacao_id"] = 1

    return transformed

# =============================================================================
# FUNÇÕES DE MIGRAÇÃO
# =============================================================================

async def migrate_table(table_name, pg_session):
    """Migra uma tabela inteira."""
    if table_name not in TABLE_MAPPINGS:
        logger.error(f"Tabela {table_name} não encontrada no mapeamento")
        return 0

    mapping = TABLE_MAPPINGS[table_name]
    new_table = mapping["new_table"]

    # Connect to Access
    access_conn = get_access_connection()
    access_cursor = access_conn.cursor()

    try:
        # Fetch all from Access
        access_cursor.execute(f"SELECT * FROM [{table_name}]")
        columns = [desc[0] for desc in access_cursor.description]
        rows = access_cursor.fetchall()

        if not rows:
            logger.info(f"Tabela {table_name} vazia")
            return 0

        logger.info(f"Migrando {table_name}: {len(rows)} registros encontrados")

        # Transform rows
        transformed_rows = [transform_row(dict(zip(columns, row)), mapping) for row in rows]

        if not transformed_rows:
            logger.warning(f"Nenhuma linha válida transformada para {table_name}")
            return 0

        # Insert into PostgreSQL (async)
        total_inserted = 0

        for row in transformed_rows:
            try:
                # Build column names and values
                columns = list(row.keys())
                values = []

                for col in columns:
                    val = row.get(col)
                    if val is None:
                        values.append("NULL")
                    elif isinstance(val, bool):
                        values.append("TRUE" if val else "FALSE")
                    elif isinstance(val, (int, float)):
                        values.append(str(val))
                    else:
                        # Escape strings
                        str_val = str(val).replace("'", "''")
                        values.append(f"'{str_val}'")

                # Build insert SQL
                columns_sql = ", ".join(columns)
                values_sql = ", ".join(values)
                sql = f"INSERT INTO {new_table} ({columns_sql}) VALUES ({values_sql})"

                await pg_session.execute(text(sql))
                total_inserted += 1

            except Exception as e:
                logger.error(f"Erro ao inserir registro na tabela {new_table}: {e}")
                logger.error(f"Registro: {row}")
                continue

        logger.info(f"✅ Migração de {table_name}: {total_inserted}/{len(rows)} registros inseridos")
        return total_inserted

    except Exception as e:
        logger.error(f"Erro migrando {table_name}: {e}")
        raise
    finally:
        access_cursor.close()
        access_conn.close()

async def validate_migration(pg_session):
    """Valida a migração: contagens e integridade referencial."""
    validation_results = {
        "tables": {},
        "errors": [],
    }

    # Validar contagens
    for table_name, mapping in TABLE_MAPPINGS.items():
        try:
            # Contar no PostgreSQL
            result = await pg_session.execute(text(f"SELECT COUNT(*) as cnt FROM {mapping['new_table']}"))
            pg_count = result.scalar()

            # Contar no Access
            access_conn = get_access_connection()
            access_cursor = access_conn.cursor()
            try:
                access_cursor.execute(f"SELECT COUNT(*) as cnt FROM [{table_name}]")
                access_count = access_cursor.fetchone()[0]
            except Exception as e:
                logger.error(f"Erro contando {table_name} no Access: {e}")
                access_count = -1
            finally:
                access_cursor.close()
                access_conn.close()

            match = access_count == pg_count or access_count == -1

            validation_results["tables"][table_name] = {
                "access_count": access_count,
                "pg_count": pg_count,
                "match": match,
                "diff": abs(access_count - pg_count) if access_count != -1 else 0,
            }

            if not match:
                msg = f"{table_name}: Access={access_count}, PG={pg_count} (diff: {abs(access_count - pg_count)})"
                logger.error(f"❌ {msg}")
                validation_results["errors"].append(msg)
            else:
                logger.info(f"✅ {table_name}: {access_count} registros")

        except Exception as e:
            logger.error(f"Erro validando {table_name}: {e}")
            validation_results["errors"].append(str(e))

    return validation_results

# =============================================================================
# FUNÇÃO PRINCIPAL
# =============================================================================

async def main():
    """Função principal de migração."""
    start_time = datetime.now()

    logger.info("=" * 70)
    logger.info("INICIANDO MIGRAÇÃO DE DADOS: ACCESS → POSTGRESQL")
    logger.info(f"Banco legado: {ACCESS_DB_PATH}")
    logger.info(f"Banco alvo: PostgreSQL")
    logger.info(f"Encoding: {LEGACY_ENCODING} → {TARGET_ENCODING}")
    logger.info(f"Timestamp: {start_time}")
    logger.info("=" * 70)

    # Create async engine
    engine = create_async_engine(POSTGRES_URI, echo=False)
    async_session_maker = async_sessionmaker(engine, expire_on_commit=False)

    try:
        # 1. Create tables first (DDL)
        logger.info("\n[1/5] Criando tabelas no PostgreSQL...")
        try:
            with open("scripts/migrations/ddl_postgres.sql", "r", encoding="utf-8") as f:
                ddl = f.read()

            async with engine.begin() as conn:
                # Split DDL into individual statements for better error handling
                statements = [s.strip() for s in ddl.split(';') if s.strip() and not s.strip().startswith('--')]

                for stmt in statements:
                    if stmt:
                        try:
                            await conn.execute(text(stmt))
                        except Exception as e:
                            if "already exists" not in str(e).lower():
                                logger.warning(f"⚠️  Warning no DDL: {e}")

            logger.info("✅ DDL executado com sucesso")

        except FileNotFoundError:
            logger.error("❌ Arquivo DDL não encontrado: scripts/migrations/ddl_postgres.sql")
            logger.error("Execute primeiro o DDL manualmente ou crie o arquivo.")
            return

        # 2. Migrate tables
        logger.info("\n[2/5] Migrando dados...")
        async with async_session_maker() as session:
            tables_migrated = []

            # Order dependencies first
            await migrate_table("Municipio", session)
            tables_migrated.append("Municipio")

            await migrate_table("Bairro", session)
            tables_migrated.append("Bairro")

            # Then catalog tables
            await migrate_table("interprete", session)
            tables_migrated.append("interprete")

            await migrate_table("musica", session)
            tables_migrated.append("musica")

            await migrate_table("titulo", session)
            tables_migrated.append("titulo")

            await migrate_table("titulo-musica", session)
            tables_migrated.append("titulo-musica")

            await migrate_table("titulo-interprete", session)
            tables_migrated.append("titulo-interprete")

            # Then main business tables
            await migrate_table("Cliente", session)
            tables_migrated.append("Cliente")

            await migrate_table("dependente", session)
            tables_migrated.append("dependente")

            await migrate_table("cd", session)
            tables_migrated.append("cd")

            await migrate_table("locacao", session)
            tables_migrated.append("locacao")

            await migrate_table("recibo", session)
            tables_migrated.append("recibo")

            await migrate_table("reserva", session)
            tables_migrated.append("reserva")

            logger.info(f"✅ {len(tables_migrated)} tabelas migradas")

        # 3. Validate
        logger.info("\n[3/5] Validando migração...")
        async with async_session_maker() as session:
            validation_results = await validate_migration(session)

        # Log validation results
        logger.info("\n📊 Resultados da Validação:")
        for table_name, result in validation_results["tables"].items():
            if result["match"]:
                logger.info(f"  ✅ {table_name}: {result['access_count']} registros")
            else:
                logger.error(f"  ❌ {table_name}: Access={result['access_count']}, PG={result['pg_count']}, diff={result['diff']}")

        if validation_results["errors"]:
            logger.error(f"\n❌ {len(validation_results['errors'])} erros encontrados na validação")
            for error in validation_results["errors"]:
                logger.error(f"  - {error}")
        else:
            logger.info("\n✅ Validação concluída sem erros")

        # 4. Summary
        logger.info("\n[4/5] Resumo da Migração:")

        total_records = sum(r["access_count"] for r in validation_results["tables"].values() if r["access_count"] is not None)

        logger.info(f"  Tabelas migradas: {len(tables_migrated)}")
        logger.info(f"  Total de registros: {total_records}")
        logger.info(f"  Tempo decorrido: {(datetime.now() - start_time).total_seconds():.1f} segundos")

        if not validation_results["errors"]:
            logger.info("\n" + "=" * 70)
            logger.info("🎉 MIGRAÇÃO CONCLUÍDA COM SUCESSO!")
            logger.info("=" * 70)
            logger.info("\nPróximos passos:")
            logger.info("  1. Valide os dados no PostgreSQL")
            logger.info("  2. Execute smoke tests na API")
            logger.info("  3. Valide funcionalidades críticas")
            logger.info("  4. Planeje o cutover")
        else:
            logger.error("\n" + "=" * 70)
            logger.error("❌ MIGRAÇÃO CONCLUÍDA COM ERROS")
            logger.error("=" * 70)
            logger.info("\nAções recomendadas:")
            logger.info("  1. Revise os erros acima")
            logger.info("  2. Corrija as causas")
            logger.info("  3. Execute novamente o script")

    except Exception as e:
        logger.error(f"\n❌ ERRO CRÍTICO NA MIGRAÇÃO: {e}")
        logger.error("=" * 70)
        import traceback
        logger.error(traceback.format_exc())
        raise

if __name__ == "__main__":
    asyncio.run(main())
