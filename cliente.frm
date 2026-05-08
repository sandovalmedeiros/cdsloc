VERSION 5.00
Object = "{C932BA88-4374-101B-A56C-00AA003668DC}#1.1#0"; "MSMASK32.OCX"
Object = "{0BA686C6-F7D3-101A-993E-0000C0EF6F5E}#1.0#0"; "THREED32.OCX"
Object = "{BDC217C8-ED16-11CD-956C-0000C04E4C0A}#1.1#0"; "TABCTL32.OCX"
Object = "{FAEEE763-117E-101B-8933-08002B2F4F5A}#1.1#0"; "DBLIST32.OCX"
Object = "{5E9E78A0-531B-11CF-91F6-C2863C385E30}#1.0#0"; "MSFLXGRD.OCX"
Begin VB.Form Clientes 
   Caption         =   "Clientes CD'S Loc"
   ClientHeight    =   6525
   ClientLeft      =   120
   ClientTop       =   195
   ClientWidth     =   9495
   ControlBox      =   0   'False
   Icon            =   "cliente.frx":0000
   KeyPreview      =   -1  'True
   LinkTopic       =   "Form1"
   LockControls    =   -1  'True
   MDIChild        =   -1  'True
   PaletteMode     =   1  'UseZOrder
   ScaleHeight     =   6525
   ScaleWidth      =   9495
   Begin VB.Data dtaBairro 
      Caption         =   "Data_Bairro"
      Connect         =   "Access"
      DatabaseName    =   ""
      DefaultCursorType=   0  'DefaultCursor
      DefaultType     =   2  'UseODBC
      Exclusive       =   0   'False
      Height          =   345
      Left            =   3975
      Options         =   0
      ReadOnly        =   0   'False
      RecordsetType   =   2  'Snapshot
      RecordSource    =   "Bairro"
      Top             =   6615
      Visible         =   0   'False
      Width           =   2340
   End
   Begin TabDlg.SSTab SSTab1 
      Height          =   6555
      Left            =   0
      TabIndex        =   20
      Top             =   0
      Width           =   9510
      _ExtentX        =   16775
      _ExtentY        =   11562
      _Version        =   327681
      Tabs            =   2
      TabHeight       =   529
      ForeColor       =   16711680
      TabCaption(0)   =   "     Clientes      "
      Tab(0).ControlEnabled=   -1  'True
      Tab(0).Control(0)=   "SSPanel24"
      Tab(0).Control(0).Enabled=   0   'False
      Tab(0).Control(1)=   "SSPanel23"
      Tab(0).Control(1).Enabled=   0   'False
      Tab(0).Control(2)=   "SSPanel22"
      Tab(0).Control(2).Enabled=   0   'False
      Tab(0).Control(3)=   "SSPanel21"
      Tab(0).Control(3).Enabled=   0   'False
      Tab(0).Control(4)=   "SSPanel20"
      Tab(0).Control(4).Enabled=   0   'False
      Tab(0).Control(5)=   "SSPanel19"
      Tab(0).Control(5).Enabled=   0   'False
      Tab(0).Control(6)=   "SSFrame6"
      Tab(0).Control(6).Enabled=   0   'False
      Tab(0).Control(7)=   "SSFrame5"
      Tab(0).Control(7).Enabled=   0   'False
      Tab(0).Control(8)=   "SSFrame4"
      Tab(0).Control(8).Enabled=   0   'False
      Tab(0).Control(9)=   "SSFrame2"
      Tab(0).Control(9).Enabled=   0   'False
      Tab(0).Control(10)=   "SSFrame1"
      Tab(0).Control(10).Enabled=   0   'False
      Tab(0).ControlCount=   11
      TabCaption(1)   =   " Dependentes "
      Tab(1).ControlEnabled=   0   'False
      Tab(1).Control(0)=   "SSFrame7"
      Tab(1).ControlCount=   1
      Begin Threed.SSFrame SSFrame1 
         Height          =   2775
         Left            =   75
         TabIndex        =   21
         Top             =   375
         Width           =   9180
         _Version        =   65536
         _ExtentX        =   16193
         _ExtentY        =   4895
         _StockProps     =   14
         Caption         =   "Dados Pessoais"
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
         Begin MSDBCtls.DBCombo dbcBairro 
            Bindings        =   "cliente.frx":0442
            Height          =   315
            Left            =   5370
            TabIndex        =   4
            Top             =   1650
            Width           =   2130
            _ExtentX        =   3757
            _ExtentY        =   556
            _Version        =   327681
            ListField       =   "deBairro"
            BoundColumn     =   "cdBairro"
            Text            =   ""
         End
         Begin VB.ListBox LstNom_Cli 
            Height          =   645
            Left            =   1200
            TabIndex        =   27
            Tag             =   "DBTTip:Lista dos Clientes pesquisados"
            Top             =   810
            Width           =   4755
         End
         Begin Threed.SSPanel SSPanel1 
            Height          =   345
            Left            =   105
            TabIndex        =   25
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
            Begin VB.TextBox TxtCod_Cli 
               Appearance      =   0  'Flat
               Height          =   315
               Left            =   15
               MaxLength       =   6
               TabIndex        =   0
               Tag             =   "Código do Cliente"
               Top             =   15
               Width           =   855
            End
         End
         Begin Threed.SSPanel SSPanel2 
            Height          =   345
            Left            =   1185
            TabIndex        =   26
            Top             =   405
            Width           =   4800
            _Version        =   65536
            _ExtentX        =   8467
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
            Begin VB.TextBox TxtNom_Cli 
               Appearance      =   0  'Flat
               Height          =   315
               Left            =   15
               TabIndex        =   1
               Tag             =   "DBTTip:Use a Tecla F10 para PESQUISAR O CLIENTE pelo Nome o Partícula do Nome/Sobrenome"
               Top             =   15
               Width           =   4770
            End
         End
         Begin Threed.SSPanel SSPanel3 
            Height          =   345
            Left            =   6135
            TabIndex        =   28
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
            Begin MSMask.MaskEdBox MskDta_Nasc 
               Height          =   315
               Left            =   15
               TabIndex        =   2
               Top             =   15
               Width           =   1185
               _ExtentX        =   2090
               _ExtentY        =   556
               _Version        =   327681
               Appearance      =   0
               MaxLength       =   10
               Mask            =   "##/##/####"
               PromptChar      =   " "
            End
         End
         Begin Threed.SSFrame SSFrame3 
            Height          =   990
            Left            =   7545
            TabIndex        =   29
            Top             =   255
            Width           =   1530
            _Version        =   65536
            _ExtentX        =   2709
            _ExtentY        =   1736
            _StockProps     =   14
            Caption         =   "Situação"
            ForeColor       =   16711680
            BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
               Name            =   "MS Sans Serif"
               Size            =   8.2
               Charset         =   0
               Weight          =   400
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            Begin VB.OptionButton OptCanc_Cli 
               Caption         =   "Cancelado"
               ForeColor       =   &H000000FF&
               Height          =   195
               Left            =   90
               TabIndex        =   43
               Tag             =   "DBTTip:Cliente cancelado por diversos motivos"
               Top             =   660
               Width           =   1170
            End
            Begin VB.OptionButton OptAtivo_Cli 
               Caption         =   "Ativo"
               ForeColor       =   &H00FF0000&
               Height          =   195
               Left            =   105
               TabIndex        =   42
               Tag             =   "DBTTip:Cliente em Atividade"
               Top             =   330
               Value           =   -1  'True
               Width           =   1245
            End
         End
         Begin Threed.SSPanel SSPanel4 
            Height          =   360
            Left            =   105
            TabIndex        =   30
            Top             =   1635
            Width           =   5175
            _Version        =   65536
            _ExtentX        =   9128
            _ExtentY        =   635
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
            Begin VB.TextBox TxtEnd_Cli 
               Appearance      =   0  'Flat
               Height          =   330
               Left            =   15
               TabIndex        =   3
               Top             =   15
               Width           =   5145
            End
         End
         Begin Threed.SSPanel SSPanel6 
            Height          =   345
            Left            =   120
            TabIndex        =   31
            Top             =   2250
            Width           =   1095
            _Version        =   65536
            _ExtentX        =   1931
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
            Begin MSMask.MaskEdBox MskCep_Cli 
               Height          =   315
               Left            =   15
               TabIndex        =   5
               Top             =   15
               Width           =   1065
               _ExtentX        =   1879
               _ExtentY        =   556
               _Version        =   327681
               Appearance      =   0
               MaxLength       =   9
               Mask            =   "#####-###"
               PromptChar      =   " "
            End
         End
         Begin Threed.SSPanel SSPanel7 
            Height          =   345
            Left            =   1335
            TabIndex        =   32
            Top             =   2265
            Width           =   1260
            _Version        =   65536
            _ExtentX        =   2222
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
            Begin MSMask.MaskEdBox MskTel1_Cli 
               Height          =   315
               Left            =   15
               TabIndex        =   6
               Top             =   15
               Width           =   1230
               _ExtentX        =   2170
               _ExtentY        =   556
               _Version        =   327681
               Appearance      =   0
               MaxLength       =   9
               Mask            =   "####-####"
               PromptChar      =   " "
            End
         End
         Begin Threed.SSPanel SSPanel8 
            Height          =   345
            Left            =   3720
            TabIndex        =   33
            Top             =   2265
            Width           =   1620
            _Version        =   65536
            _ExtentX        =   2857
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
            Begin MSMask.MaskEdBox MskCpf_Cli 
               Height          =   315
               Left            =   15
               TabIndex        =   8
               Top             =   15
               Width           =   1590
               _ExtentX        =   2805
               _ExtentY        =   556
               _Version        =   327681
               Appearance      =   0
               MaxLength       =   14
               Mask            =   "###.###.###-##"
               PromptChar      =   " "
            End
         End
         Begin Threed.SSPanel SSPanel9 
            Height          =   345
            Left            =   5385
            TabIndex        =   34
            Top             =   2235
            Width           =   1635
            _Version        =   65536
            _ExtentX        =   2884
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
            Begin VB.TextBox TxtIdent_Cli 
               Appearance      =   0  'Flat
               Height          =   315
               Left            =   15
               TabIndex        =   9
               Top             =   15
               Width           =   1605
            End
         End
         Begin Threed.SSPanel SSPanel10 
            Height          =   345
            Left            =   7080
            TabIndex        =   35
            Top             =   2220
            Width           =   765
            _Version        =   65536
            _ExtentX        =   1349
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
            Begin VB.TextBox TxtExp_Cli 
               Appearance      =   0  'Flat
               Height          =   315
               Left            =   15
               TabIndex        =   10
               Top             =   15
               Width           =   735
            End
         End
         Begin Threed.SSPanel SSPanel11 
            Height          =   345
            Left            =   7860
            TabIndex        =   36
            Top             =   2220
            Width           =   1230
            _Version        =   65536
            _ExtentX        =   2170
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
            Begin MSMask.MaskEdBox MskDta_Exp 
               Height          =   315
               Left            =   15
               TabIndex        =   11
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
         Begin Threed.SSPanel SSPanel30 
            Height          =   345
            Left            =   2745
            TabIndex        =   92
            Top             =   2280
            Width           =   765
            _Version        =   65536
            _ExtentX        =   1349
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
            Begin VB.TextBox txtRamalRes 
               Appearance      =   0  'Flat
               Height          =   315
               Left            =   15
               TabIndex        =   7
               Top             =   15
               Width           =   735
            End
         End
         Begin Threed.SSPanel SSPanel31 
            Height          =   345
            Left            =   7515
            TabIndex        =   93
            Top             =   1620
            Width           =   1545
            _Version        =   65536
            _ExtentX        =   2725
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
            Begin VB.TextBox txtMunicCli 
               Appearance      =   0  'Flat
               Height          =   315
               Left            =   15
               Locked          =   -1  'True
               TabIndex        =   94
               Top             =   15
               Width           =   1515
            End
         End
         Begin VB.Label Label19 
            AutoSize        =   -1  'True
            Caption         =   "Ramal"
            Height          =   195
            Left            =   2760
            TabIndex        =   96
            Top             =   2070
            Width           =   450
         End
         Begin VB.Label Label18 
            AutoSize        =   -1  'True
            Caption         =   "Município"
            Height          =   195
            Left            =   7530
            TabIndex        =   95
            Top             =   1410
            Width           =   705
         End
         Begin VB.Label Label10 
            AutoSize        =   -1  'True
            Caption         =   "Data Exped."
            Height          =   195
            Left            =   7860
            TabIndex        =   56
            Top             =   2025
            Width           =   885
         End
         Begin VB.Label Label9 
            AutoSize        =   -1  'True
            Caption         =   "Exped."
            Height          =   195
            Left            =   7095
            TabIndex        =   55
            Top             =   2010
            Width           =   495
         End
         Begin VB.Label Label8 
            AutoSize        =   -1  'True
            Caption         =   "Identidade"
            Height          =   195
            Left            =   5400
            TabIndex        =   54
            Top             =   2040
            Width           =   750
         End
         Begin VB.Label Label7 
            AutoSize        =   -1  'True
            Caption         =   "C.P.F."
            Height          =   195
            Left            =   3735
            TabIndex        =   53
            Top             =   2055
            Width           =   435
         End
         Begin VB.Label Label6 
            AutoSize        =   -1  'True
            Caption         =   "Telefone Resid."
            Height          =   195
            Left            =   1320
            TabIndex        =   52
            Top             =   2055
            Width           =   1125
         End
         Begin VB.Label Label5 
            AutoSize        =   -1  'True
            Caption         =   "CEP"
            Height          =   195
            Left            =   120
            TabIndex        =   51
            Top             =   2070
            Width           =   315
         End
         Begin VB.Label Label4 
            AutoSize        =   -1  'True
            Caption         =   "Bairro"
            Height          =   195
            Left            =   5355
            TabIndex        =   50
            Top             =   1455
            Width           =   405
         End
         Begin VB.Label Label3 
            AutoSize        =   -1  'True
            Caption         =   "Endereço"
            Height          =   195
            Left            =   120
            TabIndex        =   49
            Top             =   1410
            Width           =   690
         End
         Begin VB.Label Label2 
            AutoSize        =   -1  'True
            Caption         =   "Data Nascimento"
            Height          =   195
            Left            =   6150
            TabIndex        =   48
            Top             =   165
            Width           =   1230
         End
         Begin VB.Label Label1 
            AutoSize        =   -1  'True
            Caption         =   "Nome "
            Height          =   195
            Left            =   1200
            TabIndex        =   47
            Top             =   195
            Width           =   465
         End
      End
      Begin Threed.SSFrame SSFrame2 
         Height          =   1515
         Left            =   45
         TabIndex        =   22
         Top             =   3195
         Width           =   6735
         _Version        =   65536
         _ExtentX        =   11880
         _ExtentY        =   2672
         _StockProps     =   14
         Caption         =   "Dados Comerciais"
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
         Begin Threed.SSPanel SSPanel12 
            Height          =   360
            Left            =   75
            TabIndex        =   37
            Top             =   405
            Width           =   5175
            _Version        =   65536
            _ExtentX        =   9128
            _ExtentY        =   635
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
            Begin VB.TextBox TxtEmp_Cli 
               Appearance      =   0  'Flat
               Height          =   330
               Left            =   15
               TabIndex        =   12
               Top             =   15
               Width           =   5145
            End
         End
         Begin Threed.SSPanel SSPanel13 
            Height          =   360
            Left            =   5370
            TabIndex        =   38
            Top             =   420
            Width           =   1200
            _Version        =   65536
            _ExtentX        =   2117
            _ExtentY        =   635
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
            Begin MSMask.MaskEdBox MskTel2_Cli 
               Height          =   336
               Left            =   12
               TabIndex        =   13
               Top             =   12
               Width           =   1176
               _ExtentX        =   2064
               _ExtentY        =   582
               _Version        =   327681
               Appearance      =   0
               MaxLength       =   9
               Mask            =   "####-####"
               PromptChar      =   " "
            End
         End
         Begin Threed.SSPanel SSPanel14 
            Height          =   360
            Left            =   75
            TabIndex        =   39
            Top             =   990
            Width           =   5175
            _Version        =   65536
            _ExtentX        =   9128
            _ExtentY        =   635
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
            Begin VB.TextBox TxtEndEmp_Cli 
               Appearance      =   0  'Flat
               Height          =   330
               Left            =   15
               TabIndex        =   14
               Top             =   15
               Width           =   5145
            End
         End
         Begin Threed.SSPanel SSPanel32 
            Height          =   345
            Left            =   5355
            TabIndex        =   97
            Top             =   1005
            Width           =   765
            _Version        =   65536
            _ExtentX        =   1349
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
            Begin VB.TextBox txtRamalTrab 
               Appearance      =   0  'Flat
               Height          =   315
               Left            =   15
               TabIndex        =   15
               Top             =   15
               Width           =   735
            End
         End
         Begin VB.Label Label20 
            AutoSize        =   -1  'True
            Caption         =   "Ramal"
            Height          =   195
            Left            =   5370
            TabIndex        =   98
            Top             =   810
            Width           =   450
         End
         Begin VB.Label Label13 
            AutoSize        =   -1  'True
            Caption         =   "Endereço"
            Height          =   195
            Left            =   75
            TabIndex        =   59
            Top             =   765
            Width           =   690
         End
         Begin VB.Label Label12 
            AutoSize        =   -1  'True
            Caption         =   "Telefone "
            Height          =   195
            Left            =   5370
            TabIndex        =   58
            Top             =   210
            Width           =   675
         End
         Begin VB.Label Label11 
            AutoSize        =   -1  'True
            Caption         =   "Empresa"
            Height          =   195
            Left            =   75
            TabIndex        =   57
            Top             =   195
            Width           =   615
         End
      End
      Begin Threed.SSFrame SSFrame4 
         Height          =   1560
         Left            =   5730
         TabIndex        =   23
         Top             =   4755
         Width           =   3645
         _Version        =   65536
         _ExtentX        =   6429
         _ExtentY        =   2752
         _StockProps     =   14
         Caption         =   "Dependentes"
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
         Begin MSFlexGridLib.MSFlexGrid msfDependente 
            Height          =   1080
            Left            =   90
            TabIndex        =   99
            Top             =   285
            Width           =   3465
            _ExtentX        =   6112
            _ExtentY        =   1905
            _Version        =   65541
            FormatString    =   "Cód  | Nome Dependente                             "
         End
      End
      Begin Threed.SSFrame SSFrame5 
         Height          =   930
         Left            =   45
         TabIndex        =   24
         Top             =   4725
         Width           =   5535
         _Version        =   65536
         _ExtentX        =   9758
         _ExtentY        =   1630
         _StockProps     =   14
         Caption         =   "Referência Pessoal"
         ForeColor       =   16711680
         BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
            Name            =   "MS Sans Serif"
            Size            =   8.2
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Begin Threed.SSPanel SSPanel15 
            Height          =   360
            Left            =   120
            TabIndex        =   40
            Top             =   480
            Width           =   3990
            _Version        =   65536
            _ExtentX        =   7038
            _ExtentY        =   635
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
            Begin VB.TextBox TxtRef_Cli 
               Appearance      =   0  'Flat
               Height          =   330
               Left            =   15
               TabIndex        =   16
               Top             =   15
               Width           =   3960
            End
         End
         Begin Threed.SSPanel SSPanel16 
            Height          =   360
            Left            =   4200
            TabIndex        =   41
            Top             =   480
            Width           =   1200
            _Version        =   65536
            _ExtentX        =   2117
            _ExtentY        =   635
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
            Begin MSMask.MaskEdBox MskTel3_Cli 
               Height          =   336
               Left            =   12
               TabIndex        =   17
               Top             =   12
               Width           =   1176
               _ExtentX        =   2064
               _ExtentY        =   582
               _Version        =   327681
               Appearance      =   0
               MaxLength       =   9
               Mask            =   "####-####"
               PromptChar      =   " "
            End
         End
         Begin VB.Label Label14 
            AutoSize        =   -1  'True
            Caption         =   "Telefone"
            Height          =   195
            Left            =   4200
            TabIndex        =   72
            Top             =   240
            Width           =   630
         End
      End
      Begin Threed.SSFrame SSFrame6 
         Height          =   705
         Left            =   60
         TabIndex        =   44
         Top             =   5640
         Width           =   5535
         _Version        =   65536
         _ExtentX        =   9763
         _ExtentY        =   1244
         _StockProps     =   14
         Caption         =   "Observações e Data da Inscrição"
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
         Begin Threed.SSPanel SSPanel17 
            Height          =   360
            Left            =   105
            TabIndex        =   45
            Top             =   255
            Width           =   3990
            _Version        =   65536
            _ExtentX        =   7038
            _ExtentY        =   635
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
            Begin VB.TextBox TxtObs_Cli 
               Appearance      =   0  'Flat
               Height          =   330
               Left            =   15
               TabIndex        =   18
               Top             =   15
               Width           =   3960
            End
         End
         Begin Threed.SSPanel SSPanel18 
            Height          =   360
            Left            =   4230
            TabIndex        =   46
            Top             =   240
            Width           =   1200
            _Version        =   65536
            _ExtentX        =   2117
            _ExtentY        =   635
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
            Begin MSMask.MaskEdBox MskDta_Cad 
               Height          =   336
               Left            =   12
               TabIndex        =   19
               Top             =   12
               Width           =   1176
               _ExtentX        =   2064
               _ExtentY        =   582
               _Version        =   327681
               Appearance      =   0
               MaxLength       =   10
               Mask            =   "##/##/####"
               PromptChar      =   " "
            End
         End
      End
      Begin Threed.SSPanel SSPanel19 
         Height          =   495
         Left            =   6840
         TabIndex        =   60
         Top             =   3360
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
         Begin Threed.SSCommand SSCmdGrava_Cli 
            Height          =   465
            Left            =   15
            TabIndex        =   61
            ToolTipText     =   "Grava o Cliente"
            Top             =   15
            Width           =   705
            _Version        =   65536
            _ExtentX        =   1244
            _ExtentY        =   820
            _StockProps     =   78
            Picture         =   "cliente.frx":0456
         End
      End
      Begin Threed.SSPanel SSPanel20 
         Height          =   495
         Left            =   7680
         TabIndex        =   62
         Top             =   3360
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
         Begin Threed.SSCommand SSCmdLimp_Cli 
            Height          =   465
            Left            =   15
            TabIndex        =   63
            ToolTipText     =   "Novo Cliente"
            Top             =   15
            Width           =   705
            _Version        =   65536
            _ExtentX        =   1244
            _ExtentY        =   820
            _StockProps     =   78
            Picture         =   "cliente.frx":0568
         End
      End
      Begin Threed.SSPanel SSPanel21 
         Height          =   495
         Left            =   6855
         TabIndex        =   64
         Top             =   4065
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
         Begin Threed.SSCommand SSCmdExc_Cli 
            Height          =   465
            Left            =   15
            TabIndex        =   65
            ToolTipText     =   "Apaga o Registro do Cliente"
            Top             =   15
            Width           =   705
            _Version        =   65536
            _ExtentX        =   1244
            _ExtentY        =   820
            _StockProps     =   78
            Picture         =   "cliente.frx":067A
         End
      End
      Begin Threed.SSPanel SSPanel22 
         Height          =   495
         Left            =   7680
         TabIndex        =   66
         Top             =   4050
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
         Begin Threed.SSCommand SSCmdCons_Cli 
            Height          =   465
            Left            =   15
            TabIndex        =   67
            ToolTipText     =   "Cadastra Dependente(s)"
            Top             =   15
            Width           =   705
            _Version        =   65536
            _ExtentX        =   1244
            _ExtentY        =   820
            _StockProps     =   78
            Picture         =   "cliente.frx":0ACC
         End
      End
      Begin Threed.SSPanel SSPanel23 
         Height          =   495
         Left            =   8520
         TabIndex        =   68
         Top             =   3360
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
         Begin Threed.SSCommand SSCmdImp_Cli 
            Height          =   465
            Left            =   15
            TabIndex        =   69
            ToolTipText     =   "Imprime os Relatórios"
            Top             =   15
            Width           =   705
            _Version        =   65536
            _ExtentX        =   1244
            _ExtentY        =   820
            _StockProps     =   78
            Picture         =   "cliente.frx":0DE6
         End
      End
      Begin Threed.SSPanel SSPanel24 
         Height          =   495
         Left            =   8535
         TabIndex        =   70
         Top             =   4050
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
         Begin Threed.SSCommand SSCmdSai_Cli 
            Height          =   465
            Left            =   15
            TabIndex        =   71
            ToolTipText     =   "Sair da Rotina Clientes"
            Top             =   15
            Width           =   705
            _Version        =   65536
            _ExtentX        =   1244
            _ExtentY        =   820
            _StockProps     =   78
            Picture         =   "cliente.frx":0EF8
         End
      End
      Begin Threed.SSFrame SSFrame7 
         Height          =   5370
         Left            =   -74805
         TabIndex        =   73
         Top             =   660
         Width           =   8400
         _Version        =   65536
         _ExtentX        =   14817
         _ExtentY        =   9462
         _StockProps     =   14
         Caption         =   "Dependentes dos Clientes CD'S Loc"
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
         Begin VB.TextBox TxtCodCli_Dep 
            Height          =   345
            Left            =   5295
            MaxLength       =   50
            TabIndex        =   91
            Tag             =   "DBTTip:Código do Cliente "
            Top             =   2775
            Width           =   960
         End
         Begin VB.ListBox LstNomCli_Dep 
            Height          =   645
            Left            =   450
            TabIndex        =   79
            Tag             =   "DBTTip:Lista dos Cliente Pesquisado"
            Top             =   3195
            Width           =   4695
         End
         Begin VB.TextBox TxtNomCli_Dep 
            Height          =   345
            Left            =   450
            MaxLength       =   50
            TabIndex        =   78
            Tag             =   "DBTTip:Use a Tecla F10 para pesquisar os Clientes por Nome ou Particulia do Nome"
            Top             =   2775
            Width           =   4695
         End
         Begin VB.ListBox LstNom_Dep 
            Height          =   645
            Left            =   420
            TabIndex        =   76
            Top             =   1230
            Width           =   4695
         End
         Begin VB.TextBox TxtNom_Dep 
            Height          =   345
            Left            =   435
            MaxLength       =   50
            TabIndex        =   74
            Tag             =   "DBTTip:Use a Tecla F10 para Pesquisar o Dependente por Nome ou Partícula do Nome"
            Top             =   825
            Width           =   4695
         End
         Begin Threed.SSPanel SSPanel25 
            Height          =   495
            Left            =   435
            TabIndex        =   80
            Top             =   4425
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
            Begin Threed.SSCommand SSCmdGrava_Dep 
               Height          =   465
               Left            =   15
               TabIndex        =   81
               Tag             =   "DBTTip:Grava o registro"
               Top             =   15
               Width           =   705
               _Version        =   65536
               _ExtentX        =   1244
               _ExtentY        =   820
               _StockProps     =   78
               Picture         =   "cliente.frx":139A
            End
         End
         Begin Threed.SSPanel SSPanel26 
            Height          =   495
            Left            =   1410
            TabIndex        =   82
            Top             =   4440
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
            Begin Threed.SSCommand SSCmdLimp_Dep 
               Height          =   465
               Left            =   15
               TabIndex        =   83
               Tag             =   "DBTTip:Novo Registro "
               Top             =   15
               Width           =   705
               _Version        =   65536
               _ExtentX        =   1244
               _ExtentY        =   820
               _StockProps     =   78
               Picture         =   "cliente.frx":14AC
            End
         End
         Begin Threed.SSPanel SSPanel27 
            Height          =   495
            Left            =   2370
            TabIndex        =   84
            Top             =   4440
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
            Begin Threed.SSCommand SSCmdImp_Dep 
               Height          =   465
               Left            =   15
               TabIndex        =   85
               Tag             =   "DBTTip:Impressão dos Relatórios"
               Top             =   15
               Width           =   705
               _Version        =   65536
               _ExtentX        =   1244
               _ExtentY        =   820
               _StockProps     =   78
               Picture         =   "cliente.frx":15BE
            End
         End
         Begin Threed.SSPanel SSPanel28 
            Height          =   495
            Left            =   3330
            TabIndex        =   86
            Top             =   4440
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
            Begin Threed.SSCommand SSCmdExc_Dep 
               Height          =   465
               Left            =   15
               TabIndex        =   87
               Tag             =   "DBTTip:Apaga um Registro"
               Top             =   15
               Width           =   705
               _Version        =   65536
               _ExtentX        =   1244
               _ExtentY        =   820
               _StockProps     =   78
               Picture         =   "cliente.frx":16D0
            End
         End
         Begin Threed.SSPanel SSPanel29 
            Height          =   495
            Left            =   4350
            TabIndex        =   88
            Top             =   4440
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
            Begin Threed.SSCommand SSCmdSai_Dep 
               Height          =   465
               Left            =   15
               TabIndex        =   89
               Tag             =   "DBTTip:Sair da Rotina "
               Top             =   15
               Width           =   705
               _Version        =   65536
               _ExtentX        =   1244
               _ExtentY        =   820
               _StockProps     =   78
               Picture         =   "cliente.frx":1B22
            End
         End
         Begin VB.Label Label17 
            AutoSize        =   -1  'True
            Caption         =   "Codigo"
            Height          =   195
            Left            =   5310
            TabIndex        =   90
            Top             =   2550
            Width           =   495
         End
         Begin VB.Label Label16 
            AutoSize        =   -1  'True
            Caption         =   "Nome do Cliente"
            Height          =   195
            Left            =   435
            TabIndex        =   77
            Top             =   2550
            Width           =   1170
         End
         Begin VB.Label Label15 
            AutoSize        =   -1  'True
            Caption         =   "Nome do Dependente"
            Height          =   195
            Left            =   420
            TabIndex        =   75
            Top             =   555
            Width           =   1575
         End
      End
   End
