VERSION 5.00
Object = "{0BA686C6-F7D3-101A-993E-0000C0EF6F5E}#1.0#0"; "THREED32.OCX"
Object = "{A8B3B723-0B5A-101B-B22E-00AA0037B2FC}#1.0#0"; "GRID32.OCX"
Begin VB.Form ConsRes2 
   Caption         =   "Consulta Reservas de CD'S"
   ClientHeight    =   3240
   ClientLeft      =   525
   ClientTop       =   1950
   ClientWidth     =   8160
   ControlBox      =   0   'False
   Icon            =   "CONSRES2.frx":0000
   LinkTopic       =   "Form1"
   PaletteMode     =   1  'UseZOrder
   ScaleHeight     =   3240
   ScaleWidth      =   8160
   Begin Threed.SSPanel SSPanel1 
      Height          =   3225
      Left            =   0
      TabIndex        =   0
      Top             =   0
      Width           =   8145
      _Version        =   65536
      _ExtentX        =   14367
      _ExtentY        =   5689
      _StockProps     =   15
      ForeColor       =   16711680
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
      Alignment       =   2
      Begin Threed.SSPanel SSPanel2 
         Height          =   2688
         Left            =   96
         TabIndex        =   1
         Top             =   96
         Width           =   7908
         _Version        =   65536
         _ExtentX        =   13944
         _ExtentY        =   4736
         _StockProps     =   15
         BackColor       =   12632256
         BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
            Name            =   "MS Sans Serif"
            Size            =   8.2
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         BevelInner      =   1
         Autosize        =   3
         Begin MSGrid.Grid Grid1 
            Height          =   2550
            Left            =   75
            TabIndex        =   2
            Top             =   75
            Width           =   7770
            _Version        =   65536
            _ExtentX        =   13705
            _ExtentY        =   4498
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
            Rows            =   10
            Cols            =   10
            FixedCols       =   0
            MouseIcon       =   "CONSRES2.frx":0442
         End
      End
      Begin Threed.SSCommand SSCommand1 
         Height          =   345
         Left            =   105
         TabIndex        =   3
         Top             =   2820
         Width           =   765
         _Version        =   65536
         _ExtentX        =   1349
         _ExtentY        =   609
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
         Picture         =   "CONSRES2.frx":045E
      End
      Begin VB.Label Label1 
         AutoSize        =   -1  'True
         Caption         =   "Duplo Click Seleciona o Item"
         BeginProperty Font 
            Name            =   "MS Sans Serif"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H000000FF&
         Height          =   195
         Left            =   2400
         TabIndex        =   4
         Top             =   2865
         Width           =   2475
      End
   End
End
Attribute VB_Name = "ConsRes2"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False

