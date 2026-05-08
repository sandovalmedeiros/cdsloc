VERSION 5.00
Object = "{C932BA88-4374-101B-A56C-00AA003668DC}#1.1#0"; "MSMASK32.OCX"
Object = "{0BA686C6-F7D3-101A-993E-0000C0EF6F5E}#1.0#0"; "THREED32.OCX"
Object = "{BDC217C8-ED16-11CD-956C-0000C04E4C0A}#1.1#0"; "TABCTL32.OCX"
Object = "{FAEEE763-117E-101B-8933-08002B2F4F5A}#1.1#0"; "DBLIST32.OCX"
Begin VB.Form Cds 
   Caption         =   "Títulos, Músicas e CD'S Físico"
   ClientHeight    =   6465
   ClientLeft      =   390
   ClientTop       =   720
   ClientWidth     =   9510
   ControlBox      =   0   'False
   Icon            =   "CDS.frx":0000
   LinkTopic       =   "Form1"
   MDIChild        =   -1  'True
   PaletteMode     =   1  'UseZOrder
   ScaleHeight     =   6465
   ScaleWidth      =   9510
   Begin TabDlg.SSTab SSTab1 
      Height          =   6465
      Left            =   0
      TabIndex        =   0
      Top             =   0
      Width           =   9525
      _ExtentX        =   16801
      _ExtentY        =   11404
      _Version        =   327681
      TabHeight       =   529
      ForeColor       =   16711680
      TabCaption(0)   =   "Títulos"
      Tab(0).ControlEnabled=   -1  'True
      Tab(0).Control(0)=   "SSPanel24"
      Tab(0).Control(0).Enabled=   0   'False
      Tab(0).Control(1)=   "SSPanel23"
      Tab(0).Control(1).Enabled=   0   'False
      Tab(0).Control(2)=   "SSPanel21"
      Tab(0).Control(2).Enabled=   0   'False
      Tab(0).Control(3)=   "SSPanel20"
      Tab(0).Control(3).Enabled=   0   'False
      Tab(0).Control(4)=   "SSPanel19"
      Tab(0).Control(4).Enabled=   0   'False
      Tab(0).Control(5)=   "SSFrame1"
      Tab(0).Control(5).Enabled=   0   'False
      Tab(0).Control(6)=   "Data_Grupo"
      Tab(0).Control(6).Enabled=   0   'False
      Tab(0).Control(7)=   "Data_Estilo"
      Tab(0).Control(7).Enabled=   0   'False
      Tab(0).Control(8)=   "Data_Interp"
      Tab(0).Control(8).Enabled=   0   'False
      Tab(0).ControlCount=   9
      TabCaption(1)   =   "Músicas"
      Tab(1).ControlEnabled=   0   'False
      Tab(1).Control(0)=   "SSFrame2"
      Tab(1).Control(1)=   "SSFrame3"
      Tab(1).ControlCount=   2
      TabCaption(2)   =   "CD'S"
      Tab(2).ControlEnabled=   0   'False
      Tab(2).Control(0)=   "SSFrame5"
      Tab(2).Control(0).Enabled=   0   'False
      Tab(2).Control(1)=   "SSFrame4"
      Tab(2).Control(1).Enabled=   0   'False
      Tab(2).ControlCount=   2
      Begin VB.Data Data_Interp 
         Caption         =   "Data_Interp"
         Connect         =   "Access"
         DatabaseName    =   ""
         DefaultCursorType=   0  'DefaultCursor
         DefaultType     =   2  'UseODBC
         Exclusive       =   0   'False
         Height          =   345
         Left            =   6045
         Options         =   0
         ReadOnly        =   0   'False
         RecordsetType   =   2  'Snapshot
         RecordSource    =   ""
         Top             =   3930
         Visible         =   0   'False
         Width           =   2250
      End
      Begin VB.Data Data_Estilo 
         Caption         =   "Data_Estilo"
         Connect         =   "Access"
         DatabaseName    =   ""
         DefaultCursorType=   0  'DefaultCursor
         DefaultType     =   2  'UseODBC
         Exclusive       =   0   'False
         Height          =   345
         Left            =   3045
         Options         =   0
         ReadOnly        =   0   'False
         RecordsetType   =   2  'Snapshot
         RecordSource    =   ""
         Top             =   3945
         Visible         =   0   'False
         Width           =   2235
      End
      Begin VB.Data Data_Grupo 
         Caption         =   "Data_Grupo"
         Connect         =   "Access"
         DatabaseName    =   ""
         DefaultCursorType=   0  'DefaultCursor
         DefaultType     =   2  'UseODBC
         Exclusive       =   0   'False
         Height          =   345
         Left            =   390
         Options         =   0
         ReadOnly        =   0   'False
         RecordsetType   =   2  'Snapshot
         RecordSource    =   ""
         Top             =   3885
         Visible         =   0   'False
         Width           =   2250
      End
      Begin Threed.SSFrame SSFrame1 
         Height          =   4170
         Left            =   195
         TabIndex        =   1
         Top             =   930
         Width           =   8985
         _Version        =   65536
         _ExtentX        =   15854
         _ExtentY        =   7345
         _StockProps     =   14
         Caption         =   "Cadastre aqui Todos os Títulos da Locadora"
         BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
            Name            =   "MS Sans Serif"
            Size            =   8.24
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Begin VB.Frame Frame1 
            Caption         =   "Tipo Locação"
            Height          =   990
            Left            =   5910
            TabIndex        =   13
            Tag             =   "DBTTip:Tipos de Locação"
            Top             =   1125
            Width           =   1995
            Begin Threed.SSOption SSOpt48_Tit 
               Height          =   204
               Left            =   180
               TabIndex        =   15
               Tag             =   "DBTTip:Locação 48 horas"
               Top             =   612
               Width           =   1200
               _Version        =   65536
               _ExtentX        =   2117
               _ExtentY        =   360
               _StockProps     =   78
               Caption         =   "48 Horas"
               BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
                  Name            =   "MS Sans Serif"
                  Size            =   8.63
                  Charset         =   0
                  Weight          =   400
                  Underline       =   0   'False
                  Italic          =   0   'False
                  Strikethrough   =   0   'False
               EndProperty
            End
            Begin Threed.SSOption SSOpt24_Tit 
               Height          =   195
               Left            =   180
               TabIndex        =   14
               Tag             =   "DBTTip:Locação 24 horas"
               Top             =   300
               Width           =   1125
               _Version        =   65536
               _ExtentX        =   1984
               _ExtentY        =   344
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
         Begin VB.ListBox LstNom_Tit 
            Height          =   840
            Left            =   1335
            TabIndex        =   10
            Tag             =   "DBTTip:Lista dos Títulos Pesquisados"
            Top             =   1125
            Width           =   4275
         End
         Begin Threed.SSPanel SSPanel1 
            Height          =   345
            Left            =   195
            TabIndex        =   2
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
               Size            =   8.26
               Charset         =   0
               Weight          =   400
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            BevelOuter      =   1
            Autosize        =   3
            Begin VB.TextBox TxtCod_Tit 
               Appearance      =   0  'Flat
               Height          =   315
               Left            =   15
               MaxLength       =   6
               TabIndex        =   3
               Tag             =   "N"
               Top             =   15
               Width           =   855
            End
         End
         Begin Threed.SSPanel SSPanel6 
            Height          =   345
            Left            =   5955
            TabIndex        =   6
            Top             =   675
            Width           =   750
            _Version        =   65536
            _ExtentX        =   1323
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
            Begin MSMask.MaskEdBox MskQtde_Tit 
               Height          =   315
               Left            =   15
               TabIndex        =   7
               Tag             =   "DBTTip:Quantidade de Títulos Adquirido"
               Top             =   15
               Width           =   720
               _ExtentX        =   1270
               _ExtentY        =   556
               _Version        =   327681
               Appearance      =   0
               MaxLength       =   5
               Mask            =   "#####"
               PromptChar      =   " "
            End
         End
         Begin Threed.SSPanel SSPanel2 
            Height          =   345
            Left            =   1335
            TabIndex        =   8
            Top             =   690
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
            Begin VB.TextBox TxtNom_Tit 
               Appearance      =   0  'Flat
               Height          =   315
               Left            =   15
               MaxLength       =   50
               TabIndex        =   9
               Tag             =   "DBTTip:Use F10 para fazer a pesquisa do Título por Nome ou Partícula do nome"
               Top             =   15
               Width           =   4260
            End
         End
         Begin Threed.SSPanel SSPanel3 
            Height          =   345
            Left            =   7035
            TabIndex        =   11
            Top             =   660
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
            Begin VB.TextBox TxtVal_Tit 
               Appearance      =   0  'Flat
               Height          =   315
               Left            =   15
               MaxLength       =   6
               TabIndex        =   12
               Tag             =   "DBTTip:Valor em R$"
               Top             =   15
               Width           =   855
            End
         End
         Begin MSDBCtls.DBCombo DBCEst_Tit 
            Bindings        =   "CDS.frx":0442
            Height          =   315
            Left            =   2820
            TabIndex        =   33
            Tag             =   "DBTTip:Escolha na Lista o Estilo Musical a que pertence o Título"
            Top             =   2610
            Width           =   2760
            _ExtentX        =   4868
            _ExtentY        =   556
            _Version        =   327681
            BackColor       =   16777215
            ForeColor       =   0
            ListField       =   "nome_estilo"
            BoundColumn     =   "cod_estilo"
            Text            =   ""
         End
         Begin MSDBCtls.DBCombo DBCGrp_Tit 
            Bindings        =   "CDS.frx":0458
            Height          =   315
            Left            =   210
            TabIndex        =   32
            Tag             =   "DBTTip:Escolha na Lista o Grupo Musical a que pertence o Título"
            Top             =   2610
            Width           =   2445
            _ExtentX        =   4313
            _ExtentY        =   556
            _Version        =   327681
            BackColor       =   16777215
            ForeColor       =   0
            ListField       =   "nome_grupo"
            BoundColumn     =   "cod_grupo"
            Text            =   ""
         End
         Begin MSDBCtls.DBCombo DBCInt_Tit 
            Bindings        =   "CDS.frx":046D
            Height          =   315
            Left            =   5850
            TabIndex        =   16
            Tag             =   "DBTTip:Escolha na Lista o Interprete a que pertence o Título"
            Top             =   2595
            Width           =   2880
            _ExtentX        =   5080
            _ExtentY        =   556
            _Version        =   327681
            BackColor       =   16777215
            ForeColor       =   0
            ListField       =   "interprete"
            BoundColumn     =   "cod_interprete"
            Text            =   ""
         End
         Begin VB.Label Label7 
            AutoSize        =   -1  'True
            Caption         =   "Estilo Musical"
            Height          =   195
            Left            =   2820
            TabIndex        =   23
            Top             =   2415
            Width           =   960
         End
         Begin VB.Label Label6 
            AutoSize        =   -1  'True
            Caption         =   "Grupo Musical"
            Height          =   195
            Left            =   225
            TabIndex        =   22
            Top             =   2415
            Width           =   1020
         End
         Begin VB.Label Label5 
            AutoSize        =   -1  'True
            Caption         =   "Valor "
            Height          =   195
            Left            =   7050
            TabIndex        =   21
            Top             =   420
            Width           =   405
         End
         Begin VB.Label Label4 
            AutoSize        =   -1  'True
            Caption         =   "Qtde."
            Height          =   195
            Left            =   5955
            TabIndex        =   20
            Top             =   435
            Width           =   390
         End
         Begin VB.Label Label3 
            AutoSize        =   -1  'True
            Caption         =   "Descrição do Título"
            Height          =   195
            Left            =   1335
            TabIndex        =   19
            Top             =   465
            Width           =   1410
         End
         Begin VB.Label Label2 
            AutoSize        =   -1  'True
            Caption         =   "Código"
            Height          =   195
            Left            =   195
            TabIndex        =   18
            Top             =   465
            Width           =   495
         End
         Begin VB.Label Label1 
            AutoSize        =   -1  'True
            Caption         =   "Intérprete"
            Height          =   195
            Left            =   5850
            TabIndex        =   17
            Top             =   2415
            Width           =   675
         End
      End
      Begin Threed.SSPanel SSPanel19 
         Height          =   495
         Left            =   1380
         TabIndex        =   4
         Top             =   5475
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
         Begin Threed.SSCommand SSCmdGrava_Tit 
            Height          =   465
            Left            =   15
            TabIndex        =   5
            Tag             =   "DBTTip:Grava o Título"
            Top             =   15
            Width           =   705
            _Version        =   65536
            _ExtentX        =   1244
            _ExtentY        =   820
            _StockProps     =   78
            Picture         =   "CDS.frx":0483
         End
      End
      Begin Threed.SSPanel SSPanel20 
         Height          =   495
         Left            =   2505
         TabIndex        =   24
         Top             =   5475
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
         Begin Threed.SSCommand SSCmdLimp_Tit 
            Height          =   465
            Left            =   15
            TabIndex        =   25
            Tag             =   "DBTTip:Novo Título"
            Top             =   15
            Width           =   705
            _Version        =   65536
            _ExtentX        =   1244
            _ExtentY        =   820
            _StockProps     =   78
            Picture         =   "CDS.frx":0595
         End
      End
      Begin Threed.SSPanel SSPanel21 
         Height          =   495
         Left            =   3630
         TabIndex        =   26
         Top             =   5475
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
         Begin Threed.SSCommand SSCmdExc_Tit 
            Height          =   465
            Left            =   15
            TabIndex        =   27
            Tag             =   "DBTTip:Apaga o Título"
            Top             =   15
            Width           =   705
            _Version        =   65536
            _ExtentX        =   1244
            _ExtentY        =   820
            _StockProps     =   78
            Picture         =   "CDS.frx":06A7
         End
      End
      Begin Threed.SSPanel SSPanel23 
         Height          =   495
         Left            =   4740
         TabIndex        =   28
         Top             =   5460
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
         Begin Threed.SSCommand SSCmdImp_Tit 
            Height          =   465
            Left            =   15
            TabIndex        =   29
            Tag             =   "DBTTip:Imprime os Relatórios"
            Top             =   15
            Width           =   705
            _Version        =   65536
            _ExtentX        =   1244
            _ExtentY        =   820
            _StockProps     =   78
            Picture         =   "CDS.frx":0AF9
         End
      End
      Begin Threed.SSPanel SSPanel24 
         Height          =   495
         Left            =   5820
         TabIndex        =   30
         Top             =   5460
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
         Begin Threed.SSCommand SSCmdSai_Tit 
            Height          =   465
            Left            =   15
            TabIndex        =   31
            Tag             =   "DBTTip:Sair da Rotina "
            Top             =   15
            Width           =   705
            _Version        =   65536
            _ExtentX        =   1244
            _ExtentY        =   820
            _StockProps     =   78
            Picture         =   "CDS.frx":0C0B
         End
      End
      Begin Threed.SSFrame SSFrame2 
         Height          =   2565
         Left            =   -74865
         TabIndex        =   34
         Top             =   585
         Width           =   8985
         _Version        =   65536
         _ExtentX        =   15849
         _ExtentY        =   4524
         _StockProps     =   14
         Caption         =   "Escolha o Título Para Cadastrar as Músicas"
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
         Begin VB.ListBox LstTit_Mus 
            Height          =   1035
            Left            =   1335
            TabIndex        =   35
            Tag             =   "DBTTip:Lista dos Títulos Pesquisados"
            Top             =   1140
            Width           =   4275
         End
         Begin Threed.SSPanel SSPanel4 
            Height          =   345
            Left            =   195
            TabIndex        =   36
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
            Begin VB.TextBox TxtCodT_Mus 
               Appearance      =   0  'Flat
               Height          =   315
               Left            =   15
               MaxLength       =   6
               TabIndex        =   37
               Tag             =   "DBTTip:Código Título"
               Top             =   15
               Width           =   855
            End
         End
         Begin Threed.SSPanel SSPanel7 
            Height          =   345
            Left            =   1335
            TabIndex        =   38
            Top             =   690
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
            Begin VB.TextBox TxtNomT_Mus 
               Appearance      =   0  'Flat
               Height          =   315
               Left            =   15
               MaxLength       =   50
               TabIndex        =   39
               Tag             =   "DBTTip:Use F10 para fazer a pesquisa do Título por Nome ou Partícula do nome"
               Top             =   15
               Width           =   4260
            End
         End
         Begin Threed.SSPanel SSPanel5 
            Height          =   345
            Left            =   5775
            TabIndex        =   45
            Top             =   660
            Width           =   2955
            _Version        =   65536
            _ExtentX        =   5212
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
            Begin VB.TextBox TxtInt_Mus 
               Appearance      =   0  'Flat
               Height          =   315
               Left            =   15
               MaxLength       =   50
               TabIndex        =   46
               Tag             =   "DBTTip:Nome do Intérprete"
               Top             =   15
               Width           =   2925
            End
         End
         Begin Threed.SSPanel SSPanel8 
            Height          =   345
            Left            =   5805
            TabIndex        =   47
            Top             =   1335
            Width           =   2955
            _Version        =   65536
            _ExtentX        =   5212
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
            Begin VB.TextBox TxtGrp_Mus 
               Appearance      =   0  'Flat
               Height          =   315
               Left            =   15
               MaxLength       =   50
               TabIndex        =   48
               Tag             =   "DBTTip:Nome do Grupo Musical"
               Top             =   15
               Width           =   2925
            End
         End
         Begin Threed.SSPanel SSPanel9 
            Height          =   345
            Left            =   5835
            TabIndex        =   49
            Top             =   1980
            Width           =   2955
            _Version        =   65536
            _ExtentX        =   5212
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
            Begin VB.TextBox TxtEst_Mus 
               Appearance      =   0  'Flat
               Height          =   315
               Left            =   15
               MaxLength       =   50
               TabIndex        =   50
               Tag             =   "DBTTip:Nome do Estilo Musical do Título"
               Top             =   15
               Width           =   2925
            End
         End
         Begin VB.Label Label14 
            AutoSize        =   -1  'True
            Caption         =   "Intérprete"
            Height          =   195
            Left            =   5775
            TabIndex        =   44
            Top             =   420
            Width           =   675
         End
         Begin VB.Label Label13 
            AutoSize        =   -1  'True
            Caption         =   "Código Tít."
            Height          =   195
            Left            =   195
            TabIndex        =   43
            Top             =   465
            Width           =   795
         End
         Begin VB.Label Label12 
            AutoSize        =   -1  'True
            Caption         =   "Descrição do Título"
            Height          =   195
            Left            =   1335
            TabIndex        =   42
            Top             =   465
            Width           =   1410
         End
         Begin VB.Label Label9 
            AutoSize        =   -1  'True
            Caption         =   "Grupo Musical"
            Height          =   195
            Left            =   5805
            TabIndex        =   41
            Top             =   1110
            Width           =   1020
         End
         Begin VB.Label Label8 
            AutoSize        =   -1  'True
            Caption         =   "Estilo Musical"
            Height          =   195
            Left            =   5835
            TabIndex        =   40
            Top             =   1770
            Width           =   960
         End
      End
      Begin Threed.SSFrame SSFrame3 
         Height          =   2835
         Left            =   -74820
         TabIndex        =   51
         Top             =   3270
         Width           =   8985
         _Version        =   65536
         _ExtentX        =   15849
         _ExtentY        =   5001
         _StockProps     =   14
         Caption         =   "Cadastre Aqui as Músicas"
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
         Begin VB.ListBox LstMus_Mus 
            Height          =   2010
            Left            =   4605
            TabIndex        =   66
            Tag             =   "DBTTip:Lista das Músicas do Título"
            Top             =   465
            Width           =   4215
         End
         Begin Threed.SSPanel SSPanel10 
            Height          =   345
            Left            =   120
            TabIndex        =   52
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
            Begin VB.TextBox TxtNom_Mus 
               Appearance      =   0  'Flat
               Height          =   315
               Left            =   15
               MaxLength       =   50
               TabIndex        =   53
               Tag             =   "DBTTip:Nome da Música"
               Top             =   15
               Width           =   4260
            End
         End
         Begin Threed.SSPanel SSPanel11 
            Height          =   495
            Left            =   165
            TabIndex        =   56
            Top             =   1515
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
            Begin Threed.SSCommand SSCmdGrava_Mus 
               Height          =   465
               Left            =   15
               TabIndex        =   57
               Tag             =   "DBTTip:Grava a Música"
               Top             =   15
               Width           =   705
               _Version        =   65536
               _ExtentX        =   1244
               _ExtentY        =   820
               _StockProps     =   78
               Picture         =   "CDS.frx":10AD
            End
         End
         Begin Threed.SSPanel SSPanel12 
            Height          =   495
            Left            =   1065
            TabIndex        =   58
            Top             =   1515
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
            Begin Threed.SSCommand SSCmdLimp_Mus 
               Height          =   465
               Left            =   15
               TabIndex        =   59
               Tag             =   "DBTTip:Nova Música"
               Top             =   15
               Width           =   705
               _Version        =   65536
               _ExtentX        =   1244
               _ExtentY        =   820
               _StockProps     =   78
               Picture         =   "CDS.frx":11BF
            End
         End
         Begin Threed.SSPanel SSPanel13 
            Height          =   495
            Left            =   1950
            TabIndex        =   60
            Top             =   1515
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
            Begin Threed.SSCommand SSCmdExc_Mus 
               Height          =   465
               Left            =   15
               TabIndex        =   61
               Tag             =   "DBTTip:Apaga a Música"
               Top             =   15
               Width           =   705
               _Version        =   65536
               _ExtentX        =   1244
               _ExtentY        =   820
               _StockProps     =   78
               Picture         =   "CDS.frx":12D1
            End
         End
         Begin Threed.SSPanel SSPanel14 
            Height          =   495
            Left            =   2835
            TabIndex        =   62
            Top             =   1515
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
            Begin Threed.SSCommand SSCmdImp_Mus 
               Height          =   465
               Left            =   15
               TabIndex        =   63
               Tag             =   "DBTTip:Imprime os Relatórios"
               Top             =   15
               Width           =   705
               _Version        =   65536
               _ExtentX        =   1244
               _ExtentY        =   820
               _StockProps     =   78
               Picture         =   "CDS.frx":1723
            End
         End
         Begin Threed.SSPanel SSPanel15 
            Height          =   495
            Left            =   3720
            TabIndex        =   64
            Top             =   1500
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
            Begin Threed.SSCommand SSCmdSai_Mus 
               Height          =   465
               Left            =   15
               TabIndex        =   65
               Tag             =   "DBTTip:Sair da Rotina "
               Top             =   15
               Width           =   705
               _Version        =   65536
               _ExtentX        =   1244
               _ExtentY        =   820
               _StockProps     =   78
               Picture         =   "CDS.frx":1835
            End
         End
         Begin VB.Label Label11 
            AutoSize        =   -1  'True
            Caption         =   "Lista das Músicas do Título"
            Height          =   195
            Left            =   4620
            TabIndex        =   55
            Top             =   270
            Width           =   1950
         End
         Begin VB.Label Label10 
            AutoSize        =   -1  'True
            Caption         =   "Música"
            Height          =   195
            Left            =   120
            TabIndex        =   54
            Top             =   300
            Width           =   510
         End
      End
      Begin Threed.SSFrame SSFrame4 
         Height          =   2565
         Left            =   -74805
         TabIndex        =   67
         Top             =   615
         Width           =   8985
         _Version        =   65536
         _ExtentX        =   15849
         _ExtentY        =   4524
         _StockProps     =   14
         Caption         =   "Escolha o Título Para Cadastrar o(s) CD(s)"
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
         Begin VB.ListBox LstTitulo_Cd 
            Height          =   1035
            Left            =   1335
            TabIndex        =   68
            Tag             =   "DBTTip:Lista dos Títulos Pesquisados"
            Top             =   1140
            Width           =   4275
         End
         Begin Threed.SSPanel SSPanel16 
            Height          =   345
            Left            =   195
            TabIndex        =   69
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
               Size            =   8.26
               Charset         =   0
               Weight          =   400
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            BevelOuter      =   1
            Autosize        =   3
            Begin VB.TextBox TxtCodT_Cd 
               Appearance      =   0  'Flat
               Height          =   315
               Left            =   15
               MaxLength       =   6
               TabIndex        =   70
               Tag             =   "DBTTip:Código do Título"
               Top             =   15
               Width           =   855
            End
         End
         Begin Threed.SSPanel SSPanel17 
            Height          =   345
            Left            =   1335
            TabIndex        =   71
            Top             =   690
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
            Begin VB.TextBox TxtNomT_Cd 
               Appearance      =   0  'Flat
               Height          =   315
               Left            =   15
               MaxLength       =   50
               TabIndex        =   72
               Tag             =   "DBTTip:Use F10 para fazer a pesquisa do Título por Nome ou Partícula do nome"
               Top             =   15
               Width           =   4260
            End
         End
         Begin Threed.SSPanel SSPanel18 
            Height          =   345
            Left            =   5775
            TabIndex        =   73
            Top             =   660
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
            Begin VB.TextBox TxtInt_Cd 
               Appearance      =   0  'Flat
               Height          =   315
               Left            =   15
               MaxLength       =   50
               TabIndex        =   74
               Tag             =   "DBTTip:Nome do Intérprete"
               Top             =   15
               Width           =   2925
            End
         End
         Begin Threed.SSPanel SSPanel22 
            Height          =   345
            Left            =   5805
            TabIndex        =   75
            Top             =   1335
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
            Begin VB.TextBox TxtGrp_Cd 
               Appearance      =   0  'Flat
               Height          =   315
               Left            =   15
               MaxLength       =   50
               TabIndex        =   76
               Tag             =   "DBTTip:Nome do Grupo Musical"
               Top             =   15
               Width           =   2925
            End
         End
         Begin Threed.SSPanel SSPanel25 
            Height          =   345
            Left            =   5835
            TabIndex        =   77
            Top             =   1980
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
            Begin VB.TextBox TxtEst_Cd 
               Appearance      =   0  'Flat
               Height          =   315
               Left            =   15
               MaxLength       =   50
               TabIndex        =   78
               Tag             =   "DBTTip:Nome do Estilo Musical do Título"
               Top             =   15
               Width           =   2925
            End
         End
         Begin VB.Label Label19 
            AutoSize        =   -1  'True
            Caption         =   "Estilo Musical"
            Height          =   195
            Left            =   5835
            TabIndex        =   83
            Top             =   1770
            Width           =   960
         End
         Begin VB.Label Label18 
            AutoSize        =   -1  'True
            Caption         =   "Grupo Musical"
            Height          =   195
            Left            =   5805
            TabIndex        =   82
            Top             =   1110
            Width           =   1020
         End
         Begin VB.Label Label17 
            AutoSize        =   -1  'True
            Caption         =   "Descrição do Título"
            Height          =   195
            Left            =   1335
            TabIndex        =   81
            Top             =   465
            Width           =   1410
         End
         Begin VB.Label Label16 
            AutoSize        =   -1  'True
            Caption         =   "Código Tít."
            Height          =   195
            Left            =   180
            TabIndex        =   80
            Top             =   450
            Width           =   795
         End
         Begin VB.Label Label15 
            AutoSize        =   -1  'True
            Caption         =   "Intérprete"
            Height          =   195
            Left            =   5775
            TabIndex        =   79
            Top             =   420
            Width           =   675
         End
      End
      Begin Threed.SSFrame SSFrame5 
         Height          =   2835
         Left            =   -74805
         TabIndex        =   84
         Top             =   3405
         Width           =   6975
         _Version        =   65536
         _ExtentX        =   12303
         _ExtentY        =   5001
         _StockProps     =   14
         Caption         =   "Cadastre Aqui os CD's"
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
         Begin VB.ListBox LstCds_Cd 
            Height          =   1230
            Left            =   4605
            TabIndex        =   85
            Tag             =   "DBTTip:Lista dos CD's do Título"
            Top             =   480
            Width           =   1830
         End
         Begin Threed.SSPanel SSPanel26 
            Height          =   345
            Left            =   120
            TabIndex        =   86
            Top             =   510
            Width           =   1005
            _Version        =   65536
            _ExtentX        =   1773
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
            Begin VB.TextBox TxtCod_Cd 
               Appearance      =   0  'Flat
               Height          =   315
               Left            =   15
               MaxLength       =   50
               TabIndex        =   87
               Tag             =   "DBTTip:Código do CD"
               Top             =   15
               Width           =   975
            End
         End
         Begin Threed.SSPanel SSPanel27 
            Height          =   495
            Left            =   150
            TabIndex        =   88
            Top             =   2175
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
               TabIndex        =   89
               Tag             =   "DBTTip:Grava o CD"
               Top             =   15
               Width           =   705
               _Version        =   65536
               _ExtentX        =   1244
               _ExtentY        =   820
               _StockProps     =   78
               Picture         =   "CDS.frx":1CD7
            End
         End
         Begin Threed.SSPanel SSPanel28 
            Height          =   495
            Left            =   1065
            TabIndex        =   90
            Top             =   2160
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
            Begin Threed.SSCommand SSCmdLimp_Cd 
               Height          =   465
               Left            =   15
               TabIndex        =   91
               Tag             =   "DBTTip:Novo CD"
               Top             =   15
               Width           =   705
               _Version        =   65536
               _ExtentX        =   1244
               _ExtentY        =   820
               _StockProps     =   78
               Picture         =   "CDS.frx":1DE9
            End
         End
         Begin Threed.SSPanel SSPanel29 
            Height          =   495
            Left            =   1935
            TabIndex        =   92
            Top             =   2160
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
            Begin Threed.SSCommand SSCmdExc_Cd 
               Height          =   465
               Left            =   15
               TabIndex        =   93
               Tag             =   "DBTTip:Apaga o CD"
               Top             =   15
               Width           =   705
               _Version        =   65536
               _ExtentX        =   1244
               _ExtentY        =   820
               _StockProps     =   78
               Picture         =   "CDS.frx":1EFB
            End
         End
         Begin Threed.SSPanel SSPanel30 
            Height          =   495
            Left            =   2850
            TabIndex        =   94
            Top             =   2145
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
            Begin Threed.SSCommand SSCmdImp_Cd 
               Height          =   465
               Left            =   15
               TabIndex        =   95
               Tag             =   "DBTTip:Imprime os Relatórios"
               Top             =   15
               Width           =   705
               _Version        =   65536
               _ExtentX        =   1244
               _ExtentY        =   820
               _StockProps     =   78
               Picture         =   "CDS.frx":234D
            End
         End
         Begin Threed.SSPanel SSPanel31 
            Height          =   495
            Left            =   3720
            TabIndex        =   96
            Top             =   2145
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
            Begin Threed.SSCommand SSCmdSair_Cd 
               Height          =   465
               Left            =   15
               TabIndex        =   97
               Tag             =   "DBTTip:Sair da Rotina "
               Top             =   15
               Width           =   705
               _Version        =   65536
               _ExtentX        =   1244
               _ExtentY        =   820
               _StockProps     =   78
               Picture         =   "CDS.frx":245F
            End
         End
         Begin Threed.SSPanel SSPanel32 
            Height          =   345
            Left            =   1395
            TabIndex        =   100
            Top             =   495
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
            Begin MSMask.MaskEdBox MskDtaCp_Cd 
               Height          =   315
               Left            =   15
               TabIndex        =   101
               Tag             =   "DBTTip:Data da Aquisição do CD"
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
         Begin Threed.SSPanel SSPanel33 
            Height          =   345
            Left            =   2925
            TabIndex        =   102
            Top             =   495
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
            Begin VB.TextBox TxtVal_Cd 
               Appearance      =   0  'Flat
               Height          =   315
               Left            =   15
               MaxLength       =   50
               TabIndex        =   103
               Tag             =   "DBTTip:Valor do CD em R$"
               Top             =   15
               Width           =   1185
            End
         End
         Begin Threed.SSFrame SSFrame6 
            Height          =   990
            Left            =   120
            TabIndex        =   106
            Tag             =   "DBTTip:Indica  o estado do  CD no ACERVO "
            Top             =   945
            Width           =   1800
            _Version        =   65536
            _ExtentX        =   3175
            _ExtentY        =   1736
            _StockProps     =   14
            Caption         =   "Estado do CD"
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
            Begin Threed.SSOption SSOptFora_Cd 
               Height          =   204
               Left            =   156
               TabIndex        =   109
               Top             =   612
               Width           =   1536
               _Version        =   65536
               _ExtentX        =   2709
               _ExtentY        =   360
               _StockProps     =   78
               Caption         =   "Fora do Acervo"
               ForeColor       =   255
               BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
                  Name            =   "MS Sans Serif"
                  Size            =   8.63
                  Charset         =   0
                  Weight          =   400
                  Underline       =   0   'False
                  Italic          =   0   'False
                  Strikethrough   =   0   'False
               EndProperty
            End
            Begin Threed.SSOption SSOptAtivo_Cd 
               Height          =   300
               Left            =   150
               TabIndex        =   108
               Top             =   255
               Width           =   1155
               _Version        =   65536
               _ExtentX        =   2037
               _ExtentY        =   529
               _StockProps     =   78
               Caption         =   "Ativo"
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
         Begin Threed.SSFrame SSFrame7 
            Height          =   1005
            Left            =   2190
            TabIndex        =   107
            Tag             =   "DBTTip:Tipo de CD"
            Top             =   945
            Width           =   1950
            _Version        =   65536
            _ExtentX        =   3440
            _ExtentY        =   1773
            _StockProps     =   14
            Caption         =   "Tipo de CD"
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
            Begin Threed.SSOption SSOptDuplo_Cd 
               Height          =   240
               Left            =   165
               TabIndex        =   111
               Top             =   600
               Width           =   1155
               _Version        =   65536
               _ExtentX        =   2037
               _ExtentY        =   423
               _StockProps     =   78
               Caption         =   "CD Duplo"
               BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
                  Name            =   "MS Sans Serif"
                  Size            =   8.24
                  Charset         =   0
                  Weight          =   400
                  Underline       =   0   'False
                  Italic          =   0   'False
                  Strikethrough   =   0   'False
               EndProperty
            End
            Begin Threed.SSOption SSOptSimp_Cd 
               Height          =   264
               Left            =   156
               TabIndex        =   110
               Top             =   276
               Width           =   1572
               _Version        =   65536
               _ExtentX        =   2773
               _ExtentY        =   466
               _StockProps     =   78
               Caption         =   "CD Simples"
               BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
                  Name            =   "MS Sans Serif"
                  Size            =   8.07
                  Charset         =   0
                  Weight          =   400
                  Underline       =   0   'False
                  Italic          =   0   'False
                  Strikethrough   =   0   'False
               EndProperty
               Value           =   -1  'True
            End
         End
         Begin VB.Label Label23 
            AutoSize        =   -1  'True
            Caption         =   "Valor Compra"
            Height          =   195
            Left            =   2895
            TabIndex        =   105
            Top             =   315
            Width           =   945
         End
         Begin VB.Label Label22 
            AutoSize        =   -1  'True
            Caption         =   "Data Compra"
            Height          =   195
            Left            =   1380
            TabIndex        =   104
            Top             =   300
            Width           =   930
         End
         Begin VB.Label Label21 
            AutoSize        =   -1  'True
            Caption         =   "Código do CD"
            Height          =   195
            Left            =   120
            TabIndex        =   99
            Top             =   300
            Width           =   990
         End
         Begin VB.Label Label20 
            AutoSize        =   -1  'True
            Caption         =   "Lista dos CD's do Título"
            Height          =   195
            Left            =   4620
            TabIndex        =   98
            Top             =   270
            Width           =   1695
         End
      End
   End
