VERSION 5.00
Object = "{C932BA88-4374-101B-A56C-00AA003668DC}#1.1#0"; "MSMASK32.OCX"
Object = "{0BA686C6-F7D3-101A-993E-0000C0EF6F5E}#1.0#0"; "THREED32.OCX"
Object = "{FAEEE763-117E-101B-8933-08002B2F4F5A}#1.1#0"; "DBLIST32.OCX"
Begin VB.Form ConsRes3 
   Caption         =   "Consulta Reserva de CD'S"
   ClientHeight    =   4320
   ClientLeft      =   2145
   ClientTop       =   1575
   ClientWidth     =   4965
   ControlBox      =   0   'False
   Icon            =   "CONSRES3.frx":0000
   LinkTopic       =   "Form1"
   PaletteMode     =   1  'UseZOrder
   ScaleHeight     =   4320
   ScaleWidth      =   4965
   Begin Threed.SSFrame SSFrame1 
      Height          =   4356
      Left            =   0
      TabIndex        =   0
      Top             =   -36
      Width           =   4968
      _Version        =   65536
      _ExtentX        =   8758
      _ExtentY        =   7673
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
      Begin VB.OptionButton OPT_Conf 
         Caption         =   "Reservas Confirmadas"
         ForeColor       =   &H00FF0000&
         Height          =   345
         Left            =   435
         TabIndex        =   15
         Top             =   1905
         Width           =   2910
      End
      Begin VB.OptionButton OPT_NConf 
         Caption         =   "Reservas NÃO Confirmadas"
         ForeColor       =   &H000000FF&
         Height          =   345
         Left            =   435
         TabIndex        =   14
         Top             =   1500
         Width           =   2910
      End
      Begin VB.Data Data_Cliente 
         Caption         =   "Data_Cliente"
         Connect         =   "Access"
         DatabaseName    =   ""
         DefaultCursorType=   0  'DefaultCursor
         DefaultType     =   2  'UseODBC
         Exclusive       =   0   'False
         Height          =   345
         Left            =   2310
         Options         =   0
         ReadOnly        =   0   'False
         RecordsetType   =   2  'Snapshot
         RecordSource    =   "Cliente"
         Top             =   165
         Visible         =   0   'False
         Width           =   2505
      End
      Begin VB.OptionButton OPT_Todos 
         Caption         =   "Todas as Reservas"
         ForeColor       =   &H00FF0000&
         Height          =   345
         Left            =   450
         TabIndex        =   5
         Top             =   225
         Value           =   -1  'True
         Width           =   1950
      End
      Begin VB.OptionButton OPT_Nome 
         Caption         =   "Por Nome"
         ForeColor       =   &H00FF0000&
         Height          =   330
         Left            =   465
         TabIndex        =   4
         Top             =   2310
         Width           =   1215
      End
      Begin VB.OptionButton OPT_Data 
         Caption         =   "Por Data"
         ForeColor       =   &H00FF0000&
         Height          =   270
         Left            =   450
         TabIndex        =   3
         Top             =   615
         Width           =   990
      End
      Begin Threed.SSPanel SSPanel4 
         Height          =   528
         Left            =   2460
         TabIndex        =   1
         Top             =   3612
         Width           =   732
         _Version        =   65536
         _ExtentX        =   1296
         _ExtentY        =   926
         _StockProps     =   15
         Caption         =   "SSPanel3"
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
         Begin Threed.SSCommand SSCmdVol_RelatCA 
            Height          =   495
            Left            =   15
            TabIndex        =   2
            Top             =   15
            Width           =   705
            _Version        =   65536
            _ExtentX        =   1244
            _ExtentY        =   873
            _StockProps     =   78
            Picture         =   "CONSRES3.frx":0442
         End
      End
      Begin Threed.SSPanel SSPanel1 
         Height          =   396
         Left            =   456
         TabIndex        =   6
         Top             =   972
         Width           =   1248
         _Version        =   65536
         _ExtentX        =   2196
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
         Begin MSMask.MaskEdBox MskDta1_Cons 
            Height          =   360
            Left            =   15
            TabIndex        =   7
            Top             =   15
            Width           =   1230
            _ExtentX        =   2170
            _ExtentY        =   635
            _Version        =   327681
            Appearance      =   0
            Enabled         =   0   'False
            MaxLength       =   10
            Mask            =   "##/##/####"
            PromptChar      =   " "
         End
      End
      Begin Threed.SSPanel SSPanel2 
         Height          =   396
         Left            =   2088
         TabIndex        =   8
         Top             =   972
         Width           =   1236
         _Version        =   65536
         _ExtentX        =   2170
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
         Begin MSMask.MaskEdBox MskDta2_Cons 
            Height          =   360
            Left            =   15
            TabIndex        =   9
            Top             =   15
            Width           =   1215
            _ExtentX        =   2143
            _ExtentY        =   635
            _Version        =   327681
            Appearance      =   0
            Enabled         =   0   'False
            MaxLength       =   10
            Mask            =   "##/##/####"
            PromptChar      =   " "
         End
      End
      Begin Threed.SSPanel SSPanel3 
         Height          =   540
         Left            =   1332
         TabIndex        =   10
         Top             =   3600
         Width           =   732
         _Version        =   65536
         _ExtentX        =   1296
         _ExtentY        =   953
         _StockProps     =   15
         Caption         =   "SSPanel3"
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
         Begin Threed.SSCommand SSCmdImp_Cons 
            Height          =   510
            Left            =   15
            TabIndex        =   11
            Top             =   15
            Width           =   705
            _Version        =   65536
            _ExtentX        =   1244
            _ExtentY        =   900
            _StockProps     =   78
            Picture         =   "CONSRES3.frx":08E4
         End
      End
      Begin MSDBCtls.DBCombo DBC_Nome 
         Bindings        =   "CONSRES3.frx":09F6
         Height          =   288
         Left            =   432
         TabIndex        =   12
         Top             =   2652
         Width           =   4332
         _ExtentX        =   7646
         _ExtentY        =   556
         _Version        =   327681
         Enabled         =   0   'False
         BackColor       =   16777215
         ForeColor       =   0
         ListField       =   "nomecliente"
         BoundColumn     =   "nomecliente"
         Text            =   "DBC_Nome"
      End
      Begin VB.Label Label1 
         AutoSize        =   -1  'True
         Caption         =   "a"
         Height          =   240
         Left            =   1830
         TabIndex        =   13
         Top             =   1065
         Width           =   90
      End
   End
