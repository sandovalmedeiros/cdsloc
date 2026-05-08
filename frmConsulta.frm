VERSION 5.00
Object = "{0BA686C6-F7D3-101A-993E-0000C0EF6F5E}#1.0#0"; "THREED32.OCX"
Object = "{5E9E78A0-531B-11CF-91F6-C2863C385E30}#1.0#0"; "MSFLXGRD.OCX"
Begin VB.Form frmConsulta 
   BackColor       =   &H8000000A&
   Caption         =   "Consultas"
   ClientHeight    =   6315
   ClientLeft      =   60
   ClientTop       =   345
   ClientWidth     =   10935
   ControlBox      =   0   'False
   Icon            =   "frmConsulta.frx":0000
   LinkTopic       =   "Form1"
   MDIChild        =   -1  'True
   ScaleHeight     =   6315
   ScaleWidth      =   10935
   Begin VB.TextBox txtEncontrou 
      BeginProperty Font 
         Name            =   "Arial Black"
         Size            =   12
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H000000FF&
      Height          =   375
      Left            =   7545
      TabIndex        =   14
      Top             =   1365
      Width           =   1005
   End
   Begin Threed.SSFrame SSFrame1 
      Height          =   1125
      Left            =   0
      TabIndex        =   10
      Top             =   630
      Width           =   3645
      _Version        =   65536
      _ExtentX        =   6429
      _ExtentY        =   1984
      _StockProps     =   14
      Caption         =   "Tipo de Pesquisa no Banco"
      ForeColor       =   16711680
      BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Begin VB.CheckBox chkMusicas 
         Caption         =   "Com Músicas"
         Height          =   210
         Left            =   1845
         TabIndex        =   16
         Top             =   525
         Visible         =   0   'False
         Width           =   1620
      End
      Begin VB.OptionButton optInicComp 
         Caption         =   "Palavra Inicial + Complemento"
         Height          =   255
         Left            =   90
         TabIndex        =   13
         Top             =   780
         Width           =   2490
      End
      Begin VB.OptionButton optExato 
         Caption         =   "Palavras Exatas"
         Height          =   375
         Left            =   90
         TabIndex        =   12
         Top             =   450
         Width           =   1560
      End
      Begin VB.OptionButton optTodos 
         Caption         =   "Todas as Ocorrências"
         Height          =   255
         Left            =   90
         TabIndex        =   11
         Top             =   240
         Value           =   -1  'True
         Width           =   1935
      End
   End
   Begin VB.ComboBox cboTpConsulta 
      Height          =   315
      ItemData        =   "frmConsulta.frx":0442
      Left            =   -15
      List            =   "frmConsulta.frx":0458
      TabIndex        =   3
      Top             =   270
      Width           =   2160
   End
   Begin VB.TextBox txtStrConsulta 
      Height          =   375
      Left            =   3705
      Locked          =   -1  'True
      TabIndex        =   1
      Top             =   1380
      Width           =   3750
   End
   Begin VB.Data dtaConsulta 
      Caption         =   "dtaConsulta"
      Connect         =   "Access"
      DatabaseName    =   ""
      DefaultCursorType=   0  'DefaultCursor
      DefaultType     =   2  'UseODBC
      Exclusive       =   0   'False
      Height          =   375
      Left            =   7575
      Options         =   0
      ReadOnly        =   0   'False
      RecordsetType   =   1  'Dynaset
      RecordSource    =   ""
      Top             =   105
      Visible         =   0   'False
      Width           =   3615
   End
   Begin MSFlexGridLib.MSFlexGrid msfConsulta 
      Bindings        =   "frmConsulta.frx":0492
      Height          =   4260
      Left            =   15
      TabIndex        =   0
      Top             =   2025
      Width           =   10635
      _ExtentX        =   18759
      _ExtentY        =   7514
      _Version        =   393216
      FixedCols       =   0
      ForeColorFixed  =   16711680
      AllowUserResizing=   1
   End
   Begin Threed.SSPanel SSPanel24 
      Height          =   495
      Left            =   9870
      TabIndex        =   6
      Top             =   1365
      Width           =   735
      _Version        =   65536
      _ExtentX        =   1296
      _ExtentY        =   873
      _StockProps     =   15
      Caption         =   "SSPanel19"
      BackColor       =   12632256
      BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      BevelOuter      =   1
      Autosize        =   3
      Begin Threed.SSCommand SSCmdSai_Tit 
         Height          =   465
         Left            =   15
         TabIndex        =   7
         Tag             =   "DBTTip:Sair da Rotina "
         Top             =   15
         Width           =   705
         _Version        =   65536
         _ExtentX        =   1244
         _ExtentY        =   820
         _StockProps     =   78
         Picture         =   "frmConsulta.frx":04AC
      End
   End
   Begin Threed.SSPanel SSPanel10 
      Height          =   495
      Left            =   8865
      TabIndex        =   8
      Top             =   1365
      Width           =   735
      _Version        =   65536
      _ExtentX        =   1296
      _ExtentY        =   873
      _StockProps     =   15
      Caption         =   "SSPanel19"
      BackColor       =   12632256
      BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      BevelOuter      =   1
      Autosize        =   3
      Begin Threed.SSCommand SSCmdLimp_Loc 
         Height          =   465
         Left            =   15
         TabIndex        =   9
         Tag             =   "DBTTip:Nova Locação"
         Top             =   15
         Width           =   705
         _Version        =   65536
         _ExtentX        =   1244
         _ExtentY        =   820
         _StockProps     =   78
         Picture         =   "frmConsulta.frx":094E
      End
   End
   Begin VB.Label Label4 
      AutoSize        =   -1  'True
      Caption         =   "Encontrou:"
      ForeColor       =   &H00FF0000&
      Height          =   195
      Left            =   7530
      TabIndex        =   15
      Top             =   1170
      Width           =   780
   End
   Begin VB.Label Label3 
      AutoSize        =   -1  'True
      Caption         =   "Resultado da  Consulta"
      ForeColor       =   &H00FF0000&
      Height          =   195
      Left            =   0
      TabIndex        =   5
      Top             =   1785
      Width           =   1650
   End
   Begin VB.Label Label2 
      AutoSize        =   -1  'True
      Caption         =   "Digite a Opção de Consulta"
      ForeColor       =   &H00FF0000&
      Height          =   195
      Left            =   3720
      TabIndex        =   4
      Top             =   1185
      Width           =   1950
   End
   Begin VB.Label Label1 
      AutoSize        =   -1  'True
      Caption         =   "Selecione o Tipo de Consulta"
      ForeColor       =   &H00FF0000&
      Height          =   195
      Left            =   0
      TabIndex        =   2
      Top             =   60
      Width           =   2085
   End
