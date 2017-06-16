<!--#include file="../global_SCE.asp" -->
<html>
<head>
	<title></title>
	<link rel="stylesheet" href="menu.css">
</head>
<body>
<!-- Conhecendo o CRT -->
<table width="100%" height="100%"><%
if session("status") = PERFIL_ADM or session("status") = PERFIL_LOG then%>
<tr><td><a href="../../mov_acessorio.asp" target="_parent">Movimentação de Itens</a></td></tr>
<tr><td><a href="../../sel_mov_consumivel.asp" target="_parent">Movimentação de Consum&iacute;veis</a></td></tr>
<tr><td>---</td></tr><%
end if%>
<tr><td><a href="../../mov_passacarga.asp" target="_parent">Passagem de Carga</a></td></tr>
<tr><td><a href="../../mov_recebecarga.asp" target="_parent">Receber Carga</a></td></tr>
<%
if session("status") = PERFIL_ADM then%>
<tr><td>---</td></tr>
<tr><td><a href="../../adm_depara_modelos.asp" target="_parent">De-Para de Modelos</a></td></tr><%
end if%>
</table>
</body>
</html>
