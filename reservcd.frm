VERSION 5.00
Object = "{C932BA88-4374-101B-A56C-00AA003668DC}#1.1#0"; "MSMASK32.OCX"
Object = "{0BA686C6-F7D3-101A-993E-0000C0EF6F5E}#1.0#0"; "THREED32.OCX"
Begin VB.Form ReservCD 
   Caption         =   "Reserva CD'S"
   ClientHeight    =   6540
   ClientLeft      =   555
   ClientTop       =   810
   ClientWidth     =   9480
   ControlBox      =   0   'False
   Icon            =   "reservcd.frx":0000
   LinkTopic       =   "Form1"
   MDIChild        =   -1  'True
   PaletteMode     =   1  'UseZOrder
   ScaleHeight     =   6540
   ScaleWidth      =   9480
   Begin Threed.SSFrame SSFrame2 
      Height          =   4485
      Left            =   120
      TabIndex        =   0
      Top             =   2025
      Width           =   9360
      _Version        =   65536
      _ExtentX        =   16510
      _ExtentY        =   7911
      _StockProps     =   14
      Caption         =   "Escolha o Título Para Fazer a Reserva"
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
      Begin VB.ListBox LstRet_Res 
         ForeColor       =   &H000000FF&
         Height          =   840
         Left            =   180
         TabIndex        =   36
         Tag             =   "DBTTip:Lista dos Provavéis RETORNO dos Títulos que o Cliente Reservou."
         Top             =   2490
         Width           =   5760
      End
      Begin VB.ListBox LstTit_Res 
         Height          =   1035
         Left            =   1200
         TabIndex        =   2
         Tag             =   "DBTTip:Lista dos Títulos Pesquisados"
         Top             =   960
         Width           =   4275
      End
      Begin Threed.SSPanel SSPanel4 
         Height          =   345
         Left            =   180
         TabIndex        =   3
         Top             =   510
         Width           =   885
         _Version        =   65536
         _ExtentX        =   1561
         _ExtentY        =   609
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
         Begin VB.TextBox TxtCodT_Res 
            Appearance      =   0  'Flat
            Height          =   315
            Left            =   15
            MaxLength       =   6
            TabIndex        =   4
            Tag             =   "DBTTip:Código Título"
            Top             =   15
            Width           =   855
         End
      End
      Begin Threed.SSPanel SSPanel7 
         Height          =   345
         Left            =   1200
         TabIndex        =   5
         Top             =   510
         Width           =   4290
         _Version        =   65536
         _ExtentX        =   7557
         _ExtentY        =   614
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
         Begin VB.TextBox TxtNomT_Res 
            Appearance      =   0  'Flat
            Height          =   315
            Left            =   15
            MaxLength       =   50
            TabIndex        =   6
            Tag             =   "DBTTip:Use F10 para fazer a pesquisa do Título por Nome ou Partícula do nome"
            Top             =   15
            Width           =   4260
         End
      End
      Begin Threed.SSPanel SSPanel5 
         Height          =   345
         Left            =   5910
         TabIndex        =   7
         Top             =   495
         Width           =   2895
         _Version        =   65536
         _ExtentX        =   5106
         _ExtentY        =   609
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
         Begin VB.TextBox TxtInt_Res 
            Appearance      =   0  'Flat
            Height          =   315
            Left            =   15
            MaxLength       =   50
            TabIndex        =   8
            Tag             =   "DBTTip:Nome do Intérprete"
            Top             =   15
            Width           =   2865
         End
      End
      Begin Threed.SSPanel SSPanel8 
         Height          =   345
         Left            =   5925
         TabIndex        =   9
         Top             =   1155
         Width           =   2925
         _Version        =   65536
         _ExtentX        =   5159
         _ExtentY        =   609
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
         Begin VB.TextBox TxtGrp_Res 
            Appearance      =   0  'Flat
            Height          =   315
            Left            =   15
            MaxLength       =   50
            TabIndex        =   10
            Tag             =   "DBTTip:Nome do Grupo Musical"
            Top             =   15
            Width           =   2895
         End
      End
      Begin Threed.SSPanel SSPanel9 
         Height          =   345
         Left            =   5940
         TabIndex        =   11
         Top             =   1815
         Width           =   2955
         _Version        =   65536
         _ExtentX        =   5212
         _ExtentY        =   609
         _StockProps     =   15
         Caption         =   "SSPanel1"
         BackColor       =   12632256
         BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
            Name            =   "MS Sans Serif"
            Size            =   8.26
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         BevelOuter      =   1
         Autosize        =   3
         Begin VB.TextBox TxtEst_Res 
            Appearance      =   0  'Flat
            Height          =   315
            Left            =   15
            MaxLength       =   50
            TabIndex        =   12
            Tag             =   "DBTTip:Nome do Estilo Musical do Título"
            Top             =   15
            Width           =   2925
         End
      End
      Begin Threed.SSFrame SSFrame11 
         Height          =   720
         Left            =   195
         TabIndex        =   25
         Top             =   3630
         Width           =   8430
         _Version        =   65536
         _ExtentX        =   14870
         _ExtentY        =   1270
         _StockProps     =   14
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
         Begin Threed.SSPanel SSPanel23 
            Height          =   495
            Left            =   465
            TabIndex        =   26
            Top             =   165
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
            Begin Threed.SSCommand SSCmdGrava_Res 
               Height          =   465
               Left            =   15
               TabIndex        =   27
               Tag             =   "DBTTip:Grava a Reserva"
               Top             =   15
               Width           =   705
               _Version        =   65536
               _ExtentX        =   1244
               _ExtentY        =   820
               _StockProps     =   78
               Picture         =   "reservcd.frx":0442
            End
         End
         Begin Threed.SSPanel SSPanel24 
            Height          =   495
            Left            =   1575
            TabIndex        =   28
            Top             =   165
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
            Begin Threed.SSCommand SSCmdLimp_Res 
               Height          =   465
               Left            =   15
               TabIndex        =   29
               Tag             =   "DBTTip:Nova Reserva"
               Top             =   15
               Width           =   705
               _Version        =   65536
               _ExtentX        =   1244
               _ExtentY        =   820
               _StockProps     =   78
               Picture         =   "reservcd.frx":0554
            End
         End
         Begin Threed.SSPanel SSPanel25 
            Height          =   495
            Left            =   3885
            TabIndex        =   30
            Top             =   135
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
            Begin Threed.SSCommand SSCmdVer_Res 
               Height          =   465
               Left            =   15
               TabIndex        =   31
               Tag             =   "DBTTip:Consulta as Reservas no Vídeo"
               Top             =   15
               Width           =   705
               _Version        =   65536
               _ExtentX        =   1244
               _ExtentY        =   820
               _StockProps     =   78
               Picture         =   "reservcd.frx":0666
            End
         End
         Begin Threed.SSPanel SSPanel26 
            Height          =   495
            Left            =   5070
            TabIndex        =   32
            Top             =   150
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
            Begin Threed.SSCommand SSCmdImp_Res 
               Height          =   465
               Left            =   15
               TabIndex        =   33
               Tag             =   "DBTTip:Imprime as Reservas  "
               Top             =   15
               Width           =   705
               _Version        =   65536
               _ExtentX        =   1244
               _ExtentY        =   820
               _StockProps     =   78
               Picture         =   "reservcd.frx":0770
            End
         End
         Begin Threed.SSPanel SSPanel27 
            Height          =   495
            Left            =   7275
            TabIndex        =   34
            Top             =   150
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
            Begin Threed.SSCommand SSCmdSair_Res 
               Height          =   465
               Left            =   15
               TabIndex        =   35
               Tag             =   "DBTTip:Sair da Rotina "
               Top             =   15
               Width           =   705
               _Version        =   65536
               _ExtentX        =   1244
               _ExtentY        =   820
               _StockProps     =   78
               Picture         =   "reservcd.frx":0882
            End
         End
         Begin Threed.SSPanel SSPanel2 
            Height          =   495
            Left            =   2730
            TabIndex        =   41
            Top             =   150
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
            Begin Threed.SSCommand SSCmdExc_Res 
               Height          =   465
               Left            =   15
               TabIndex        =   42
               Tag             =   "DBTTip:Apaga a Reserva"
               Top             =   15
               Width           =   705
               _Version        =   65536
               _ExtentX        =   1244
               _ExtentY        =   820
               _StockProps     =   78
               Picture         =   "reservcd.frx":0D24
            End
         End
         Begin Threed.SSPanel SSPanel3 
            Height          =   495
            Left            =   6195
            TabIndex        =   43
            Top             =   150
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
            Begin Threed.SSCommand SSCmdDel_Res 
               Height          =   465
               Left            =   15
               TabIndex        =   44
               TabStop         =   0   'False
               Tag             =   "Deleta o Registro"
               Top             =   15
               Width           =   705
               _Version        =   65536
               _ExtentX        =   1244
               _ExtentY        =   820
               _StockProps     =   78
               ForeColor       =   0
               Picture         =   "reservcd.frx":1176
            End
         End
      End
      Begin Threed.SSFrame SSFrame1 
         Height          =   1065
         Left            =   6210
         TabIndex        =   38
         Top             =   2445
         Width           =   2400
         _Version        =   65536
         _ExtentX        =   4233
         _ExtentY        =   1879
         _StockProps     =   14
         Caption         =   "Data da Reserva"
         ForeColor       =   255
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
         Begin Threed.SSPanel SSPanel1 
            Height          =   345
            Left            =   600
            TabIndex        =   39
            Top             =   390
            Width           =   1230
            _Version        =   65536
            _ExtentX        =   2170
            _ExtentY        =   609
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
            Begin MSMask.MaskEdBox MskDtaRes_Res 
               Height          =   315
               Left            =   15
               TabIndex        =   40
               Tag             =   "DBTTip:Data da Reserva do Título "
               Top             =   15
               Width           =   1200
               _ExtentX        =   2117
               _ExtentY        =   556
               _Version        =   327681
               Appearance      =   0
               MaxLength       =   10
               Mask            =   "##/##/####"
               PromptChar      =   " "
            End
         End
      End
      Begin VB.Label Label2 
         AutoSize        =   -1  'True
         Caption         =   "Provável Retorno do Título"
         Height          =   195
         Left            =   165
         TabIndex        =   37
         Top             =   2250
         Width           =   1935
      End
      Begin VB.Label Label8 
         AutoSize        =   -1  'True
         Caption         =   "Estilo Musical"
         Height          =   195
         Left            =   5940
         TabIndex        =   17
         Top             =   1605
         Width           =   960
      End
      Begin VB.Label Label9 
         AutoSize        =   -1  'True
         Caption         =   "Grupo Musical"
         Height          =   195
         Left            =   5925
         TabIndex        =   16
         Top             =   915
         Width           =   1020
      End
      Begin VB.Label Label12 
         AutoSize        =   -1  'True
         Caption         =   "Descrição do Título"
         Height          =   195
         Left            =   1215
         TabIndex        =   15
         Top             =   285
         Width           =   1410
      End
      Begin VB.Label Label13 
         AutoSize        =   -1  'True
         Caption         =   "Código Tít."
         Height          =   195
         Left            =   180
         TabIndex        =   14
         Top             =   285
         Width           =   795
      End
      Begin VB.Label Label14 
         AutoSize        =   -1  'True
         Caption         =   "Intérprete"
         Height          =   195
         Left            =   5925
         TabIndex        =   13
         Top             =   300
         Width           =   675
      End
   End
   Begin Threed.SSFrame SSFrame7 
      Height          =   1860
      Left            =   135
      TabIndex        =   18
      Top             =   90
      Width           =   6120
      _Version        =   65536
      _ExtentX        =   10795
      _ExtentY        =   3281
      _StockProps     =   14
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
      Begin VB.ListBox LstCli_Res 
         Height          =   645
         Left            =   1155
         TabIndex        =   19
         Tag             =   "DBTTip:Lista dos Clientes Pesquisados"
         Top             =   825
         Width           =   4275
      End
      Begin Threed.SSPanel SSPanel17 
         Height          =   345
         Left            =   195
         TabIndex        =   20
         Top             =   405
         Width           =   885
         _Version        =   65536
         _ExtentX        =   1561
         _ExtentY        =   609
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
         Begin VB.TextBox TxtCodCli_Res 
            Appearance      =   0  'Flat
            Height          =   315
            Left            =   15
            MaxLength       =   6
            TabIndex        =   1
            Tag             =   "DBTTip:Código do Cliente"
            Top             =   15
            Width           =   855
         End
      End
      Begin Threed.SSPanel SSPanel18 
         Height          =   345
         Left            =   1140
         TabIndex        =   21
         Top             =   405
         Width           =   4290
         _Version        =   65536
         _ExtentX        =   7557
         _ExtentY        =   614
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
         Begin VB.TextBox TxtNomCli_Res 
            Appearance      =   0  'Flat
            Height          =   315
            Left            =   15
            MaxLength       =   50
            TabIndex        =   22
            Tag             =   "DBTTip:Nome do Cliente, Use F10 para fazer a pesquisa"
            Top             =   15
            Width           =   4260
         End
      End
      Begin VB.Label Label1 
         AutoSize        =   -1  'True
         Caption         =   "Cód. Cliente"
         Height          =   195
         Left            =   195
         TabIndex        =   24
         Top             =   195
         Width           =   855
      End
      Begin VB.Label Label15 
         AutoSize        =   -1  'True
         Caption         =   "Nome do Cliente"
         Height          =   195
         Left            =   1140
         TabIndex        =   23
         Top             =   180
         Width           =   1170
      End
   End