End
Attribute VB_Name = "Cds"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Dim cdgrupo_tit As String
Dim cdestilo_tit As String
Dim cdinterp_tit As String
Dim msgI As String
Dim tit_tit As String
Dim Atualiza As String
Dim cdgrupo_mus As String
Dim cdestilo_mus As String
Dim cdinterp_mus As String
Dim tit_mus As String
Dim Atualiza_mus As String
Dim cdgrupo_cd As String
Dim cdestilo_cd As String
Dim cdinterp_cd As String
Dim tit_cd As String
Dim Atualiza_cd As String
Dim cod_cd As String
Dim SQLData As String
Dim cod_musica As String
Private Sub dados_cd()
     If Wcdfisico.RecordCount <> 0 Then
        Wcdfisico.Index = "primarykey"
        Wcdfisico.MoveFirst
        Wcdfisico.Seek "=", TxtCodT_Cd, TxtCod_Cd
        If Not Wcdfisico.NoMatch Then
           MskDtaCp_Cd.SelText = Format(Wcdfisico("data_compra"), "dd/mm/yyyy")
           TxtVal_Cd = Format(Wcdfisico("valor"), "0.00")
           If Wcdfisico("ativo") = True Then
              SSOptAtivo_Cd.Value = True
           Else
              SSOptFora_Cd.Value = True
           End If
           If Wcdfisico("cd_duplo") = True Then
              SSOptDuplo_Cd.Value = True
           Else
              SSOptSimp_Cd.Value = True
           End If
        End If
     End If