End
Attribute VB_Name = "Clientes"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Dim pesq_dep As String
Dim pesq_cli As String
Dim mensagem As String
Dim nome_anterior As String
Dim cdBairro As Integer
Dim cod_dependente As String
Private Sub dados_cliente()
     'Carrega a lista de dependentes
     LstNomDep_Cli.Clear
     Wdependente.MoveFirst
     While Not Wdependente.EOF
        If Wdependente("cod_cliente") = wclien("codcliente") Then
           LstNomDep_Cli.AddItem Wdependente("nome_dependente")
        End If
        Wdependente.MoveNext
     Wend

     msgI = "Atualização"
     Atualiza = "Sim" ' Variável que indica que o registro foi editado

     'Carrega os campos
     TxtCod_Cli.Text = Format(wclien("codcliente"), "0000")
     TxtNom_Cli = wclien("nomecliente")
     If Not IsNull(wclien("data-nascimento")) Then
        MskDta_Nasc.SelText = Format(wclien("data-nascimento"), "dd/mm/yyyy")
     End If
     TxtEnd_Cli = wclien("endereco")
     TxtBairro_Cli = wclien("bairro")
     TxtIdent_Cli = wclien("identidade")
     If Not IsNull(wclien("cep")) Then
        MskCep_Cli.SelText = wclien("cep")
     End If
     If Not IsNull(wclien("cic")) Then
        MskCpf_Cli.SelText = Format(wclien("cic"), "###.###.###-##")
     End If
     If Not IsNull(wclien("expedidor")) Then
        TxtExp_Cli = wclien("expedidor")
     End If
     If Not IsNull(wclien("data-expedicao")) Then
        MskDta_Exp.SelText = Format(wclien("data-expedicao"), "dd/mm/yyyy")
     End If
     If Not IsNull(wclien("fone-01")) Then
        MskTel1_Cli.SelText = Format(wclien("fone-01"), "####-####")
     End If
     If Not IsNull(wclien("fone-02")) Then
        MskTel2_Cli.SelText = Format(wclien("fone-02"), "####-####")
     End If
     If Not IsNull(wclien("fone-03")) Then
        MskTel3_Cli.SelText = Format(wclien("fone-03"), "####-####")
     End If
     If Not IsNull(wclien("empresa")) Then
        TxtEmp_Cli = wclien("empresa")
     End If
     If Not IsNull(wclien("end-comercial")) Then
        TxtEndEmp_Cli = wclien("end-comercial")
     End If
     If Not IsNull(wclien("referencia-pessoal")) Then
        TxtRef_Cli = wclien("referencia-pessoal")
     End If
     If Not IsNull(wclien("data-inscricao")) Then
        MskDta_Cad.SelText = Format(wclien("data-inscricao"), "dd/mm/yyyy")
     End If
     If wclien("cancelado") = False Then
        OptAtivo_Cli = True
        SSCmdCons_Cli.Enabled = True
     Else
        OptCanc_Cli = True
        SSCmdCons_Cli.Enabled = False
     End If
     If Not IsNull(wclien("obs")) Then
        TxtObs_Cli = wclien("obs")
     End If
