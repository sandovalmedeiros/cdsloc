VERSION 5.00
Object = "{F9043C88-F6F2-101A-A3C9-08002B2F49FB}#1.1#0"; "COMDLG32.OCX"
Object = "{00025600-0000-0000-C000-000000000046}#4.6#0"; "CRYSTL32.OCX"
Object = "{6B7E6392-850A-101B-AFC0-4210102A8DA7}#1.2#0"; "COMCTL32.OCX"
Begin VB.MDIForm Principal 
   Appearance      =   0  'Flat
   BackColor       =   &H8000000C&
   Caption         =   $"MENU02.frx":0000
   ClientHeight    =   5235
   ClientLeft      =   900
   ClientTop       =   1890
   ClientWidth     =   9420
   Icon            =   "MENU02.frx":0097
   LinkTopic       =   "MDIForm1"
   WindowState     =   2  'Maximized
   Begin ComctlLib.StatusBar StatusBar1 
      Align           =   2  'Align Bottom
      Height          =   315
      Left            =   0
      TabIndex        =   1
      Top             =   4920
      Width           =   9420
      _ExtentX        =   16616
      _ExtentY        =   556
      SimpleText      =   ""
      _Version        =   327682
      BeginProperty Panels {0713E89E-850A-101B-AFC0-4210102A8DA7} 
         NumPanels       =   9
         BeginProperty Panel1 {0713E89F-850A-101B-AFC0-4210102A8DA7} 
            Style           =   6
            Object.Width           =   1658
            MinWidth        =   1658
            TextSave        =   "25/03/99"
            Key             =   ""
            Object.Tag             =   ""
         EndProperty
         BeginProperty Panel2 {0713E89F-850A-101B-AFC0-4210102A8DA7} 
            Style           =   5
            Object.Width           =   1305
            MinWidth        =   1305
            TextSave        =   "10:19"
            Key             =   ""
            Object.Tag             =   ""
         EndProperty
         BeginProperty Panel3 {0713E89F-850A-101B-AFC0-4210102A8DA7} 
            Bevel           =   0
            TextSave        =   ""
            Key             =   ""
            Object.Tag             =   ""
         EndProperty
         BeginProperty Panel4 {0713E89F-850A-101B-AFC0-4210102A8DA7} 
            Style           =   1
            Enabled         =   0   'False
            Object.Width           =   1305
            MinWidth        =   1305
            TextSave        =   "CAPS"
            Key             =   ""
            Object.Tag             =   ""
         EndProperty
         BeginProperty Panel5 {0713E89F-850A-101B-AFC0-4210102A8DA7} 
            Style           =   2
            Object.Width           =   1305
            MinWidth        =   1305
            TextSave        =   "NUM"
            Key             =   ""
            Object.Tag             =   ""
         EndProperty
         BeginProperty Panel6 {0713E89F-850A-101B-AFC0-4210102A8DA7} 
            Style           =   3
            Enabled         =   0   'False
            Object.Width           =   1305
            MinWidth        =   1305
            TextSave        =   "INS"
            Key             =   ""
            Object.Tag             =   ""
         EndProperty
         BeginProperty Panel7 {0713E89F-850A-101B-AFC0-4210102A8DA7} 
            Bevel           =   0
            TextSave        =   ""
            Key             =   ""
            Object.Tag             =   ""
         EndProperty
         BeginProperty Panel8 {0713E89F-850A-101B-AFC0-4210102A8DA7} 
            Bevel           =   0
            TextSave        =   ""
            Key             =   ""
            Object.Tag             =   ""
         EndProperty
         BeginProperty Panel9 {0713E89F-850A-101B-AFC0-4210102A8DA7} 
            AutoSize        =   2
            Bevel           =   0
            Object.Width           =   6191
            MinWidth        =   4304
            Text            =   "                                by: Sandoval@e-net.com.br"
            TextSave        =   "                                by: Sandoval@e-net.com.br"
            Key             =   ""
            Object.Tag             =   ""
         EndProperty
      EndProperty
   End
   Begin VB.PictureBox Picture1 
      Align           =   1  'Align Top
      Appearance      =   0  'Flat
      BackColor       =   &H80000005&
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H80000008&
      Height          =   495
      Left            =   0
      ScaleHeight     =   465
      ScaleWidth      =   9390
      TabIndex        =   0
      Top             =   0
      Visible         =   0   'False
      Width           =   9420
      Begin MSComDlg.CommonDialog CMDconfigurarImpressora 
         Left            =   615
         Top             =   -15
         _ExtentX        =   847
         _ExtentY        =   847
         _Version        =   327681
         DialogTitle     =   "Configurar Impressora"
         Flags           =   64
      End
      Begin Crystal.CrystalReport Imprimir 
         Left            =   90
         Top             =   15
         _ExtentX        =   741
         _ExtentY        =   741
         _Version        =   262150
         WindowWidth     =   480
         WindowControlBox=   -1  'True
         WindowMaxButton =   -1  'True
         WindowMinButton =   -1  'True
         PrintFileType   =   2
      End
   End
   Begin VB.Menu cad 
      Caption         =   "&Cadastro"
      Begin VB.Menu cli01 
         Caption         =   "Clientes"
         Begin VB.Menu cli02 
            Caption         =   "Clientes"
         End
         Begin VB.Menu dep 
            Caption         =   "Dependentes"
         End
      End
      Begin VB.Menu cds_mdi 
         Caption         =   "CD'S"
      End
      Begin VB.Menu Tabelas_Mdi 
         Caption         =   "Tabelas"
      End
   End
   Begin VB.Menu mnu_Consultas 
      Caption         =   "Consul&tas"
   End
   Begin VB.Menu loc01 
      Caption         =   "&Movimentação"
   End
   Begin VB.Menu reserv 
      Caption         =   "&Reserva"
   End
   Begin VB.Menu imp 
      Caption         =   "&Imprimir"
      Begin VB.Menu config_imp 
         Caption         =   "Configurar Impressora"
      End
      Begin VB.Menu rel_cli 
         Caption         =   "Clientes"
         Begin VB.Menu rel_cli01 
            Caption         =   "Sintético"
         End
         Begin VB.Menu rel_cli02 
            Caption         =   "Analítico"
         End
      End
      Begin VB.Menu dep_rel 
         Caption         =   "Dependentes"
      End
      Begin VB.Menu musica_imp 
         Caption         =   "Músicas"
         Begin VB.Menu mus_int 
            Caption         =   "Músicas/Intérpretes"
         End
         Begin VB.Menu mus_cad 
            Caption         =   "Só as Músicas"
         End
      End
      Begin VB.Menu cd_fisico 
         Caption         =   "CD's"
         Begin VB.Menu cd_fis 
            Caption         =   "CD Físico"
         End
         Begin VB.Menu cd_tit 
            Caption         =   "Títulos"
         End
      End
   End
   Begin VB.Menu jan01 
      Caption         =   "&Janelas"
      Begin VB.Menu lad 
         Caption         =   "&Lado a Lado"
         Shortcut        =   ^I
      End
      Begin VB.Menu Cas 
         Caption         =   "&Cascata"
         Shortcut        =   ^C
      End
      Begin VB.Menu ativ 
         Caption         =   "Janelas Ativas"
         WindowList      =   -1  'True
      End
   End
   Begin VB.Menu final 
      Caption         =   "&Finaliza"
   End
