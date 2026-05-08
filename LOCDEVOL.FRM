VERSION 5.00
Object = "{C932BA88-4374-101B-A56C-00AA003668DC}#1.1#0"; "MSMASK32.OCX"
Object = "{0BA686C6-F7D3-101A-993E-0000C0EF6F5E}#1.0#0"; "THREED32.OCX"
Object = "{BDC217C8-ED16-11CD-956C-0000C04E4C0A}#1.1#0"; "TABCTL32.OCX"
Object = "{FAEEE763-117E-101B-8933-08002B2F4F5A}#1.1#0"; "DBLIST32.OCX"
Begin VB.Form LocDevol 
   Caption         =   "Locação, Devolução e Recibos"
   ClientHeight    =   6480
   ClientLeft      =   45
   ClientTop       =   390
   ClientWidth     =   9510
   ControlBox      =   0   'False
   Icon            =   "LOCDEVOL.frx":0000
   LinkTopic       =   "Form1"
   LockControls    =   -1  'True
   MDIChild        =   -1  'True
   PaletteMode     =   1  'UseZOrder
   ScaleHeight     =   6480
   ScaleWidth      =   9510
   Begin TabDlg.SSTab SSTab1 
      Height          =   6480
      Left            =   0
      TabIndex        =   0
      Top             =   15
      Width           =   9555
      _ExtentX        =   16854
      _ExtentY        =   11430
      _Version        =   393216
      Tab             =   1
      TabHeight       =   529
      ForeColor       =   16711680
      TabCaption(0)   =   "Locação"
      Tab(0).ControlEnabled=   0   'False
      Tab(0).Control(0)=   "SSFrame6"
      Tab(0).Control(0).Enabled=   0   'False
      Tab(0).Control(1)=   "SSFrame5"
      Tab(0).Control(1).Enabled=   0   'False
      Tab(0).Control(2)=   "SSFrame2"
      Tab(0).Control(2).Enabled=   0   'False
      Tab(0).Control(3)=   "SSFrame4"
      Tab(0).Control(3).Enabled=   0   'False
      Tab(0).Control(4)=   "LstImprime_Loc"
      Tab(0).Control(4).Enabled=   0   'False
      Tab(0).ControlCount=   5
      TabCaption(1)   =   "Devolução"
      Tab(1).ControlEnabled=   -1  'True
      Tab(1).Control(0)=   "SSFrame11"
      Tab(1).Control(0).Enabled=   0   'False
      Tab(1).Control(1)=   "SSFrame10"
      Tab(1).Control(1).Enabled=   0   'False
      Tab(1).Control(2)=   "SSFrame9"
      Tab(1).Control(2).Enabled=   0   'False
      Tab(1).Control(3)=   "SSFrame7"
      Tab(1).Control(3).Enabled=   0   'False
      Tab(1).ControlCount=   4
      TabCaption(2)   =   "Recibo"
      Tab(2).ControlEnabled=   0   'False
      Tab(2).Control(0)=   "SSFrame12"
      Tab(2).Control(1)=   "SSFrame13"
      Tab(2).Control(2)=   "Data_Recibo"
      Tab(2).ControlCount=   3
      Begin VB.Data Data_Recibo 
         Caption         =   "Data_Recibo"
         Connect         =   "Access"
         DatabaseName    =   ""
         DefaultCursorType=   0  'DefaultCursor
         DefaultType     =   2  'UseODBC
         Exclusive       =   0   'False
         Height          =   300
         Left            =   -74865
         Options         =   0
         ReadOnly        =   0   'False
         RecordsetType   =   2  'Snapshot
         RecordSource    =   "select * from recibo where devolvido = false"
         Top             =   5070
         Visible         =   0   'False
         Width           =   2340
      End
      Begin VB.ListBox LstImprime_Loc 
         Height          =   645
         Left            =   -68175
         TabIndex        =   55
         Top             =   5115
         Visible         =   0   'False
         Width           =   2370
      End
      Begin Threed.SSFrame SSFrame4 
         Height          =   945
         Left            =   -72870
         TabIndex        =   1
         Top             =   5115
         Width           =   4560
         _Version        =   65536
         _ExtentX        =   8043
         _ExtentY        =   1667
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
         Begin Threed.SSPanel SSPanel1 
            Height          =   495
            Left            =   120
            TabIndex        =   2
            Top             =   240
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
            Begin Threed.SSCommand SSCmdGrava_Loc 
               Height          =   465
               Left            =   15
               TabIndex        =   3
               Tag             =   "DBTTip:Grava a Locação"
               Top             =   15
               Width           =   705
               _Version        =   65536
               _ExtentX        =   1244
               _ExtentY        =   820
               _StockProps     =   78
               Picture         =   "LOCDEVOL.frx":0442
            End
         End
         Begin Threed.SSPanel SSPanel10 
            Height          =   495
            Left            =   990
            TabIndex        =   4
            Top             =   240
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
               TabIndex        =   5
               Tag             =   "DBTTip:Nova Locação"
               Top             =   15
               Width           =   705
               _Version        =   65536
               _ExtentX        =   1244
               _ExtentY        =   820
               _StockProps     =   78
               Picture         =   "LOCDEVOL.frx":0554
            End
         End
         Begin Threed.SSPanel SSPanel11 
            Height          =   495
            Left            =   1890
            TabIndex        =   6
            Top             =   225
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
            Begin Threed.SSCommand SSCmdExc_Loc 
               Height          =   465
               Left            =   15
               TabIndex        =   7
               Tag             =   "DBTTip:Apaga a Locação"
               Top             =   15
               Width           =   705
               _Version        =   65536
               _ExtentX        =   1244
               _ExtentY        =   820
               _StockProps     =   78
               Picture         =   "LOCDEVOL.frx":0666
            End
         End
         Begin Threed.SSPanel SSPanel12 
            Height          =   495
            Left            =   2805
            TabIndex        =   8
            Top             =   225
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
            Begin Threed.SSCommand SSCmdImp_Loc 
               Height          =   465
               Left            =   15
               TabIndex        =   9
               Tag             =   "DBTTip:Imprime o Recibo de Locação"
               Top             =   15
               Width           =   705
               _Version        =   65536
               _ExtentX        =   1244
               _ExtentY        =   820
               _StockProps     =   78
               Picture         =   "LOCDEVOL.frx":0AB8
            End
         End
         Begin Threed.SSPanel SSPanel13 
            Height          =   495
            Left            =   3675
            TabIndex        =   10
            Top             =   210
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
            Begin Threed.SSCommand SSCmdSair_Loc 
               Height          =   465
               Left            =   15
               TabIndex        =   11
               Tag             =   "DBTTip:Sair da Rotina "
               Top             =   15
               Width           =   705
               _Version        =   65536
               _ExtentX        =   1244
               _ExtentY        =   820
               _StockProps     =   78
               Picture         =   "LOCDEVOL.frx":0BCA
            End
         End
      End
      Begin Threed.SSFrame SSFrame2 
         Height          =   2370
         Left            =   -74820
         TabIndex        =   12
         Top             =   645
         Width           =   9165
         _Version        =   65536
         _ExtentX        =   16171
         _ExtentY        =   4170
         _StockProps     =   14
         ForeColor       =   16711680
         BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
            Name            =   "MS Sans Serif"
            Size            =   8.23
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Begin VB.ListBox LstDep_Loc 
            Height          =   450
            Left            =   1230
            TabIndex        =   53
            Top             =   1185
            Visible         =   0   'False
            Width           =   3975
         End
         Begin VB.ListBox LstNomCli_Loc 
            Height          =   645
            Left            =   1155
            TabIndex        =   13
            Top             =   795
            Width           =   4275
         End
         Begin Threed.SSPanel SSPanel4 
            Height          =   345
            Left            =   180
            TabIndex        =   14
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
               Size            =   8.26
               Charset         =   0
               Weight          =   400
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            BevelOuter      =   1
            Autosize        =   3
            Begin VB.TextBox TxtCodCli_Loc 
               Appearance      =   0  'Flat
               Height          =   315
               Left            =   15
               MaxLength       =   6
               TabIndex        =   15
               Tag             =   "DBTTip:Código do Cliente"
               Top             =   15
               Width           =   855
            End
         End
         Begin Threed.SSPanel SSPanel7 
            Height          =   345
            Left            =   1155
            TabIndex        =   16
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
               Size            =   8.32
               Charset         =   0
               Weight          =   400
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            BevelOuter      =   1
            Autosize        =   3
            Begin VB.TextBox TxtNomCli_Loc 
               Appearance      =   0  'Flat
               Height          =   315
               Left            =   15
               MaxLength       =   50
               TabIndex        =   17
               Tag             =   "DBTTip:Código do Cliente"
               Top             =   15
               Width           =   4260
            End
         End
         Begin Threed.SSPanel SSPanel2 
            Height          =   345
            Left            =   1140
            TabIndex        =   21
            Top             =   1920
            Width           =   4275
            _Version        =   65536
            _ExtentX        =   7541
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
            Begin VB.TextBox TxtNomDep_Loc 
               Appearance      =   0  'Flat
               Height          =   315
               Left            =   15
               MaxLength       =   50
               TabIndex        =   22
               Tag             =   "DBTTip:Código do Cliente"
               Top             =   15
               Width           =   4245
            End
         End
         Begin Threed.SSFrame SSFrame1 
            Height          =   1275
            Left            =   5595
            TabIndex        =   23
            Top             =   315
            Width           =   1515
            _Version        =   65536
            _ExtentX        =   2672
            _ExtentY        =   2249
            _StockProps     =   14
            Caption         =   "Locação"
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
            Begin Threed.SSOption SSOpt48_Loc 
               Height          =   195
               Left            =   150
               TabIndex        =   25
               Top             =   750
               Width           =   1020
               _Version        =   65536
               _ExtentX        =   1799
               _ExtentY        =   344
               _StockProps     =   78
               Caption         =   "48 Horas"
               BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
                  Name            =   "MS Sans Serif"
                  Size            =   8.25
                  Charset         =   0
                  Weight          =   400
                  Underline       =   0   'False
                  Italic          =   0   'False
                  Strikethrough   =   0   'False
               EndProperty
            End
            Begin Threed.SSOption SSOpt24_Loc 
               Height          =   225
               Left            =   135
               TabIndex        =   24
               Top             =   360
               Width           =   1080
               _Version        =   65536
               _ExtentX        =   1905
               _ExtentY        =   397
               _StockProps     =   78
               Caption         =   "24 Horas"
               BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
                  Name            =   "MS Sans Serif"
                  Size            =   8.25
                  Charset         =   0
                  Weight          =   400
                  Underline       =   0   'False
                  Italic          =   0   'False
                  Strikethrough   =   0   'False
               EndProperty
               Value           =   -1  'True
            End
         End
         Begin Threed.SSFrame SSFrame3 
            Height          =   1650
            Left            =   7230
            TabIndex        =   26
            Top             =   330
            Width           =   1665
            _Version        =   65536
            _ExtentX        =   2942
            _ExtentY        =   2900
            _StockProps     =   14
            Caption         =   "Datas"
            ForeColor       =   16711680
            BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
               Name            =   "MS Sans Serif"
               Size            =   8.22
               Charset         =   0
               Weight          =   400
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            Begin Threed.SSPanel SSPanel3 
               Height          =   345
               Left            =   180
               TabIndex        =   27
               Top             =   510
               Width           =   1215
               _Version        =   65536
               _ExtentX        =   2143
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
               Begin MSMask.MaskEdBox MskDtaInic_Loc 
                  Height          =   315
                  Left            =   15
                  TabIndex        =   28
                  Top             =   15
                  Width           =   1185
                  _ExtentX        =   2090
                  _ExtentY        =   556
                  _Version        =   393216
                  Appearance      =   0
                  MaxLength       =   10
                  Mask            =   "##/##/####"
                  PromptChar      =   " "
               End
            End
            Begin Threed.SSPanel SSPanel5 
               Height          =   345
               Left            =   180
               TabIndex        =   29
               Top             =   1185
               Width           =   1215
               _Version        =   65536
               _ExtentX        =   2143
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
               Begin MSMask.MaskEdBox MskDtaDevol_Loc 
                  Height          =   315
                  Left            =   15
                  TabIndex        =   30
                  Top             =   15
                  Width           =   1185
                  _ExtentX        =   2090
                  _ExtentY        =   556
                  _Version        =   393216
                  Appearance      =   0
                  MaxLength       =   10
                  Mask            =   "##/##/####"
                  PromptChar      =   " "
               End
            End
            Begin VB.Label Label2 
               AutoSize        =   -1  'True
               Caption         =   "Devolução"
               ForeColor       =   &H000000FF&
               Height          =   195
               Left            =   180
               TabIndex        =   32
               Top             =   975
               Width           =   780
            End
            Begin VB.Label Label1 
               AutoSize        =   -1  'True
               Caption         =   "Início Locação"
               Height          =   195
               Left            =   180
               TabIndex        =   31
               Top             =   285
               Width           =   1080
            End
         End
         Begin Threed.SSPanel SSPanel31 
            Height          =   600
            Left            =   210
            TabIndex        =   104
            Top             =   885
            Width           =   810
            _Version        =   65536
            _ExtentX        =   1429
            _ExtentY        =   1058
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
            Begin Threed.SSCommand SSCmdCons_Loc 
               Height          =   570
               Left            =   15
               TabIndex        =   105
               Tag             =   "DBTTip:Consulta Reserva"
               Top             =   15
               Width           =   780
               _Version        =   65536
               _ExtentX        =   1376
               _ExtentY        =   1016
               _StockProps     =   78
               Picture         =   "LOCDEVOL.frx":106C
            End
         End
         Begin Threed.SSCheck SSChkDep_Loc 
            Height          =   264
            Left            =   5616
            TabIndex        =   20
            Top             =   1908
            Width           =   1212
            _Version        =   65536
            _ExtentX        =   2138
            _ExtentY        =   466
            _StockProps     =   78
            Caption         =   "Dependente"
            ForeColor       =   16711680
            BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
               Name            =   "MS Sans Serif"
               Size            =   8.07
               Charset         =   0
               Weight          =   400
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
         End
         Begin VB.Label Label8 
            AutoSize        =   -1  'True
            Caption         =   "Nome do Dependente"
            Height          =   195
            Left            =   1140
            TabIndex        =   54
            Top             =   1710
            Width           =   1575
         End
         Begin VB.Label Label13 
            AutoSize        =   -1  'True
            Caption         =   "Cód. Cliente"
            Height          =   195
            Left            =   180
            TabIndex        =   19
            Top             =   195
            Width           =   855
         End
         Begin VB.Label Label12 
            AutoSize        =   -1  'True
            Caption         =   "Nome do Cliente"
            Height          =   195
            Left            =   1155
            TabIndex        =   18
            Top             =   195
            Width           =   1170
         End
      End
      Begin Threed.SSFrame SSFrame5 
         Height          =   1980
         Left            =   -74835
         TabIndex        =   33
         Top             =   3075
         Width           =   9165
         _Version        =   65536
         _ExtentX        =   16166
         _ExtentY        =   3493
         _StockProps     =   14
         Caption         =   "Inclusão dos Itens da Locação"
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
         Begin VB.ListBox LstItens_Loc 
            Height          =   1035
            Left            =   5520
            TabIndex        =   40
            Top             =   510
            Width           =   3540
         End
         Begin Threed.SSPanel SSPanel6 
            Height          =   345
            Left            =   120
            TabIndex        =   35
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
               Size            =   8.26
               Charset         =   0
               Weight          =   400
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            BevelOuter      =   1
            Autosize        =   3
            Begin VB.TextBox TxtCodCD_Loc 
               Appearance      =   0  'Flat
               Height          =   315
               Left            =   15
               MaxLength       =   7
               TabIndex        =   36
               Tag             =   "DBTTip:Código do Cliente"
               Top             =   15
               Width           =   855
            End
         End
         Begin Threed.SSPanel SSPanel8 
            Height          =   345
            Left            =   1125
            TabIndex        =   37
            Top             =   525
            Width           =   4290
            _Version        =   65536
            _ExtentX        =   7557
            _ExtentY        =   614
            _StockProps     =   15
            Caption         =   "SSPanel1"
            BackColor       =   12632256
            BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
               Name            =   "MS Sans Serif"
               Size            =   8.32
               Charset         =   0
               Weight          =   400
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            BevelOuter      =   1
            Autosize        =   3
            Begin VB.TextBox TxtTitCD_Loc 
               Appearance      =   0  'Flat
               Height          =   315
               Left            =   15
               MaxLength       =   50
               TabIndex        =   38
               Tag             =   "DBTTip:Código do Cliente"
               Top             =   15
               Width           =   4260
            End
         End
         Begin Threed.SSPanel SSPanel9 
            Height          =   345
            Left            =   3390
            TabIndex        =   43
            Top             =   1155
            Width           =   885
            _Version        =   65536
            _ExtentX        =   1561
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
            Begin VB.TextBox TxtValUnit_Loc 
               Appearance      =   0  'Flat
               Enabled         =   0   'False
               Height          =   315
               Left            =   15
               MaxLength       =   6
               TabIndex        =   44
               Tag             =   "DBTTip:Código do Cliente"
               Top             =   15
               Width           =   855
            End
         End
         Begin Threed.SSPanel SSPanel14 
            Height          =   345
            Left            =   4500
            TabIndex        =   45
            Top             =   1155
            Width           =   885
            _Version        =   65536
            _ExtentX        =   1561
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
            Begin VB.TextBox TxtValTot_Loc 
               Appearance      =   0  'Flat
               Enabled         =   0   'False
               Height          =   315
               Left            =   15
               MaxLength       =   6
               TabIndex        =   46
               Tag             =   "DBTTip:Código do Cliente"
               Top             =   15
               Width           =   855
            End
         End
         Begin Threed.SSPanel SSPanel15 
            Height          =   630
            Left            =   150
            TabIndex        =   48
            Top             =   1020
            Width           =   735
            _Version        =   65536
            _ExtentX        =   1291
            _ExtentY        =   1101
            _StockProps     =   15
            Caption         =   "SSPanel19"
            BackColor       =   12632256
            BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
               Name            =   "MS Sans Serif"
               Size            =   8.17
               Charset         =   0
               Weight          =   400
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            BevelOuter      =   1
            Autosize        =   3
            Begin Threed.SSCommand SSCmdGravaCD_Loc 
               Height          =   600
               Left            =   15
               TabIndex        =   49
               Tag             =   "DBTTip:Grava o Estilo"
               Top             =   15
               Width           =   705
               _Version        =   65536
               _ExtentX        =   1244
               _ExtentY        =   1058
               _StockProps     =   78
               Picture         =   "LOCDEVOL.frx":1176
            End
         End
         Begin Threed.SSCheck SSChkCort_Loc 
            Height          =   360
            Left            =   1140
            TabIndex        =   50
            Top             =   1020
            Width           =   1284
            _Version        =   65536
            _ExtentX        =   2265
            _ExtentY        =   635
            _StockProps     =   78
            Caption         =   "Cortezia"
            ForeColor       =   16711680
            BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
               Name            =   "MS Sans Serif"
               Size            =   12
               Charset         =   0
               Weight          =   700
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
         End
         Begin VB.Label Label7 
            AutoSize        =   -1  'True
            Caption         =   "Valor Total"
            ForeColor       =   &H000000FF&
            Height          =   195
            Left            =   4500
            TabIndex        =   47
            Top             =   930
            Width           =   765
         End
         Begin VB.Label Label6 
            AutoSize        =   -1  'True
            Caption         =   "Valor Unit."
            Height          =   195
            Left            =   3390
            TabIndex        =   42
            Top             =   930
            Width           =   735
         End
         Begin VB.Label Label5 
            AutoSize        =   -1  'True
            Caption         =   "Itens da Locação"
            Height          =   195
            Left            =   5520
            TabIndex        =   41
            Top             =   270
            Width           =   1245
         End
         Begin VB.Label Label4 
            AutoSize        =   -1  'True
            Caption         =   "Descrição do Título"
            Height          =   195
            Left            =   1125
            TabIndex        =   39
            Top             =   300
            Width           =   1410
         End
         Begin VB.Label Label3 
            AutoSize        =   -1  'True
            Caption         =   "Código CD"
            Height          =   195
            Left            =   120
            TabIndex        =   34
            Top             =   315
            Width           =   765
         End
      End
      Begin Threed.SSFrame SSFrame6 
         Height          =   960
         Left            =   -74865
         TabIndex        =   51
         Top             =   5100
         Width           =   1815
         _Version        =   65536
         _ExtentX        =   3201
         _ExtentY        =   1693
         _StockProps     =   14
         Caption         =   "Financeiro"
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
         Begin Threed.SSCheck SSChkPago_Loc 
            Height          =   264
            Left            =   156
            TabIndex        =   52
            Top             =   396
            Width           =   1536
            _Version        =   65536
            _ExtentX        =   2709
            _ExtentY        =   466
            _StockProps     =   78
            Caption         =   "Locação Paga"
            ForeColor       =   255
            BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
               Name            =   "MS Sans Serif"
               Size            =   8.07
               Charset         =   0
               Weight          =   400
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
         End
      End
      Begin Threed.SSFrame SSFrame7 
         Height          =   1965
         Left            =   540
         TabIndex        =   56
         Top             =   690
         Width           =   8400
         _Version        =   65536
         _ExtentX        =   14817
         _ExtentY        =   3466
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
         Begin VB.ListBox LstCli_Dev 
            Height          =   645
            Left            =   3675
            TabIndex        =   57
            Top             =   840
            Width           =   4275
         End
         Begin Threed.SSPanel SSPanel17 
            Height          =   345
            Left            =   2475
            TabIndex        =   58
            Top             =   390
            Width           =   885
            _Version        =   65536
            _ExtentX        =   1561
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
            Begin VB.TextBox TxtCodCli_Dev 
               Appearance      =   0  'Flat
               Height          =   315
               Left            =   15
               MaxLength       =   6
               TabIndex        =   59
               Tag             =   "DBTTip:Código do Cliente"
               Top             =   15
               Width           =   855
            End
         End
         Begin Threed.SSPanel SSPanel18 
            Height          =   345
            Left            =   3675
            TabIndex        =   60
            Top             =   420
            Width           =   4290
            _Version        =   65536
            _ExtentX        =   7557
            _ExtentY        =   614
            _StockProps     =   15
            Caption         =   "SSPanel1"
            BackColor       =   12632256
            BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
               Name            =   "MS Sans Serif"
               Size            =   8.32
               Charset         =   0
               Weight          =   400
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            BevelOuter      =   1
            Autosize        =   3
            Begin VB.TextBox TxtNomCli_Dev 
               Appearance      =   0  'Flat
               Height          =   315
               Left            =   15
               MaxLength       =   50
               TabIndex        =   61
               Tag             =   "DBTTip:Código do Cliente"
               Top             =   15
               Width           =   4260
            End
         End
         Begin Threed.SSFrame SSFrame8 
            Height          =   1455
            Left            =   240
            TabIndex        =   64
            Top             =   225
            Width           =   1665
            _Version        =   65536
            _ExtentX        =   2937
            _ExtentY        =   2566
            _StockProps     =   14
            Caption         =   "Número do Recibo"
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
            Begin VB.ComboBox CboRec_Dev 
               Height          =   315
               Left            =   360
               TabIndex        =   102
               Top             =   990
               Visible         =   0   'False
               Width           =   930
            End
            Begin Threed.SSPanel SSPanel19 
               Height          =   345
               Left            =   360
               TabIndex        =   65
               Top             =   585
               Width           =   885
               _Version        =   65536
               _ExtentX        =   1561
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
               Begin VB.TextBox TxtRec_Dev 
                  Appearance      =   0  'Flat
                  Height          =   315
                  Left            =   15
                  MaxLength       =   6
                  TabIndex        =   66
                  Tag             =   "DBTTip:Código do Cliente"
                  Top             =   15
                  Width           =   855
               End
            End
         End
         Begin VB.Label Label15 
            AutoSize        =   -1  'True
            Caption         =   "Nome do Cliente"
            Height          =   195
            Left            =   3690
            TabIndex        =   63
            Top             =   195
            Width           =   1170
         End
         Begin VB.Label Label14 
            AutoSize        =   -1  'True
            Caption         =   "Cód. Cliente"
            Height          =   195
            Left            =   2490
            TabIndex        =   62
            Top             =   180
            Width           =   855
         End
      End
      Begin Threed.SSFrame SSFrame9 
         Height          =   2700
         Left            =   555
         TabIndex        =   67
         Top             =   2790
         Width           =   4335
         _Version        =   65536
         _ExtentX        =   7646
         _ExtentY        =   4763
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
         Begin VB.ListBox LstItens_Dev 
            Height          =   1230
            Left            =   180
            TabIndex        =   71
            Top             =   1110
            Width           =   2715
         End
         Begin Threed.SSPanel SSPanel20 
            Height          =   345
            Left            =   195
            TabIndex        =   72
            Top             =   390
            Width           =   1215
            _Version        =   65536
            _ExtentX        =   2143
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
            Begin MSMask.MaskEdBox MskDtaHoje_Dev 
               Height          =   315
               Left            =   15
               TabIndex        =   73
               Top             =   15
               Width           =   1185
               _ExtentX        =   2090
               _ExtentY        =   556
               _Version        =   393216
               Appearance      =   0
               MaxLength       =   10
               Mask            =   "##/##/####"
               PromptChar      =   " "
            End
         End
         Begin Threed.SSPanel SSPanel21 
            Height          =   345
            Left            =   1545
            TabIndex        =   74
            Top             =   405
            Width           =   1215
            _Version        =   65536
            _ExtentX        =   2143
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
            Begin MSMask.MaskEdBox MskDtaLoc_Dev 
               Height          =   315
               Left            =   15
               TabIndex        =   75
               Top             =   15
               Width           =   1185
               _ExtentX        =   2090
               _ExtentY        =   556
               _Version        =   393216
               Appearance      =   0
               MaxLength       =   10
               Mask            =   "##/##/####"
               PromptChar      =   " "
            End
         End
         Begin Threed.SSPanel SSPanel22 
            Height          =   345
            Left            =   2895
            TabIndex        =   76
            Top             =   390
            Width           =   1215
            _Version        =   65536
            _ExtentX        =   2143
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
            Begin MSMask.MaskEdBox MskDtaDev_Dev 
               Height          =   315
               Left            =   15
               TabIndex        =   77
               Top             =   15
               Width           =   1185
               _ExtentX        =   2090
               _ExtentY        =   556
               _Version        =   393216
               Appearance      =   0
               MaxLength       =   10
               Mask            =   "##/##/####"
               PromptChar      =   " "
            End
         End
         Begin VB.Label Label16 
            AutoSize        =   -1  'True
            Caption         =   "Itens da Nota"
            Height          =   195
            Left            =   195
            TabIndex        =   78
            Top             =   855
            Width           =   960
         End
         Begin VB.Label Label11 
            AutoSize        =   -1  'True
            Caption         =   "Data Atual"
            ForeColor       =   &H000000FF&
            Height          =   195
            Left            =   210
            TabIndex        =   70
            Top             =   180
            Width           =   750
         End
         Begin VB.Label Label10 
            AutoSize        =   -1  'True
            Caption         =   "Data Devolução"
            Height          =   195
            Left            =   2880
            TabIndex        =   69
            Top             =   180
            Width           =   1170
         End
         Begin VB.Label Label9 
            AutoSize        =   -1  'True
            Caption         =   "Data Locação"
            Height          =   195
            Left            =   1530
            TabIndex        =   68
            Top             =   180
            Width           =   1020
         End
      End
      Begin Threed.SSFrame SSFrame10 
         Height          =   2685
         Left            =   5055
         TabIndex        =   79
         Top             =   2775
         Width           =   3855
         _Version        =   65536
         _ExtentX        =   6800
         _ExtentY        =   4736
         _StockProps     =   14
         Caption         =   "Financeiro"
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
         Begin Threed.SSPanel SSPanel28 
            Height          =   495
            Left            =   1995
            TabIndex        =   91
            Top             =   225
            Width           =   1455
            _Version        =   65536
            _ExtentX        =   2566
            _ExtentY        =   873
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
            Begin VB.TextBox TxtValNota_Dev 
               Appearance      =   0  'Flat
               BeginProperty Font 
                  Name            =   "MS Sans Serif"
                  Size            =   12
                  Charset         =   0
                  Weight          =   700
                  Underline       =   0   'False
                  Italic          =   0   'False
                  Strikethrough   =   0   'False
               EndProperty
               Height          =   465
               Left            =   15
               MaxLength       =   6
               TabIndex        =   92
               Tag             =   "DBTTip:Código do Cliente"
               Top             =   15
               Width           =   1425
            End
         End
         Begin Threed.SSPanel SSPanel29 
            Height          =   510
            Left            =   2010
            TabIndex        =   93
            Top             =   795
            Width           =   1455
            _Version        =   65536
            _ExtentX        =   2566
            _ExtentY        =   900
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
            Begin VB.TextBox TxtValDif_Dev 
               Appearance      =   0  'Flat
               BeginProperty Font 
                  Name            =   "MS Sans Serif"
                  Size            =   12
                  Charset         =   0
                  Weight          =   700
                  Underline       =   0   'False
                  Italic          =   0   'False
                  Strikethrough   =   0   'False
               EndProperty
               ForeColor       =   &H000000FF&
               Height          =   480
               Left            =   15
               MaxLength       =   6
               TabIndex        =   94
               Tag             =   "DBTTip:Código do Cliente"
               Top             =   15
               Width           =   1425
            End
         End
         Begin Threed.SSPanel SSPanel30 
            Height          =   510
            Left            =   2025
            TabIndex        =   95
            Top             =   1380
            Width           =   1470
            _Version        =   65536
            _ExtentX        =   2593
            _ExtentY        =   900
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
            Begin VB.TextBox TxtValTot_Dev 
               Appearance      =   0  'Flat
               BeginProperty Font 
                  Name            =   "MS Sans Serif"
                  Size            =   12
                  Charset         =   0
                  Weight          =   700
                  Underline       =   0   'False
                  Italic          =   0   'False
                  Strikethrough   =   0   'False
               EndProperty
               ForeColor       =   &H00FF0000&
               Height          =   480
               Left            =   15
               MaxLength       =   6
               TabIndex        =   96
               Tag             =   "DBTTip:Código do Cliente"
               Top             =   15
               Width           =   1440
            End
         End
         Begin Threed.SSCheck SSChkDev_Dev 
            Height          =   375
            Left            =   1560
            TabIndex        =   101
            Top             =   2160
            Width           =   1485
            _Version        =   65536
            _ExtentX        =   2619
            _ExtentY        =   661
            _StockProps     =   78
            Caption         =   "Devolvido"
            ForeColor       =   65535
            BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
               Name            =   "MS Sans Serif"
               Size            =   8.24
               Charset         =   0
               Weight          =   700
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
         End
         Begin Threed.SSCheck SSChkPg_Dev 
            Height          =   375
            Left            =   150
            TabIndex        =   100
            Top             =   2160
            Width           =   1230
            _Version        =   65536
            _ExtentX        =   2170
            _ExtentY        =   661
            _StockProps     =   78
            Caption         =   "Pago"
            ForeColor       =   12583104
            BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
               Name            =   "MS Sans Serif"
               Size            =   8.24
               Charset         =   0
               Weight          =   700
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
         End
         Begin VB.Label LBLAnt_Dev 
            AutoSize        =   -1  'True
            Caption         =   "Pagamento Antecipado"
            ForeColor       =   &H000000FF&
            Height          =   195
            Left            =   105
            TabIndex        =   103
            Top             =   585
            Visible         =   0   'False
            Width           =   1665
         End
         Begin VB.Label Label19 
            AutoSize        =   -1  'True
            Caption         =   "Total a Pagar"
            BeginProperty Font 
               Name            =   "MS Sans Serif"
               Size            =   12
               Charset         =   0
               Weight          =   700
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            ForeColor       =   &H000000FF&
            Height          =   300
            Left            =   135
            TabIndex        =   99
            Top             =   1485
            Width           =   1620
         End
         Begin VB.Label Label18 
            AutoSize        =   -1  'True
            Caption         =   "Diferença"
            BeginProperty Font 
               Name            =   "MS Sans Serif"
               Size            =   12
               Charset         =   0
               Weight          =   700
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            Height          =   300
            Left            =   120
            TabIndex        =   98
            Top             =   855
            Width           =   1185
         End
         Begin VB.Label Label17 
            AutoSize        =   -1  'True
            Caption         =   "Valor da Nota"
            BeginProperty Font 
               Name            =   "MS Sans Serif"
               Size            =   12
               Charset         =   0
               Weight          =   700
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            ForeColor       =   &H00FF0000&
            Height          =   300
            Left            =   90
            TabIndex        =   97
            Top             =   345
            Width           =   1665
         End
      End
      Begin Threed.SSFrame SSFrame11 
         Height          =   720
         Left            =   2460
         TabIndex        =   80
         Top             =   5550
         Width           =   4500
         _Version        =   65536
         _ExtentX        =   7938
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
            Left            =   120
            TabIndex        =   81
            Top             =   180
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
            Begin Threed.SSCommand SSCmdGrava_Dev 
               Height          =   465
               Left            =   15
               TabIndex        =   82
               Tag             =   "DBTTip:Grava a Locação"
               Top             =   15
               Width           =   705
               _Version        =   65536
               _ExtentX        =   1244
               _ExtentY        =   820
               _StockProps     =   78
               Picture         =   "LOCDEVOL.frx":1288
            End
         End
         Begin Threed.SSPanel SSPanel24 
            Height          =   495
            Left            =   990
            TabIndex        =   83
            Top             =   180
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
            Begin Threed.SSCommand SSCmdLimp_Dev 
               Height          =   465
               Left            =   15
               TabIndex        =   84
               Tag             =   "DBTTip:Nova Locação"
               Top             =   15
               Width           =   705
               _Version        =   65536
               _ExtentX        =   1244
               _ExtentY        =   820
               _StockProps     =   78
               Picture         =   "LOCDEVOL.frx":139A
            End
         End
         Begin Threed.SSPanel SSPanel25 
            Height          =   495
            Left            =   1890
            TabIndex        =   85
            Top             =   180
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
            Begin Threed.SSCommand SSCmdExc_Dev 
               Height          =   465
               Left            =   15
               TabIndex        =   86
               Tag             =   "DBTTip:Apaga a Locação"
               Top             =   15
               Width           =   705
               _Version        =   65536
               _ExtentX        =   1244
               _ExtentY        =   820
               _StockProps     =   78
               Picture         =   "LOCDEVOL.frx":14AC
            End
         End
         Begin Threed.SSPanel SSPanel26 
            Height          =   495
            Left            =   2805
            TabIndex        =   87
            Top             =   180
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
            Begin Threed.SSCommand SSCmdImp_Dev 
               Height          =   465
               Left            =   15
               TabIndex        =   88
               Tag             =   "DBTTip:Imprime o Recibo de Locação"
               Top             =   15
               Width           =   705
               _Version        =   65536
               _ExtentX        =   1244
               _ExtentY        =   820
               _StockProps     =   78
               Picture         =   "LOCDEVOL.frx":15B6
            End
         End
         Begin Threed.SSPanel SSPanel27 
            Height          =   495
            Left            =   3675
            TabIndex        =   89
            Top             =   180
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
            Begin Threed.SSCommand SSCmdSair_Dev 
               Height          =   465
               Left            =   15
               TabIndex        =   90
               Tag             =   "DBTTip:Sair da Rotina "
               Top             =   15
               Width           =   705
               _Version        =   65536
               _ExtentX        =   1244
               _ExtentY        =   820
               _StockProps     =   78
               Picture         =   "LOCDEVOL.frx":16C8
            End
         End
      End
      Begin Threed.SSFrame SSFrame13 
         Height          =   2280
         Left            =   -74565
         TabIndex        =   106
         Top             =   915
         Width           =   8400
         _Version        =   65536
         _ExtentX        =   14817
         _ExtentY        =   4022
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
         Begin VB.ListBox LstCli_Rec 
            Height          =   645
            Left            =   3675
            TabIndex        =   107
            Top             =   1005
            Width           =   4275
         End
         Begin Threed.SSPanel SSPanel16 
            Height          =   345
            Left            =   2475
            TabIndex        =   108
            Top             =   540
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
            Begin VB.TextBox TxtCodCli_Rec 
               Appearance      =   0  'Flat
               Height          =   315
               Left            =   15
               MaxLength       =   6
               TabIndex        =   109
               Tag             =   "DBTTip:Código do Cliente"
               Top             =   15
               Width           =   855
            End
         End
         Begin Threed.SSPanel SSPanel32 
            Height          =   345
            Left            =   3675
            TabIndex        =   110
            Top             =   525
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
            Begin VB.TextBox TxtNomCli_Rec 
               Appearance      =   0  'Flat
               Height          =   315
               Left            =   15
               MaxLength       =   50
               TabIndex        =   111
               Tag             =   "DBTTip:Código do Cliente"
               Top             =   15
               Width           =   4260
            End
         End
         Begin Threed.SSFrame SSFrame14 
            Height          =   1590
            Left            =   240
            TabIndex        =   112
            Top             =   375
            Width           =   1665
            _Version        =   65536
            _ExtentX        =   2937
            _ExtentY        =   2805
            _StockProps     =   14
            Caption         =   "Número do Recibo"
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
            Begin VB.ComboBox CboRec_Rec 
               Height          =   315
               Left            =   180
               TabIndex        =   127
               Top             =   1005
               Visible         =   0   'False
               Width           =   1230
            End
            Begin MSDBCtls.DBCombo DBCRecibo_Rec 
               Bindings        =   "LOCDEVOL.frx":1B6A
               Height          =   315
               Left            =   180
               TabIndex        =   115
               Top             =   405
               Width           =   1215
               _ExtentX        =   2143
               _ExtentY        =   556
               _Version        =   393216
               BackColor       =   16777215
               ForeColor       =   0
               ListField       =   "cod_recibo"
               BoundColumn     =   "cod_recibo"
               Text            =   ""
            End
            Begin VB.Label LBLCliente_Rec 
               AutoSize        =   -1  'True
               Caption         =   "Recibos do Cliente"
               ForeColor       =   &H00FF0000&
               Height          =   195
               Left            =   135
               TabIndex        =   128
               Top             =   780
               Width           =   1335
            End
         End
         Begin VB.Label Label22 
            AutoSize        =   -1  'True
            Caption         =   "Cód. Cliente"
            Height          =   195
            Left            =   2490
            TabIndex        =   114
            Top             =   315
            Width           =   855
         End
         Begin VB.Label Label21 
            AutoSize        =   -1  'True
            Caption         =   "Nome do Cliente"
            Height          =   195
            Left            =   3690
            TabIndex        =   113
            Top             =   300
            Width           =   1170
         End
      End
      Begin Threed.SSFrame SSFrame12 
         Height          =   945
         Left            =   -72450
         TabIndex        =   116
         Top             =   4425
         Width           =   4560
         _Version        =   65536
         _ExtentX        =   8043
         _ExtentY        =   1667
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
         Begin Threed.SSPanel SSPanel33 
            Height          =   495
            Left            =   120
            TabIndex        =   117
            Top             =   240
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
            Begin Threed.SSCommand SSCmdVer_Rec 
               Height          =   465
               Left            =   15
               TabIndex        =   118
               Tag             =   "DBTTip:Grava a "
               Top             =   15
               Width           =   705
               _Version        =   65536
               _ExtentX        =   1244
               _ExtentY        =   820
               _StockProps     =   78
               Picture         =   "LOCDEVOL.frx":1B84
            End
         End
         Begin Threed.SSPanel SSPanel34 
            Height          =   495
            Left            =   990
            TabIndex        =   119
            Top             =   225
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
            Begin Threed.SSCommand SSCmdLimp_Rec 
               Height          =   465
               Left            =   15
               TabIndex        =   120
               Tag             =   "DBTTip:Novo Recibo"
               Top             =   15
               Width           =   705
               _Version        =   65536
               _ExtentX        =   1244
               _ExtentY        =   820
               _StockProps     =   78
               Picture         =   "LOCDEVOL.frx":1C8E
            End
         End
         Begin Threed.SSPanel SSPanel35 
            Height          =   495
            Left            =   1890
            TabIndex        =   121
            Top             =   225
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
            Begin Threed.SSCommand SSCommand3 
               Height          =   465
               Left            =   15
               TabIndex        =   122
               Tag             =   "DBTTip:Apaga a Locação"
               Top             =   15
               Width           =   705
               _Version        =   65536
               _ExtentX        =   1244
               _ExtentY        =   820
               _StockProps     =   78
               Picture         =   "LOCDEVOL.frx":1DA0
            End
         End
         Begin Threed.SSPanel SSPanel36 
            Height          =   495
            Left            =   2805
            TabIndex        =   123
            Top             =   225
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
            Begin Threed.SSCommand SSCmdImp_Rec 
               Height          =   465
               Left            =   15
               TabIndex        =   124
               Tag             =   "DBTTip:Imprime o Recibo de Locação"
               Top             =   15
               Width           =   705
               _Version        =   65536
               _ExtentX        =   1244
               _ExtentY        =   820
               _StockProps     =   78
               Picture         =   "LOCDEVOL.frx":21F2
            End
         End
         Begin Threed.SSPanel SSPanel37 
            Height          =   495
            Left            =   3675
            TabIndex        =   125
            Top             =   210
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
            Begin Threed.SSCommand SSCmdSair_Rec 
               Height          =   465
               Left            =   15
               TabIndex        =   126
               Tag             =   "DBTTip:Sair da Rotina "
               Top             =   15
               Width           =   705
               _Version        =   65536
               _ExtentX        =   1244
               _ExtentY        =   820
               _StockProps     =   78
               Picture         =   "LOCDEVOL.frx":2304
            End
         End
      End
   End