End
Attribute VB_Name = "ReservCD"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False

Private Sub dados_tit()
     'carrega os campos
     TxtCodT_Res.Text = Format(Wtitulo("cod_titulo"), "000000")
     TxtNomT_Res = Wtitulo("titulo")
     
    'Pesquisa o Grupo
     Wgrupo.Index = "primarykey"
     Wgrupo.Seek "=", Wtitulo("cod_grupo")
     TxtGrp_Res = Wgrupo("nome_grupo")
    ' cdgrupo_Res = Wtitulo("cod_grupo")
     
     'Pesquisa o estilo
     Westilo.Index = "cod_estilo"
     Westilo.Seek "=", Wtitulo("cod_estilo")
     TxtEst_Res = Westilo("nome_estilo")
     'cdestilo_Res = Wtitulo("cod_estilo")
   
     'Pesquisa o interprete no relacionamento titulo-interprete
     wtinterprete.Index = "cod_titulo"
     wtinterprete.Seek "=", Wtitulo("cod_titulo")
     
     'Pesquisa o interprete na tabela interprete
     Winterprete.Index = "cod_interprete"
     Winterprete.Seek "=", wtinterprete("cod_interprete")
     TxtInt_Res = Winterprete("interprete")
     'cdinterp_Res = wtinterprete("cod_interprete")
     
     quantidade = Format(Wtitulo("qtde_disp"), "00")
     If quantidade <> 0 Then
        If quantidade > 1 Then
           MsgBox "Existem " + Str(quantidade) + " CÓPIAS no ACERVO", 64
        Else
           MsgBox "Existe " + Str(quantidade) + " CÓPIA no ACERVO", 64
        End If
        'Limpa as veriáveis e retorna
        TxtCodT_Res = ""
        TxtNomT_Res = ""
        TxtGrp_Res = ""
        TxtInt_Res = ""
        TxtEst_Res = ""
        LstTit_Res.Clear
        LstRet_Res.Clear
        MskDtaRes_Res.Mask = ""
        MskDtaRes_Res.Text = ""
        MskDtaRes_Res.Mask = "##/##/####"
        TxtCodT_Res.SetFocus
        Exit Sub
     End If

     'Pesquisa na tabela locação a provavel data de retorno do título
     Wlocacao.Index = "cod_titulo"
     Wlocacao.MoveFirst
     Wlocacao.Seek "=", TxtCodT_Res
     Do While Not Wlocacao.EOF And Format(Wlocacao("cod_titulo"), "000000") = TxtCodT_Res
        data_devol = Format(Wlocacao("data_devolucao"), "dd/mm/yyyy")
        num_dias = DateDiff("d", Now, data_devol)
        If num_dias >= 0 Then
           If num_dias = 0 Then
              nome_dias = "  Hoje"
           Else
              If num_dias = 1 Then
                 nome_dias = "  Dia"
              Else
                 nome_dias = "  Dias"
              End If
           End If
           LstRet_Res.AddItem "Cliente => " & Format(Wlocacao("cod_cliente"), "000000") & "  -  Código CD => " & Format(Wlocacao("cod_cd"), ">") & "  -  " & Format(Wlocacao("data_devolucao"), "dd/mm/yyyy") & " ==> " & num_dias & nome_dias
        End If
        Wlocacao.MoveNext
        If Wlocacao.EOF Then
           Exit Do
        End If
     Loop
     
     MskDtaRes_Res.SetFocus