Private Sub Form_Activate()
    Dim Cons_Re As Snapshot
    Dim databanco As Variant
    X = 1
    Set Cons_Re = wbanco.CreateSnapshot("Consulta Reserva")
    Cons_Re.MoveFirst
    Select Case VTitul
    Case Is = "Todos"
        Do While Not Cons_Re.EOF
           ConsRes2.Grid1.Row = X
           ConsRes2.Grid1.Col = 0
           ConsRes2.Grid1 = Format(Cons_Re("Cod_Cliente"), "000000")
           ConsRes2.Grid1.Col = 1
           ConsRes2.Grid1 = Cons_Re("Nomecliente")
           ConsRes2.Grid1.Col = 2
           ConsRes2.Grid1 = Cons_Re("titulo")
           ConsRes2.Grid1.Col = 3
           If Not IsNull(Cons_Re("data_reserva")) Then
              ConsRes2.Grid1 = Format(Cons_Re("data_reserva"), "dd/mm/yyyy")
           End If
           ConsRes2.Grid1.Col = 4
           If Not IsNull(Cons_Re("data_confirmacao")) Then
              ConsRes2.Grid1 = Format(Cons_Re("data_confirmacao"), "dd/mm/yyyy")
           End If
           ConsRes2.Grid1.Col = 5
           If Cons_Re("locado") = True Then
            ConsRes2.Grid1 = "SIM"
           Else
            ConsRes2.Grid1 = "NÃO"
           End If
           ConsRes2.Grid1.Col = 6
           ConsRes2.Grid1 = Format(Cons_Re("cod_cd"), ">")
           ConsRes2.Grid1.Col = 7
           ConsRes2.Grid1 = Cons_Re("fone-01")
           ConsRes2.Grid1.Col = 8
           ConsRes2.Grid1 = Cons_Re("fone-02")
           ConsRes2.Grid1.Col = 9
           ConsRes2.Grid1 = Format(Cons_Re("cod_titulo"), "000000")
           
           Cons_Re.MoveNext
           X = X + 1
           If X > 9 Then
              ConsRes2.Grid1.Rows = ConsRes2.Grid1.Rows + 1
           End If
        Loop
    Case Is = "Por Data"
        Do While Not Cons_Re.EOF
            databanco = Format(Cons_Re("data_reserva"), "yyyy/mm/dd")
         If databanco >= Vdt1 And databanco <= Vdt2 Then
            ConsRes2.Grid1.Row = X
            ConsRes2.Grid1.Col = 0
            ConsRes2.Grid1 = Format(Cons_Re("Cod_Cliente"), "000000")
            ConsRes2.Grid1.Col = 1
            ConsRes2.Grid1 = Cons_Re("Nomecliente")
            ConsRes2.Grid1.Col = 2
            ConsRes2.Grid1 = Cons_Re("titulo")
            ConsRes2.Grid1.Col = 3
            If Not IsNull(Cons_Re("data_reserva")) Then
               ConsRes2.Grid1 = Format(Cons_Re("data_reserva"), "dd/mm/yyyy")
            End If
            ConsRes2.Grid1.Col = 4
            If Not IsNull(Cons_Re("data_confirmacao")) Then
               ConsRes2.Grid1 = Format(Cons_Re("data_confirmacao"), "dd/mm/yyyy")
            End If
            ConsRes2.Grid1.Col = 5
            If Cons_Re("locado") = True Then
             ConsRes2.Grid1 = "SIM"
            Else
             ConsRes2.Grid1 = "NÃO"
            End If
            ConsRes2.Grid1.Col = 6
            ConsRes2.Grid1 = Format(Cons_Re("cod_cd"), ">")
            ConsRes2.Grid1.Col = 7
            ConsRes2.Grid1 = Cons_Re("fone-01")
            ConsRes2.Grid1.Col = 8
            ConsRes2.Grid1 = Cons_Re("fone-02")
            ConsRes2.Grid1.Col = 9
            ConsRes2.Grid1 = Format(Cons_Re("cod_titulo"), "000000")
           
            X = X + 1
            If X > 9 Then
               ConsRes2.Grid1.Rows = ConsRes2.Grid1.Rows + 1
            End If
         End If
         Cons_Re.MoveNext
        Loop
    Case Is = "Por Nome"
        Do While Not Cons_Re.EOF
            If Cons_Re("Nomecliente") = ConsRes3.DBC_Nome.BoundText Then
               ConsRes2.Grid1.Row = X
               ConsRes2.Grid1.Col = 0
               ConsRes2.Grid1 = Format(Cons_Re("Cod_Cliente"), "000000")
               ConsRes2.Grid1.Col = 1
               ConsRes2.Grid1 = Cons_Re("Nomecliente")
               ConsRes2.Grid1.Col = 2
               ConsRes2.Grid1 = Cons_Re("titulo")
               ConsRes2.Grid1.Col = 3
               If Not IsNull(Cons_Re("data_reserva")) Then
                  ConsRes2.Grid1 = Format(Cons_Re("data_reserva"), "dd/mm/yyyy")
               End If
               ConsRes2.Grid1.Col = 4
               If Not IsNull(Cons_Re("data_confirmacao")) Then
                  ConsRes2.Grid1 = Format(Cons_Re("data_confirmacao"), "dd/mm/yyyy")
               End If
               ConsRes2.Grid1.Col = 5
               If Cons_Re("locado") = True Then
                  ConsRes2.Grid1 = "SIM"
               Else
                  ConsRes2.Grid1 = "NÃO"
               End If
               ConsRes2.Grid1.Col = 6
               ConsRes2.Grid1 = Format(Cons_Re("cod_cd"), ">")
               ConsRes2.Grid1.Col = 7
               ConsRes2.Grid1 = Cons_Re("fone-01")
               ConsRes2.Grid1.Col = 8
               ConsRes2.Grid1 = Cons_Re("fone-02")
               ConsRes2.Grid1.Col = 9
               ConsRes2.Grid1 = Format(Cons_Re("cod_titulo"), "000000")
             
               X = X + 1
               If X > 9 Then
                  ConsRes2.Grid1.Rows = ConsRes2.Grid1.Rows + 1
               End If
            End If
            Cons_Re.MoveNext
        Loop
        Case Is = "Reservas Confirmadas"
        Do While Not Cons_Re.EOF
            'databanco = Format(Cons_Re("data_reserva"), "yyyy/mm/dd")
         If Not IsNull(Cons_Re("data_confirmacao")) Then
            ConsRes2.Grid1.Row = X
            ConsRes2.Grid1.Col = 0
            ConsRes2.Grid1 = Format(Cons_Re("Cod_Cliente"), "000000")
            ConsRes2.Grid1.Col = 1
            ConsRes2.Grid1 = Cons_Re("Nomecliente")
            ConsRes2.Grid1.Col = 2
            ConsRes2.Grid1 = Cons_Re("titulo")
            ConsRes2.Grid1.Col = 3
            If Not IsNull(Cons_Re("data_reserva")) Then
               ConsRes2.Grid1 = Format(Cons_Re("data_reserva"), "dd/mm/yyyy")
            End If
            ConsRes2.Grid1.Col = 4
            If Not IsNull(Cons_Re("data_confirmacao")) Then
               ConsRes2.Grid1 = Format(Cons_Re("data_confirmacao"), "dd/mm/yyyy")
            End If
            ConsRes2.Grid1.Col = 5
            If Cons_Re("locado") = True Then
             ConsRes2.Grid1 = "SIM"
            Else
             ConsRes2.Grid1 = "NÃO"
            End If
            ConsRes2.Grid1.Col = 6
            ConsRes2.Grid1 = Format(Cons_Re("cod_cd"), ">")
            ConsRes2.Grid1.Col = 7
            ConsRes2.Grid1 = Cons_Re("fone-01")
            ConsRes2.Grid1.Col = 8
            ConsRes2.Grid1 = Cons_Re("fone-02")
            ConsRes2.Grid1.Col = 9
            ConsRes2.Grid1 = Format(Cons_Re("cod_titulo"), "000000")
             
            X = X + 1
            If X > 9 Then
               ConsRes2.Grid1.Rows = ConsRes2.Grid1.Rows + 1
            End If
         End If
         Cons_Re.MoveNext
        Loop
        Case Is = "Reservas NÃO Confirmadas"
        Do While Not Cons_Re.EOF
            'databanco = Format(Cons_Re("data_reserva"), "yyyy/mm/dd")
         If IsNull(Cons_Re("data_confirmacao")) Then
            ConsRes2.Grid1.Row = X
            ConsRes2.Grid1.Col = 0
            ConsRes2.Grid1 = Format(Cons_Re("Cod_Cliente"), "000000")
            ConsRes2.Grid1.Col = 1
            ConsRes2.Grid1 = Cons_Re("Nomecliente")
            ConsRes2.Grid1.Col = 2
            ConsRes2.Grid1 = Cons_Re("titulo")
            ConsRes2.Grid1.Col = 3
            If Not IsNull(Cons_Re("data_reserva")) Then
               ConsRes2.Grid1 = Format(Cons_Re("data_reserva"), "dd/mm/yyyy")
            End If
            ConsRes2.Grid1.Col = 4
            If Not IsNull(Cons_Re("data_confirmacao")) Then
               ConsRes2.Grid1 = Format(Cons_Re("data_confirmacao"), "dd/mm/yyyy")
            End If
            ConsRes2.Grid1.Col = 5
            If Cons_Re("locado") = True Then
             ConsRes2.Grid1 = "SIM"
            Else
             ConsRes2.Grid1 = "NÃO"
            End If
            ConsRes2.Grid1.Col = 6
            ConsRes2.Grid1 = Format(Cons_Re("cod_cd"), ">")
            ConsRes2.Grid1.Col = 7
            ConsRes2.Grid1 = Cons_Re("fone-01")
            ConsRes2.Grid1.Col = 8
            ConsRes2.Grid1 = Cons_Re("fone-02")
            ConsRes2.Grid1.Col = 9
            ConsRes2.Grid1 = Format(Cons_Re("cod_titulo"), "000000")
            
            X = X + 1
            If X > 9 Then
               ConsRes2.Grid1.Rows = ConsRes2.Grid1.Rows + 1
            End If
         End If
         Cons_Re.MoveNext
        Loop
    End Select