End
Attribute VB_Name = "LocDevol"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Dim cod_depen As String, cod_recibo As String, gravou_recibo As String
Dim imprimiu_loc As String
Dim total_loc As Double
Dim cli_dev As String, cli_rec As String, gravou_dev As String
Dim data_retirada As Variant
Dim data_devolucao As Variant
Dim pago As String, valor_total As String
Private Sub cons_recibo()
   Dim X As Integer
   X = 1
   'Verific se a Tabela tem registro
   If Wrecibo.RecordCount <> 0 Then
      Wrecibo.MoveFirst
      Do While Not Wrecibo.EOF
         If Wrecibo("devolvido") = False Then
            wclien.Index = "primarykey"
            wclien.MoveFirst
            wclien.Seek "=", Wrecibo("cod_cliente")
            ConsRec1.GRDCons_Rec.Row = X
            ConsRec1.GRDCons_Rec.Col = 0
            ConsRec1.GRDCons_Rec = Format(Wrecibo("cod_cliente"), "000000")
            ConsRec1.GRDCons_Rec.Col = 1
            ConsRec1.GRDCons_Rec = wclien("nomecliente")
            ConsRec1.GRDCons_Rec.Col = 2
            ConsRec1.GRDCons_Rec = Format(Wrecibo("cod_recibo"), "000000")
            ConsRec1.GRDCons_Rec.Col = 3
            ConsRec1.GRDCons_Rec = Format(Wrecibo("valor_total"), "R$ 0.00")
            X = X + 1
            If X > 8 Then
               ConsRec1.GRDCons_Rec.Rows = ConsRec1.GRDCons_Rec.Rows + 1
            End If
         End If
         Wrecibo.MoveNext
      Loop
   End If
   If X > 1 Then
      ConsRec1.Show vbModal
   Else
      MsgBox "Tabela Vazia", 64
   End If
