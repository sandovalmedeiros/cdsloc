"""Insert test data for the CDsLoc application."""
import asyncio
from sqlalchemy import text
from sqlalchemy.ext.asyncio import create_async_engine

DOCKER_DB_URL = "postgresql+asyncpg://cdsloc:cdsloc_password@localhost:5434/cdsloc"

async def insert_test_data():
    """Insert test data for titles, CDs, and customers."""
    engine = create_async_engine(DOCKER_DB_URL, echo=True)

    try:
        async with engine.begin() as conn:
            # Insert test groups
            await conn.execute(text("""
                INSERT INTO grupos (id, nome, descricao, created_at, updated_at) VALUES
                (1, 'Rock', 'Rock and roll music', CURRENT_DATE, CURRENT_DATE),
                (2, 'Pop', 'Pop music', CURRENT_DATE, CURRENT_DATE)
                ON CONFLICT (id) DO UPDATE SET
                    nome = EXCLUDED.nome,
                    descricao = EXCLUDED.descricao
            """))

            # Insert test styles
            await conn.execute(text("""
                INSERT INTO estilos (id, nome, descricao, created_at, updated_at) VALUES
                (1, 'Classic Rock', 'Classic rock style', CURRENT_DATE, CURRENT_DATE),
                (2, 'Modern Pop', 'Modern pop style', CURRENT_DATE, CURRENT_DATE)
                ON CONFLICT (id) DO UPDATE SET
                    nome = EXCLUDED.nome,
                    descricao = EXCLUDED.descricao
            """))

            # Insert test titles
            await conn.execute(text("""
                INSERT INTO titulos (id, nome, tipo_locacao, valor, qtde, id_grupo, id_estilo, created_at, updated_at) VALUES
                (1, 'Abbey Road', '48h', 15.00, 3, 1, 1, CURRENT_DATE, CURRENT_DATE),
                (2, 'Thriller', '48h', 18.00, 2, 2, 2, CURRENT_DATE, CURRENT_DATE),
                (3, 'Dark Side of the Moon', '48h', 20.00, 4, 1, 1, CURRENT_DATE, CURRENT_DATE)
                ON CONFLICT (id) DO UPDATE SET
                    nome = EXCLUDED.nome,
                    tipo_locacao = EXCLUDED.tipo_locacao,
                    valor = EXCLUDED.valor,
                    qtde = EXCLUDED.qtde
            """))

            # Insert test interpreters
            await conn.execute(text("""
                INSERT INTO interpretes (id, nome, created_at, updated_at) VALUES
                (1, 'The Beatles', CURRENT_DATE, CURRENT_DATE),
                (2, 'Michael Jackson', CURRENT_DATE, CURRENT_DATE),
                (3, 'Pink Floyd', CURRENT_DATE, CURRENT_DATE)
                ON CONFLICT (id) DO UPDATE SET
                    nome = EXCLUDED.nome
            """))

            # Link interpreters to titles
            await conn.execute(text("""
                INSERT INTO titulos_interpretes (id_titulo, id_interprete, created_at) VALUES
                (1, 1, CURRENT_DATE),
                (2, 2, CURRENT_DATE),
                (3, 3, CURRENT_DATE)
                ON CONFLICT DO NOTHING
            """))

            # Insert test music tracks
            await conn.execute(text("""
                INSERT INTO musicas (id, nome, tempo, created_at, updated_at) VALUES
                (1, 'Come Together', 259, CURRENT_DATE, CURRENT_DATE),
                (2, 'Something', 183, CURRENT_DATE, CURRENT_DATE),
                (3, 'Billie Jean', 294, CURRENT_DATE, CURRENT_DATE),
                (4, 'Beat It', 258, CURRENT_DATE, CURRENT_DATE),
                (5, 'Speak to Me', 90, CURRENT_DATE, CURRENT_DATE),
                (6, 'Breathe', 163, CURRENT_DATE, CURRENT_DATE)
                ON CONFLICT (id) DO UPDATE SET
                    nome = EXCLUDED.nome,
                    tempo = EXCLUDED.tempo
            """))

            # Link music to titles
            await conn.execute(text("""
                INSERT INTO titulos_musicas (id_titulo, id_musica, created_at) VALUES
                (1, 1, CURRENT_DATE),
                (1, 2, CURRENT_DATE),
                (2, 3, CURRENT_DATE),
                (2, 4, CURRENT_DATE),
                (3, 5, CURRENT_DATE),
                (3, 6, CURRENT_DATE)
                ON CONFLICT DO NOTHING
            """))

            # Insert test CDs
            await conn.execute(text("""
                INSERT INTO cds (codigo, id_titulo, numcd, situacao_id, is_locado, created_at, updated_at) VALUES
                ('CD001', 1, 'Abbey Road - CD 1', 1, false, CURRENT_DATE, CURRENT_DATE),
                ('CD002', 1, 'Abbey Road - CD 2', 1, false, CURRENT_DATE, CURRENT_DATE),
                ('CD003', 1, 'Abbey Road - CD 3', 1, false, CURRENT_DATE, CURRENT_DATE),
                ('CD004', 2, 'Thriller - CD 1', 1, false, CURRENT_DATE, CURRENT_DATE),
                ('CD005', 2, 'Thriller - CD 2', 1, false, CURRENT_DATE, CURRENT_DATE),
                ('CD006', 3, 'Dark Side - CD 1', 1, false, CURRENT_DATE, CURRENT_DATE),
                ('CD007', 3, 'Dark Side - CD 2', 1, false, CURRENT_DATE, CURRENT_DATE),
                ('CD008', 3, 'Dark Side - CD 3', 1, false, CURRENT_DATE, CURRENT_DATE),
                ('CD009', 3, 'Dark Side - CD 4', 1, false, CURRENT_DATE, CURRENT_DATE)
                ON CONFLICT (codigo) DO UPDATE SET
                    id_titulo = EXCLUDED.id_titulo,
                    numcd = EXCLUDED.numcd
            """))

        print("✓ Test data inserted successfully!")

        # Verify inserted data
        async with engine.connect() as conn:
            result = await conn.execute(text("SELECT COUNT(*) FROM titulos"))
            titulos_count = result.scalar()
            print(f"✓ Total titles: {titulos_count}")

            result = await conn.execute(text("SELECT COUNT(*) FROM cds"))
            cds_count = result.scalar()
            print(f"✓ Total CDs: {cds_count}")

    except Exception as e:
        print(f"✗ Error inserting test data: {e}")
        import traceback
        traceback.print_exc()
    finally:
        await engine.dispose()

if __name__ == "__main__":
    asyncio.run(insert_test_data())