End
Attribute VB_Name = "ConsRes3"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Private Sub SSCmdImp_RelatCA_Click()
  Dim Cons_Re  As Snapshot
  Dim Apag_Re As Dynaset
End Sub


Private Sub Form_Load()
   'ChDrive Left(App.Path, 2) 'muda para drive de carga
   'ChDir App.Path 'muda para diretório de carga
   'Set wbanco = OpenDatabase(App.Path & "\bd_cdloc.mdb")
   
   Set vformu = ConsRes3
   ChDir App.Path 'muda para diretório de carga

   With Data_Cliente
     'Seta o data
     .DatabaseName = App.Path & "\bd_cdloc.mdb"
     .Refresh
   End With
   
   If VConre = "Relatorio" Then
       Caption = "Relatório Consulta Reserva de CD'S"
       SSCmdImp_Cons.Picture = LoadPicture(App.Path & "\Print.bmp")
   Else
       Caption = "Consulta Reserva de CD'S"
       SSCmdImp_Cons.Picture = LoadPicture(App.Path & "\Binoculo.bmp")
   End If

   
   
End Sub

Private Sub MskDta1_Cons_KeyPress(KeyAscii As Integer)
    If KeyAscii = 13 Then
       MskDta2_Cons.SetFocus
    End If
End Sub

Private Sub OPT_Data_Click()
    DBC_Nome = ""
    DBC_Nome.Enabled = False
    MskDta1_Cons.Enabled = True
    MskDta2_Cons.Enabled = True
    MskDta1_Cons.SetFocus
End Sub

Private Sub OPT_Nome_Click()
    MskDta1_Cons.Enabled = False
    MskDta2_Cons.Enabled = False
    DBC_Nome.Enabled = True
    DBC_Nome.SetFocus