End Sub

Private Sub Dados_Cliente2()
    'Passa parametro para Consulta e gera o Objeto
    Set QDCliente = wbanco.QueryDefs("Cs_Clientes")
    QDCliente!cdcliente = TxtCod_Cli.Text
    Set DSCliente = QDCliente.OpenRecordset(dbOpenDynaset)
    
    If DSCliente.RecordCount <> 0 Then
       
       'Chama a Proc que Procura os DSependentes e Eche o Grid
       EncheGrid
       
       msgI = "Atualização"
       Atualiza = "Sim" ' Variável que indica que o registro foi editado

      'Carrega os campos
      TxtCod_Cli.Text = Format(DSCliente("codcliente"), "0000")
      TxtNom_Cli.Text = DSCliente("nomecliente")
      If Not IsNull(DSCliente("data-nascimento")) Then
         MskDta_Nasc.SelText = Format(DSCliente("data-nascimento"), "dd/mm/yyyy")
      End If
      TxtEnd_Cli.Text = DSCliente("endereco")
      dbcBairro.Text = DSCliente("debairro")
      cdBairro = DSCliente!cdBairro
      txtMunicCli.Text = DSCliente!deMunic
      If Not IsNull(DSCliente!Ramal_res) Then txtRamalRes.Text = DSCliente!Ramal_res
      If Not IsNull(DSCliente!Ramal_trab) Then txtRamalTrab.Text = DSCliente!Ramal_trab
      TxtIdent_Cli.Text = DSCliente("identidade")
      If Not IsNull(DSCliente("cep")) Then
         MskCep_Cli.SelText = DSCliente("cep")
      End If
      If Not IsNull(DSCliente("cic")) Then
         MskCpf_Cli.SelText = Format(DSCliente("cic"), "###.###.###-##")
      End If
      If Not IsNull(DSCliente("expedidor")) Then
         TxtExp_Cli.Text = DSCliente("expedidor")
      End If
      If Not IsNull(DSCliente("data-expedicao")) Then
        MskDta_Exp.SelText = Format(DSCliente("data-expedicao"), "dd/mm/yyyy")
      End If
      If Not IsNull(DSCliente("fone-01")) Then
         MskTel1_Cli.SelText = Format(DSCliente("fone-01"), "####-####")
      End If
      If Not IsNull(DSCliente("fone-02")) Then
         MskTel2_Cli.SelText = Format(DSCliente("fone-02"), "####-####")
      End If
      If Not IsNull(DSCliente("fone-03")) Then
         MskTel3_Cli.SelText = Format(DSCliente("fone-03"), "####-####")
      End If
      If Not IsNull(DSCliente("empresa")) Then
         TxtEmp_Cli.Text = DSCliente("empresa")
      End If
      If Not IsNull(DSCliente("end-comercial")) Then
         TxtEndEmp_Cli.Text = DSCliente("end-comercial")
      End If
      If Not IsNull(DSCliente("referencia-pessoal")) Then
         TxtRef_Cli.Text = DSCliente("referencia-pessoal")
      End If
      If Not IsNull(DSCliente("data-inscricao")) Then
         MskDta_Cad.SelText = Format(DSCliente("data-inscricao"), "dd/mm/yyyy")
      End If
      If DSCliente("cancelado") = False Then
         OptAtivo_Cli.Value = True
         SSCmdCons_Cli.Enabled = True
      Else
         OptCanc_Cli.Value = True
         SSCmdCons_Cli.Enabled = False
      End If
      If Not IsNull(DSCliente("obs")) Then
         TxtObs_Cli.Text = DSCliente("obs")
      End If
 Else
    'Novo Cliente
     msgI = "Inclusão"
     Atualiza = "Não" ' Variável que indica que o registro foi editado
     'DSCliente.Close
 End If
