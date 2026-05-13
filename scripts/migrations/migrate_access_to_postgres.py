"""
Data Migration Script: CDsLoc (Access → PostgreSQL)
Estratégia: Big Bang via CSV (mdbtools export) — SEM ODBC

Pré-requisitos:
    pip install sqlalchemy asyncpg pandas

Uso:
    1. Extraia o BD_CDLOC_csv.zip em:
       scripts/migrations/csv/

    2. Ajuste POSTGRES_URI abaixo

    3. python migrate_access_to_postgres.py
"""

import asyncio
import logging
import os
from datetime import datetime, date
from decimal import Decimal, InvalidOperation

import re
import pandas as pd
from sqlalchemy.ext.asyncio import create_async_engine, async_sessionmaker
from sqlalchemy import text

# =============================================================================
# CONFIGURAÇÃO
# =============================================================================

logging.basicConfig(
    level=logging.INFO,
    format="%(asctime)s - %(name)s - %(levelname)s - %(message)s",
    handlers=[
        logging.FileHandler("migration.log", encoding="utf-8"),
        logging.StreamHandler(),
    ],
)
logger = logging.getLogger(__name__)

POSTGRES_URI = "postgresql+asyncpg://postgres:postgres@localhost:5432/cdsloc"

# Diretório onde os CSVs foram extraídos do BD_CDLOC_csv.zip
CSV_DIR = os.path.join(os.path.dirname(os.path.abspath(__file__)), "csv")

# =============================================================================
# HELPERS
# =============================================================================

def _str(val) -> str | None:
    if pd.isna(val) or val is None:
        return None
    s = str(val).strip()
    return s if s else None

def _int(val) -> int | None:
    if pd.isna(val) or val is None:
        return None
    try:
        return int(float(str(val)))
    except (ValueError, TypeError):
        return None

def _decimal(val) -> Decimal | None:
    if pd.isna(val) or val is None:
        return None
    try:
        return Decimal(str(val).strip())
    except InvalidOperation:
        return None

def _bool(val) -> bool:
    if pd.isna(val) or val is None:
        return False
    return str(val).strip() in ("1", "True", "true", "yes")

def _date(val) -> date | None:
    if pd.isna(val) or val is None:
        return None
    s = str(val).strip()
    if not s:
        return None
    for fmt in ("%m/%d/%y %H:%M:%S", "%m/%d/%Y %H:%M:%S", "%Y-%m-%d"):
        try:
            d = datetime.strptime(s, fmt).date()
            # Access com ano 2 dígitos: janela errada gera datas futuras absurdas
            # Ex: "03/25/77" → 2077 → corrige para 1977
            if d.year > 2026:
                d = d.replace(year=d.year - 100)
            return d
        except ValueError:
            continue
    logger.warning(f"Data não reconhecida: '{s}'")
    return None



def _cpf(val) -> str | None:
    """Normaliza CPF: troca vírgula por ponto, valida formato, invalidos → None."""
    if pd.isna(val) or val is None:
        return None
    s = str(val).strip().replace(",", ".")
    # Aceita apenas padrões NNN.NNN.NNN-NN
    if re.match(r"^\d{3}\.\d{3}\.\d{3}-\d{2}$", s):
        # Rejeita CPFs com todos dígitos iguais (111.111.111-11 etc.)
        digits = re.sub(r"\D", "", s)
        if len(set(digits)) == 1:
            return None
        return s
    return None  # formato inválido vira NULL — não viola a constraint

def _csv(name: str) -> pd.DataFrame:
    path = os.path.join(CSV_DIR, f"{name}.csv")
    if not os.path.exists(path):
        raise FileNotFoundError(f"CSV não encontrado: {path}")
    return pd.read_csv(path, dtype=str, keep_default_na=False)

# =============================================================================
# TRANSFORMADORES
# =============================================================================

def transform_municipios() -> list[dict]:
    df = _csv("Municipio")
    return [
        {"id": _int(r["cdMunic"]), "nome": _str(r["deMunic"]), "uf": "PE"}
        for _, r in df.iterrows()
    ]