End Sub

Private Sub dados_tit2()
    'carrega os campos
     TxtCodT_Mus.Text = Format(Wtitulo("cod_titulo"), "00000")
     TxtNomT_Mus = Wtitulo("titulo")
     
    'Pesquisa o Grupo
     Wgrupo.Index = "primarykey"
     Wgrupo.Seek "=", Wtitulo("cod_grupo")
     TxtGrp_Mus = Wgrupo("nome_grupo")
     cdgrupo_mus = Wtitulo("cod_grupo")
     
     'Pesquisa o estilo
     Westilo.Index = "cod_estilo"
     Westilo.Seek "=", Wtitulo("cod_estilo")
     TxtEst_Mus = Westilo("nome_estilo")
     cdestilo_mus = Wtitulo("cod_estilo")
   
     'Pesquisa o interprete no relacionamento titulo-interprete
     wtinterprete.Index = "cod_titulo"
     wtinterprete.Seek "=", Wtitulo("cod_titulo")
     
     'Pesquisa o interprete na tabela interprete
     Winterprete.Index = "cod_interprete"
     Winterprete.Seek "=", wtinterprete("cod_interprete")
     TxtInt_Mus = Winterprete("interprete")
     cdinterp_mus = wtinterprete("cod_interprete")
     
     Wtmusica.Index = "cod_titulo"
     Wtmusica.MoveFirst
     Wtmusica.Seek "=", TxtCodT_Mus
     If Not Wtmusica.NoMatch Then
        Do While Not Wtmusica.EOF And Format(Wtmusica("cod_titulo"), "00000") = TxtCodT_Mus
           wmusica.Index = "primarykey"
           wmusica.MoveFirst
           wmusica.Seek "=", Wtmusica("cod_musica")
           LstMus_Mus.AddItem Format(wmusica("cod_musica"), "00000") + "  - " + wmusica("titulo_musica")
           Wtmusica.MoveNext
           If Wtmusica.EOF Then
              Exit Do
           End If
        Loop
     End If
     TxtNom_Mus.SetFocus
