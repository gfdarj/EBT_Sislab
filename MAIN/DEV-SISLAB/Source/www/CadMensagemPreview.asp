<!--#include file="includes/Sislab_Lib.asp"-->
<!--#include file="includes/PadraoHTML.asp" -->
<!--#include file="includes/global.asp" -->
<%

Call ImprimeCabecalho2(TITULO_SITE, MENU_OFF, False, "", "Mensagens de automáticas de email - Preview", "window.close();", "")

If Not (VVVNZ(Request("ID")) And VVVNZ(Request("Email"))) Then
	Dim RS
	Set RS = Env.oConn.Execute("SELECT DeMensagem, TextoMensagem FROM Mensagem WHERE CodMensagem = " & Request("ID"))

	If Not RS.Eof Then
		Titulo = "Teste do envio de email com mensagem personalizada" & numAS
		Texto = Replace(RS("TextoMensagem"), VbCrLf, "<BR>")

        RW "<b>" & Titulo & "</b>"
        RW "<br><br>"
        RW Texto
        RW "<br>"
	End If

	Set RS = Nothing
End If

Call imprimeRodape(RODAPE_OFF)
%>
