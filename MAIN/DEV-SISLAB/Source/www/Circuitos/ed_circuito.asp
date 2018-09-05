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

if( not( isnumeric( cstr( request.querystring( "cto_id" ) ) ) ) ) then
	response.redirect( "circuitos.asp" )
end if

strSQL = "select cto_nome, tpc_nome, cto_permanente, cto_ativado from fac_circuito inner join fac_tipo_circuito on fac_circuito.tpc_id = fac_tipo_circuito.tpc_id where cto_id = " & request.querystring( "cto_id" )
call Env.RecordSet( true, objRS, strSQL)
if( objRS.BOF and objRS.EOF ) then
	call ErroBD( "Nao foi possivel encontrar o circuito especificado (" & cstr( request.querystring( "cto_id" ) ) & ")" )
end if %>
<br>
<script language="JavaScript1.2">
function ad_fac( pos )
{
	document.all.d_nova_fac.style.display = "block";
	document.dados_fac.pos_nova_fac.value = pos.toString();
}

function remove_fac( fac_id )
{
	self.location.href = "remove_fac.asp?fac_id=" + fac_id + "&cto_id=<%= request.querystring( "cto_id" ) %>";
}
</script>
<table class="tipo1" align="center" width="600px">
	<tr>
		<td bgcolor="#000030" align="right"><font face="tahoma" style="font-size=10pt" color="#FFFFFF">&nbsp;<B><a href="index.asp" class="Menu">Voltar</a></B>&nbsp;&nbsp;&nbsp;<br></font></td>
	</tr>
	<tr>
		<td class="titulo"><%= objRS( "cto_nome" ) %></td>
	</tr>
	<tr>
		<td>
			<table class="tipo1" width="100%">
				<tr>
					<th width="10%">Tipo:</th>
					<td align="left"><%= objRS( "tpc_nome" ) %></td>
					<td rowspan="3"><button onclick="javascript:window.open( 'det_circuito.asp?cto_id=<%= request.querystring( "cto_id" ) %>', 'det_circuito', 'scrollbars=no, status=no, height=250, width=600' );">Alterar</button></td>
				</tr>
				<tr>
					<th>Status:</th>
					<td align="left">Este circuito se encontra <%
if( objRS( "cto_ativado" ) ) then %><span class="circ_ativ">ativado</span><%
else %><span class="circ_desat">desativado</span><%
end if 			  %></td>
				</tr><%
if( not( isNull( objRS( "cto_permanente" ) ) ) ) then
	if( objRS( "cto_permanente" ) ) then %>
				<tr>
					<th colspan="2">Este &eacute; um circuito permanente</th>
				</tr><%
	end if
end if %>
			</table>
		</td>
	</tr>
	<tr>
		<td>
			<table align="center" class="tipo1">
<%
call Env.RecordSet( false, objRS, strSQL)

strSQL = "select cpt_nome, tipo_interface, rcf_identificador_caracteristica, car_nome, fac_ordem, fac_facilidades.fac_id from fac_facilidades " _
		& "inner join fac_componentes on fac_facilidades.cpt_id = fac_componentes.cpt_id " _
		& "left join fac_rel_caracteristicas_facilidades on fac_facilidades.fac_id = fac_rel_caracteristicas_facilidades.fac_id " _
		& "left join fac_caracteristicas on fac_rel_caracteristicas_facilidades.car_id = fac_caracteristicas.car_id " _
		& "left join fac_tipo_interface on fac_facilidades.Tipo_interface_id = fac_Tipo_interface.Tipo_interface_id " _
		& "where fac_facilidades.cto_id = " & request.querystring( "cto_id" ) _
		& " order by fac_facilidades.fac_ordem"
'response.write strSQL
call Env.RecordSet( true, objRS, strSQl)
dim pos_atual, fac_id
pos_atual = -1
if( objRS.BOF and objRS.EOF ) then %>
			<tr>
				<td align="center">
					N&atilde;o existem facilidades cadastradas!<br />
					Pressione aqui para adicionar uma facilidade:
				</td>
			</tr>
			<tr><%
else %>
			<tr><%
	while( not( objRS.EOF ) )
		pos_atual = cint( objRS( "fac_ordem" ) )
		fac_id = cint( objRS( "fac_id" ) ) %>
				<td>
					<button onclick="javascript:ad_fac( <%= pos_atual %> );">+</button>
				</td>
				<td>
					<table class="tipo1" border="1">
						<tr><td></td><td></td></tr>
						<tr><td colspan="2" class="titulo"><%= objRS( "cpt_nome" ) %></th></tr>

<tr><th colspan=2><font style="font-size=7pt;"><%= objRS("tipo_interface") %>&nbsp;</font></th></tr>

