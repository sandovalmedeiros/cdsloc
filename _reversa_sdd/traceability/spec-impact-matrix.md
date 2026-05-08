# Spec Impact Matrix — CDsLoc

> Gerado pelo Reversa em 2026-05-08
> Matriz de rastreabilidade e impacto entre componentes do sistema

---

## Descrição

A Spec Impact Matrix mostra como cada componente do sistema impacta outros componentes. Isso é útil para:
- Entender o impacto de mudanças
- Identificar dependências ocultas
- Planejar refatorações
- Avaliar riscos de regressão

---

## Matriz de Impacto por Componente

### Módulo de Autenticação (SENHA.FRM)

| Componente Afetado | Tipo de Impacto | Descrição | Severidade |
|-------------------|-----------------|-----------|------------|
| MENU02.FRM | Orquestração | Não inicia sem autenticação bem-sucedida | 🔴 CRÍTICA |
| Todos os formulários | Acesso | Bloqueados até login | 🔴 CRÍTICA |
| tabela `senha` | Dados | Contém a senha do sistema | 🔴 CRÍTICA |

**Impacto de mudança em SENHA.FRM:** 🟡 ALTO
- Mudança na lógica de autenticação afeta todos os módulos
- Substituição por hash de senha requer atualização da tabela `senha`

---

### Módulo de Cadastro de Clientes (cliente.frm)

| Componente Afetado | Tipo de Impacto | Descrição | Severidade |
|-------------------|-----------------|-----------|------------|
| LOCDEVOL.FRM | Dados | Necessita clientes ativos para locação | 🟡 ALTA |
| reservcd.frm | Dados | Necessita clientes ativos para reservas | 🟡 ALTA |
| CONSRES*.FRM | Consulta | Consulta dados de clientes | 🟢 BAIXA |
| tabela `Cliente` | Dados | Principal fonte de dados de clientes | 🔴 CRÍTICA |
| tabela `dependente` | Dados | Vinculada a clientes | 🟡 ALTA |
| tabela `Bairro` | Dados | FK em Cliente | 🟡 ALTA |
| tabela `Municipio` | Dados | FK em Bairro | 🟢 BAIXA |
| Relatórios de clientes | Relatórios | clien01.rpt, clien02.rpt, etc. | 🟡 ALTA |

**Impacto de mudança em cliente.frm:** 🟡 ALTO
- Mudança em campos de cliente afeta locação, reservas e relatórios
- Mudança na chave primária (`codcliente`) quebra todo o sistema

---

### Módulo de CDs (CDS.FRM)

| Componente Afetado | Tipo de Impacto | Descrição | Severidade |
|-------------------|-----------------|-----------|------------|
| LOCDEVOL.FRM | Dados | Necessita CDs disponíveis para locação | 🔴 CRÍTICA |
| reservcd.frm | Dados | Necessita títulos para reserva | 🔴 CRÍTICA |
| frmConsulta.frm | Consulta | Consulta dados de CDs, títulos, músicas | 🟡 ALTA |
| tabela `cd` | Dados | Principal fonte de CDs físicos | 🔴 CRÍTICA |
| tabela `titulo` | Dados | Principal fonte de títulos | 🔴 CRÍTICA |
| tabela `musica` | Dados | Músicas vinculadas a títulos | 🟡 ALTA |
| tabela `interprete` | Dados | Intérpretes vinculados | 🟢 BAIXA |
| Tabelas relacionais | Dados | titulo-interprete, titulo-musica, etc. | 🟡 ALTA |
| tabela `grupo`, `estilo` | Dados | FK em titulo | 🟢 BAIXA |
| Relatórios de CDs | Relatórios | cds.rpt, titulos.rpt, musicas.rpt | 🟡 ALTA |

**Impacto de mudança em CDS.FRM:** 🔴 CRÍTICO
- Mudança na estrutura de títulos/CDs afeta locação e reservas
- Mudança nas tabelas relacionais afeta consultas e relatórios

---

### Módulo de Locação (LOCDEVOL.FRM)

| Componente Afetado | Tipo de Impacto | Descrição | Severidade |
|-------------------|-----------------|-----------|------------|
| tabela `locacao` | Dados | Principal fonte de locações | 🔴 CRÍTICA |
| tabela `recibo` | Dados | Vinculado a locações | 🔴 CRÍTICA |
| tabela `cd` | Dados | Estado atualizado (situacao) | 🔴 CRÍTICA |
| tabela `Cliente` | Dados | Histórico de locações | 🟡 ALTA |
| tabela `reserva` | Dados | Reservas podem ser convertidas | 🟡 ALTA |
| Relatórios de locação | Relatórios | Recibos, movimentação | 🟡 ALTA |

