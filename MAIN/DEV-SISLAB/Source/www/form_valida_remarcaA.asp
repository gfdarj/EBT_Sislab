<!--#include file="includes/Sislab_Lib.asp"-->
<!--#include file="includes/global.asp" -->
<!--#include file="includes/emailHTML.ASP" -->
<!--#include file="includes/PadraoHTML.asp" -->
<!--#include file="includes/bib_mensagem.asp" -->
<%
Dim strSQL, vNum_agendamento, vRemarca, vTexto, rs_designados
Dim num_erro, desc_erro, cmdRemarca, retorno, vCancelou, chr_SQL

vNum_agendamento = Request("txtNum_agendamento")
vRemarca = Request("cmbRemarca")
vCancelou = CBool(Request("solicitouCancelamento"))

if vCancelou then
	chr_SQL = "EXECUTE sp_ValidaCancelamento " & vNum_agendamento & ", '" & Env.usuario & "', " & Request("cmbRemarca")
	Env.oConn.Execute(chr_SQL)

'	Call StoredProcedure(True, cmdRemarca, "sp_ValidaCancelamento", objConn)
'		cmdRemarca.Parameters.Append cmdRemarca.CreateParameter("@pAG_NUMERO", adsmallint, adParamInput)
'		cmdRemarca.Parameters.Append cmdRemarca.CreateParameter("@pRESPONSAVEL", advarchar, adParamInput, 20)
'		cmdRemarca.Parameters("@pAG_NUMERO") = vNum_agendamento
'		cmdRemarca.Parameters("@pRESPONSAVEL") = Request.cookies("SISLAB")("usuario")
'		cmdRemarca.Execute
'	Call StoredProcedure(False, cmdRemarca, Null, Null)
else
'	chr_SQL = "EXECUTE sp_ValidaRemarcacao " & vNum_agendamento & ", " & vRemarca & ""
'	objConn.Execute(chr_SQL)

	Call Env.StoredProcedure(True, cmdRemarca, "sp_ValidaRemarcacao")
 		'cmdRemarca.Parameters.Append cmdRemarca.CreateParameter("RETURN_VALUE", adInteger, adParamReturnValue)
		cmdRemarca.Parameters.Append cmdRemarca.CreateParameter("@pAG_NUMERO", adsmallint, adParamInput)
		cmdRemarca.Parameters.Append cmdRemarca.CreateParameter("@pAG_FLAGREMARCADO", adsmallint, adParamInput)
		cmdRemarca.Parameters("@pAG_NUMERO") = vNum_agendamento
		cmdRemarca.Parameters("@pAG_FLAGREMARCADO") = vRemarca
		cmdRemarca.Execute 
		'retorno = cmdRemarca.Parameters("RETURN_VALUE")
	Call Env.StoredProcedure(False, cmdRemarca, Null)
end if

If Err.number <> 0 then
	Call MsgGravacaoDados(True, False, "<span class='vermelho2'><b>Erro ao gravar remarcação !</b></span>", "form_valida_remarca_sel.asp", "")
else
	'=====================================================================================
	vTexto = "<div class='margem-10'>" & VbCrLf
	vTexto = vTexto & "Número da AS: " & vNum_agendamento & "<BR><BR>"

	if vCancelou then
		If Request("cmbRemarca") = "0" Then
			vTexto = vTexto & "Solicitação do usuário para cancelamento do agendamento foi cancelada."
		Else
			vTexto = vTexto & "Agendamento cancelado"
		End If
	else
		vTexto = vTexto & "Remarcado:"
		if vRemarca then vTexto = vTexto & "Sim" else vTexto = vTexto & "Não"
	end if
	
	vTexto = vTexto & "<BR>"
	vTexto = vTexto & "</div>"
	vTexto = replace(vTexto, VbCrLf, "<BR>")


	'call enviaEmailsAS(Env.oConn,vNum_agendamento,"Validação de Cancelamento/Remarcação de Testes/Ensaios",vTexto)
	call enviaEmailsAS(Env.oConn,vNum_agendamento,"Validação de Remarcação de Agendamento",vTexto)

	'-- solicitacao de cancelamento foi suspensa pelo RAT
	If vCancelou And Request("cmbRemarca") = "0" Then
		Call MsgGravacaoDados(True, False, "<span class='texto1'><b>" & vTexto & "</b></span>", "form_valida_remarca_sel.asp", "")
	Else
		Call MsgGravacaoDados(True, False, "<span class='texto1'><b>A remarcação do Agendamento foi validada com sucesso.</b></span>", "form_valida_remarca_sel.asp", "")
	End If
end if
%>