End Sub

Private Sub limpa_reserva()
       'Procedure que limpa a Reserva
       TxtCodT_Res = ""
       TxtNomT_Res = ""
       TxtGrp_Res = ""
       TxtInt_Res = ""
       TxtEst_Res = ""
       LstTit_Res.Clear
       LstRet_Res.Clear
       LstCli_Res.Clear
       MskDtaRes_Res.Mask = ""
       MskDtaRes_Res.Text = ""
       MskDtaRes_Res.Mask = "##/##/####"
       TxtCodCli_Res = ""
       TxtNomCli_Res = ""
       TxtCodCli_Res.Enabled = True
       TxtCodCli_Res.SetFocus
End Sub


Private Sub pesquisa_cliente()
     Msg = "Digite o Nome/Sobrenome a ser Pesquisado"
     tit = "CD'S Loc - Pesquisa Cliente"
     Pesq_Nome = InputBox(Msg, tit)
     'inicio da rotina para escolha de um cliente
     If Pesq_Nome <> "" Then
        LstCli_Res.Clear
        wclien.MoveFirst
        While Not wclien.EOF
          ' Pesquisa Cliente
          pesquisa = InStr(wclien!nomecliente, UCase(Pesq_Nome)) ' Maiúsculas
          pesquisa2 = InStr(wclien!nomecliente, Pesq_Nome) ' Minúsculas
          If pesquisa <> 0 Or pesquisa2 <> 0 Then
             LstCli_Res.AddItem wclien("nomecliente")
          End If
          wclien.MoveNext
        Wend
     End If
