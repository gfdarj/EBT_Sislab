<!--#include file="includes/montatela.inc"-->
<!--#include file="includes/funcoesAux.inc"-->

<!--#include file="../includes/Sislab_Lib.asp"-->
<!--#include file="../includes/PadraoHTML.asp" -->
<!--#include file="../includes/global.asp" -->
<!--#include file="../includes/controlesHTML.asp" -->
<html>
<head>
	<title>Site do Centro de Referência Tecnológica</title>
	<meta http-equiv="Pragma" content="no-cache">
	<link rel="stylesheet" href="includes/style.css">
</head>
<body bgcolor="#FFFFFF" topmargin=0 leftmargin=0><% 

'Chamo a Barra da controladoria comum a todas as paginas

Call MostraHeader 

'adicionar aqui verificacoes de seguranca / acesso

dim objConn, objRS, strSQL

strSQL = "select lee_nome,cpt_id, cpt_nome, tpc_nome from fac_componentes inner join fac_tipo_componente on fac_componentes.tpc_id = fac_tipo_componente.tpc_id inner join fac_locais_especificos_equip on fac_componentes.lee_id = fac_locais_especificos_equip.lee_id order by tpc_nome"
call Env.RecordSet( true, objRS, strSQL)
if( objRS.BOF and objRS.EOF ) then
	response.redirect( "index.asp" )
end if %>
<br>
<table width="600px" class="tipo1" align="center">
	<tr><td width="150px"></td><td></td><td></td></tr>
	<tr>
		<td colspan="3" bgcolor="#000030" align="right"><font face="tahoma" style="font-size=10pt" color="#FFFFFF">&nbsp;<B><a href="index.asp" class="Menu">Voltar</a></B>&nbsp;&nbsp;&nbsp;<br></font></td>
	</tr>
	<tr>
		<td class="titulo" colspan="3">Componentes Cadastrados</td>
	</tr>
	<tr>
		<th>Componente</th>
		<th>Tipo Componente</th>
		<th>Localização</th>
	</tr>
<%
do while( not objRS.EOF ) %>

	<tr>
		<td>&nbsp;&nbsp;&nbsp;<a href="#"  class="fonte3" onclick="javascript:self.location.href='componente_sel.asp?cpt_id=<%= objRS( "cpt_id" ) %>'"><%= objRS( "cpt_nome" ) %></a></td>
		<td class="fonte3" >&nbsp;&nbsp;&nbsp;<%= objRS( "tpc_nome" ) %></td>
		<td  class="fonte3" >&nbsp;&nbsp;&nbsp;<%= objRS( "lee_nome" ) %></td>
	</tr><%
	objRS.MoveNext
loop %>
	<tr>
		<td colspan="3"><a href="#"  class="fonte3" onclick="javascript:self.location.href='componente_sel.asp?cpt_id=0'">listar todos os componentes cadastrados</a></td>
	</tr>
</table><%
call Env.RecordSet( false, objRS, strSQL)
call MostraFooter
%>