End Sub






Private Sub pesquisa_cliente()
     Msg = "Digite o Nome/Sobrenome a ser Pesquisado"
     tit = "CD'S Loc - Pesquisa Cliente"
     Pesq_Nome = InputBox(Msg, tit)
     'inicio da rotina para escolha de um cliente
     If Pesq_Nome <> "" Then
        If pesq_cli = "Sim" Then
           LstNom_Cli.Clear
        ElseIf pesq_dep = "Sim" Then
           LstNomCli_Dep.Clear
        End If
        wclien.MoveFirst
        While Not wclien.EOF
          ' Pesquisa Cliente
          pesquisa = InStr(wclien!nomecliente, UCase(Pesq_Nome)) ' Maiúsculas
          pesquisa2 = InStr(wclien!nomecliente, Pesq_Nome) ' Minúsculas
          If pesquisa <> 0 Or pesquisa2 <> 0 Then
             If pesq_cli = "Sim" Then
                LstNom_Cli.AddItem wclien("nomecliente")
             ElseIf pesq_dep = "Sim" Then
                LstNomCli_Dep.AddItem wclien("nomecliente")
             End If
          End If
          wclien.MoveNext
        Wend
     End If
     pesq_cli = ""
     pesq_dep = ""
End Sub


Private Sub dbcBairro_Click(Area As Integer)
   cdBairro = Val(dbcBairro.BoundText)
