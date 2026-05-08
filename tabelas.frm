VERSION 5.00
Object = "{0BA686C6-F7D3-101A-993E-0000C0EF6F5E}#1.0#0"; "THREED32.OCX"
Object = "{BDC217C8-ED16-11CD-956C-0000C04E4C0A}#1.1#0"; "TABCTL32.OCX"
Object = "{FAEEE763-117E-101B-8933-08002B2F4F5A}#1.1#0"; "DBLIST32.OCX"
Begin VB.Form Tabelas 
   Caption         =   "Tabelas"
   ClientHeight    =   6480
   ClientLeft      =   15
   ClientTop       =   630
   ClientWidth     =   9495
   ControlBox      =   0   'False
   Icon            =   "tabelas.frx":0000
   LinkTopic       =   "Form1"
   MDIChild        =   -1  'True
   PaletteMode     =   1  'UseZOrder
   ScaleHeight     =   6480
   ScaleWidth      =   9495
   Begin TabDlg.SSTab SSTab1 
      Height          =   6480
      Left            =   0
      TabIndex        =   0
      Top             =   15
      Width           =   9495
      _ExtentX        =   16748
      _ExtentY        =   11430
      _Version        =   327681
      Tabs            =   5
      Tab             =   2
      TabHeight       =   529
      ForeColor       =   16711680
      TabCaption(0)   =   "Intérprete"
      TabPicture(0)   =   "tabelas.frx":0442
      Tab(0).ControlEnabled=   0   'False
      Tab(0).Control(0)=   "SSFrame5"
      Tab(0).Control(1)=   "SSFrame2"
      Tab(0).ControlCount=   2
      TabCaption(1)   =   "Grupo"
      Tab(1).ControlEnabled=   0   'False
      Tab(1).Control(0)=   "SSFrame1"
      Tab(1).Control(1)=   "SSFrame3"
      Tab(1).Control(2)=   "Data_Grupo"
      Tab(1).ControlCount=   3
      TabCaption(2)   =   "Estilo"
      TabPicture(2)   =   "tabelas.frx":045E
      Tab(2).ControlEnabled=   -1  'True
      Tab(2).Control(0)=   "SSFrame7"
      Tab(2).Control(0).Enabled=   0   'False
      Tab(2).Control(1)=   "SSFrame6"
      Tab(2).Control(1).Enabled=   0   'False
      Tab(2).Control(2)=   "SSFrame4"
      Tab(2).Control(2).Enabled=   0   'False
      Tab(2).Control(3)=   "Data_Estilo"
      Tab(2).Control(3).Enabled=   0   'False
      Tab(2).ControlCount=   4
      TabCaption(3)   =   "Bairro"
      TabPicture(3)   =   "tabelas.frx":047A
      Tab(3).ControlEnabled=   0   'False
      Tab(3).Control(0)=   "SSFrame10"
      Tab(3).Control(1)=   "SSFrame9"
      Tab(3).Control(2)=   "SSFrame8"
      Tab(3).Control(3)=   "dtaBairro"
      Tab(3).ControlCount=   4
      TabCaption(4)   =   "Município"
      TabPicture(4)   =   "tabelas.frx":0496
      Tab(4).ControlEnabled=   0   'False
      Tab(4).Control(0)=   "SSFrame12"
      Tab(4).Control(1)=   "SSFrame11"
      Tab(4).Control(2)=   "dtaMunic"
      Tab(4).ControlCount=   3
      Begin VB.Data dtaBairro 
         Caption         =   "Data_Bairro"
         Connect         =   "Access"
         DatabaseName    =   ""
         DefaultCursorType=   0  'DefaultCursor
         DefaultType     =   2  'UseODBC
         Exclusive       =   0   'False
         Height          =   345
         Left            =   -71205
         Options         =   0
         ReadOnly        =   0   'False
         RecordsetType   =   2  'Snapshot
         RecordSource    =   "Bairro"
         Top             =   5880
         Visible         =   0   'False
         Width           =   2340
      End
      Begin VB.Data dtaMunic 
         Caption         =   "Data_Munic"
         Connect         =   "Access"
         DatabaseName    =   ""
         DefaultCursorType=   0  'DefaultCursor
         DefaultType     =   2  'UseODBC
         Exclusive       =   0   'False
         Height          =   345
         Left            =   -71070
         Options         =   0
         ReadOnly        =   0   'False
         RecordsetType   =   2  'Snapshot
         RecordSource    =   "Municipio"
         Top             =   5715
         Visible         =   0   'False
         Width           =   2340
      End
      Begin VB.Data Data_Estilo 
         Caption         =   "Data_Estilo"
         Connect         =   "Access"
         DatabaseName    =   ""
         DefaultCursorType=   0  'DefaultCursor
         DefaultType     =   2  'UseODBC
         Exclusive       =   0   'False
         Height          =   300
         Left            =   3570
         Options         =   0
         ReadOnly        =   0   'False
         RecordsetType   =   2  'Snapshot
         RecordSource    =   ""
         Top             =   6075
         Visible         =   0   'False
         Width           =   2640
      End
      Begin VB.Data Data_Grupo 
         Caption         =   "Data_Grupo"
         Connect         =   "Access"
         DatabaseName    =   ""
         DefaultCursorType=   0  'DefaultCursor
         DefaultType     =   2  'UseODBC
         Exclusive       =   0   'False
         Height          =   345
         Left            =   -71445
         Options         =   0
         ReadOnly        =   0   'False
         RecordsetType   =   2  'Snapshot
         RecordSource    =   "grupo"
         Top             =   5850
         Visible         =   0   'False
         Width           =   2340
      End
      Begin Threed.SSFrame SSFrame2 
         Height          =   3120
         Left            =   -73875
         TabIndex        =   1
         Top             =   1305
         Width           =   6330
         _Version        =   65536
         _ExtentX        =   11165
         _ExtentY        =   5503
         _StockProps     =   14
         Caption         =   "Cadastre Aqui o Intérprete"
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
         Begin VB.ListBox LstNom_Int 
            Height          =   1035
            Left            =   1335
            TabIndex        =   2
            Tag             =   "DBTTip:Lista dos Intérpretes pesquisado"
            Top             =   1140
            Width           =   4275
         End
         Begin Threed.SSPanel SSPanel4 
            Height          =   345
            Left            =   195
            TabIndex        =   3
            Top             =   690
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
            Begin VB.TextBox TxtCod_Int 
               Appearance      =   0  'Flat
               Height          =   315
               Left            =   15
               MaxLength       =   6
               TabIndex        =   4
               Tag             =   "DBTTip:Código do Intérprete"
               Top             =   15
               Width           =   855
            End
         End
         Begin Threed.SSPanel SSPanel7 
            Height          =   345
            Left            =   1335
            TabIndex        =   5
            Top             =   690
            Width           =   4290
            _Version        =   65536
            _ExtentX        =   7567
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
            Begin VB.TextBox TxtNom_Int 
               Appearance      =   0  'Flat
               Height          =   315
               Left            =   15
               MaxLength       =   50
               TabIndex        =   6
               Tag             =   "DBTTip:Use F10 para fazer a pesquisa por nome ou partícula do nome."
               Top             =   15
               Width           =   4260
            End
         End
         Begin VB.Label Label12 
            AutoSize        =   -1  'True
            Caption         =   "Nome do Intérprete"
            Height          =   195
            Left            =   1335
            TabIndex        =   8
            Top             =   465
            Width           =   1365
         End
         Begin VB.Label Label13 
            AutoSize        =   -1  'True
            Caption         =   "Cód. Interp."
            Height          =   195
            Left            =   195
            TabIndex        =   7
            Top             =   465
            Width           =   825
         End
      End
      Begin Threed.SSFrame SSFrame5 
         Height          =   1080
         Left            =   -73095
         TabIndex        =   9
         Top             =   4785
         Width           =   4725
         _Version        =   65536
         _ExtentX        =   8334
         _ExtentY        =   1905
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
         Begin Threed.SSPanel SSPanel27 
            Height          =   495
            Left            =   120
            TabIndex        =   10
            Top             =   360
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
            Begin Threed.SSCommand SSCmdGrava_Cd 
               Height          =   465
               Left            =   15
               TabIndex        =   11
               Tag             =   "DBTTip:Grava o Intérprete"
               Top             =   15
               Width           =   705
               _Version        =   65536
               _ExtentX        =   1244
               _ExtentY        =   820
               _StockProps     =   78
               Picture         =   "tabelas.frx":04B2
            End
         End
         Begin Threed.SSPanel SSPanel28 
            Height          =   495
            Left            =   1020
            TabIndex        =   12
            Top             =   345
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
            Begin Threed.SSCommand SSCmdLimp_Int 
               Height          =   465
               Left            =   15
               TabIndex        =   13
               Tag             =   "DBTTip:Novo Interprete"
               Top             =   15
               Width           =   705
               _Version        =   65536
               _ExtentX        =   1244
               _ExtentY        =   820
               _StockProps     =   78
               Picture         =   "tabelas.frx":05C4
            End
         End
         Begin Threed.SSPanel SSPanel29 
            Height          =   495
            Left            =   1965
            TabIndex        =   14
            Top             =   345
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
            Begin Threed.SSCommand SSCmdExc_Int 
               Height          =   465
               Left            =   15
               TabIndex        =   15
               Tag             =   "DBTTip:Apaga o Intérprete"
               Top             =   15
               Width           =   705
               _Version        =   65536
               _ExtentX        =   1244
               _ExtentY        =   820
               _StockProps     =   78
               Picture         =   "tabelas.frx":06D6
            End
         End
         Begin Threed.SSPanel SSPanel30 
            Height          =   495
            Left            =   2910
            TabIndex        =   16
            Top             =   345
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
            Begin Threed.SSCommand SSCmdImp_Int 
               Height          =   465
               Left            =   15
               TabIndex        =   17
               Tag             =   "DBTTip:Imprime os Relatórios"
               Top             =   15
               Width           =   705
               _Version        =   65536
               _ExtentX        =   1244
               _ExtentY        =   820
               _StockProps     =   78
               Picture         =   "tabelas.frx":0B28
            End
         End
         Begin Threed.SSPanel SSPanel31 
            Height          =   495
            Left            =   3825
            TabIndex        =   18
            Top             =   345
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
            Begin Threed.SSCommand SSCmdSair_Int 
               Height          =   465
               Left            =   15
               TabIndex        =   19
               Tag             =   "DBTTip:Sair da Rotina "
               Top             =   15
               Width           =   705
               _Version        =   65536
               _ExtentX        =   1244
               _ExtentY        =   820
               _StockProps     =   78
               Picture         =   "tabelas.frx":0C3A
            End
         End
      End
      Begin Threed.SSFrame SSFrame3 
         Height          =   1080
         Left            =   -72600
         TabIndex        =   20
         Top             =   4665
         Width           =   4725
         _Version        =   65536
         _ExtentX        =   8334
         _ExtentY        =   1905
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
         Begin Threed.SSPanel SSPanel3 
            Height          =   495
            Left            =   120
            TabIndex        =   21
            Top             =   360
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
            Begin Threed.SSCommand SSCmdGrava_Grp 
               Height          =   465
               Left            =   15
               TabIndex        =   22
               Tag             =   "DBTTip:Grava o Grupo"
               Top             =   15
               Width           =   705
               _Version        =   65536
               _ExtentX        =   1244
               _ExtentY        =   820
               _StockProps     =   78
               Picture         =   "tabelas.frx":10DC
            End
         End
         Begin Threed.SSPanel SSPanel5 
            Height          =   495
            Left            =   1020
            TabIndex        =   23
            Top             =   345
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
            Begin Threed.SSCommand SSCmdLimp_Grp 
               Height          =   465
               Left            =   15
               TabIndex        =   24
               Tag             =   "DBTTip:Novo Grupo"
               Top             =   15
               Width           =   705
               _Version        =   65536
               _ExtentX        =   1244
               _ExtentY        =   820
               _StockProps     =   78
               Picture         =   "tabelas.frx":11EE
            End
         End
         Begin Threed.SSPanel SSPanel6 
            Height          =   495
            Left            =   1965
            TabIndex        =   25
            Top             =   345
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
            Begin Threed.SSCommand SSCmdExc_Grp 
               Height          =   465
               Left            =   15
               TabIndex        =   26
               Tag             =   "DBTTip:Apaga o Grupo"
               Top             =   15
               Width           =   705
               _Version        =   65536
               _ExtentX        =   1244
               _ExtentY        =   820
               _StockProps     =   78
               Picture         =   "tabelas.frx":1300
            End
         End
         Begin Threed.SSPanel SSPanel8 
            Height          =   495
            Left            =   2910
            TabIndex        =   27
            Top             =   345
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
            Begin Threed.SSCommand SSCmdImp_Grp 
               Height          =   465
               Left            =   15
               TabIndex        =   28
               Tag             =   "DBTTip:Imprime os Relatórios"
               Top             =   15
               Width           =   705
               _Version        =   65536
               _ExtentX        =   1244
               _ExtentY        =   820
               _StockProps     =   78
               Picture         =   "tabelas.frx":1752
            End
         End
         Begin Threed.SSPanel SSPanel9 
            Height          =   495
            Left            =   3825
            TabIndex        =   29
            Top             =   345
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
            Begin Threed.SSCommand SSCmdSai_Grp 
               Height          =   465
               Left            =   15
               TabIndex        =   30
               Tag             =   "DBTTip:Sair da Rotina "
               Top             =   15
               Width           =   705
               _Version        =   65536
               _ExtentX        =   1244
               _ExtentY        =   820
               _StockProps     =   78
               Picture         =   "tabelas.frx":1864
            End
         End
      End
      Begin Threed.SSFrame SSFrame4 
         Height          =   1080
         Left            =   2415
         TabIndex        =   31
         Top             =   4965
         Width           =   4725
         _Version        =   65536
         _ExtentX        =   8334
         _ExtentY        =   1905
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
            TabIndex        =   32
            Top             =   360
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
            Begin Threed.SSCommand SSCmdGrava_Est 
               Height          =   465
               Left            =   15
               TabIndex        =   33
               Tag             =   "DBTTip:Grava o Estilo"
               Top             =   15
               Width           =   705
               _Version        =   65536
               _ExtentX        =   1244
               _ExtentY        =   820
               _StockProps     =   78
               Picture         =   "tabelas.frx":1D06
            End
         End
         Begin Threed.SSPanel SSPanel10 
            Height          =   495
            Left            =   1020
            TabIndex        =   34
            Top             =   345
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
            Begin Threed.SSCommand SSCmdLimp_Est 
               Height          =   465
               Left            =   15
               TabIndex        =   35
               Tag             =   "DBTTip:Novo Estilo"
               Top             =   15
               Width           =   705
               _Version        =   65536
               _ExtentX        =   1244
               _ExtentY        =   820
               _StockProps     =   78
               Picture         =   "tabelas.frx":1E18
            End
         End
         Begin Threed.SSPanel SSPanel11 
            Height          =   495
            Left            =   1965
            TabIndex        =   36
            Top             =   345
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
            Begin Threed.SSCommand SSCmdExc_Est 
               Height          =   465
               Left            =   15
               TabIndex        =   37
               Tag             =   "DBTTip:Apaga o Estilo"
               Top             =   15
               Width           =   705
               _Version        =   65536
               _ExtentX        =   1244
               _ExtentY        =   820
               _StockProps     =   78
               Picture         =   "tabelas.frx":1F2A
            End
         End
         Begin Threed.SSPanel SSPanel12 
            Height          =   495
            Left            =   2910
            TabIndex        =   38
            Top             =   345
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
            Begin Threed.SSCommand SSCmdImp_Est 
               Height          =   465
               Left            =   15
               TabIndex        =   39
               Tag             =   "DBTTip:Imprime os Relatórios"
               Top             =   15
               Width           =   705
               _Version        =   65536
               _ExtentX        =   1244
               _ExtentY        =   820
               _StockProps     =   78
               Picture         =   "tabelas.frx":237C
            End
         End
         Begin Threed.SSPanel SSPanel13 
            Height          =   495
            Left            =   3825
            TabIndex        =   40
            Top             =   345
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
            Begin Threed.SSCommand SSCmdSair_Est 
               Height          =   465
               Left            =   15
               TabIndex        =   41
               Tag             =   "DBTTip:Sair da Rotina "
               Top             =   15
               Width           =   705
               _Version        =   65536
               _ExtentX        =   1244
               _ExtentY        =   820
               _StockProps     =   78
               Picture         =   "tabelas.frx":248E
            End
         End
      End
      Begin Threed.SSFrame SSFrame6 
         Height          =   3090
         Left            =   180
         TabIndex        =   42
         Top             =   1215
         Width           =   3405
         _Version        =   65536
         _ExtentX        =   6006
         _ExtentY        =   5450
         _StockProps     =   14
         Caption         =   "Escolha aqui o  Grupo"
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
         Begin MSDBCtls.DBList DBLGrupo_Est 
            Bindings        =   "tabelas.frx":2930
            Height          =   2205
            Left            =   240
            TabIndex        =   43
            Tag             =   "DBTTip:Lista dos Grupos Musicais"
            Top             =   510
            Width           =   2895
            _ExtentX        =   5106
            _ExtentY        =   3889
            _Version        =   327681
            BackColor       =   -2147483643
            ForeColor       =   16711680
            ListField       =   "nome_grupo"
            BoundColumn     =   "cod_grupo"
         End
      End
      Begin Threed.SSFrame SSFrame7 
         Height          =   3120
         Left            =   3675
         TabIndex        =   44
         Top             =   1185
         Width           =   5430
         _Version        =   65536
         _ExtentX        =   9578
         _ExtentY        =   5503
         _StockProps     =   14
         Caption         =   "Cadastre Aqui o Estilo"
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
         Begin Threed.SSPanel SSPanel14 
            Height          =   345
            Left            =   585
            TabIndex        =   45
            Top             =   600
            Width           =   4290
            _Version        =   65536
            _ExtentX        =   7567
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
            Begin VB.TextBox TxtNom_Est 
               Appearance      =   0  'Flat
               Height          =   315
               Left            =   15
               MaxLength       =   50
               TabIndex        =   46
               Tag             =   "DBTTip:Nome do Estilo"
               Top             =   15
               Width           =   4260
            End
         End
         Begin Threed.SSPanel SSPanel15 
            Height          =   345
            Left            =   585
            TabIndex        =   50
            Top             =   2610
            Width           =   4290
            _Version        =   65536
            _ExtentX        =   7567
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
            Begin VB.TextBox TxtGrupo_Est 
               Appearance      =   0  'Flat
               Height          =   315
               Left            =   15
               MaxLength       =   50
               TabIndex        =   51
               Tag             =   "DBTTip:Nome do Grupo"
               Top             =   15
               Width           =   4260
            End
         End
         Begin MSDBCtls.DBList DBLEst_Est 
            Bindings        =   "tabelas.frx":2945
            Height          =   1230
            Left            =   570
            TabIndex        =   47
            Tag             =   "DBTTip:Lista dos estilos musicais"
            Top             =   975
            Width           =   4290
            _ExtentX        =   7567
            _ExtentY        =   2170
            _Version        =   327681
            BackColor       =   -2147483643
            ForeColor       =   16711680
            ListField       =   "nome_estilo"
            BoundColumn     =   "cod_estilo"
         End
         Begin VB.Label Label3 
            AutoSize        =   -1  'True
            Caption         =   "Nome do Grupo"
            Height          =   195
            Left            =   585
            TabIndex        =   49
            Top             =   2400
            Width           =   1125
         End
         Begin VB.Label Label2 
            AutoSize        =   -1  'True
            Caption         =   "Nome do Estilo"
            Height          =   195
            Left            =   600
            TabIndex        =   48
            Top             =   360
            Width           =   1065
         End
      End
      Begin Threed.SSFrame SSFrame1 
         Height          =   3120
         Left            =   -73500
         TabIndex        =   52
         Top             =   1335
         Width           =   6330
         _Version        =   65536
         _ExtentX        =   11165
         _ExtentY        =   5503
         _StockProps     =   14
         Caption         =   "Cadastre Aqui o Grupo"
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
         Begin Threed.SSPanel SSPanel2 
            Height          =   345
            Left            =   1335
            TabIndex        =   53
            Top             =   690
            Width           =   4290
            _Version        =   65536
            _ExtentX        =   7567
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
            Begin VB.TextBox TxtNom_Grp 
               Appearance      =   0  'Flat
               Height          =   315
               Left            =   15
               MaxLength       =   50
               TabIndex        =   54
               Tag             =   "DBTTip:Nome do Grupo"
               Top             =   15
               Width           =   4260
            End
         End
         Begin MSDBCtls.DBList DBLGrupo_Grp 
            Bindings        =   "tabelas.frx":295B
            Height          =   1620
            Left            =   1335
            TabIndex        =   55
            Tag             =   "DBTTip:Lista dos Grupos"
            Top             =   1125
            Width           =   4245
            _ExtentX        =   7488
            _ExtentY        =   2858
            _Version        =   327681
            BackColor       =   -2147483643
            ForeColor       =   16711680
            ListField       =   "nome_grupo"
            BoundColumn     =   "cod_grupo"
         End
         Begin VB.Label Label1 
            AutoSize        =   -1  'True
            Caption         =   "Nome do Grupo"
            Height          =   195
            Left            =   1335
            TabIndex        =   56
            Top             =   450
            Width           =   1125
         End
      End
      Begin Threed.SSFrame SSFrame8 
         Height          =   1080
         Left            =   -72720
         TabIndex        =   57
         Top             =   4740
         Width           =   4725
         _Version        =   65536
         _ExtentX        =   8334
         _ExtentY        =   1905
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
         Begin Threed.SSPanel SSPanel16 
            Height          =   495
            Left            =   120
            TabIndex        =   58
            Top             =   360
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
            Begin Threed.SSCommand cmdGravaBairro 
               Height          =   465
               Left            =   15
               TabIndex        =   59
               Tag             =   "DBTTip:Grava o Estilo"
               Top             =   15
               Width           =   705
               _Version        =   65536
               _ExtentX        =   1244
               _ExtentY        =   820
               _StockProps     =   78
               Picture         =   "tabelas.frx":2970
            End
         End
         Begin Threed.SSPanel SSPanel17 
            Height          =   495
            Left            =   1020
            TabIndex        =   60
            Top             =   345
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
            Begin Threed.SSCommand cmdLimpaBairro 
               Height          =   465
               Left            =   15
               TabIndex        =   61
               Tag             =   "DBTTip:Novo Estilo"
               Top             =   15
               Width           =   705
               _Version        =   65536
               _ExtentX        =   1244
               _ExtentY        =   820
               _StockProps     =   78
               Picture         =   "tabelas.frx":2A82
            End
         End
         Begin Threed.SSPanel SSPanel18 
            Height          =   495
            Left            =   1965
            TabIndex        =   62
            Top             =   345
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
            Begin Threed.SSCommand cmdDelBairro 
               Height          =   465
               Left            =   15
               TabIndex        =   63
               Tag             =   "DBTTip:Apaga o Estilo"
               Top             =   15
               Width           =   705
               _Version        =   65536
               _ExtentX        =   1244
               _ExtentY        =   820
               _StockProps     =   78
               Picture         =   "tabelas.frx":2B94
            End
         End
         Begin Threed.SSPanel SSPanel19 
            Height          =   495
            Left            =   2910
            TabIndex        =   64
            Top             =   345
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
            Begin Threed.SSCommand cmdImpBairro 
               Height          =   465
               Left            =   15
               TabIndex        =   65
               Tag             =   "DBTTip:Imprime os Relatórios"
               Top             =   15
               Width           =   705
               _Version        =   65536
               _ExtentX        =   1244
               _ExtentY        =   820
               _StockProps     =   78
               Picture         =   "tabelas.frx":2FE6
            End
         End
         Begin Threed.SSPanel SSPanel20 
            Height          =   495
            Left            =   3825
            TabIndex        =   66
            Top             =   345
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
            Begin Threed.SSCommand cmdSaiBairro 
               Height          =   465
               Left            =   15
               TabIndex        =   67
               Tag             =   "DBTTip:Sair da Rotina "
               Top             =   15
               Width           =   705
               _Version        =   65536
               _ExtentX        =   1244
               _ExtentY        =   820
               _StockProps     =   78
               Picture         =   "tabelas.frx":30F8
            End
         End
      End
      Begin Threed.SSFrame SSFrame9 
         Height          =   3120
         Left            =   -74820
         TabIndex        =   68
         Top             =   990
         Width           =   3405
         _Version        =   65536
         _ExtentX        =   6006
         _ExtentY        =   5503
         _StockProps     =   14
         Caption         =   "Escolha aqui o  Município"
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
         Begin MSDBCtls.DBList dblMunicBairro 
            Bindings        =   "tabelas.frx":359A
            Height          =   2205
            Left            =   225
            TabIndex        =   69
            Tag             =   "DBTTip:Lista dos Grupos Musicais"
            Top             =   510
            Width           =   2895
            _ExtentX        =   5106
            _ExtentY        =   3889
            _Version        =   327681
            BackColor       =   -2147483643
            ForeColor       =   16711680
            ListField       =   "deMunic"
            BoundColumn     =   "cdMunic"
         End
      End
      Begin Threed.SSFrame SSFrame10 
         Height          =   3120
         Left            =   -71370
         TabIndex        =   70
         Top             =   975
         Width           =   5430
         _Version        =   65536
         _ExtentX        =   9578
         _ExtentY        =   5503
         _StockProps     =   14
         Caption         =   "Cadastre Aqui o Bairro"
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
         Begin MSDBCtls.DBList dblBairro 
            Bindings        =   "tabelas.frx":35AD
            Height          =   1230
            Left            =   600
            TabIndex        =   93
            Top             =   1050
            Width           =   4260
            _ExtentX        =   7514
            _ExtentY        =   2170
            _Version        =   327681
            ForeColor       =   16711680
            ListField       =   "deBairro"
            BoundColumn     =   "cdBairro"
         End
         Begin Threed.SSPanel SSPanel21 
            Height          =   345
            Left            =   585
            TabIndex        =   71
            Top             =   600
            Width           =   4290
            _Version        =   65536
            _ExtentX        =   7567
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
            Begin VB.TextBox txtBairro 
               Appearance      =   0  'Flat
               Height          =   315
               Left            =   15
               MaxLength       =   50
               TabIndex        =   72
               Tag             =   "DBTTip:Nome do Estilo"
               Top             =   15
               Width           =   4260
            End
         End
         Begin Threed.SSPanel SSPanel22 
            Height          =   345
            Left            =   585
            TabIndex        =   73
            Top             =   2610
            Width           =   4290
            _Version        =   65536
            _ExtentX        =   7567
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
            Begin VB.TextBox txtMunBairro 
               Appearance      =   0  'Flat
               Height          =   315
               Left            =   15
               MaxLength       =   50
               TabIndex        =   74
               Tag             =   "DBTTip:Nome do Grupo"
               Top             =   15
               Width           =   4260
            End
         End
         Begin VB.Label Label5 
            AutoSize        =   -1  'True
            Caption         =   "Nome do Bairro"
            Height          =   195
            Left            =   600
            TabIndex        =   76
            Top             =   405
            Width           =   1095
         End
         Begin VB.Label Label4 
            AutoSize        =   -1  'True
            Caption         =   "Nome do Município"
            Height          =   195
            Left            =   585
            TabIndex        =   75
            Top             =   2400
            Width           =   1395
         End
      End
      Begin Threed.SSFrame SSFrame11 
         Height          =   3120
         Left            =   -73410
         TabIndex        =   77
         Top             =   1170
         Width           =   6330
         _Version        =   65536
         _ExtentX        =   11165
         _ExtentY        =   5503
         _StockProps     =   14
         Caption         =   "Cadastre Aqui o Município"
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
            Height          =   345
            Left            =   1335
            TabIndex        =   78
            Top             =   690
            Width           =   4290
            _Version        =   65536
            _ExtentX        =   7567
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
            Begin VB.TextBox txtMunic 
               Appearance      =   0  'Flat
               Height          =   315
               Left            =   15
               MaxLength       =   50
               TabIndex        =   79
               Tag             =   "DBTTip:Nome do Grupo"
               Top             =   15
               Width           =   4260
            End
         End
         Begin MSDBCtls.DBList dblMunic 
            Bindings        =   "tabelas.frx":35C1
            Height          =   1620
            Left            =   1350
            TabIndex        =   80
            Tag             =   "DBTTip:Lista dos Grupos"
            Top             =   1125
            Width           =   4245
            _ExtentX        =   7488
            _ExtentY        =   2858
            _Version        =   327681
            BackColor       =   -2147483643
            ForeColor       =   16711680
            ListField       =   "deMunic"
            BoundColumn     =   "cdMunic"
         End
         Begin VB.Label Label6 
            AutoSize        =   -1  'True
            Caption         =   "Nome do Município"
            Height          =   195
            Left            =   1335
            TabIndex        =   81
            Top             =   450
            Width           =   1395
         End
      End
      Begin Threed.SSFrame SSFrame12 
         Height          =   1080
         Left            =   -72360
         TabIndex        =   82
         Top             =   4545
         Width           =   4725
         _Version        =   65536
         _ExtentX        =   8334
         _ExtentY        =   1905
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
         Begin Threed.SSPanel SSPanel24 
            Height          =   495
            Left            =   120
            TabIndex        =   83
            Top             =   360
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
            Begin Threed.SSCommand cmdGravaMunic 
               Height          =   465
               Left            =   15
               TabIndex        =   84
               Tag             =   "DBTTip:Grava o Grupo"
               Top             =   15
               Width           =   705
               _Version        =   65536
               _ExtentX        =   1244
               _ExtentY        =   820
               _StockProps     =   78
               Picture         =   "tabelas.frx":35D4
            End
         End
         Begin Threed.SSPanel SSPanel25 
            Height          =   495
            Left            =   1020
            TabIndex        =   85
            Top             =   345
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
            Begin Threed.SSCommand cmdLimpaMunic 
               Height          =   465
               Left            =   15
               TabIndex        =   86
               Tag             =   "DBTTip:Novo Grupo"
               Top             =   15
               Width           =   705
               _Version        =   65536
               _ExtentX        =   1244
               _ExtentY        =   820
               _StockProps     =   78
               Picture         =   "tabelas.frx":36E6
            End
         End
         Begin Threed.SSPanel SSPanel26 
            Height          =   495
            Left            =   1965
            TabIndex        =   87
            Top             =   345
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
            Begin Threed.SSCommand cmdDelMunic 
               Height          =   465
               Left            =   15
               TabIndex        =   88
               Tag             =   "DBTTip:Apaga o Grupo"
               Top             =   15
               Width           =   705
               _Version        =   65536
               _ExtentX        =   1244
               _ExtentY        =   820
               _StockProps     =   78
               Picture         =   "tabelas.frx":37F8
            End
         End
         Begin Threed.SSPanel SSPanel32 
            Height          =   495
            Left            =   2910
            TabIndex        =   89
            Top             =   345
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
            Begin Threed.SSCommand cmdImpMunic 
               Height          =   465
               Left            =   15
               TabIndex        =   90
               Tag             =   "DBTTip:Imprime os Relatórios"
               Top             =   15
               Width           =   705
               _Version        =   65536
               _ExtentX        =   1244
               _ExtentY        =   820
               _StockProps     =   78
               Picture         =   "tabelas.frx":3C4A
            End
         End
         Begin Threed.SSPanel SSPanel33 
            Height          =   495
            Left            =   3825
            TabIndex        =   91
            Top             =   345
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
            Begin Threed.SSCommand cmdSaiMunic 
               Height          =   465
               Left            =   15
               TabIndex        =   92
               Tag             =   "DBTTip:Sair da Rotina "
               Top             =   15
               Width           =   705
               _Version        =   65536
               _ExtentX        =   1244
               _ExtentY        =   820
               _StockProps     =   78
               Picture         =   "tabelas.frx":3D5C
            End
         End
      End
   End