End Sub

Private Sub grava_recibo()
    If TxtCodCli_Loc = "" Or cod_recibo = 0 Then
       MsgBox "Campo essencial não pode ficar vazio", 48, "AVISO"
       TxtNomCli_Loc.SetFocus
       Exit Sub
    Else
       If gravou_recibo = "Sim" Then
          MsgBox "o Recibo já foi gravado", 64
          Exit Sub
       Else
          Wrecibo.AddNew
          Wrecibo("cod_cliente") = TxtCodCli_Loc
          Wrecibo("cod_recibo") = cod_recibo
          Wrecibo("valor_total") = TxtValTot_Loc
          If SSChkPago_Loc.Value = True Then
             Wrecibo("data_pagamento") = MskDtaInic_Loc
          End If
          Wrecibo.Update
          gravou_recibo = "Sim"
          If imprimiu_loc <> "Sim" Then
             MsgBox "Recibo Gravado com Sucesso", 64
          End If
          imprimiu_loc = "Não"
       End If
    End If
End Sub

Private Sub limpa_dev()
   ' Limpa a tela para nova devolução de CDS
    LBLAnt_Dev.Visible = False
    TxtRec_Dev = ""
    TxtCodCli_Dev = ""
    TxtCodCli_Dev.Enabled = True
    TxtNomCli_Dev = ""
    LstItens_Dev.Clear
    LstCli_Dev.Clear
    CboRec_Dev.Clear
    CboRec_Dev.Visible = False
    MskDtaLoc_Dev.Mask = ""
    MskDtaLoc_Dev.Text = ""
    MskDtaLoc_Dev.Mask = "##/##/####"
    MskDtaDev_Dev.Mask = ""
    MskDtaDev_Dev.Text = ""
    MskDtaDev_Dev.Mask = "##/##/####"
    SSChkPg_Dev = False
    SSChkDev_Dev = False
    TxtValNota_Dev = ""
    TxtValDif_Dev = ""
    TxtValTot_Dev = ""
    TxtRec_Dev.Enabled = True
    gravou_dev = ""
    TxtRec_Dev.SetFocus
