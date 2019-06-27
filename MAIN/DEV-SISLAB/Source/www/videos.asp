<!--#include file="includes/Sislab_Lib.asp"-->
<!--#include file="includes/PadraoHTML.asp" -->
<!--#include file="includes/global.asp" -->
<!--#include file="includes/bib_str.asp" -->
<%
Call Tela.ImprimeCabecalho2(TITULO_SITE, MENU_ON, true, "", "Vídeos do CRT", "", "")

Dim objFSO, objFolder, objFile
Dim chr_Path
Dim int_Conta
Dim chr_Buf
Dim chr_href

chr_Path = Server.MapPath("videos/")

Set objFSO = Server.CreateObject("Scripting.FileSystemObject")

Set objFolder = objFSO.GetFolder(chr_Path)

int_Conta = 0

chr_Buf = _
	"Selecione o vídeo desejado<br><br>" & VbCrLf & _
	"<table align='center' class='table-bordered table-condensed'>" & VbCrLf & _
	"<tr>" & VbCrLf & _
	"	<td><b>Arquivo</b></td><td><b>Tamanho</b><td>&nbsp;</td></td>" & VbCrLf & _
	"</tr>" & VbCrLf

For Each objFile in objFolder.Files
	int_Conta = int_Conta + 1

	If UCase(objFile.Name) <> "THUMBS.DB" Then
		chr_href = "videos/" & objFile.Name
		chr_Buf = chr_Buf & _
			"<tr><td><a href='" & chr_href & "'>" & objFile.Name & "</a></td><td align='right'>" & FormataNumero(int(objFile.Size/1024)) &" Kb</td><td><a href='" & chr_href & "'>" & VbCrLf & _
            "   <span class='glyphicon glyphicon-download-alt' title='Clique aqui para abrir o vídeo' style='color: darkblue;'></span>" & VbCrLf & _
            "</a></td></tr>" & VbCrLf
	End If
Next

chr_Buf = chr_Buf & "</table>" & VbCrLf

%>

<div class="margem-10">
    <% Response.write chr_Buf%>
</div>
<%
Call Tela.MostraRodape()
%>