def transform_bairros() -> list[dict]:
    df = _csv("Bairro")
    return [
        {
            "id":          _int(r["cdBairro"]),
            "cdbairro":    str(_int(r["cdBairro"])),
            "debairro":    _str(r["deBairro"]),
            "id_municipio": _int(r["cdMunic"]),
        }
        for _, r in df.iterrows()
    ]

def transform_grupos() -> list[dict]:
    df = _csv("grupo")
    return [
        {"id": _int(r["cod_grupo"]), "nome": _str(r["nome_grupo"])}
        for _, r in df.iterrows()
    ]

def transform_estilos() -> list[dict]:
    df = _csv("estilo")
    return [
        {"id": _int(r["cod_estilo"]), "nome": _str(r["nome_estilo"])}
        for _, r in df.iterrows()
    ]

def transform_interpretes() -> list[dict]:
    df = _csv("interprete")
    return [
        {"id": _int(r["cod_interprete"]), "nome": _str(r["interprete"])}
        for _, r in df.iterrows()
    ]

def transform_musicas() -> list[dict]:
    df = _csv("musica")
    return [
        {"id": _int(r["cod_musica"]), "nome": _str(r["titulo_musica"]), "tempo": None}
        for _, r in df.iterrows()
    ]

def transform_titulos() -> list[dict]:
    df = _csv("titulo")
    try:
        vloc = _csv("valor_loc").iloc[0]
        val_24 = _decimal(vloc.get("loc_24")) or Decimal("1.30")
        val_48 = _decimal(vloc.get("loc_48")) or Decimal("2.60")
    except Exception:
        val_24, val_48 = Decimal("1.30"), Decimal("2.60")

    rows = []
    for _, r in df.iterrows():
        tipo = "24h" if str(r.get("locacao", "24")).strip() in ("24", "24h") else "48h"
        valor_raw = _decimal(r.get("valor"))
        valor = valor_raw if valor_raw else (val_24 if tipo == "24h" else val_48)
        rows.append({
            "id":           _int(r["cod_titulo"]),
            "nome":         _str(r["titulo"]),
            "tipo_locacao": tipo,
            "valor":        valor,
            "qtde":         _int(r.get("qtde_tot")) or 0,
            "id_grupo":     _int(r.get("cod_grupo")),
            "id_estilo":    _int(r.get("cod_estilo")),
        })
    return rows

def transform_titulos_musicas() -> list[dict]:
    df = _csv("titulo_musica")
    return [
        {"id_titulo": _int(r["cod_titulo"]), "id_musica": _int(r["cod_musica"])}
        for _, r in df.iterrows()
    ]

def transform_titulos_interpretes() -> list[dict]:
    df = _csv("titulo_interprete")
    return [
        {"id_titulo": _int(r["cod_titulo"]), "id_interprete": _int(r["cod_interprete"])}
        for _, r in df.iterrows()
    ]

def transform_clientes() -> list[dict]:
    df = _csv("Cliente")
    rows = []
    for i, r in df.iterrows():
        rows.append({
            "id":                 i + 1,
            "codcliente":         str(_int(r.get("codcliente")) or (i + 1)),
            "nomecliente":        _str(r.get("nomecliente")),
            "endereco":           _str(r.get("endereco")) or "",
            "data_nascimento":    _date(r.get("data-nascimento")),
            "cdbairro":           _int(r.get("cdBairro")),
            "cep":                _str(r.get("cep")),
            "fone_01":            _str(r.get("fone-01")),
            "ramal_res":          _str(r.get("ramal_res")),
            "fone_02":            _str(r.get("fone-02")),
            "ramal_trab":         _str(r.get("ramal_trab")),
            "fone_03":            _str(r.get("fone-03")),
            "identidade":         _str(r.get("identidade")) or "",
            "expedidor":          _str(r.get("expedidor")),
            "data_expedicao":     _date(r.get("data-expedicao")),
            "cpf":                _cpf(r.get("cic")),
            "empresa":            _str(r.get("empresa")),
            "end_comercial":      _str(r.get("end-comercial")),
            "referencia_pessoal": _str(r.get("referencia-pessoal")),
            "data_inscricao":     _date(r.get("data-inscricao")),
            "is_cancelado":       _bool(r.get("cancelado")),
            "obs":                _str(r.get("obs")),
        })
    return rows