End Sub

Private Sub Form_KeyPress(KeyAscii As Integer)
   If KeyAscii = 13 Then
      SendKeys Chr(9)
   End If
End Sub

Private Sub Form_Load()
    
    With Clientes
       .Left = 1245
       .Height = 6945
       .Width = 9630
       .Top = 435
    End With
    
    Set vformu = Clientes
    
    msgI = "Inclusão"
    Set VTb = wclien
    VIx = "primarykey"
    VCt = "Codcliente"
    TxtCod_Cli = geracod()
    TxtCod_Cli = Format(TxtCod_Cli, "0000")
    
    'Seta o data
    ChDir App.Path 'muda para diretório de carga
    SQLData = "select cdbairro,debairro from bairro order by debairro"
    dtaBairro.DatabaseName = App.Path & "\bd_cdloc.mdb"
    dtaBairro.RecordSource = SQLData
    dtaBairro.Refresh

End Sub

Private Sub LstNom_Cli_Click()
    TxtNom_Cli = LstNom_Cli
    wclien.Index = "nomecliente"
    wclien.MoveFirst
    wclien.Seek "=", LstNom_Cli.Text
    If wclien.NoMatch Then
       ' Cliente Não Cadastrado
       msgI = "Inclusão"
       mensagem = "Incluir"
    Else
       mensagem = "Alterar"
       TxtCod_Cli = wclien("codcliente")
       Msg = MsgBox("Voçê selecionou o Cliente ? " + TxtCod_Cli + "  " + LstNom_Cli.Text, 36)
       If Msg = 7 Then 'Resposta = Não
          TxtNom_Cli = ""
          TxtCod_Cli = ""
          Exit Sub
       End If
       'Chama a Procedure para preencher os campos
       Dados_Cliente2
       TxtNom_Cli.SetFocus
    End If
