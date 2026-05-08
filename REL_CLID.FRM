VERSION 5.00
Object = "{C932BA88-4374-101B-A56C-00AA003668DC}#1.1#0"; "MSMASK32.OCX"
Object = "{0BA686C6-F7D3-101A-993E-0000C0EF6F5E}#1.0#0"; "THREED32.OCX"
Begin VB.Form Rel_CliDEp 
   Caption         =   "CD'S Loc - Relatórios "
   ClientHeight    =   3945
   ClientLeft      =   1650
   ClientTop       =   1380
   ClientWidth     =   4050
   ControlBox      =   0   'False
   Icon            =   "REL_CLID.frx":0000
   LinkTopic       =   "Form1"
   PaletteMode     =   1  'UseZOrder
   ScaleHeight     =   3945
   ScaleWidth      =   4050
   Begin Threed.SSFrame SSFrame1 
      Height          =   3885
      Left            =   0
      TabIndex        =   0
      Top             =   -15
      Width           =   4035
      _Version        =   65536
      _ExtentX        =   7117
      _ExtentY        =   6853
      _StockProps     =   14
      BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Begin VB.OptionButton OPT_Nome 
         Caption         =   "Por Nome"
         Height          =   330
         Left            =   375
         TabIndex        =   3
         Top             =   1755
         Width           =   1215
      End
      Begin VB.OptionButton OPT_Todos 
         Caption         =   "Todos os Registros"
         Height          =   300
         Left            =   390
         TabIndex        =   2
         Top             =   510
         Width           =   1785
      End
      Begin VB.ComboBox CBO_Nome 
         Enabled         =   0   'False
         Height          =   315
         Left            =   375
         TabIndex        =   1
         Top             =   2220
         Width           =   3255
      End
      Begin Threed.SSPanel SSPanel4 
         Height          =   375
         Left            =   2010
         TabIndex        =   4
         Top             =   3315
         Width           =   735
         _Version        =   65536
         _ExtentX        =   1296
         _ExtentY        =   661
         _StockProps     =   15
         Caption         =   "SSPanel3"
         BackColor       =   12632256
         BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
            Name            =   "MS Sans Serif"
            Size            =   8.24
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         BevelOuter      =   1
         Autosize        =   3
         Begin Threed.SSCommand SSCmdVol_RelatCA 
            Height          =   345
            Left            =   15
            TabIndex        =   5
            Tag             =   "DBTTip:Sair da Rotina"
            Top             =   15
            Width           =   705
            _Version        =   65536
            _ExtentX        =   1244
            _ExtentY        =   609
            _StockProps     =   78
            Picture         =   "REL_CLID.frx":0442
         End
      End
      Begin Threed.SSPanel SSPanel1 
         Height          =   390
         Left            =   2370
         TabIndex        =   6
         Top             =   1110
         Width           =   465
         _Version        =   65536
         _ExtentX        =   820
         _ExtentY        =   688
         _StockProps     =   15
         Caption         =   "SSPanel1"
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
         Begin MSMask.MaskEdBox MskDta1_Rel 
            Height          =   360
            Left            =   15
            TabIndex        =   7
            Top             =   15
            Width           =   435
            _ExtentX        =   767
            _ExtentY        =   635
            _Version        =   327681
            Appearance      =   0
            MaxLength       =   2
            Mask            =   "##"
            PromptChar      =   " "
         End
      End
      Begin Threed.SSPanel SSPanel3 
         Height          =   375
         Left            =   420
         TabIndex        =   8
         Top             =   3330
         Width           =   735
         _Version        =   65536
         _ExtentX        =   1296
         _ExtentY        =   661
         _StockProps     =   15
         Caption         =   "SSPanel3"
         BackColor       =   12632256
         BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
            Name            =   "MS Sans Serif"
            Size            =   8.24
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         BevelOuter      =   1
         Autosize        =   3
         Begin Threed.SSCommand SSCmdImp_Relat 
            Height          =   345
            Left            =   15
            TabIndex        =   9
            Tag             =   "DBTTip:Envia a Impressão."
            Top             =   15
            Width           =   705
            _Version        =   65536
            _ExtentX        =   1244
            _ExtentY        =   609
            _StockProps     =   78
            Picture         =   "REL_CLID.frx":08E4
         End
      End
      Begin Threed.SSCheck SSChk_Data 
         Height          =   240
         Left            =   390
         TabIndex        =   10
         Tag             =   "DBTTip:Imprime todos os Clientes que fazem aniversário no mês indicado."
         Top             =   1185
         Width           =   1995
         _Version        =   65536
         _ExtentX        =   3519
         _ExtentY        =   423
         _StockProps     =   78
         Caption         =   "Aniversariantes do Mês"
         BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
            Name            =   "MS Sans Serif"
            Size            =   8.24
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
      End
   End
