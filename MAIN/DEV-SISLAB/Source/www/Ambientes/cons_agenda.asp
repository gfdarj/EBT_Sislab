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

<p style="font-weight: bold;"><span class="texto-vermelho-bold">&raquo;</span>&nbsp;<span style="font-size: 12px;">Lista de Ocupação dos Ambientes (Atual e Futura)</span></p>

<table border="0" width="100%" class="table-condensed" cellpadding="3" cellspacing="3">
<tr>
	<td>
		<table width="100%" border="1" cellpadding="2" cellspacing="0" class="table-condensed">
		<tr>
<%
s = "SELECT Reserva_ambientes.RAM_id, RAM_descricao, RAM_Titulo, RAM_horario, RAM_contato, Ambientes.AMB_ID, RAM_AS, RAM_Responsavel, CONVERT(VARCHAR, RAM_datainicio, 103) as RAM_DATAINICIO, CONVERT(VARCHAR, RAM_datafim, 103) AS RAM_datafim, AMB_NOME " & _
	"FROM dbo.Ambientes LEFT OUTER JOIN Reserva_ambientes ON Ambientes.AMB_ID = Reserva_ambientes.AMB_ID " & _
	"where (RAM_datafim >= getDate()-1 OR (RAM_ID Is Null)) " & _
	"order by AMB_Nome, RAM_datainicio asc;"
call Env.RecordSet( true, objRS, s)

If Not objRS.EOF Then
	objRS.Movefirst

	auxmesant=""
	auxanoant=""
	auxlocalizacaoant=""

	do while not objRS.EOF
		auxIDagenda=objRS("RAM_id")
		auxdescricao=objRS("RAM_descricao")
		auxtitulo=objRS("RAM_Titulo")
		auxdatainicio=objRS("RAM_datainicio")
		auxdatafim=objRS("RAM_datafim")
		auxhorario=objRS("RAM_horario")
		auxcontato=objRS("RAM_contato")
		auxlocalizacao=objRS("AMB_NOME")
		auxAS=objRS("RAM_AS")
		auxResponsavel=objRS("RAM_Responsavel")
		if Not(IsNull(auxIDagenda) or auxIDagenda="") then
			auxmesatual = month(auxdatainicio)
			auxanoatual = year(auxdatainicio)
		end if

		if auxlocalizacaoant <> auxlocalizacao then
			if auxlocalizacaoant <> "" then%>
			</td>
		</tr>
		<tr>
<%			end if%>
			<td valign="top">
			    <%=auxlocalizacao%>
			</td>
			<td align="justify">
<%		end if%>

<%		if Not(IsNull(auxIDagenda) or auxIDagenda="")  then%>
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
				<br>
<%		else%>
				&nbsp;Ambiente Disponível (sem previsão de utilização)	 
<%		end if

		auxmesant=auxmesatual
		auxanoant=auxanoatual
		auxlocalizacaoant=auxlocalizacao

		objRS.movenext
	loop
else
%>
				Nenhum evento previsto ou em andamento registrado no momento.
<%
end if%>
			</td>
		</tr>
		</table>
	</td>
</tr>
</table>
<br>

</div>

<%
call Env.RecordSet( false, objRS, null)

Call Tela.MostraRodape()
%>
