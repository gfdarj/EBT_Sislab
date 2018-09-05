<!--#include file="includes/Sislab_Lib.asp"-->
<!--#include file="includes/global.asp" -->
<!--#include file="includes/PadraoHTML.asp" -->
<!--#include file="includes/funcoes.asp" -->
<!--#include file="includes/bib_mensagem.asp" -->
<!--#include file="includes/emailHTML.asp" -->
<%
Response.Buffer = true

Response.Addheader "Expires","Mon, 26 Jul 1997 05:00:00 GMT" 
Response.Addheader "Cache-Control","no-cache, must-revalidate" 
Response.Addheader "Pragma","no-cache"

Dim strSQL, vNum_agendamento, vInicio, vFim, vMotivo, vInicioAnt, vFimAnt
Dim num_erro, desc_erro, cmdRemarca, retorno, vTexto, rs_designados, chr_SQL
Dim chr_Buf

vNum_agendamento = Request("txtNum_agendamento")
vInicio = Request("txtInicio")
vFim = Request("txtFim")
vInicioAnt = Request("txtInicioAnt")
vFimAnt = Request("txtFimAnt")
vMotivo = Request("txaMotivo")
remarcacao = (Request("cmbCancelar") = "0")
dim msg

'response.write vNum_agendamento & "<br>"
'response.write vInicio & "<br>"
'response.write vFim & "<br>"
'response.write vMotivo & "<br>"
'response.end

if remarcacao then
	msg = "Remarcação do período de teste"
	if vMotivo = "" then vMotivo = "null" Else vMotivo = "'" & vMotivo & "'"

	chr_SQL = "EXECUTE sp_RemarcaTeste " & vNum_agendamento & ", '" & vInicio & "', '" & vFim & "', " & vMotivo
	Env.oConn.Execute(chr_SQL)

'	Call StoredProcedure(True, cmdRemarca, "sp_RemarcaTeste", objConn)
		'cmdRemarca.Parameters.Append cmdRemarca.CreateParameter("RETURN_VALUE", adInteger, adParamReturnValue) 
'		cmdRemarca.Parameters.Append cmdRemarca.CreateParameter("@pAG_NUMERO", adsmallint, adParamInput, , cint(vNum_agendamento))
'		cmdRemarca.Parameters.Append cmdRemarca.CreateParameter("@pAG_DATAINICIO", adDate, adParamInput, , vInicio)
'		cmdRemarca.Parameters.Append cmdRemarca.CreateParameter("@pAG_DATATERMINO", adDate, adParamInput, , vFim)
'		cmdRemarca.Parameters.Append cmdRemarca.CreateParameter("@pAG_MOTIVO", advarchar, adParamInput, 7000, vMotivo)
'		cmdRemarca.Parameters("@pAG_NUMERO") = Cint(vNum_agendamento)
'		cmdRemarca.Parameters("@pAG_DATAINICIO") = vInicio
'		cmdRemarca.Parameters("@pAG_DATATERMINO") = vFim
'		cmdRemarca.Parameters("@pAG_MOTIVO") = vMotivo
'		cmdRemarca.Execute
		'retorno = cmdRemarca.Parameters("RETURN_VALUE")
'	Call StoredProcedure(False, cmdRemarca, Null, objConn)

	If Err.number <> 0 then
		num_erro = Server.URLEncode(Err.number)
		desc_erro = Server.URLEncode(Err.Description)
		Consite.Close
		set Consite = nothing
		Response.Redirect "erro.asp?perro=" & num_erro & "&pdescricao=" & desc_erro 
	End If

	'=====================================================================================
	vTexto = "Número da AS: " & vNum_agendamento & "<BR>" & "<BR>"
	vTexto = vTexto & "Período anterior" & "<BR>"
	vTexto = vTexto & "Data Inicio: " & vInicioAnt & "<BR>"
	vTexto = vTexto & "Data Fim: " & vFimAnt & "<BR>" & "<BR>"
	vTexto = vTexto & "Período solicitado" & "<BR>"
	vTexto = vTexto & "Data Inicio: " & vInicio & "<BR>"
	vTexto = vTexto & "Data Fim: " & vFim & "<BR>"
	vTexto = replace(vTexto, VbCrLf, "<BR>")

	call enviaEmailsAS(Env.oConn,vNum_agendamento,"Solicitação de Remarcação de Teste",vTexto)
else
	if vMotivo = "" then vMotivo = "null" Else vMotivo = "'" & vMotivo & "'"

	chr_SQL = "EXECUTE sp_CancelaTeste " & vNum_agendamento & ", " & vMotivo
	Env.oConn.Execute(chr_SQL)

'	Call StoredProcedure(True, cmdRemarca, "sp_CancelaTeste", objConn)
'		cmdRemarca.Parameters.Append cmdRemarca.CreateParameter("RETURN_VALUE", adInteger, adParamReturnValue) 
'		cmdRemarca.Parameters.Append cmdRemarca.CreateParameter("@pAG_NUMERO", adsmallint, adParamInput) 
'		cmdRemarca.Parameters.Append cmdRemarca.CreateParameter("@pAG_MOTIVO", advarchar, adParamInput, 7000)
'		cmdRemarca.Parameters("@pAG_NUMERO") = vNum_agendamento
'		cmdRemarca.Parameters("@pAG_MOTIVO") = vMotivo
'		cmdRemarca.Execute
'		retorno = cmdRemarca.Parameters("RETURN_VALUE")
'	Call StoredProcedure(False, cmdRemarca, Null, Null)

	If Err.number <> 0 then
		num_erro = Server.URLEncode(Err.number)
		desc_erro = Server.URLEncode(Err.Description)
		Consite.Close
		set Consite = nothing
		Response.Redirect "erro.asp?perro=" & num_erro & "&pdescricao=" & desc_erro 
	End If

	msg = "Cancelamento do teste nº " & vNum_agendamento & " "
	vTexto = "Número da AS: " & vNum_agendamento & "<BR>" & "<BR>"
	vTexto = vTexto & "Período anterior" & "<BR>"
	vTexto = vTexto & "Data Inicio: " & vInicioAnt & "<BR>"
	vTexto = vTexto & "Data Fim: " & vFimAnt & "<BR>" & "<BR>"
	vTexto = vTexto & "Período solicitado" & "<BR>"
	vTexto = vTexto & "Data Inicio: " & vInicio & "<BR>"
	vTexto = vTexto & "Data Fim: " & vFim & "<BR>"
	vTexto = replace(vTexto, VbCrLf, "<BR>")

	call enviaEmailsAS(Env.oConn,vNum_agendamento,"Solicitação de Cancelamento de Teste",vTexto)
end if

chr_Buf = _
	"<table border='0' width='100%' class='texto1'>" & VbCrLf & _
	"  <tr> " & VbCrLf & _
	"    <td width='100%'><b>Dados Atualizados com Sucesso</b></td>" & VbCrLf & _
	"  </tr>" & VbCrLf & _
	"  <tr>" & VbCrLf & _
	"	<td width='100%'>Seu pedido de " & msg & " foi cadastrado.<br></td>" & VbCrLf & _
	"  </tr>" & VbCrLf & _
	"</table>"

If Env.EhRat Or Env.EhRT Then
	Call MsgGravacaoDados(True, False, chr_Buf, "sislab.asp", "")
Else
	Call MsgGravacaoDados(True, False, chr_Buf, "index.asp", "")
End If
%>
