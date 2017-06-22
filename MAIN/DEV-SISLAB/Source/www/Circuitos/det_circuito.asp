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
<body onload="javascript: Preenche();" bgcolor="#FFFFFF" topmargin=0 leftmargin=0><%
dim objConn, objRS, strSQL, cto_nome, tpc_id, cto_permanente, cto_ativado, cto_as
'On error resume next
%>
<br>
<script language="JavaScript">
function chk_teste( sel )
{
	var d = document.det_circ;
	if( sel.options[ sel.selectedIndex ].text.toUpperCase() == "TESTE" )
	{
		d.cto_permanente[ 0 ].disabled = false;
		d.cto_permanente[ 1 ].disabled = false;
		document.all.cmbAS.style.display="block";
	}
	else
	{
		d.cto_permanente[ 0 ].disabled = true;
		d.cto_permanente[ 1 ].disabled = true;
		document.all.cmbAS.style.display="none";
	}
}

function ver_submit()
{
	var d = document.det_circ;
	d.btn_OK.disabled = ( d.cto_nome.value == "" || d.tpc_id.value == "" );
}
</script>
<form action="proc_circuito.asp" method="post" name="det_circ">
<input type="Hidden" name="cto_id" value="<%= request.querystring( "cto_id" ) %>" />
<table class="tipo1" align="center">
	<tr><td></td><td></td></tr>
<%
If request.querystring( "cto_id" ) <> "" Then
	strSQL = "select cto_nome, ag_numero, tpc_id, cto_permanente, cto_ativado from fac_circuito where cto_id = " & request.querystring( "cto_id" )
	call Env.RecordSet( true, objRS, strSQL )

	if( objRS.BOF and objRS.EOF ) then
		call ErroBD( "Nao foi possivel recuperar as informacoes do circuito " & request.querystring( "cto_id" ) )
	end if

	If IsNull(objRS("ag_numero")) Then cto_as = "" Else cto_as = Cstr(objRS("ag_numero"))
	If IsNull(objRS("cto_nome")) Then cto_nome = "" Else cto_nome = objRS("cto_nome")
	If IsNull(objRS("tpc_id")) Then tpc_id = "" Else tpc_id = objRS("tpc_id")
	If IsNull(objRS("cto_permanente")) Then cto_permanente = False Else cto_permanente = objRS("cto_permanente")
	If IsNull(objRS("cto_ativado")) Then cto_ativado = "" Else cto_ativado = objRS("cto_ativado")

	call Env.RecordSet( false, objRS, null)
Else
	cto_as = ""
	cto_nome = ""
	tpc_id = ""
	cto_permanente = null
	cto_ativado = true
End if

strSQL = "select tpc_id, tpc_nome from fac_tipo_circuito order by tpc_nome"
call Env.RecordSet( true, objRS, strSQL)
if( objRS.BOF and objRS.EOF ) then
	call ErroBD( "Nao foi possivel recuperar os tipos de circuito" )
end if %>
	<tr>
		<th colspan="2" class="titulo">Informa&ccedil;&otilde;es do Circuito</th>
	</tr>
	<tr>
		<th>Nome:</th>
		<td><input type="Text" name="cto_nome" onchange="javascript:ver_submit();" size="60" maxlength="200" value="<%= cto_nome %>" /></td>
	</tr>
	<tr>
		<th>Tipo:</th>
		<td>
			<select name="tpc_id" onchange="javascript:chk_teste( this );ver_submit();">
				<option value="">Escolha um tipo...</option><%
while( not objRS.EOF ) %>
				<option value="<%= objRS( "tpc_id" ) %>"><%= objRS( "tpc_nome" ) %></option><%
	objRS.MoveNext
wend
call Env.RecordSet( false, objRS, strSQL)
%>
			</select>
		</td>
	</tr>
<tr>
<td colspan="2">
<div id="cmbAS" style="display:none">
<table class="tipo1" align="center">
	<tr>
		<th>Agendamento:</th>
		<td>

			<select name="AS_id">
				<option value="">Escolha a AS associada</option>

<%
strSQL = "Select distinct AG_Numero, TA_DESCRICAO "
strSQL = strSQL & "from Agendamento "
strSQL = strSQL & "inner join Tipo_Atividade on Agendamento.TA_ID = Tipo_Atividade.TA_ID "
strSQL = strSQL & "Order by AG_Numero desc"
  ' trazer os números dos agendamentos

call Env.RecordSet( true, objRS, strSQL)
if not objRS.EOF then objRS.MoveFirst
While not objRS.EOF%>
<option value="<%=objRS("AG_Numero")%>"><%=Left(objRS("AG_Numero") & " - " & objRS("TA_DESCRICAO"), 45)%></option>
<%	objRS.MoveNext
WEnd
%>
</b></font>
</select>

		</td>
	</tr>
</table>
</div>	
		</td>
	</tr>
	<tr>
		<th>Ativado?</th>
		<td><input type="Radio" name="cto_ativado" value="1" />&nbsp;Sim&nbsp;&nbsp;&nbsp;&nbsp;<input type="Radio" name="cto_ativado" value="0" checked />&nbsp;N&atilde;o</td>
	</tr>
	<tr>
		<th>Permanente?</th>
		<td><input type="Radio" name="cto_permanente" value="1" />&nbsp;Sim&nbsp;&nbsp;&nbsp;&nbsp;<input type="Radio" name="cto_permanente" value="0" checked />&nbsp;N&atilde;o</td>
	</tr>
</table>
<p align="center">
<button name="btn_OK" type="submit">&nbsp;OK&nbsp;</button>
</p>
</form>
<script language="JavaScript">
{
<%if (tpc_id = "4") then%> 
	{
		document.all.cmbAS.style.display="block";
	}
<%else%>
	{
		document.all.cmbAS.style.display="none";
	}
<%end if%>
}

</script>

<script language="JavaScript">

function Preenche(){
document.det_circ.tpc_id.value = '<%= tpc_id %>';
document.det_circ.AS_id.value = '<%= cto_as %>';
<%if( cto_ativado ) then %>
document.det_circ.cto_ativado[ 0 ].checked = true;<%
end if
if( not isNull( cto_permanente ) ) then
	if( cto_permanente ) then %>
document.det_circ.cto_permanente[ 0 ].checked = true;<%
	end if
else %>
document.det_circ.cto_permanente[ 0 ].disabled = true;
document.det_circ.cto_permanente[ 1 ].disabled = true;<%
end if %>
ver_submit();
//document.det_circ.reset();
}



</script>
<%
call MostraFooter
%>