<!--#include file="includes/Sislab_Lib.asp"-->
<!--#include file="includes/PadraoHTML.asp" -->
<!--#include file="includes/global.asp" -->
<%
Dim Ebt

Set Ebt = New TEbt

Response.Buffer = true

Call Tela.ImprimeCabecalho2(TITULO_SITE, MENU_ON, true, "", "Valida Remarcação - Agendamentos Disponíveis", "", "")

Dim rs_numteste, strSQL
Dim num_erro, desc_erro, cor
%>
<script type="text/javascript">
    function abre(codigo)
    {
        formulario.cmbNumeroAgendamento.value = codigo;
	    formulario.submit();
    }
</script>

<div class="margem-10">

    <form name="formulario" action="form_valida_remarca.asp" method="post">
        <input type="hidden" name="cmbNumeroAgendamento">
    </form>

    <table class="table-bordered table-condensed table-striped table-hover" style="width: 100%;">
	<tr>
		<th>N<sup>o</sup> Agendamento - Tipo de Teste</th>
		<th style="text-align: center;">Situação</th>
		<th style="text-align: center;">Tecnologia</th>
		<th>Solicitante</th>
		<th style="text-align: center;">Início</th>
		<th style="text-align: center;">Término</th>
	</tr>
	<tr>
<%
	strSQL = _
		"SELECT * FROM vw_Agendamento a " & _
		"WHERE EXISTS (SELECT he.AG_NUMERO FROM Historico_Eventos he WHERE he.AG_NUMERO = a.AG_NUMERO AND he.HE_DATATERMINO is NULL) " & _
		"and EXISTS (SELECT hd.AG_NUMERO FROM Historico_Datas hd WHERE hd.AG_NUMERO = a.AG_NUMERO) " & _
		"and (a.AG_FLAGREMARCACAO = 1 OR a.AG_SOLICITOUCANCELAMENTO = 1) ORDER BY a.AG_NUMERO"
	Call Env.RecordSet(true, rs_numteste, strSQL)

	if rs_numteste.BOF and rs_numteste.EOF then%>
		<tr>
            <td style="text-align: center;" colspan="6">Nenhuma solicitação encontrada !</td>
		</tr>
<%	else
		while not rs_numteste.EOF%>
		<tr>
		    <td style="text-align: justify;">
				<a href="javascript:abre(<%=rs_numteste("AG_NUMERO")%>)">
				N<sup>o</sup> AS: <%=rs_numteste("AG_NUMERO")%> - <%=rs_numteste("TA_DESCRICAO")%> - <%=rs_numteste("AG_TITULO")%></a>
			</td>

<!--
        1	Cadastrado
        2	Pendente
        3	Agendado
        4	Indeferido
        5	Cancelado
        6	Em Execução
        7	Interrompido
        8	Finalizado
        9	Agendado
        10	Pendente
        11	Em Execução
        12	Teste Interrompido
        13	Indeferido
        14	Cancelado
        15	Finalizado -->

    		<td style="text-align: center;">
<%      If rs_numteste("ID_SITUACAO") = 2 Or rs_numteste("ID_SITUACAO") = 10 Or rs_numteste("ID_SITUACAO") = 7 Or rs_numteste("ID_SITUACAO") = 12 Then
            cor = "text-warning"
        ElseIf rs_numteste("ID_SITUACAO") = 4 Or rs_numteste("ID_SITUACAO") = 5 Or rs_numteste("ID_SITUACAO") = 12 Or rs_numteste("ID_SITUACAO") = 13 Or rs_numteste("ID_SITUACAO") = 14 Then
            cor = "text-danger"
        ElseIf rs_numteste("ID_SITUACAO") = 6 Or rs_numteste("ID_SITUACAO") = 8 Or rs_numteste("ID_SITUACAO") = 11 Or rs_numteste("ID_SITUACAO") = 15 Then
            cor = "text-success"
        Else
            cor = ""
        End If %>
                <span class="<%=cor%>"><%=rs_numteste("S_DESCRICAO")%>&nbsp;</span>
	    	</td>

		    <td style="text-align: center;">
				<%= rs_numteste("TEC_NOME")%>&nbsp;
			</td>
		    <td style="text-align: justify;">
<%			Call Ebt.BuscaDadosEmbratel(rs_numteste("ag_username"))

			If Ebt.EhFuncionario Then
				Response.Write Ebt.NomeReduzido
			Else
				Response.Write "xxxx"
			End If %>
				<i>(<%=rs_numteste("ag_username")%>)</i>
			</td>
		    <td style="text-align: center;">
				<%=rs_numteste("AG_DATAINICIO")%>
			</td>
		    <td style="text-align: center;">
				<%=rs_numteste("AG_DATATERMINO")%>
			</td>
		</tr>
<%			rs_numteste.MoveNext()
		wend
	end if
	Call Env.RecordSet(false, rs_numteste, null)
%>
    </table>
    <br />
</div>
<%
Set Ebt = nothing

Call Tela.MostraRodape()
%>
