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
'if session("status") = PERFIL_ADM or session("status") = PERFIL_LOG then%>
<tr><td><a href="../../rel_instrumental.asp" target="_parent">Controle de Instrumentais</a></td></tr>
<%
if session("status") = PERFIL_ADM then%>
<tr><td><a href="../../rel_consolidado_total_nf.asp" target="_parent">Consolidado - Total por Nota Fiscal</a></td></tr>
<tr><td><a href="../../rel_consolidado_mov.asp" target="_parent">Consolidado - Movimentações</a></td></tr>
<tr><td><a href="../../rel_consolidado.asp" target="_parent">Consolidado - Posi&ccedil;&atilde;o do Estoque</a></td></tr><%
end if

if session("status") = PERFIL_ADM Or session("status") = PERFIL_LOG then%>
<tr><td><a href="../../rel_consolidado_doc.asp" target="_parent">Consolidado - Documentos Gerados</a></td></tr><%
end if
%>
<tr><td><a href="../../imp_emp.asp" target="_parent">Empresas</a></td></tr>
<tr><td><a href="../../rel_equipamento.asp" target="_parent">Equipamentos</a></td></tr>
<tr><td><a href="../../rel_nf.asp" target="_parent">Notas Fiscais</a></td></tr>
<%
'if session("status") = PERFIL_ADM or session("status") = PERFIL_LOG then%>
<tr><td><a href="../../log.asp" target="_parent">Hist&oacute;rico Geral</a></td></tr><%
'end if
if session("status") = PERFIL_ADM or session("status") = PERFIL_RAT then%>
<tr><td><a href="../../sel_cad_reserva.asp?abrir_como=REL" target="_parent">Reservas</a></td></tr><%
end if
'if session("status") = PERFIL_ADM or session("status") = PERFIL_LOG then%>
<tr><td><a href="../../rel_pas.asp" target="_parent">Passagem de Cargas</a></td></tr>
<tr><td><a href="../../rel_con.asp" target="_parent">Movimenta&ccedil;&atilde;o de Consum&iacute;veis</a></td></tr>
<tr><td><a href="../../rel_mov.asp" target="_parent">Movimenta&ccedil;&atilde;o de Itens</a></td></tr><%
'end if%>
<%
if session("status") = PERFIL_ADM or session("status") = PERFIL_LOG then%>
<tr><td>---</td></tr>
<tr><td><a href="../../rel_termoresp.asp" target="_parent"><b>Termo de Responsabilidade</b></a></td></tr><%
end if%>

</table>
</body>
</html>
