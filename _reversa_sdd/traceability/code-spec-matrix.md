# Code-Spec Matrix — CDsLoc

> Matriz de rastreabilidade entre arquivos do legado e specs geradas
> Gerado pelo Reversa em 2026-05-08

---

## Legenda

| Símbolo | Significado |
|---------|-------------|
| 🟢 | Cobertura completa (todos os comportamentos documentados) |
| 🟡 | Cobertura parcial (alguns comportamentos documentados) |
| 🔴 | Sem cobertura (não analisado ou não há correspondência) |
| n/a | Não aplicável (arquivo não contém lógica de negócio) |

---

## Matriz de Rastreabilidade

| Arquivo do Legado | Feature Correspondente | Cobertura |
|---------------------|------------------------|-----------|
| **DECLARA.BAS** | Global | 🟢 |
| **ARQUIMSG.BAS** | Global | 🟢 |
| **MENU.FRM** | Global | 🟡 |
| **MENU02.FRM** | Global | 🟢 |
| **SENHA.FRM** | Global | 🟢 |
| **frmPainel.frm** | Global | 🟡 |
| **CAD_DEP.FRM** | cadastro-clientes | 🟡 |
| **CLIENTE.FRM** | cadastro-clientes | 🟢 |
| **CDS.FRM** | cadastro-cds | 🟢 |
| **LOCDEVOL.FRM** | movimentacao | 🟢 |
| **CONSREC1.FRM** | movimentacao | 🟡 |
| **CONSRES1.FRM** | reservas | 🟡 |
| **CONSRES2.FRM** | reservas | 🟡 |
| **CONSRES3.FRM** | reservas | 🟡 |
| **frmConsulta.frm** | consultas | 🟢 |
| **BD_CDLOC.mdb** | Global | 🟢 |
| **CONSTANT.TXT** | Global | 🟡 |
| **BINOCULO.BMP** | Global | n/a |
| **CLAUDE.md** | Global | n/a |
| **ARQUIMSG.MSG** | Global | 🟢 |
| **Instalação Sistema com Banco de Dados.SWT** | Global | n/a |
| **Intalação Sistema CD's Loc.SWT** | Global | n/a |
| **CDS.log** | cadastro-cds | n/a |
| **CLIENTE.log** | cadastro-clientes | n/a |
| **CLIENTE.FRX** | cadastro-clientes | n/a |
| **CAD_DEP.FRX** | cadastro-clientes | n/a |
| **CDS.FRX** | cadastro-cds | n/a |
| **LOCDEVOL.FRX** | movimentacao | n/a |
| **CONSREC1.FRX** | movimentacao | n/a |
| **CONSRES1.FRX** | reservas | n/a |
| **CONSRES2.FRX** | reservas | n/a |
| **CONSRES3.FRX** | reservas | n/a |

---

## Detalhamento por Feature

### cadastro-clientes

| Arquivo do Legado | Responsabilidade | Cobertura |
|---------------------|-----------------|-----------|
| `CLIENTE.FRM` | Formulário principal de clientes | 🟢 |
| `CLIENTE.FRM` | `dados_cliente2()` | 🟢 |
| `CLIENTE.FRM` | `SSCmdGrava_Cli_Click` | 🟢 |
| `CLIENTE.FRM` | `SSCmdExc_Cli_Click` | 🟢 |
| `CLIENTE.FRM` | `SSCmdCons_Cli_Click` | 🟢 |
| `CLIENTE.FRM` | `SSCmdGrava_Dep_Click` | 🟢 |
| `CLIENTE.FRM` | `limpacampos1()`, `limpacampos2()` | 🟢 |
| `CLIENTE.FRM` | Pesquisa de clientes (F10) | 🟢 |
| `DECLARA.BAS` | `geracod()` | 🟢 |
| `DECLARA.BAS` | `LimpaCampos()` | 🟢 |
| `Tabela Cliente` | Persistência de clientes | 🟢 |
| `Tabela dependente` | Persistência de dependentes | 🟢 |
| `Tabela Bairro` | Lista de bairros | 🟢 |
| `QueryDef Cs_Clientes` | Consulta parametrizada | 🟢 |
| `QueryDef Cs_Dependente` | Consulta parametrizada | 🟢 |

### cadastro-cds

| Arquivo do Legado | Responsabilidade | Cobertura |
|---------------------|-----------------|-----------|
| `CDS.FRM` | Formulário principal de CDs | 🟢 |
| `CDS.FRM` | Aba Títulos | 🟢 |
| `CDS.FRM` | Aba Músicas | 🟢 |
| `CDS.FRM` | Aba CDs | 🟢 |
| `CDS.FRM` | `dados_titulo()` | 🟢 |
| `CDS.FRM` | `dados_cd()` | 🟢 |
| `CDS.FRM` | `pesq_titulo()` | 🟢 |
| `CDS.FRM` | Gravação de título | 🟢 |
| `CDS.FRM` | Gravação de música | 🟢 |
| `CDS.FRM` | Gravação de CD | 🟢 |
| `Tabela titulo` | Persistência de títulos | 🟢 |
| `Tabela musica` | Persistência de músicas | 🟢 |
| `Tabela cd` | Persistência de CDs | 🟢 |
| `Tabela interprete` | Persistência de intérpretes | 🟢 |
| `Tabela titulo-musica` | Relacionamento | 🟢 |
| `Tabela titulo-interprete` | Relacionamento | 🟢 |
| `Tabela musica-interprete` | Relacionamento | 🟢 |
| `Tabela grupo` | Classificação | 🟢 |
| `Tabela estilo` | Classificação | 🟢 |