End
Attribute VB_Name = "Tabelas"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Dim Atualiza_int As String
Dim Atualiza_grp As String
Dim cdgrupo_grp As String
Dim Atualiza_est As String
Dim cdmunic_mun As Byte
Dim cdgrupo_est As String
Dim cdestilo_est As String
Dim cdMunBairro_bai As Byte
Dim cdbairro_bai As Integer
Dim Atualiza_bai As String
Dim Atualiza_mun As String
Private Sub limpa_int()
    LstNom_Int.Clear
    Atualiza_int = "Não"
    msgI = "Inclusão"
    'Apaga o nome da música no text
    TxtCod_Int = ""
    TxtNom_Int = ""
    Set VTb = Winterprete
    VIx = "cod_interprete"
    VCt = "Cod_interprete"
    TxtCod_Int.Text = geracod()
    TxtCod_Int.Text = Format(TxtCod_Int, "0000")
    TxtCod_Int.SetFocus
End Sub

Private Sub pesq_int()
     Msg = "Digite o Nome do Intérprete a ser Pesquisado"
     tit = "CD'S Loc - Pesquisa Intérprete"
     pesquisa_int = InputBox(Msg, tit)
     'inicio da rotina para escolha de um cliente
     If pesquisa_int <> "" Then
        LstNom_Int.Clear
        If Winterprete.RecordCount <> 0 Then Winterprete.MoveFirst
        While Not Winterprete.EOF
          ' Pesquisa Cliente
          pesquisa = InStr(Winterprete!interprete, UCase(pesquisa_int)) ' Maiúsculas
          pesquisa2 = InStr(Winterprete!interprete, pesquisa_int) ' Minúsculas
          If pesquisa <> 0 Or pesquisa2 <> 0 Then
             LstNom_Int.AddItem Format(Winterprete("cod_interprete"), "0000") & " - " & Winterprete("interprete")
          End If
          Winterprete.MoveNext
        Wend
     End If
