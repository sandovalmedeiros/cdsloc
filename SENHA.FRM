VERSION 5.00
Object = "{0BA686C6-F7D3-101A-993E-0000C0EF6F5E}#1.0#0"; "THREED32.OCX"
Begin VB.Form Senha 
   Caption         =   "CD'S Loc - Login do Sistema de Locação de CD's "
   ClientHeight    =   2325
   ClientLeft      =   1140
   ClientTop       =   1515
   ClientWidth     =   4560
   ControlBox      =   0   'False
   Icon            =   "SENHA.frx":0000
   LinkTopic       =   "Form1"
   PaletteMode     =   1  'UseZOrder
   Picture         =   "SENHA.frx":0442
   ScaleHeight     =   2325
   ScaleWidth      =   4560
   Begin Threed.SSFrame SSFrame1 
      Height          =   2355
      Left            =   15
      TabIndex        =   0
      Top             =   -15
      Width           =   4560
      _Version        =   65536
      _ExtentX        =   8043
      _ExtentY        =   4154
      _StockProps     =   14
      ForeColor       =   12632256
      BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ShadowStyle     =   1
      Begin VB.PictureBox Picture1 
         Appearance      =   0  'Flat
         AutoSize        =   -1  'True
         BackColor       =   &H80000005&
         BorderStyle     =   0  'None
         ForeColor       =   &H80000008&
         Height          =   480
         Left            =   3495
         Picture         =   "SENHA.frx":0A8A
         ScaleHeight     =   480
         ScaleWidth      =   480
         TabIndex        =   4
         Top             =   540
         Width           =   480
      End
      Begin VB.TextBox Text1 
         Alignment       =   2  'Center
         Appearance      =   0  'Flat
         BeginProperty Font 
            Name            =   "Courier New"
            Size            =   12
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   420
         IMEMode         =   3  'DISABLE
         Left            =   1065
         MaxLength       =   10
         PasswordChar    =   "*"
         TabIndex        =   1
         Top             =   540
         Width           =   2295
      End
      Begin VB.CheckBox muda_senha_check 
         Appearance      =   0  'Flat
         BackColor       =   &H00C0C0C0&
         Caption         =   "Muda senha"
         ForeColor       =   &H00000000&
         Height          =   375
         Left            =   1440
         TabIndex        =   3
         Top             =   1020
         Width           =   1335
      End
      Begin VB.PictureBox Picture2 
         Appearance      =   0  'Flat
         AutoSize        =   -1  'True
         BackColor       =   &H80000005&
         BorderStyle     =   0  'None
         ForeColor       =   &H80000008&
         Height          =   480
         Left            =   435
         Picture         =   "SENHA.frx":0D94
         ScaleHeight     =   480
         ScaleWidth      =   480
         TabIndex        =   2
         Top             =   525
         Width           =   480
      End
      Begin Threed.SSPanel SSPanel1 
         Height          =   525
         Left            =   3195
         TabIndex        =   7
         Top             =   1575
         Width           =   900
         _Version        =   65536
         _ExtentX        =   1588
         _ExtentY        =   926
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
         Begin Threed.SSCommand SSCommand1 
            Height          =   495
            Left            =   15
            TabIndex        =   8
            Top             =   15
            Width           =   870
            _Version        =   65536
            _ExtentX        =   1535
            _ExtentY        =   873
            _StockProps     =   78
            Picture         =   "SENHA.frx":109E
         End
      End
      Begin VB.Label Label1 
         AutoSize        =   -1  'True
         Caption         =   "Sobre Senha Click Aqui  =>"
         ForeColor       =   &H00C000C0&
         Height          =   195
         Left            =   1170
         TabIndex        =   9
         Top             =   1710
         Width           =   1950
      End
      Begin VB.Label Label2 
         Appearance      =   0  'Flat
         AutoSize        =   -1  'True
         BackColor       =   &H00C0C0C0&
         Caption         =   "Digite a  senha aqui :"
         ForeColor       =   &H00FF0000&
         Height          =   195
         Left            =   1335
         TabIndex        =   6
         Top             =   300
         Width           =   1770
      End
      Begin VB.Label Label3 
         AutoSize        =   -1  'True
         BackColor       =   &H00C0C0C0&
         Caption         =   "Máximo 10 caracteres"
         ForeColor       =   &H000000FF&
         Height          =   195
         Left            =   1185
         TabIndex        =   5
         Top             =   1395
         Width           =   1830
      End
   End
End
Attribute VB_Name = "Senha"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Dim contador As Integer
Private Function codigo(went)
    wsai = ""
    For i = 1 To Len(went)
       wsai = wsai & Chr(Asc(Mid(went, i, 1)) Xor 255)
    Next
    codigo = wsai
End Function

Private Sub Form_Load()
  With Senha
      .Left = 3090
      .Height = 2730
      .Width = 4680
      .Top = 2775
   End With
   
  'Posiciona o formulario proximo ao canto superior esquerdo da tela
  ' Senha.Left = (Screen.Width - Senha.Width) * 0.2
  ' Senha.Top = (Screen.Height - Senha.Height) * 0.3
   'abre banco de dados
  ' ChDrive Left(App.Path, 2) 'muda para drive de carga
  ' ChDir App.Path 'muda para diretório de carga
  ' Set banco = OpenDatabase(App.Path & "\bd_cdloc.mdb")
  ' Set tabsenha = banco.OpenTable("senha")
End Sub


Private Sub muda_senha_check_Click()
  Text1.SetFocus
End Sub

Private Sub SSCommand1_Click()
   SobreSen.Show vbModal
End Sub

Private Sub Text1_KeyPress(KeyAscii As Integer)
    If KeyAscii = 13 And contador <> 3 Then
       tabsenha.MoveFirst
       If LCase(Text1) <> codigo(tabsenha("id-senha")) Then
          MsgBox "Senha Inválida, tente novamente", 64, "Atenção"
          contador = contador + 1
          Text1 = ""
          Text1.SetFocus
       Else
          If muda_senha_check Then
             wsenha_atu1 = InputBox("Forneça a nova senha.")
             wsenha_atu2 = InputBox("Forneça a nova senha, para confirmar.")
             If wsenha_atu1 = wsenha_atu2 And Len(wsenha_atu2) < 11 Then
                tabsenha.Edit
                tabsenha("id-senha") = codigo(Format(wsenha_atu2, "<"))
                tabsenha.Update
             Else
                MsgBox "Senha rejeitada por erro na confirmação ou por possuir mais de 10 caracteres. Encerre o programa e tente de novo!", 64, "Atenção"
             End If
          End If
          Unload Me
          Principal.Show
       End If
    End If
    If contador = 3 Then
       End
    End If
End Sub


