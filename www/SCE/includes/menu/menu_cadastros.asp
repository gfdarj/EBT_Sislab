<!--#include file="../global_SCE.asp" -->
<html>
<head>
	<title></title>
	<link rel="stylesheet" href="menu.css">
</head>
<body>
<!-- Cadastros -->
<table width="100%" height="100%">
<%
if session("status") = PERFIL_ADM or session("status") = PERFIL_LOG then%>
<tr><td><a href="../../cad_empresas.asp" target="_parent">Empresas</a></td></tr>
<tr><td><a href="../../cad_fab.asp" target="_parent">Fabricantes</a></td></tr>
<tr><td><a href="../../cad_no.asp" target="_parent">Natureza de Opera&ccedil;&atilde;o</a></td></tr>
<tr><td><a href="../../cad_nf.asp" target="_parent">Notas Fiscais</a></td></tr>
<tr><td><a href="../../cad_doc.asp" target="_parent">Documentos</a></td></tr>
<tr><td><a href="../../cad_tipos.asp" target="_parent">Fam&iacute;lia Tipo</a></td></tr>
<tr><td><a href="../../cad_areasutilizacao.asp" target="_parent">&Aacute;reas de Utiliza&ccedil;&atilde;o</a></td></tr>
<tr><td><a href="../../cad_modelos.asp" target="_parent">Modelos</a></td></tr>
<tr><td><a href="../../cad_acess_item.asp" target="_parent">Itens</a></td></tr><%
end if
if session("status") = PERFIL_ADM or session("status") = PERFIL_RAT then%>
<tr><td><a href="../../cad_reserva.asp" target="_parent">Reservas</a></td></tr><%
end if
if session("status") = PERFIL_ADM then%>
<tr><td><a href="../../cad_usu.asp" target="_parent">Usu&aacute;rios</a></td></tr><%
end if%>
</table>
</body>
</html>
