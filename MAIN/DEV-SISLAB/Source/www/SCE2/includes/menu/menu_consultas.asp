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
<!-- Cadastros -->
<table width="100%" height="100%">
<%
if perfil = PERFIL_ADM or perfil = PERFIL_LOG then%>
<tr><td><a href="../../sel_cad_empresa.asp" target="_parent">Empresas</a></td></tr>
<tr><td><a href="../../alt_fab.asp" target="_parent">Fabricantes</a></td></tr>
<tr><td><a href="../../sel_cad_no.asp" target="_parent">Natureza de Opera&ccedil;&atilde;o</a></td></tr>
<tr><td><a href="../../sel_cad_nf.asp" target="_parent">Notas Fiscais</a></td></tr>
<tr><td><a href="../../alt_doc.asp" target="_parent">Documentos</a></td></tr>
<tr><td><a href="../../sel_cad_tipo.asp" target="_parent">Fam&iacute;lia Tipo</a></td></tr>
<tr><td><a href="../../sel_cad_areautilizacao.asp" target="_parent">&Aacute;reas de Utiliza&ccedil;&atilde;o</a></td></tr>
<tr><td><a href="../../sel_cad_modelo.asp" target="_parent">Modelos</a></td></tr><%
end if%>
<tr><td><a href="../../sel_cad_acessorio.asp" target="_parent">Itens</a></td></tr>
<tr><td><a href="../../sel_cad_reserva.asp?abrir_como=CON" target="_parent">Reservas</a></td></tr>
</table>
</body>
</html>