End Sub


Private Sub pesquisa_titulo()
     Msg = "Digite o Nome do Título a ser Pesquisado"
     tit = "CD'S Loc - Pesquisa Título"
     Pesq_Tit = InputBox(Msg, tit)
     'inicio da rotina para escolha de um cliente
     If Pesq_Tit <> "" Then
        LstTit_Res.Clear
        Wtitulo.MoveFirst
        While Not Wtitulo.EOF
          ' Pesquisa Cliente
          pesquisa = InStr(Wtitulo!titulo, UCase(Pesq_Tit)) ' Maiúsculas
          pesquisa2 = InStr(Wtitulo!titulo, Pesq_Tit) ' Minúsculas
          If pesquisa <> 0 Or pesquisa2 <> 0 Then
             LstTit_Res.AddItem Wtitulo("titulo")
          End If
          Wtitulo.MoveNext
        Wend
     End If
End Sub

Private Sub Form_Load()
   With ReservCD
      .Left = 1260
      .Height = 7065
      .Width = 9750
      .Top = 390
   End With
End Sub

Private Sub LstCli_Res_Click()
   'Pesquisa o nome cliente na tabela
    TxtNomCli_Res = LstCli_Res
    wclien.Index = "nomecliente"
    wclien.MoveFirst
    wclien.Seek "=", LstCli_Res

    If wclien.NoMatch Then
       ' Cliente Não Cadastrado
       msgI = "Inclusão"
       Atualiza = "Não"
    Else
       TxtCodCli_Res = Format(wclien("codcliente"), "000000")
       Msg = MsgBox("Voçê selecionou o Cliente ? " + TxtCodCli_Res + "  " + LstCli_Res.Text, 36)
       
       If Msg = 7 Then 'Resposta = Não
          TxtNomCli_Res = ""
          TxtCodCli_Res.Enabled = True
          TxtCodCli_Res = ""
          Exit Sub
       End If

       If wclien("cancelado") = True Then
          MsgBox "O Cliente está CANCELADO", 16, "Atenção"
          TxtNomCli_Res = ""
          TxtCodCli_Res = ""
          TxtCodCli_Res.Enabled = True
          TxtNomCli_Res.SetFocus
          Exit Sub
       End If
       TxtCodT_Res.SetFocus
    End If
