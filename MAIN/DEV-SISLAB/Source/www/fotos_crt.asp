<!--#include file="includes/Sislab_Lib.asp"-->
<!--#include file="includes/PadraoHTML.asp" -->
<!--#include file="includes/global.asp" -->
<!--#include file="includes/controleshtml.asp" -->
<head>
	<title>SISLAB</title>
	<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
	<meta http-equiv="refresh" content="<%=Application("SISLAB_Tempo_Troca_Imagens")%>">
	<link rel="stylesheet" href="estilos/principal.css" type="text/css">
</head>

<% 
'call ImprimeCabecalho2(TITULO_SITE, MENU_ON, true, "", "Cadastro de Arquivos - " & auxaltera & " " & auxlink, "", "")

Dim RS
Dim chr_SQL
Dim chr_URL
Dim chr_Link
Dim id_Arq

If VVVNZ(Session("SISLAB_id_Arquivo_Imagem")) Then
	chr_SQL = _
		"SELECT TOP 1 ARQ_CODARQ " & _
		"FROM Arquivos " & _
		"WHERE ARQ_CODARQTIPO = " & Application("SISLAB_id_TipoArquivo_Imagem")
	Call Env.RecordSet(True, RS, chr_SQL)
	If Not (RS.Eof And RS.Bof) Then
		Session("SISLAB_id_Arquivo_Imagem") = RS(0)
	Else
		Session("SISLAB_id_Arquivo_Imagem") = 0
	End If
Else
	chr_SQL = _
		"SELECT TOP 1 ARQ_CODARQ " & _
		"FROM Arquivos " & _
		"WHERE ARQ_CODARQTIPO = " & Application("SISLAB_id_TipoArquivo_Imagem") & " " & _
		"	AND ARQ_CODARQ > " & Session("SISLAB_id_Arquivo_Imagem") & " " & _
		"ORDER BY ARQ_CODARQ ASC"
	Call Env.RecordSet(True, RS, chr_SQL)
	If Not (RS.Eof And RS.Bof) Then
		Session("SISLAB_id_Arquivo_Imagem") = RS(0)
	Else
		Session("SISLAB_id_Arquivo_Imagem") = 0
		RR "fotos_crt.asp"
	End If
End If
Call Env.RecordSet(False, RS, chr_SQL)

chr_SQL = _
	"SELECT ARQ_NOMEARQ, ARQ_LINK, ARQ_CODARQ " & _
	"FROM Arquivos " & _
	"WHERE ARQ_CODARQ = " & Session("SISLAB_id_Arquivo_Imagem")
Call Env.RecordSet(True, RS, chr_SQL)
If Not (RS.Eof And RS.Bof) Then
	chr_URL = RS(0)
	chr_Link = RS(1)
	id_Arq = RS(2)
Else
	id_Arq = -1
End If
%>

<script language="JavaScript">
function abreJanela(id_arq)
{
	var w = window.open('fotos_exibe.asp?arq=' + id_arq, '', 'toolbar=no,location=no,directories=no,status=no,menubar=no,scrollbars=yes,resizable=yes,copyhistory=no,width=780,height=500,top=5,left=5');
//    window.open(link,'Noticias_Detalhe','toolbar=no,location=no,directories=no,status=no,menubar=yes,scrollbars=auto,resizable=no,copyhistory=no,width=800,height=600, top=0, left=0');
	w.focus();
}
</script>
<body leftmargin="0" topmargin="0">

<center>
<%
If id_Arq > 0 Then
%>
	<a href="#" onclick="javascript:abreJanela(<%=id_Arq%>);"><img border="0" width="128" height="115" title="<%=chr_Link%>" src="arquivos/<%=chr_URL%>"></a>
<%
Else
%>
	<span class="texto1">Nenhuma foto encontrada</span>
<%
End If
%>
</center>

<%
RE

'If Request("URL") <> "" And Request("Image") <> "" Then
	'Response.Redirect "Http://" & Request.ServerVariables("SERVER_NAME") & Application("SISLAB_PathRaiz") & Request("URL")
'	Response.Redirect Request("URL") & "?img=" & Request("Image")
%>
	<script language="JavaScript">
		//var w;
		//alert('Janela !!!');
		//w = window.open('Http://<%'=Request.ServerVariables("SERVER_NAME")%><%'=Application("SISLAB_PathRaiz")%><%=Request("URL")%>', 'FotoCRT', 'toolbar=no,location=no,directories=no,status=no,menubar=no,scrollbars=yes,resizable=no,copyhistory=no,width=460,height=300,top=5,left=5');
		//w.focus();
	</script>
<%
'Else
'	Dim adrotator
'	Set adrotator = Server.CreateObject("MSWC.AdRotator")
	'adrotator.Border = "2"
	'adrotator.TargetFrame = "target='_parent'"
'	adrotator.TargetFrame = "TARGET=fotos.asp"
%>
<!--
<center>
<%'=Response.Write(adrotator.GetAdvertisement("fotos_crt.txt"))%>


<img src="" alt="" width="128" height="115">

</center>
-->
<%
'	Set adrotator = Nothing
'End If
%>
</body>
</html>