End Sub

Private Sub limpa_loc()
    If gravou_recibo <> "Sim" Then
       MsgBox "O Recibo NÃO foi Gravado !!", 16
       SSCmdGrava_Loc.SetFocus
       Exit Sub
    End If
    'Inicio da procedure que limpa os campos e prepara para nova locação
    'Cálculo do número do recibo
    Set VTb = Wrecibo
    VIx = "cod_recibo"
    VCt = "Cod_Recibo"
    cod_recibo = geracod()
    'Limpa os campos
    TxtNomCli_Loc.Enabled = True
    LstNomCli_Loc.Enabled = True
    MskDtaInic_Loc.Enabled = True
    MskDtaDevol_Loc.Enabled = True
    SSOpt24_Loc.Enabled = True
    SSOpt48_Loc.Enabled = True
    SSChkDep_Loc.Enabled = True
    TxtNomDep_Loc.Enabled = True
    TxtCodCli_Loc.Enabled = True
    TxtCodCli_Loc = ""
    TxtNomCli_Loc = ""
    LstNomCli_Loc.Clear
    LstDep_Loc.Clear
    LstImprime_Loc.Clear
    LstItens_Loc.Clear
    TxtNomDep_Loc = ""
    SSChkCort_Loc.Value = False
    SSChkDep_Loc.Value = False
    SSChkPago_Loc.Value = False
    TxtCodCD_Loc = ""
    TxtTitCD_Loc = ""
    TxtValUnit_Loc = ""
    TxtValTot_Loc = ""
    MskDtaDevol_Loc.Mask = ""
    MskDtaDevol_Loc.Text = ""
    MskDtaDevol_Loc.Mask = "##/##/####"
    SSOpt24_Loc.Value = True
    TxtCodCli_Loc.SetFocus
End Sub

Private Sub limpa_rec()
     TxtNomCli_Rec = ""
     TxtCodCli_Rec = ""
     DBCRecibo_Rec = ""
     LBLCliente_Rec.Visible = False
     CboRec_Rec.Visible = False
     LstCli_Rec.Clear
     LstImprime_Loc.Clear
     Data_Recibo.Refresh
     DBCRecibo_Rec.SetFocus
End Sub


Private Sub pesquisa_cliente()
     Msg = "Digite o Nome/Sobrenome a ser Pesquisado"
     tit = "CD'S Loc - Pesquisa Cliente"
     Pesq_Nome = InputBox(Msg, tit)
     'inicio da rotina para escolha de um cliente
     If Pesq_Nome <> "" Then
        LstNomCli_Loc.Clear
        LstCli_Dev.Clear
        LstCli_Rec.Clear
        wclien.MoveFirst
        While Not wclien.EOF
          ' Pesquisa Cliente
          pesquisa = InStr(wclien!nomecliente, UCase(Pesq_Nome)) ' Maiúsculas
          pesquisa2 = InStr(wclien!nomecliente, Pesq_Nome) ' Minúsculas
          If pesquisa <> 0 Or pesquisa2 <> 0 Then
             If cli_dev = "Sim" Then
                LstCli_Dev.AddItem wclien("nomecliente")
             ElseIf cli_rec = "Sim" Then
                LstCli_Rec.AddItem wclien("nomecliente")
             Else
                LstNomCli_Loc.AddItem wclien("nomecliente")
             End If
          End If
          wclien.MoveNext
        Wend
     End If
     cli_dev = ""
     cli_rec = ""
End Sub


Private Sub pesquisa_reserva()
  'Pesquisa se o cliente tem reserva
  If Wreserva.RecordCount <> 0 Then
     Wreserva.Index = "cod_cliente"
     Wreserva.MoveFirst
     Wreserva.Seek "=", TxtCodCli_Loc
     If Not Wreserva.NoMatch Then
        Do While Not Wreserva.EOF
           If Wreserva("locado") = False Then
              If Wreserva("confirmado") = True Then
                 MsgBox "O Cliente tem Reserva de CD, Consulte a Reserva", 64
                 Exit Sub
              End If
            End If
            Wreserva.MoveNext
        Loop
     End If
  End If
  
End Sub


Private Sub CboRec_Dev_Click()
    TxtRec_Dev = CboRec_Dev.Text
    CboRec_Dev.Visible = False
    TxtRec_Dev.SetFocus
End Sub


Private Sub CboRec_rec_Click()
    DBCRecibo_Rec = CboRec_Rec.Text
    LBLCliente_Rec.Visible = False
    CboRec_Rec.Visible = False
    DBCRecibo_Rec.SetFocus
End Sub


Private Sub DBCRecibo_Rec_KeyDown(KeyCode As Integer, Shift As Integer)
    If KeyCode = 13 Then
       TxtCodCli_Rec.Enabled = True
       TxtCodCli_Rec.SetFocus
    End If
End Sub

Private Sub DBCRecibo_Rec_LostFocus()
   If DBCRecibo_Rec <> "" Then
       
       If Not IsNumeric(DBCRecibo_Rec) Then
          MsgBox "Use Apenas NÚMEROS", 64
          DBCRecibo_Rec.SetFocus
          Exit Sub
       End If
       
       'Pesquisa na tabela o codigo do recibo
       Wrecibo.Index = "cod_recibo"
       Wrecibo.MoveFirst
       Wrecibo.Seek "=", DBCRecibo_Rec.Text
       
       If Wrecibo.NoMatch Then
          MsgBox "Registro INEXISTENTE, Tente Outro.", 32
          DBCRecibo_Rec.SetFocus
          Exit Sub
       Else
          
          ' Verifica se o recibo já foi processado
          If Wrecibo("devolvido") = True Then
             MsgBox "Este recibo já foi devolvido", 16, "Atenção"
             DBCRecibo_Rec.SetFocus
             Exit Sub
          End If
          
          'Guarda valor total para imprimir no recibo
          valor_total = Wrecibo("valor_total")
          recibo = Wrecibo("cod_recibo")

          'Verifica se já está pago
          If Wrecibo("data_pagamento") <> "" Then
             pago = "Sim"
          End If

          'Pesquisa em locação todos os itens do recibo
          Wlocacao.Index = "cod_recibo"
          Wlocacao.MoveFirst
          Wlocacao.Seek "=", DBCRecibo_Rec
          If Not Wlocacao.NoMatch Then
             data_retirada = Format(Wlocacao("data_locacao"), "dd/mm/yyyy")
             data_devolucao = Format(Wlocacao("data_devolucao"), "dd/mm/yyyy")

             ' Carrega a lista de CD'S locado
             LstImprime_Loc.Clear
             While Not Wlocacao.EOF
               If Wlocacao("cod_recibo") = recibo Then
                  valor = Format(Wlocacao("valor_locacao"), "0.00")
                  LstImprime_Loc.AddItem Wlocacao("cod_cd") + "                     " + "R$ " + valor
               End If
               Wlocacao.MoveNext
             Wend
          End If
          'Guarda o código para pesquisar na tabela Recibo
          cod_cliente = Wrecibo("cod_cliente")

          'Pesquisa o nome do cliente
          wclien.Index = "primarykey"
          wclien.MoveFirst
          wclien.Seek "=", cod_cliente
          TxtCodCli_Rec = Format(wclien("codcliente"), "000000")
          TxtNomCli_Rec = wclien("nomecliente")

          If wclien("cancelado") = True Then
             MsgBox "O Cliente está CANCELADO", 16, "Atenção"
             'Limpa os campos
             DBCRecibo_Rec = ""
             TxtCodCli_Rec = ""
             TxtNomCli_Rec = ""
             DBCRecibo_Rec.SetFocus
             Exit Sub
          End If
       End If
    End If