End Sub

Private Sub dados_tit3()
    'carrega os campos
     TxtCodT_Cd.Text = Format(Wtitulo("cod_titulo"), "00000")
     TxtNomT_Cd = Wtitulo("titulo")
     
    'Pesquisa o Grupo
     Wgrupo.Index = "primarykey"
     Wgrupo.Seek "=", Wtitulo("cod_grupo")
     TxtGrp_Cd = Wgrupo("nome_grupo")
     cdgrupo_cd = Wtitulo("cod_grupo")
     
     'Pesquisa o estilo
     Westilo.Index = "cod_estilo"
     Westilo.Seek "=", Wtitulo("cod_estilo")
     TxtEst_Cd = Westilo("nome_estilo")
     cdestilo_cd = Wtitulo("cod_estilo")
   
     'Pesquisa o interprete no relacionamento titulo-interprete
     wtinterprete.Index = "cod_titulo"
     wtinterprete.Seek "=", Wtitulo("cod_titulo")
     
     'Pesquisa o interprete na tabela interprete
     Winterprete.Index = "cod_interprete"
     Winterprete.Seek "=", wtinterprete("cod_interprete")
     TxtInt_Cd = Winterprete("interprete")
     cdinterp_cd = wtinterprete("cod_interprete")
     
     Wcdfisico.Index = "cod_titulo"
     Wcdfisico.MoveFirst
     Wcdfisico.Seek "=", TxtCodT_Cd
     LstCds_Cd.Clear
     If Not Wcdfisico.NoMatch Then
        Do While Not Wcdfisico.EOF And Format(Wcdfisico("cod_titulo"), "00000") = TxtCodT_Cd
           'Wtitulo.Index = "primarykey"
           'Wtitulo.MoveFirst
           'Wtitulo.Seek "=", Wcdfisico("cod_titulo")
           LstCds_Cd.AddItem Format(Wcdfisico("cod_cd"), ">")
           Wcdfisico.MoveNext
           If Wcdfisico.EOF Then
              Exit Do
           End If
        Loop
     End If
     TxtCod_Cd.SetFocus