End Sub

Private Sub OPT_Todos_Click()
    MskDta1_Cons.Enabled = False
    MskDta2_Cons.Enabled = False
    DBC_Nome.Enabled = False
End Sub


Private Sub SSCmdImp_Cons_Click()
   X = 1
   Select Case VConre
   Case Is = "Relatorio"
   
        Dim SQL As String, RS As String ', banco As Database
        'Set banco = OpenDatabase("gerad.mdb")
        
        
        If OPT_Todos = True Then
        
           'SQL = "select * form adiantamento"
        ElseIf OPT_Data = True Then
           Vdt1 = Format(MskDta1_Cons, "yyyy,mm,dd")
           Vdt2 = Format(MskDta2_Cons, "yyyy,mm,dd")
           RS = "{adiantamento.dat_ra}>=Date(" + Vdt1 + ") and {adiantamento.dat_ra}<=date(" + Vdt2 + ")"
        ElseIf OPT_Nome = True Then
           RS = "{adiantamento.num_ma}='" + DBC_Nome.BoundText + "'"
        End If
        
        'Chama o Relatório
        'Principal.Relatorios2.ReportFileName = "c:\gerad\contad.rpt"
        'Principal.Relatorios2.SelectionFormula = RS
        'Principal.Relatorios2.Action = 1
    
    Case Is = "Consulta"
        Set Cons_Re = wbanco.CreateSnapshot("Consulta Reserva")
        If Cons_Re.RecordCount <> 0 Then
           If OPT_Todos = True Then
               ConsRes2.Caption = "Todos"
               ConsRes2.Grid1.Rows = 9
              ' Set Cons_Re = wbanco.CreateSnapshot("Consulta Reserva")
               Cons_Re.MoveFirst
               VTitul = "Todos"
               Unload Me
               ConsRes2.Show vbModal
           ElseIf OPT_NConf = True Then
               ConsRes2.Caption = "Reservas NÃO Confirmadas"
               ConsRes2.Grid1.Rows = 9
              ' Set Cons_Re = wbanco.CreateSnapshot("Consulta Reserva")
               Cons_Re.MoveFirst
               VTitul = ConsRes2.Caption
               Unload Me
               ConsRes2.Show vbModal
           ElseIf OPT_Conf = True Then
               ConsRes2.Caption = "Reservas Confirmadas"
               ConsRes2.Grid1.Rows = 9
              ' Set Cons_Re = wbanco.CreateSnapshot("Consulta Reserva")
               Cons_Re.MoveFirst
               VTitul = ConsRes2.Caption
               Unload Me
               ConsRes2.Show vbModal
           ElseIf OPT_Data = True Then
               Vdt1 = Format(MskDta1_Cons, "yyyy/mm/dd")
               Vdt2 = Format(MskDta2_Cons, "yyyy/mm/dd")
               ConsRes2.Caption = "Por Data"
               ConsRes2.Grid1.Rows = 9
             '  Set Cons_Re = wbanco.CreateSnapshot("Consulta Reserva")
               Cons_Re.MoveFirst
               VTitul = ConsRes2.Caption
               Unload Me
               ConsRes2.Show vbModal
           ElseIf OPT_Nome = True Then
               ConsRes2.Caption = "Por Nome"
               ConsRes2.Grid1.Rows = 9
             '  Set Cons_Re = wbanco.CreateSnapshot("Consulta Reserva")
               Cons_Re.MoveFirst
               Vdbc = DBC_Nome.Text
               VTitul = ConsRes2.Caption
               Unload Me
               ConsRes2.Show vbModal
           End If
        Else
           MsgBox "Tabela Vazia", vbInformation
        End If
    End Select
    
    'Limpa os campos
    MskDta1_Cons.Mask = ""
    MskDta1_Cons.Text = ""
    MskDta1_Cons.Mask = "##/##/####"
    MskDta2_Cons.Mask = ""
    MskDta2_Cons.Text = ""
    MskDta2_Cons.Mask = "##/##/####"
    DBC_Nome = ""
    OPT_Todos = True
    
    
End Sub


Private Sub SSCmdVol_RelatCA_Click()
    Unload Me
End Sub