**Impacto de mudança em LOCDEVOL.FRM:** 🔴 CRÍTICO
- Mudança no fluxo de locação afeta estado de CDs e histórico de clientes
- Mudança no cálculo de multa (se existir) afeta faturamento

---

### Módulo de Reservas (reservcd.frm)

| Componente Afetado | Tipo de Impacto | Descrição | Severidade |
|-------------------|-----------------|-----------|------------|
| LOCDEVOL.FRM | Dados | Verifica reservas ao locar | 🟡 ALTA |
| tabela `reserva` | Dados | Principal fonte de reservas | 🔴 CRÍTICA |
| tabela `titulo` | Dados | FK em reserva | 🟡 ALTA |
| tabela `Cliente` | Dados | FK em reserva | 🟡 ALTA |
| Relatórios de reservas | Relatórios | reserva.rpt | 🟡 ALTA |

**Impacto de mudança em reservcd.frm:** 🟡 ALTO
- Mudança no fluxo de reservas afeta locação
- Mudança na conversão reserva→locação pode quebrar o processo

---

### Módulo de Consultas (frmConsulta.frm)

| Componente Afetado | Tipo de Impacto | Descrição | Severidade |
|-------------------|-----------------|-----------|------------|
| Todas as tabelas | Consulta | Leitura de dados | 🟡 ALTA |
| Nenhum (read-only) | Escrita | Não escreve dados | 🟢 BAIXA |

**Impacto de mudança em frmConsulta.frm:** 🟢 BAIXO
- Módulo read-only, impacto limitado a consultas
- Mudanças afetam apenas visualização de dados

---

### Módulo de Tabelas Auxiliares (tabelas.frm)

| Componente Afetado | Tipo de Impacto | Descrição | Severidade |
|-------------------|-----------------|-----------|------------|
| cliente.frm | Dados | Usa Bairro | 🟡 ALTA |
| CDS.FRM | Dados | Usa grupo, estilo, interprete | 🟡 ALTA |
| CONSRES*.FRM | Consulta | Pode consultar tabelas auxiliares | 🟢 BAIXA |
| tabela `interprete` | Dados | FK em relacionais | 🟡 ALTA |
| tabela `grupo` | Dados | FK em titulo | 🟢 BAIXA |
| tabela `estilo` | Dados | FK em titulo | 🟢 BAIXA |
| tabela `Bairro` | Dados | FK em Cliente | 🟡 ALTA |
| tabela `Municipio` | Dados | FK em Bairro | 🟢 BAIXA |

**Impacto de mudança em tabelas.frm:** 🟡 ALTO
- Mudança em Bairro afeta cadastro de clientes
- Mudança em grupo/estilo/interprete afeta catálogo de CDs

---

### Módulo Global (DECLARA.BAS)

| Componente Afetado | Tipo de Impacto | Descrição | Severidade |
|-------------------|-----------------|-----------|------------|
| **TODOS os formulários** | Funções | geracod(), SetaBanco(), LimpaCampos() | 🔴 CRÍTICA |
| **TODOS os recordsets** | Dados | Variáveis globais de banco | 🔴 CRÍTICA |

**Impacto de mudança em DECLARA.BAS:** 🔴 CRÍTICO
- Mudança em funções globais afeta TODO o sistema
- Mudança em variáveis globais quebra múltiplos módulos
- 🚨 Ponto de maior risco de regressão

---

### Módulo de Mensagens (ARQUIMSG.BAS)

| Componente Afetado | Tipo de Impacto | Descrição | Severidade |
|-------------------|-----------------|-----------|------------|
| Formulários que usam mensagens | UX | Mensagens de erro/informação | 🟡 ALTA |
| Arquivo .msg externo | Conteúdo | Texto das mensagens | 🟢 BAIXA |

**Impacto de mudança em ARQUIMSG.BAS:** 🟡 ALTO
- Mudança no formato de mensagens afeta UX
- Pode quebrar exibição de mensagens

---

## Matriz de Impacto por Tabela

### Tabela `Cliente`

| Impacta em | Tipo | Severidade |
|------------|------|------------|
| cliente.frm | CRUD | 🔴 CRÍTICA |
| LOCDEVOL.FRM | Leitura/FK | 🔴 CRÍTICA |
| reservcd.frm | Leitura/FK | 🔴 CRÍTICA |
| CONSRES*.FRM | Consulta | 🟡 ALTA |
| Relatórios | Leitura | 🟡 ALTA |
| dependente | FK (1:N) | 🔴 CRÍTICA |