End
Attribute VB_Name = "Principal"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
'Dim wbanco As Database
'Dim wclien As Table

Private Sub Cas_Click()
    Principal.Arrange 0
End Sub

Private Sub cd_fis_Click()
    Imprimir.ReportFileName = "c:\Arquivos de Programas\CD'S LOC\cds.rpt"
    Imprimir.Action = 1
End Sub

Private Sub cd_tit_Click()
    Imprimir.ReportFileName = "c:\Arquivos de Programas\CD'S LOC\titulos.rpt"
    Imprimir.Action = 1

End Sub

Private Sub cds_Click()
    Cds.Show
End Sub

Private Sub cds_mdi_Click()
   Cds.Show
End Sub

Private Sub cli02_Click()
    Clientes.Show
End Sub

Private Sub config_imp_Click()
    CMDconfigurarImpressora.Action = 5
End Sub

Private Sub Consulta_res_Click()
    consulta_reserva.Show
End Sub

Private Sub dep_Click()
    Clientes.Show
End Sub

Private Sub dep_rel_Click()
    Imprimir.ReportFileName = "c:\Arquivos de Programas\CD'S LOC\depend.rpt"
    Imprimir.Action = 1
End Sub

Private Sub dev_Click()
    devolve.Show
End Sub

Private Sub est_Click()
    cad_est.Show
End Sub

Private Sub faz_reserva_Click()
    reserva.Show
End Sub

Private Sub final_Click()
    'Arquimsg "arquimsg.msg", 1
    a = MsgBox("Deseja realmente sair do sistema ?", 49)
    If a = "2" Then
       Principal.Show
    Else
       End
    End If
End Sub

Private Sub grp02_Click()
    grupo.Show
End Sub

Private Sub inter_Click()
     cad_int.Show
End Sub

Private Sub lad_Click()
    Principal.Arrange 2
End Sub

Private Sub loc02_Click()
    locacao.Show
End Sub

Private Sub loc01_Click()
   LocDevol.Show
End Sub

Private Sub MDIForm_Load()
     
    'Chama a Procedure no Modulo que seta o Banco e as Tabelas
    SetaBanco
    'tela de abertura
    frmPainel.Show
   ' frmPainel.Show
    DoEvents
    'abre janela de login
    Senha.Show vbModal
    'carrega o formulario de cadastro na memoria
    'Load frmcadastro
    Unload frmPainel
    '.StatusBar1.Panels(1).Text = "Login: " & UserName
    '.StatusBar1.Panels(2).Text = "Grupo: " & NmGrupo
End Sub

Private Sub mnu_musicas_Click()
     frmConsulta.Show
End Sub

Private Sub mnu_Consultas_Click()
   frmConsulta.Show
End Sub

Private Sub mus_cad_Click()
    Imprimir.ReportFileName = "c:\Arquivos de Programas\CD'S LOC\musicas1.rpt"
    Imprimir.Action = 1
End Sub
Private Sub mus_Click()
    musica.Show
End Sub
Private Sub mus_int_Click()
    Imprimir.ReportFileName = "c:\Arquivos de Programas\CD'S LOC\musicas.rpt"
    Imprimir.Action = 1
End Sub

Private Sub reci_Click()
    Recibo_form.Show
End Sub

Private Sub rel_cli01_Click()
    Imprimir.ReportFileName = "c:\Arquivos de Programas\CD'S LOC\clien01.rpt"
    Imprimir.Action = 1
End Sub

Private Sub rel_cli02_Click()
    Imprimir.ReportFileName = "c:\Arquivos de Programas\CD'S LOC\clien02.rpt"
    Imprimir.Action = 1
End Sub

Private Sub reserv_Click()
   ReservCD.Show
End Sub

Private Sub Tabelas_Mdi_Click()
   Tabelas.Show
End Sub


