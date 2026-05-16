# Schema do Banco de Dados - CDsLoc

## 📊 Resumo das Tabelas e Relações

Data de geração: 2026-05-12

---

## 🎵 Tabelas Principais do Catálogo

### titulos (526 registros)
| Campo | Tipo | Descrição |
|------|------|-----------|
| id | integer (PK) | Identificador único |
| nome | varchar(255) | Nome do título/álbum |
| tipo_locacao | varchar(10) | 24h ou 48h |
| valor | numeric(10,2) | Valor da locação |
| qtde | integer | Quantidade de CDs físicos |
| id_grupo | integer (FK) | → grupos.id (opcional) |
| id_estilo | integer (FK) | → estilos.id (opcional) |

**Relacionamentos:**
- → **cds** (um título tem muitos CDs físicos)
- → **titulos_musicas** (músicas do título)
- → **titulos_interpretes** (intérpretes do título)

---

### cds (569 registros)
| Campo | Tipo | Descrição |
|------|------|-----------|
| codigo | varchar (PK) | Código do CD físico (string) |
| id_titulo | integer (FK) | → titulos.id |
| numcd | varchar | Número/Descrição do CD |
| situacao_id | integer | → situacoes.id (1=Disponível, 2=Locado, 3=Reservado) |
| is_locado | boolean | Se está alugado |
| data_cp | date | Data de compra |
| valor_cp | numeric | Valor de compra |

**Relacionamentos:**
- → **titulos** (cada CD pertence a um título)
- → **situacoes** (status do CD)

---

### musicas (27,478 registros!)
| Campo | Tipo | Descrição |
|------|------|-----------|
| id | integer (PK) | Identificador único |
| nome | varchar(255) | Nome da música |
| tempo | integer | Duração em segundos (opcional) |

---

### interpretes (1,202 registros)
| Campo | Tipo | Descrição |
|------|------|-----------|
| id | integer (PK) | Identificador único |
| nome | varchar(255) | Nome do intérprete/artista |

---

### titulos_musicas (7,542 registros) ⭐
**Tabela de relacionamento Many-to-Many**

| Campo | Tipo | Descrição |
|------|------|-----------|
| id | integer (PK) | Identificador da relação |
| id_titulo | integer (FK) | → titulos.id |
| id_musica | integer (FK) | → musicas.id |
| created_at | timestamp | Data de criação |

**Relação:** Um título tem muitas músicas, uma música pode estar em vários títulos

---

### titulos_interpretes (529 registros) ⭐
**Tabela de relacionamento Many-to-Many**

| Campo | Tipo | Descrição |
|------|------|-----------|
| id | integer (PK) | Identificador da relação |
| id_titulo | integer (FK) | → titulos.id |
| id_interprete | integer (FK) | → interpretes.id |
| created_at | timestamp | Data de criação |

**Relação:** Um título tem muitos intérpretes, um intérprete pode estar em vários títulos

---

### grupos (8 registros)
Classificação musical (Rock, Pop, Jazz, etc.)

### estilos (18 registros)
Subclassificação (Hard Rock, Soft Rock, etc.)

---

## 👥 Tabelas de Clientes

### clientes (283 registros)
| Campo | Tipo | Descrição |
|------|------|-----------|
| id | integer (PK) | Identificador único |
| codcliente | varchar | Código do cliente (legado) |
| nomecliente | varchar(255) | Nome completo |
| endereco | varchar | Endereço |
| data_nascimento | date | Data de nascimento |
| cdbairro | integer (FK) | → bairros.id |
| cep | varchar | CEP |
| fone_01, fone_02, fone_03 | varchar | Telefones |
| identidade | varchar | RG |
| cpf | varchar | CPF |
| is_cancelado | boolean | Se está cancelado |
| obs | text | Observações |

---

### dependentes (489 registros)
| Campo | Tipo | Descrição |
|------|------|-----------|
| id | integer (PK) | Identificador único |
| cod_dependente | varchar | Código (legado) |
| id_cliente | integer (FK) | → clientes.id |
| nome_dependente | varchar(255) | Nome do dependente |

**Relação:** Um cliente tem muitos dependentes

---

### bairros (125 registros)
| Campo | Tipo | Descrição |
|------|------|-----------|
| id | integer (PK) | Identificador único |
| cdbairro | varchar | Código do bairro (legado) |
| debairro | varchar | Nome do bairro |
| id_municipio | integer (FK) | → municipios.id |

---

## 📋 Tabelas de Locação (Vazias)

### locacoes (0 registros)
Tabela principal de locações

### locacoes_itens (0 registros)
Itens de uma locação (CDs locados)

### reservas (0 registros)
Reservas de CDs

### situacoes_reservas (4 registros)
Status de reservas

---

## 💰 Tabelas Financeiras

### recibos (1 registro)
Cabeçalho de recibo

### recibo_itens (0 registros)
Itens de um recibo (CDs devolvidos)

---

## 🔐 Tabelas de Segurança

### users (0 registros)
Usuários do sistema

### roles (0 registros)
Papéis de usuário

### roles_users (0 registros)
Relação usuário ↔ papel

---

## 📈 Estatísticas dos Dados

| Tabela | Registros | Observação |
|--------|-----------|------------|
| musicas | 27,478 | Músicas cadastradas no sistema |
| titulos_musicas | 7,542 | Relação títulos ↔ músicas |
| interpretes | 1,202 | Intérpretes/artistas |
| cds | 569 | CDs físicos |
| clientes | 283 | Clientes cadastrados |
| dependentes | 489 | Dependentes |
| titulos | 526 | Títulos/álbuns |
| titulos_interpretes | 529 | Relação títulos ↔ intérpretes |

---

## 🎯 Relações Mais Importantes

```
┌─────────────┐
│   titulos   │ (526)
└──────┬──────┘
       │
       ├──→ cds (569) [1:N]
       │    └──→ situacoes
       │
       ├──→ titulos_musicas (7,542) [N:M]
       │    └──→ musicas (27,478)
       │
       └──→ titulos_interpretes (529) [N:M]
            └──→ interpretes (1,202)

┌─────────────┐
│  clientes  │ (283)
└──────┬──────┘
       │
       └──→ dependentes (489) [1:N]

┌─────────────┐
│   locacoes │ (0 - VAZIA)
└──────┬──────┘
       │
       └──→ locacoes_itens (0) [1:N]
            └──→ cds
```

---

## ⚠️ Observações Importantes

1. **Locações vazias:** As tabelas de locação (locacoes, reservas) estão vazias, indicando que o sistema ainda não foi usado para locações reais.

2. **Dados migrados:** Os dados de catálogo (títulos, músicas, intérpretes, CDs) foram migrados do sistema legado.

3. **Relações many-to-many:** As tabelas `titulos_musicas` e `titulos_interpretes` implementam relacionamentos muitos-para-muitos, permitindo que:
   - Uma música apareça em vários títulos (ex: diferentes compilações)
   - Um intérprete participe de vários títulos
   - Um título tenha múltas músicas e múltiplos intérpretes

4. **Código do CD:** O campo `codigo` na tabela `cds` é string, não integer, permitindo códigos como "CD001", "ABBEY01", etc.