End Sub

Private Sub LstNom_Dep_Click()
    TxtNom_Dep = LstNom_Dep
    Wdependente.Index = "nome_dependente"
    Wdependente.MoveFirst
    Wdependente.Seek "=", LstNom_Dep.Text
    If Wdependente.NoMatch Then
       ' Cliente Não Cadastrado
       'msgI = "Inclusão"
       'mensagem = "Incluir"
    Else
       mensagem = "Alterar"
       Msg = MsgBox("Voçê selecionou o Dependente ? " + LstNom_Dep.Text, 36)
       If Msg = 7 Then 'Resposta = Não
          TxtNom_Dep = ""
          TxtCodCli_Dep = ""
          Exit Sub
       Else
          nome_anterior = TxtNom_Dep 'variavel usada para troca no list
          cod_dependente = Wdependente("cod_dependente")
          TxtCodCli_Dep = Format(Wdependente("cod_cliente"), "0000")
          wclien.Index = "primarykey"
          wclien.MoveFirst  ' Posiciona no inicio da tabela
          wclien.Seek "=", TxtCodCli_Dep.Text
          TxtNomCli_Dep = wclien("nomecliente")
          ' Carrega a lista de dependentes
          LstNom_Dep.Clear
          Wdependente.MoveFirst
          While Not Wdependente.EOF
             If Wdependente("cod_cliente") = wclien("codcliente") Then
                LstNom_Dep.AddItem Wdependente("nome_dependente")
             End If
             Wdependente.MoveNext
          Wend
       End If
       TxtNom_Dep.SetFocus
    End If
End Sub

Private Sub LstNomCli_Dep_Click()
    TxtNomCli_Dep = LstNomCli_Dep
    wclien.Index = "nomecliente"
    wclien.MoveFirst
    wclien.Seek "=", LstNomCli_Dep.Text
    If wclien.NoMatch Then
       ' Cliente Não Cadastrado
       'msgI = "Inclusão"
       'mensagem = "Incluir"
    Else
       'mensagem = "Alterar"
       TxtCodCli_Dep = Format(wclien("codcliente"), "0000")
       Msg = MsgBox("Voçê selecionou o Cliente ? " + TxtCodCli_Dep + "  " + LstNomCli_Dep.Text, 36)
       If Msg = 7 Then 'Resposta = Não
          TxtNomCli_Dep = ""
          TxtCodCli_Dep = ""
          Exit Sub
       End If
       ' Carrega a lista de dependentes
       LstNom_Dep.Clear
       Wdependente.MoveFirst
       While Not Wdependente.EOF
          If Wdependente("cod_cliente") = wclien("codcliente") Then
             LstNom_Dep.AddItem Wdependente("nome_dependente")
          End If
          Wdependente.MoveNext
       Wend
       TxtNomCli_Dep.SetFocus
    End If
End Sub

Private Sub MskCep_Cli_KeyPress(KeyAscii As Integer)
 '   If KeyAscii = 13 Then
 '     MskTel1_Cli.SetFocus
 '  End If
End Sub

Private Sub MskCpf_Cli_KeyPress(KeyAscii As Integer)
 '   If KeyAscii = 13 Then
 '     TxtIdent_Cli.SetFocus
 '  End If
End Sub

Private Sub MskDta_Cad_LostFocus()
   If Not IsDate(MskDta_Cad) Then
      MsgBox "Data Inválida", 16
      MskDta_Cad.SetFocus
   End If
End Sub

Private Sub MskDta_Exp_KeyPress(KeyAscii As Integer)
 '  If KeyAscii = 13 Then
 '     TxtEmp_Cli.SetFocus
 '  End If
End Sub

Private Sub MskDta_Exp_LostFocus()
    If Not IsDate(MskDta_Exp) Then
       MsgBox "Data Inválida", 16
       MskDta_Exp.SetFocus
    End If
End Sub


Private Sub MskDta_Nasc_KeyPress(KeyAscii As Integer)
 '  If KeyAscii = 13 Then
 '     TxtEnd_Cli.SetFocus
 '  End If
End Sub

Private Sub MskDta_Nasc_LostFocus()
    If Not IsDate(MskDta_Nasc) Then
       MsgBox "Data Inválida", 16
       MskDta_Nasc.SetFocus
    End If
End Sub


Private Sub MskTel1_Cli_KeyPress(KeyAscii As Integer)
  '  If KeyAscii = 13 Then
  '    MskCpf_Cli.SetFocus
  ' End If
End Sub

Private Sub MskTel2_Cli_KeyPress(KeyAscii As Integer)
  ' If KeyAscii = 13 Then
  '    TxtEndEmp_Cli.SetFocus
  ' End If
End Sub

Private Sub MskTel3_Cli_KeyPress(KeyAscii As Integer)
 '  If KeyAscii = 13 Then
 '     TxtObs_Cli.SetFocus
 '  End If
End Sub

