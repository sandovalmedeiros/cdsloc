# Cadastro de CDs, Tarefas de Implementação

> Tarefas executáveis para reimplementar a feature de cadastro de CDs
> Gerado pelo Reversa em 2026-05-08

---

## Pré-requisitos

- [ ] Tabelas `titulo`, `musica`, `cd`, `interprete`, `titulo-musica`, `titulo-interprete`, `musica-interprete` existem no banco
- [ ] Recordsets globais `Wtitulo`, `Wmusica`, `Wcdfisico`, `Winterprete` disponíveis
- [ ] Funções globais `geracod()`, `LimpaCampos()` e `trata_errobd()` implementadas
- [ ] Tabelas auxiliares `grupo` e `estilo` configuradas

---

## Tarefas

### Tarefas de Implementação

#### Títulos

- [ ] T-01, Criar formulário principal de CDs com SSTab (3 abas)
  - Origem no legado: `CDS.FRM:Form_Load`
  - Critério de pronto: Formulário carrega com 3 abas: Títulos, Músicas, CDs Físicos
  - Confiança: 🟢 CONFIRMADO

- [ ] T-02, Implementar validação de campos obrigatórios de título
  - Origem no legado: `CDS.FRM:SSCmdGrava_Tit_Click`
  - Critério de pronto: Valida nome, tipo de locação, quantidade e valor; exibe erro se vazio
  - Confiança: 🟢 CONFIRMADO

- [ ] T-03, Implementar geração automática de código de título
  - Origem no legado: `DECLARA.BAS:geracod()`
  - Critério de pronto: Código sequencial gerado via `geracod()`, formatado como 0000
  - Confiança: 🟢 CONFIRMADO

- [ ] T-04, Implementar gravação de novo título (AddNew)
  - Origem no legado: `CDS.FRM:SSCmdGrava_Tit_Click` (caminho AddNew)
  - Critério de pronto: Registro inserido na tabela titulo com todos os campos populados
  - Confiança: 🟢 CONFIRMADO

- [ ] T-05, Implementar atualização de título existente (Edit)
  - Origem no legado: `CDS.FRM:SSCmdGrava_Tit_Click` (caminho Edit)
  - Critério de pronto: Registro atualizado na tabela titulo sem criar duplicata
  - Confiança: 🟢 CONFIRMADO

- [ ] T-06, Implementar seleção de tipo de locação (24h/48h)
  - Origem no legado: `CDS.FRM:Opt24h`, `Opt48h`
  - Critério de pronto: OptionButtons funcionam, valor "24h" ou "48h" persistido
  - Confiança: 🟢 CONFIRMADO

- [ ] T-07, Implementar vinculação de Grupo e Estilo ao título
  - Origem no legado: `CDS.FRM:CboGrupo`, `CboEstilo`
  - Critério de pronto: ComboBoxes populadas, FKs `cdgrupo` e `cdestilo` persistidas
  - Confiança: 🟢 CONFIRMADO

- [ ] T-08, Implementar pesquisa de título por nome
  - Origem no legado: `CDS.FRM:pesq_titulo()`
  - Critério de pronto: Pesquisa substring case-insensitive, resultados em ListBox
  - Confiança: 🟢 CONFIRMADO

- [ ] T-09, Implementar carregamento de dados do título selecionado
  - Origem no legado: `CDS.FRM:dados_titulo()`
  - Critério de pronto: Título carregado via índice, todos os campos populados, modo edição ativado
  - Confiança: 🟢 CONFIRMADO

- [ ] T-10, Implementar exclusão de título com tratamento de integridade referencial
  - Origem no legado: `CDS.FRM:SSCmdExc_Tit_Click`
  - Critério de pronto: Título excluído se não tem músicas ou CDs; erro 3200 tratado
  - Confiança: 🟢 CONFIRMADO

#### Músicas

- [ ] T-11, Implementar aba Músicas com campos de cadastro
  - Origem no legado: `CDS.FRM` (aba Músicas)
  - Critério de pronto: Seção visível com campos para nome, tempo e título relacionado
  - Confiança: 🟢 CONFIRMADO

- [ ] T-12, Implementar gravação de nova música
  - Origem no legado: `CDS.FRM:SSCmdGrava_Mus_Click`
  - Critério de pronto: Música inserida na tabela musica, código sequencial gerado
  - Confiança: 🟢 CONFIRMADO

