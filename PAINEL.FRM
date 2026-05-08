VERSION 5.00
Begin VB.Form Painel 
   Appearance      =   0  'Flat
   BackColor       =   &H80000005&
   BorderStyle     =   0  'None
   Caption         =   "Painel"
   ClientHeight    =   6600
   ClientLeft      =   780
   ClientTop       =   1785
   ClientWidth     =   9450
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
   LinkTopic       =   "Form1"
   PaletteMode     =   1  'UseZOrder
   Picture         =   "PAINEL.frx":0000
   ScaleHeight     =   6600
   ScaleWidth      =   9450
End
Attribute VB_Name = "Painel"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Private Sub Form_Load()
    'Posiciona o formulario proximo ao canto superior esquerdo da tela
   Painel.Left = (Screen.Width - Painel.Width) * 0.2
   Painel.Top = (Screen.Height - Painel.Height) * 0.3
End Sub