### Tabela `cd`

| Impacta em | Tipo | Severidade |
|------------|------|------------|
| CDS.FRM | CRUD | 🔴 CRÍTICA |
| LOCDEVOL.FRM | Leitura/Atualização | 🔴 CRÍTICA |
| frmConsulta.frm | Consulta | 🟡 ALTA |
| Relatórios | Leitura | 🟡 ALTA |
| locacao | FK (N:1) | 🔴 CRÍTICA |

### Tabela `locacao`

| Impacta em | Tipo | Severidade |
|------------|------|------------|
| LOCDEVOL.FRM | CRUD | 🔴 CRÍTICA |
| recibo | FK (1:1) | 🔴 CRÍTICA |
| Cliente | Histórico | 🟡 ALTA |
| Relatórios | Leitura | 🟡 ALTA |

### Tabela `titulo`

| Impacta em | Tipo | Severidade |
|------------|------|------------|
| CDS.FRM | CRUD | 🔴 CRÍTICA |
| reservcd.frm | Leitura/FK | 🔴 CRÍTICA |
| LOCDEVOL.FRM | Leitura (via cd) | 🔴 CRÍTICA |
| frmConsulta.frm | Consulta | 🟡 ALTA |
| Relatórios | Leitura | 🟡 ALTA |
| cd | FK (1:N) | 🔴 CRÍTICA |
| titulo-interprete | FK | 🟡 ALTA |
| titulo-musica | FK | 🟡 ALTA |

### Tabela `senha`

| Impacta em | Tipo | Severidade |
|------------|------|------------|
| SENHA.FRM | CRUD | 🔴 CRÍTICA |
| MENU02.FRM | Login | 🔴 CRÍTICA |
| Todo o sistema | Autenticação | 🔴 CRÍTICA |

---

## Mapa de Risco de Regressão

### 🔴 Zona Vermelha (Alto Risco)

Mudanças nestes componentes têm alto risco de quebrar outras partes:

1. **DECLARA.BAS** - Funções globais usadas por todo o sistema
2. **Tabela `Cliente`** - Usada em locação, reservas, consultas, relatórios
3. **Tabela `cd`** - Central para locação
4. **Tabela `locacao`** - Vincula clientes, CDs e recibos
5. **Tabela `titulo`** - Central para catálogo e reservas
6. **SENHA.FRM** - Bloqueia acesso a todo o sistema

### 🟡 Zona Amarela (Médio Risco)

Mudanças nestes componentes podem afetar várias partes:

1. **cliente.frm** - Mudança em campos afeta múltiplos módulos
2. **CDS.FRM** - Mudança em estrutura de títulos/CDs afeta locação
3. **LOCDEVOL.FRM** - Mudança no fluxo de locação afeta estado
4. **tabelas.frm** - Mudança em tabelas auxiliares afeta cadastros
5. **Tabela `recibo`** - Vinculado a locação
6. **Tabela `Bairro`** - FK em Cliente

### 🟢 Zona Verde (Baixo Risco)

Mudanças nestes componentes têm impacto limitado:

1. **frmConsulta.frm** - Read-only
2. **Tabela `interprete`** - Apenas catálogo
3. **Tabela `grupo`** - Apenas classificação
4. **Tabela `estilo`** - Apenas classificação
5. **Tabela `Municipio`** - FK em Bairro

---

## Recomendações para Refatoração

### Prioridade 1 (Imediata)

1. **Remover variáveis globais de DECLARA.BAS**
   - Criar camada de acesso a dados
   - Passar recordsets como parâmetros

2. **Isolar lógica de autenticação**
   - Mover para componente separado
   - Permitir múltiplos usuários

### Prioridade 2 (Curto Prazo)

1. **Criar serviço de locação**
   - Centralizar lógica de locação/devolução
   - Garantir atomicidade de transações

2. **Validar cálculo de multa**
   - 🔴 Localizar código existente
   - Se não existir, implementar

### Prioridade 3 (Médio Prazo)

1. **Criar serviço de catálogo**
   - Centralizar lógica de títulos/CDs
   - Facilitar consulta de disponibilidade

2. **Implementar eventos de domínio**
   - Notificar mudanças de estado (CD locado/devolvido)
   - Atualizar dependentes automaticamente
