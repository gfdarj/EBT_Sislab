<!--#include file="../includes/EmailHtml.asp"-->
<!--#include file="../includes/Sislab_Lib.asp"-->
<!--#include file="../includes/global.asp"-->
<!--#include file="../includes/Geral_Lib.asp"-->
<%
'#####
'#	Testa o envio de mensagens personalizadas
'###
Dim buf

buf = "ERRO"
'response.Write(Request("ID"))
'response.End()

If Not (VVVNZ(Request("ID")) And VVVNZ(Request("Email"))) Then
	Dim RS
	Set RS = Env.oConn.Execute("SELECT DeMensagem, TextoMensagem FROM Mensagem WHERE CodMensagem = " & Request("ID"))

	If Not RS.Eof Then
		Titulo = "Teste do envio de email com mensagem personalizada" & numAS
		Texto = Replace(RS("TextoMensagem"), VbCrLf, "<BR>")

		'Envia o email ao solicitante como se fosse o RT
		Call Enviar_EmailGenerico( _
			"ilab@embratel.com.br", _
			"iLab", _
			Request("Email"), _
			"Teste Sislab", _
			Titulo, _
			Texto _
		)
		buf = "OK"
	End If

	Set RS = Nothing
End If

Response.Write buf
%>
