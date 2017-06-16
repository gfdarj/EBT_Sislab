<!--#include file="includes/Sislab_Lib.asp"-->
<!-- #include file="includes/PadraoHTML.asp" -->
<!-- #include file="includes/global.asp" -->
<!-- #include file="includes/funcoes.asp" -->
<!-- #include file="includes/bib_mensagem.asp" -->
<%
if request("excluir") = "1" then
	tipoteste = request("tipoteste")
	if tipoteste = "" then tipoteste = "0"
	ssql = "exec sp_ApagaTipoTeste " & tipoteste

	on error resume next
	Set rsRET = Env.oConn.execute(ssql)
	on error goto 0

	If Env.oConn.Errors.Count > 0 Then
		call erroDB(true, false, true, Env.oConn.Errors, "CadTipoTeste.asp?tipoteste=" & tipoteste, "")
	else
		response.redirect "CadTipoTeste.asp"
	end if
else
	if request("ehNovoTipoTeste") = "1" then tipoteste = "" else tipoteste = request("tipoteste")
	descricao = request("desc")

	ssql = "exec sp_CadTipoTeste " & tipoteste & ",'" & descricao & "'"

	on error resume next
	Set rsRET = Env.oConn.execute(PreparaStrSQL(sSQL))
	on error goto 0

	If Env.oConn.Errors.Count > 0 Then
		call erroDB(true, false, true, Env.oConn.Errors, "CadTipoTeste.asp?tipoteste=" & tipoteste, "")
	else
		response.redirect "CadTipoTeste.asp?tipoteste=" & rsRET(0)
	end if
end if

set rsRET = nothing
%>