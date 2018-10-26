<!--#include file="../includes/Sislab_Lib.asp"-->
<!--#include file="../includes/PadraoHTML.asp" -->
<!--#include file="../includes/global.asp" -->
<!--#include file="../includes/controlesHTML.asp" -->

<%
Response.Addheader "Expires","Mon, 26 Jul 1997 05:00:00 GMT"
Response.Addheader "Cache-Control","no-cache, must-revalidate"
Response.Addheader "Pragma","no-cache"
Dim objRS, objConn, s, i %>
<html>
<head>
	<title>Defini&ccedil;&atilde;o de <%=request.querystring("car_nome")%></title>
	<meta http-equiv="Pragma" content="no-cache">
	<link rel="stylesheet" href="includes/style.css">
</head>
<body topmargin=0 leftmargin=0 scroll="no">
<table width="100%" height="100%">
<tr>
<td valign="top" class="trcadtit1" border="1">
<div style="width: 100%; height: 160; overflow-y: Auto;" ><font class="Fonttit3Cad">
<%
i = Request.querystring("car_id")
if i = "" then i = 0
s = "select CAR_DEFINICAO from FAC_Caracteristicas where CAR_ID = " & i
call Env.RecordSet(true, objRS, s)
if objRS.EOF and objRS.BOF then%>
	DEFINI&Ccedil;&Atilde;o n&Atilde;o encontrada.<%
else
	Response.Write Replace(objRS("CAR_DEFINICAO"), VbCrLf, "<br>")
end if
call Env.RecordSet(false, objRS, null)
%></font></div>
</td>
</tr>
<tr height="30" class="trcadtit1">
	<td align="center"><input type="button" name="btnCancela" value="Fechar" class="botao1" onclick="javascript:window.close();"></td>
</tr>
</table>