End Sub

Private Sub dados_titulo()
     msgI = "Atualização"
     Atualiza = "Sim" ' Variável que indica que o registro foi editado

    'carrega os campos
     TxtCod_Tit.Text = Format(Wtitulo("cod_titulo"), "00000")
     TxtNom_Tit.Text = Wtitulo("titulo")
     
     If Not IsNull(Wtitulo("qtde_tot")) Then
        MskQtde_Tit.SelText = Format(Wtitulo("qtde_tot"), "0000")
     End If
     If Not IsNull(Wtitulo("valor")) Then
        TxtVal_Tit.Text = Format(Wtitulo("valor"), "0.00")
     Else
        TxtVal_Tit.Text = "0.00"
     End If
     If Wtitulo("locacao") = "24" Then
        SSOpt24_Tit.Value = True
     Else
        SSOpt48_Tit.Value = True
     End If
     'Atribui ops Valores as variáveis
     cdgrupo_tit = Wtitulo("cod_grupo")
     cdestilo_tit = Wtitulo("cod_estilo")
     
     'Pesquisa o Grupo
     Wgrupo.Index = "primarykey"
     Wgrupo.Seek "=", Wtitulo("cod_grupo")
     DBCGrp_Tit.Text = Wgrupo("nome_grupo")
     
     'Pesquisa o estilo
     Westilo.Index = "cod_estilo"
     Westilo.Seek "=", Wtitulo("cod_estilo")
     DBCEst_Tit.Text = Westilo("nome_estilo")
   
     'Pesquisa o interprete no relacionamento titulo-interprete
     wtinterprete.Index = "cod_titulo"
     wtinterprete.Seek "=", Wtitulo("cod_titulo")
     
     'Pesquisa o interprete na tabela interprete
     Winterprete.Index = "cod_interprete"
     Winterprete.Seek "=", wtinterprete("cod_interprete")
     DBCInt_Tit.Text = Winterprete("interprete")
     cdinterp_tit = wtinterprete("cod_interprete")

End Sub


Private Sub limpa_cd()
   LstTitulo_Cd.Clear
   LstCds_Cd.Clear
   TxtCodT_Cd = ""
   TxtNomT_Cd = ""
   TxtGrp_Cd = ""
   TxtEst_Cd = ""
   TxtInt_Cd = ""
   TxtCod_Cd = ""
   MskDtaCp_Cd.Mask = ""
   MskDtaCp_Cd.Text = ""
   MskDtaCp_Cd.Mask = "##/##/####"
   TxtVal_Cd = ""
   Atualiza_cd = "Não"
   msgI = "Inclusão"
   SSOptAtivo_Cd.Value = True
   SSOptSimp_Cd.Value = True
End Sub

Private Sub limpa_musica()
     'Limpa os campos de Música
     TxtCodT_Mus.Text = ""
     TxtNomT_Mus = ""
     TxtGrp_Mus = ""
     TxtEst_Mus = ""
     TxtInt_Mus = ""
     LstMus_Mus.Clear
     TxtNom_Mus = ""
     Atualiza_mus = "Não"
End Sub

Private Sub limpa_titulo()
   'Limpa os campos do tab título
   LstNom_Tit.Clear
   TxtCod_Tit = ""
   TxtNom_Tit = ""
   MskQtde_Tit.Mask = ""
   MskQtde_Tit.Text = ""
   MskQtde_Tit.Mask = "#####"
   TxtVal_Tit = ""
   SSOpt24_Tit.Value = True
   DBCGrp_Tit = ""
   DBCEst_Tit = ""
   DBCInt_Tit = ""
   'Calcula o novo código e se posiciona
   Set VTb = Wtitulo
   VIx = "primarykey"
   VCt = "Cod_titulo"
   TxtCod_Tit = geracod()
   TxtCod_Tit = Format(TxtCod_Tit, "00000")
   TxtCod_Tit.SetFocus
   
End Sub

Private Sub pesq_titulo()
     Msg = "Digite o Nome do Título a ser Pesquisado"
     tit = "CD'S Loc - Pesquisa Título"
     Pesq_Tit = InputBox(Msg, tit)
     'inicio da rotina para escolha de um cliente
     If Pesq_Tit <> "" Then
        LstTit_Mus.Clear
        LstNom_Tit.Clear
        Wtitulo.MoveFirst
        While Not Wtitulo.EOF
          ' Pesquisa Cliente
          pesquisa = InStr(Wtitulo!titulo, UCase(Pesq_Tit)) ' Maiúsculas
          pesquisa2 = InStr(Wtitulo!titulo, Pesq_Tit) ' Minúsculas
          If pesquisa <> 0 Or pesquisa2 <> 0 Then
                If tit_mus = "Sim" Then
                   LstTit_Mus.AddItem Wtitulo("titulo")
                ElseIf tit_tit = "Sim" Then
                   LstNom_Tit.AddItem Wtitulo("titulo")
                ElseIf tit_cd = "Sim" Then
                   LstTitulo_Cd.AddItem Wtitulo("titulo")
                End If
          End If
          Wtitulo.MoveNext
        Wend
     End If
     tit_mus = ""
     tit_cd = ""
     tit_tit = ""
End Sub


Private Sub DBCEst_Tit_KeyDown(KeyCode As Integer, Shift As Integer)
   If KeyCode = 13 Then
      DBCInt_Tit.SetFocus
   End If
End Sub

Private Sub DBCEst_Tit_LostFocus()
    If DBCEst_Tit.BoundText <> "" Then cdestilo_tit = DBCEst_Tit.BoundText
End Sub

Private Sub DBCGrp_Tit_KeyDown(KeyCode As Integer, Shift As Integer)
   If KeyCode = 13 Then
      DBCEst_Tit.SetFocus
   End If
End Sub

Private Sub DBCGrp_Tit_LostFocus()
    If DBCGrp_Tit.BoundText <> "" Then
       cdgrupo_tit = DBCGrp_Tit.BoundText
       SQL = "select * from estilo where cod_grupo=" + cdgrupo_tit + ""
       Data_Estilo.RecordSource = SQL
       Data_Estilo.Refresh
    End If
End Sub

Private Sub DBCInt_Tit_LostFocus()
   If DBCInt_Tit.BoundText <> "" Then cdinterp_tit = DBCInt_Tit.BoundText
End Sub


Private Sub Form_Activate()
   Data_Estilo.Refresh
   Data_Grupo.Refresh
   Data_Interp.Refresh
End Sub

Private Sub Form_Load()

    
   With Cds
      .Left = 1260
      .Height = 6855
      .Width = 9645
      .Top = 390
   End With
    
      
   Set vformu = Cds
   
   ChDir App.Path 'muda para diretório de carga

   With Data_Estilo
     'Seta o data
     .DatabaseName = App.Path & "\bd_cdloc.mdb"
     
     .Refresh
   End With
   
   With Data_Grupo
     'Seta o data
     .DatabaseName = App.Path & "\bd_cdloc.mdb"
     SQLData = "select cod_grupo,nome_grupo from grupo order by cod_grupo"
     .RecordSource = SQLData
     .Refresh
   End With
   
   With Data_Interp
     'Seta o data
     .DatabaseName = App.Path & "\bd_cdloc.mdb"
     SQLData = "select cod_interprete,interprete from interprete order by interprete"
     .RecordSource = SQLData
     .Refresh
   End With
   
End Sub

Private Sub LstCds_Cd_Click()
    mensagem = "Alterar"
    Atualiza_cd = "Sim"
    msgI = "Alteração"
    Msg = MsgBox("Voçê selecionou o CD ? " & LstCds_Cd.Text, 36)
    If Msg = 7 Then 'Resposta = Não
       TxtCod_Cd = ""
       Exit Sub
    End If
    cod_cd = LstCds_Cd.Text
    TxtCod_Cd = LstCds_Cd.Text
    'chama a procedure que pesquisa o cd
    dados_cd
End Sub

Private Sub LstMus_Mus_Click()
    mensagem = "Alterar"
    Atualiza_mus = "Sim"
    msgI = "Alteração"
    Msg = MsgBox("Voçê selecionou a Música ? " & LstMus_Mus.Text, 36)
    If Msg = 7 Then 'Resposta = Não
       TxtNom_Mus = ""
       Exit Sub
    End If
    cod_musica = Left(LstMus_Mus, 5)
    TxtNom_Mus = Mid(LstMus_Mus, 10)
End Sub