End Sub

Private Sub cmdDelBairro_Click()
    On Error GoTo ErrorHandler  ' Enable error-handling routine.
    Msg = "Deseja realmente Excluir ?"  ' Define message.
    Style = vbYesNo + vbCritical + vbDefaultButton1 ' Define buttons.
    Title = "CD'S Loc - Cuidado!!"  ' Define title.
    Help = "DEMO.HLP"   ' Define Help file.
    Ctxt = 1000 ' Define topic
                ' context.
    ' Display message.
    resposta = MsgBox(Msg, Style, Title, Help, Ctxt)
 With wBairro
    If resposta = vbNo Then    ' User chose Yes.
       'Posiciona no código
       txtBairro.SetFocus
    Else
       If .RecordCount <> 0 Then
          .Index = "primarykey"
          .MoveFirst
          .Seek "=", cdbairro_bai
      
          If Not .NoMatch Then
             'Apaga registro do Banco de Dados
             .Delete
          Else
             MsgBox "SELECIONE registro para EXCLUIR", 32
          End If
       Else
          MsgBox "Não existe registro para EXCLUIR", 32
       End If
    End If
    
    dtaBairro.Refresh
    msgI = "Inclusão"
    Atualiza_bai = "Não"
    txtBairro.Text = ""
    txtMunBairro.Text = ""
    cdMunBairro_bai = 0
    cdbairro_bai = 0
    txtBairro.SetFocus
 End With

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
    Exit Sub
    Resume  ' Resume execution at same line
                ' that caused the error.
