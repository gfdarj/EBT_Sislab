<!--#include file="../includes/Sislab_Lib.asp"-->
<!--#include file="../includes/PadraoHTML.asp" -->
<!--#include file="../includes/global.asp" -->
<%
Dim cont, objRS, s
cont=0

call imprimeCabecalho2(TITULO_SITE, MENU_ON, true, "", "Reserva de Ambientes", "location.href='../sislab.asp'", "../")
%>
<script language=javascript>
function navselecao(id_res)
{
	document.all.sel.value = id_res;
	document.formulario.submit();
}
</script>
<form name="formulario" method="post" action="cad_agenda.asp">
<input type="hidden" name="tipocomando" value="Alterar">
<input type="hidden" name="sel" value="">
<table width="100%" border="0" class="tabela1">
<tr valign="middle">
	<td height="40">
		<a href="cad_agenda.asp"><b>&lt;Cadastrar Novo Evento&gt;</b></a>
	</td>
</tr>
<tr>
<tr valign="top">
	<td valign="top">
		<b>Editar Evento Cadastrado</b><br><br>
		<div style="overflow: auto; width: 100%; height=200px; border: thin solid gray;">
			<table border="1" cellpadding="2" cellspacing="0" class="tabela1" width="100%" style="border: solid thin;">
			<tr>
				<th style="font-size: xx-small;">Data Inicial</th>
				<th style="font-size: xx-small;">Data Final</th>
				<th style="font-size: xx-small;">Ambiente</th>
				<th style="font-size: xx-small;">Título do Evento</th>
				<th style="font-size: xx-small;">AS</th>
				<th style="font-size: xx-small;">&nbsp;</th>
			</tr>
<%
s = "Select RAM_ID, RAM_AS, RAM_titulo, CONVERT(VARCHAR, RAM_datainicio, 103) as RAM_DATAINICIO, CONVERT(VARCHAR, RAM_datafim, 103) AS RAM_datafim, AMB_NOME " & _
	"From reserva_ambientes, ambientes " & _
	"where reserva_ambientes.AMB_ID=ambientes.AMB_ID AND " & _
	"ambientes.AMB_USADOPORAG = 0 " & _
	"order by CAST(RAM_datainicio AS DATETIME) desc;"
call Env.RecordSet( true, objRS, s)

if Not objRS.EOF then
	objRS.MoveFirst
	do while not objRS.EOF%>
			<tr>
				<td align="center"><%=objRS("RAM_datainicio")%>&nbsp;</td>
				<td align="center"><%=objRS("RAM_datafim")%>&nbsp;</td>
				<td><a href="#" onclick="navselecao(<%=objRS("RAM_ID")%>);" title="Clique aqui para editar evento"><%=objRS("AMB_NOME")%></a>&nbsp;</td>
				<td><%=objRS("RAM_titulo")%>&nbsp;</td>
				<td align="center"><a href="../ficha_as.asp?emjanela=1&selecao=<%=objRS("RAM_AS")%>" title="Clique aqui para ver os dados do Agendamento" target="_blank"><%=objRS("RAM_AS")%></a>&nbsp;</td>
				<td align="center"><a href="#" onclick="navselecao(<%=objRS("RAM_ID")%>);" title="Clique aqui para editar evento">Editar</a></td>
			</tr>
<%		objRS.movenext
	loop
else%>
			<tr><td colspan="5" align="center"><b><i>Não existem reservas cadastradas no momento</i></b></td></tr>
<%
end if%>
		</table>
		</div>
	</td>
</tr>
</table>
</form>
<br>
<%
call Env.RecordSet( false, objRS, null)
call imprimeRodape(RODAPE_OFF)
%>