Private Sub SSCmdCons_Cli_Click()
   If OptCanc_Cli = True Then
      MsgBox "O Cliente encontra-se CANCELADO", 32
      TxtCod_Cli.SetFocus
      Exit Sub
   Else
      wclien.Index = "primarykey"
      wclien.MoveFirst  ' Posiciona no inicio da tabela
      'Busca registro
       wclien.Seek "=", TxtCod_Cli.Text
      If wclien.NoMatch Then
          MsgBox "Voce Precisa Selecionar ou Gravar O Cliente", 32
          TxtCod_Cli.SetFocus
          Exit Sub
       Else
          cod_cliente = wclien("codcliente")
          Cad_Depend.Show vbModal
      End If
   End If
End Sub

Private Sub SSCmdExc_Cli_Click()
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
       TxtCod_Cli.SetFocus
    Else
       If wclien.RecordCount <> 0 Then
          wclien.Index = "primarykey"
          wclien.MoveFirst
          wclien.Seek "=", TxtCod_Cli
      
          If Not wclien.NoMatch Then
             'Apaga registro do Banco de Dados
             wclien.Delete
          Else
             MsgBox "SELECIONE registro para EXCLUIR", 32
          End If
       Else
          MsgBox "Não existe registro para EXCLUIR", 32
       End If
    End If
    'Chama a Procedure que Limpa
    LimpaCampos
    'Gera novo Código
    wclien.MoveFirst
    GeraCodigo
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
    TxtCod_Cli.SetFocus
    Exit Sub
    Resume  ' Resume execution at same line
                ' that caused the error.
End Sub

Private Sub SSCmdExc_Dep_Click()
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
       TxtNom_Dep.SetFocus
    Else
       If Wdependente.RecordCount <> 0 Then
          Wdependente.Index = "cod_cliente"
          Wdependente.MoveFirst
          Wdependente.Seek "=", TxtCodCli_Dep, cod_dependente
      
          If Not Wdependente.NoMatch Then
             'Apaga registro do Banco de Dados
             Wdependente.Delete
             For i = 0 To LstNom_Dep.ListCount - 1
                 If LstNom_Dep.List(i) = nome_anterior Then
                    LstNom_Dep.RemoveItem i
                    Exit For
                 End If
             Next
          Else
             MsgBox "SELECIONE registro para EXCLUIR", 32
          End If
       Else
          MsgBox "Não existe registro para EXCLUIR", 32
       End If
    End If
    TxtNom_Dep = ""
    TxtNom_Dep.SetFocus
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
    TxtNom_Dep.SetFocus
    Exit Sub
    Resume  ' Resume execution at same line
                ' that caused the error.
End Sub

Private Sub SSCmdGrava_Cli_Click()
   Dim MeuObjeto As Object
   Dim Texto As String
   If TxtCod_Cli.Text = "" Then
      Set MeuObjeto = TxtCod_Cli
      Texto = "Código do Cliente"
   ElseIf TxtNom_Cli.Text = "" Then
      Set MeuObjeto = TxtNom_Cli
      Texto = "Nome do Cliente"
   ElseIf TxtEnd_Cli.Text = "" Then
      Set MeuObjeto = TxtEnd_Cli
      Texto = "Endereço do Cliente"
   ElseIf MskDta_Nasc.Text = "" Then
      Set MeuObjeto = MskDta_Nasc
      Texto = "Data de Nascimento do Cliente"
   ElseIf cdBairro = 0 Then
      Set MeuObjeto = dbcBairro
      Texto = "Bairro do Cliente"
   ElseIf TxtIdent_Cli.Text = "" Then
      Set MeuObjeto = TxtIdent_Cli
      Texto = "Identidade do Cliente"
   End If
   If Texto <> "" Then
      If Texto = "Bairro do Cliente" Then
         MsgBox "O Campo " + Texto + " Deve ser Escolhido da Lista e não pode ficar em branco", 48, "AVISO"
      Else
         MsgBox "O Campo " + Texto + " não pode ficar em branco", 48, "AVISO"
      End If
      MeuObjeto.SetFocus
      Exit Sub
   Else
      Msg = MsgBox("Confirme a " + msgI, 36, "CONFIRMAÇÃO")
      If Msg = 6 Then   'Se a tecla acionado foi Sim
         If Atualiza = "Sim" Then
             DSCliente.Edit
         Else
            DSCliente.AddNew
            DSCliente("codcliente") = Format(TxtCod_Cli.Text, "0000")
         End If
         DSCliente("nomecliente") = TxtNom_Cli.Text
         DSCliente("endereco") = TxtEnd_Cli.Text
         If MskDta_Nasc.Text <> "  /  /    " Then DSCliente("data-nascimento") = MskDta_Nasc.Text
         DSCliente("cdbairro") = cdBairro
         DSCliente("cep") = MskCep_Cli.Text
         DSCliente("fone-01") = MskTel1_Cli.Text
         DSCliente("ramal_res") = txtRamalRes.Text
         DSCliente("ramal_trab") = txtRamalTrab.Text
         DSCliente("fone-02") = MskTel2_Cli.Text
         DSCliente("fone-03") = MskTel3_Cli.Text
         DSCliente("identidade") = TxtIdent_Cli.Text
         DSCliente("expedidor") = TxtExp_Cli.Text
         If MskDta_Exp.Text <> "  /  /    " Then DSCliente("data-expedicao") = MskDta_Exp.Text
         DSCliente("cic") = MskCpf_Cli.Text
         DSCliente("empresa") = TxtEmp_Cli.Text
         DSCliente("end-comercial") = TxtEndEmp_Cli.Text
         DSCliente("referencia-pessoal") = TxtRef_Cli.Text
         If MskDta_Cad.Text <> "  /  /    " Then DSCliente("data-inscricao") = MskDta_Cad.Text
         DSCliente("obs") = TxtObs_Cli.Text
         If OptAtivo_Cli.Value = False Then
            DSCliente("cancelado") = True
         Else
            DSCliente("cancelado") = False
            SSCmdCons_Cli.Enabled = True
         End If
         DSCliente.Update 'Grava no banco
         gravou = "Sim"
      Else
         MsgBox "Operação Cancelada pelo usuário", 48, "AVISO"
         gravou = "Não"
         LimpaCampos
         GeraCodigo
      End If
   End If
   DSCliente.Requery
   wclien.MoveFirst
End Sub

Private Sub SSCmdGrava_Dep_Click()
     Dim Msg
     If TxtNom_Dep = "" Then
        MsgBox "O Campo Nome do Dependente não pode ficar vazio", 48, "AVISO"
        TxtNom_Dep.SetFocus
     Else
        If mensagem = "Alterar" Then
           Msg = "Confirma a Alteração do Dependente ?"  ' Define message.
        Else
           Msg = "Confirma a Inclusão do Dependente ?"  ' Define message.
        End If
        Style = vbYesNo + vbCritical + vbDefaultButton1 ' Define buttons.
        Title = "CD'S Loc - Atenção !!"  ' Define title.
        Help = "DEMO.HLP"   ' Define Help file.
        Ctxt = 1000 ' Define topic
                    ' context.
        ' Display message.
        resposta = MsgBox(Msg, Style, Title, Help, Ctxt)
        If resposta = vbYes Then   'Se a tecla acionado foi o OK
           If mensagem <> "Alterar" Then
              Wdependente.AddNew
              Wdependente("cod_cliente") = TxtCodCli_Dep
           Else
              Wdependente.Edit
              For i = 0 To LstNom_Dep.ListCount - 1
                 If LstNom_Dep.List(i) = nome_anterior Then
                    LstNom_Dep.RemoveItem i
                    Exit For
                 End If
             Next
           End If
           LstNom_Dep.AddItem TxtNom_Dep 'inclui novo nome no list
           Wdependente("nome_dependente") = TxtNom_Dep
           Wdependente.Update 'Grava no banco
           TxtNom_Dep = ""
           TxtNom_Dep.SetFocus
       Else
           MsgBox "Operação Cancelada", 48, "AVISO"
           TxtNom_Dep = ""
           TxtNom_Dep.SetFocus
       End If
     End If
     nome_anterior = ""
     mensagem = ""
