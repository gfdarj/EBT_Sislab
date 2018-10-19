<!--#include file="includes/Sislab_Lib.asp"-->
<!--#include file="includes/PadraoHTML.asp" -->
<!--#include file="includes/global.asp" -->
<!--#include file="includes/bib_str.asp" -->
<%
call imprimeCabecalho2(TITULO_SITE, MENU_ON, true, "", "Vídeos do CRT", "", "")

Dim objFSO, objFolder, objFile
Dim chr_Path : chr_Path = Server.MapPath("videos/")
Dim int_Conta
Dim chr_Buf
Dim chr_href

Set objFSO = Server.CreateObject("Scripting.FileSystemObject")

Set objFolder = objFSO.GetFolder(chr_Path)

int_Conta = 0

chr_Buf = _
	"&nbsp;<span class='vermelho2'>&raquo;</span>&nbsp;<span class='texto1b' style='font-size: 12px;'>Selecione o vídeo desejado</span><br><br>" & VbCrLf & _
	"<table align='center' class='tabela1' border='1' cellpadding='3' cellspacing='0'>" & VbCrLf & _
	"<tr>" & VbCrLf & _
	"	<td><b>Arquivo</b></td><td><b>Tamanho</b><td>&nbsp;</td></td>" & VbCrLf & _
	"</tr>" & VbCrLf

For Each objFile in objFolder.Files
	int_Conta = int_Conta + 1

	If UCase(objFile.Name) <> "THUMBS.DB" Then
		chr_href = "videos/" & objFile.Name
		chr_Buf = chr_Buf & _
			"<tr><td><a href='" & chr_href & "'>" & objFile.Name & "</a></td><td align='right'>" & FormataNumero(int(objFile.Size/1024)) &" Kb</td><td><a href='" & chr_href & "'><img border='0' src='img/download.gif' title='Clique aqui para abrir o vídeo'></a></td></tr>" & VbCrLf
	End If
Next

chr_Buf = chr_Buf & "</table>" & VbCrLf

Response.write chr_Buf

call imprimeRodape(RODAPE_OFF)
%>