- [ ] T-13, Implementar vinculação de música a título (tabela titulo-musica)
  - Origem no legado: `CDS.FRM:SSCmdGrava_Mus_Click` (relacionamento)
  - Critério de pronto: Registro criado em `titulo-musica`, música aparece na lista do título
  - Confiança: 🟢 CONFIRMADO

- [ ] T-14, Implementar listagem de músicas do título selecionado
  - Origem no legado: `CDS.FRM:LstTit_Comp`
  - Critério de pronto: ListBox de músicas populada ao carregar título
  - Confiança: 🟢 CONFIRMADO

- [ ] T-15, Implementar exclusão de música
  - Origem no legado: `CDS.FRM:SSCmdExc_Mus_Click`
  - Critério de pronto: Música excluída da tabela musica e do relacionamento
  - Confiança: 🟢 CONFIRMADO

#### CDs Físicos

- [ ] T-16, Implementar aba CDs Físicos com campos de cadastro
  - Origem no legado: `CDS.FRM` (aba CDs)
  - Critério de pronto: Seção visível com campos para código, número, situação e dados de compra
  - Confiança: 🟢 CONFIRMADO

- [ ] T-17, Implementar gravação de novo CD físico
  - Origem no legado: `CDS.FRM:SSCmdGrava_CD_Click`
  - Critério de pronto: CD inserido na tabela cd, vinculado ao título, situação definida
  - Confiança: 🟢 CONFIRMADO

- [ ] T-18, Implementar controle de situação do CD (Disponível/Locado)
  - Origem no legado: `CDS.FRM:OptDisp_CD`, `OptLoc_CD`
  - Critério de pronto: OptionButtons funcionam, flag `situacao` persistida
  - Confiança: 🟢 CONFIRMADO

- [ ] T-19, Implementar bloqueio de exclusão de CD locado
  - Origem no legado: `CDS.FRM:SSCmdExc_CD_Click`
  - Critério de pronto: Exclusão bloqueada se `situacao = "Locado"`, mensagem exibida
  - Confiança: 🟢 CONFIRMADO

#### Intérpretes

- [ ] T-20, Implementar vinculação de intérprete a música (tabela musica-interprete)
  - Origem no legado: `CDS.FRM` (relacionamento música ↔ intérprete)
  - Critério de pronto: Registro criado em `musica-interprete`, intérprete aparece na lista da música
  - Confiança: 🟢 CONFIRMADO

- [ ] T-21, Implementar vinculação de intérprete a título (tabela titulo-interprete)
  - Origem no legado: `CDS.FRM` (relacionamento título ↔ intérprete)
  - Critério de pronto: Registro criado em `titulo-interprete`, intérprete aparece na lista do título
  - Confiança: 🟢 CONFIRMADO

- [ ] T-22, Implementar listagem de intérpretes do título/música selecionada
  - Origem no legado: `CDS.FRM:LstTit_Interp`, `LstMus_Interp`
  - Critério de pronto: ListBoxes de intérpretes populadas ao carregar título/música
  - Confiança: 🟢 CONFIRMADO

#### Tabelas Auxiliares

- [ ] T-23, Implementar CRUD de Intérpretes
  - Origem no legado: `tabelas.frm` (interprete)
  - Critério de pronto: Incluir, alterar, excluir e listar intérpretes
  - Confiança: 🟢 CONFIRMADO

- [ ] T-24, Implementar CRUD de Grupos
  - Origem no legado: `tabelas.frm` (grupo)
  - Critério de pronto: Incluir, alterar, excluir e listar grupos
  - Confiança: 🟢 CONFIRMADO

- [ ] T-25, Implementar CRUD de Estilos
  - Origem no legado: `tabelas.frm` (estilo)
  - Critério de pronto: Incluir, alterar, excluir e listar estilos
  - Confiança: 🟢 CONFIRMADO

---

## Tarefas de Teste

- [ ] TT-01, Testar cadastro de novo título com todos os campos
  - Critério de pronto: Título cadastrado com código sequencial, dados persistidos
  - Confiança: 🟢 CONFIRMADO

- [ ] TT-02, Testar seleção de tipo de locação (24h/48h)
  - Critério de pronto: Tipo de locação persistido corretamente
  - Confiança: 🟢 CONFIRMADO

- [ ] TT-03, Testar edição de título existente
  - Critério de pronto: Alterações persistidas sem criar novo registro
  - Confiança: 🟢 CONFIRMADO

- [ ] TT-04, Testar cadastro de música vinculada a título
  - Critério de pronto: Música cadastrada, aparece na lista de músicas do título
  - Confiança: 🟢 CONFIRMADO

