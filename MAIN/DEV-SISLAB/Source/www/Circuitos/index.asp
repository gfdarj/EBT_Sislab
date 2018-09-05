<!--#include file="../includes/PadraoHTML.asp" -->
<!--#include file="../includes/EmailHTML.asp" -->
<!--#include file="../includes/global.asp" -->
<!--#include file="../includes/Sislab_Lib.asp"-->
<%
Response.Addheader "Expires","Mon, 26 Jul 1997 05:00:00 GMT"
Response.Addheader "Cache-Control","no-cache, must-revalidate"
Response.Addheader "Pragma","no-cache"
%>
<html>
<head>
	<title>Site do Centro de Referência Tecnológica</title>
	<meta http-equiv="Pragma" content="no-cache">
	<link rel="stylesheet" href="includes/style.css">
</head>
<body bgcolor="#FFFFFF" topmargin=0 leftmargin=0 scroll="auto">
<% 
'Call MostraHeader
call imprimeCabecalho2(TITULO_SITE, MENU_ON, true, "", "Sistema de Gestão de Facilidades", "location.href='../sislab.asp'", "../")
%>
<br>
<form name="formulario">
<table width="650" class="trcadtit1" border="1" align="center">
<tr> 
	<td width="40%"></td>
	<td width="60%"></td>
</tr>
<tr>
  <td colspan="2" bgcolor="#000030" align="right"><font face="tahoma" style="font-size=10pt" color="#FFFFFF">&nbsp;<B><a href="../index.asp" class="Menu">Voltar</a></B>&nbsp;&nbsp;&nbsp;<br></font></td>
</tr>

<tr valign="middle" class="trcadtit2"> 
  <td colspan="2" align="left"><font  class="fonttit1cad"><b>&nbsp;&nbsp;&nbsp;Sistema de Gestão de Facilidades - CRT</b></font></td>
</tr>
<tr>
	<td colspan="2" align="center">
		<br>
		<input type="button" value="Cadastrar Componente (Elemento)" class="botaoMenu" onclick="javascript:location.href='componentes.asp';"><br>
		<input type="button" value="Editar Componente (Elemento)" class="botaoMenu" onclick="javascript:location.href='lista_compos.asp';"><br>
<input type="button" value="Consultar Componente (Elemento)" class="botaoMenu" onclick="javascript:location.href='lista_componentes.asp';"><br>
		<input type="button" value="Cadastrar/Editar Tipo de Componente (Modelo)" class="botaoMenu" onclick="javascript:location.href='sel_tipocomponentes.asp';"><br>
		<input type="button" value="Locais Genéricos" class="botaoMenu" onclick="javascript:location.href='sel_localgenerico.asp';"><br>
		<input type="button" value="Circuitos" class="botaoMenu" onclick="javascript:location.href='circuitos.asp';"><br>
		<br>
	</td>
</tr>

</table>
</form>
<%
'Call MostraFooter
call ImprimeRodape(RODAPE_OFF)
%>