End Sub


Private Sub LstTit_Res_Click()
    TxtNomT_Res = LstTit_Res
    Wtitulo.Index = "titulo"
    Wtitulo.MoveFirst
    Wtitulo.Seek "=", LstTit_Res.Text
    If Wtitulo.NoMatch Then
       ' Cliente Não Cadastrado
       msgI = "Inclusão"
       mensagem = "Incluir"
    Else
       mensagem = "Alterar"
       TxtCodT_Res = Wtitulo("cod_titulo")
       Msg = MsgBox("Voçê selecionou o Título ? " + TxtCodT_Res + "  " + LstTit_Res.Text, 36)
       If Msg = 7 Then 'Resposta = Não
          TxtNomT_Res = ""
          TxtCodT_Res = ""
          Exit Sub
       End If
       'Chama a Procedure para preencher os campos
       dados_tit
    End If
End Sub

Private Sub MskDtaRes_Res_KeyPress(KeyAscii As Integer)
    If KeyAscii = 13 Then
       SSCmdGrava_Res.SetFocus
    End If
End Sub

Private Sub MskDtaRes_Res_LostFocus()
   If Wreserva.RecordCount <> 0 Then
      'Verifica se já foi Registrado a Reserva
      Wreserva.Index = "cod_titulo"
      Wreserva.MoveFirst
      Wreserva.Seek "=", TxtCodT_Res
      
      If Not Wreserva.NoMatch Then
         Do While Format(Wreserva("cod_titulo"), "000000") = TxtCodT_Res And Not Wreserva.EOF
            If Format(Wreserva("data_reserva"), "dd/mm/yyyy") = Format(MskDtaRes_Res, "dd/mm/yyyy") Then
               Msg = "Existe uma Reserva para este Título, Deseja Vê-la ?"
               ' Define message.
               Style = vbYesNo + vbQuestion + vbDefaultButton1 ' Define buttons.
               Title = "CD'S Loc - Atenção !!"  ' Define title.
               Help = "DEMO.HLP"   ' Define Help file.
               Ctxt = 1000 ' Define topic
                           ' context.
               ' Display message.
               resposta = MsgBox(Msg, Style, Title, Help, Ctxt)
               If resposta = vbYes Then    ' User chose Yes.
                  wclien.Index = "primarykey"
                  wclien.MoveFirst
                  wclien.Seek "=", Wreserva("cod_cliente")
                  If Not Wreserva.NoMatch Then
                     dia = Format(Wreserva("data_reserva"), "dddddd")
                     nome_cli = wclien("nomecliente")
                     'Chama o Formulário da Consulta de Reserva
                     MsgBox "Reserva para  " & nome_cli & ", " & dia, 32
                     MskDtaRes_Res.SetFocus
                  End If
               End If
            End If
            Wreserva.MoveNext
            If Wreserva.EOF Then
               Exit Do
            End If
         Loop
      End If
   End If