Private Sub LstNom_Tit_Click()
    TxtNom_Tit = LstNom_Tit
    Wtitulo.Index = "titulo"
    Wtitulo.MoveFirst
    Wtitulo.Seek "=", LstNom_Tit.Text
    If Wtitulo.NoMatch Then
       ' Cliente Não Cadastrado
       msgI = "Inclusão"
       mensagem = "Incluir"
    Else
       mensagem = "Alterar"
       TxtCod_Tit = Wtitulo("cod_titulo")
       Msg = MsgBox("Voçê selecionou o Título ? " + TxtCod_Tit + "  " + LstNom_Tit.Text, 36)
       If Msg = 7 Then 'Resposta = Não
          TxtNom_Tit = ""
          TxtCod_Tit = ""
          Exit Sub
       End If
       'Chama a Procedure para preencher os campos
       dados_titulo
       TxtNom_Tit.SetFocus
    End If
End Sub

Private Sub LstTit_Mus_Click()
    TxtNomT_Mus = LstTit_Mus
    Wtitulo.Index = "titulo"
    Wtitulo.MoveFirst
    Wtitulo.Seek "=", LstTit_Mus.Text
    If Wtitulo.NoMatch Then
       ' Cliente Não Cadastrado
       msgI = "Inclusão"
       mensagem = "Incluir"
    Else
       mensagem = "Alterar"
       TxtCodT_Mus = Wtitulo("cod_titulo")
       Msg = MsgBox("Voçê selecionou o Título ? " + TxtCodT_Mus + "  " + LstTit_Mus.Text, 36)
       If Msg = 7 Then 'Resposta = Não
          TxtNomT_Mus = ""
          TxtCodT_Mus = ""
          Exit Sub
       End If
       'Chama a Procedure para preencher os campos
       dados_tit2
    End If
End Sub

Private Sub LstTitulo_Cd_Click()
    TxtNomT_Cd = LstTitulo_Cd
    Wtitulo.Index = "titulo"
    Wtitulo.MoveFirst
    Wtitulo.Seek "=", LstTitulo_Cd.Text
    If Wtitulo.NoMatch Then
       ' Cliente Não Cadastrado
       msgI = "Inclusão"
       mensagem = "Incluir"
    Else
       mensagem = "Alterar"
       TxtCodT_Cd = Wtitulo("cod_titulo")
       Msg = MsgBox("Voçê selecionou o Título ? " + TxtCodT_Cd + "  " + LstTitulo_Cd.Text, 36)
       If Msg = 7 Then 'Resposta = Não
          TxtNomT_Cd = ""
          TxtCodT_Cd = ""
          Exit Sub
       End If
       'Chama a Procedure para preencher os campos
       dados_tit3
    End If
End Sub



Private Sub MskDtaCp_Cd_KeyPress(KeyAscii As Integer)
    If KeyAscii = 13 Then
       TxtVal_Cd.SetFocus
    End If
End Sub

Private Sub MskDtaCp_Cd_LostFocus()
   If Not IsDate(MskDtaCp_Cd) Then
      MsgBox "Data Inválida", 16
      MskDtaCp_Cd.SetFocus
   End If
End Sub


Private Sub MskQtde_Tit_KeyDown(KeyCode As Integer, Shift As Integer)
    If KeyCode = vbKeyF2 Then
       SSTab1.Tab = 1
       SSTab1_GotFocus
    ElseIf KeyCode = vbKeyF3 Then
       SSTab1.Tab = 2
       SSTab1_GotFocus
    End If
End Sub

Private Sub MskQtde_Tit_KeyPress(KeyAscii As Integer)
   If KeyAscii = 13 Then
      TxtVal_Tit.SetFocus
   End If
End Sub

Private Sub SSCmdExc_Cd_Click()
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
       'Posiciona no Nome da música
       TxtCod_Cd.SetFocus
    Else
       If TxtCodT_Cd <> "" Then
          If TxtCod_Cd <> "" Then
             If Wcdfisico.RecordCount <> 0 Then
                Wcdfisico.MoveFirst
                Wcdfisico.Index = "Primarykey"
                Wcdfisico.Seek "=", TxtCodT_Cd, TxtCod_Cd
                If Not Wcdfisico.NoMatch Then
                   'Apaga registro do Banco de Dados
                   Wcdfisico.Delete
                End If
                ' Retira da lista
                For I = 0 To LstCds_Cd.ListCount - 1
                    If LstCds_Cd.List(I) = LstCds_Cd Then
                       LstCds_Cd.RemoveItem I
                       Exit For
                    End If
                Next
             End If
          Else
             MsgBox "SELECIONE o CD para EXCLUIR", 32
          End If
       Else
          MsgBox "Não existe registro para EXCLUIR", 32
       End If
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
    'Limpa
    TxtCod_Cd = ""
    MskDtaCp_Cd.Mask = ""
    MskDtaCp_Cd.Text = ""
    MskDtaCp_Cd.Mask = "##/##/####"
    TxtVal_Cd = ""
    Atualiza_cd = "Não"
    msgI = "Inclusão"
    SSOptAtivo_Cd.Value = True
    SSOptSimp_Cd.Value = True
    TxtCod_Cd.SetFocus
    Exit Sub
    Resume  ' Resume execution at same line
                ' that caused the error.
End Sub

Private Sub SSCmdExc_Mus_Click()
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
       'Posiciona no Nome da música
       TxtNom_Mus.SetFocus
    Else
       If TxtCodT_Mus <> "" Then
          If cod_musica <> "" Then
             If wmusica.RecordCount <> 0 Then
                Wminterprete.MoveFirst
                Wminterprete.Index = "Primarykey"
                Wminterprete.Seek "=", cod_musica, cdinterp_mus
                If Not Winterprete.NoMatch Then
                   'Apaga registro do Banco de Dados
                   Wminterprete.Delete
                End If
          
                Wtmusica.MoveFirst
                Wtmusica.Index = "Primarykey"
                Wtmusica.Seek "=", TxtCodT_Mus, cod_musica
                If Not Wtmusica.NoMatch Then
                   'Apaga registro do Banco de Dados
                   Wtmusica.Delete
                End If
          
                wmusica.MoveFirst
                wmusica.Index = "primarykey"
                wmusica.Seek "=", cod_musica
                ' Retira da lista a musica anterior
                For I = 0 To LstMus_Mus.ListCount - 1
                    If LstMus_Mus.List(I) = LstMus_Mus Then
                       LstMus_Mus.RemoveItem I
                       Exit For
                    End If
                Next
               If Not wmusica.NoMatch Then
                  'Apaga registro do Banco de Dados
                  wmusica.Delete
               End If
             End If
          Else
             MsgBox "SELECIONE a Música para EXCLUIR", 32
          End If
       Else
          MsgBox "Não existe registro para EXCLUIR", 32
       End If
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
    'Limpa
    cod_musica = ""
    TxtNom_Mus = ""
    Atualiza_mus = "Não"
    msgI = "Inclusão"
    TxtNom_Mus.SetFocus
    Exit Sub
    Resume  ' Resume execution at same line
                ' that caused the error.
End Sub

Private Sub SSCmdExc_Tit_Click()
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
       TxtCod_Tit.SetFocus
    Else
       If Wtitulo.RecordCount <> 0 Then
          Wtitulo.Index = "primarykey"
          Wtitulo.MoveFirst
          Wtitulo.Seek "=", TxtCod_Tit
      
          If Not Wtitulo.NoMatch Then
             'Apaga registro do Banco de Dados
             Wtitulo.Delete
          Else
             MsgBox "SELECIONE registro para EXCLUIR", 32
          End If
       Else
          MsgBox "Não existe registro para EXCLUIR", 32
       End If
    End If
    'Chama a Procedure que Limpa
    limpa_titulo
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
    TxtCod_Tit.SetFocus
    Exit Sub
    Resume  ' Resume execution at same line
                ' that caused the error.
End Sub

Private Sub SSCmdGrava_Cd_Click()
   On Error GoTo traterro
   If TxtCodT_Cd = "" Or cdgrupo_cd = "" Or cdestilo_cd = "" Or cdinterp_cd = "" Then
       MsgBox "Selecione o TÍTULO para Incluir/Alterar um CD", 48, "AVISO"
       TxtCodT_Cd.SetFocus
    Else
       Msg = MsgBox("Confirme a " + msgI, 36, "CONFIRMAÇÃO")
       If Msg = 6 Then   'Se a tecla acionado foi Sim
          
          
          'Inicia a Transação
          Workspaces(0).BeginTrans
          If Atualiza_cd = "Sim" Then
              Wcdfisico.MoveFirst
              Wcdfisico.Index = "primarykey"
              Wcdfisico.Seek "=", TxtCodT_Cd, cod_cd
              Wcdfisico.Edit
              Wcdfisico("cod_cd") = TxtCod_Cd
          Else
              'Pesquisa a Qtde de Títulos Disponivel
              Dim qtde_disp As Byte
              With Wtitulo
                .MoveFirst
                .Index = "primarykey"
                .Seek "=", TxtCodT_Cd
                qtde_disp = Wtitulo!qtde_tot
              End With
          
              If LstCds_Cd.ListCount >= qtde_disp Then
                 MsgBox "A Qtde. Informada no Cadastro de Títulos é de: " & Format(qtde_disp, "00") & " Título(s), você não pode cadastrar mais CD do que a qtde. informada", vbInformation, "CD'S Loc - Sistema de Locação"
                 'Desfaz a Transação
                 Workspaces(0).Rollback
                 Exit Sub
             End If
             
             Wcdfisico.AddNew
             Wcdfisico("cod_titulo") = TxtCodT_Cd
             Wcdfisico("cod_cd") = TxtCod_Cd
             'Inclui no List novo cd
             LstCds_Cd.AddItem Format(TxtCod_Cd, ">")
          End If
          Wcdfisico("data_compra") = MskDtaCp_Cd
          Wcdfisico("valor") = Val(TxtVal_Cd)
          If SSOptAtivo_Cd.Value = True Then
             Wcdfisico("ativo") = True
          Else
             Wcdfisico("ativo") = False
          End If
          If SSOptDuplo_Cd.Value = True Then
             Wcdfisico("cd_duplo") = True
          Else
             Wcdfisico("cd_duplo") = False
          End If
          
          'Grava na tabela música
          Wcdfisico.Update
          
          gravou = "Sim"
       Else
          MsgBox "Operação Cancelada", 48, "AVISO"
          gravou = "Não"
       End If
       Atualiza_cd = "Não"
       msgI = "Inclusão"
       'Apaga o nome da música no text
       TxtCod_Cd = ""
       MskDtaCp_Cd.Mask = ""
       MskDtaCp_Cd.Text = ""
       MskDtaCp_Cd.Mask = "##/##/####"
       TxtVal_Cd = ""
       SSOptAtivo_Cd.Value = True
       SSOptSimp_Cd.Value = True
       TxtCod_Cd.SetFocus
    End If
    