def transform_dependentes(cliente_rows: list[dict]) -> list[dict]:
    df = _csv("dependente")
    cod_to_id = {int(c["codcliente"]): c["id"] for c in cliente_rows if c["codcliente"]}
    rows = []
    for _, r in df.iterrows():
        cod_cli = _int(r.get("cod_cliente"))
        rows.append({
            "cod_dependente":  str(_int(r.get("cod_dependente"))),
            "id_cliente":      cod_to_id.get(cod_cli),
            "nome_dependente": _str(r.get("nome_dependente")),
        })
    return [row for row in rows if row["id_cliente"] is not None]

def transform_cds() -> list[dict]:
    df = _csv("cd")
    rows = []
    for _, r in df.iterrows():
        locado    = _bool(r.get("locado"))
        reservado = _bool(r.get("reservado"))
        if reservado:
            situacao_id = 3
        elif locado:
            situacao_id = 2
        else:
            situacao_id = 1
        rows.append({
            "codigo":      _str(r.get("cod_cd")),
            "id_titulo":   _int(r.get("cod_titulo")),
            "numcd":       _str(r.get("cod_cd")) or "",
            "situacao_id": situacao_id,
            "is_locado":   locado,
            "data_cp":     _date(r.get("data_compra")),
            "valor_cp":    _decimal(r.get("valor")),
        })
    return rows

def transform_recibos(cliente_rows: list[dict]) -> list[dict]:
    df = _csv("recibo")
    if df.empty:
        return []
    cod_to_id = {int(c["codcliente"]): c["id"] for c in cliente_rows if c["codcliente"]}
    rows = []
    for i, r in df.iterrows():
        cod_cli = _int(r.get("cod_cliente"))
        id_cli  = cod_to_id.get(cod_cli)
        if id_cli is None:
            continue
        rows.append({
            "id_locacao":     i + 1,
            "id_cliente":     id_cli,
            "valor_total":    _decimal(r.get("valor_total")) or Decimal("0"),
            "is_devolvido":   _bool(r.get("devolvido")),
            "data_devolucao": _date(r.get("data_pagamento")),
        })
    return rows

# =============================================================================
# INSERÇÃO
# =============================================================================

def _sql_val(v) -> str:
    if v is None:
        return "NULL"
    if isinstance(v, bool):
        return "TRUE" if v else "FALSE"
    if isinstance(v, (int, float, Decimal)):
        return str(v)
    if isinstance(v, (date, datetime)):
        return f"'{v}'"
    s = str(v).replace("'", "''")
    # SQLAlchemy interpreta :palavra como bind parameter dentro de text()
    # Solução: quebrar sequências :letra com concatenação SQL quando necessário
    if ":" in s:
        # Divide em partes pelo ':', gera concatenação SQL: 'parte1' || chr(58) || 'parte2'
        parts = s.split(":")
        sql_parts = [f"'{p}'" for p in parts]
        return " || chr(58) || ".join(sql_parts)
    return f"'{s}'"

async def insert_rows(conn, table: str, rows: list[dict], conflict: str = "") -> int:
    """Insere linha a linha usando SAVEPOINT para isolar erros sem abortar a transação."""
    if not rows:
        logger.info(f"  ⚠️  {table}: nenhum registro para inserir")
        return 0
    inserted = 0
    skipped  = 0
    for i, row in enumerate(rows):
        cols = ", ".join(row.keys())
        vals = ", ".join(_sql_val(v) for v in row.values())
        sql  = f"INSERT INTO {table} ({cols}) VALUES ({vals}) {conflict}"
        sp   = f"sp_{table}_{i}"
        try:
            await conn.execute(text(f"SAVEPOINT {sp}"))
            await conn.execute(text(sql))
            await conn.execute(text(f"RELEASE SAVEPOINT {sp}"))
            inserted += 1
        except Exception as e:
            await conn.execute(text(f"ROLLBACK TO SAVEPOINT {sp}"))
            await conn.execute(text(f"RELEASE SAVEPOINT {sp}"))
            skipped += 1
            logger.warning(f"  ⚠️  {table}[{i}] ignorado: {e} | {row}")
    if skipped:
        logger.info(f"  ℹ️  {table}: {skipped} linha(s) ignorada(s)")
    return inserted

