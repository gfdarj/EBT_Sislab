<%
'---------------------------------------------------------------------------------
'	Classe de gerenciamento dos arquivos
'
'	Obs: Necessário o include Geral_Lib.asp e Bib_Str.asp
'---------------------------------------------------------------------------------
Class TArquivo

Private bln_TemErro
Private chr_MsgErro
Private bln_OverWrite
Private chr_Folder
Private objUpload
Private int_ArquivosCarregados
Private chr_Obj
Private chr_FolderRaiz
Private chr_SubFolder
Private chr_PrefixoNomePasta
Public Arquivos

Private Sub Class_Initialize()
    int_ArquivosCarregados = 0
	bln_TemErro = False
	chr_MsgErro = ""
	bln_OverWrite = False
	chr_Obj = ""
	chr_Folder = Server.MapPath(".") & Application("SISLAB_FolderArquivos") & "\"
	chr_FolderRaiz = chr_Folder
	chr_SubFolder = ""
	chr_PrefixoNomePasta = "AS_"
End Sub

Private Sub Class_Terminate()
	Set objUpload = Nothing
End Sub

'-Property------------------------------------------------------------------------'

Public Property Get GetNomePasta
	GetNomePasta = chr_PrefixoPasta
End Property

Public Property Let SetNomePasta(chr_Nome)
	chr_PrefixoNomePasta = chr_Nome
End Property

Public Property Get ArquivosCarregados()
	ArquivosCarregados = int_ArquivosCarregados
End Property

Public Property Get GetPastaRaiz()
	GetPastaRaiz = chr_FolderRaiz
End Property

Public Property Let SetPastaRaiz(chr_Pasta)
	chr_Folder = Server.MapPath(".") & chr_Pasta & "\"
	chr_FolderRaiz = chr_Folder
	chr_SubFolder = ""
End Property

Public Property Get GetSubPasta()
	GetSubPasta = chr_SubFolder
End Property

Public Property Let SetSubPasta(chr_Pasta)
	chr_SubFolder = chr_Pasta
End Property

Public Property Let SetOverwrite(bln_Ow)
	bln_OverWrite = bln_Ow
End Property

Public Property Get TemErro()
	TemErro = bln_TemErro
End Property

Public Property Get MensagemErro()
    MensagemErro = chr_MsgErro
End Property

Public Property Get Arquivo(int_Indice)
	Dim int_Erro

	On Error Resume Next
	Arquivo = objUpload.Files(int_Indice).ExtractFileName
	int_Erro = Err.Number
	On Error Goto 0
	If int_Erro <> 0 Then bln_TemErro = True
End Property