traterro:
    Select Case Err.Number
    Case Is = 3201
        MsgBox "Falta Registro Relacionado na Tabela", vbCritical, _
        "CD'S Loc - Locadora de CD"
        'Desfaz a Transação
        Workspaces(0).Rollback
    Case Is = 3421
        MsgBox "A Data está Incorreta", vbCritical, _
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

Private Sub SSCmdGrava_Mus_Click()
    On Error GoTo traterro
    If TxtCodT_Mus = "" Or cdgrupo_mus = "" Or cdestilo_mus = "" Or cdinterp_mus = "" Then
       MsgBox "Selecione o TÍTULO para Incluir uma MÚSICA", 48, "AVISO"
       TxtCodT_Mus.SetFocus
    Else
       Msg = MsgBox("Confirme a " + msgI, 36, "CONFIRMAÇÃO")
       If Msg = 6 Then   'Se a tecla acionado foi Sim
          'Inicia a Transação
          Workspaces(0).BeginTrans
          If Atualiza_mus = "Sim" Then
              wmusica.MoveFirst
              wmusica.Index = "primarykey"
              wmusica.Seek "=", cod_musica
              wmusica.Edit
              ' Retira da lista a musica anterior
              For I = 0 To LstMus_Mus.ListCount - 1
                  If LstMus_Mus.List(I) = LstMus_Mus Then
                     LstMus_Mus.RemoveItem I
                  Exit For
              End If
              Next
          Else
             'Pega o último código da tabela música e soma mais 1
             wmusica.MoveLast
             cod_musica = wmusica("cod_musica") + 1
             
             wmusica.AddNew
             wmusica("cod_musica") = cod_musica
             
             'Relacionamento Título-Música
             Wtmusica.AddNew
             Wtmusica("cod_titulo") = TxtCodT_Mus
             Wtmusica("cod_musica") = cod_musica

             'Relacionamento Música-Interprete
             Wminterprete.AddNew
             Wminterprete("cod_musica") = cod_musica
             Wminterprete("cod_interprete") = cdinterp_mus
             
          End If
          wmusica("titulo_musica") = TxtNom_Mus
          'Grava na tabela música
          wmusica.Update
          
          'Inclui no List a nova música
          LstMus_Mus.AddItem Format(cod_musica, "00000") + "  - " + TxtNom_Mus
          
          If Atualiza_mus <> "Sim" Then
             'Grava Relacionamento Música-Interprete
             Wminterprete.Update
             'Grava no banco o relacionamento Música Titulo-Música
             Wtmusica.Update
          End If
          gravou = "Sim"
       Else
          MsgBox "Operação Cancelada", 48, "AVISO"
          gravou = "Não"
          cod_musica = ""
       End If
       cod_musica = ""
       Atualiza_mus = "Não"
       msgI = "Inclusão"
       'Apaga o nome da música no text
       TxtNom_Mus = ""
       TxtNom_Mus.SetFocus
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

Private Sub SSCmdGrava_Tit_Click()
    On Error GoTo traterro
    If Atualiza <> "Sim" And gravou = "Sim" Then
       MsgBox "Este registro já existe, Impossível inclusão.", 16
       Exit Sub
    End If
    If TxtNom_Tit = "" Or cdgrupo_tit = "" Or cdestilo_tit = "" Or cdinterp_tit = "" Or MskQtde_Tit = "" Then
       MsgBox "Os Campos essenciais não podem ficar vazios", 48, "AVISO"
       TxtNom_Tit.SetFocus
       Exit Sub
    End If
    Msg = MsgBox("Confirme a " + msgI, 36, "CONFIRMAÇÃO")
    If Msg = 6 Then   'Se a tecla acionado foi Sim
       Workspaces(0).BeginTrans 'Inicia a transação
       'werro_bd = False
       If Atualiza = "Sim" Then
           Wtitulo.Edit
           wtinterprete.Edit 'Edita o relacionamento titulo-interprete
       Else
          Wtitulo.AddNew
          Wtitulo("cod_titulo") = TxtCod_Tit
          Wtitulo("qtde_disp") = MskQtde_Tit

          'Relacionamento titulo-Interprete
          wtinterprete.AddNew
          wtinterprete("cod_titulo") = TxtCod_Tit
       End If
       Wtitulo("titulo") = TxtNom_Tit
       Wtitulo("qtde_tot") = MskQtde_Tit
       Wtitulo("valor") = Val(TxtVal_Tit)
       Wtitulo("cod_estilo") = cdestilo_tit
       If SSOpt24_Tit = True Then
          Wtitulo("locacao") = "24"
       ElseIf SSOpt48_Tit = True Then
          Wtitulo("locacao") = "48"
       End If
       Wtitulo("cod_grupo") = cdgrupo_tit
       'Grava no banco
       Wtitulo.Update 'Grava no banco
        
       wtinterprete("cod_interprete") = cdinterp_tit
       wtinterprete.Update 'Grava o relacionamento titulo-interprete
       gravou = "Sim"
    Else
       MsgBox "Operação Cancelada", 48, "AVISO"
       gravou = "Não"
    End If
       
    'Chama a procedure
    limpa_titulo
    
    
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

Private Sub SSCmdImp_Cd_Click()
    MsgBox "Rotina não Implementada", 32
End Sub

Private Sub SSCmdImp_Mus_Click()
    MsgBox "Rotina não Implementada", 32
End Sub

Private Sub SSCmdImp_Tit_Click()
    MsgBox "Rotina não Implementada", 32
End Sub

Private Sub SSCmdLimp_Cd_Click()
    'Chama a Procedure
    limpa_cd
    TxtCodT_Cd.SetFocus
End Sub

Private Sub SSCmdLimp_Mus_Click()
    'Chama a Procedure Limpa música
    limpa_musica
    TxtCodT_Mus.SetFocus
End Sub

Private Sub SSCmdLimp_Tit_Click()
    'Chama a procedure que limpa os campos
    limpa_titulo
End Sub

Private Sub SSCmdSai_Mus_Click()
    Cds.Hide
End Sub

Private Sub SSCmdSai_Tit_Click()
  Cds.Hide
End Sub


Private Sub SSCmdSair_Cd_Click()
   Cds.Hide
End Sub

Private Sub SSTab1_GotFocus()
   If SSTab1.Tab = 0 Then
       Set VTb = Wtitulo
       VIx = "primarykey"
       VCt = "Cod_titulo"
       TxtCod_Tit = geracod()
       TxtCod_Tit = Format(TxtCod_Tit, "00000")
       TxtCod_Tit.SetFocus
    ElseIf SSTab1.Tab = 1 Then
       TxtCodT_Mus.SetFocus
    ElseIf SSTab1.Tab = 2 Then
       TxtCodT_Cd.SetFocus
    End If
End Sub


Private Sub TxtCod_Cd_KeyDown(KeyCode As Integer, Shift As Integer)
    If KeyCode = vbKeyF1 Then
       SSTab1.Tab = 0
       SSTab1_GotFocus
    ElseIf KeyCode = vbKeyF2 Then
       SSTab1.Tab = 1
       SSTab1_GotFocus
    End If
End Sub

Private Sub TxtCod_Cd_KeyPress(KeyAscii As Integer)
   On Error GoTo traterro
   If KeyAscii = 13 Then
      TxtCod_Cd = Format(TxtCod_Cd, ">")
      Wcdfisico.Index = "cod_cd"
      Wcdfisico.MoveFirst  ' Posiciona no inicio da tabela
      Wcdfisico.Seek "=", TxtCod_Cd
      If Not Wcdfisico.NoMatch Then
         Msg = "Este Código de CD já Existe, Deseja Vê-lo ?"   ' Define message.
         Style = vbYesNo + vbCritical + vbDefaultButton1 ' Define buttons.
         Title = "CD'S Loc - Atenção!!"  ' Define title.
         Help = "DEMO.HLP"   ' Define Help file.
         Ctxt = 1000 ' Define topic
                ' context.
                ' Display message.
         resposta = MsgBox(Msg, Style, Title, Help, Ctxt)
         If resposta = vbNo Then    ' User chose Yes.
            TxtCod_Cd.SetFocus
         Else
            TxtCodT_Cd = Format(Wcdfisico("cod_titulo"), "00000")
            Wtitulo.Index = "primarykey"
            Wtitulo.MoveFirst  ' Posiciona no inicio da tabela
            Wtitulo.Seek "=", TxtCodT_Cd.Text
            'Chama a procedure que preenche os dados.
            dados_tit3
            dados_cd
            msgI = "Alteração"
            Atualiza_cd = "Sim"
            SSOptAtivo_Cd.SetFocus
         End If
         Exit Sub
      End If
      MskDtaCp_Cd.SetFocus
   End If
   
traterro:
  Select Case Err.Number
    Case Is = 3201
        MsgBox "Falta Registro Relacionado na Tabela", vbCritical, _
        "CD'S Loc - Locadora de CD"
    Case Is <> 0 ' Else
        MsgBox "Erro Número => " & Err.Number & "  " & Err.Description, vbCritical, _
        "CD'S Loc - Locadora de CD"
        'Chama a Procedure Pública que trata o erro
       ' MsgErro
    Case Is = 0
    
  End Select
End Sub

