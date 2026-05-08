# Relatórios, Tarefas de Implementação

> Tarefas executáveis para reimplementar a feature de relatórios
> Gerado pelo Reversa em 2026-05-08

---

## Pré-requisitos

- [ ] Tabelas `Cliente`, `dependente`, `musica`, `cd`, `titulo`, `reserva` existem no banco
- [ ] Crystal Reports ou motor de relatórios equivalente instalado
- [ ] Arquivos de relatórios `.rpt` disponíveis ou equivalente

---

## Tarefas

### Tarefas de Implementação

- [ ] T-01, Implementar menu de relatórios
  - Origem no legado: `MENU02.FRM`
  - Critério de pronto: Menu Imprimir com sub-menus para cada relatório
  - Confiança: 🟢 CONFIRMADO

- [ ] T-02, Implementar geração de relatório Clientes Sintético
  - Origem no legado: `MENU02.FRM` (clien01.rpt)
  - Critério de pronto: Relatório gerado via `clien01.rpt`
  - Confiança: 🟢 CONFIRMADO

- [ ] T-03, Implementar geração de relatório Clientes Analítico
  - Origem no legado: `MENU02.FRM` (clien02.rpt)
  - Critério de pronto: Relatório gerado via `clien02.rpt`
  - Confiança: 🟢 CONFIRMADO

- [ ] T-04, Implementar geração de relatório de Dependentes
  - Origem no legado: `MENU02.FRM` (depend.rpt)
  - Critério de pronto: Relatório gerado via `depend.rpt`
  - Confiança: 🟢 CONFIRMADO

- [ ] T-05, Implementar geração de relatório de Músicas/Intérpretes
  - Origem no legado: `MENU02.FRM` (musicas.rpt)
  - Critério de pronto: Relatório gerado via `musicas.rpt`
  - Confiança: 🟢 CONFIRMADO

- [ ] T-06, Implementar geração de relatório de Apenas Músicas
  - Origem no legado: `MENU02.FRM` (musicas1.rpt)
  - Critério de pronto: Relatório gerado via `musicas1.rpt`
  - Confiança: 🟢 CONFIRMADO

- [ ] T-07, Implementar geração de relatório de CDs Físicos
  - Origem no legado: `MENU02.FRM` (cds.rpt)
  - Critério de pronto: Relatório gerado via `cds.rpt`
  - Confiança: 🟢 CONFIRMADO

- [ ] T-08, Implementar geração de relatório de Títulos
  - Origem no legado: `MENU02.FRM` (titulos.rpt)
  - Critério de pronto: Relatório gerado via `titulos.rpt`
  - Confiança: 🟢 CONFIRMADO

- [ ] T-09, Implementar geração de relatório de Reservas
  - Origem no legado: `MENU02.FRM` (reserva.rpt)
  - Critério de pronto: Relatório gerado via `reserva.rpt`
  - Confiança: 🟢 CONFIRMADO

- [ ] T-10, Implementar configuração de impressora
  - Origem no legado: `MENU02.FRM` (Configurar Impressora)
  - Critério de pronto: Diálogo de impressora exibido, configuração salva
  - Confiança: 🟢 CONFIRMADO

---

## Tarefas de Teste

- [ ] TT-01, Testar geração de relatório Clientes Sintético
  - Critério de pronto: Relatório exibido com dados de clientes
  - Confiança: 🟢 CONFIRMADO

- [ ] TT-02, Testar impressão de relatório
  - Critério de pronto: Relatório enviado para impressora configurada
  - Confiança: 🟢 CONFIRMADO

- [ ] TT-03, Testar configuração de impressora
  - Critério de pronto: Diálogo de impressora exibido, impressora selecionada
  - Confiança: 🟢 CONFIRMADO

---

## Tarefas de Migração de Dados

Não aplicável - esta feature não requer migração de dados.

---

## Ordem Sugerida

1. **Infraestrutura:** T-01 (menu)
2. **Relatórios Principais:** T-02 (clientes sintético), T-07 (CDs)
3. **Demais Relatórios:** T-03 a T-06, T-08, T-09
4. **Configuração:** T-10 (configurar impressora)
5. **Testes:** TT-01 a TT-03

**Bloqueios:**
- T-02 a T-09 dependem das tabelas do banco

---

## Lacunas Pendentes (🔴)

- 🔴 **Estrutura dos relatórios não analisada:** Campos exibidos em cada relatório não foram documentados - requer análise dos arquivos `.rpt`
- 🔴 **Parâmetros de relatório:** Não confirmado se os relatórios aceitam parâmetros (filtro por período, cliente específico, etc.)
- 🔴 **Dependência de Crystal Reports:** Sistema depende de Crystal Reports instalado - pode não funcionar sem a instalação; requer decisão sobre motor de relatórios alternativo
