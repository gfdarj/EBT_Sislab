<!--#include file="../global_SCE.asp" -->
<%
Dim perfil
perfil = CInt(Request("Perfil"))
%>
<html>
<head>
	<title></title>
	<link rel="stylesheet" href="menu.css">
</head>
<body>
<!-- Conhecendo o CRT -->
<table width="100%" height="100%"><%
if perfil = PERFIL_ADM or perfil = PERFIL_LOG then%>
<tr><td><a href="../../mov_acessorio.asp" target="_parent">Movimentação de Itens</a></td></tr>
<tr><td>---</td></tr><%
end if%>
<tr><td><a href="../../mov_passacarga.asp" target="_parent">Passagem de Carga</a></td></tr>
<tr><td><a href="../../mov_recebecarga.asp" target="_parent">Receber Carga</a></td></tr>
<%
if perfil = PERFIL_ADM then%>
<tr><td>---</td></tr>
<tr><td><a href="../../adm_depara_modelos.asp" target="_parent">De-Para de Modelos</a></td></tr><%
end if%>
</table>
</body>
</html>