End
Attribute VB_Name = "Rel_CliDEp"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Private Sub limpa_campo()
  CBO_Nome = ""
  MskDta1_Rel.Mask = ""
  MskDta1_Rel.Text = ""
  MskDta1_Rel.Mask = "##"
End Sub


Private Sub Form_Load()
  ChDrive Left(App.Path, 2) 'muda para drive de carga
  ChDir App.Path 'muda para diretório de carga
  Set banco = OpenDatabase(App.Path & "\bd_cdloc.mdb")
  Set wcliente = banco.OpenTable("cliente")
  Set Wdependente = banco.OpenTable("dependente")
  'Preenche o Combo
  CBO_Nome.Clear
  If tipo_relat = "Dependentes" Then
      SSChk_Data.Enabled = False
      MskDta1_Rel.Enabled = False
      Wdependente.MoveFirst
      Do While Not Wdependente.EOF()
         CBO_Nome.AddItem Wdependente("nome_dependente")
         Wdependente.MoveNext
      Loop
  ElseIf tipo_relat = "Cliente" Then
      SSChk_Data.Enabled = True
      wcliente.MoveFirst
      Do While Not wcliente.EOF()
         CBO_Nome.AddItem wcliente("nomecliente")
         wcliente.MoveNext
      Loop
  End If
End Sub


Private Sub MskDta2_Rel_KeyPress(KeyAscii As Integer)
   If KeyAscii = 13 Then
      SSCmdImp_Relat.SetFocus
   End If
End Sub

Private Sub MskDta2_Rel_LostFocus()
  If Not IsDate(MskDta2_Rel) Then
       MsgBox "Data Inválida", 48
       SSChk_Data.SetFocus
  End If
End Sub

Private Sub MskDta1_Rel_KeyPress(KeyAscii As Integer)
    If KeyAscii = 13 Then
       SSCmdImp_Relat.SetFocus
    End If
End Sub

Private Sub MskDta1_Rel_LostFocus()
   If Val(MskDta1_Rel) < 1 Or Val(MskDta1_Rel) > 12 Then
      MsgBox "Mês Inválido Entre de 1 a 12", 16
      MskDta1_Rel.SetFocus
   End If
End Sub

Private Sub OPT_Nome_Click()
  CBO_Nome.Enabled = True
End Sub

Private Sub OPT_Todos_Click()
  limpa_campo
  'SSChk_Data.Enabled = False
  'MskDta1_Rel.Enabled = False
End Sub

Private Sub SSChk_Data_Click(Value As Integer)
 '  MskDta1_Rel.SetFocus
End Sub

Private Sub SSCmdImp_Relat_Click()
 If OPT_Todos = True Then
    'SQL = "select * form adiantamento"
 End If
 If SSChk_Data = True Then 'opt_data = True Then
     Vdt1 = MskDta1_Rel
 End If
 If tipo_relat = "Cliente" Then 'Relatório por Cliente -
    If OPT_Nome = True Then
        RS = "{cliente.nomecliente}='" + CBO_Nome + "'"
    End If
    If SSChk_Data = True Then
       RS = "Month({Cliente.data-nascimento})=" & Val(Vdt1) & ""
    End If
    'Chama o Relatório
    Principal.Imprimir.ReportFileName = "c:\Arquivos de Programas\CD'S LOC\AnivMes.rpt"
    'Principal.imprimir.ReportFileName = "c:\trab\cd-loc\clien02.rpt"
 ElseIf tipo_relat = "Dependentes" Then 'Relatório por Dependente -
     If OPT_Nome = True Then
        RS = "{dependente.nome_dependente}='" + CBO_Nome + "'"
     End If
     If SSChk_Data = True Then
       RS = "Month ({Cliente.data-nascimento})='" + Vdt1 + "'"
     End If
     'Chama o Relatório
     Principal.Imprimir.ReportFileName = "c:\Arquivos de Programas\CD'S LOC\clien03.rpt"
     'Principal.imprimir.ReportFileName = "c:\trab\cd-loc\clien03.rpt"
 End If
 
 Principal.Imprimir.SelectionFormula = RS
 Principal.Imprimir.Action = 1
 
 MskDta1_Rel.Mask = ""
 MskDta1_Rel.Text = ""
 MskDta1_Rel.Mask = "##"
 SSChk_Data.Value = False
 OPT_Todos = False
 OPT_Nome = False
 CBO_Nome = ""
 If tipo_relat <> "Dependentes" Then
    SSChk_Data.Enabled = True
    MskDta1_Rel.Enabled = True
 End If
 CBO_Nome.Enabled = False
End Sub


Private Sub SSCmdVol_RelatCA_Click()
   Unload Me
End Sub