End Sub


Private Sub Form_Load()
    With LocDevol
       .Left = 1275
       .Height = 6885
       .Width = 9660
       .Top = 360
    End With
    
    With Data_Recibo
     'Seta o data
     .DatabaseName = App.Path & "\bd_cdloc.mdb"
     .Refresh
    End With
End Sub

Private Sub LstCli_Dev_Click()
    'Pesquisa o nome cliente na tabela
    TxtNomCli_Dev = LstCli_Dev
    wclien.Index = "nomecliente"
    wclien.MoveFirst
    wclien.Seek "=", LstCli_Dev

    'Guarda a variável cod_cli para pesquisar na tabela recibo
    cod_cli = wclien("codcliente")

    If wclien.NoMatch Then
       ' Cliente Não Cadastrado
       msgI = "Inclusão"
       Atualiza = "Não"
    Else
       TxtCodCli_Dev = Format(wclien("codcliente"), "000000")
       Msg = MsgBox("Voçê selecionou o Cliente ? " + TxtCodCli_Dev + "  " + LstCli_Dev.Text, 36)
       
       If Msg = 7 Then 'Resposta = Não
          TxtNomCli_Dev = ""
          TxtCodCli_Dev.Enabled = True
          TxtCodCli_Dev = ""
          Exit Sub
       End If

       If wclien("cancelado") = True Then
          MsgBox "O Cliente está CANCELADO", 16, "Atenção"
          TxtNomCli_Dev = ""
          TxtCodCli_Dev = ""
          TxtCodCli_Dev.Enabled = True
          TxtNomCli_Dev.SetFocus
          Exit Sub
       End If
       
       'Pesquisa se o cliente escolhido tem recibo na tabela recibo.
       Wrecibo.Index = "cod_cliente"
       Wrecibo.MoveFirst
       Wrecibo.Seek "=", cod_cli
       
       ' Pesquisa se existe mais de um recibo em aberto
       num_rec = 0
       CboRec_Dev.Clear
       While Not Wrecibo.NoMatch And Not Wrecibo.EOF
          If cod_cli = Wrecibo("cod_cliente") And Wrecibo("devolvido") <> True Then
             num_rec = num_rec + 1
             CboRec_Dev.AddItem Format(Wrecibo("cod_recibo"), "000000")
             recibo = Wrecibo("cod_recibo")
          End If
          Wrecibo.MoveNext
       Wend

       If Wrecibo.NoMatch Or recibo = "" Then
          ' Cliente não tem recibo
          MsgBox "Não existe locação em aberto para o Cliente", 32, "Atenção"
          TxtNomCli_Dev = ""
          TxtCodCli_Dev = ""
          TxtCodCli_Dev.Enabled = True
          TxtNomCli_Dev.SetFocus
       Else
          If num_rec > 1 Then
             MsgBox "Cliente possue mais de um recibo em aberto", 16, "Cuidado !"
             'label7.Visible = True
             CboRec_Dev.Visible = True
             CboRec_Dev.SetFocus
             Exit Sub
          Else
             TxtRec_Dev = Format(recibo, "000000")
          End If
          TxtRec_Dev.SetFocus
          SSChkPg_Dev.SetFocus
       End If
    End If
End Sub

Private Sub LstCli_Rec_Click()
    'Pesquisa o nome cliente na tabela
    TxtNomCli_Rec = LstCli_Rec
    wclien.Index = "nomecliente"
    wclien.MoveFirst
    wclien.Seek "=", LstCli_Rec

    'Guarda a variável cod_cli para pesquisar na tabela recibo
    cod_cli = wclien("codcliente")

    If wclien.NoMatch Then
       ' Cliente Não Cadastrado
       msgI = "Inclusão"
       Atualiza = "Não"
    Else
       TxtCodCli_Rec = Format(wclien("codcliente"), "000000")
       Msg = MsgBox("Voçê selecionou o Cliente ? " + TxtCodCli_Rec + "  " + LstCli_Rec.Text, 36)
       
       If Msg = 7 Then 'Resposta = Não
          TxtNomCli_Rec = ""
          TxtCodCli_Rec.Enabled = True
          TxtCodCli_Rec = ""
          Exit Sub
       End If

       If wclien("cancelado") = True Then
          MsgBox "O Cliente está CANCELADO", 16, "Atenção"
          TxtNomCli_Rec = ""
          TxtCodCli_Rec = ""
          TxtCodCli_Rec.Enabled = True
          TxtNomCli_Rec.SetFocus
          Exit Sub
       End If
       
       'Pesquisa se o cliente escolhido tem recibo na tabela recibo.
       Wrecibo.Index = "cod_cliente"
       Wrecibo.MoveFirst
       Wrecibo.Seek "=", cod_cli
       
       ' Pesquisa se existe mais de um recibo em aberto
       num_rec = 0
       CboRec_Rec.Clear
       While Not Wrecibo.NoMatch And Not Wrecibo.EOF
          If cod_cli = Wrecibo("cod_cliente") And Wrecibo("devolvido") <> True Then
             num_rec = num_rec + 1
             CboRec_Rec.AddItem Format(Wrecibo("cod_recibo"), "000000")
             recibo = Wrecibo("cod_recibo")
          End If
          Wrecibo.MoveNext
       Wend

       If Wrecibo.NoMatch Or recibo = "" Then
          ' Cliente não tem recibo
          MsgBox "Não existe locação em aberto para o Cliente", 32, "Atenção"
          TxtNomCli_Rec = ""
          TxtCodCli_Rec = ""
          TxtCodCli_Rec.Enabled = True
          TxtNomCli_Rec.SetFocus
       Else
          If num_rec > 1 Then
             MsgBox "Cliente possue mais de um recibo em aberto", 16, "Cuidado !"
             LBLCliente_Rec.Visible = True
             CboRec_Rec.Visible = True
             CboRec_Rec.SetFocus
             Exit Sub
          Else
             DBCRecibo_Rec = Format(recibo, "000000")
          End If
          DBCRecibo_Rec.SetFocus
       End If
    End If
End Sub

Private Sub LstDep_Loc_Click()
    Msg = MsgBox("Voçê selecionou o Dependente ? " + LstDep_Loc.Text, 36)
    If Msg = 7 Then 'Resposta = Não
       cod_depen = ""
       Exit Sub
    End If
    LstDep_Loc.Visible = False
    cod_depen = Left(LstDep_Loc, 3)
    TxtNomDep_Loc = Mid(LstDep_Loc, 6)
    TxtCodCD_Loc.SetFocus
End Sub

Private Sub LstItens_Loc_Click()
    chave = Left(LstItens_Loc, 6)
    Wlocacao.Index = "cod_cd"
    Wlocacao.MoveFirst
    Wlocacao.Seek "=", chave
    valor_debitar = Wlocacao("valor_locacao")
    chave_cd = Wlocacao("cod_cd")
    Msg = MsgBox("Exclui o item ? " + Wlocacao("cod_cd") + " ", 36)
    If Msg = 7 Then 'Resposta = Não
       Exit Sub
    Else
       'Deleta o registro em locação
       Wlocacao.Delete
       'Diminui o valor da variável valor_total que será gravado em recibo
       novo_total = CSng(TxtValTot_Loc) - CSng(valor_debitar)
       TxtValTot_Loc = ""
       TxtValTot_Loc = Format(novo_total, "0.00")
       
       'Pesquisa o cd na tabela
       Wcdfisico.Index = "cod_cd"
       Wcdfisico.MoveFirst
       Wcdfisico.Seek "=", chave_cd
       cod_titulo = Wcdfisico("cod_titulo")

       'Muda o estado de locação em cd para locado = Não
       Wcdfisico.Edit
       Wcdfisico("locado") = False
       Wcdfisico.Update

       'Devolve a tabela título a quantidade retirada
       Wtitulo.Index = "primarykey "
       Wtitulo.MoveFirst
       Wtitulo.Seek "=", cod_titulo
       Wtitulo.Edit
       Wtitulo("qtde_disp") = (Wtitulo("qtde_disp") + 1)

       'Verifica se a quantidade disponível bate com a quantidade total
       If Wtitulo("qtde_disp") > Wtitulo("qtde_tot") Then
          MsgBox "Quantidade Disponível MAIOR QUE O TOTAL", 16
          '****** ATENÇÃO *******
         'Fazer a rotina para desfazer a transação
       Else
          Wtitulo.Update
       End If

       'Retira do list o registro deletado
       For i = 0 To LstItens_Loc.ListCount - 1
           If LstItens_Loc.List(i) = LstItens_Loc Then
              LstItens_Loc.RemoveItem i
              Exit For
           End If
       Next
       
       'Retira do list de imprimir o registro deletado
       tam_cod = Len(Wcdfisico("cod_cd"))
       For i = 0 To LstImprime_Loc.ListCount - 1
           If Left(LstImprime_Loc.List(i), tam_cod) = Wcdfisico("cod_cd") Then
              LstImprime_Loc.RemoveItem i
              Exit For
           End If
       Next
    End If
End Sub

Private Sub LstNomCli_Loc_Click()
    TxtNomCli_Loc = LstNomCli_Loc
    wclien.Index = "nomecliente"
    wclien.MoveFirst
    wclien.Seek "=", LstNomCli_Loc.Text
    If wclien.NoMatch Then
       ' Cliente Não Cadastrado
       msgI = "Inclusão"
       mensagem = "Incluir"
    Else
       msgI = "Inclusão"
       mensagem = "Incluir"
       TxtCodCli_Loc = Format(wclien("codcliente"), "000000")
       Msg = MsgBox("Voçê selecionou o Cliente ? " + TxtCodCli_Loc + "  " + LstNomCli_Loc.Text, 36)
       If Msg = 7 Then 'Resposta = Não
          TxtNomCli_Loc = ""
          TxtCodCli_Loc = ""
          TxtNomCli_Loc.SetFocus
          Exit Sub
       End If
       'Chama a Procedure que verifica se o cliente tem uma reserva
       pesquisa_reserva
       If SSOpt24_Loc.Value = True Then
          hoje = Weekday(Now)
          If hoje = 7 Then
             MskDtaDevol_Loc.SelText = DateAdd("d", 2, MskDtaInic_Loc)
             MskDtaDevol_Loc = Format(MskDtaDevol_Loc, "dd/mm/yyyy")
          Else
             MskDtaDevol_Loc.SelText = DateAdd("d", 1, MskDtaInic_Loc)
             MskDtaDevol_Loc = Format(MskDtaDevol_Loc, "dd/mm/yyyy")
          End If
       End If
       'preencher os campos
       TxtNomCli_Loc = wclien("nomecliente")
       TxtCodCli_Loc.Enabled = False
       TxtNomCli_Loc.SetFocus
    End If
End Sub

Private Sub SSChkDep_Loc_Click(Value As Integer)
   If SSChkDep_Loc.Value = True Then
       LstDep_Loc.Visible = True
       ' Carrega a lista de dependentes
       LstDep_Loc.Clear
       Wdependente.Index = "cod_cli"
       Wdependente.MoveFirst
       Wdependente.Seek "=", TxtCodCli_Loc
       If Not Wdependente.NoMatch Then
          Do While Not Wdependente.EOF And Format(Wdependente("cod_cliente"), "000000") = TxtCodCli_Loc
             LstDep_Loc.AddItem Format(Wdependente("cod_dependente"), "000") & " - " & Wdependente("nome_dependente")
             Wdependente.MoveNext
             If Wdependente.EOF Then
                Exit Do
             End If
          Loop
       End If
    Else
       LstDep_Loc.Clear
       LstDep_Loc.Visible = False
       TxtNomDep_Loc = ""
       cod_depen = ""
    End If
End Sub

Private Sub SSCmdCons_Loc_Click()
   Dim X As Integer
   X = 1
   'Verific se a Tabela tem registro
   If Wreserva.RecordCount <> 0 Then
      Wreserva.Index = "cod_cliente"
      Wreserva.MoveFirst
      Wreserva.Seek "=", TxtCodCli_Loc
      If Not Wreserva.NoMatch Then
         Do While Not Wreserva.EOF
            If Wreserva("locado") = False Then
               If Wreserva("confirmado") = True Then
                  ConsRes1.GRDCons_Res.Row = X
                  ConsRes1.GRDCons_Res.Col = 0
                  ConsRes1.GRDCons_Res = Format(Wreserva("cod_cd"), ">")
                  ConsRes1.GRDCons_Res.Col = 1
                  Wtitulo.Index = "primarykey"
                  Wtitulo.MoveFirst
                  Wtitulo.Seek "=", Wreserva("cod_titulo")
                  ConsRes1.GRDCons_Res = Wtitulo("titulo")
                  ConsRes1.GRDCons_Res.Col = 2
                  ConsRes1.GRDCons_Res = Format(Wreserva("data_reserva"), "dd/mm/yyyy")
                  ConsRes1.GRDCons_Res.Col = 3
                  ConsRes1.GRDCons_Res = Format(Wreserva("data_confirmacao"), "dd/mm/yyyy")
               End If
            End If
            X = X + 1
            If X > 4 Then
               ConsRes1.GRDCons_Res.Rows = ConsRes1.GRDCons_Res.Rows + 1
            End If
            Wreserva.MoveNext
         Loop
      End If
   End If
   If X > 1 Then
      ConsRes1.Show vbModal
   Else
      MsgBox "Tabela Vazia", 64
   End If
