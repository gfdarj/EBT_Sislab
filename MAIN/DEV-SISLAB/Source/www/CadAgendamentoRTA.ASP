<!--#include file="includes/Sislab_Lib.asp"-->
<!--#include file="includes/PadraoHTML.asp" -->
<!--#include file="includes/global.asp" -->
<!--#include file="includes/funcoes.asp" -->
<%
'-- redireciona caso expirado
if Env.usuario = "" or IsEmpty(Env.usuario) then response.redirect "msgAcessoNA.ASP"

Dim listaParticipantesEBT : listaParticipantesEBT = ""

num_ag = request("hdAG")
str_sistema = replace(REQUEST("strSistema")," - ",SEPARADOR_CAMPO)
str_servico = replace(REQUEST("strServico")," - ",SEPARADOR_CAMPO)
relatAS = limpaTexto(request("relatAS"))
listaParticipantesEBT = Trim(trocaPlic2Aspas(request("strParticipantesEBT")))

ssql = _
	"exec sp_CadAgendamentoRT '" & SEPARADOR_CAMPO & "','" & SEPARADOR_REGISTRO & _
	"','" & str_servico & "','" & str_sistema & "','" & relatAS & "'," & num_ag & _
	",'" & listaParticipantesEBT & "'"

ssql = PreparaStrSQL(ssql)

'Response.write num_ag & "<BR>"
'Response.write ssql
'Response.end

Env.oConn.execute(ssql)

response.redirect "CadAgendamentoRT.asp?hdAG=" & num_ag
%>