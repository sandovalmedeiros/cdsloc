# Consultas, Tarefas de Implementação

> Tarefas executáveis para reimplementar a feature de consultas
> Gerado pelo Reversa em 2026-05-08

---

## Pré-requisitos

- [ ] Tabelas `titulo`, `musica`, `cd`, `Cliente`, `locacao`, `reserva` existem no banco
- [ ] Índices adequados configurados para performance

---

## Tarefas

### Tarefas de Implementação

- [ ] T-01, Criar formulário principal de consultas
  - Origem no legado: `frmConsulta.frm:Form_Load`
  - Critério de pronto: Formulário carrega com ComboBox de tipos, campo de pesquisa, ComboBox de modos e grid
  - Confiança: 🟢 CONFIRMADO

- [ ] T-02, Implementar carregamento de tipos de consulta
  - Origem no legado: `frmConsulta.frm:Form_Load`
  - Critério de pronto: ComboBox populada com Títulos, Músicas, CDs, Clientes, Locações, Reservas
  - Confiança: 🟢 CONFIRMADO

- [ ] T-03, Implementar carregamento de modos de pesquisa
  - Origem no legado: `frmConsulta.frm:Form_Load`
  - Critério de pronto: ComboBox populada com Todas as Ocorrências, Palavras Exatas, Palavra Inicial
  - Confiança: 🟢 CONFIRMADO

- [ ] T-04, Implementar construção de SQL dinâmico
  - Origem no legado: `frmConsulta.frm:executa_consulta()`
  - Critério de pronto: SQL construído baseado em tipo, texto e modo de pesquisa
  - Confiança: 🟢 CONFIRMADO

- [ ] T-05, Implementar execução de consulta
  - Origem no legado: `frmConsulta.frm:executa_consulta()`
  - Critério de pronto: SQL executado via recordset, resultados obtidos
  - Confiança: 🟢 CONFIRMADO

- [ ] T-06, Implementar população do grid
  - Origem no legado: `frmConsulta.frm:preenche_grid()`
  - Critério de pronto: Grid configurado com colunas adequadas, linhas populadas com resultados
  - Confiança: 🟢 CONFIRMADO

- [ ] T-07, Implementar contagem de resultados
  - Origem no legado: `frmConsulta.frm:preenche_grid()`
  - Critério de pronto: Número de registros exibido no campo `TxtEncontrou`
  - Confiança: 🟢 CONFIRMADO

- [ ] T-08, Implementar limpeza de campos e grid
  - Origem no legado: `frmConsulta.frm:BtnLimpar`
  - Critério de pronto: Grid limpo, contador zerado, campo de pesquisa vazio
  - Confiança: 🟢 CONFIRMADO

---

## Tarefas de Teste

- [ ] TT-01, Testar consulta de Títulos - Todas as Ocorrências
  - Critério de pronto: Todos os títulos contendo o texto são exibidos
  - Confiança: 🟢 CONFIRMADO

- [ ] TT-02, Testar consulta de Músicas - Palavras Exatas
  - Critério de pronto: Apenas músicas com nome exato são exibidas
  - Confiança: 🟢 CONFIRMADO

- [ ] TT-03, Testar consulta de CDs - Palavra Inicial
  - Critério de pronto: CDs começando com o texto são exibidos
  - Confiança: 🟢 CONFIRMADO

- [ ] TT-04, Testar consulta sem resultados
  - Critério de pronto: Grid vazio, contador = 0, mensagem exibida
  - Confiança: 🟢 CONFIRMADO

- [ ] TT-05, Testar pesquisa case-insensitive
  - Critério de pronto: Resultados encontrados independente de maiúsculas/minúsculas
  - Confiança: 🟢 CONFIRMADO

---

## Tarefas de Migração de Dados

Não aplicável - esta feature não requer migração de dados.

---

## Ordem Sugerida

1. **Infraestrutura:** T-01 (formulário)
2. **Carregamento:** T-02 (tipos), T-03 (modos)
3. **Execução:** T-04 (SQL), T-05 (executar), T-06 (grid), T-07 (contador)
4. **Limpeza:** T-08 (limpar)
5. **Testes:** TT-01 a TT-05

**Bloqueios:**
- T-04 a T-07 dependem das tabelas do banco

---

## Lacunas Pendentes (🔴)

Nenhuma lacuna identificada para esta feature.
