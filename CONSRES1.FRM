VERSION 5.00
Object = "{0BA686C6-F7D3-101A-993E-0000C0EF6F5E}#1.0#0"; "THREED32.OCX"
Object = "{A8B3B723-0B5A-101B-B22E-00AA0037B2FC}#1.0#0"; "GRID32.OCX"
Begin VB.Form ConsRes1 
   Caption         =   "Consulta Reserva do Cliente"
   ClientHeight    =   2115
   ClientLeft      =   1320
   ClientTop       =   1905
   ClientWidth     =   6750
   ControlBox      =   0   'False
   Icon            =   "CONSRES1.frx":0000
   LinkTopic       =   "Form1"
   PaletteMode     =   1  'UseZOrder
   ScaleHeight     =   2115
   ScaleWidth      =   6750
   Begin Threed.SSPanel SSPanel1 
      Height          =   2100
      Left            =   0
      TabIndex        =   0
      Top             =   12
      Width           =   6744
      _Version        =   65536
      _ExtentX        =   11896
      _ExtentY        =   3704
      _StockProps     =   15
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
      Begin Threed.SSPanel SSPanel2 
         Height          =   1392
         Left            =   96
         TabIndex        =   1
         Top             =   60
         Width           =   6576
         _Version        =   65536
         _ExtentX        =   11589
         _ExtentY        =   2461
         _StockProps     =   15
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
         BevelInner      =   1
         Autosize        =   3
         Begin MSGrid.Grid GRDCons_Res 
            Height          =   1245
            Left            =   75
            TabIndex        =   2
            Top             =   75
            Width           =   6435
            _Version        =   65536
            _ExtentX        =   11351
            _ExtentY        =   2196
            _StockProps     =   77
            BackColor       =   16777215
            BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
               Name            =   "MS Sans Serif"
               Size            =   8.25
               Charset         =   0
               Weight          =   400
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            BorderStyle     =   0
            Rows            =   5
            Cols            =   4
            FixedCols       =   0
            MouseIcon       =   "CONSRES1.frx":0442
         End
      End
      Begin Threed.SSCommand SSCmdSai_Cons 
         Height          =   405
         Left            =   135
         TabIndex        =   3
         Top             =   1545
         Width           =   765
         _Version        =   65536
         _ExtentX        =   1349
         _ExtentY        =   714
         _StockProps     =   78
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
         Picture         =   "CONSRES1.frx":045E
      End
   End
End
Attribute VB_Name = "ConsRes1"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Private Sub GRDProd_Ped_RowColChange()

End Sub


Private Sub Form_Load()
    GRDCons_Res.ColWidth(0) = 900
    GRDCons_Res.ColWidth(1) = 3000
    GRDCons_Res.ColWidth(2) = 1100
    GRDCons_Res.ColWidth(3) = 1100
    GRDCons_Res.Row = 0
    GRDCons_Res.Col = 0
    GRDCons_Res = "Código CD "
    GRDCons_Res.Col = 1
    GRDCons_Res = " Título   "
    GRDCons_Res.Col = 2
    GRDCons_Res = " Reserva  "
    GRDCons_Res.Col = 3
    GRDCons_Res = " Confirmação"
End Sub

Private Sub SSCmdSai_Cons_Click()
    Unload Me
End Sub


