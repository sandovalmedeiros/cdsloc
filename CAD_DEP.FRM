VERSION 5.00
Object = "{0BA686C6-F7D3-101A-993E-0000C0EF6F5E}#1.0#0"; "THREED32.OCX"
Begin VB.Form Cad_Depend 
   Caption         =   "CD'S Loc - Inclusão de Dependentes"
   ClientHeight    =   2115
   ClientLeft      =   1320
   ClientTop       =   2970
   ClientWidth     =   6270
   ControlBox      =   0   'False
   Icon            =   "CAD_DEP.frx":0000
   PaletteMode     =   1  'UseZOrder
   ScaleHeight     =   2115
   ScaleWidth      =   6270
   Begin Threed.SSFrame SSFrame1 
      Height          =   2070
      Left            =   -15
      TabIndex        =   0
      Top             =   0
      Width           =   6285
      _Version        =   65536
      _ExtentX        =   11086
      _ExtentY        =   3651
      _StockProps     =   14
      Caption         =   "Inclua os Dependentes"
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
      Begin VB.TextBox TxtNomDep_Cli 
         Height          =   345
         Left            =   210
         MaxLength       =   50
         TabIndex        =   1
         Top             =   555
         Width           =   5535
      End
      Begin Threed.SSPanel SSPanel19 
         Height          =   495
         Left            =   225
         TabIndex        =   2
         Top             =   1140
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
         Begin Threed.SSCommand SSCmdGravaDep_Cli 
            Height          =   465
            Left            =   15
            TabIndex        =   3
            Top             =   15
            Width           =   705
            _Version        =   65536
            _ExtentX        =   1244
            _ExtentY        =   820
            _StockProps     =   78
            Picture         =   "CAD_DEP.frx":0442
         End
      End
      Begin Threed.SSPanel SSPanel1 
         Height          =   495
         Left            =   1260
         TabIndex        =   4
         Top             =   1140
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
         Begin Threed.SSCommand SSCmdSaiDep_Cli 
            Height          =   465
            Left            =   15
            TabIndex        =   5
            Top             =   15
            Width           =   705
            _Version        =   65536
            _ExtentX        =   1244
            _ExtentY        =   820
            _StockProps     =   78
            Picture         =   "CAD_DEP.frx":0554
         End
      End
   End
End
Attribute VB_Name = "Cad_Depend"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Private Sub SSCmdGravaDep_Cli_Click()
     Dim Msg
     If TxtNomDep_Cli = "" Then
        MsgBox "O Campo Nome do Dependente não pode ficar vazio", 48, "AVISO"
        TxtNomDep_Cli.SetFocus
     Else
        Msg = "Confirma a Inclusão do Dependente ?"  ' Define message.
        Style = vbYesNo + vbCritical + vbDefaultButton1 ' Define buttons.
        Title = "CD'S Loc - Atenção !!"  ' Define title.
        Help = "DEMO.HLP"   ' Define Help file.
        Ctxt = 1000 ' Define topic
                    ' context.
        ' Display message.
        resposta = MsgBox(Msg, Style, Title, Help, Ctxt)
        If resposta = vbYes Then   'Se a tecla acionado foi o OK
           Wdependente.AddNew
           Wdependente("cod_cliente") = cod_cliente
           Wdependente("nome_dependente") = TxtNomDep_Cli
           Wdependente.Update 'Grava no banco
           DSDependente.Requery
           Clientes.EncheGrid
           'Clientes.LstNomDep_Cli.AddItem TxtNomDep_Cli
           TxtNomDep_Cli = ""
           TxtNomDep_Cli.SetFocus
       Else
           MsgBox "Operação Cancelada", 48, "AVISO"
           TxtNomDep_Cli = ""
           TxtNomDep_Cli.SetFocus
       End If
     End If
End Sub

Private Sub SSCmdSaiDep_Cli_Click()
   Unload Me
End Sub


Private Sub TxtNomDep_Cli_KeyPress(KeyAscii As Integer)
  If KeyAscii = 13 Then
     SSCmdGravaDep_Cli.SetFocus
  End If
End Sub