End
Attribute VB_Name = "frmConsulta"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Dim StrSQL As String
Dim X As Integer


Private Sub cboTpConsulta_Click()
  'If KeyAscii = 13 Then
      FormataConsulta
      If cboTpConsulta.Text = "CD Físico" Then
         chkMusicas.Visible = True
      Else
         optTodos.Enabled = True
         optInicComp.Enabled = True
         optTodos.Value = True
         chkMusicas.Value = 0
         chkMusicas.Visible = False
      End If
      txtStrConsulta.Locked = False
      txtStrConsulta.SetFocus
   'End If
End Sub

Private Sub chkMusicas_Click()
    optExato.Value = True
   'optTodos.Enabled = False
   'optInicComp.Enabled = False
   'txtStrConsulta.SetFocus
End Sub

Private Sub Form_Load()
    With frmConsulta
       .Left = 465
       .Height = 6705
       .Width = 11010
       .Top = 345
    End With
End Sub

Private Sub optInicComp_Click()
   chkMusicas.Value = 0
End Sub

Private Sub optTodos_Click()
   chkMusicas.Value = 0
End Sub

Private Sub SSCmdLimp_Loc_Click()
  LimpaCampos
End Sub

Private Sub SSCmdSai_Tit_Click()
    frmConsulta.Hide
End Sub

Private Sub txtstrconsulta_GotFocus()
   txtStrConsulta.SelStart = 0
   txtStrConsulta.SelLength = Len(txtStrConsulta.Text)
End Sub