End Sub

Private Sub cmdDelMunic_Click()
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
       txtMunic.SetFocus
    Else
       If wMunic.RecordCount <> 0 Then
          wMunic.Index = "primarykey"
          wMunic.MoveFirst
          wMunic.Seek "=", cdmunic_mun
      
          If Not wMunic.NoMatch Then
             'Apaga registro do Banco de Dados
             wMunic.Delete
          Else
             MsgBox "SELECIONE registro para EXCLUIR", 32
          End If
       Else
          MsgBox "Não existe registro para EXCLUIR", 32
       End If
    End If
    dtaMunic.Refresh
    msgI = "Inclusão"
    Atualiza_mun = "Não"
    txtMunic.Text = ""
    txtMunic.SetFocus
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
    Exit Sub
    Resume  ' Resume execution at same line
                ' that caused the error.
End Sub

Private Sub cmdGravaBairro_Click()
   If cdMunBairro_bai = 0 Then
       MsgBox "Você deve escolher um MUNICÍPIO para Incluir um BAIRRO", 48, "AVISO"
       dblMunicBairro.SetFocus
    Else
       With wBairro
       Msg = MsgBox("Confirme a " + msgI, 36, "CONFIRMAÇÃO")
       If Msg = 6 Then   'Se a tecla acionado foi Sim
          If Atualiza_bai = "Sim" Then
             If cdbairro_bai = 0 Then
                MsgBox "Voçê deve Escolher um Bairro para Alterar", 16, "Aviso"
                dblBairro.SetFocus
                Exit Sub
              End If
                 .MoveFirst
                 .Index = "primarykey"
                 .Seek "=", cdbairro_bai
                 .Edit
           Else
             wBairro.MoveLast
             cdbairro_bai = wBairro!cdBairro + 1
             .AddNew
             wBairro!cdBairro = cdbairro_bai
          End If
          wBairro!deBairro = txtBairro.Text
          wBairro!cdMunic = cdMunBairro_bai
          
          'Grava na tabela
          .Update
          
          gravou = "Sim"
       Else
          MsgBox "Operação Cancelada", 48, "AVISO"
          gravou = "Não"
       End If
       End With
       dtaBairro.Refresh
       msgI = "Inclusão"
       Atualiza_bai = "Não"
       txtBairro.Text = ""
       txtBairro.SetFocus
    End If
