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

'adicionar aqui verificacoes de seguranca / acesso %>
<script language="JavaScript">
function verifica()
{
	var d = document.novo_circ;
	var l = document.all;
	var msg = "";

	l.l_nome.className = l.l_tipo.className = "";
	if( d.cto_nome.value.length <= 0 )
	{
		d = d.cto_nome;
		l = l.l_nome;
		msg = "Todo circuito deve possuir um nome";
	}
	else if( d.tpc_id.value == "" )
	{
		d = d.tpc_id;
		l = l.l_tipo;
		msg = "Nao foi escolhido um nome para o circuito";
	}
/*
	else if( l.d_datas.style.display == "block" && ( d.dataini_d.value.length <= 0 || d.dataini_m.value.length <= 0 || d.dataini_a.value.length <= 3 ) )
	{
		msg = d.dataini_d.value+"/"+d.dataini_d.value+"/"+d.dataini_a.value+"A data inicial nao possui um valor válido";

		d = d.dataini_d;
		l = l.l_dataini;
	}
	else if( l.d_datas.style.display == "block" && ( d.datafim_d.value.length <= 0 || d.datafim_m.value.length <= 0 || d.datafim_a.value.length <= 3 ) )
	{
		d = d.datafim_d;
		l = l.l_datafim;
		msg = "A data de término nao possui um valor válido";
	}
*/
	
	if( msg != "" )
	{
		alert( msg + ". Por favor, verifique este erro e tente novamente." );
		l.className = "erro";
		d.focus();
	}
	else
	{ d.submit(); }
}


function chk_teste( sel )
{
	if( sel.options[ sel.selectedIndex ].value == "" )
	{
		document.novo_circ.btn_OK.disabled = true;
		document.novo_circ.cto_permanente[ 0 ].disabled = true;
		document.novo_circ.cto_permanente[ 1 ].disabled = true;
	}
	else if( sel.options[ sel.selectedIndex ].text.toUpperCase() == "TESTE" )
	{
/*
		document.all.d_datas.style.display = "block";
		document.novo_circ.dataini_d.disabled = false;
		document.novo_circ.dataini_m.disabled = false;
		document.novo_circ.dataini_a.disabled = false;
		document.novo_circ.datafim_d.disabled = false;
		document.novo_circ.datafim_m.disabled = false;
		document.novo_circ.datafim_a.disabled = false;
*/
		document.novo_circ.btn_OK.disabled = false;
		document.novo_circ.cto_permanente[ 0 ].disabled = false;
		document.novo_circ.cto_permanente[ 1 ].disabled = false;
	}
	else
	{
/*
		document.all.d_datas.style.display = "none";
		document.novo_circ.dataini_d.disabled = true;
		document.novo_circ.dataini_m.disabled = true;
		document.novo_circ.dataini_a.disabled = true;
		document.novo_circ.datafim_d.disabled = true;
		document.novo_circ.datafim_m.disabled = true;
		document.novo_circ.datafim_a.disabled = true;
*/
		document.novo_circ.btn_OK.disabled = false;
		document.novo_circ.cto_permanente[ 0 ].disabled = true;
		document.novo_circ.cto_permanente[ 1 ].disabled = true;
	}
}

</script>
<br><br>
<div align="center"><%
dim objRS, strSQL
strSQL = "select cto_id, cto_nome, tpc_nome, cto_ativado from fac_circuito inner join fac_tipo_circuito on fac_circuito.tpc_id = fac_tipo_circuito.tpc_id order by cto_ativado desc, cto_nome"
call Env.RecordSet( true, objRS, strSQL)
if( objRS.BOF and objRS.EOF ) then %>
<table class="tipo1" align="center" width="400px">
<tr>
  <td bgcolor="#000030" align="right"><font face="tahoma" style="font-size=10pt" color="#FFFFFF">&nbsp;<B><a href="index.asp" class="Menu">Voltar</a></B>&nbsp;&nbsp;&nbsp;<br></font></td>
</tr>
<tr><td class="titulo">Circuitos Cadastrados</td></tr>
<tr><td>Ainda não existem circuitos cadastrados!</td></tr>
</table>
<br /><%
else %>
<table class="tipo1" width="500px">
<tr><td width="380px"></td><td></td></tr>
<tr>
	<td colspan="2" bgcolor="#000030" align="right"><font face="tahoma" style="font-size=10pt" color="#FFFFFF">&nbsp;<B><a href="index.asp" class="Menu">Voltar</a></B>&nbsp;&nbsp;&nbsp;<br></font></td>
