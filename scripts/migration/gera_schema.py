import psycopg2
import json
from datetime import datetime

# Conectar
conn = psycopg2.connect(
    host="localhost",
    database="cdsloc",
    user="postgres",
    password="postgres"
    )
cursor = conn.cursor()

# Buscar tabelas do schema dados_mapoteca
cursor.execute("""
    SELECT table_name
    FROM information_schema.tables
    WHERE table_schema = 'public'
      AND table_type = 'BASE TABLE'
    ORDER BY table_name
""")

tabelas = {}

# Processar tabelas do schema dados_mapoteca
for (table_name,) in cursor.fetchall():
    print(f"Processando public.{table_name}...")

    # Buscar colunas
    cursor.execute("""
        SELECT
            column_name,
            data_type,
            is_nullable,
            column_default
        FROM information_schema.columns
        WHERE table_schema = 'public'
          AND table_name = %s
        ORDER BY ordinal_position
    """, (table_name,))

    colunas = []
    for row in cursor.fetchall():
        colunas.append({
            'nome': row[0],
            'tipo': row[1],
            'nullable': row[2],
            'default': row[3]
        })

    # Contar registros
    cursor.execute(f"SELECT COUNT(*) FROM public.{table_name}")
    total = cursor.fetchone()[0]

    tabelas[table_name] = {
        'nome': table_name,
        'colunas': colunas,
        'total_registros': total
    }

schema_json = {
    'database': 'cdsloc',
    'schema_principal': 'public',
    'data_geracao': datetime.now().isoformat(),
    'tabelas': tabelas
}

with open('schema_public.json', 'w', encoding='utf-8') as f:
    json.dump(schema_json, f, indent=2, ensure_ascii=False)

print(f"✅ JSON gerado: schema_public.json")
print(f"📊 Total de tabelas: {len(tabelas)}")
print(f"   - Tabelas public: {len(tabelas)}")
print(f"   - Tabelas dados_sei: 1 (t_municipio)")

cursor.close()
conn.close()