End Sub

Private Sub cmdGravaMunic_Click()
   If txtMunic = "" Then
      MsgBox "O campo nome do Município está vazio", 48, "AVISO"
      txtMunic.SetFocus
    Else
       Msg = MsgBox("Confirme a " + msgI, 36, "CONFIRMAÇÃO")
       If Msg = 6 Then   'Se a tecla acionado foi Sim
          If Atualiza_mun = "Sim" Then
              wMunic.MoveFirst
              wMunic.Index = "primarykey"
              wMunic.Seek "=", cdmunic_mun
              wMunic.Edit
          Else
             wMunic.MoveLast
             cdmunic_mun = wMunic!cdMunic + 1
             
             wMunic.AddNew
             wMunic!cdMunic = cdmunic_mun
          End If
          wMunic("deMunic") = txtMunic.Text
          
          'Grava na tabela
          wMunic.Update
          
          gravou = "Sim"
       Else
          MsgBox "Operação Cancelada", 48, "AVISO"
          gravou = "Não"
       End If
       dtaMunic.Refresh
       msgI = "Inclusão"
       Atualiza_mun = "Não"
       txtMunic.Text = ""
       txtMunic.SetFocus
    End If
End Sub

Private Sub cmdLimpaBairro_Click()
    SQL = "select deBairro from bairro "
    dtaBairro.RecordSource = SQL
    dtaBairro.Refresh
    msgI = "Inclusão"
    Atualiza_bai = "Não"
    txtBairro.Text = ""
    txtMunBairro.Text = ""
    cdMunBairro_bai = 0
    cdbairro_bai = 0
    dblMunicBairro.SetFocus