End Sub

Private Sub SSCmdExc_Dev_Click()
   'Chama a Procedure cosulta recibo
   cons = "Devol"
   cons_recibo
End Sub

Private Sub SSCmdExc_Loc_Click()
   MsgBox "Rotina não Implementada", 32
   ' On Error GoTo ErrorHandler  ' Enable error-handling routine.
   ' Msg = "Deseja realmente Excluir ?"  ' Define message.
   ' Style = vbYesNo + vbCritical + vbDefaultButton1 ' Define buttons.
   ' Title = "CD'S Loc - Cuidado!!"  ' Define title.
   ' Help = "DEMO.HLP"   ' Define Help file.
   ' Ctxt = 1000 ' Define topic
                ' context.
    ' Display message.
   ' resposta = MsgBox(Msg, Style, Title, Help, Ctxt)
   ' If resposta = vbNo Then    ' User chose Yes.
       'Posiciona no código
   '    TxtCod_Tit.SetFocus
   ' Else
   '    If Wtitulo.RecordCount <> 0 Then
   '       Wtitulo.Index = "primarykey"
   '       Wtitulo.MoveFirst
   '       Wtitulo.Seek "=", TxtCod_Tit
      
   '       If Not Wtitulo.NoMatch Then
             'Apaga registro do Banco de Dados
   '          Wtitulo.Delete
   '       Else
   '          MsgBox "SELECIONE registro para EXCLUIR", 32
   '       End If
   '    Else
   '       MsgBox "Não existe registro para EXCLUIR", 32
   '    End If
   ' End If
    'Chama a Procedure que Limpa
   ' limpa_titulo
'ErrorHandler: ' Error-handling routine.
'    Select Case Err.Number  ' Evaluate error number.
'        Case 3200 ' "Erro de Integridade referencial" error.
'             msg2 = "Voçê não pode EXCLUIR este registro !"  ' Define message.
'             estilo = vbYes + vbCritical + vbDefaultButton1
'             titulo = "CD'S Loc - Atenção !"
'             res = MsgBox(msg2, estilo, titulo)
'        Case Is <> 0 ' Else
'            ' Handle other situations here...
'            MsgBox "Ocorreu Erro No. " & Err.Number & " na Exclusão, ligue p/Sandoval", 48
'    End Select
'    TxtCod_Tit.SetFocus
'    Exit Sub
'    Resume  ' Resume execution at same line
                ' that caused the error.
                
End Sub

Private Sub SSCmdGrava_Dev_Click()
     On Error GoTo traterro
     If gravou_dev = "Sim" Then
        MsgBox "Registro já Gravado", 16
        SSCmdLimp_Dev.SetFocus
        Exit Sub
     End If
     If TxtRec_Dev = "" Then
        MsgBox "Informe o Recibo para Devolução", 32
        TxtRec_Dev.SetFocus
        Exit Sub
     End If
     'Inicia a Transação
     Workspaces(0).BeginTrans

     If SSChkDev_Dev = True Then
        Wrecibo.Edit
        If SSChkPg_Dev = True Then
           If Wrecibo("data_pagamento") <> "" Then
              ' Passou pelo if
           Else
              Wrecibo("data_pagamento") = MskDtaHoje_Dev
           End If
           Wrecibo("valor_recebido") = TxtValTot_Dev
        Else
           'Verificar com André se pode devolver sem pagar
           Msg = MsgBox("Confirma a Devolução sem o Pagamento ? ", 36)
       
           If Msg = 7 Then 'Resposta = Não
              SSChkPg_Dev = True
              Exit Sub
           End If
           
        End If
        'Inicia a Transação
        
        'Atualiza a tabela recibo
        Wrecibo("devolvido") = True
        Wrecibo.Update
        
        gravou_dev = "Sim"
        
        'Pesquisa na tabela o codigo do recibo
        Wlocacao.Index = "cod_recibo"
        Wlocacao.MoveFirst
        Wlocacao.Seek "=", TxtRec_Dev
          
        Do While Not Wlocacao.EOF
           cod_cd = Wlocacao("cod_cd")
           cod_titulo = Wlocacao("cod_titulo")
           If Format(Wlocacao("cod_recibo"), "000000") = TxtRec_Dev Then
             
              If Wreserva.RecordCount <> 0 Then
                 'Pesquisa se existe reserva para este CD
                 Wreserva.Index = "cod_titulo"
                 Wreserva.MoveFirst
                 Wreserva.Seek "=", cod_titulo

                 'Verifica se achou o título
                 If Not Wreserva.NoMatch Then
                    'Varre todo o arquivo até achar um
                    Do While Not Wreserva.EOF
                       If Wreserva("confirmado") <> True Then
                          cdcliente = Wreserva("cod_cliente")
                          wclien.Index = "primarykey"
                          wclien.MoveFirst
                          wclien.Seek "=", cdcliente
                          If Not wclien.NoMatch Then
                             nmcliente = wclien("nomecliente")
                          End If
                          Msg = MsgBox("Existe uma Reserva para o CD " & cod_cd & " do Cliente: " & nmcliente & " confirma a Reserva ? ", 36)
                          If Msg = 6 Then
                             Wreserva.Edit
                             Wreserva("confirmado") = True
                             Wreserva("data_confirmacao") = MskDtaHoje_Dev
                             Wreserva("cod_cd") = cod_cd
                             Wreserva.Update
                             Exit Do
                          Else
                             Exit Do
                          End If
                       End If
                       Wreserva.MoveNext
                    Loop
                 End If
              End If
              'Pesquisa na tabela de cd para alterar o estado locado
              Wcdfisico.Index = "cod_cd"
              Wcdfisico.MoveFirst
              Wcdfisico.Seek "=", cod_cd
              Wcdfisico.Edit
              If Msg = 6 Then
                 Wcdfisico("reservado") = True
              End If
              Wcdfisico("locado") = False
              Wcdfisico.Update

              'Soma a quantidade de cd disponível na tabela título
              Wtitulo.Index = "primarykey"
              Wtitulo.MoveFirst
              Wtitulo.Seek "=", cod_titulo
              Wtitulo.Edit
              Wtitulo("qtde_disp") = (Wtitulo("qtde_disp") + 1)

              'Verifica se a quantidade disponível bate com a quantidade total
              If Wtitulo("qtde_disp") > Wtitulo("qtde_tot") Then
                 MsgBox "Quantidade Disponível MAIOR QUE O TOTAL", 16
                 'Desfaz a Transação
                 Workspaces(0).Rollback
                 Exit Sub
              Else
                 Wtitulo.Update
              End If

           Else
              'Sai do laço quando o recibo é diferente
              Exit Do
           End If
           'Move o próximo registro de locação
           Wlocacao.MoveNext
         Loop
      Else
         MsgBox "Voçê Precisa confirmar a DEVOLUÇÃO antes de GRAVAR", 16
         SSChkDev_Dev.SetFocus
         Exit Sub
      End If
      
      
traterro:
    Select Case Err.Number
    Case Is = 3201
        MsgBox "Falta Registro Relacionado na Tabela", vbCritical, _
        "CD'S Loc - Locadora de CD"
        'Desfaz a Transação
        Workspaces(0).Rollback
    Case Is <> 0 ' Else
        MsgBox "Erro Número => " & Err.Number & "  " & Err.Description, vbCritical, _
        "CD'S Loc - Locadora de CD"
        'Desfaz a Transação
        Workspaces(0).Rollback
       ' DSHorario.Requery 'Para forçar a atualização do Recordset
        'Chama a Procedure Pública que trata o erro
       ' MsgErro
    Case Is = 0
       'Confirma a Transação
       Workspaces(0).CommitTrans
       MsgBox "Gravado com Sucesso", vbInformation, "CD'S Loc - Sistema de Locação"
    End Select
      
      
End Sub

Private Sub SSCmdGrava_Loc_Click()
    'Chama a procedure que grava o recibo
    grava_recibo
End Sub

Private Sub SSCmdGravaCD_Loc_Click()
    On Error GoTo traterro
    If TxtCodCli_Loc = "" Or cod_recibo = "" Or TxtCodCD_Loc = "" Or MskDtaInic_Loc = "" Or MskDtaDevol_Loc = "" Then
       MsgBox "Os Campos essenciais não podem ficar vazios", 48, "AVISO"
       TxtNomCli_Loc.SetFocus
       Exit Sub
    Else
       Msg = MsgBox("Confirma o item ? ", 36, "CONFIRMAÇÃO")
       If Msg = 6 Then   'Se a tecla acionado foi Sim
          
          'Inicia a Transação
          Workspaces(0).BeginTrans
          
          'Insere os registros da locação na tabela locação
          Wlocacao.AddNew
          Wlocacao("cod_titulo") = cod_titulo
          Wlocacao("cod_cd") = Wcdfisico("cod_cd")
          Wlocacao("data_locacao") = MskDtaInic_Loc
          Wlocacao("cod_cliente") = TxtCodCli_Loc
          Wlocacao("cod_dependente") = Val(cod_depen)
          Wlocacao("cod_recibo") = cod_recibo
          Wlocacao("data_devolucao") = MskDtaDevol_Loc
          If SSChkCort_Loc = True Then
             TxtValUnit_Loc = 0
             Wlocacao("valor_locacao") = 0
          Else
             Wlocacao("valor_locacao") = TxtValUnit_Loc.Text
          End If
          'Inclui o item na lista 2 para impressão do recibo mais rápido
          LstImprime_Loc.AddItem Wlocacao("cod_cd") + "                     " + "R$ " + TxtValUnit_Loc
          
          'Grava na tabela locação
          Wlocacao.Update
          
          gravou_recibo = "Não"
          'Desabilita para não modificar o cliente
          TxtNomCli_Loc.Enabled = False
          LstNomCli_Loc.Enabled = False
          MskDtaInic_Loc.Enabled = False
          MskDtaDevol_Loc.Enabled = False
          SSOpt24_Loc.Enabled = False
          SSOpt48_Loc.Enabled = False
          SSChkDep_Loc.Enabled = False
          TxtNomDep_Loc.Enabled = False
          
          
          'Subtrai a quantidade de cd disponível na tabela título
          Wtitulo.Index = "primarykey"
          Wtitulo.MoveFirst
          Wtitulo.Seek "=", cod_titulo
          Wtitulo.Edit
          Wtitulo("qtde_disp") = (Wtitulo("qtde_disp") - 1)
          If Wtitulo("qtde_disp") < 0 Then
             MsgBox "Quantidade Disponível MENOR DO QUE ZERO", 16
             'Desfaz a Transação
             Workspaces(0).Rollback
             Exit Sub
          Else
             Wtitulo.Update
          End If

          'Muda o estado de locação em cd para locado=sim e reservado = não
          Wcdfisico.Edit
          Wcdfisico("locado") = True
          Wcdfisico("reservado") = False
          Wcdfisico.Update

          'Muda o estado de locado = sim da tabela reserva
          If Wreserva.RecordCount <> 0 Then
             Wreserva.Index = "cod_cliente"
             Wreserva.MoveFirst
             Wreserva.Seek "=", TxtCodCli_Loc
             If Not Wreserva.NoMatch Then
                Do While Not Wreserva.EOF
                   If Wreserva("locado") = False Then
                      If Wreserva("confirmado") = True Then
                         If Wreserva("cod_cd") = TxtCodCD_Loc Then
                            Wreserva.Edit
                            Wreserva("locado") = True
                            Wreserva.Update
                         End If
                      End If
                   End If
                   Wreserva.MoveNext
                Loop
             End If
          End If
          If TxtValTot_Loc = "" Then
             TxtValTot_Loc = 0
          End If
          'Soma a variável valor total que servirá para o recibo
          total_loc = CSng(TxtValTot_Loc.Text) + CSng(TxtValUnit_Loc.Text)
          TxtValTot_Loc = ""
          TxtValTot_Loc = Format(total_loc, "0.00")
          
          'inclui o item na lista
          LstItens_Loc.AddItem TxtCodCD_Loc + " " + TxtTitCD_Loc
          
          'Limpa
          TxtCodCD_Loc = ""
          TxtTitCD_Loc = ""
          TxtValUnit_Loc = ""
       Else
          'Não confirmou a inclusão do item
          TxtCodCD_Loc = ""
          TxtTitCD_Loc = ""
          TxtValUnit_Loc = ""
       End If
       TxtCodCD_Loc.SetFocus
    End If
    