- [ ] TT-05, Testar cadastro de CD físico vinculado a título
  - Critério de pronto: CD cadastrado, vinculado ao título, situação definida
  - Confiança: 🟢 CONFIRMADO

- [ ] TT-06, Testar bloqueio de exclusão de CD locado
  - Critério de pronto: Exclusão bloqueada, mensagem exibida
  - Confiança: 🟢 CONFIRMADO

- [ ] TT-07, Testar vinculação de intérprete a música
  - Critério de pronto: Intérprete relacionado, aparece na lista
  - Confiança: 🟢 CONFIRMADO

- [ ] TT-08, Testar pesquisa de título por nome (substring case-insensitive)
  - Critério de pronto: Pesquisa funciona independente de maiúsculas/minúsculas e como substring
  - Confiança: 🟢 CONFIRMADO

---

## Tarefas de Migração de Dados

- [ ] TM-01, Migrar tabela `titulo` com todos os campos
  - Origem no legado: Tabela `titulo` em BD_CDLOC.mdb
  - Critério de pronto: Todos os títulos migrados, estrutura preservada
  - Confiança: 🟢 CONFIRMADO

- [ ] TM-02, Migrar tabela `musica`
  - Origem no legado: Tabela `musica` em BD_CDLOC.mdb
  - Critério de pronto: Todas as músicas migradas
  - Confiança: 🟢 CONFIRMADO

- [ ] TM-03, Migrar tabela `cd` (CDs físicos)
  - Origem no legado: Tabela `cd` em BD_CDLOC.mdb
  - Critério de pronto: Todos os CDs físicos migrados, vínculos com título mantidos
  - Confiança: 🟢 CONFIRMADO

- [ ] TM-04, Migrar tabela `interprete`
  - Origem no legado: Tabela `interprete` em BD_CDLOC.mdb
  - Critério de pronto: Todos os intérpretes migrados
  - Confiança: 🟢 CONFIRMADO

- [ ] TM-05, Migrar tabelas de relacionamento
  - Origem no legado: `titulo-musica`, `titulo-interprete`, `musica-interprete`
  - Critério de pronto: Todos os relacionamentos migrados, integridade preservada
  - Confiança: 🟢 CONFIRMADO

- [ ] TM-06, Migrar tabelas auxiliares `grupo` e `estilo`
  - Origem no legado: Tabelas `grupo` e `estilo` em BD_CDLOC.mdb
  - Critério de pronto: Todos os registros migrados
  - Confiança: 🟢 CONFIRMADO

---

## Ordem Sugerida

1. **Infraestrutura:** T-01 (formulário), T-03 (geracod), T-23, T-24, T-25 (tabelas auxiliares)
2. **Migração de dados:** TM-01, TM-02, TM-03, TM-04, TM-05, TM-06
3. **CRUD Títulos:** T-02 (validação), T-04 (incluir), T-05 (editar), T-06 (tipo), T-07 (grupo/estilo), T-08 (pesquisar), T-09 (carregar), T-10 (excluir)
4. **CRUD Músicas:** T-11 (seção), T-12 (cadastrar), T-13 (vincular), T-14 (listar), T-15 (excluir)
5. **CRUD CDs Físicos:** T-16 (seção), T-17 (cadastrar), T-18 (situação), T-19 (bloqueio)
6. **Intérpretes:** T-20 (música-interprete), T-21 (título-interprete), T-22 (listar)
7. **Testes:** TT-01 a TT-08

**Bloqueios:**
- T-04 a T-10 dependem de TM-01 (tabela titulo migrada)
- T-12 a T-15 dependem de TM-02 (tabela musica migrada) e TM-05 (titulo-musica)
- T-17 a T-19 dependem de TM-03 (tabela cd migrada)
- T-20 a T-22 dependem de TM-04 (interprete migrada) e TM-05 (relacionamentos)
- T-07 depende de TM-06 (grupo e estilo)

---

## Lacunas Pendentes (🔴)

- 🔴 **Validação de estoque:** Não há validação no legado para impedir que quantidade de CDs físicos exceda `qtde` do título - requer decisão de implementação
- 🔴 **Situação "Reservado":** Situação inferida mas não encontrada explicitamente - definir comportamento
- 🔴 **Lógica de atualização de estoque:** Não confirmada no código se há decremento/incremento automático ao cadastrar/excluir CD físico - requer implementação ou decisão
- 🔴 **Exclusão de título com CDs físicos:** Comportamento não confirmado - deve falhar com erro 3200 mas precisa validação
