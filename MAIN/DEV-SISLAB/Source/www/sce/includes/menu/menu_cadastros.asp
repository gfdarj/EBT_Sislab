<!--#include file="../global_SCE.asp" -->
<%
Dim perfil
perfil = CInt(Request("Perfil"))
%>
<!DOCTYPE html>
<html>
    <head>
	    <title></title>
	    <link rel="stylesheet" href="menu.css">
        <meta charset="utf-8" />
    </head>
    <body>
<!-- Cadastros -->
        <table style="height: 100%; width: 100%;">
<%
If perfil = PERFIL_ADM Or perfil = PERFIL_LOG Then %>
            <tr><td><a href="../../cad_empresas.asp" target="_parent">Empresas</a></td></tr>
            <tr><td><a href="../../cad_fab.asp" target="_parent">Fabricantes</a></td></tr>
            <tr><td><a href="../../cad_no.asp" target="_parent">Natureza de Opera&ccedil;&atilde;o</a></td></tr>
            <tr><td><a href="../../cad_nf.asp" target="_parent">Notas Fiscais</a></td></tr>
            <tr><td><a href="../../cad_doc.asp" target="_parent">Documentos</a></td></tr>
            <tr><td><a href="../../cad_tipos.asp" target="_parent">Fam&iacute;lia Tipo</a></td></tr>
            <tr><td><a href="../../cad_areasutilizacao.asp" target="_parent">&Aacute;reas de Utiliza&ccedil;&atilde;o</a></td></tr>
            <tr><td><a href="../../cad_modelos.asp" target="_parent">Modelos</a></td></tr>
            <tr><td><a href="../../cad_acess_item.asp" target="_parent">Itens</a></td></tr><%
End If

If perfil = PERFIL_ADM Or perfil = PERFIL_RAT Then %>
            <tr><td><a href="../../cad_reserva.asp" target="_parent">Reservas</a></td></tr><%
End If
%>
        </table>
    </body>
</html>