traterro:
    Select Case Err.Number
    Case Is = 3201
        MsgBox "Falta Registro Relacionado na Tabela", vbCritical, _
        "CD'S Loc - Locadora de CD"
        'Desfaz a Transação
        Workspaces(0).Rollback
    Case Is <> 0 ' Else
        MsgBox "Erro Número => " & Err.Number & "  " & Err.Description, vbCritical, _
        "CD'S Loc - Locadora de CD"
        'Desfaz a Transação
        Workspaces(0).Rollback
       ' DSHorario.Requery 'Para forçar a atualização do Recordset
        'Chama a Procedure Pública que trata o erro
       ' MsgErro
    Case Is = 0
        If Msg = 6 Then
           'Confirma a Transação
           Workspaces(0).CommitTrans
         '  DSHorario.Requery 'Para forçar a atualização do Recordset
         '  DSServLinha.Requery 'Para forçar a atualização do Recordset
           MsgBox "Gravado com Sucesso", vbInformation, "CD'S Loc - Sistema de Locação"
        Else
           MsgBox "Operação Cancelada pelo Usuário", vbExclamation, "CD'S Loc - Sistema de Locação"
        End If
    End Select
    
End Sub

Private Sub SSCmdImp_Dev_Click()
     MsgBox "Rotina não Implementada", 32
End Sub

Private Sub SSCmdImp_Loc_Click()
    If TxtCodCli_Loc = "" Or cod_recibo = 0 Then
       MsgBox "Campo essencial não pode ficar vazio", 48, "AVISO"
       TxtNomCli_Loc.SetFocus
       Exit Sub
    Else
       Msg = MsgBox("Confirma a impressão do RECIBO ? ", 36, "CONFIRMAÇÃO")
       If Msg = 6 Then   'Se a tecla acionado foi Sim
          'Verifica se existe pelo menos um CD na lista
          If LstItens_Loc.ListCount = 0 Then
             MsgBox "Não existe CD na lista para Imprimir Recibo", 48, "CUIDADO"
             TxtCodCD_Loc.SetFocus
             Exit Sub
          End If
          'Executa o procedimento de impressão do RECIBO
          ' Colocar o tamanho da fonte e centarlizar em 9 colunas
         ' Printer.FontName = "Bazooka"
          Printer.FontSize = "14"
          Printer.Print "CD'S LOC"
          Printer.Print
          Printer.FontName = "MS Serif"
          Printer.FontSize = "12"
          Printer.Print "Número do Recibo..: "; Format(cod_recibo, "000000")
          Printer.Print
          Printer.Print "Retirada "; "   --   "; " Devolução"
          Printer.Print MskDtaInic_Loc, MskDtaDevol_Loc
          Printer.Print
          Printer.Print "NÃO DISPENSAMOS TAXA DE PERMANÊNCIA"
          Printer.Print
          Printer.Print "Código do Cliente....: "; Format(TxtCodCli_Loc, "000000")
          Printer.Print "Cliente.:"; TxtNomCli_Loc
          Printer.Print
          Printer.Print "Código do CD  "; "  Valor Unitário"
          Printer.Print
          For i = 0 To LstImprime_Loc.ListCount - 1
              Printer.Print LstImprime_Loc.List(i)
          Next
          Printer.Print
          Printer.Print "Total R$  "; Format(TxtValTot_Loc, "0.00")
          If SSChkPago_Loc = True Then
           Printer.Print
           Printer.Print "LOCAÇÃO PAGA"
           Printer.Print
          End If
          Printer.Print
          Printer.Print "Locatário..: __________________________"
          Printer.Print
          Printer.Print "Fone 431-2351"
          Printer.EndDoc 'Fim da impressão do recibo
          
          'flag para não mostrar o Msgbox de Gravado com sucesso
          imprimiu_loc = "Sim"
           
          'Chama Procedure de gravar recibo
          grava_recibo
          
          'Chama a Procedure que limpa
          limpa_loc

       Else
          'Não confirmou a impressão do recibo
          'TxtNomCli_Loc.SetFocus
       End If
    End If
End Sub

Private Sub SSCmdImp_Rec_Click()
   'Executa o procedimento de impressão do RECIBO
    If DBCRecibo_Rec = "" Then
       MsgBox "Escolha um Recibo para Imprimir", 64
       DBCRecibo_Rec.SetFocus
       Exit Sub
    Else
       Msg = MsgBox("Confirma a impressão do RECIBO ? ", 36, "CONFIRMAÇÃO")
       If Msg = 6 Then   'Se a tecla acionado foi Sim
          ' Colocar o tamanho da fonte e centarlizar em 9 colunas
          'Printer.FontName = "Bazooka"
          Printer.FontSize = "12"
          Printer.Print "CD'S LOC"
          Printer.Print
          Printer.FontName = "MS Serif"
          Printer.FontSize = "8"
          Printer.Print "Número do Recibo..: "; Format(DBCRecibo_Rec, "000000")
          Printer.Print
          Printer.Print "Retirada "; "  --  "; " Devolução"
          Printer.Print data_retirada, data_devolucao
          Printer.Print
          Printer.Print "NÃO DISPENSAMOS TAXA DE PERMANÊNCIA"
          Printer.Print
          Printer.Print "Código do Cliente....: "; TxtCodCli_Rec
          Printer.Print "Cliente.:"; TxtNomCli_Rec
          Printer.Print
          Printer.Print "Código do CD  "; "  Valor Unitário"
          Printer.Print
          For i = 0 To LstImprime_Loc.ListCount - 1
              Printer.Print LstImprime_Loc.List(i)
          Next
          Printer.Print
          Printer.Print "Total R$  "; Format(valor_total, "0.00")
          If pago = "Sim" Then
             Printer.Print
             Printer.Print "LOCAÇÃO PAGA"
             Printer.Print
          End If
          Printer.Print
          Printer.Print "Locatário..: __________________________"
          Printer.Print
          Printer.Print "Fone 431-0628"
          Printer.EndDoc
       End If
       'Chama a Procedure que limpa
       limpa_rec
    End If
    DBCRecibo_Rec.SetFocus
End Sub

Private Sub SSCmdLimp_Dev_Click()
   'Chama a Procedure
   limpa_dev
End Sub

Private Sub SSCmdLimp_Loc_Click()
    'Chama a Procedure que limpa
    limpa_loc
End Sub

Private Sub SSCmdLimpCD_Loc_Click()

End Sub

Private Sub SSCmdLimp_Rec_Click()
   'Chama a Procedure que limpa
   limpa_rec
End Sub

Private Sub SSCmdSair_Dev_Click()
    LocDevol.Hide
End Sub

Private Sub SSCmdSair_Loc_Click()
    If TxtNomCli_Loc.Text <> "" Then
       MsgBox "Clique em Nova Locação para Limpar !!", 16
       SSCmdLimp_Loc.SetFocus
       Exit Sub
    End If
    LocDevol.Hide
End Sub

Private Sub SSCmdSair_Rec_Click()
    LocDevol.Hide
End Sub

Private Sub SSCmdVer_Rec_Click()
   'Chama a Procedure cosulta recibo
   cons = "Recibo"
   cons_recibo
End Sub

Private Sub SSOpt24_Loc_Click(Value As Integer)
   If SSOpt24_Loc.Value = True Then
     MskDtaDevol_Loc.Mask = ""
     MskDtaDevol_Loc.Text = ""
     MskDtaDevol_Loc.Mask = "##/##/####"
     hoje = Weekday(Now)
     If hoje = 7 Then
        MskDtaDevol_Loc.SelText = DateAdd("d", 2, MskDtaInic_Loc)
        MskDtaDevol_Loc = Format(MskDtaDevol_Loc, "dd/mm/yyyy")
     Else
        MskDtaDevol_Loc.SelText = DateAdd("d", 1, MskDtaInic_Loc)
        MskDtaDevol_Loc = Format(MskDtaDevol_Loc, "dd/mm/yyyy")
     End If
  End If
  TxtCodCD_Loc.SetFocus
End Sub

Private Sub SSOpt48_Loc_Click(Value As Integer)
  If SSOpt48_Loc.Value = True Then
     MskDtaDevol_Loc.Mask = ""
     MskDtaDevol_Loc.Text = ""
     MskDtaDevol_Loc.Mask = "##/##/####"
     hoje = Weekday(Now)
     If hoje = 7 Or hoje = 6 Then
        MskDtaDevol_Loc.SelText = DateAdd("d", 3, MskDtaInic_Loc)
        MskDtaDevol_Loc = Format(MskDtaDevol_Loc, "dd/mm/yyyy")
     Else
        MskDtaDevol_Loc.SelText = DateAdd("d", 2, MskDtaInic_Loc)
        MskDtaDevol_Loc = Format(MskDtaDevol_Loc, "dd/mm/yyyy")
     End If
  End If
  TxtCodCD_Loc.SetFocus
End Sub

Private Sub SSTab1_GotFocus()
    On Error GoTo trataerro
    If SSTab1.Tab = 0 Then
       MskDtaInic_Loc = Format(Now, "dd/mm/yyyy")
       'Cálculo do número do recibo
       Set VTb = Wrecibo
       VIx = "cod_recibo"
       VCt = "Cod_Recibo"
       cod_recibo = geracod()
       TxtCodCli_Loc.SetFocus
    ElseIf SSTab1.Tab = 1 Then
       If TxtNomCli_Loc.Text <> "" Then
          If gravou_recibo <> "Sim" Then
             grava_recibo
             limpa_loc
          End If
       End If
       MskDtaHoje_Dev = Format(Now, "dd/mm/yyyy")
       TxtRec_Dev.SetFocus
    ElseIf SSTab1.Tab = 2 Then
       If TxtNomCli_Loc.Text <> "" Then
          If gravou_recibo <> "Sim" Then
             grava_recibo
             limpa_loc
          End If
       End If
       Data_Recibo.Refresh
       DBCRecibo_Rec.SetFocus
    End If
    
trataerro:     ' Rotina de tratamento de erro
    Select Case Err.Number  ' Evaluate error number.
        Case 5
           MsgBox "Favor limpar os campos", vbInformation, "CD'S Loc"
        Case Is <> 0 ' Else
            ' Handle other situations here...
            MsgBox "Ocorreu Erro No. " & Err.Number & " , ligue p/Sandoval", 48
    End Select
End Sub


Private Sub TxtCodCD_Loc_KeyPress(KeyAscii As Integer)
    If KeyAscii = 13 Then
       SSCmdGravaCD_Loc.SetFocus
    End If
End Sub

Private Sub TxtCodCD_Loc_LostFocus()
  If TxtCodCD_Loc <> "" Then
     Wcdfisico.Index = "cod_cd"
     Wcdfisico.MoveFirst  ' Posiciona no inicio da tabela
    'Busca registro CD
     Wcdfisico.Seek "=", TxtCodCD_Loc
     
     If Wcdfisico.NoMatch Then
        res = MsgBox("O CD não consta do cadastro, Deseja Continuar ?", 68)
        If res = 6 Then
           TxtCodCD_Loc.SetFocus
        Else
           codigo_cd = ""
           'imprimir_recibo.SetFocus
        End If
        Exit Sub
     End If

     'Verifica se o CD está locado
     If Wcdfisico("locado") = True Then
        MsgBox "Este CD Encotra-se LOCADO", 64
        TxtCodCD_Loc.SetFocus
        Exit Sub
     Else
        If Wcdfisico("reservado") = True Then
           Wreserva.Index = "cod_cliente"
           Wreserva.MoveFirst
           Wreserva.Seek "=", TxtCodCli_Loc

           If Wreserva.NoMatch Then
              achou = "não"
           Else
              Do While Not Wreserva.EOF And Format(Wreserva("cod_cliente"), "000000") = TxtCodCli_Loc
                  If Wreserva("cod_cd") = Wcdfisico("cod_cd") And Wreserva("locado") = False Then
                     'Achou a reserva
                     achou = "sim"
                     Exit Do
                  End If
                  Wreserva.MoveNext
              Loop
           End If
           If achou <> "sim" Then
              MsgBox "Existe uma reserva para este CD", 16
              TxtCodCD_Loc.SetFocus
              Exit Sub
           End If
        End If
        'Busca registro Título/Valor
        cod_titulo = Wcdfisico("cod_titulo")
        Wtitulo.Index = "primarykey"
        Wtitulo.MoveFirst
        Wtitulo.Seek "=", cod_titulo
        TxtTitCD_Loc = Wtitulo("titulo")
        If Wtitulo("valor") <> 0 Then 'É uma locação com preço diferenciado
           valor_loc = Wtitulo("valor")
        Else
           wvalor_loc.MoveFirst
           If SSOpt24_Loc = True Then
              TxtValUnit_Loc = Format(wvalor_loc("loc_24"), "0.00")
           Else
              TxtValUnit_Loc = Format(wvalor_loc("loc_48"), "0.00")
           End If
        End If
    End If
  End If
  TxtCodCD_Loc = Format(TxtCodCD_Loc, ">")
End Sub


Private Sub TxtCodCli_Dev_KeyPress(KeyAscii As Integer)
     If KeyAscii = 13 Then
        TxtNomCli_Dev.SetFocus
     End If
End Sub


