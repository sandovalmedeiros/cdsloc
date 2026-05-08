# C4 Components — CDsLoc

> Gerado pelo Reversa em 2026-05-08
> Diagrama de componentes do sistema de locação de CDs (Nível 3)

---

## Descrição dos Componentes

Este detalhamento foca nos componentes internos dos containers mais relevantes do sistema, especialmente a Aplicação VB6 e seus módulos principais.

---

## Componentes da Aplicação VB6

```mermaid
C4Component
    title Componentes - Aplicação VB6
    Container_Boundary(app, "Aplicação VB6") {
        Component(mdi_form, "MENU02.FRM", "Formulário MDI Principal", "Orquestra toda a aplicação")
        Component(splash, "frmPainel.frm", "Splash Screen", "Tela de abertura")
        Component(global_mod, "DECLARA.BAS", "Módulo Global", "Funções utilitárias compartilhadas")
        Component(msg_mod, "ARQUIMSG.BAS", "Módulo de Mensagens", "Mensagens externalizadas")
    }

    Component(mdi_form, "MENU02.FRM")
    Component(splash, "frmPainel.frm")
    Component(global_mod, "DECLARA.BAS")
    Component(msg_mod, "ARQUIMSG.BAS")

    Rel(global_mod, mdi_form, "Fornece", "Funções: geracod(), SetaBanco(), LimpaCampos()")
    Rel(msg_mod, mdi_form, "Fornece", "ARQUIMSG() para mensagens")
    Rel(mdi_form, splash, "Gerencia", "Exibe e remove splash")

    Component(login_form, "SENHA.FRM", "Formulário de Login")
    Component(cliente_form, "cliente.frm", "Cadastro de Clientes")
    Component(cds_form, "CDS.FRM", "Catálogo de CDs")
    Component(locdevol_form, "LOCDEVOL.FRM", "Locação/Devolução")
    Component(reserva_form, "reservcd.frm", "Reserva de CDs")
    Component(consulta_form, "frmConsulta.frm", "Consultas Genéricas")
    Component(tabelas_form, "tabelas.frm", "Tabelas Auxiliares")

    Rel(mdi_form, login_form, "Abre", "Modal de autenticação")
    Rel(mdi_form, cliente_form, "Abre", "Formulário de clientes")
    Rel(mdi_form, cds_form, "Abre", "Formulário de CDs")
    Rel(mdi_form, locdevol_form, "Abre", "Formulário de locação")
    Rel(mdi_form, reserva_form, "Abre", "Formulário de reservas")
    Rel(mdi_form, consulta_form, "Abre", "Formulário de consultas")
    Rel(mdi_form, tabelas_form, "Abre", "Formulário de tabelas")
```

---

## Componentes do Módulo Global (DECLARA.BAS)

```mermaid
C4Component
    title Componentes - Módulo Global (DECLARA.BAS)

    Component_Boundary(global_mod, "DECLARA.BAS - Módulo Global") {
        Component(banco_init, "SetaBanco()", "Inicialização do Banco", "Abre BD e recordsets globais")
        Component(cod_gen, "geracod()", "Gerador de Códigos", "Gera próximo ID sequencial")
        Component(error_handler, "trata_errobd()", "Tratamento de Erros", "Captura erros de banco")
        Component(field_cleaner, "LimpaCampos()", "Limpeza de Campos", "Limpa controles do formulário")
        Component(recibo_print, "imprimir_recibo()", "Impressão de Recibo", "🔴 Não implementado")
    }

    Component_Boundary(db_vars, "Variáveis Globais de Banco") {
        Component(wbanco, "wbanco", "Conexão Principal", "Database object")
        Component(wclien, "wclien", "Recordset Cliente", "Tabela Cliente")
        Component(Wcdfisico, "Wcdfisico", "Recordset CD", "Tabela CD")
        Component(Wlocacao, "Wlocacao", "Recordset Locação", "Tabela Locação")
        Component(Wreserva, "Wreserva", "Recordset Reserva", "Tabela Reserva")
        Component(other_rs, "...", "Outros Recordsets", "8+ tabelas adicionais")
    }

    Rel(banco_init, wbanco, "Cria", "Conexão DAO")
    Rel(banco_init, wclien, "Abre", "Recordset Cliente")
    Rel(banco_init, Wcdfisico, "Abre", "Recordset CD")
    Rel(banco_init, Wlocacao, "Abre", "Recordset Locação")
    Rel(banco_init, Wreserva, "Abre", "Recordset Reserva")

    Rel(cod_gen, wclien, "Usa", "Para gerar código de cliente")
    Rel(cod_gen, Wcdfisico, "Usa", "Para gerar código de CD")
    Rel(cod_gen, Wlocacao, "Usa", "Para gerar código de locação")
    Rel(cod_gen, Wreserva, "Usa", "Para gerar código de reserva")
```

