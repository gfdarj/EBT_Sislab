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
<body bgcolor="#FFFFFF" topmargin=0 leftmargin=0>


<%
Call MostraHeader 

'adicionar aqui verificacoes de seguranca / acesso
dim objRS, strSQL, objConn
dim objRS1, strSQL1
dim objRS2, strSQL2
dim objRS3, strSQL3
dim lges(), lges_id(), nlges
dim cpt_id, cpt_nome, tpc_id, tpc_nome, lee_id, lee_nome, lge_nome, lge_id, cpt_cod, auxcpt_id
dim vsw_atu, vsw_std, obs

if( isnumeric( cstr( request.querystring( "cpt_id" ) ) ) ) then
	cpt_id = request( "cpt_id" )
	strSQL = "select fac_componentes.cpt_nome, cpt_id, fac_componentes.tpc_id, fac_componentes.lee_id, vsw_std, vsw_atu, obs,fac_tipo_componente.tpc_nome, fac_locais_especificos_equip.lee_nome,fac_locais_genericos_equip.lge_nome,fac_locais_genericos_equip.lge_id, fac_componentes.cpt_cod_sgp_sce "
	strSQL = strSQL	&  "from fac_componentes inner join fac_tipo_componente on fac_componentes.tpc_id = fac_tipo_componente.tpc_id "
	strSQL = strSQL	&  "inner join ( fac_locais_especificos_equip inner join fac_locais_genericos_equip on fac_locais_especificos_equip.lge_id = fac_locais_genericos_equip.lge_id ) on fac_componentes.lee_id =fac_locais_especificos_equip.lee_id " 
if( cstr( cpt_id ) <> 0 ) then
	strSQL = strSQL	& " where fac_componentes.cpt_id = " & cpt_id
end if
	strSQL = strSQL	& " order by cpt_nome asc; " 

'	response.write( strSQL )
'	response.end
	call Env.RecordSet( true, objRS, strSQL)
	if( objRS.BOF and objRS.EOF ) then
		call ErroBD( "Identificador de componente inválido" )
	end if
end if

%>

<br>
<table width="600px" class="tipo1" align="center">
	<tr><td width="150px"></td><td></td><td></td></tr>
	<tr>
		<td colspan="3" bgcolor="#000030" align="right"><font face="tahoma" style="font-size=10pt" color="#FFFFFF">&nbsp;<B><a href="index.asp" class="Menu">Voltar</a></B>&nbsp;&nbsp;&nbsp;<br></font></td>
	</tr>

<%


while( not( objRS.EOF ) ) 

	auxcpt_id = objRS( "cpt_id" )

if( isnumeric( cstr( cpt_id ) ) ) then

	vsw_atu = objRS( "vsw_atu" )
	vsw_std = objRS( "vsw_std" )
	obs = objRS( "obs" )
	cpt_nome = objRS( "cpt_nome" )
	tpc_id = objRS( "tpc_id" )
	tpc_nome = objRS( "tpc_nome" )
	lee_id = objRS( "lee_id" )
	lee_nome = objRS( "lee_nome" )
	lge_nome = objRS( "lge_nome" )
	lge_id = objRS( "lge_id" )
	cpt_cod = objRS( "cpt_cod_sgp_sce" )
'	call RecordSet( false, objRS, null, null )
else
	cpt_nome = ""
	tpc_id = ""
	tpc_nome = ""
	lee_id = ""
	lee_nome = ""
	lge_nome = ""
	cpt_cod = ""
end if

%>

	<tr>
		<td class="titulo" colspan="3">
Componente: <%=cpt_nome%></td>
	</tr>

	<tr>
		<td><br>
<b><u>FICHA TÉCNICA DO COMPONENTE:</u></b><br><br>

&nbsp;&nbsp;<b>Componente:</b> <%= cpt_nome %> - <b>tipo(modelo):</b> <%= tpc_nome %></td>
	</tr>

	<tr>
		<td class="fonte3" >&nbsp;&nbsp;&nbsp;<b>Localização:</b> <%= lge_nome %> - <%= lee_nome %></td>
	</tr>

	<tr>
		<td  class="fonte3" >&nbsp;&nbsp;&nbsp;<b>versão de SW atual:</b> <%= vsw_atu %> &nbsp;&nbsp;&nbsp;<b>versão de SW padrão:</b><%= vsw_std %></td>
	</tr>

	<tr>
		<td  class="fonte3" >&nbsp;&nbsp;&nbsp;<b>Código SGP:</b> <%= cpt_cod %></td>
	</tr>

	<tr>
		<td  class="fonte3" >&nbsp;&nbsp;&nbsp;<b>Observação:</b> <%= obs %></td>
	</tr>

	<tr>
		<td  class="fonte3" >&nbsp;&nbsp;&nbsp;<b>Total de interfaces:</b><br>

<%

strSQL1 = "select qtd_int, tipo_interface, fac_componentes_interface.tipo_interface_id from fac_componentes_interface, fac_tipo_interface  where fac_tipo_interface.tipo_interface_id = fac_componentes_interface.tipo_interface_id "
	strSQL1 = strSQL1 & " and cpt_ID="&auxcpt_id& "; "
call Env.RecordSet( true, objRS1, strSQL1)

if Not( objRS1.BOF and objRS1.EOF ) then

while( not( objRS1.EOF ) ) %>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;	<%= objRS1( "tipo_interface" ) %> - qtd: <%= objRS1( "qtd_int" ) %><br>

<%
	objRS1.MoveNext
wend

call Env.RecordSet( false, objRS1, strSQL1)

end if
%>

</td></tr>


</table>

<table width="600px" class="tipo2" align="center">
	<tr><td width="550px">
<br>
<b><u>RECURSOS EM USO:</u></b>
<br><br>
<u>LÓGICO:</u>
<br>

<%
strSQL2 = "select * from fac_as_componente where Id_componente="&auxcpt_id& "; "
call Env.RecordSet( true, objRS2, strSQL2)

if Not( objRS2.BOF and objRS2.EOF ) then

while( not( objRS2.EOF ) ) %>
<br>
<div align=justify>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;	<b>AS Nº <%= objRS2( "AG_Numero" ) %> - </b><%= objRS2( "observacao" ) %></div><br>

<%
	objRS2.MoveNext
wend

call Env.RecordSet( false, objRS2, strSQL2)

end if
%>

<br><br>
<u>FÍSICO:</u>
<br>

<%

strSQL3 = "select * from vw_circuitos where cpt_id="&auxcpt_id& " order by cto_nome, fac_id ; "
call Env.RecordSet( true, objRS3, strSQL3 )

dim auxcircnome

auxcircnome=""

if Not( objRS3.BOF and objRS3.EOF ) then

while( not( objRS3.EOF ) )

if (auxcircnome<>objRS3( "CTO_NOME" )) then

auxcircnome=objRS3( "CTO_NOME" )
 %>
<br>

<div align=justify>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;	<b>Circuito <%= objRS3( "CTO_NOME" ) %> - TIPO: </b><%= objRS3( "tpc_nome" ) %></div><br>
<% end if %>


&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;	 <%= objRS3( "CAR_NOME" ) %> - <%= objRS3( "RCF_IDENTIFICADOR_CARACTERISTICA" ) %><br>

<%
	objRS3.MoveNext
wend

call Env.RecordSet( false, objRS3, strSQL3)

end if
%>


</td></tr>
</TABLE>



<%


	objRS.MoveNext
 

wend
call Env.RecordSet( false, objRS, strSQL)

'end if

call MostraFooter
%>