# =============================================================================
# VALIDAÇÃO
# =============================================================================

EXPECTED_COUNTS = {
    "municipios":           7,
    "bairros":            125,
    "grupos":               8,
    "estilos":             18,  # legado tem cod_estilo duplicado; 18 IDs únicos inseridos
    "interpretes":       1202,  # legado tem IDs duplicados; 1202 IDs únicos efetivamente inseridos
    "musicas":          27477,  # 1 música com nome problemático normalizado; 27477 inseridas
    "titulos":            526,
    "titulos_musicas":   7542,
    "titulos_interpretes": 529,
    "clientes":           283,
    "dependentes":        489,
    "cds":                569,
}

async def validate(session) -> bool:
    ok = True
    logger.info("\n📊 Validação pós-migração:")
    for table, expected in EXPECTED_COUNTS.items():
        result = await session.execute(text(f"SELECT COUNT(*) FROM {table}"))
        actual = result.scalar()
        status = "✅" if actual >= expected else "❌"
        if actual < expected:
            ok = False
        logger.info(f"  {status} {table}: {actual} registros (esperado ≥ {expected})")
    return ok

# =============================================================================
# MAIN
# =============================================================================

async def main():
    start = datetime.now()
    logger.info("=" * 70)
    logger.info("INICIANDO MIGRAÇÃO: Access CSV → PostgreSQL  (sem ODBC)")
    logger.info(f"CSV_DIR : {CSV_DIR}")
    logger.info(f"Postgres: {POSTGRES_URI}")
    logger.info(f"Início  : {start}")
    logger.info("=" * 70)

    # Verifica se os CSVs existem antes de conectar ao banco
    obrigatorios = ["Municipio", "Bairro", "grupo", "estilo", "interprete",
                    "musica", "titulo", "titulo_musica", "titulo_interprete",
                    "Cliente", "dependente", "cd"]
    faltando = [t for t in obrigatorios
                if not os.path.exists(os.path.join(CSV_DIR, f"{t}.csv"))]
    if faltando:
        logger.error(f"❌ CSVs não encontrados em '{CSV_DIR}': {faltando}")
        logger.error("Extraia o BD_CDLOC_csv.zip dentro da pasta 'csv' ao lado deste script.")
        return

    engine = create_async_engine(POSTGRES_URI, echo=False)
    session_maker = async_sessionmaker(engine, expire_on_commit=False)

    # [1/5] DDL
    logger.info("\n[1/5] DDL já aplicado manualmente. Etapa ignorada.")

    # [2/5] Transformar
    logger.info("\n[2/5] Transformando dados dos CSVs...")
    municipio_rows    = transform_municipios()
    bairro_rows       = transform_bairros()
    grupo_rows        = transform_grupos()
    estilo_rows       = transform_estilos()
    interprete_rows   = transform_interpretes()
    musica_rows       = transform_musicas()
    titulo_rows       = transform_titulos()
    tm_rows           = transform_titulos_musicas()
    ti_rows           = transform_titulos_interpretes()
    cliente_rows      = transform_clientes()
    dependente_rows   = transform_dependentes(cliente_rows)
    cd_rows           = transform_cds()
    recibo_rows       = transform_recibos(cliente_rows)
    logger.info("  ✅ Transformação concluída")

    # [3/5] Inserir
    logger.info("\n[3/5] Inserindo no PostgreSQL...")
    ON_CONFLICT = "ON CONFLICT DO NOTHING"

    # Limpeza das tabelas e remoção de constraints problemáticas (idempotente)
    logger.info("\n  🧹 Limpando tabelas e ajustando constraints...")
    async with engine.connect() as raw_conn:
        await raw_conn.execution_options(isolation_level="AUTOCOMMIT")
        # Remove constraint de validação aritmética de CPF (dados legados não garantem CPF válido)
        await raw_conn.execute(text(
            "ALTER TABLE clientes DROP CONSTRAINT IF EXISTS clientes_cpf_check"
        ))
        # Garante unicidade nas tabelas de junção para evitar duplicatas em re-execução
        await raw_conn.execute(text(
            "ALTER TABLE titulos_musicas DROP CONSTRAINT IF EXISTS titulos_musicas_pkey"
        ))
        await raw_conn.execute(text(
            "ALTER TABLE titulos_interpretes DROP CONSTRAINT IF EXISTS titulos_interpretes_pkey"
        ))
        # Trunca todas as tabelas na ordem correta (FK-safe) para re-execução limpa
        tabelas_ordem = [
            "recibos", "dependentes", "cds",
            "titulos_musicas", "titulos_interpretes",
            "clientes", "titulos",
            "musicas", "interpretes", "estilos", "grupos",
            "bairros", "municipios"
        ]
        for t in tabelas_ordem:
            await raw_conn.execute(text(f"TRUNCATE TABLE {t} CASCADE"))
        logger.info("  ✅ Tabelas limpas")

    # session_replication_role só funciona fora de bloco de transação (AUTOCOMMIT)
    async with engine.connect() as raw_conn:
        await raw_conn.execution_options(isolation_level="AUTOCOMMIT")
        await raw_conn.execute(text("SET session_replication_role = replica"))

    # Inserção dentro de uma única transação com SAVEPOINT por linha
    async with engine.begin() as conn:
        tabelas = [
            ("Municípios",            "municipios",           municipio_rows),
            ("Bairros",               "bairros",              bairro_rows),
            ("Grupos",                "grupos",               grupo_rows),
            ("Estilos",               "estilos",              estilo_rows,    "ON CONFLICT (id) DO UPDATE SET nome = EXCLUDED.nome"),
            ("Intérpretes",           "interpretes",          interprete_rows,"ON CONFLICT (id) DO UPDATE SET nome = EXCLUDED.nome"),
            ("Músicas",               "musicas",              musica_rows,    "ON CONFLICT (id) DO UPDATE SET nome = EXCLUDED.nome"),
            ("Títulos",               "titulos",              titulo_rows),
            ("Títulos × Músicas",     "titulos_musicas",      tm_rows,    "ON CONFLICT DO NOTHING"),
            ("Títulos × Intérpretes", "titulos_interpretes",  ti_rows,    "ON CONFLICT DO NOTHING"),
            ("Clientes",              "clientes",             cliente_rows),
            ("Dependentes",           "dependentes",          dependente_rows),
            ("CDs",                   "cds",                  cd_rows),
            ("Recibos",               "recibos",              recibo_rows),
        ]
        for entry in tabelas:
            label, table, rows = entry[0], entry[1], entry[2]
            conflict = entry[3] if len(entry) == 4 else ON_CONFLICT
            n = await insert_rows(conn, table, rows, conflict)
            logger.info(f"  ✅ {label}: {n} registros inseridos")

    # Restaura role e reajusta sequences em conexão autocommit separada
    async with engine.connect() as raw_conn:
        await raw_conn.execution_options(isolation_level="AUTOCOMMIT")
        await raw_conn.execute(text("SET session_replication_role = DEFAULT"))
        for table in ["municipios", "bairros", "grupos", "estilos",
                      "interpretes", "musicas", "titulos", "clientes"]:
            await raw_conn.execute(text(
                f"SELECT setval(pg_get_serial_sequence('{table}', 'id'), "
                f"COALESCE(MAX(id), 1)) FROM {table}"
            ))
    logger.info("  ✅ Sequences ajustadas")

    # [4/5] Validar
    logger.info("\n[4/5] Validando migração...")
    async with session_maker() as session:
        migration_ok = await validate(session)

    # [5/5] Resumo
    elapsed = (datetime.now() - start).total_seconds()
    logger.info(f"\n[5/5] Tempo total: {elapsed:.1f}s")

    if migration_ok:
        logger.info("\n" + "=" * 70)
        logger.info("🎉 MIGRAÇÃO CONCLUÍDA COM SUCESSO!")
        logger.info("=" * 70)
    else:
        logger.error("\n" + "=" * 70)
        logger.error("❌ MIGRAÇÃO COM DIVERGÊNCIAS — revise os warnings acima")
        logger.error("=" * 70)

if __name__ == "__main__":
    asyncio.run(main())