End Sub

Private Sub SSCmdImp_Cli_Click()
   tipo_relat = "Cliente"
   Rel_CliDEp.Show vbModal
End Sub

Private Sub SSCmdImp_Dep_Click()
   tipo_relat = "Dependentes"
   Rel_CliDEp.Show vbModal
End Sub

Private Sub SSCmdLimp_Cli_Click()
  LimpaCampos
  OptAtivo_Cli = True
  SSCmdCons_Cli.Enabled = True
  GeraCodigo
End Sub

Private Sub SSCmdLimp_Dep_Click()
   LimpaCampos
   mensagem = ""
   nome_anterior = ""
   cod_dependente = ""
   pesq_cli = ""
   pesq_dep = ""
   TxtNom_Dep.SetFocus
   GeraCodigo
End Sub

Private Sub SSCmdSai_Cli_Click()
  Clientes.Hide
End Sub


Private Sub SSCmdSai_Dep_Click()
   Clientes.Hide
End Sub

Private Sub SSTab1_GotFocus()
   If SSTab1.Tab = 0 Then
      TxtCod_Cli.SetFocus
   ElseIf SSTab1.Tab = 1 Then
      TxtNom_Dep.SetFocus
   End If
End Sub


Private Sub TxtBairro_Cli_KeyPress(KeyAscii As Integer)
    If KeyAscii = 13 Then
       MskCep_Cli.SetFocus
    End If
End Sub


Private Sub TxtCod_Cli_KeyPress(KeyAscii As Integer)
 '  If KeyAscii = 13 Then
 '     TxtNom_Cli.SetFocus
 '  End If
End Sub

Private Sub TxtCod_Cli_LostFocus()
 If TxtCod_Cli <> "" Then
    If Not IsNumeric(TxtCod_Cli) Then
       MsgBox "Só é permitido o uso de Números", 64
       TxtCod_Cli.SetFocus
       Exit Sub
    End If
    'limpacampos2
    gravou = "Não"
   ' wclien.Index = "primarykey"
   ' wclien.MoveFirst  ' Posiciona no inicio da tabela
    'Busca registro
   '  wclien.Seek "=", TxtCod_Cli.Text
   '  If wclien.NoMatch Then
   '     TxtNom_Cli.SetFocus
   '     Exit Sub
   '  End If
     'Chama a procedure que preenche os dados do cliente
     Dados_Cliente2
            
 End If
End Sub




Private Sub TxtEmp_Cli_KeyPress(KeyAscii As Integer)
 '  If KeyAscii = 13 Then
 '     MskTel2_Cli.SetFocus
 '  End If
End Sub


Private Sub TxtEnd_Cli_KeyPress(KeyAscii As Integer)
 '  If KeyAscii = 13 Then
 '     TxtBairro_Cli.SetFocus
 '  End If
End Sub


Private Sub TxtEndEmp_Cli_KeyPress(KeyAscii As Integer)
 '  If KeyAscii = 13 Then
 '     TxtRef_Cli.SetFocus
 '  End If
End Sub


Private Sub txtexp_cli_KeyPress(KeyAscii As Integer)
 '  If KeyAscii = 13 Then
 '     MskDta_Exp.SetFocus
 '  End If
End Sub


Private Sub TxtIdent_Cli_KeyPress(KeyAscii As Integer)
 '   If KeyAscii = 13 Then
 '     TxtExp_Cli.SetFocus
 '  End If
End Sub
Private Sub TxtNom_Cli_KeyDown(KeyCode As Integer, Shift As Integer)
    If KeyCode = vbKeyF10 Then
       pesq_cli = "Sim"
       pesquisa_cliente
    End If
End Sub

Private Sub TxtNom_Cli_KeyPress(KeyAscii As Integer)
   'If KeyCode <> vbKeyF10 Then
      'If KeyAscii = 13 Then
      '   MskDta_Nasc.SetFocus
      'End If
  ' End If
End Sub


Private Sub TxtNom_Dep_KeyDown(KeyCode As Integer, Shift As Integer)
   If KeyCode = vbKeyF10 Then
       Msg = "Digite o Nome/Sobrenome a ser Pesquisado"
       tit = "CD'S Loc - Pesquisa Dependente"
       Pesq_Nome = InputBox(Msg, tit)
        'inicio da rotina para escolha de um cliente
       If Pesq_Nome <> "" Then
          LstNom_Dep.Clear
          Wdependente.MoveFirst
          While Not Wdependente.EOF
            ' Pesquisa Cliente
            pesquisa = InStr(Wdependente!nome_dependente, UCase(Pesq_Nome)) ' Maiúsculas
            pesquisa2 = InStr(Wdependente!nome_dependente, Pesq_Nome) ' Minúsculas
            If pesquisa <> 0 Or pesquisa2 <> 0 Then
               LstNom_Dep.AddItem Wdependente("nome_dependente")
            End If
            Wdependente.MoveNext
          Wend
       End If
    End If
End Sub

Private Sub TxtNom_Dep_KeyPress(KeyAscii As Integer)
    If KeyCode <> vbKeyF10 Then
      If KeyAscii = 13 Then
         TxtNomCli_Dep.SetFocus
      End If
   End If
End Sub


Private Sub txtnomcli_dep_KeyDown(KeyCode As Integer, Shift As Integer)
    If KeyCode = vbKeyF10 Then
       pesq_dep = "Sim"
       pesquisa_cliente
    End If
End Sub


Private Sub TxtObs_Cli_KeyPress(KeyAscii As Integer)
 '  If KeyAscii = 13 Then
 '     MskDta_Cad.SetFocus
 '   End If
End Sub


Private Sub TxtRef_Cli_KeyPress(KeyAscii As Integer)
 '  If KeyAscii = 13 Then
 '     MskTel3_Cli.SetFocus
 '  End If
End Sub

Private Sub GeraCodigo()
    DSCliente.Requery
    wclien.MoveFirst
    'Gera um novo código
    msgI = "Inclusão"
    Atualiza = "Não"
    Set VTb = wclien
    VIx = "primarykey"
    VCt = "Codcliente"
    TxtCod_Cli = geracod()
   ' wclien.MoveLast
   ' TxtCod_Cli.Text = wclien!codcliente + 1
    TxtCod_Cli = Format(TxtCod_Cli, "0000")
    TxtCod_Cli.SetFocus
End Sub
Public Sub EncheGrid()
    With msfDependente
        .Text = Empty
        Vtxt = .FormatString
        .Clear
        .Rows = 2
        .FormatString = Vtxt
        
         'Passa parametro para Consulta e gera o Objeto
         Set QDDep = wbanco.QueryDefs("Cs_Dependente")
         QDDep!cdcliente = TxtCod_Cli.Text
         Set DSDependente = QDDep.OpenRecordset
         
         If DSDependente.RecordCount <> o Then
            'Carrega o MsflexGrid do(s) dependentes
            ' FormatAjuste
             DSDependente.MoveFirst
             X = 1
             Do While Not DSDependente.EOF
                If X > 1 Then
                   .Rows = .Rows + 1
                End If
                .Row = X
                .Col = 0
                .Text = Format(DSDependente!cod_dependente, "000")
                .Col = 1
                .Text = DSDependente!nome_dependente
             
                DSDependente.MoveNext
             
                X = X + 1
             Loop
         End If
  End With
End Sub
