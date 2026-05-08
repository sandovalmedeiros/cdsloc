# Inventário — CDsLoc

> Gerado pelo Reversa em 2026-05-08
> Sistema de Locação de CDs — Visual Basic 6.0

---

## Resumo Executivo

- **Linguagem Principal:** Visual Basic 6.0 (VB6)
- **Tipo de Aplicação:** MDI (Multiple Document Interface) Desktop
- **Banco de Dados:** Microsoft Access (DAO 2.5)
- **Framework de Relatórios:** Crystal Reports
- **Total de Arquivos:** ~70 arquivos

---

## Estrutura de Pastas

O projeto não utiliza subdiretórios significativos. Todos os arquivos estão organizados na raiz do diretório.

**Estrutura plana:**
```
D:\Legados\Apps\Cd-Loc32\
├── *.vbp          (1 arquivo de projeto)
├── *.vbw          (1 arquivo de workspace)
├── *.frm          (17 formulários)
├── *.frx          (16 recursos de formulários)
├── *.bas          (2 módulos de código)
├── *.rpt          (12 relatórios Crystal Reports)
├── *.mdb          (2 bancos de dados Access)
├── *.bmp          (2 imagens)
├── *.log          (4 arquivos de log)
├── *.msg          (1 arquivo de mensagens)
├── *.txt          (1 arquivo de constantes)
├── *.scc          (1 arquivo de controle de versão)
├── *.swt          (2 arquivos de instalação)
├── *.dep          (1 arquivo de dependências)
└── *.pdm          (1 arquivo de modelo de dados)
```

---

## Formulários (Forms)

| Arquivo | Nome do Form | Descrição |
|---------|--------------|-----------|
| SENHA.FRM | Senha | Formulário de autenticação/login |
| MENU02.FRM | Principal | Formulário MDI principal (menu do sistema) |
| cliente.frm | Clientes | Cadastro de clientes |
| SOBRESEN.FRM | SobreSen | Sobre o sistema/senha |
| PAINEL.FRM | Painel | Tela de abertura/splash screen |
| CAD_DEP.FRM | Cad_Dep | Cadastro de dependentes |
| REL_CLID.FRM | Rel_CliD | Relatório de clientes |
| CDS.FRM | Cds | Cadastro de CDs físicos |
| tabelas.frm | Tabelas | Cadastro de tabelas auxiliares |
| LOCDEVOL.FRM | LocDevol | Locação e devolução de CDs |
| CONSRES1.FRM | ConsRes1 | Consulta de reservas (versão 1) |
| CONSREC1.FRM | ConsRec1 | Consulta de recebimentos |
| reservcd.frm | ReservCD | Reserva de CDs |
| CONSRES2.FRM | ConsRes2 | Consulta de reservas (versão 2) |
| CONSRES3.FRM | ConsRes3 | Consulta de reservas (versão 3) |
| frmConsulta.frm | frmConsulta | Formulário genérico de consulta |
| frmPainel.frm | frmPainel | Formulário de painel |

---

## Módulos (Modules)

| Arquivo | Nome do Módulo | Descrição |
|---------|----------------|-----------|
| DECLARA.BAS | Declara | Módulo de declarações globais e funções comuns |
| ARQUIMSG.BAS | ArquiMsg | Módulo de mensagens do sistema |
| CONSTANT.TXT | Module2 | Constantes globais do VB6 |

---

## Relatórios (Crystal Reports)

| Arquivo | Descrição |
|---------|-----------|
| clien01.rpt | Relatório de clientes - Sintético |
| clien02.rpt | Relatório de clientes - Analítico |
| clien03.rpt | Relatório de clientes - Outra versão |
| clientes.rpt | Relatório geral de clientes |
| depend.rpt | Relatório de dependentes |
| musicas.rpt | Relatório de músicas/intérpretes |
| musicas1.rpt | Relatório apenas de músicas |
| cds.rpt | Relatório de CDs físicos |
| titulos.rpt | Relatório de títulos |
| reserva.rpt | Relatório de reservas |
| anivmes.rpt | Relatório de aniversariantes do mês |
| TMPCLI.RPT | Template de relatório de clientes |

---

## Banco de Dados

| Arquivo | Descrição |
|---------|-----------|
| BD_CDLOC.mdb | Banco de dados de produção |
| BD_CDLOC_Desenv.mdb | Banco de dados de desenvolvimento |

**Tabelas identificadas no código:**
- Cliente
- dependente
- cd
- interprete
- grupo
- estilo
- Municipio
- Bairro
- musica
- titulo
- titulo-interprete
- musica-interprete
- titulo-musica
- locacao
- recibo
- reserva
- valor_loc
- senha

---

## Componentes OCX Utilizados

| OCX | Descrição |
|-----|-----------|
| COMDLG32.OCX | Common Dialog (diálogos de arquivo, cor, fonte, impressora) |
| CRYSTL32.OCX | Crystal Reports Control |
| MSMASK32.OCX | Masked Edit Control |
| PICCLP32.OCX | Picture Clip Control |
| THREED32.OCX | Sheridan 3D Controls |
| GRID32.OCX | Grid Control |
| DBGRID32.OCX | DBGrid (grid vinculado a dados) |
| TABCTL32.OCX | Tab Control (abas) |
| DBLIST32.OCX | DBList (lista vinculada a dados) |
| MSFLXGRD.OCX | MSFlexGrid (grid flexível da Microsoft) |
| COMCTL32.OCX | Windows Common Controls (StatusBar, etc.) |

---

## Bibliotecas Referenciadas

| Biblioteca | Versão | Descrição |
|------------|--------|-----------|
| Microsoft DAO 2.5 Object Library | 3.5 | Data Access Objects para Access |

---

## Pontos de Entrada

1. **Startup Form:** `Principal` (MENU02.FRM) - Formulário MDI principal
2. **Fluxo de inicialização:**
   - `MDIForm_Load` chama `SetaBanco()` para conectar ao banco de dados
   - Exibe `frmPainel.frm` (tela de abertura)
   - Exibe `Senha.frm` como modal (autenticação)
   - Após login, descarrega `frmPainel.frm`

---

## Módulos Funcionais Identificados

### Cadastro
- Clientes (clientes.frm)
- Dependentes (CAD_DEP.FRM)
- CDs (CDS.FRM)
- Tabelas auxiliares (tabelas.frm)

### Movimentação
- Locação/Devolução (LOCDEVOL.FRM)

### Reservas
- Reserva de CDs (reservcd.frm)
- Consultas de reservas (CONSRES1.FRM, CONSRES2.FRM, CONSRES3.FRM)

### Consultas
- Consulta genérica (frmConsulta.frm)
- Consulta de recebimentos (CONSREC1.FRM)

### Relatórios
- Múltiplos relatórios via menu Imprimir

### Sistema
- Autenticação (SENHA.FRM)
- Menu principal (MENU02.FRM)
- Sobre o sistema (SOBRESEN.FRM)
