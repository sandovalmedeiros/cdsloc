-- DDL PostgreSQL — CDsLoc
-- Esquema de dados do sistema novo
-- Gerado pelo Reversa Designer (2026-05-12)
-- Topologia: Hexagonal com Bounded Contexts

-- ====================================================================
-- Extensões
-- ====================================================================

CREATE EXTENSION IF NOT EXISTS "uuid-ossp";

-- ====================================================================
-- Tabelas Auxiliares
-- ====================================================================

-- Tabela de situações de CDs
CREATE TABLE IF NOT EXISTS situacoes (
    id SERIAL PRIMARY KEY,
    nome VARCHAR(50) NOT NULL UNIQUE,
    descricao TEXT
);

INSERT INTO situacoes (nome, descricao) VALUES
    ('Disponível', 'CD disponível para locação'),
    ('Locado', 'CD está com cliente'),
    ('Reservado', 'CD reservado para retirada');

-- Tabela de situações de reservas
CREATE TABLE IF NOT EXISTS situacoes_reservas (
    id SERIAL PRIMARY KEY,
    nome VARCHAR(50) NOT NULL UNIQUE,
    descricao TEXT
);

INSERT INTO situacoes_reservas (nome, descricao) VALUES
    ('Pendente', 'Reserva criada, aguardando conversão'),
    ('Confirmada', 'Reserva convertida em locação'),
    ('Locada', 'CD reservado foi locado'),
    ('Cancelada', 'Reserva cancelada');

-- ====================================================================
-- Bounded Context: Auth
-- ====================================================================

CREATE TABLE IF NOT EXISTS users (
    id SERIAL PRIMARY KEY,
    email VARCHAR(255) NOT NULL UNIQUE CHECK (email LIKE '%@%'),
    password_hash VARCHAR(255) NOT NULL,
    salt VARCHAR(64) NOT NULL,
    active BOOLEAN NOT NULL DEFAULT TRUE,
    created_at TIMESTAMP NOT NULL DEFAULT NOW(),
    last_login_at TIMESTAMP,
    updated_at TIMESTAMP NOT NULL DEFAULT NOW()
);

CREATE INDEX IF NOT EXISTS idx_users_email ON users(email);
CREATE INDEX IF NOT EXISTS idx_users_active ON users(active);

CREATE TABLE IF NOT EXISTS roles (
    id SERIAL PRIMARY KEY,
    nome VARCHAR(100) NOT NULL UNIQUE,
    permissions JSONB NOT NULL DEFAULT '[]'::jsonb,
    created_at TIMESTAMP NOT NULL DEFAULT NOW(),
    updated_at TIMESTAMP NOT NULL DEFAULT NOW()
);

CREATE INDEX IF NOT EXISTS idx_roles_nome ON roles(nome);

CREATE TABLE IF NOT EXISTS roles_users (
    id SERIAL PRIMARY KEY,
    id_user INT NOT NULL REFERENCES users(id) ON DELETE CASCADE,
    id_role INT NOT NULL REFERENCES roles(id) ON DELETE CASCADE,
    assigned_at TIMESTAMP NOT NULL DEFAULT NOW(),
    revoked_at TIMESTAMP,
    created_at TIMESTAMP NOT NULL DEFAULT NOW()
);

CREATE INDEX IF NOT EXISTS idx_roles_users_user_role ON roles_users(id_user, id_role);
CREATE INDEX IF NOT EXISTS idx_roles_users_revoked ON roles_users(revoked_at);

-- ====================================================================
-- Bounded Context: Catalog
-- ====================================================================

CREATE TABLE IF NOT EXISTS grupos (
    id SERIAL PRIMARY KEY,
    nome VARCHAR(100) NOT NULL UNIQUE,
    descricao TEXT,
    created_at TIMESTAMP NOT NULL DEFAULT NOW(),
    updated_at TIMESTAMP NOT NULL DEFAULT NOW()
);

CREATE INDEX IF NOT EXISTS idx_grupos_nome ON grupos(nome);

CREATE TABLE IF NOT EXISTS estilos (
    id SERIAL PRIMARY KEY,
    nome VARCHAR(100) NOT NULL UNIQUE,
    descricao TEXT,
    created_at TIMESTAMP NOT NULL DEFAULT NOW(),
    updated_at TIMESTAMP NOT NULL DEFAULT NOW()
);

CREATE INDEX IF NOT EXISTS idx_estilos_nome ON estilos(nome);

