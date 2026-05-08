# Relatórios, Design Técnico

> Design técnico da feature de relatórios do sistema CDsLoc
> Gerado pelo Reversa em 2026-05-08

---

## Interface

### Menu de Relatórios (MENU02.FRM)

| Componente | Tipo | Descrição | Confiança |
|------------|------|-----------|-----------|
| **Menu → Imprimir** | MenuItem | Acessa sub-menu de relatórios | 🟢 |
| **Configurar Impressora** | MenuItem | Abre diálogo de configuração de impressora | 🟢 |
| **Clientes Sintético** | MenuItem | Gera relatório sintético de clientes | 🟢 |
| **Clientes Analítico** | MenuItem | Gera relatório analítico de clientes | 🟢 |
| **Dependentes** | MenuItem | Gera relatório de dependentes | 🟢 |
| **Músicas/Intérpretes** | MenuItem | Gera relatório de músicas com intérpretes | 🟢 |
| **Apenas Músicas** | MenuItem | Gera relatório de apenas músicas | 🟢 |
| **CD's** | MenuItem | Gera relatório de CDs físicos | 🟢 |
| **Títulos** | MenuItem | Gera relatório de títulos | 🟢 |
| **Reservas** | MenuItem | Gera relatório de reservas | 🟢 |

---

## Fluxo Principal

### Geração de Relatório

Para cada relatório, o fluxo é o mesmo:

1. Usuário seleciona tipo de relatório no menu

2. Sistema carrega arquivo do Crystal Reports correspondente:
   - `clien01.rpt` para Clientes Sintético
   - `clien02.rpt` para Clientes Analítico
   - `depend.rpt` para Dependentes
   - `musicas.rpt` para Músicas/Intérpretes
   - `musicas1.rpt` para Apenas Músicas
   - `cds.rpt` para CDs Físicos
   - `titulos.rpt` para Títulos
   - `reserva.rpt` para Reservas

3. Sistema define conexão com banco de dados:
   - Configura path do banco de dados `BD_CDLOC.mdb`
   - Define usuário e senha (se aplicável)

4. Sistema executa relatório:
   - Crystal Reports carrega dados do banco
   - Relatório é exibido no Crystal Reports Viewer

5. Usuário pode:
   - Visualizar o relatório
   - Imprimir
   - Exportar (PDF, Excel, etc., dependendo da versão do Crystal Reports)
   - Fechar

### Configuração de Impressora

1. Usuário seleciona "Configurar Impressora" no menu

2. Sistema chama função do Windows para exibir diálogo de impressora:
   - `CommonDialog.ShowPrinter`

3. Usuário seleciona impressora e configurações

4. Sistema salva configuração como impressora padrão

---

## Relatórios Disponíveis

### clien01.rpt - Clientes Sintético

Relatório resumido de clientes, provavelmente contendo:
- Código do cliente
- Nome do cliente
- Endereço
- Telefone
- Situação (Ativo/Cancelado)

### clien02.rpt - Clientes Analítico

Relatório detalhado de clientes, contendo:
- Todos os campos da tabela Cliente
- Dependentes (se houver)
- Estatísticas (locações, reservas, etc.)

### depend.rpt - Dependentes

Relatório de dependentes, contendo:
- Código do cliente titular
- Nome do cliente
- Código do dependente
- Nome do dependente

### musicas.rpt - Músicas/Intérpretes

Relatório de músicas com intérpretes, contendo:
- Código da música
- Nome da música
- Intérpretes relacionados
- Tempo (se informado)

### musicas1.rpt - Apenas Músicas

Relatório simplificado de músicas, contendo:
- Código da música
- Nome da música
- Tempo (se informado)

### cds.rpt - CDs Físicos

Relatório de CDs físicos, contendo:
- Código do CD
- Número do CD
- Título relacionado
- Situação (Disponível/Locado)
- Data de compra
- Valor de compra

### titulos.rpt - Títulos

Relatório de títulos, contendo:
- Código do título
- Nome do título
- Tipo de locação
- Quantidade
- Valor
- Grupo/Estilo (se informado)

### reserva.rpt - Reservas

Relatório de reservas, contendo:
- Código da reserva
- Código do cliente
- Nome do cliente
- Código do título
- Nome do título
- Data da reserva
- Situação

---

## Dependências

| Dependência | Motivo | Como Usa |
|-------------|--------|----------|
| **Crystal Reports** | Motor de relatórios | Carrega e exibe arquivos `.rpt` |
| **Tabela Cliente** | Relatórios de clientes | Fonte de dados |
| **Tabela dependente** | Relatório de dependentes | Fonte de dados |
| **Tabela musica** | Relatórios de músicas | Fonte de dados |
| **Tabela cd** | Relatório de CDs | Fonte de dados |
| **Tabela titulo** | Relatórios de títulos | Fonte de dados |
| **Tabela reserva** | Relatório de reservas | Fonte de dados |

---

## Decisões de Design Identificadas

| Decisão | Evidência no código | Confiança |
|---------|---------------------|-----------|
| **Crystal Reports como motor** | Uso de arquivos `.rpt` e controle Crystal Reports | 🟢 CONFIRMADO |
| **Arquivos externos de relatório** | Relatórios armazenados como arquivos `.rpt` | 🟢 CONFIRMADO |
| **Dois relatórios de clientes** | `clien01.rpt` e `clien02.rpt` | 🟢 CONFIRMADO |
| **Dois relatórios de músicas** | `musicas.rpt` e `musicas1.rpt` | 🟢 CONFIRMADO |

---

## Estado Interno

### Variáveis Locais

Não há variáveis específicas documentadas para esta feature.

### Estados do Formulário

| Estado | Descrição | Flags/Ações |
|--------|-----------|-------------|
| **Menu Aberto** | Menu Imprimir acessível | MenuItem habilitado |
| **Relatório em Exibição** | Crystal Reports Viewer aberto | Relatório carregado, dados exibidos |
| **Diálogo de Impressora** | Configuração de impressora aberta | Diálogo do Windows exibido |

---

## Observabilidade

Não há observabilidade específica documentada para esta feature.

---

## Riscos e Lacunas

- 🔴 **Dependência de Crystal Reports:** Sistema depende de Crystal Reports instalado - pode não funcionar sem a instalação
- 🔴 **Estrutura dos relatórios não analisada:** Campos exibidos em cada relatório não foram documentados - requer análise dos arquivos `.rpt`
- 🔴 **Parâmetros de relatório:** Não confirmado se os relatórios aceitam parâmetros (filtro por período, cliente específico, etc.)
