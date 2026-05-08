VERSION 5.00
Begin VB.Form frmPainel 
   BorderStyle     =   0  'None
   Caption         =   "Form1"
   ClientHeight    =   7185
   ClientLeft      =   0
   ClientTop       =   0
   ClientWidth     =   9615
   ControlBox      =   0   'False
   LinkTopic       =   "Form1"
   Picture         =   "frmPainel.frx":0000
   ScaleHeight     =   7185
   ScaleWidth      =   9615
   ShowInTaskbar   =   0   'False
   StartUpPosition =   3  'Windows Default
End
Attribute VB_Name = "frmPainel"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Private Sub Form_Load()
   'Posiciona o formulario proximo ao canto superior esquerdo da tela
   frmPainel.Left = (Screen.Width - frmPainel.Width) * 0.2
   frmPainel.Top = (Screen.Height - frmPainel.Height) * 0.3
End Sub