Public Property Get ArquivoSubPasta(int_Indice)
	ArquivoSubPasta = Replace(Replace(IIf(VVVN(chr_SubFolder), "", chr_SubFolder & "\") &  objUpload.Files(int_Indice).ExtractFileName, "\\", "\"), "//", "/")
End Property

Public Property Get TotalArquivos
	TotalArquivos = int_ArquivosCarregados
End Property

Public Property Get GetOverwrite()
	GetOverwrite = bln_OverWrite
End Property

'-Metodos------------------------------------------------------------------------'

Public Sub Init_FS()	'Objeto File System
	chr_Obj = "FS"

	On Error Resume Next
	Set objUpload = Server.CreateObject("Scripting.FileSystemObject")

	If Err.Number <> 0 Then bln_TemErro = True
	On Error Goto 0
End Sub

Public Sub Init_UP()	'Objeto Persists Upload
	chr_Obj = "UP"

	On Error Resume Next
	Set objUpload = Server.CreateObject("Persits.Upload.1")

	objUpload.OverwriteFiles = bln_OverWrite

    	' Limita o tamanho máximo do arquivo em 100MB 
    	objUpload.SetMaxSize 104857600, True

	If Err.Number <> 0 Then
	    bln_TemErro = True
		chr_MsgErro = Err.Description
	End If
	On Error Goto 0
End Sub

Public Function Campo(chr_Nome)
	If chr_Obj = "UP" Then
		Campo = objUpload.Form(chr_Nome)
	Else
		Campo = ""
	End If
End Function

'
'	Carrega os arquivos, salvando para a memoria
'
Public Sub Upload()
	If chr_Obj = "UP" Then
		On Error Resume Next
		int_ArquivosCarregados = objUpload.SaveToMemory()
        If VVVNZ(int_ArquivosCarregados) Then
            int_ArquivosCarregados = 0
        End If
'RW server.mappath(".")& "\Arquivos\"
'RE
		'int_ArquivosCarregados = objUpload.Save
		'int_ArquivosCarregados = objUpload.Save(Server.MapPath(".") & "\Arquivos")
		If Err.Number <> 0 Then
		    bln_TemErro = True
		    chr_MsgErro = Err.Description
		End If
		Set Arquivos = objUpload.Files
		On Error Goto 0
	End If
End Sub

'
'	Salva os arquivos da memoria para o disco
'
Public Sub Salva(chr_AS)
	Dim objFS
	Dim chr_Salvar

	If chr_Obj = "UP" Then

		If int_ArquivosCarregados > 0 Then
			'Se existir AS entao verifico a pasta com o nome da mesma
			If Not VVVNZ(chr_AS) Then

				'	Coloca um limite para que a partir de um numero de AS / LB comece
				'	a valer o novo esquema
				'
				'	Teoricamente esta funcionalidade e temporária
				chr_SubFolder = ""
				If chr_PrefixoNomePasta = "AS_" Then
					'If CInt(chr_AS) > 1958 Then
					'If CInt(chr_AS) > 2746 Then
						chr_SubFolder = chr_PrefixoNomePasta & Zeros(chr_AS, 5) & "\"
					'End If
				Else
					'If CInt(chr_AS) > 746 Then
					If CInt(chr_AS) > 786 Then
						chr_SubFolder = chr_PrefixoNomePasta & Zeros(chr_AS, 5) & "\"
					End If
				End If

				chr_Folder = chr_Folder & chr_SubFolder

				'	Verifica se a pasta com o numero da AS existe
'				On Error Resume Next
				Set objFS = Server.CreateObject("Scripting.FileSystemObject")
				If Err.Number <> 0 Then bln_TemErro = True
'				On Error Goto 0

				If Not bln_TemErro Then
					If Not objFS.FolderExists(chr_Folder) Then
						Call objFS.CreateFolder(chr_Folder)
					End If
				End If

				Set objFS = Nothing

            ' Se houver um prefixo de pasta sem correlação com um Agendamento
            ElseIf chr_PrefixoNomePasta <> "AS_" And chr_PrefixoNomePasta <> "" Then

				chr_Folder = chr_Folder & chr_PrefixoNomePasta & "\"

				'	Verifica se a pasta existe
'				On Error Resume Next
				Set objFS = Server.CreateObject("Scripting.FileSystemObject")
				If Err.Number <> 0 Then bln_TemErro = True
'				On Error Goto 0

				If Not bln_TemErro Then
					If Not objFS.FolderExists(chr_Folder) Then
						Call objFS.CreateFolder(chr_Folder)
					End If
				End If

				Set objFS = Nothing
			End If


			'	Salva os arquivos
			If Not bln_TemErro Then
				'For Each File In objUpload.Files
				'	File.SaveAs chr_Folder & File.FileName
				'Next
				For i=1 To int_ArquivosCarregados
					Set File = objUpload.Files(i)
					chr_Salvar = chr_Folder & File.ExtractFileName
'					chr_Salvar = Server.MapPath(".") & "\" & File.ExtractFileName
					'rw chr_Salvar
					'rw "<BR><BR>" & Server.MapPath(".")
'					response.end
					File.SaveAs chr_Salvar
				Next
			End If

		End If

	End If
End Sub

Public Sub Exclui(chr_Arquivo)
	If chr_Obj = "UP" Then
		On Error Resume Next
'rw "<BR><BR><b>chr_Folder & chr_Arquivo: " & chr_Folder & chr_Arquivo
		objUpload.DeleteFile( chr_Folder & chr_Arquivo )
		If Err.Number <> 0 Then bln_TemErro = True
		On Error Goto 0
	Else
		On Error Resume Next
		objUpload.DeleteFile( chr_Folder & chr_Arquivo )
		If Err.Number <> 0 Then bln_TemErro = True
		On Error Goto 0
	End If
End Sub

Public Sub Mover(chr_ArquivoOrigem, chr_ArquivoDestino)
	If chr_Obj = "UP" Then
		'On Error Resume Next
		'If Err.Number <> 0 Then bln_TemErro = True
		'On Error Goto 0
	Else
		On Error Resume Next
		objUpload.Movefile chr_ArquivoOrigem, chr_ArquivoDestino
		If Err.Number <> 0 Then bln_TemErro = True
		On Error Goto 0
	End If
End Sub

Public Function ExistePasta(chr_Pasta)
	If chr_Obj = "UP" Then
		ExistePasta = False
	Else
		ExistePasta = objUpload.FolderExists(chr_Pasta)
	End If
End Function

Public Function ExisteArquivo(chr_Arquivo)
	If chr_Obj = "UP" Then
		ExisteArquivo = False
	Else
		ExisteArquivo = objUpload.FileExists(chr_Arquivo)
	End If
End Function

Public Sub NovaPasta(chr_Pasta)
	If chr_Obj = "UP" Then
		'---
	Else
		On Error Resume Next
		Call objUpload.CreateFolder(chr_Pasta)
		If Err.Number <> 0 Then
		    bln_TemErro = True
		    chr_MsgErro = Err.Description
		End If
		On Error Goto 0
	End If
End Sub

Public Function ExtraiNomeArquivo(chr_Arquivo)
	Dim obj

	On Error Resume Next
	Set obj = Server.CreateObject("Scripting.FileSystemObject")

	If Err.Number <> 0 Then bln_TemErro = True
	On Error Goto 0

	Set obj = Nothing
End Function

End Class
%>