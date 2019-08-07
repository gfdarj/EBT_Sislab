<!--#include file="../includes/Sislab_Lib.asp"-->
<!--#include file="../includes/PadraoHTML.asp" -->
<!--#include file="../includes/global.asp" -->
<%
dim objRS, s, auxlocalizacaoant
dim auxidagenda, auxdescricao, auxtitulo, auxdatainicio, auxdatafim 
dim auxhorario, auxcontato,auxaltera, auxlocalizacao
dim auxmesant,auxanoant,auxmesatual,auxanoatual, auxAS, auxResponsavel

Call Tela.imprimeCabecalho2(TITULO_SITE, MENU_ON, true, "", "Ocupação de Ambientes do CRT", "location.href='sel_cad_agenda.asp'", "../")

if (IsEmpty(request.form("sel"))) Then
	auxselecao = 0
else
	auxselecao = CInt(trim(request("sel")))
End if
%>

<div class="margem-10">

    <br />
    <p style="font-weight: bold;">Lista de Ocupação dos Ambientes (Atual e Futura)</p>

    <table class="table-bordered table-condensed table-striped table-hover largura-total">
    <tr>
        <th>Ambiente/Sala</th>
        <th>CRT</th>
        <th>Observação</th>
    </tr>
<%
s = "SELECT ra.RAM_id, ra.RAM_descricao, ra.RAM_Titulo, ra.RAM_horario, ra.RAM_contato, a.AMB_ID, ra.RAM_AS, ra.RAM_Responsavel, CONVERT(VARCHAR, ra.RAM_datainicio, 103) as RAM_DATAINICIO, CONVERT(VARCHAR, ra.RAM_datafim, 103) AS RAM_datafim, a.AMB_NOME, crt.NM_CRT " & _
	"FROM Ambientes a " & _
    "   LEFT JOIN Reserva_ambientes ra ON a.AMB_ID = ra.AMB_ID " & _
    "   LEFT JOIN CentroReferencia crt ON a.ID_CRT = crt.ID_CRT " & _
	"WHERE (a.AMB_MODULO = " & Application("SISLAB_ID_APLICACAO_SISLAB") & ") AND (RAM_datafim >= getDate()-1 OR (RAM_ID Is Null)) " & _
	"ORDER BY AMB_Nome, RAM_datainicio asc;"
Call Env.RecordSet( true, objRS, s)

'response.Write s
'response.End

If Not objRS.EOF Then
	objRS.Movefirst

	auxmesant=""
	auxanoant=""
	auxlocalizacaoant=""

	Do While Not objRS.Eof
		auxIDagenda=objRS("RAM_id")
		auxdescricao=objRS("RAM_descricao")
		auxtitulo=objRS("RAM_Titulo")
		auxdatainicio=objRS("RAM_datainicio")
		auxdatafim=objRS("RAM_datafim")
		auxhorario=objRS("RAM_horario")
		auxcontato = objRS("RAM_contato")
		auxlocalizacao=objRS("AMB_NOME")
		auxAS=objRS("RAM_AS")
		auxResponsavel=objRS("RAM_Responsavel")
		if Not(IsNull(auxIDagenda) or auxIDagenda="") then
			auxmesatual = month(auxdatainicio)
			auxanoatual = year(auxdatainicio)
		end if

		if auxlocalizacaoant <> auxlocalizacao then
			if auxlocalizacaoant <> "" then %>
	<tr>
<%			end if%>
	    <td valign="top">
			    <%=auxlocalizacao%>&nbsp;
		</td>

        <td><%=objRS("NM_CRT")%></td>

		<td align="justify">
<%		end if%>

<%		If Not(IsNull(auxIDagenda) or auxIDagenda="") Then %>
				<table width="100%" class="table-condensed">
				<tr valign="top">
					<td width="7px"><span class="cinza1">&raquo;</span></td>
					<td>
						<i><%=auxdatainicio%>
<%			if (auxdatainicio<>auxdatafim) then %>
						a <%=auxdatafim%>
<%			end if%>
<%			if Not(Isnull(auxhorario) Or auxhorario="") then%>
						- <%=auxhorario%>
<%			end if%>
						</i><br>
						<b><%=auxtitulo%></b><br>
<%			if Not(Isnull(auxdescricao) Or auxdescricao="") then%>
						<%=auxdescricao%><br>
<%			end if%>
<%			if Not(Isnull(auxlocalizacao) Or auxlocalizacao="") then%>
						<b>Local:</b> <%=auxlocalizacao%><br>
<%			end if%>
<%			if Not(Isnull(auxcontato) Or auxcontato="") then%>
						<b>Contato:</b> <%=auxcontato%><br>
<%			end if%>
<%			if Not(Isnull(auxas) Or auxas="") then%>
						<b>AS:</b> <%=auxas%><br>
<%			end if%>
<%			if Not(Isnull(auxresponsavel) Or auxresponsavel="") then%>
						<b>Responsável:</b> <%=auxresponsavel%>
<%			end if%>
					</td>
				</tr>
				</table>
<%		else%>
				&nbsp;Ambiente Disponível (sem previsão de utilização)	 
<%		end if

		auxmesant=auxmesatual
		auxanoant=auxanoatual
		auxlocalizacaoant=auxlocalizacao

		objRS.movenext
	Loop
%>
		</td>
	</tr>
<%
else
%>
	<tr>
		<td colspan="3" style="text-align: center;">
		    Nenhum evento previsto ou em andamento registrado no momento.
		</td>
	</tr>
<%
end if%>
	</table>

    <br>

</div>

<%
call Env.RecordSet( false, objRS, null)

Call Tela.MostraRodape()
%>