---

## Componentes do Módulo de Autenticação (SENHA.FRM)

```mermaid
C4Component
    title Componentes - Módulo de Autenticação (SENHA.FRM)

    Container_Boundary(auth_mod, "Módulo de Autenticação") {
        Component(login_ui, "Formulário", "Interface de Login", "Campo de senha + checkbox")
        Component(crypt_func, "codigo()", "Criptografia XOR", "Codifica/decodifica senha")
        Component(validator, "Validação", "Verificador de Senha", "Compara com banco")
        Component(attempt_counter, "Contador", "Controle de Tentativas", "Máximo 3 tentativas")
        Component(password_changer, "Troca de Senha", "Alteração de Senha", "Confirmação dupla")
    }

    Rel(login_ui, crypt_func, "Chama", "Para codificar senha digitada")
    Rel(crypt_func, validador, "Fornece", "Senha codificada")
    Rel(validator, attempt_counter, "Usa", "Para contar tentativas")
    Rel(login_ui, password_changer, "Chama", "Se checkbox marcado")
    Rel(password_changer, crypt_func, "Usa", "Para codificar nova senha")
```

---

## Componentes do Módulo de Clientes (cliente.frm)

```mermaid
C4Component
    title Componentes - Módulo de Clientes (cliente.frm)

    Container_Boundary(cliente_mod, "Módulo de Clientes") {
        Component(cli_ui, "UI de Clientes", "Formulário Principal", "Dados pessoais + grid dependentes")
        Component(cli_loader, "dados_cliente()", "Carregador", "Carrega dados do cliente")
        Component(cli_qdef, "Dados_Cliente2()", "Carregador QD", "Usa QueryDef parametrizada")
        Component(cli_searcher, "pesquisa_cliente()", "Buscador", "Pesquisa por nome")
        Component(cli_saver, "SSCmdGrava_Cli_Click()", "Gravador", "Salva/Atualiza cliente")
        Component(cli_deleter, "SSCmdExc_Cli_Click()", "Excluidor", "Exclui cliente")
        Component(cli_code_gen, "GeraCodigo()", "Gerador", "Gera código de cliente")

        Component(dep_ui, "UI de Dependentes", "Sub-formulário", "Lista de dependentes")
        Component(dep_loader, "EncheGrid()", "Populador", "Preenche grid")
        Component(dep_saver, "SSCmdGrava_Dep_Click()", "Gravador", "Salva/Atualiza dependente")
        Component(dep_deleter, "SSCmdExc_Dep_Click()", "Excluidor", "Exclui dependente")
    }

    Rel(cli_ui, cli_loader, "Chama", "Ao selecionar cliente")
    Rel(cli_ui, cli_searcher, "Chama", "Ao pesquisar (F10)")
    Rel(cli_ui, cli_saver, "Chama", "Ao clicar Gravar")
    Rel(cli_ui, cli_deleter, "Chama", "Ao clicar Excluir")
    Rel(cli_saver, cli_code_gen, "Usa", "Para gerar código na inclusão")

    Rel(cli_ui, dep_ui, "Contém", "Grid de dependentes")
    Rel(cli_ui, dep_loader, "Chama", "Ao carregar cliente")
    Rel(dep_ui, dep_saver, "Chama", "Ao gravar dependente")
    Rel(dep_ui, dep_deleter, "Chama", "Ao excluir dependente")
```

---

## Componentes do Módulo de CDs (CDS.FRM)

