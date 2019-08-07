<!--#include file="../includes/Sislab_Lib.asp"-->
<!--#include file="../includes/PadraoHTML.asp" -->
<!--#include file="../includes/global.asp" -->
<%
Dim cont, objRS, s
cont=0

Call Tela.imprimeCabecalho2(TITULO_SITE, MENU_ON, true, "", "Reserva de Ambientes", "location.href='../sislab.asp'", "../")
%>
<script type="text/javascript">
    function navselecao(id_res)
    {
	    document.all.sel.value = id_res;
	    document.formulario.submit();
    }
</script>

<div class="margem-10">
    <form name="formulario" method="post" action="cad_agenda.asp">
        <input type="hidden" name="tipocomando" value="Alterar">
        <input type="hidden" name="sel" value="">


        <div>
		    <p><a href="cad_agenda.asp">&lt;Cadastrar Novo Evento&gt;</a></p>
            <br />
        </div>

        <div>
		    <p><b>Editar Evento Cadastrado</b></p>
        </div>

		<table class="table-bordered table-condensed" width="100%" >
			<tr>
				<th style="text-align: center;">Data Inicial</th>
				<th style="text-align: center;">Data Final</th>
				<th>Ambiente</th>
				<th>Título do Evento</th>
				<th style="text-align: center;">AS</th>
				<th style="text-align: center;">Ação</th>
			</tr>
<%
s = "SELECT ra.RAM_ID, ra.RAM_AS, ra.RAM_titulo, CONVERT(VARCHAR, ra.RAM_datainicio, 103) as RAM_DATAINICIO, CONVERT(VARCHAR, ra.RAM_datafim, 103) AS RAM_datafim, a.AMB_NOME, crt.NM_CRT " & _
	"FROM reserva_ambientes ra INNER JOIN Ambientes a ON ra.AMB_ID = a.AMB_ID " & _
    "   INNER JOIN CentroReferencia crt ON a.ID_CRT = crt.ID_CRT " & _
	"WHERE a.AMB_USADOPORAG = 0 AND a.AMB_MODULO = " & Application("SISLAB_ID_APLICACAO_SISLAB") & " " & _
	"order by CAST(ra.RAM_datainicio AS DATETIME) desc;"
'response.write s
'response.End
Call Env.RecordSet( true, objRS, s)

if Not objRS.EOF then
	objRS.MoveFirst
	do while not objRS.EOF%>
			<tr>
				<td style="text-align: center;"><%=objRS("RAM_datainicio")%>&nbsp;</td>
				<td style="text-align: center;"><%=objRS("RAM_datafim")%>&nbsp;</td>
				<td>
                    <a href="#" onclick="navselecao(<%=objRS("RAM_ID")%>);" title="Clique aqui para editar evento"><%=objRS("AMB_NOME")%></a>&nbsp;<br />
                    <i><small><%=objRS("NM_CRT") %></small></i>
				</td>
				<td><%=objRS("RAM_titulo")%>&nbsp;</td>
				<td style="text-align: center;"><a href="../ficha_as.asp?emjanela=1&selecao=<%=objRS("RAM_AS")%>" title="Clique aqui para ver os dados do Agendamento" target="_blank"><%=objRS("RAM_AS")%></a>&nbsp;</td>
				<td style="text-align: center;"><a href="#" onclick="navselecao(<%=objRS("RAM_ID")%>);" title="Clique aqui para editar evento">Editar</a></td>
			</tr>
<%		objRS.movenext
	loop
else%>
        	<tr>
                <td colspan="5" style="text-align: center;"><b><i>Não existem reservas cadastradas no momento</i></b></td>
        	</tr>
<%
end if%>
		</table>

    </form>
    <br />
</div>
<%
Call Env.RecordSet( false, objRS, null)

Call Tela.MostraRodape()
%>