End Sub


Private Sub SSCmdDel_Res_Click()
     On Error GoTo ErrorHandler  ' Enable error-handling routine.
     Set Apag_Re = wbanco.CreateDynaset("Apaga Reserva")
     If Apag_Re.RecordCount <> 0 Then
        Apag_Re.MoveLast
        Msg = "Serão APAGADAS " & Apag_Re.RecordCount & " Reservas já LOCADAS, Confirma ?"
        Style = vbYesNo + vbInformation + vbDefaultButton1 ' Define buttons.
        Title = "CD'S Loc - Atenção!!"  ' Define title.
        Help = "DEMO.HLP"   ' Define Help file.
        Ctxt = 1000 ' Define topic
                ' context.
        ' Display message.
        resposta = MsgBox(Msg, Style, Title, Help, Ctxt)
        If resposta = vbNo Then    ' User chose Yes.
           'Posiciona no código
           TxtCodCli_Res.SetFocus
        Else
           Apag_Re.MoveFirst
           Do While Not Apag_Re.EOF
             Apag_Re.Delete
             Apag_Re.MoveNext
           Loop
        End If
     Else
        MsgBox "Não Existem Reservas LOCADAS para APAGAR", vbInformation
     End If
ErrorHandler: ' Error-handling routine.
    Select Case Err.Number  ' Evaluate error number.
        Case 3200 ' "Erro de Integridade referencial" error.
             msg2 = "Voçê não pode EXCLUIR este registro !"  ' Define message.
             estilo = vbYes + vbCritical + vbDefaultButton1
             titulo = "CD'S Loc - Atenção !"
             res = MsgBox(msg2, estilo, titulo)
        Case Is <> 0 ' Else
            ' Handle other situations here...
            MsgBox "Ocorreu Erro No. " & Err.Number & " na Exclusão, ligue p/Sandoval", 48
    End Select
    TxtCodCli_Res.Enabled = True
    TxtCodCli_Res.SetFocus
    Exit Sub
    Resume  ' Resume execution at same line
                ' that caused the error.



    