Private Sub FormataConsulta()
   With msfConsulta
      '.CellAlignment = flexAlignCenterCenter
      .Clear
      .Cols = 2
      .Rows = 2
      .Row = 0
      .Col = 0
      Select Case cboTpConsulta
      
        Case Is = "Música"
          ' Set column headers.
          s$ = "<Música                                          |<Título                                 |<Intérprete                                |<Estilo                |<Grupo            |<Num.CD|<Locado"
          .FormatString = s$
          .CellAlignment = flexAlignCenterCenter
          .Col = 1
          .CellAlignment = flexAlignCenterCenter
          .Col = 2
          .CellAlignment = flexAlignCenterCenter
          .Col = 3
          .CellAlignment = flexAlignCenterCenter
          .Col = 4
          .CellAlignment = flexAlignCenterCenter
        Case Is = "Intérprete"
          ' Set column headers.
          s$ = "<Intérprete                                                 |<Título                                                     |<Estilo                                   |<Grupo            |<Num.CD|<Locado"
          .FormatString = s$
          .CellAlignment = flexAlignCenterCenter
          .Col = 1
          .CellAlignment = flexAlignCenterCenter
          .Col = 2
          .CellAlignment = flexAlignCenterCenter
          .Col = 3
          .CellAlignment = flexAlignCenterCenter
          .Col = 4
          .CellAlignment = flexAlignCenterCenter
        Case Is = "Título", "Estilo", "Grupo"
          ' Set column headers.
          s$ = "<Título                                         |<Intérprete                                       |<Estilo                      |<Grupo              |<Num.CD|<Locado"
          .FormatString = s$
          .CellAlignment = flexAlignCenterCenter
          .Col = 1
          .CellAlignment = flexAlignCenterCenter
          .Col = 2
          .CellAlignment = flexAlignCenterCenter
          .Col = 3
          .CellAlignment = flexAlignCenterCenter
          .Col = 4
          .CellAlignment = flexAlignCenterCenter
        
        Case Is = "CD Físico"
          ' Set column headers.
          s$ = "<Cód. CD|<Locado|<Cod.Tit.|<Título                                                   |<Intérprete                                          |<Estilo                          |<Grupo            "
          .FormatString = s$
          .CellAlignment = flexAlignCenterCenter
          .Col = 1
          .CellAlignment = flexAlignCenterCenter
          .Col = 2
          .CellAlignment = flexAlignCenterCenter
          .Col = 3
          .CellAlignment = flexAlignCenterCenter
          .Col = 4
          .CellAlignment = flexAlignCenterCenter
      End Select
      
     
   End With
End Sub

Private Sub txtStrConsulta_KeyPress(KeyAscii As Integer)
  If KeyAscii = 13 Then
    txtStrConsulta.BackColor = &HC0FFFF
    FormataConsulta
    Select Case cboTpConsulta
      Case Is = "Música"
          'If optclCodigo.Value = True Then
              ConsultaSQL "musica.titulo_musica", ""
          'ElseIf optClDesc.Value = True Then
          '   ChamadaSql "esctponto.dePonto"
          'End If
      Case Is = "Intérprete"
          ConsultaSQL "interprete.interprete", ""
      Case Is = "Título", "Estilo", "Grupo"
           If cboTpConsulta.Text = "Título" Then
              ConsultaSQL "titulo.titulo", "titulo.titulo"
           ElseIf cboTpConsulta.Text = "Estilo" Then
              ConsultaSQL "estilo.nome_estilo", "estilo.nome_estilo"
           ElseIf cboTpConsulta.Text = "Grupo" Then
              ConsultaSQL "grupo.nome_grupo", "grupo.nome_grupo"
           End If
      Case Is = "CD Físico"
           ConsultaSQL "titulo.titulo", "cd.cod_cd"
    End Select
  End If
End Sub

Private Sub txtStrConsulta_LostFocus()
    txtStrConsulta.BackColor = &H80000005
