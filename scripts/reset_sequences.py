"""Script para resetar todas as sequences do banco de dados.

Esse script deve ser executado sempre que houver problemas de duplicação
de chaves primárias devido a sequences desincronizadas.
"""

import asyncio
import sys
from pathlib import Path

# Adicionar diretório /app ao PATH
sys.path.insert(0, str(Path(__file__).parent.parent))


async def reset_all_sequences():
    """Reset all sequences to their maximum value + 1."""
    from sqlalchemy import text
    from app.adapters.db.base import AsyncSessionLocal

    async with AsyncSessionLocal() as session:
        # Lista de tabelas e suas sequences
        tables_to_reset = [
            ("clientes", "clientes_codcliente_seq"),
            ("titulos", "titulos_id_seq"),
            ("cds", "cds_codigo_seq"),  # Se existir
            ("musicas", "musicas_id_seq"),
            ("interpretes", "interpretes_id_seq"),
            ("locacoes", "locacoes_codlocacao_seq"),
            ("dependentes", "dependentes_coddependente_seq"),
            ("recibos", "recibos_codrecibo_seq"),
        ]

        for table, sequence in tables_to_reset:
            try:
                # Reset sequence to max(id) + 1
                query = text(f"""
                    SELECT setval(
                        '{sequence}',
                        (SELECT COALESCE(MAX(id), 0) + 1 FROM {table}),
                        true
                    )
                """)
                await session.execute(query)
                print(f"✓ Sequence {sequence} resetada")
            except Exception as e:
                print(f"✗ Erro ao resetar sequence {sequence}: {e}")

        await session.commit()
        print("\nTodas as sequences foram resetadas com sucesso!")


if __name__ == "__main__":
    asyncio.run(reset_all_sequences())