End Sub

Private Sub cmdLimpaMunic_Click()
   dtaMunic.Refresh
   msgI = "Inclusão"
   Atualiza_mun = "Não"
   txtMunic.Text = ""
   txtMunic.SetFocus
End Sub

Private Sub cmdSaiBairro_Click()
   Tabelas.Hide
End Sub

Private Sub cmdSaiMunic_Click()
   Tabelas.Hide
End Sub

Private Sub dblBairro_Click()
   txtBairro.Text = dblBairro.Text
   cdbairro_bai = dblBairro.BoundText
   If wBairro.RecordCount <> 0 Then
      wBairro.Index = "primarykey"
      wBairro.MoveFirst
      wBairro.Seek "=", cdbairro_bai
      If Not wBairro.NoMatch Then
         txtBairro.Text = wBairro("deBairro")
         msgI = "Alteração"
         Atualiza_bai = "Sim"
      End If
   End If
End Sub

Private Sub DBLEst_Est_Click()
   TxtNom_Est = DBLEst_Est.Text
   cdestilo_est = DBLEst_Est.BoundText
   Westilo.Index = "cod_estilo"
   Westilo.MoveFirst
   Westilo.Seek "=", cdestilo_est
   If Not Westilo.NoMatch Then
      cdgrupo_est = Westilo("cod_grupo")
      Wgrupo.Index = "primarykey"
      Wgrupo.MoveFirst
      Wgrupo.Seek "=", cdgrupo_est
      cdgrupo_est = Wgrupo("cod_grupo")
      TxtGrupo_Est = Wgrupo("nome_grupo")
      msgI = "Alteração"
      Atualiza_est = "Sim"
   End If
