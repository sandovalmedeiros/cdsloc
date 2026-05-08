Attribute VB_Name = "DECLARA"
Option Explicit
Option Compare Text
Const TECLA_ALT = 4
Public wbanco As Database
Public wclien As Recordset
Public Wcdfisico As Recordset
Public Wdependente As Recordset
Public Westilo As Recordset
Public wMunic As Recordset
Public wBairro As Recordset
Public Wgrupo As Recordset
Public Winterprete As Recordset
Public wtinterprete As Recordset
Public Wlocacao As Recordset
Public wmusica As Recordset
Public Wminterprete As Recordset
Public Wrecibo As Recordset
Public Wreserva As Recordset
Public Wtitulo As Recordset
Public Wtmusica As Recordset
Public tabsenha As Recordset
Public wvalor_loc As Recordset
Public DSCliente As Recordset
Public DSDependente As Recordset
Public QDConsulta As QueryDef
Public DSConsulta As Recordset

'Declara as QueryDefs
Public QDCliente As QueryDef
Public QDDep As QueryDef


Public vformu As Form

Global Atualiza As String
Global tipo_relat As String
Global gravou As String
Global msgI As String
Global cod_titulo As String
Global cod_cliente As String
Global VTb As Recordset       'Variaveis da função geracod, que representam
Global VIx, VCt As String 'o nome da tabela, o indice e o campo da tabela
Global wtb As Recordset
Global cons As String
Global Retorna As String
Global interprete As String
Global werro_bd As Integer
Global VTitul, VConre As String
Global Vdt1, Vdt2 As Variant

Static Function geracod() As Long
        ' Função geracod recebe os parametros do form com as
        ' seguintes variaveis Vtb (nome da tabela), VIx (nome do indice)
        ' e VCt (campo da tabela)
       ' VTb.Requery
        gravou = "Não"
        If VTb.RecordCount <> 0 Then
            VTb.Index = VIx
            VTb.MoveLast
            geracod = VTb(VCt).Value + 1
        Else
            geracod = 1
        End If
       
End Function

Sub imprimir_recibo()
End Sub

Sub limpacampos1()

        Clientes!codcliente.Text = ""
        Clientes!nomecliente.Text = ""
      ' Clientes!cbonome.ListIndex = -1 Limpa o Combo
        Clientes!endereco.Text = ""
        Clientes!datanascimento.Mask = ""
        Clientes!datanascimento.Text = ""
        Clientes!datanascimento.Mask = "##/##/####"
        Clientes!bairro.Text = ""
        Clientes!cep.Mask = ""
        Clientes!cep.Text = ""
        Clientes!cep.Mask = "#####-###"
        Clientes!fone01.Mask = ""
        Clientes!fone01.Text = ""
        Clientes!fone01.Mask = "###-####"
        Clientes!identidade.Text = ""
        Clientes!expedidor.Text = ""
        Clientes!dataexpedicao.Mask = ""
        Clientes!dataexpedicao.Text = ""
        Clientes!dataexpedicao.Mask = "##/##/####"
        Clientes!cic.Mask = ""
        Clientes!cic.Text = ""
        Clientes!cic.Mask = "###,###,###-##"
        Clientes!situacao(0) = True
        Clientes!obs.Text = ""
        Clientes!empresa.Text = ""
        Clientes!fone02.Mask = ""
        Clientes!fone02.Text = ""
        Clientes!fone02.Mask = "###-####"
        Clientes!endcomercial.Text = ""
        Clientes!referenciapessoal.Text = ""
        Clientes!fone03.Mask = ""
        Clientes!fone03.Text = ""
        Clientes!fone03.Mask = "###-####"
        Clientes!nomedependente.Text = ""
        Clientes!datainscricao.Mask = ""
        Clientes!datainscricao.Text = ""
        Clientes!datainscricao.Mask = "##/##/####"

End Sub