End Sub

Private Sub SSCmdExc_Res_Click()
    On Error GoTo ErrorHandler  ' Enable error-handling routine.
    Msg = "Deseja realmente Excluir ?"  ' Define message.
    Style = vbYesNo + vbCritical + vbDefaultButton1 ' Define buttons.
    Title = "CD'S Loc - Cuidado!!"  ' Define title.
    Help = "DEMO.HLP"   ' Define Help file.
    Ctxt = 1000 ' Define topic
                ' context.
    ' Display message.
    resposta = MsgBox(Msg, Style, Title, Help, Ctxt)
    If resposta = vbNo Then    ' User chose Yes.
       'Posiciona no código
       TxtCodT_Res.SetFocus
    Else
       If Wreserva.RecordCount <> 0 Then
          Wreserva.Index = "primarykey"
          Wreserva.MoveFirst
          Wreserva.Seek "=", TxtCodT_Res, TxtCodCli_Res, MskDtaRes_Res
      
          If Not Wreserva.NoMatch Then
             'Apaga registro do Banco de Dados
             Wreserva.Delete
          Else
             MsgBox "SELECIONE registro para EXCLUIR", 32
          End If
       Else
          MsgBox "Não existe registro para EXCLUIR", 32
       End If
    End If
    'Chama a Procedure que Limpa
    limpa_reserva
ErrorHandler: ' Error-handling routine.
    Select Case Err.Number  ' Evaluate error number.
        Case 3200 ' "Erro de Integridade referencial" error.
             msg2 = "Voçê não pode EXCLUIR este registro !"  ' Define message.
             estilo = vbYes + vbCritical + vbDefaultButton1
             titulo = "CD'S Loc - Atenção !"
             res = MsgBox(msg2, estilo, titulo)
        Case Is <> 0 ' Else
            ' Handle other situations here...
            MsgBox "Ocorreu Erro No. " & Err.Number & " na Exclusão, ligue p/Sandoval", 48
    End Select
    TxtCodT_Res.SetFocus
    Exit Sub
    Resume  ' Resume execution at same line
                ' that caused the error.
End Sub

Private Sub SSCmdGrava_Res_Click()
    If TxtCodCli_Res = "" Or TxtCodT_Res = "" Or MskDtaRes_Res = "" Then
       MsgBox "Campo obrigatório não preenchido", 16
       TxtCodT_Res.SetFocus
       Exit Sub
    Else
       If Wreserva.RecordCount <> 0 Then
          'Verifica se já foi Registrado a Reserva
          Wreserva.Index = "primarykey"
          Wreserva.MoveFirst
          Wreserva.Seek "=", TxtCodT_Res, TxtCodCli_Res, MskDtaRes_Res
          If Wreserva.NoMatch Then
             'Grava a Reserva
             Wreserva.AddNew
             Wreserva("cod_titulo") = TxtCodT_Res
             Wreserva("cod_cliente") = TxtCodCli_Res
             Wreserva("data_reserva") = MskDtaRes_Res
             Wreserva.Update
       
             MsgBox "Gravação com Sucesso ", 32
          Else
             MsgBox "Esta Reserva Já Foi Feita", 64
          End If
       Else
          'Grava a Reserva
          Wreserva.AddNew
          Wreserva("cod_titulo") = TxtCodT_Res
          Wreserva("cod_cliente") = TxtCodCli_Res
          Wreserva("data_reserva") = MskDtaRes_Res
          Wreserva.Update
       
          MsgBox "Gravação com Sucesso ", 32
       End If
       'Limpa as variáveis e retorna
       TxtCodT_Res = ""
       TxtNomT_Res = ""
       TxtGrp_Res = ""
       TxtInt_Res = ""
       TxtEst_Res = ""
       LstTit_Res.Clear
       LstRet_Res.Clear
       MskDtaRes_Res.Mask = ""
       MskDtaRes_Res.Text = ""
       MskDtaRes_Res.Mask = "##/##/####"
       TxtCodT_Res.SetFocus
    End If
