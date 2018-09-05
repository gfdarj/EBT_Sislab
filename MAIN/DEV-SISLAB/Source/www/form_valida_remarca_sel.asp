<!--#include file="includes/Sislab_Lib.asp"-->
<!--#include file="includes/PadraoHTML.asp" -->
<!--#include file="includes/global.asp" -->
<%
Dim Ebt

Set Ebt = New TEbt

Response.Buffer = true

call ImprimeCabecalho2(TITULO_SITE, MENU_ON, true, "", "Valida Remarcação - Agendamentos Disponíveis", "", "")

Dim rs_numteste, strSQL
Dim num_erro, desc_erro
%>
<script language="javascript">
function abre(codigo)
{
    formulario.cmbNumeroAgendamento.value = codigo;
	formulario.submit();
}
</script>

<form name="formulario" action="form_valida_remarca.asp" method="post">
<input type="hidden" name="cmbNumeroAgendamento">
</form>

<TABLE border="1" cellpadding="2" cellspacing="0" width="100%" class="tabela1">
	<TR>
		<Th colSpan=2 style="font-size: 10px;">N<sup>o</sup> Agendamento - Tipo de Teste</Th>
		<Th style="font-size: 10px;">Situação</Th>
		<!--<th style="font-size: 10px;">Tarefa</th>-->
		<Th colSpan=1 style="font-size: 10px;">Tecnologia</Th>
		<Th colSpan=3 style="font-size: 10px;">Solicitante</Th>
		<Th colspan="2" Align=center style="font-size: 10px;">Início - Término</Th>
	</TR>
	<TR>
<%
	strSQL = _
		"SELECT * FROM vw_Agendamento a " & _
		"WHERE EXISTS (SELECT he.AG_NUMERO FROM Historico_Eventos he WHERE he.AG_NUMERO = a.AG_NUMERO AND he.HE_DATATERMINO is NULL) " & _
		"and EXISTS (SELECT hd.AG_NUMERO FROM Historico_Datas hd WHERE hd.AG_NUMERO = a.AG_NUMERO) " & _
		"and (a.AG_FLAGREMARCACAO = 1 OR a.AG_SOLICITOUCANCELAMENTO = 1) ORDER BY a.AG_NUMERO"
	Call Env.RecordSet(true, rs_numteste, strSQL)

	if rs_numteste.BOF and rs_numteste.EOF then%>
		<tr><td colspan="10" align="center">Nenhum solicitação encontrada !</td></tr>
<%	else
		while not rs_numteste.EOF%>
		<TR>
			<TD colSpan=2 vAlign="middle" align="justify">
				<a href="javascript:abre(<%=rs_numteste("AG_NUMERO")%>)">
				N<sup>o</sup> AS: <%=rs_numteste("AG_NUMERO")%> - <%=rs_numteste("TA_DESCRICAO")%> - <%=rs_numteste("AG_TITULO")%></a>
			</TD>
			<TD align="center">
				<%=rs_numteste("S_DESCRICAO")%>&nbsp;
			</TD>
<!--			<td align="center">
<%'			if rs_numteste("AG_SOLICITOUCANCELAMENTO") then _
'				response.write "Cancelar" _
'			else _
'				if rs_numteste("AG_FLAGREMARCACAO") then _
'					response.write "Remarcar"
%>
			</td>-->
			<TD colSpan="1" align="center">
				<%= rs_numteste("TEC_NOME")%>&nbsp;
			</TD>
			<TD colSpan="3" align="center">
<%
			Call Ebt.BuscaDadosEmbratel(rs_numteste("ag_username"))

			If Ebt.EhFuncionario Then
				Response.Write Ebt.NomeReduzido
			Else
				Response.Write "xxxx"
			End If
%>
				<i>(<%=rs_numteste("ag_username")%>)</i>
			</TD>
			<TD align="center" colspan="2">
				<%=rs_numteste("AG_DATAINICIO") & " - " & rs_numteste("AG_DATATERMINO")%>
			</TD>
		</TR>
<%			rs_numteste.MoveNext()
		wend
	end if
	Call Env.RecordSet(false, rs_numteste, null)
%>
	</TR>
</TABLE>
<br>
<%
Set Ebt = nothing

Call imprimeRodape(RODAPE_OFF)
%>