End Sub
Private Sub ConsultaSQL(Var As String, Var2 As String)
   If txtStrConsulta.Text <> "" Then
      txtStrConsulta.BackColor = &HC0FFFF
      'busca dinamica
      Dim Criterio As String
      If optTodos.Value = True Then
         Criterio = "*" & txtStrConsulta.Text & "*"
      ElseIf optInicComp.Value = True Then
          Criterio = txtStrConsulta.Text & " *"
      Else
          Criterio = txtStrConsulta.Text
      End If
      Select Case cboTpConsulta
      
        Case Is = "Música"
             StrSQL = "SELECT musica.cod_musica, musica.titulo_musica, [musica-interprete].cod_interprete, " _
             & "interprete.interprete, [titulo-interprete].cod_titulo, " _
             & "titulo.titulo, cd.cod_cd, cd.locado, grupo.nome_grupo, " _
             & "estilo.nome_estilo " _
             & "FROM grupo INNER JOIN (estilo INNER JOIN " _
             & "((titulo INNER JOIN cd ON titulo.cod_titulo = cd.cod_titulo) " _
             & "INNER JOIN ((interprete INNER JOIN ((musica INNER JOIN [titulo-musica] " _
             & "ON musica.cod_musica = [titulo-musica].cod_musica) INNER JOIN [musica-interprete] " _
             & "ON musica.cod_musica = [musica-interprete].cod_musica) " _
             & "ON interprete.cod_interprete = [musica-interprete].cod_interprete) " _
             & "INNER JOIN [titulo-interprete] ON interprete.cod_interprete = [titulo-interprete].cod_interprete) " _
             & "ON (titulo.cod_titulo = [titulo-musica].cod_titulo) AND  " _
             & "(titulo.cod_titulo = [titulo-interprete].cod_titulo)) ON (estilo.cod_estilo = titulo.cod_estilo) " _
             & "AND (estilo.cod_grupo = titulo.cod_grupo)) ON (titulo.cod_grupo = grupo.cod_grupo)  " _
             & "AND (grupo.cod_grupo = estilo.cod_grupo) " _
             & "WHERE (((musica.titulo_musica) Like '" & Criterio & "'))" _
             & "ORDER BY " & Var & ";"
          
             Set QDConsulta = wbanco.CreateQueryDef("", StrSQL)
             Set DSConsulta = QDConsulta.OpenRecordset
           
             If DSConsulta.RecordCount = 0 Then
                MsgBox "Não existe(m) Registro(s) para esta Consulta", vbInformation, "CD'S Loc - Locadora de CD"
             Else
                 X = 1
                 Do While Not DSConsulta.EOF
                    With msfConsulta
                       If X > 1 Then .Rows = .Rows + 1
                         .Row = X
                         .Col = 0
                         .Text = DSConsulta!titulo_musica
                         .Col = 1
                         .Text = DSConsulta!titulo
                         .Col = 2
                         .Text = DSConsulta!interprete
                         .Col = 3
                         .Text = DSConsulta!nome_estilo
                         .Col = 4
                         .Text = DSConsulta!nome_grupo
                         .Col = 5
                         .Text = DSConsulta!cod_cd
                         .Col = 6
                         If DSConsulta!locado = False Then
                            .Text = "Não"
                         Else
                            .Text = "Sim"
                         End If
                    End With
                    DSConsulta.MoveNext
                    X = X + 1
         
                 Loop
             End If
        
        Case Is = "Intérprete"
          
            StrSQL = "SELECT interprete.interprete, titulo.titulo, estilo.nome_estilo, " _
            & "grupo.nome_grupo, cd.cod_cd, cd.locado " _
            & "FROM (interprete INNER JOIN (((grupo INNER JOIN estilo ON grupo.cod_grupo " _
            & "= estilo.cod_grupo) INNER JOIN titulo ON (grupo.cod_grupo = titulo.cod_grupo) " _
            & "AND (estilo.cod_estilo = titulo.cod_estilo) AND (estilo.cod_grupo = titulo.cod_grupo)) " _
            & "INNER JOIN [titulo-interprete] ON titulo.cod_titulo = [titulo-interprete].cod_titulo) " _
            & "ON interprete.cod_interprete = [titulo-interprete].cod_interprete) INNER JOIN cd ON " _
            & "titulo.cod_titulo = cd.cod_titulo " _
            & "WHERE (((interprete.interprete  Like '" & Criterio & "'))) " _
            & "ORDER BY " & Var & ";"

             Set QDConsulta = wbanco.CreateQueryDef("", StrSQL)
             Set DSConsulta = QDConsulta.OpenRecordset
           
             If DSConsulta.RecordCount = 0 Then
                MsgBox "Não existe(m) Registro(s) para esta Consulta", vbInformation, "CD'S Loc - Locadora de CD"
             Else
                 X = 1
                 Do While Not DSConsulta.EOF

                    With msfConsulta
                       If X > 1 Then .Rows = .Rows + 1
                         .Row = X
                         .Col = 0
                         .Text = DSConsulta!interprete
                         .Col = 1
                         .Text = DSConsulta!titulo
                         .Col = 2
                         .Text = DSConsulta!nome_estilo
                         .Col = 3
                         .Text = DSConsulta!nome_grupo
                         .Col = 4
                         .Text = DSConsulta!cod_cd
                         .Col = 5
                         If DSConsulta!locado = False Then
                            .Text = "Não"
                         Else
                            .Text = "Sim"
                         End If
                    End With
                    DSConsulta.MoveNext
                    X = X + 1
         
                 Loop
             End If
             
        Case Is = "Título", "Estilo", "Grupo"
             
             StrSQL = "SELECT interprete.interprete, titulo.titulo, estilo.nome_estilo, " _
             & "grupo.nome_grupo, cd.cod_cd, cd.locado " _
             & "FROM (interprete INNER JOIN (((grupo INNER JOIN estilo ON grupo.cod_grupo " _
             & "= estilo.cod_grupo) INNER JOIN titulo ON (grupo.cod_grupo = titulo.cod_grupo) " _
             & "AND (estilo.cod_estilo = titulo.cod_estilo) AND (estilo.cod_grupo = titulo.cod_grupo)) " _
             & "INNER JOIN [titulo-interprete] ON titulo.cod_titulo = [titulo-interprete].cod_titulo) " _
             & "ON interprete.cod_interprete = [titulo-interprete].cod_interprete) INNER JOIN cd ON " _
             & "titulo.cod_titulo = cd.cod_titulo " _
             & "WHERE (((" & Var2 & "  Like '" & Criterio & "'))) " _
             & "ORDER BY " & Var & ";"

             Set QDConsulta = wbanco.CreateQueryDef("", StrSQL)
             Set DSConsulta = QDConsulta.OpenRecordset
           
             If DSConsulta.RecordCount = 0 Then
                MsgBox "Não existe(m) Registro(s) para esta Consulta", vbInformation, "CD'S Loc - Locadora de CD"
             Else
                 X = 1
                 Do While Not DSConsulta.EOF

                    With msfConsulta
                       If X > 1 Then .Rows = .Rows + 1
                          .Row = X
                          .Col = 0
                          .Text = DSConsulta!titulo
                          .Col = 1
                          .Text = DSConsulta!interprete
                          .Col = 2
                          .Text = DSConsulta!nome_estilo
                          .Col = 3
                          .Text = DSConsulta!nome_grupo
                          .Col = 4
                          .Text = DSConsulta!cod_cd
                          .Col = 5
                          If DSConsulta!locado = False Then
                             .Text = "Não"
                          Else
                             .Text = "Sim"
                          End If
                     End With
                     DSConsulta.MoveNext
                     X = X + 1
         
                  Loop
              End If
          Case Is = "CD Físico"
          
               If chkMusicas.Value = 0 Then
               
                  StrSQL = "SELECT interprete.interprete, [titulo-interprete].cod_titulo, " _
                  & "titulo.titulo, cd.cod_cd, cd.locado, estilo.nome_estilo,grupo.nome_grupo " _
                  & "FROM (estilo INNER JOIN ((titulo INNER JOIN cd ON titulo.cod_titulo = cd.cod_titulo) " _
                  & "INNER JOIN grupo ON titulo.cod_grupo = grupo.cod_grupo) ON (grupo.cod_grupo = estilo.cod_grupo) " _
                  & "AND (estilo.cod_estilo = titulo.cod_estilo) AND (estilo.cod_grupo = titulo.cod_grupo)) " _
                  & "INNER JOIN (interprete INNER JOIN [titulo-interprete] ON interprete.cod_interprete = [titulo-interprete].cod_interprete) " _
                  & "ON titulo.cod_titulo = [titulo-interprete].cod_titulo " _
                  & "WHERE (((" & Var2 & "  Like '" & Criterio & "'))) " _
                  & "ORDER BY " & Var & ";"
                  
                  Set QDConsulta = wbanco.CreateQueryDef("", StrSQL)
                  Set DSConsulta = QDConsulta.OpenRecordset
              
                 If DSConsulta.RecordCount = 0 Then
                    MsgBox "Não existe(m) Registro(s) para esta Consulta", vbInformation, "CD'S Loc - Locadora de CD"
                 Else
                     X = 1
                     Do While Not DSConsulta.EOF
                        With msfConsulta
                           If X > 1 Then .Rows = .Rows + 1
                             .Row = X
                             .Col = 0
                             .Text = DSConsulta!cod_cd
                             .Col = 1
                             If DSConsulta!locado = False Then
                                .Text = "Não"
                             Else
                                .Text = "Sim"
                             End If
                             .Col = 2
                             .Text = DSConsulta!cod_titulo
                             .Col = 3
                             .Text = DSConsulta!titulo
                             .Col = 4
                             .Text = DSConsulta!interprete
                             .Col = 5
                             .Text = DSConsulta!nome_estilo
                             .Col = 6
                             .Text = DSConsulta!nome_grupo
                        End With
                        DSConsulta.MoveNext
                        X = X + 1
            
                     Loop
              End If
           Else
              With msfConsulta
                .Clear
                .Cols = 2
                .Rows = 2
                .Row = 0
                .Col = 0
                'Set column headers.
                s$ = "<Cod.Tit.|<Título                                             |<Intérprete                                        |<Música                                           |<Estilo                      |<Grupo          "
                .FormatString = s$
                .CellAlignment = flexAlignCenterCenter
                .Col = 1
                .CellAlignment = flexAlignCenterCenter
                .Col = 2
                .CellAlignment = flexAlignCenterCenter
                .Col = 3
                .CellAlignment = flexAlignCenterCenter
                .Col = 4
                .CellAlignment = flexAlignCenterCenter
              End With
              StrSQL = "SELECT cd.cod_cd, titulo.cod_titulo, titulo.titulo, interprete.interprete, musica.titulo_musica, " _
              & "estilo.nome_estilo, grupo.nome_grupo, cd.locado " _
              & "FROM ((cd INNER JOIN ((grupo INNER JOIN estilo ON grupo.cod_grupo" _
              & "= estilo.cod_grupo) INNER JOIN titulo ON (grupo.cod_grupo = " _
              & "titulo.cod_grupo) AND (estilo.cod_estilo = titulo.cod_estilo)  " _
              & "AND (estilo.cod_grupo = titulo.cod_grupo)) ON cd.cod_titulo =  " _
              & "titulo.cod_titulo) INNER JOIN ((interprete INNER JOIN " _
              & "(musica INNER JOIN [musica-interprete] ON musica.cod_musica =  " _
              & "[musica-interprete].cod_musica) ON interprete.cod_interprete =  " _
              & "[musica-interprete].cod_interprete) INNER JOIN [titulo-interprete] " _
              & "ON interprete.cod_interprete = [titulo-interprete].cod_interprete)  " _
              & "ON titulo.cod_titulo = [titulo-interprete].cod_titulo) INNER JOIN [titulo-musica] " _
              & "ON (titulo.cod_titulo = [titulo-musica].cod_titulo) AND (musica.cod_musica = [titulo-musica].cod_musica) " _
              & "WHERE (((" & Var2 & "  Like '" & Criterio & "'))) " _
              & "ORDER BY " & Var & ";"
              
              Set QDConsulta = wbanco.CreateQueryDef("", StrSQL)
              Set DSConsulta = QDConsulta.OpenRecordset
              
              If DSConsulta.RecordCount = 0 Then
                 MsgBox "Não existe(m) Registro(s) para esta Consulta", vbInformation, "CD'S Loc - Locadora de CD"
              Else
                 X = 1
                 Do While Not DSConsulta.EOF
                    With msfConsulta
                       If X > 1 Then .Rows = .Rows + 1
                         .Row = X
                         .Col = 0
                         .Text = DSConsulta!cod_titulo
                         .Col = 1
                         .Text = DSConsulta!titulo
                         .Col = 2
                         .Text = DSConsulta!interprete
                         .Col = 3
                         .Text = DSConsulta!titulo_musica
                         .Col = 4
                         .Text = DSConsulta!nome_estilo
                         .Col = 5
                         .Text = DSConsulta!nome_grupo
                    End With
                    DSConsulta.MoveNext
                    X = X + 1
        
                 Loop
           
              End If
               
            End If
      End Select
      
      txtEncontrou.Text = Format(DSConsulta.RecordCount, "000")
   End If
     
End Sub
Private Sub LimpaCampos()
   FormataConsulta
   optTodos.Enabled = True
   optInicComp.Enabled = True
   optTodos.Value = True
   chkMusicas.Value = 0
   chkMusicas.Visible = False
   txtEncontrou.Text = ""
   txtStrConsulta.SetFocus
End Sub