End Sub

Private Sub DBLGrupo_Est_Click()
   TxtGrupo_Est = DBLGrupo_Est.Text
   cdgrupo_est = DBLGrupo_Est.BoundText
   SQL = "select * from estilo where cod_grupo=" + cdgrupo_est + ""
   Data_Estilo.RecordSource = SQL
   Data_Estilo.Refresh
   TxtNom_Est.SetFocus
   Atualiza_est = "Não"
   msgI = "Inclusão"
End Sub

Private Sub DBLGrupo_Grp_Click()
   TxtNom_Grp = DBLGrupo_Grp.Text
   cdgrupo_grp = DBLGrupo_Grp.BoundText
   msgI = "Alteração"
   Atualiza_grp = "Sim"
End Sub

Private Sub dblMunic_Click()
   txtMunic.Text = dblMunic.Text
   cdmunic_mun = dblMunic.BoundText
   msgI = "Alteração"
   Atualiza_mun = "Sim"
End Sub

Private Sub dblMunicBairro_Click()
   txtMunBairro.Text = dblMunicBairro.Text
   cdMunBairro_bai = dblMunicBairro.BoundText
   SQL = "select * from bairro where cdMunic=" + Str(cdMunBairro_bai) + ""
   dtaBairro.RecordSource = SQL
   dtaBairro.Refresh
   txtBairro.SetFocus
   Atualiza_bai = "Não"
   msgI = "Inclusão"
End Sub

Private Sub Form_Load()
     
   With Tabelas
      .Left = 1245
      .Height = 6900
      .Width = 9465
      .Top = 390
   End With
    
   Set vformu = Tabelas
   
   ChDir App.Path 'muda para diretório de carga

   With Data_Estilo
     'Seta o data
     .DatabaseName = App.Path & "\bd_cdloc.mdb"
     .Refresh
   End With
   
   With Data_Grupo
     'Seta o data
     .DatabaseName = App.Path & "\bd_cdloc.mdb"
     .Refresh
   End With
   
   With dtaMunic
     'Seta o data
     .DatabaseName = App.Path & "\bd_cdloc.mdb"
     .Refresh
   End With
   
   With dtaBairro
     'Seta o data
     .DatabaseName = App.Path & "\bd_cdloc.mdb"
     .Refresh
   End With
    
End Sub

Private Sub LstNom_Int_Click()
    Winterprete.Index = "cod_interprete"
    Winterprete.MoveFirst
    Winterprete.Seek "=", Left(LstNom_Int.Text, 4)
    If Winterprete.NoMatch Then
       ' Cliente Não Cadastrado
       msgI = "Inclusão"
       mensagem = "Incluir"
    Else
       mensagem = "Alterar"
       msgI = "Alteração"
       Atualiza_int = "Sim"
       Msg = MsgBox("Voçê selecionou o Intérprete ? " + LstNom_Int.Text, 36)
       If Msg = 7 Then 'Resposta = Não
          TxtNom_Int = ""
          TxtCod_Int = ""
          Exit Sub
       End If
       'preencher os campos
       TxtCod_Int = Format(Winterprete("cod_interprete"), "0000")
       TxtNom_Int = Winterprete("interprete")
       TxtNom_Int.SetFocus
    End If
End Sub
Private Sub SSCmdSair_Cd_Click()
End Sub

Private Sub SSCmdExc_Est_Click()
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
       TxtNom_Est.SetFocus
    Else
       If Westilo.RecordCount <> 0 Then
          Westilo.Index = "primarykey"
          Westilo.MoveFirst
          Westilo.Seek "=", cdgrupo_est, cdestilo_est
      
          If Not Westilo.NoMatch Then
             'Apaga registro do Banco de Dados
             Westilo.Delete
          Else
             MsgBox "SELECIONE registro para EXCLUIR", 32
          End If
       Else
          MsgBox "Não existe registro para EXCLUIR", 32
       End If
    End If
    Data_Estilo.Refresh
    msgI = "Inclusão"
    Atualiza_est = "Não"
    TxtNom_Est = ""
    TxtGrupo_Est = ""
    cdestilo_est = ""
    cdgrupo_est = ""
    TxtNom_Est.SetFocus
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
    Exit Sub
    Resume  ' Resume execution at same line
                ' that caused the error.
End Sub

Private Sub SSCmdExc_Grp_Click()
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
       TxtNom_Grp.SetFocus
    Else
       If Wgrupo.RecordCount <> 0 Then
          Wgrupo.Index = "primarykey"
          Wgrupo.MoveFirst
          Wgrupo.Seek "=", cdgrupo_grp
      
          If Not Wgrupo.NoMatch Then
             'Apaga registro do Banco de Dados
             Wgrupo.Delete
          Else
             MsgBox "SELECIONE registro para EXCLUIR", 32
          End If
       Else
          MsgBox "Não existe registro para EXCLUIR", 32
       End If
    End If
    Data_Grupo.Refresh
    msgI = "Inclusão"
    Atualiza_grp = "Não"
    TxtNom_Grp = ""
    TxtNom_Grp.SetFocus
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
    Exit Sub
    Resume  ' Resume execution at same line
                ' that caused the error.
End Sub

Private Sub SSCmdExc_Int_Click()
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
       TxtCod_Int.SetFocus
    Else
       If Winterprete.RecordCount <> 0 Then
          Winterprete.Index = "cod_interprete"
          Winterprete.MoveFirst
          Winterprete.Seek "=", TxtCod_Int
      
          If Not Winterprete.NoMatch Then
             'Apaga registro do Banco de Dados
             Winterprete.Delete
          Else
             MsgBox "SELECIONE registro para EXCLUIR", 32
          End If
       Else
          MsgBox "Não existe registro para EXCLUIR", 32
       End If
    End If
    'Chama a Procedure que Limpa
    limpa_int
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
    Exit Sub
    Resume  ' Resume execution at same line
                ' that caused the error.
End Sub