```mermaid
C4Component
    title Componentes - Módulo de CDs (CDS.FRM)

    Container_Boundary(cds_mod, "Módulo de CDs") {
        Component(tabs, "SSTab", "Controle de Abas", "3 abas: Títulos, Músicas, CDs")

        Component_Boundary(tit_tab, "Aba Títulos") {
            Component(tit_ui, "UI de Títulos", "Formulário de Títulos", "Dados do título")
            Component(tit_loader, "dados_titulo()", "Carregador", "Carrega dados do título")
            Component(tit_qdef, "dados_tit2()", "Carregador QD", "Usa QueryDef")
            Component(tit_searcher, "pesq_titulo()", "Buscador", "Pesquisa título")
            Component(tit_saver, "SSCmdGrava_Tit_Click()", "Gravador", "Salva/Atualiza")
            Component(tit_deleter, "SSCmdExc_Tit_Click()", "Excluidor", "Exclui título")
        }

        Component_Boundary(mus_tab, "Aba Músicas") {
            Component(mus_ui, "UI de Músicas", "Formulário de Músicas", "Dados da música")
            Component(mus_loader, "Carregador", "Carrega dados da música")
            Component(mus_saver, "Gravador", "Salva/Atualiza")
            Component(mus_deleter, "Excluidor", "Exclui música")
        }

        Component_Boundary(cd_tab, "Aba CDs Físicos") {
            Component(cd_ui, "UI de CDs", "Formulário de CDs", "Dados do CD físico")
            Component(cd_loader, "dados_cd()", "Carregador", "Carrega dados do CD")
            Component(cd_saver, "SSCmdGrava_Cd_Click()", "Gravador", "Salva/Atualiza")
            Component(cd_deleter, "SSCmdExc_Cd_Click()", "Excluidor", "Exclui CD")
        }
    }

    Rel(tabs, tit_tab, "Contém", "Aba de Títulos")
    Rel(tabs, mus_tab, "Contém", "Aba de Músicas")
    Rel(tabs, cd_tab, "Contém", "Aba de CDs")
```

---

## Componentes do Módulo de Locação (LOCDEVOL.FRM)

```mermaid
C4Component
    title Componentes - Módulo de Locação (LOCDEVOL.FRM)

    Container_Boundary(loc_mod, "Módulo de Locação") {
        Component(tabs, "SSTab", "Controle de Abas", "3 abas: Locação, Devolução, Recibo")

        Component_Boundary(loc_tab, "Aba Locação") {
            Component(loc_ui, "UI de Locação", "Formulário Principal", "Cliente, CD, Tipo")
            Component(loc_cleaner, "limpa_loc()", "Limpeza", "Limpa campos")
            Component(cli_searcher, "pesquisa_cliente()", "Buscador", "Busca cliente")
            Component(res_searcher, "pesquisa_reserva()", "Buscador", "Busca reservas")
            Component(loc_saver, "SSCmdGrava_Loc_Click()", "Gravador", "Grava locação")
            Component(cd_adder, "SSCmdGravaCD_Loc_Click()", "Adicionador", "Adiciona CD à lista")
            Component(date_calc, "Cálculo de Data", "Calculador", "Data prevista 24h/48h")
            Component(val_calc, "Cálculo de Valor", "Calculador", "Valor da locação")
        }

        Component_Boundary(dev_tab, "Aba Devolução") {
            Component(dev_ui, "UI de Devolução", "Formulário de Devolução", "Recibos pendentes")
            Component(dev_cleaner, "limpa_dev()", "Limpeza", "Limpa campos")
            Component(receipt_searcher, "cons_recibo()", "Buscador", "Busca recibos")
            Component(dev_saver, "SSCmdGrava_Dev_Click()", "Gravador", "Registra devolução")
            Component(fine_calc, "Cálculo de Multa", "🔴 Calculador", "Multas por atraso (não encontrado)")
        }

        Component_Boundary(rec_tab, "Aba Recibo") {
            Component(rec_ui, "UI de Recibo", "Formulário de Recibo", "Detalhes do recibo")
            Component(rec_cleaner, "limpa_rec()", "Limpeza", "Limpa campos")
            Component(rec_viewer, "SSCmdVer_Rec_Click()", "Visualizador", "Exibe recibo")
            Component(rec_saver, "grava_recibo()", "Gravador", "Grava recibo")
            Component(rec_printer, "SSCmdImp_Rec_Click()", "Impressor", "Imprime recibo")
        }
    }

    Rel(tabs, loc_tab, "Contém", "Aba de Locação")
    Rel(tabs, dev_tab, "Contém", "Aba de Devolução")
    Rel(tabs, rec_tab, "Contém", "Aba de Recibo")

    Rel(loc_ui, cli_searcher, "Chama", "Para buscar cliente")
    Rel(loc_ui, res_searcher, "Chama", "Para buscar reservas")
    Rel(loc_ui, loc_saver, "Chama", "Para gravar locação")
    Rel(loc_ui, cd_adder, "Chama", "Para adicionar CD")
    Rel(loc_saver, date_calc, "Usa", "Para calcular data prevista")
    Rel(loc_saver, val_calc, "Usa", "Para calcular valor")

    Rel(dev_ui, receipt_searcher, "Chama", "Para buscar recibo")
    Rel(dev_ui, dev_saver, "Chama", "Para registrar devolução")
    Rel(dev_saver, fine_calc, "Usa", "Para calcular multa (🔴)")
```

