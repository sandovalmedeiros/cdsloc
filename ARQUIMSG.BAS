Attribute VB_Name = "ARQUIMSG"
Sub ARQUIMSG(NomeArq$, Secao%)
    'Determina o caminho para o arquivo de mensagens
    MsgArq$ = App.Path + "\" + NomeArq$
    
    'Certifica-se de que o arquivo existe
    Arq$ = Dir$(MsgArq$)
    If Arq$ = "" Then
        Msg$ = "Arquivo " + MsgArq$ + " nao encontrado"
        MsgBox Msg$, 48, "ARQUIMSG"
        Exit Sub
    End If
    
    'Cria string de nova linha
    NL$ = Chr$(13) + Chr$(10)
    
    'Abre o arquivo de mensagem para leitura
    NumArq% = FreeFile
    Open MsgArq$ For Input As #NumArq%
    
    'Localiza secao especifica
    Do Until EOF(NumArq%)
        Line Input #NumArq%, ArqTxt$
            If Left$(ArqTxt$, 1) = ">" Then
            If Val(Mid$(ArqTxt$, 2)) = Secao Then
                Exit Do
            End If
        End If
    Loop
    
    'Chegamos ao fim do arquivo durante a procura?
    If EOF(NumArq%) Then
        Msg$ = "Secao de mensagem" + Str$(Secao) + " nao encontrada"
        MsgBox Msg$
        Exit Sub
    End If
    
    'Extrai a o tipo e titulo da caixa de mensagem
    ArqTxt$ = RTrim$(LTrim$(Mid$(ArqTxt$, 2)))
    ArqTxt$ = Mid$(ArqTxt$, InStr(ArqTxt$, ",") + 1)
    TipoNum% = Val(ArqTxt$)
    Titulo$ = LTrim$(Mid$(ArqTxt$, InStr(ArqTxt$, ",") + 1))
    
    'Percorre em um laco todas as secoes do bloco
    Do
    
        'Limpa a string de mensagem
        Msg$ = ""
    
        'Le a secao de mensagem
        Do Until EOF(NumArq%)
            Line Input #NumArq%, ArqTxt$
            If Left$(ArqTxt$, 1) = ">" Then
                Exit Do
            End If
            Msg$ = Msg$ + ArqTxt$ + NL$
        Loop
    
        'Remove as linhas em branco finais
        Do While Right$(Msg$, 4) = NL$ + NL$
            Msg$ = Left$(Msg$, Len(Msg$) - 2)
        Loop
    
        'Exibe o bloco de mensagem
        If Msg$ <> "" Then
            MsgBox Msg$, TipoNum%, Titulo$
        End If
                            
    'Continua o bloco se > estava sozinho
    Loop While LTrim$(RTrim$(ArqTxt$)) = ">"
    
    'Terminamos com o arquivo
    Close NumArq%
End Sub