End Sub

Private Sub SSCmdImp_Res_Click()
    MsgBox "Rotina não Implementada", 32
End Sub

Private Sub SSCmdLimp_Res_Click()
    'Chama a Procedure que limpa a reserva
    limpa_reserva
End Sub

Private Sub SSCmdSair_Res_Click()
   ReservCD.Hide
End Sub


Private Sub SSCmdVer_Res_Click()
   VConre = "Consulta"
   ConsRes3.Show vbModal
End Sub




Private Sub TxtCodCli_Res_KeyPress(KeyAscii As Integer)
    If KeyAscii = 13 Then
       TxtNomCli_Res.SetFocus
    End If
End Sub

Private Sub TxtCodCli_Res_LostFocus()
    If TxtCodCli_Res <> "" Then
       'Desabilita o campo cod_cliente para não incluir outro enquanto não gravar
       TxtCodCli_Res.Enabled = False
       If Not IsNumeric(TxtCodCli_Res) Then
          MsgBox "Use Apenas Numeros", 64
          TxtCodCli_Res.Enabled = True
          TxtCodCli_Res.SetFocus
          Exit Sub
       End If
       wclien.Index = "primarykey"
       wclien.MoveFirst
       wclien.Seek "=", TxtCodCli_Res
       If wclien.NoMatch Then
          MsgBox "Este Cliente não Existe, Tente Outro", 32
          TxtCodCli_Res.Enabled = True
          TxtCodCli_Res.SetFocus
          Exit Sub
       Else
          TxtCodCli_Res = Format(wclien("codcliente"), "000000")
          TxtNomCli_Res = wclien("nomecliente")
          If wclien("cancelado") = True Then
             MsgBox "O Cliente está CANCELADO", 16, "Atenção"
             TxtCodCli_Res = ""
             TxtNomCli_Res = ""
             TxtCodCli_Res.Enabled = True
             TxtCodCli_Res.SetFocus
             Exit Sub
          End If
          TxtCodT_Res.SetFocus
       End If
    End If
End Sub


Private Sub TxtCodT_Res_KeyPress(KeyAscii As Integer)
    If KeyAscii = 13 Then
       TxtNomT_Res.SetFocus
    End If
End Sub

Private Sub TxtCodT_Res_LostFocus()
    If TxtCodT_Res <> "" Then
       TxtCodT_Res = Format(TxtCodT_Res, "000000")
       If Not IsNumeric(TxtCodT_Res) Then
          MsgBox "Só é permitido o uso de Números", 64
          TxtCodT_Res.SetFocus
          Exit Sub
       End If
       gravou = "Não"
       Wtitulo.Index = "primarykey"
       Wtitulo.MoveFirst  ' Posiciona no inicio da tabela
       'Busca registro
       Wtitulo.Seek "=", TxtCodT_Res.Text
       If Wtitulo.NoMatch Then
          MsgBox "Título Inexistente, Tente Outro", 32
          TxtCodT_Res.SetFocus
          Exit Sub
       End If
       'Chama a procedure que preenche os dados.
       dados_tit
    End If
End Sub


Private Sub TxtNomCli_Res_KeyDown(KeyCode As Integer, Shift As Integer)
   If KeyCode = vbKeyF10 Then
       pesquisa_cliente
   End If
End Sub

Private Sub TxtNomCli_Res_KeyPress(KeyAscii As Integer)
   If KeyCode <> vbKeyF10 Then
      If KeyAscii = 13 Then
         TxtCodT_Res.SetFocus
      End If
   End If
   
End Sub


Private Sub txtnomt_res_KeyDown(KeyCode As Integer, Shift As Integer)
   If KeyCode = vbKeyF10 Then
       tit_mus = "Sim"
       pesquisa_titulo
    End If
End Sub

Private Sub txtnomt_res_KeyPress(KeyAscii As Integer)
    If KeyCode <> vbKeyF10 Then
      If KeyAscii = 13 Then
         MskDtaRes_Res.SetFocus
      End If
   End If
End Sub