---

## Componentes do Módulo de Consultas (frmConsulta.frm)

```mermaid
C4Component
    title Componentes - Módulo de Consultas (frmConsulta.frm)

    Container_Boundary(consulta_mod, "Módulo de Consultas") {
        Component(cons_ui, "UI de Consultas", "Formulário Principal", "Tipo, texto, modo, grid")
        Component(type_selector, "cboTpConsulta", "Seletor de Tipo", "6 tipos de consulta")
        Component(mode_selector, "OptionButtons", "Seletor de Modo", "3 modos de pesquisa")
        Component(sql_builder, "executa_consulta()", "Construtor SQL", "Monta SQL dinâmico")
        Component(grid_popper, "preenche_grid()", "Populador", "Preenche MSFlexGrid")
        Component(data_control, "dtaConsulta", "Data Control", "Controle de dados DAO")
    }

    Rel(cons_ui, type_selector, "Contém", "ComboBox de tipos")
    Rel(cons_ui, mode_selector, "Contém", "OptionButtons de modo")
    Rel(cons_ui, sql_builder, "Chama", "Para executar consulta")
    Rel(sql_builder, grid_popper, "Chama", "Para preencher grid")
    Rel(data_control, sql_builder, "Usa", "Para executar query")
```

---

## Matriz de Dependências Entre Componentes

| Componente | Depende De | Tipo de Dependência |
|------------|------------|---------------------|
| SENHA.FRM | DECLARA.BAS | Variáveis globais, SetaBanco() |
| cliente.frm | DECLARA.BAS | geracod(), LimpaCampos(), wclien, Wdependente |
| cliente.frm | ARQUIMSG.BAS | ARQUIMSG() para mensagens |
| CDS.FRM | DECLARA.BAS | geracod(), Wcdfisico, Wtitulo, Wmusica |
| LOCDEVOL.FRM | DECLARA.BAS | geracod(), Wlocacao, Wrecibo, Wcdfisico |
| LOCDEVOL.FRM | CRYSTL32.OCX | Impressão de recibos |
| reservcd.frm | DECLARA.BAS | geracod(), Wreserva, Wtitulo |
| frmConsulta.frm | DECLARA.BAS | Variáveis globais |
| tabelas.frm | DECLARA.BAS | geracod(), Recordsets de tabelas auxiliares |
| MENU02.FRM | Todos os formulários | Abre/gerencia janelas filhas |

---

## Observações

🟢 **Boas Práticas Identificadas:**

1. **Centralização de Funções Utilitárias:** DECLARA.BAS concentra funções reutilizáveis
2. **Mensagens Externalizadas:** ARQUIMSG.BAS separa mensagens do código
3. **Padrão Consistente:** CRUD segue o mesmo padrão em todos os formulários

🔴 **Problemas Identificados:**

1. **Variáveis Globais:** Uso extensivo de recordsets globais (acoplamento alto)
2. **Lógica Misturada:** Regras de negócio nos eventos de formulário
3. **Função Não Implementada:** imprimir_recibo() está vazia
4. **Cálculo de Multa Ausente:** Não encontrado código explícito
5. **Sem Testes:** Não há componentes de teste