CREATE TABLE IF NOT EXISTS titulos (
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

CREATE INDEX IF NOT EXISTS idx_titulos_grupo ON titulos(id_grupo);
CREATE INDEX IF NOT EXISTS idx_titulos_estilo ON titulos(id_estilo);
CREATE INDEX IF NOT EXISTS idx_titulos_tipo ON titulos(tipo_locacao);

CREATE TABLE IF NOT EXISTS musicas (
    id SERIAL PRIMARY KEY,
    nome VARCHAR(255) NOT NULL,
    tempo INT CHECK (tempo >= 0),
    created_at TIMESTAMP NOT NULL DEFAULT NOW(),
    updated_at TIMESTAMP NOT NULL DEFAULT NOW()
);

CREATE INDEX IF NOT EXISTS idx_musicas_nome ON musicas(nome);

CREATE TABLE IF NOT EXISTS interpretes (
    id SERIAL PRIMARY KEY,
    nome VARCHAR(255) NOT NULL UNIQUE,
    created_at TIMESTAMP NOT NULL DEFAULT NOW(),
    updated_at TIMESTAMP NOT NULL DEFAULT NOW()
);

CREATE INDEX IF NOT EXISTS idx_interpretes_nome ON interpretes(nome);

CREATE TABLE IF NOT EXISTS titulos_musicas (
    id SERIAL PRIMARY KEY,
    id_titulo INT NOT NULL REFERENCES titulos(id) ON DELETE CASCADE,
    id_musica INT NOT NULL REFERENCES musicas(id) ON DELETE CASCADE,
    created_at TIMESTAMP NOT NULL DEFAULT NOW()
);

CREATE INDEX IF NOT EXISTS idx_titulos_musicas_titulo_musica ON titulos_musicas(id_titulo, id_musica);

CREATE TABLE IF NOT EXISTS titulos_interpretes (
    id SERIAL PRIMARY KEY,
    id_titulo INT NOT NULL REFERENCES titulos(id) ON DELETE CASCADE,
    id_interprete INT NOT NULL REFERENCES interpretes(id) ON DELETE CASCADE,
    created_at TIMESTAMP NOT NULL DEFAULT NOW()
);

CREATE INDEX IF NOT EXISTS idx_titulos_interpretes_titulo_interprete ON titulos_interpretes(id_titulo, id_interprete);

CREATE TABLE IF NOT EXISTS cds (
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

CREATE INDEX IF NOT EXISTS idx_cds_codigo ON cds(codigo);
CREATE INDEX IF NOT EXISTS idx_cds_titulo ON cds(id_titulo);
CREATE INDEX IF NOT EXISTS idx_cds_situacao ON cds(situacao_id);
CREATE INDEX IF NOT EXISTS idx_cds_locado ON cds(is_locado);

-- ====================================================================
-- Bounded Context: Customers
-- ====================================================================

CREATE TABLE IF NOT EXISTS municipios (
    id SERIAL PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    uf CHAR(2) NOT NULL CHECK (uf ~ '[A-Z]{2}'),
    created_at TIMESTAMP NOT NULL DEFAULT NOW(),
    updated_at TIMESTAMP NOT NULL DEFAULT NOW()
);

CREATE INDEX IF NOT EXISTS idx_municipios_uf ON municipios(uf);
CREATE INDEX IF NOT EXISTS idx_municipios_nome ON municipios(nome);

CREATE TABLE IF NOT EXISTS bairros (
    id SERIAL PRIMARY KEY,
    cdbairro VARCHAR(10) NOT NULL UNIQUE,
    debairro VARCHAR(100) NOT NULL,
    id_municipio INT REFERENCES municipios(id) ON DELETE SET NULL,
    created_at TIMESTAMP NOT NULL DEFAULT NOW(),
    updated_at TIMESTAMP NOT NULL DEFAULT NOW()
);

CREATE INDEX IF NOT EXISTS idx_bairros_codigo ON bairros(cdbairro);
CREATE INDEX IF NOT EXISTS idx_bairros_municipio ON bairros(id_municipio);

CREATE TABLE IF NOT EXISTS clientes (
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
    cpf VARCHAR(14) CHECK (cpf ~ '^\d{11}$'),
    empresa VARCHAR(255),
    end_comercial VARCHAR(255),
    referencia_pessoal VARCHAR(255),
    data_inscricao DATE DEFAULT CURRENT_DATE,
    is_cancelado BOOLEAN NOT NULL DEFAULT FALSE,
    obs TEXT,
    created_at TIMESTAMP NOT NULL DEFAULT NOW(),
    updated_at TIMESTAMP NOT NULL DEFAULT NOW()
);

CREATE INDEX IF NOT EXISTS idx_clientes_codcliente ON clientes(codcliente);
CREATE INDEX IF NOT EXISTS idx_clientes_nome ON clientes(nomecliente);
CREATE INDEX IF NOT EXISTS idx_clientes_cpf ON clientes(cpf);
CREATE INDEX IF NOT EXISTS idx_clientes_cancelado ON clientes(is_cancelado);

CREATE TABLE IF NOT EXISTS dependentes (
    id SERIAL PRIMARY KEY,
    cod_dependente VARCHAR(10) NOT NULL UNIQUE,
    id_cliente INT NOT NULL REFERENCES clientes(id) ON DELETE CASCADE,
    nome_dependente VARCHAR(255) NOT NULL,
    created_at TIMESTAMP NOT NULL DEFAULT NOW(),
    updated_at TIMESTAMP NOT NULL DEFAULT NOW()
);

CREATE INDEX IF NOT EXISTS idx_dependentes_coddependente ON dependentes(cod_dependente);
CREATE INDEX IF NOT EXISTS idx_dependentes_id_cliente ON dependentes(id_cliente);

-- ====================================================================
-- Bounded Context: Rentals
-- ====================================================================

CREATE TABLE IF NOT EXISTS locacoes (
    id SERIAL PRIMARY KEY,
    id_cliente INT NOT NULL REFERENCES clientes(id) ON DELETE CASCADE,
    id_dependente INT REFERENCES dependentes(id) ON DELETE SET NULL,
    data_locacao TIMESTAMP NOT NULL DEFAULT NOW(),
    data_prevista DATE NOT NULL,
    valor_locacao DECIMAL(10,2) NOT NULL,
    valor_multa DECIMAL(10,2) NOT NULL DEFAULT 0.00 CHECK (valor_multa >= 0),
    created_at TIMESTAMP NOT NULL DEFAULT NOW(),
    updated_at TIMESTAMP NOT NULL DEFAULT NOW()
);

CREATE INDEX IF NOT EXISTS idx_locacoes_cliente ON locacoes(id_cliente);
CREATE INDEX IF NOT EXISTS idx_locacoes_dependente ON locacoes(id_dependente);
CREATE INDEX IF NOT EXISTS idx_locacoes_data_locacao ON locacoes(data_locacao);
CREATE INDEX IF NOT EXISTS idx_locacoes_data_prevista ON locacoes(data_prevista);

CREATE TABLE IF NOT EXISTS locacoes_itens (
    id SERIAL PRIMARY KEY,
    id_locacao INT NOT NULL REFERENCES locacoes(id) ON DELETE CASCADE,
    id_cd VARCHAR(10) NOT NULL REFERENCES cds(codigo) ON DELETE CASCADE,
    valor_item DECIMAL(10,2) NOT NULL,
    created_at TIMESTAMP NOT NULL DEFAULT NOW(),
    updated_at TIMESTAMP NOT NULL DEFAULT NOW()
);

CREATE INDEX IF NOT EXISTS idx_locacoes_itens_locacao ON locacoes_itens(id_locacao);
CREATE INDEX IF NOT EXISTS idx_locacoes_itens_cd ON locacoes_itens(id_cd);

CREATE TABLE IF NOT EXISTS recibos (
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

CREATE INDEX IF NOT EXISTS idx_recibos_locacao ON recibos(id_locacao);
CREATE INDEX IF NOT EXISTS idx_recibos_cliente ON recibos(id_cliente);
CREATE INDEX IF NOT EXISTS idx_recibos_devolvido ON recibos(is_devolvido);

CREATE TABLE IF NOT EXISTS recibo_itens (
    id SERIAL PRIMARY KEY,
    id_recibo INT NOT NULL REFERENCES recibos(id) ON DELETE CASCADE,
    id_cd VARCHAR(10) NOT NULL REFERENCES cds(codigo) ON DELETE CASCADE,
    valor_item DECIMAL(10,2) NOT NULL,
    created_at TIMESTAMP NOT NULL DEFAULT NOW(),
    updated_at TIMESTAMP NOT NULL DEFAULT NOW()
);

CREATE INDEX IF NOT EXISTS idx_recibo_itens_recibo ON recibo_itens(id_recibo);
CREATE INDEX IF NOT EXISTS idx_recibo_itens_cd ON recibo_itens(id_cd);

-- ====================================================================
-- Bounded Context: Reservations
-- ====================================================================

CREATE TABLE IF NOT EXISTS reservas (
    id SERIAL PRIMARY KEY,
    id_cliente INT NOT NULL REFERENCES clientes(id) ON DELETE CASCADE,
    id_titulo INT NOT NULL REFERENCES titulos(id) ON DELETE CASCADE,
    data_reserva TIMESTAMP NOT NULL DEFAULT NOW(),
    data_prevista DATE NOT NULL,
    situacao_id INT NOT NULL DEFAULT 1 REFERENCES situacoes_reservas(id),
    created_at TIMESTAMP NOT NULL DEFAULT NOW(),
    updated_at TIMESTAMP NOT NULL DEFAULT NOW()
);

CREATE INDEX IF NOT EXISTS idx_reservas_cliente ON reservas(id_cliente);
CREATE INDEX IF NOT EXISTS idx_reservas_titulo ON reservas(id_titulo);
CREATE INDEX IF NOT EXISTS idx_reservas_data_reserva ON reservas(data_reserva);
CREATE INDEX IF NOT EXISTS idx_reservas_situacao ON reservas(situacao_id);

-- ====================================================================
-- Bounded Context: Reports
-- ====================================================================

CREATE TABLE IF NOT EXISTS relatorio_specs (
    id SERIAL PRIMARY KEY,
    tipo VARCHAR(50) NOT NULL,
    template VARCHAR(255) NOT NULL,
    descricao TEXT,
    created_at TIMESTAMP NOT NULL DEFAULT NOW(),
    updated_at TIMESTAMP NOT NULL DEFAULT NOW()
);

CREATE INDEX IF NOT EXISTS idx_relatorio_specs_tipo ON relatorio_specs(tipo);

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

-- ====================================================================
-- Shared: Domain Events
-- ====================================================================

CREATE TABLE IF NOT EXISTS domain_events (
    id BIGSERIAL PRIMARY KEY,
    event_type VARCHAR(255) NOT NULL,
    event_data JSONB NOT NULL,
    aggregate_type VARCHAR(100) NOT NULL,
    aggregate_id VARCHAR(100) NOT NULL,
    occurred_at TIMESTAMP NOT NULL DEFAULT NOW(),
    correlation_id UUID,
    created_at TIMESTAMP NOT NULL DEFAULT NOW()
);

CREATE INDEX IF NOT EXISTS idx_domain_events_type ON domain_events(event_type);
CREATE INDEX IF NOT EXISTS idx_domain_events_aggregate ON domain_events(aggregate_type, aggregate_id);
CREATE INDEX IF NOT EXISTS idx_domain_events_occurred ON domain_events(occurred_at);

-- ====================================================================
-- Funções
-- ====================================================================

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

-- ====================================================================
-- Views
-- ====================================================================

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

-- ====================================================================
-- Triggers
-- ====================================================================

CREATE OR REPLACE FUNCTION trg_atualizar_qtde_titulo()
RETURNS TRIGGER AS $$
BEGIN
    UPDATE titulos
    SET qtde = (SELECT COUNT(*) FROM cds WHERE id_titulo = NEW.id_titulo)
    WHERE id = NEW.id_titulo;

    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

DROP TRIGGER IF EXISTS tr_cds_insert_qtde ON cds;
DROP TRIGGER IF EXISTS tr_cds_update_qtde ON cds;
DROP TRIGGER IF EXISTS tr_cds_delete_qtde ON cds;

CREATE TRIGGER tr_cds_insert_qtde
AFTER INSERT ON cds
FOR EACH ROW EXECUTE FUNCTION trg_atualizar_qtde_titulo(NEW);

CREATE TRIGGER tr_cds_update_qtde
AFTER UPDATE ON cds
FOR EACH ROW EXECUTE FUNCTION trg_atualizar_qtde_titulo(NEW);

CREATE TRIGGER tr_cds_delete_qtde
AFTER DELETE ON cds
FOR EACH ROW EXECUTE FUNCTION trg_atualizar_qtde_titulo(OLD);

-- ====================================================================
-- Finalização
-- ====================================================================

COMMENT ON DATABASE postgres IS 'Sistema de Locação de CDs - Migração do VB6 legado';