</tr>
<tr>
	<td colspan="2" class="titulo">Circuitos Cadastrados</td>
</tr>
<tr>
	<td class="col_tit">Nome</td>
	<td class="col_tit">Tipo</td>
</tr><%
	if( objRS( "cto_ativado" ) ) then
		do while( objRS( "cto_ativado" ) ) %>
<tr>
	<td>
		<a href="ed_circuito.asp?cto_id=<%= objRS( "cto_id" ) %>"><span class="circ_ativ"><%= objRS( "cto_nome" ) %></span></a>
	</td>
	<td>
		<%= objRS( "tpc_nome" ) %>
	</td>
</tr><%
			objRS.MoveNext
			if( objRS.EOF ) then exit do
		loop
	end if
	if( not objRS.EOF ) then
		do while( not objRS.EOF ) %>
<tr>
	<td>
		<a href="ed_circuito.asp?cto_id=<%= objRS( "cto_id" ) %>"><span class="circ_desat"><%= objRS( "cto_nome" ) %></span></a>
	</td>
	<td>
		<%= objRS( "tpc_nome" ) %>
	</td>
</tr><%
			objRS.MoveNext
		loop
	end if %>
</table>
<br /><%
end if
call Env.RecordSet( false, objRS, strSQL)%>
<button id="b_adcirc" onclick="javascript:document.all.if_novo_circ.style.display = 'block';">Adicionar Novo Circuito</button>
<iframe name="if_novo_circ" style="display: none;" src="det_circuito.asp" height="250px" width="600px" align="middle" scrolling="No" frameborder="0"></iframe>
</div>
<!--<div id="d_novo" style="display:none;" align="center">
<form name="novo_circ" action="proc_circuito.asp" method="post">
<table class="tipo1">
	<tr id="l_nome">
		<th>Nome:</th>
		<td><input type="text" name="cto_nome" size="40" maxlength="200" /></td>
	</tr>
	<tr id="l_tipo">
		<th>Tipo:</th>
		<td>
			<select name="tpc_id" onchange="javascript:chk_teste( this );">
				<option value="">Escolha um tipo...</option>--><%
'strSQL = "select tpc_id, tpc_nome from fac_tipo_circuito order by tpc_nome"
'call RecordSet( true, objRS, strSQL, objConn )
'if( objRS.BOF and objRS.EOF ) then
'	call ErroBD( "Nao existem tipos de circuito cadastrados" )
'else
'	while( not objRS.EOF ) %>
				<option value="<%'= objRS( "tpc_id" ) %>"><%'= objRS( "tpc_nome" ) %></option><%
'		objRS.MoveNext
'	wend
'end if
'call RecordSet( false, objRS, strSQL, objConn ) %>
<!--			</select>
		</td>
	</tr>
	<tr id="l_ativ">
		<th>Ativado?</th>
		<td>
			<input type="Radio" name="cto_ativado" value="1" checked />&nbsp;Sim&nbsp;&nbsp;&nbsp;&nbsp;<input type="Radio" name="cto_ativado" value="0" />&nbsp;N&atilde;o
		</td>
	</tr>
	<tr id="l_perm">
		<th>Permanente?</th>
		<td>
			<input type="Radio" name="cto_permanente" value="1" disabled checked />&nbsp;Sim&nbsp;&nbsp;&nbsp;&nbsp;<input type="Radio" name="cto_permanente" value="0" disabled />&nbsp;N&atilde;o
		</td>
	</tr>
</table>
<!-- <div align="center" id="d_datas" style="display:none;">
<br />
<table class="tipo1">
	<tr id="l_dataini">
		<th>Data de in&iacute;cio:</th>
		<td><input type="text" size="2" maxlength="2" name="dataini_d" disabled />/<input type="text" size="2" maxlength="2" name="dataini_m" disabled />/<input type="text" size="4" maxlength="4" name="dataini_a" disabled /></td>
	</tr>
	<tr id="l_datafim">
		<th>Data de T&eacute;rmino:</th>
		<td><input type="text" size="2" maxlength="2" name="datafim_d" disabled />/<input type="text" size="2" maxlength="2" name="datafim_m" disabled />/<input type="text" size="4" maxlength="4" name="datafim_a" disabled /></td>
	</tr>
</table>
</div> 
<p align="center">
<button name="btn_OK" onclick="javascript:verifica();" disabled>&nbsp;&nbsp;OK&nbsp;&nbsp;</button>
</p>
</form>
</div>-->
<%
call MostraFooter
%>