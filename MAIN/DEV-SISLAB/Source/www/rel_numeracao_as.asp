<!--#include file="includes/Sislab_Lib.asp"-->
<!--#include file="includes/PadraoHTML.asp" -->
<!--#include file="includes/global.asp" -->
<%
Dim objConn, objRS, i, max
Dim tot_geral : tot_geral = 0

call ImprimeCabecalho2(TITULO_SITE, MENU_ON, true, "", "Verifica Numeração dos Agendamentos", "location.href='sislab.asp'", "")

call Env.RecordSet(true, objRS, "SELECT MAX(AG_NUMERO) FROM Agendamento")
max = objRS(0)
call Env.RecordSet(false, objRS, null)
call Env.RecordSet(true, objRS, "SELECT AG_NUMERO, AG_OBJETIVO FROM Agendamento ORDER BY AG_NUMERO")
if not (objRS.Eof and objRS.Bof) then tot_geral = objRS.RecordCount

Server.ScriptTimeout = 1000
Response.buffer = True
response.flush
%>
<br>
<table width="100%" cellpadding="2" cellspacing="0" border="1" class="tabela1">
<tr>
	<th width="50px">Nº AS</th>
	<th>Objetivo</th>
</tr>
<%
for i = 1 to max
	objRS.Find "AG_NUMERO = " & i
%>
<tr>
	<td><%if objRS.Eof then response.write i else response.write "<b>" & i & "</b>"%></td>
	<td><%if not objRS.Eof then response.write objRS("AG_OBJETIVO")%>&nbsp;</td>
</td>
</tr>
<%
	if not objRS.Eof then tot_ag = tot_ag + 1
	objRS.MoveFirst
	response.flush
next
call Env.RecordSet(false, objRS, null)
if tot_geral > 0 then%>
<tr>
	<td colspan="2" align="right">
	<b>Números vagos: <%=max - tot_geral%>&nbsp;&nbsp;&nbsp;&nbsp;Total de Agendamentos: <%=tot_geral%></b>
	</td>
</tr>
<%
end if%>
</table>
<%
call imprimeRodape(RODAPE_OFF)
%>
