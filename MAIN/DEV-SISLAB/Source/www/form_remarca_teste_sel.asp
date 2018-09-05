<!--#include file="includes/Sislab_Lib.asp"-->
<!--#include file="includes/PadraoHTML.asp" -->
<!--#include file="includes/global.asp" -->
<!--#include file="includes/controleshtml.asp" -->
<%
call ImprimeCabecalho2(TITULO_SITE, MENU_ON, true, "", "Cancelamento ou Remarcação de Testes/Ensaios - Agendamentos disponíveis", "", "")

Dim Ebt
Dim rs_numteste, strSQL
Dim num_erro, desc_erro, tipo_remarca

Set Ebt = New TEbt

tipo_remarca = request("tipo_remarca")
%>
<script language="javascript">
function abre(codigo)
{
    formulario.cmbNumeroAgendamento.value= codigo;
	formulario.submit();
}
</script>

<TABLE border=1 cellpadding="2" cellspacing="0" width="100%" class="tabela1">
	<TR>
		<Th colSpan=3 style="font-size: 10px;">N<sup>o</sup> Agendamento - Tipo de Teste</Th>
		<Th style="font-size: 10px;">Situação</Th>
		<Th colSpan=2 style="font-size: 10px;">Tecnologia</Th>
		<Th colSpan=3 style="font-size: 10px;">Solicitante</Th>
		<Th style="font-size: 10px;">Início - Término</Th>
	</TR>
	<TR>
<%
	strSQL = _
		"SELECT * FROM vw_Agendamento a " & _
		"WHERE EXISTS (SELECT he.AG_NUMERO FROM Historico_Eventos he WHERE he.AG_NUMERO = a.AG_NUMERO AND he.HE_DATATERMINO is NULL) " & _
		"AND (a.AG_SOLICITOUCANCELAMENTO = 0 AND a.AG_FLAGREMARCACAO = 0)"

	if tipo_remarca <> "S" then
		strSQL = strSQL & " AND A.AG_USERNAME = '" & Env.Usuario & "'"
	end if
	strSQL = strSQL & " ORDER BY a.AG_Numero"
	call Env.RecordSet( true, rs_numteste, strSQL)

	while not rs_numteste.EOF%>
		<TR>
			<TD colSpan=3 align="justify">
				<a href="javascript:abre(<%=rs_numteste("AG_NUMERO")%>)">
				N<sup>o</sup> AS: <%=rs_numteste("AG_NUMERO")%> - <%=rs_numteste("TA_DESCRICAO")%>  - <%=rs_numteste("AG_TITULO")%></a>
			</TD>
			<TD align="center">
				<%=rs_numteste("S_DESCRICAO")%>&nbsp;
			</TD>
			<TD colSpan=2 align="center">
				<%= rs_numteste("TEC_NOME")%>&nbsp;
			</TD>
			<TD colSpan=3 align="center">
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
			<TD align="center">
				<%=rs_numteste("AG_DATAINICIO") & " - " & rs_numteste("AG_DATATERMINO")%>
			</TD>
		</TR>
		<%rs_numteste.MoveNext()
	wend
	rs_numteste.Close
	set rs_numteste = nothing
%>
	</TR>
</TABLE>
<br>
<form name="formulario" action="form_remarca_teste.asp" method="post">
<input type="hidden" name="cmbNumeroAgendamento">
</form>

<%
Set Ebt = nothing

Call imprimeRodape(RODAPE_OFF)

if Err.number <> 0 then
	Response.Redirect "erro.asp?perro=" & Server.URLEncode(Err.number) & "&pdescricao=" & Server.URLEncode(Err.description) 
end if
%>