Private Sub TxtCod_Cd_LostFocus()
  '  TxtCod_Cd = Format(TxtCod_Cd, ">")
  '  Wcdfisico.Index = "primarykey"
  '  Wcdfisico.MoveFirst  ' Posiciona no inicio da tabela
  '  Wcdfisico.Seek "=", TxtCodT_Cd, TxtCod_Cd
  '  If Not Wtitulo.NoMatch Then
  '     MsgBox "Este Código de CD já Existe, Tente Outro", 32
       'TxtCod_Cd.SetFocus
  '  End If
End Sub

Private Sub TxtCod_Tit_KeyDown(KeyCode As Integer, Shift As Integer)
    If KeyCode = vbKeyF2 Then
       SSTab1.Tab = 1
       SSTab1_GotFocus
    ElseIf KeyCode = vbKeyF3 Then
       SSTab1.Tab = 2
       SSTab1_GotFocus
    End If
End Sub

Private Sub TxtCod_Tit_KeyPress(KeyAscii As Integer)
   If KeyAscii = 13 Then
      TxtNom_Tit.SetFocus
   End If
End Sub

Private Sub TxtCod_Tit_LostFocus()
   On Error GoTo traterro
   
   If TxtCod_Tit <> "" Then
    
    If Not IsNumeric(TxtCod_Tit) Then
       MsgBox "Só é permitido o uso de Números", 64
       TxtCod_Tit.SetFocus
       Exit Sub
    End If
    
    gravou = "Não"
    
    Wtitulo.Index = "primarykey"
    Wtitulo.MoveFirst  ' Posiciona no inicio da tabela
    'Busca registro
     Wtitulo.Seek "=", TxtCod_Tit.Text
     
     If Wtitulo.NoMatch Then
        LimpaCampos
        msgI = "Inclusão"
        Atualiza = "Não"
        TxtNom_Tit.SetFocus
     Else
        'Chama a procedure que preenche os dados.
        dados_titulo
     End If
     
 End If
 
traterro:
    Select Case Err.Number
    Case Is = 3201
        MsgBox "Falta Registro Relacionado na Tabela", vbCritical, _
        "CD'S Loc - Locadora de CD"
    Case Is <> 0 ' Else
        MsgBox "Erro Número => " & Err.Number & "  " & Err.Description, vbCritical, _
        "CD'S Loc - Locadora de CD"
        'Chama a Procedure Pública que trata o erro
       ' MsgErro
    Case Is = 0
    
    End Select
 
End Sub

Private Sub TxtCodT_Cd_KeyDown(KeyCode As Integer, Shift As Integer)
    If KeyCode = vbKeyF1 Then
        SSTab1.Tab = 0
        SSTab1_GotFocus
     ElseIf KeyCode = vbKeyF2 Then
        SSTab1.Tab = 1
        SSTab1_GotFocus
     End If
End Sub

Private Sub TxtCodT_Cd_KeyPress(KeyAscii As Integer)
   If KeyAscii = 13 Then
      TxtNomT_Cd.SetFocus
   End If
End Sub

Private Sub TxtCodT_Cd_LostFocus()
   On Error GoTo traterro
   If TxtCodT_Cd <> "" Then
       TxtCodT_Cd = Format(TxtCodT_Cd, "00000")
       If Not IsNumeric(TxtCodT_Cd) Then
          MsgBox "Só é permitido o uso de Números", 64
          TxtCodT_Cd.SetFocus
          Exit Sub
       End If
       gravou = "Não"
       Wtitulo.Index = "primarykey"
       Wtitulo.MoveFirst  ' Posiciona no inicio da tabela
       'Busca registro
       Wtitulo.Seek "=", TxtCodT_Cd.Text
       If Wtitulo.NoMatch Then
          MsgBox "Não Existe Este Título, Tente Outro", vbInformation, "CD'S Loc - Sistema de Locação"
          With TxtCodT_Cd
             .SelStart = 0
             .SelLength = Len(.Text)
             .SetFocus
          End With
       Else
          msgI = "Inclusão"
          'Chama a procedure que preenche os dados.
          dados_tit3
       End If
    End If
    
traterro:
    Select Case Err.Number
    Case Is = 3201
        MsgBox "Falta Registro Relacionado na Tabela", vbCritical, _
        "CD'S Loc - Locadora de CD"
    Case Is <> 0 ' Else
        MsgBox "Erro Número => " & Err.Number & "  " & Err.Description, vbCritical, _
        "CD'S Loc - Locadora de CD"
        'Chama a Procedure Pública que trata o erro
       ' MsgErro
    Case Is = 0
    
    End Select
End Sub

Private Sub TxtCodT_Mus_KeyDown(KeyCode As Integer, Shift As Integer)
  If KeyCode = vbKeyF1 Then
     SSTab1.Tab = 0
     SSTab1_GotFocus
  ElseIf KeyCode = vbKeyF3 Then
     SSTab1.Tab = 2
     SSTab1_GotFocus
  End If
End Sub

Private Sub TxtCodT_Mus_KeyPress(KeyAscii As Integer)
   If KeyAscii = 13 Then
      TxtNomT_Mus.SetFocus
   End If
End Sub
Private Sub TxtCodT_Mus_LostFocus()
    On Error GoTo traterro
    If TxtCodT_Mus <> "" Then
       TxtCodT_Mus = Format(TxtCodT_Mus, "00000")
       If Not IsNumeric(Txtcod_Mus) Then
          MsgBox "Só é permitido o uso de Números", 64
          Txtcod_Mus.SetFocus
          Exit Sub
       End If
       gravou = "Não"
       Wtitulo.Index = "primarykey"
       Wtitulo.MoveFirst  ' Posiciona no inicio da tabela
       'Busca registro
       Wtitulo.Seek "=", TxtCodT_Mus.Text
       If Wtitulo.NoMatch Then
          MsgBox "Não Existe Este Título, Tente Outro", vbInformation, "CD'S Loc - Sistema de Locação"
          With TxtCodT_Mus
             .SelStart = 0
             .SelLength = Len(.Text)
             .SetFocus
          End With
       Else
          msgI = "Inclusão"
          'Chama a procedure que preenche os dados.
          dados_tit2
       End If
    End If
    
traterro:
    Select Case Err.Number
    Case Is = 3201
        MsgBox "Falta Registro Relacionado na Tabela", vbCritical, _
        "CD'S Loc - Locadora de CD"
    Case Is <> 0 ' Else
        MsgBox "Erro Número => " & Err.Number & "  " & Err.Description, vbCritical, _
        "CD'S Loc - Locadora de CD"
        'Chama a Procedure Pública que trata o erro
       ' MsgErro
    Case Is = 0
    
    End Select
End Sub

Private Sub TxtNom_Mus_KeyDown(KeyCode As Integer, Shift As Integer)
    If KeyCode = vbKeyF1 Then
       SSTab1.Tab = 0
       SSTab1_GotFocus
    ElseIf KeyCode = vbKeyF3 Then
       SSTab1.Tab = 2
       SSTab1_GotFocus
    End If
End Sub

Private Sub TxtNom_Mus_KeyPress(KeyAscii As Integer)
   If KeyAscii = 13 Then
      SSCmdGrava_Mus_Click
   End If
End Sub

Private Sub TxtNom_Tit_KeyDown(KeyCode As Integer, Shift As Integer)
    If KeyCode = vbKeyF2 Then
       SSTab1.Tab = 1
       SSTab1_GotFocus
    ElseIf KeyCode = vbKeyF3 Then
       SSTab1.Tab = 2
       SSTab1_GotFocus
    ElseIf KeyCode = vbKeyF10 Then
       pesq_titulo
       tit_tit = "Sim"
    End If
End Sub

Private Sub TxtNom_Tit_KeyPress(KeyAscii As Integer)
   If KeyCode <> vbKeyF10 Then
      If KeyAscii = 13 Then
         MskQtde_Tit.SetFocus
      End If
   End If
End Sub

Private Sub TxtNomT_Cd_KeyDown(KeyCode As Integer, Shift As Integer)
   If KeyCode = vbKeyF10 Then
       tit_cd = "Sim"
       pesq_titulo
    End If
End Sub

Private Sub TxtNomT_Cd_KeyPress(KeyAscii As Integer)
   If KeyCode <> vbKeyF10 Then
      If KeyAscii = 13 Then
         TxtCod_Cd.SetFocus
      End If
   End If
End Sub

Private Sub TxtNomT_Mus_KeyDown(KeyCode As Integer, Shift As Integer)
    If KeyCode = vbKeyF10 Then
       tit_mus = "Sim"
       pesq_titulo
    End If
End Sub
Private Sub TxtNomT_Mus_KeyPress(KeyAscii As Integer)
   If KeyCode <> vbKeyF10 Then
      If KeyAscii = 13 Then
         TxtNom_Mus.SetFocus
      End If
   End If
End Sub

Private Sub TxtVal_Cd_KeyDown(KeyCode As Integer, Shift As Integer)
    
    If KeyCode = vbKeyF1 Then
       SSTab1.Tab = 0
       SSTab1_GotFocus
    ElseIf KeyCode = vbKeyF2 Then
       SSTab1.Tab = 1
       SSTab1_GotFocus
    End If

End Sub

Private Sub TxtVal_Cd_KeyPress(KeyAscii As Integer)
   If KeyAscii = 13 Then
      SSCmdGrava_Cd_Click
   End If
End Sub

Private Sub TxtVal_Tit_KeyDown(KeyCode As Integer, Shift As Integer)
    If KeyCode = vbKeyF2 Then
       SSTab1.Tab = 1
       SSTab1_GotFocus
    ElseIf KeyCode = vbKeyF3 Then
       SSTab1.Tab = 2
       SSTab1_GotFocus
    End If
End Sub

Private Sub TxtVal_Tit_KeyPress(KeyAscii As Integer)
   If KeyAscii = 13 Then
      DBCGrp_Tit.SetFocus
   End If
End Sub

Private Sub TxtVal_Tit_LostFocus()
   TxtVal_Tit = Format(TxtVal_Tit, "0.00")
End Sub