Private Sub SSCmdGrava_Cd_Click()
   If TxtCod_Int = "" Or TxtNom_Int = "" Then
       MsgBox "Selecione o Intérprete para Incluir ou Alterar.", 48, "AVISO"
       TxtCod_Int.SetFocus
    Else
       Msg = MsgBox("Confirme a " + msgI, 36, "CONFIRMAÇÃO")
       If Msg = 6 Then   'Se a tecla acionado foi Sim
          If Atualiza_int = "Sim" Then
              Winterprete.MoveFirst
              Winterprete.Index = "cod_interprete"
              Winterprete.Seek "=", TxtCod_Int
              Winterprete.Edit
          Else
             Winterprete.AddNew
             Winterprete("cod_interprete") = TxtCod_Int
          End If
          Winterprete("interprete") = TxtNom_Int
          
          'Grava na tabela
          Winterprete.Update
          
          gravou = "Sim"
       Else
          MsgBox "Operação Cancelada", 48, "AVISO"
          gravou = "Não"
       End If
       ' Chama a procedure
       limpa_int
    End If
End Sub

Private Sub SSCmdGrava_Est_Click()
    If cdgrupo_est = "" Then
       MsgBox "Você deve escolher um GRUPO para Incluir um ESTILO", 48, "AVISO"
       DBLGrupo_Est.SetFocus
    Else
       Msg = MsgBox("Confirme a " + msgI, 36, "CONFIRMAÇÃO")
       If Msg = 6 Then   'Se a tecla acionado foi Sim
          If Atualiza_est = "Sim" Then
             If cdestilo_est = "" Then
                MsgBox "Voçê deve Escolher um Estilo para Alterar", 16, "Aviso"
                DBLEst_Est.SetFocus
                Exit Sub
              End If
              Westilo.MoveFirst
              Westilo.Index = "primarykey"
              Westilo.Seek "=", cdgrupo_est, cdestilo_est
              Westilo.Edit
          Else
             Westilo.AddNew
             Westilo("cod_grupo") = cdgrupo_est
          End If
          Westilo("nome_estilo") = TxtNom_Est
          
          'Grava na tabela
          Westilo.Update
          
          gravou = "Sim"
       Else
          MsgBox "Operação Cancelada", 48, "AVISO"
          gravou = "Não"
       End If
       Data_Estilo.Refresh
       msgI = "Inclusão"
       Atualiza_est = "Não"
       TxtNom_Est = ""
       TxtNom_Est.SetFocus
    End If
End Sub

Private Sub SSCmdGrava_Grp_Click()
   If TxtNom_Grp = "" Then
       MsgBox "O Campo Nome do Grupo Vazio", 48, "AVISO"
       TxtNom_Grp.SetFocus
    Else
       Msg = MsgBox("Confirme a " + msgI, 36, "CONFIRMAÇÃO")
       If Msg = 6 Then   'Se a tecla acionado foi Sim
          If Atualiza_grp = "Sim" Then
              Wgrupo.MoveFirst
              Wgrupo.Index = "primarykey"
              Wgrupo.Seek "=", cdgrupo_grp
              Wgrupo.Edit
          Else
             Wgrupo.AddNew
          End If
          Wgrupo("nome_grupo") = TxtNom_Grp
          
          'Grava na tabela
          Wgrupo.Update
          
          gravou = "Sim"
       Else
          MsgBox "Operação Cancelada", 48, "AVISO"
          gravou = "Não"
       End If
       Data_Grupo.Refresh
       msgI = "Inclusão"
       Atualiza_grp = "Não"
       TxtNom_Grp = ""
       TxtNom_Grp.SetFocus
    End If
End Sub

Private Sub SSCmdLimp_Est_Click()
    SQL = "select * from estilo where cod_grupo=0"
    Data_Estilo.RecordSource = SQL
    Data_Estilo.Refresh
    msgI = "Inclusão"
    Atualiza_est = "Não"
    TxtGrupo_Est = ""
    TxtNom_Est = ""
    cdestilo_est = ""
    cdgrupo_est = ""
    DBLGrupo_Est.SetFocus
End Sub

Private Sub SSCmdLimp_Grp_Click()
   Data_Grupo.Refresh
   msgI = "Inclusão"
   Atualiza_grp = "Não"
   TxtNom_Grp = ""
   TxtNom_Grp.SetFocus
End Sub


Private Sub SSCmdLimp_Int_Click()
   'chama a procedure
   limpa_int
End Sub

Private Sub SSCmdSai_Grp_Click()
    Tabelas.Hide
End Sub

Private Sub SSCmdSair_Est_Click()
   Tabelas.Hide
End Sub

Private Sub SSCmdSair_Int_Click()
   Tabelas.Hide
End Sub

Private Sub SSCommand7_Click()

End Sub

Private Sub SSCommand10_Click()

End Sub

Private Sub SSCommand1_Click()
 
End Sub

Private Sub SSTab1_GotFocus()
    If SSTab1.Tab = 0 Then
       Set VTb = Winterprete
       VIx = "cod_interprete"
       VCt = "Cod_interprete"
       TxtCod_Int.Text = geracod()
       TxtCod_Int.Text = Format(TxtCod_Int, "0000")
       TxtCod_Int.SetFocus
    ElseIf SSTab1.Tab = 1 Then
       TxtNom_Grp.SetFocus
    ElseIf SSTab1.Tab = 2 Then
       DBLGrupo_Est.SetFocus
    End If
End Sub


Private Sub TxtCod_Int_KeyPress(KeyAscii As Integer)
    If KeyAscii = 13 Then
       TxtNom_Int.SetFocus
    End If
End Sub

Private Sub TxtCod_Int_LostFocus()
 If TxtCod_Int <> "" Then
    If Not IsNumeric(TxtCod_Int) Then
       MsgBox "Só é permitido o uso de Números", 64
       TxtCod_Int.SetFocus
       Exit Sub
    End If
    gravou = "Não"
    Winterprete.Index = "cod_interprete"
    Winterprete.MoveFirst  ' Posiciona no inicio da tabela
    Winterprete.Seek "=", TxtCod_Int.Text
    If Winterprete.NoMatch Then
       msgI = "Inclusão"
       TxtCod_Int = Format(TxtCod_Int, "0000")
       TxtNom_Int.SetFocus
       Exit Sub
    End If
    Atualiza_int = "Sim"
    msgI = "Alteração"
    TxtCod_Int = Format(TxtCod_Int, "0000")
    'Chama a procedure que preenche os dados.
    TxtNom_Int = Winterprete("interprete")
 End If
End Sub


Private Sub TxtNom_Grp_LostFocus()
   If cdgrupo_grp = "" Then
      msgI = "Inclusão"
      Atualiza_grp = "Não"
   End If
End Sub


Private Sub TxtNom_Int_KeyDown(KeyCode As Integer, Shift As Integer)
    If KeyCode = vbKeyF10 Then
       pesq_int
    End If
End Sub


Private Sub TxtNom_Int_KeyPress(KeyAscii As Integer)
   If KeyCode <> vbKeyF10 Then
      If KeyAscii = 13 Then
         'Setar o foco
      End If
   End If
End Sub