### movimentacao

| Arquivo do Legado | Responsabilidade | Cobertura |
|---------------------|-----------------|-----------|
| `LOCDEVOL.FRM` | Formulário de locação/devolução | 🟢 |
| `LOCDEVOL.FRM` | Aba Locação | 🟢 |
| `LOCDEVOL.FRM` | Aba Devolução | 🟢 |
| `LOCDEVOL.FRM` | Aba Recibo | 🟢 |
| `LOCDEVOL.FRM` | `pesquisa_cliente()` | 🟢 |
| `LOCDEVOL.FRM` | `pesquisa_reserva()` | 🟢 |
| `LOCDEVOL.FRM` | `cons_recibo()` | 🟢 |
| `LOCDEVOL.FRM` | `grava_recibo()` | 🟢 |
| `LOCDEVOL.FRM` | `SSCmdGrava_Loc_Click` | 🟢 |
| `LOCDEVOL.FRM` | `SSCmdBaixa_Click` | 🟢 |
| `CONSREC1.FRM` | Consulta de recibo | 🟡 |
| `Tabela locacao` | Persistência de locações | 🟢 |
| `Tabela recibo` | Persistência de recibos | 🟢 |
| `Tabela cd` | Atualização de situação | 🟢 |
| `Tabela Cliente` | Dados do cliente | 🟢 |
| `Tabela dependente` | Dados do dependente | 🟢 |

### reservas

| Arquivo do Legado | Responsabilidade | Cobertura |
|---------------------|-----------------|-----------|
| `CONSRES1.FRM` | Formulário de reservas | 🟡 |
| `CONSRES2.FRM` | Consulta de reserva | 🟡 |
| `CONSRES3.FRM` | Consulta de reserva | 🟡 |
| `Tabela reserva` | Persistência de reservas | 🟢 |
| `Tabela titulo` | Dados do título | 🟢 |
| `Tabela Cliente` | Dados do cliente | 🟢 |

### consultas

| Arquivo do Legado | Responsabilidade | Cobertura |
|---------------------|-----------------|-----------|
| `frmConsulta.frm` | Formulário de consultas | 🟢 |
| `frmConsulta.frm` | `executa_consulta()` | 🟢 |
| `frmConsulta.frm` | `preenche_grid()` | 🟢 |
| `Tabela titulo` | Consulta de títulos | 🟢 |
| `Tabela musica` | Consulta de músicas | 🟢 |
| `Tabela cd` | Consulta de CDs | 🟢 |
| `Tabela Cliente` | Consulta de clientes | 🟢 |
| `Tabela locacao` | Consulta de locações | 🟢 |
| `Tabela reserva` | Consulta de reservas | 🟢 |

### relatorios

| Arquivo do Legado | Responsabilidade | Cobertura |
|---------------------|-----------------|-----------|
| `MENU02.FRM` | Menu Imprimir | 🟢 |
| `clien01.rpt` | Relatório Clientes Sintético | 🟡 |
| `clien02.rpt` | Relatório Clientes Analítico | 🟡 |
| `depend.rpt` | Relatório Dependentes | 🟡 |
| `musicas.rpt` | Relatório Músicas/Intérpretes | 🟡 |
| `musicas1.rpt` | Relatório Apenas Músicas | 🟡 |
| `cds.rpt` | Relatório CDs Físicos | 🟡 |
| `titulos.rpt` | Relatório Títulos | 🟡 |
| `reserva.rpt` | Relatório Reservas | 🟡 |

---

## Arquivos Sem Cobertura

Os seguintes arquivos não foram analisados em detalhe:

| Arquivo | Motivo |
|---------|---------|
| `CAD_DEP.FRM` | Análise parcial, requer verificação se é diferente de CLIENTE.FRM |
| `CONSRES2.FRM` | Análise parcial, requer verificação de funcionalidade específica |
| `CONSRES3.FRM` | Análise parcial, requer verificação de funcionalidade específica |
| `CONSTANT.TXT` | Análise parcial, requer verificação de constantes definidas |
| `MENU.FRM` | Análise parcial, possivelmente substituído por MENU02.FRM |
| Arquivos `.log` | Logs de sistema, não contêm lógica |
| Arquivos `.FRX` | Resources de formulários, não contêm código |
| Arquivos `.SWM` | Arquivos de instalação, não contêm lógica |

---

## Cobertura Estimada

| Feature | Cobertura | Observações |
|---------|-----------|-------------|
| cadastro-clientes | 95% | Cobertura quase completa |
| cadastro-cds | 90% | Cobertura boa, detalhes de relacionamentos podem ser expandidos |
| movimentacao | 90% | Cobertura boa, cálculo de multa não confirmado |
| reservas | 70% | Análise parcial, requer detalhamento adicional |
| consultas | 95% | Cobertura quase completa |
| relatorios | 40% | Apenas listagem de relatórios, estruturas não analisadas |
| **Média Geral** | **80%** | Cobertura satisfatória para reimplementação |

---

## Observações

- A maioria dos arquivos `.FRM` e `.BAS` foi analisada completamente
- Arquivos de recursos (`.FRX`, `.BMP`, `.MSG`) não contêm lógica de negócio
- Relatórios requerem análise detalhada dos arquivos `.rpt` para documentar campos exibidos
- Logs e arquivos de instalação não foram priorizados
