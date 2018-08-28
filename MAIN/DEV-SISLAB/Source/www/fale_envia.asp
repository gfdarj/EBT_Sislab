<!--#INCLUDE FILE="includes/emailHtml.ASP" -->
<!--#include file="includes/Sislab_Lib.asp"-->
<!--#include file="includes/global.asp" -->
<!--#include file="includes/PadraoHTML.asp" -->
<%
Dim sSQL
Dim auxusername
Dim auxtexto
Dim auxassunto
Dim vTexto

auxusername = request.form("username")
auxassunto = request("assunto")
vTexto = replace(request.form("titulo"), VbCrLf, "<BR>") & "<BR>" & "<BR>" & replace(request.form("texto"), VbCrLf, "<BR>")

'auxusername = "gilbertof"


sSQL = "select * from usercrt where rat=1 and exibir=1"
Call Env.RecordSet(true, rsRATs, sSQL)
While not rsRATs.eof

	If Env.Ebt.ExisteUsuario(rsRATs(0)) then
		Call Enviar_EmailGenerico(auxusername, auxusername, rsRATs("userid"), rsRATs("userid"), "SISLAB - Fale Conosco", vTexto)
	End If

	rsRATs.movenext
WEnd
Call Env.RecordSet(false, rsRATs, sSQL)

'enviar_email auxusername, auxusername, "ilab@embratel.com.br", "Site CRT - " & request.form("assunto") ,  "Site CRT - " & request.form("assunto"), vTexto

call ImprimeCabecalho2(TITULO_SITE, MENU_ON, true, "", "Fale Conosco - Email enviado !", "", "")
%>
<table width="100%" height="100%" border="0">
<tr><td height="30px"></td></tr>
<tr>
	<td class="menu" valign="middle" align="center" height="100%" width="100%">
	A sua mensagem foi encaminhada para a Equipe do CRT.<br><br>
	Em breve retornaremos o seu contato.<br><br>
	Frequente nosso Site e participe do Centro de Referência Tecnológica contribuindo com suas críticas e sugestões.<br>
	</td>
</tr>
<tr><td height="30px"></td></tr>
<tr><td align="center"><input type="Button" class="texto1" value="Voltar para a página inicial" onclick="javascript:location.href='index.asp';"></td></tr>
</table>
<%
Call ImprimeRodape(RODAPE_OFF)
%>