<%
		do while( cint( objRS( "fac_ordem" ) ) = pos_atual ) %>
						<tr><th><%= objRS( "car_nome" ) %></th><td><%= objRS( "rcf_identificador_caracteristica" ) %></td></tr><%
			objRS.MoveNext
			if( objRS.EOF ) then exit do
		loop %>
						<tr><td align="center" colspan="2"><button onclick="javascript:remove_fac( <%= fac_id %> );">-</button></td></tr>
					</table>
				</td><%
	wend
end if %>
				<td align="center">
					<button onclick="javascript:ad_fac( <%= pos_atual + 1 %> );">+</button>
				</td>
			</tr><%
call Env.RecordSet( false, objRS, strSQl)
%>
			</table>
		</td>
	</tr>
</table>
<div align="center" id="d_nova_fac" style="display:none">
<script language="JavaScript1.2">
function busca_cars( sel )
{
	if( sel[ sel.selectedIndex ].value != "" )
	{
		document.nova_fac.action = "busca_caracs.asp?cpt_id=" + sel[ sel.selectedIndex ].value;
		document.nova_fac.submit();
		document.dados_fac.bt_at.disabled = false;
	}
	else
	{
		limpa_caracs();
		window.parent.document.all.d_carac.style.display = "none";
		document.dados_fac.bt_at.disabled = true;
	}
}

function limpa_caracs()
{
	document.all.td_caracs.innerHTML = "";
}

function ad_carac( texto, nome )
{
	document.all.td_caracs.innerHTML += texto + ':&nbsp;<input type="Text" title="' + texto + '" name="' + nome + '" size="5" maxlength="255" /><br />';
}

function verifica_carac()
{
	var i;
	for( i = 0; i < document.dados_fac.elements.length; i++ )
	{
		if( !isNaN( document.dados_fac.elements[ i ].name ) && document.dados_fac.elements[ i ].value.length <= 0 )
		{
			alert( "Existem características em branco. Por favor, corrija este erro e tente novamente." );
			document.dados_fac.elements[ i ].focus();
			return;
		}

	}
		if (document.dados_fac.interface.value=="")
		  {
			alert( "Escolha um tipo de Interface para o elemento." );
			document.dados_fac.interface.focus();
			return;
		  }
	document.dados_fac.submit();
}

function muda_tipo( val )
{
	document.dados_fac.tpc_id.value = val;
}
</script>
<form name="nova_fac" target="cpt_caracs" method="post"></form>
<iframe name="cpt_caracs" style="display: none;"></iframe>
<form name="dados_fac" method="post" action="proc_ed_circuito.asp">
<input type="Hidden" name="tpc_id" value="" />
<input type="Hidden" name="cto_id" value="<%= request.querystring( "cto_id" ) %>" />
<table class="tipo1">
	<tr>
		<th>Posição:</th>
		<td><input type="Text" size="2" maxlength="1" name="pos_nova_fac" value="" readonly /></td>
	</tr>
	<tr>
		<th>Componente:</th>
		<td>
			<select name="cpt_id" onchange="javascript:busca_cars( this );">
				<option value="">Escolha um componente...</option><%
strSQL = "select cpt_id, cpt_nome from fac_componentes order by cpt_nome"
call Env.RecordSet( true, objRS, strSQl)
if( objRS.BOF and objRS.EOF ) then
	call ErroBD( "Nao foi possivel buscar a lista de componentes" )
end if
while( not( objRS.EOF ) ) %>
				<option value="<%= objRS( "cpt_id" ) %>"><%= objRS( "cpt_nome" ) %></option><%
	objRS.MoveNext
wend
call Env.RecordSet( false, objRS, strSQl)
%>
			</select>
		</td>
	</tr>
</table>
</div>

<div align="center" id="d_carac" style="display:none">
<br>
<table class="tipo1">
	<tr valign=top>
		<th>Caracter&iacute;sticas:</th>
		<td id="td_caracs"></td>
	</tr>
	<tr>
<td></td>
		<td>
		TIPO DE INTERFACE:
<select name="interface">
<option value=""></option>
<%
strSQL = "select tipo_interface, tipo_interface_id from fac_tipo_interface order by  tipo_interface"
call Env.RecordSet( true, objRS, strSQl)
if( objRS.BOF and objRS.EOF ) then
	call ErroBD( "Nao foi possivel buscar a lista de componentes" )
end if
while( not( objRS.EOF ) ) %>
				<option value="<%= objRS( "tipo_interface_id" ) %>"><%= objRS( "tipo_interface" ) %></option><%
	objRS.MoveNext
wend
call Env.RecordSet( false, objRS, strSQl)
%>
			</select>
<br>
		</td>

	</tr>

</table>

<br>
<button  onclick="javascript:verifica_carac();" name="bt_at" disabled>Atualizar</button>
</form>
</div>

<script language="javascript">
if (document.all.dados_fac.bt_at.disabled == true)
	document.all.d_carac.style.display = "none";
	//document.all.tabcarac.style.display = "none";
else
	document.all.d_carac.style.display = "block";
	//document.all.tabcarac.style.display = "block";
</script>

<%
call MostraFooter
%>