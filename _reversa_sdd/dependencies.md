# Dependências — CDsLoc

> Gerado pelo Reversa em 2026-05-08

---

## Resumo

- **Gerenciador de Pacotes:** N/A (Visual Basic 6 não usa gerenciador de pacotes moderno)
- **Total de Dependências:** 12 controles OCX + 1 biblioteca de acesso a dados

---

## Controles OCX (ActiveX Controls)

| Nome | Versão | GUID | Descrição |
|------|--------|------|-----------|
| COMDLG32.OCX | 1.2 | {F9043C88-F6F2-101A-A3C9-08002B2F49FB} | Microsoft Common Dialog Control - Diálogos de arquivo, cor, fonte, impressora |
| CRYSTL32.OCX | 5.2 | {00025600-0000-0000-C000-000000000046} | Crystal Reports Control - Geração de relatórios |
| MSMASK32.OCX | 1.1 | {C932BA88-4374-101B-A56C-00AA003668DC} | Microsoft Masked Edit Control - Campos com máscara de entrada |
| PICCLP32.OCX | 1.1 | {27395F88-0C0C-101B-A3C9-08002B2F49FB} | Microsoft Picture Clip Control - Manipulação de imagens |
| THREED32.OCX | 1.0 | {0BA686C6-F7D3-101B-993E-0000C0EF6F5E} | Sheridan 3D Controls - Controles com efeito 3D |
| GRID32.OCX | 1.0 | {A8B3B723-0B5A-101B-B22E-00AA0037B2FC} | Microsoft Grid Control - Grade de exibição de dados |
| DBGRID32.OCX | 1.0 | {00028C01-0000-0000-0000-000000000046} | Microsoft Data Bound Grid - Grade vinculada a dados |
| TABCTL32.OCX | 1.1 | {BDC217C8-ED16-11CD-956C-0000C04E4C0A} | Microsoft Tabbed Dialog Control - Controle de abas |
| DBLIST32.OCX | 1.1 | {FAEEE763-117E-101B-8933-08002B2F4F5A} | Microsoft Data Bound List Controls - Listas vinculadas a dados |
| MSFLXGRD.OCX | 1.0 | {5E9E78A0-531B-11CF-91F6-C2863C385E30} | Microsoft FlexGrid Control - Grid flexível |
| COMCTL32.OCX | 1.3 | {6B7E6392-850A-101B-AFC0-4210102A8DA7} | Microsoft Windows Common Controls - StatusBar, ProgressBar, etc. |

---

## Bibliotecas de Acesso a Dados

| Nome | Versão | Localização (referência) | Descrição |
|------|--------|-------------------------|-----------|
| Microsoft DAO 2.5 Object Library | 3.5 | C:\Arquivos de Programas\Arquivos comuns\Microsoft Shared\DAO\DAO2535.TLB | Data Access Objects - Acesso ao banco de dados Access via Jet Engine |

---

## Dependências de Runtime (Necessárias para Execução)

Para executar o sistema compilado (Menu.exe), os seguintes componentes devem estar registrados no Windows:

1. **Visual Basic 6.0 Runtime Files:**
   - MSVBVM60.DLL (Visual Basic Virtual Machine)
   - OLEAUT32.DLL (OLE Automation)
   - OLEPRO32.DLL (OLE Properties)

2. **Controles OCX** (devem ser registrados via `regsvr32`):
   - COMDLG32.OCX
   - CRYSTL32.OCX
   - MSMASK32.OCX
   - PICCLP32.OCX
   - THREED32.OCX
   - GRID32.OCX
   - DBGRID32.OCX
   - TABCTL32.OCX
   - DBLIST32.OCX
   - MSFLXGRD.OCX
   - COMCTL32.OCX

3. **Crystal Reports Runtime:**
   - CRPE32.DLL (Crystal Reports Print Engine)
   - P2smon.dll e outros arquivos do Crystal Reports

---

## Notas sobre Dependências

### Crystal Reports
- Versão referenciada: 4.6 ou 5.2 (dependendo do OCX)
- Necessita runtime do Crystal Reports instalado
- Arquivos .RPT são independentes do código VB6

### DAO (Data Access Objects)
- Versão 2.5 é uma versão antiga do DAO
- Tabelas são abertas via `OpenRecordset()`
- QueryDefs são usadas para consultas parametrizadas

### Controles 3D (Sheridan)
- THREED32.OCX é um controle de terceiros
- Fornece efeitos 3D para botões, frames e painéis
- Pode ser difícil encontrar em instalações modernas do Windows

---

## Arquivos de Instalação Detectados

| Arquivo | Descrição |
|---------|-----------|
| Instalação Sistema com Banco de Dados.SWT | Instalador do sistema com banco de dados |
| Intalação Sistema CD's Loc.SWT | Instalador do sistema (observado erro de digitação no nome) |

---

## Risco de Obsolescência

| Componente | Risco | Motivo |
|------------|-------|--------|
| Visual Basic 6.0 | **CRÍTICO** | Descontinuado pela Microsoft em 2008 |
| DAO 2.5 | **ALTO** | Versão muito antiga, substituída por ADO e posteriormente por ADO.NET |
| Crystal Reports (antigo) | **ALTO** | Versão descontinuada, runtime pode não funcionar em Windows 10/11 |
| THREED32.OCX | **ALTO** | Controle de terceiros, pode não estar disponível |
| DBGRID32.OCX | **MÉDIO** | Controle antigo, substituído por componentes mais modernos |
| COMCTL32.OCX | **BAIXO** | Ainda disponível no Windows |

---

## Caminho Mínimo de Migração

Para um sistema moderno, as dependências seriam substituídas por:

| Antigo | Substituição Sugerida |
|--------|---------------------|
| DAO 2.5 | ORM moderno (Entity Framework, Dapper) ou ADO.NET |
| Crystal Reports | FastReport, Stimulsoft Reports, ou PDF gerado via código |
| THREED32.OCX | CSS/Controles modernos do framework de UI |
| DBGRID32.OCX | DataGrid do framework (DataGridView, DataTable) |
| MSFLXGRD.OCX | Grid moderno do framework |
| COMDLG32.OCX | Diálogos nativos do SO/framework |