Sub limpacampos2()
        Clientes!nomecliente.Text = ""
      ' Clientes!cbonome.ListIndex = -1 Limpa o Combo
        Clientes!endereco.Text = ""
        Clientes!datanascimento.Mask = ""
        Clientes!datanascimento.Text = ""
        Clientes!datanascimento.Mask = "##/##/####"
        Clientes!bairro.Text = ""
        Clientes!cep.Mask = ""
        Clientes!cep.Text = ""
        Clientes!cep.Mask = "#####-###"
        Clientes!fone01.Mask = ""
        Clientes!fone01.Text = ""
        Clientes!fone01.Mask = "###-####"
        Clientes!identidade.Text = ""
        Clientes!expedidor.Text = ""
        Clientes!dataexpedicao.Mask = ""
        Clientes!dataexpedicao.Text = ""
        Clientes!dataexpedicao.Mask = "##/##/####"
        Clientes!cic.Mask = ""
        Clientes!cic.Text = ""
        Clientes!cic.Mask = "###,###,###-##"
        Clientes!situacao(0) = True
        Clientes!obs.Text = ""
        Clientes!empresa.Text = ""
        Clientes!fone02.Mask = ""
        Clientes!fone02.Text = ""
        Clientes!fone02.Mask = "###-####"
        Clientes!endcomercial.Text = ""
        Clientes!referenciapessoal.Text = ""
        Clientes!fone03.Mask = ""
        Clientes!fone03.Text = ""
        Clientes!fone03.Mask = "###-####"
        Clientes!nomedependente.Text = ""
        Clientes!datainscricao.Mask = ""
        Clientes!datainscricao.Text = ""
        Clientes!datainscricao.Mask = "##/##/####"
    
End Sub

Public Sub SetaBanco()

    ChDrive Left(App.Path, 2) 'muda para drive de carga
    ChDir App.Path 'muda para diretório de carga
    Set wbanco = Workspaces(0).OpenDatabase(App.Path & "\bd_cdloc.mdb")
    Set Winterprete = wbanco.OpenRecordset("interprete")
    Set Wgrupo = wbanco.OpenRecordset("grupo")
    Set Westilo = wbanco.OpenRecordset("estilo")
    Set wMunic = wbanco.OpenRecordset("Municipio")
    Set wBairro = wbanco.OpenRecordset("Bairro")
    Set wclien = wbanco.OpenRecordset("Cliente")
    Set Wdependente = wbanco.OpenRecordset("dependente")
    Set Wcdfisico = wbanco.OpenRecordset("cd")
    Set wtinterprete = wbanco.OpenRecordset("titulo-interprete")
    Set wmusica = wbanco.OpenRecordset("musica")
    Set Wminterprete = wbanco.OpenRecordset("musica-interprete")
    Set Wtitulo = wbanco.OpenRecordset("titulo")
    Set Wtmusica = wbanco.OpenRecordset("titulo-musica")
    Set Wlocacao = wbanco.OpenRecordset("locacao")
    Set Wtitulo = wbanco.OpenRecordset("titulo")
    Set Wrecibo = wbanco.OpenRecordset("recibo")
    Set wvalor_loc = wbanco.OpenRecordset("valor_loc")
    Set Wreserva = wbanco.OpenRecordset("reserva")
    Set tabsenha = wbanco.OpenTable("senha")


End Sub

Sub trata_errobd()
    MsgBox "Erro cod:" & Err & ". Msg: " & Error(Err)
    If (Err > 599 And Err < 647) Or (Err > 2419 And Err < 2478) Or (Err > 3001 And Err < 3300) Then
       MsgBox "Erro de Banco de Dados"
    End If
    werro_bd = True 'Qualquer erro implica em cancelamento da transação
End Sub

Sub LimpaCampos()
    Dim MeuControle As Variant, Vtxt As String
    For Each MeuControle In vformu.Controls
        If TypeOf MeuControle Is TextBox Then
           If MeuControle.Tag <> "N" Then MeuControle.Text = Empty
        ElseIf TypeOf MeuControle Is MaskEdBox Then
            If MeuControle.Tag <> "N" Then
               Vtxt = MeuControle.Mask
               MeuControle.Mask = Empty
               MeuControle.Text = Empty
               MeuControle.Mask = Vtxt
            End If
        ElseIf TypeOf MeuControle Is DBCombo Then
            If MeuControle.Tag <> "N" Then
               MeuControle.Text = Empty
            End If
        ElseIf TypeOf MeuControle Is MSFlexGrid Then
            If MeuControle.Tag <> "N" Then
               MeuControle.Text = Empty
               Vtxt = MeuControle.FormatString
               MeuControle.Clear
               MeuControle.Rows = 2
               MeuControle.FormatString = Vtxt
            End If
        ElseIf TypeOf MeuControle Is ComboBox Then
            If MeuControle.Tag <> "N" Then
               MeuControle.Text = Empty
            End If
        ElseIf TypeOf MeuControle Is ListBox Then
            If MeuControle.Tag <> "N" Then
               MeuControle.Clear
            End If
        ElseIf TypeOf MeuControle Is Label Then
            MeuControle.ForeColor = &H80000012
        End If
    Next
End Sub

