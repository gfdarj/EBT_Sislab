<!--#include file="includes/Sislab_Lib.asp"-->
<!--#include file="includes/PadraoHTML.asp" -->
<!--#include file="includes/global.asp" -->
<%
Dim objSP, nome_sp, ag_numero, os_id, return

ag_numero = CInt(request("ag_numero"))
os_id = Trim(request("os_id"))

'-- apaga a AS se for vazio, caso seja "-1" apaga todas as OS e mantem a AS
if os_id = "" then
	nome_sp = "sp_ApagaAgendamento"
else
	nome_sp = "sp_ApagaOrdemDeServico"
end if

Call Env.StoredProcedure(true, objSP, nome_sp)
with objSP
	.Parameters.Append .CreateParameter("RETURN_VALUE", adInteger, adParamReturnValue)
	.Parameters.Append .CreateParameter("@pAG_NUMERO", adinteger, adParamInput, , ag_numero)

	if os_id <> "" then '-- apaga a AS
		if os_id = "-1" then os_id = null else os_id = CInt(os_id)
		.Parameters.Append .CreateParameter("@pOS_ID", adinteger, adParamInput, , os_id)
	end if
	.Execute

	return = .Parameters("RETURN_VALUE")
end with
Call Env.StoredProcedure(false, objSP, nome_sp)

call imprimeCabecalho2(TITULO_SITE, MENU_ON, true, "", "Administração do SISLAB - Exclusão de Agendamento", "location.href='form_agenda_exclui.asp'", "")

'return = 1

if return > 0 then '-- ok
%>
<table border="0" width="100%" class="tabela1">
<tr> 
	<td width="100%" class="texto1B">
		Dados exclu&iacute;dos com sucesso !! <br><br>
<%	if Isnull(os_id) or os_id <> "" then
		if isnull(os_id) then _
			response.write "- Todas as OS´s do agendamento " & ag_numero _
		else _
			response.write "AS N<sup>o</sup>: " & ag_numero & "&nbsp;&nbsp;/&nbsp;&nbsp;OS N<sup>o</sup>:&nbsp;" & os_id
	end if%>
	</td>
</tr>
<tr><td>&nbsp;</td></tr>
<tr> 
	<td width="100%"><a href="form_agenda_exclui.asp">Clique aqui para voltar</a></td>
</tr>
</table>
<%
else '-- ocorreu um erro
%>
<table border="0" width="100%" class="tabela1">
<tr> 
	<td width="100%" class="texto1B">
		N&atilde;o foi poss&iacute;vel excluir os dados solicitados !!!<br><br>
<%	if Isnull(os_id) or os_id <> "" then
		if isnull(os_id) then _
			response.write "- Todas as OS´s do agendamento " & ag_numero _
		else _
			response.write "AS N<sup>o</sup>: " & ag_numero & "&nbsp;&nbsp;/&nbsp;&nbsp;OS N<sup>o</sup>:&nbsp;" & os_id
	end if%>
	</td>
</tr>
<tr><td>&nbsp;</td></tr>
<tr> 
	<td width="100%"><a href="form_agenda_exclui.asp">Clique aqui para voltar</a></td>
</tr>
</table>
<%
end if

Call imprimeRodape(RODAPE_OFF)
%>