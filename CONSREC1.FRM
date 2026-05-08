VERSION 5.00
Object = "{0BA686C6-F7D3-101A-993E-0000C0EF6F5E}#1.0#0"; "THREED32.OCX"
Object = "{A8B3B723-0B5A-101B-B22E-00AA0037B2FC}#1.0#0"; "GRID32.OCX"
Begin VB.Form ConsRec1 
   Caption         =   "Consulta Recibos em Aberto"
   ClientHeight    =   3555
   ClientLeft      =   1140
   ClientTop       =   1515
   ClientWidth     =   6750
   ControlBox      =   0   'False
   Icon            =   "CONSREC1.frx":0000
   LinkTopic       =   "Form1"
   PaletteMode     =   1  'UseZOrder
   ScaleHeight     =   3555
   ScaleWidth      =   6750
   Begin Threed.SSPanel SSPanel1 
      Height          =   3555
      Left            =   0
      TabIndex        =   0
      Top             =   0
      Width           =   6750
      _Version        =   65536
      _ExtentX        =   11906
      _ExtentY        =   6271
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
         Height          =   2340
         Left            =   90
         TabIndex        =   1
         Top             =   60
         Width           =   6570
         _Version        =   65536
         _ExtentX        =   11589
         _ExtentY        =   4128
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
         Begin MSGrid.Grid GRDCons_Rec 
            Height          =   2190
            Left            =   75
            TabIndex        =   2
            Top             =   75
            Width           =   6420
            _Version        =   65536
            _ExtentX        =   11324
            _ExtentY        =   3863
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
            Rows            =   9
            Cols            =   4
            FixedCols       =   0
            MouseIcon       =   "CONSREC1.frx":0442
         End
      End
      Begin Threed.SSCommand SSCmdSai_Cons 
         Height          =   405
         Left            =   135
         TabIndex        =   3
         Top             =   2640
         Width           =   765
         _Version        =   65536
         _ExtentX        =   1349
         _ExtentY        =   714
         _StockProps     =   78
         ForeColor       =   16711680
         Picture         =   "CONSREC1.frx":045E
      End
      Begin VB.Label Label1 
         AutoSize        =   -1  'True
         BackColor       =   &H00C0C0C0&
         Caption         =   "Dê um Duplo Click no Cliente para Selecionar o Recibo"
         BeginProperty Font 
            Name            =   "MS Sans Serif"
            Size            =   9.75
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H000000FF&
         Height          =   240
         Left            =   630
         TabIndex        =   4
         Top             =   3165
         Width           =   5745
      End
   End
End
Attribute VB_Name = "ConsRec1"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Private Sub Form_Load()
    GRDCons_Rec.ColWidth(0) = 900
    GRDCons_Rec.ColWidth(1) = 3000
    GRDCons_Rec.ColWidth(2) = 1100
    GRDCons_Rec.ColWidth(3) = 1100
    GRDCons_Rec.Row = 0
    GRDCons_Rec.Col = 0
    GRDCons_Rec = "Cód. Cliente "
    GRDCons_Rec.Col = 1
    GRDCons_Rec = " Nome Cliente   "
    GRDCons_Rec.Col = 2
    GRDCons_Rec = " Num.Recibo"
    GRDCons_Rec.Col = 3
    GRDCons_Rec = " Valor Total"
End Sub

Private Sub GRDCons_Res_RowColChange()

End Sub

Private Sub GRDCons_Rec_DblClick()
    On Error GoTo trataerro
    GRDCons_Rec.Col = 2
    If cons = "Devol" Then
       LocDevol.TxtRec_Dev = GRDCons_Rec.Text
       cons = ""
       Unload Me
       LocDevol.TxtRec_Dev.SetFocus
    ElseIf cons = "Recibo" Then
       LocDevol.DBCRecibo_Rec = GRDCons_Rec.Text
       cons = ""
       Unload Me
       LocDevol.DBCRecibo_Rec.SetFocus
    End If
trataerro: ' Error-handling routine.
    Select Case Err.Number  ' Evaluate error number.
        Case 5
           MsgBox "Favor limpar devolução anterior", vbInformation, "CD'S Loc"
           Unload Me
        Case Is <> 0 ' Else
            ' Handle other situations here...
            MsgBox "Ocorreu Erro No. " & Err.Number & " , ligue p/Sandoval", 48
    End Select

End Sub

Private Sub SSCmdSai_Cons_Click()
    Unload Me
End Sub


