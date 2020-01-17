<!--#include file="includes/Sislab_Lib.asp"-->
<!--#include file="includes/PadraoHTML.asp" -->
<!--#include file="includes/global.asp" -->
<!--#include file="includes/bib_str.asp" -->
<%
Call ImprimeCabecalho2(TITULO_SITE, MENU_ON, true, "", "Vídeos do CRT", "", "")

'Dim objFSO, objFolder, objFile
'Dim chr_Path : chr_Path = Server.MapPath("videos/")
'Dim int_Conta
'Dim chr_Buf
'Dim chr_href

'Set objFSO = Server.CreateObject("Scripting.FileSystemObject")

'Set objFolder = objFSO.GetFolder(chr_Path)

'int_Conta = 0

'chr_Buf = _
'	"&nbsp;<span class='vermelho2'>&raquo;</span>&nbsp;<span class='texto1b' style='font-size: 12px;'>Selecione o video desejado</span><br><br>" & VbCrLf & _
'	"<table align='center' class='tabela1' border='1' cellpadding='3' cellspacing='0'>" & VbCrLf & _
'	"<tr>" & VbCrLf & _
'	"	<td><b>Arquivo</b></td><td><b>Tamanho</b><td>&nbsp;</td></td>" & VbCrLf & _
'	"</tr>" & VbCrLf

'For Each objFile in objFolder.Files
'	int_Conta = int_Conta + 1
'	chr_href = "videos/" & objFile.Name
'	chr_Buf = chr_Buf & _
'		"<tr><td><a href='" & chr_href & "'>" & objFile.Name & "</a></td><td align='right'>" & FormataNumero(int(objFile.Size/1024)) &" Kb</td><td><a href='" & chr_href & "'><img border='0' src='img/download.gif' title='Clique aqui para abrir o vídeo'></a></td></tr>" & VbCrLf
'Next

'chr_Buf = chr_Buf & "</table>" & VbCrLf

'Response.write chr_Buf
%>

<div style="margin-left: 10px;">
    <br>
    <p><span class='texto1b' style='font-size: 12px;'>Selecione o video desejado</span><br></p>
<%
    Dim rsSubMenu, s

    '-- Pega os dados de Configuracao da aplicacao SISLAB
    s = "SELECT ARQ_LINK, ARQ_NOMEARQ FROM ARQUIVOS WHERE ARQ_CODARQTIPO = " & Application("SISLAB_ID_CODARQTIPO_VIDEOS") & " AND ARQ_IDSITUACAO = " & Application("SISLAB_ID_SITUACAOARQUIVO_APROVADO") & " ORDER BY ARQ_LINK"
	call Env.RecordSet(true, rsSubMenu, s)
'    Set  = oConn.Execute(s)
    If rsSubMenu.Eof And rsSubMenu.Bof Then %>
    <p style="font-style: italic; font-size: 12px;">Nenhum arquivo de vídeo encontrado</p>
<%  Else %>
<%      While Not rsSubMenu.Eof %>
    <p style="font-size: 12px;"><a href="Arquivos/Videos/<%=rsSubMenu("ARQ_NOMEARQ")%>"><img border='0' src='img/download.gif' title='Clique aqui para abrir o vídeo'>&nbsp;<%=rsSubMenu("ARQ_LINK")%></a></p>
<%          rsSubMenu.MoveNext %>
<%      WEnd %>
<%  End If %>

</div>

<%
Call ImprimeRodape(RODAPE_OFF)
%>