Private Sub TxtCodCli_Dev_LostFocus()
   If TxtCodCli_Dev <> "" Then
       'Desabilita o campo cod_cliente para não incluir outro enquanto não gravar
       TxtCodCli_Dev.Enabled = False
       If Not IsNumeric(TxtCodCli_Dev) Then
          MsgBox "Use Apenas Numeros", 64
          TxtCodCli_Dev.Enabled = True
          TxtCodCli_Dev.SetFocus
          Exit Sub
       End If
       wclien.Index = "primarykey"
       wclien.MoveFirst
       wclien.Seek "=", TxtCodCli_Dev
       If wclien.NoMatch Then
          MsgBox "Este Cliente não Existe, Tente Outro", 32
          TxtCodCli_Dev.Enabled = True
          TxtCodCli_Dev.SetFocus
          Exit Sub
       Else
          TxtCodCli_Dev = Format(wclien("codcliente"), "000000")
          TxtNomCli_Dev = wclien("nomecliente")
          If wclien("cancelado") = True Then
             MsgBox "O Cliente está CANCELADO", 16, "Atenção"
             TxtCodCli_Dev = ""
             TxtNomCli_Dev = ""
             TxtCodCli_Loc.Enabled = True
             TxtCodCli_Dev.SetFocus
             Exit Sub
          Else
              
             'Pesquisa se o cliente escolhido tem recibo na tabela recibo.
             Wrecibo.Index = "cod_cliente"
             Wrecibo.MoveFirst
             Wrecibo.Seek "=", TxtCodCli_Dev
       
             ' Pesquisa se existe mais de um recibo em aberto
             num_rec = 0
             CboRec_Dev.Clear
             While Not Wrecibo.NoMatch And Not Wrecibo.EOF
                If TxtCodCli_Dev = Format(Wrecibo("cod_cliente"), "000000") And Wrecibo("devolvido") <> True Then
                   num_rec = num_rec + 1
                   CboRec_Dev.AddItem Format(Wrecibo("cod_recibo"), "000000")
                   recibo = Wrecibo("cod_recibo")
                End If
                Wrecibo.MoveNext
             Wend

             If Wrecibo.NoMatch Or recibo = "" Then
                ' Cliente não tem recibo
                MsgBox "Não existe locação em aberto para o Cliente", 32, "Atenção"
                TxtNomCli_Dev = ""
                TxtCodCli_Dev = ""
                TxtCodCli_Dev.Enabled = True
                TxtCodCli_Dev.SetFocus
             Else
                If num_rec > 1 Then
                   MsgBox "Cliente possue mais de um recibo em aberto", 16, "Cuidado !"
                   'label7.Visible = True
                   CboRec_Dev.Visible = True
                   CboRec_Dev.SetFocus
                   Exit Sub
                Else
                   TxtRec_Dev = Format(recibo, "000000")
                End If
                TxtRec_Dev.SetFocus
                SSChkPg_Dev.SetFocus
             End If
              
          End If
       End If
    End If
End Sub

Private Sub TxtCodCli_Loc_KeyPress(KeyAscii As Integer)
   If KeyAscii = 13 Then
      TxtNomCli_Loc.SetFocus
   End If
End Sub

Private Sub TxtCodCli_Loc_LostFocus()
    If TxtCodCli_Loc <> "" Then
       'Chama a Procedure que pesquisa se o cliente tem uma reserva
       pesquisa_reserva
       'Desabilita o campo cod_cliente para não incluir outro enquanto não gravar
       TxtCodCli_Loc.Enabled = False
       If Not IsNumeric(TxtCodCli_Loc) Then
          MsgBox "Use Apenas Numeros", 64
          TxtCodCli_Loc.Enabled = True
          TxtCodCli_Loc.SetFocus
          Exit Sub
       End If
       wclien.Index = "primarykey"
       wclien.MoveFirst
       wclien.Seek "=", TxtCodCli_Loc
       If wclien.NoMatch Then
          MsgBox "Este Cliente não Existe, Tente Outro", 32
          TxtCodCli_Loc.Enabled = True
          TxtCodCli_Loc.SetFocus
          Exit Sub
       Else
          TxtCodCli_Loc = Format(wclien("codcliente"), "000000")
          TxtNomCli_Loc = wclien("nomecliente")
          If wclien("cancelado") = True Then
             MsgBox "O Cliente está CANCELADO", 16, "Atenção"
             TxtCodCli_Loc = ""
             TxtNomCli_Loc = ""
             TxtCodCli_Loc.Enabled = True
             TxtCodCli_Loc.SetFocus
             Exit Sub
          Else
             cliente_novo = "Sim"
             'locacao_24.SetFocus
             If SSOpt24_Loc.Value = True Then
                hoje = Weekday(Now)
                If hoje = 7 Then
                   MskDtaDevol_Loc.SelText = DateAdd("d", 2, MskDtaInic_Loc)
                   MskDtaDevol_Loc = Format(MskDtaDevol_Loc, "dd/mm/yyyy")
                Else
                   MskDtaDevol_Loc.SelText = DateAdd("d", 1, MskDtaInic_Loc)
                   MskDtaDevol_Loc = Format(MskDtaDevol_Loc, "dd/mm/yyyy")
                End If
             End If
          End If
       End If
    End If
End Sub


Private Sub TxtCodCli_Rec_KeyPress(KeyAscii As Integer)
    If KeyAscii = 13 Then
       TxtNomCli_Rec.SetFocus
    End If
End Sub


Private Sub TxtCodCli_Rec_LostFocus()
   If TxtCodCli_Rec <> "" Then
       'Desabilita o campo cod_cliente para não incluir outro enquanto não gravar
       TxtCodCli_Rec.Enabled = False
       If Not IsNumeric(TxtCodCli_Rec) Then
          MsgBox "Use Apenas Numeros", 64
          TxtCodCli_Rec.Enabled = True
          TxtCodCli_Rec.SetFocus
          Exit Sub
       End If
       wclien.Index = "primarykey"
       wclien.MoveFirst
       wclien.Seek "=", TxtCodCli_Rec
       If wclien.NoMatch Then
          MsgBox "Este Cliente não Existe, Tente Outro", 32
          TxtCodCli_Rec.Enabled = True
          TxtCodCli_Rec.SetFocus
          Exit Sub
       Else
          TxtCodCli_Rec = Format(wclien("codcliente"), "000000")
          TxtNomCli_Rec = wclien("nomecliente")
          If wclien("cancelado") = True Then
             MsgBox "O Cliente está CANCELADO", 16, "Atenção"
             TxtCodCli_Rec = ""
             TxtNomCli_Rec = ""
             TxtCodCli_Loc.Enabled = True
             TxtCodCli_Rec.SetFocus
             Exit Sub
          Else
              
             'Pesquisa se o cliente escolhido tem recibo na tabela recibo.
             Wrecibo.Index = "cod_cliente"
             Wrecibo.MoveFirst
             Wrecibo.Seek "=", TxtCodCli_Rec
       
             ' Pesquisa se existe mais de um recibo em aberto
             num_rec = 0
             CboRec_Rec.Clear
             While Not Wrecibo.NoMatch And Not Wrecibo.EOF
                If TxtCodCli_Rec = Format(Wrecibo("cod_cliente"), "000000") And Wrecibo("devolvido") <> True Then
                   num_rec = num_rec + 1
                   CboRec_Rec.AddItem Format(Wrecibo("cod_recibo"), "000000")
                   recibo = Wrecibo("cod_recibo")
                End If
                Wrecibo.MoveNext
             Wend

             If Wrecibo.NoMatch Or recibo = "" Then
                ' Cliente não tem recibo
                MsgBox "Não existe locação em aberto para o Cliente", 32, "Atenção"
                TxtNomCli_Rec = ""
                TxtCodCli_Rec = ""
                TxtCodCli_Rec.Enabled = True
                TxtCodCli_Rec.SetFocus
             Else
                If num_rec > 1 Then
                   MsgBox "Cliente possue mais de um recibo em aberto", 16, "Cuidado !"
                   'label7.Visible = True
                   CboRec_Rec.Visible = True
                   CboRec_Rec.SetFocus
                   Exit Sub
                Else
                   DBCRecibo_Rec = Format(recibo, "000000")
                End If
                DBCRecibo_Rec.SetFocus
             End If
              
          End If
       End If
    End If
End Sub


Private Sub TxtNomCli_Dev_KeyDown(KeyCode As Integer, Shift As Integer)
   If KeyCode = vbKeyF10 Then
       cli_dev = "Sim"
       pesquisa_cliente
   End If
End Sub


Private Sub TxtNomCli_Dev_KeyPress(KeyAscii As Integer)
   If KeyCode <> vbKeyF10 Then
      If KeyAscii = 13 Then
         TxtRec_Dev.SetFocus
      End If
   End If
End Sub


Private Sub TxtNomCli_Loc_KeyDown(KeyCode As Integer, Shift As Integer)
    If KeyCode = vbKeyF10 Then
       pesquisa_cliente
    End If
End Sub


Private Sub TxtNomCli_Loc_KeyPress(KeyAscii As Integer)
   If KeyCode <> vbKeyF10 Then
      If KeyAscii = 13 Then
         TxtCodCD_Loc.SetFocus
      End If
   End If
End Sub


Private Sub TxtNomCli_Loc_LostFocus()
    gravou_recibo = "Sim"
    
End Sub


Private Sub TxtNomCli_Rec_KeyDown(KeyCode As Integer, Shift As Integer)
    If KeyCode = vbKeyF10 Then
       cli_rec = "Sim"
       pesquisa_cliente
   End If
End Sub


Private Sub TxtNomCli_Rec_KeyPress(KeyAscii As Integer)
    If KeyCode <> vbKeyF10 Then
      If KeyAscii = 13 Then
         DBCRecibo_Rec.SetFocus
      End If
   End If
End Sub


Private Sub TxtRec_Dev_KeyPress(KeyAscii As Integer)
    If KeyAscii = 13 Then
       If TxtRec_Dev = "" Then
          TxtCodCli_Dev.SetFocus
       Else
          SSChkPg_Dev.SetFocus
       End If
    End If
End Sub

Private Sub TxtRec_Dev_LostFocus()
    If TxtRec_Dev <> "" Then
       
       'Desabilita o campo txtrec_dev para não incluir outro enquanto não gravar
       If Not IsNumeric(TxtRec_Dev) Then
          MsgBox "Use Apenas Números", 64
          TxtRec_Dev.SetFocus
          Exit Sub
       End If
       
       'Pesquisa na tabela o codigo do recibo
       Wlocacao.Index = "cod_recibo"
       Wlocacao.MoveFirst
       Wlocacao.Seek "=", Val(TxtRec_Dev)
      
       If Wlocacao.NoMatch Then
          MsgBox "Registro INEXISTENTE, Tente outro", 32
          TxtRec_Dev.Enabled = True
          TxtRec_Dev.SetFocus
          Exit Sub
       Else
          'Guarda o código para pesquisar na tabela Recibo
          cod_cliente = Wlocacao("cod_cliente")

          'Preenche as datas de devolução e locação
          MskDtaLoc_Dev = Format(Wlocacao("data_locacao"), "dd/mm/yyyy")
          MskDtaDev_Dev = Format(Wlocacao("data_devolucao"), "dd/mm/yyyy")
          TxtRec_Dev.Enabled = False
          
          ' Carrega a lista de CD'S locado
          LstItens_Dev.Clear
          While Not Wlocacao.EOF
            If Wlocacao("cod_recibo") = Val(TxtRec_Dev) Then
               LstItens_Dev.AddItem Wlocacao("cod_cd")
            End If
            Wlocacao.MoveNext
          Wend

          'Pesquisa o nome do cliente
          wclien.Index = "primarykey"
          wclien.MoveFirst
          wclien.Seek "=", cod_cliente
          TxtRec_Dev = Format(TxtRec_Dev, "000000")
          TxtCodCli_Dev = Format(wclien("codcliente"), "00000")
          TxtNomCli_Dev = wclien("nomecliente")
          
          'Pesquisa na tabela recibo o valor total para calcular o total geral
          Wrecibo.Index = "cod_recibo"
          Wrecibo.MoveFirst
          Wrecibo.Seek "=", Val(TxtRec_Dev)
          
          'If Wrecibo.NoMatch Then
             ' Verifica se o recibo já foi processado
             If Wrecibo("devolvido") = True Then
                MsgBox "Este recibo já foi devolvido", 16, "Atenção"
                limpa_dev 'Função que limpa os campos
                Exit Sub
             End If
          'End If

          If Not IsNull(Wrecibo("valor_total")) Then
            TxtValNota_Dev = Format(Wrecibo("valor_total"), "0.00")
          End If
          If MskDtaDev_Dev <> MskDtaHoje_Dev Then
             num_dias = DateDiff("d", MskDtaDev_Dev, Now)
             If num_dias = 1 Then
                xdia = "dia"
             Else
                xdia = "dias"
             End If
             MsgBox "Devolução com diferença de: " + Format(num_dias, "00") + " " + xdia
             If num_dias > 0 Then
                diferenca = Val(num_dias) * Wrecibo("valor_total")
                TxtValDif_Dev = Format(diferenca, "0.00")
             Else
                diferenca = 0
             End If
          End If
          
          'Verifica se o cliente pagou antecipado.
          If Wrecibo("data_pagamento") <> "" Then
             If diferenca = 0 Then
                SSChkPg_Dev.Value = True
             End If
             LBLAnt_Dev.Visible = True
             TxtValTot_Dev = Format(diferenca, "0.00")
          Else
             TxtValTot_Dev = Wrecibo("valor_total") + diferenca
             TxtValTot_Dev = Format(TxtValTot_Dev, "0.00")
          End If

          If wclien("cancelado") = True Then
             MsgBox "O Cliente está CANCELADO", 16, "Atenção"
             TxtRec_Dev.Text = ""
             TxtNomCli_Dev = ""
             TxtRec_Dev.Enabled = True
             TxtRec_Dev.SetFocus
             Exit Sub
          End If
       End If
    End If
End Sub


