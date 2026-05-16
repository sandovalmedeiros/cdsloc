"""Insert default situacoes data into PostgreSQL."""
import asyncio
from sqlalchemy import text
from sqlalchemy.ext.asyncio import create_async_engine

DOCKER_DB_URL = "postgresql+asyncpg://cdsloc:cdsloc_password@localhost:5434/cdsloc"

async def insert_situacoes():
    """Insert default situacoes for CDs."""
    engine = create_async_engine(DOCKER_DB_URL, echo=True)

    try:
        async with engine.begin() as conn:
            # Insert CD situacoes
            await conn.execute(text("""
                INSERT INTO situacoes (id, descricao, tipo, created_at) VALUES
                (1, 'Disponível', 'cd', CURRENT_DATE),
                (2, 'Locado', 'cd', CURRENT_DATE),
                (3, 'Reservado', 'cd', CURRENT_DATE)
                ON CONFLICT (id) DO UPDATE SET
                    descricao = EXCLUDED.descricao,
                    tipo = EXCLUDED.tipo
            """))

            # Insert reserva situacoes
            await conn.execute(text("""
                INSERT INTO situacoes (id, descricao, tipo, created_at) VALUES
                (4, 'Pendente', 'reserva', CURRENT_DATE),
                (5, 'Confirmada', 'reserva', CURRENT_DATE),
                (6, 'Locada', 'reserva', CURRENT_DATE),
                (7, 'Cancelada', 'reserva', CURRENT_DATE)
                ON CONFLICT (id) DO UPDATE SET
                    descricao = EXCLUDED.descricao,
                    tipo = EXCLUDED.tipo
            """))

        print("✓ Default situacoes inserted successfully!")

        # Verify inserted data
        async with engine.connect() as conn:
            result = await conn.execute(text("SELECT * FROM situacoes ORDER BY id"))
            situacoes = result.fetchall()
            print(f"✓ Total situacoes: {len(situacoes)}")
            for row in situacoes:
                print(f"  - {row[0]}: {row[1]} ({row[2]})")

    except Exception as e:
        print(f"✗ Error inserting situacoes: {e}")
        import traceback
        traceback.print_exc()
    finally:
        await engine.dispose()

if __name__ == "__main__":
    asyncio.run(insert_situacoes())