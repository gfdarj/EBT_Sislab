<!--#include file="includes/Sislab_Lib.asp"-->
<!--#include file="includes/PadraoHTML.asp" -->
<!--#include file="includes/global.asp" -->
<%
' recuperando o periodo da consulta e o username
Dim tp_datainicial, tp_datafinal, username, link, titulo, objRS

tp_datainicial = request("tp_datainicial")
tp_datafinal = request("tp_datafinal")
username = request("username")
exibeTodos = request("exibeTodos")
if exibeTodos <> "1" then exibeTodos = "0"
if username = "" or username = null then username="-1"

link = "location.href='consulta_pessoal.asp?tp_datainicial=" & tp_datainicial & "&tp_datafinal=" & tp_datafinal & "&username=" & username & "&exibeTodos=" & exibeTodos & "'"
titulo = "Quadro de Alocação de Pessoal - Período de " & tp_datainicial & " até " & tp_datafinal
if username <> "-1" then titulo = titulo & " - Usuário " & username

Call Tela.ImprimeCabecalho2(TITULO_SITE, MENU_ON, true, "", titulo, link, "")

'response.write username & "<BR><BR>"
'response.write "sp_ag_pessoas_por_periodo '"&tp_datainicial&"','"&tp_datafinal&"','"&username&"'"
'response.end

if tp_datainicial <> "" then%>
<table width="100%" cellspacing="0" border="0" class="texto1" style="font-size:13px;">
<%
	Dim nomeT
	nomeT = ""
	Call Env.RecordSet(True, objRS, "sp_ag_pessoas_por_periodo '"&tp_datainicial&"','"&tp_datafinal&"','"&username&"'")
	If not(objRS.EOF AND objRS.BOF) Then
		While( NOT( objRS.EOF ) )
			if (objRS("ID_SITUACAO") <> 5 and objRS("ID_SITUACAO") <> 8) or (exibeTodos = "1") then
				if (nomeT <> ucase(objRS("PES_USERNAME"))) then
					if (nomeT <> "") then%>
					<tr>
						<td colspan="5" height="30">
							&nbsp;
						</td>
					</tr>
<%					end if%>
	<tr class="titulo1" valign="bottom">
		<td width="500" colspan="2">
			<b><%=ucase(objRS("PES_USERNAME"))%><br><i><%=objRS("NOME")%></i></b>
		</td>
		<td width="100">
			<b>&nbsp;Início</b>
		</td>
		<td width="100">
			<b>&nbsp;Término</b>
		</td>
		<td width="80">
			<font class="fonte2"><b>&nbsp;Situa&ccedil;&atilde;o</b></font>
		</td>
	</tr>
<%				end if%>
	<tr><td colspan="5"><table width="100%" cellspacing="0" cellpadding="0" height="1px" style="border-bottom: thin #000000 solid;"><tr><td></td></tr></table></td></tr>
	<tr style="border: thin #000000 solid;">
		<td class="celula" width="80" valign="baseline" align="left">
			&nbsp;&nbsp;&nbsp;<%=objRS("TAREFA_TIPO")%>:<%=objRS("TAREFA_ID")%>
		</td>
		<td width="*" valign="baseline">
			<%=objRS("DESCRICAO")%>&nbsp;
		</td>
		<td width="100" valign="baseline">
			&nbsp;<%=FormatDateTime(objRS("TP_DATAINICIAL"),2)%>
		</td>
		<td width="100" valign="baseline">
			&nbsp;<%=FormatDateTime(objRS("TP_DATAFINAL"),2)%>
		</td>
		<td width="100" valign="baseline">
			<font class="fonte2">&nbsp;<%=objRS("S_DESCRICAO")%></font>
		</td>
	</tr>
<%				nomeT = ucase(objRS("PES_USERNAME"))
			end if
			objRS.MoveNext
		Wend
	else%>
	<tr>
		<td colspan="4" align="center">
			<i><b>Nenhum resultado foi encontrado neste período.</b></i>
		</td>
	</tr>
<%	end if
	Call Env.RecordSet(False, objRS, Null)
end if%>
<tr><td>&nbsp;</td></tr>
</table>
<%
Call Tela.MostraRodape()
%>