End Sub

Private Sub Form_Load()

   Formu1 = "V"
  
  ' Left = 0
  ' Top = 0
   Grid1.ColWidth(0) = 800
   Grid1.ColWidth(1) = 2670
   Grid1.ColWidth(2) = 3200
   Grid1.ColWidth(3) = 1100
   Grid1.ColWidth(4) = 1100
   Grid1.ColWidth(5) = 800
   Grid1.ColWidth(6) = 900
   Grid1.ColWidth(7) = 960
   Grid1.ColWidth(8) = 960
   Grid1.ColWidth(9) = 800
   
   Grid1.Row = 0
   Grid1.Col = 0
   Grid1 = "Codigo"
   Grid1.Col = 1
   Grid1 = "         Nome do Cliente"
   Grid1.Col = 2
   Grid1 = "  Nome do Título    "
   Grid1.Col = 3
   Grid1 = " Data Reserva "
   Grid1.Col = 4
   Grid1 = " Data Conf. "
   Grid1.Col = 5
   Grid1 = " Locado"
   Grid1.Col = 6
   Grid1 = " Cod. CD "
   Grid1.Col = 7
   Grid1 = " Fone Res. "
   Grid1.Col = 8
   Grid1 = " Fone Com. "
   Grid1.Col = 9
   Grid1 = "Cod.Tit."
   Grid1.SelStartCol = 0
   Grid1.SelEndCol = 9


   
End Sub

Private Sub Grid1_DblClick()
    Grid1.Col = 0
    ReservCD.TxtCodCli_Res = Grid1.Text
    Grid1.Col = 1
    ReservCD.TxtNomCli_Res = Grid1.Text
    Grid1.Col = 2
    ReservCD.TxtNomT_Res = Grid1.Text
    Grid1.Col = 3
    ReservCD.MskDtaRes_Res = Grid1.Text
    Grid1.Col = 9
    ReservCD.TxtCodT_Res = Grid1.Text
    Unload Me
    ReservCD.TxtCodT_Res.SetFocus
    ReservCD.MskDtaRes_Res.SetFocus
End Sub

Private Sub SSCommand1_Click()
   Unload Me
End Sub


