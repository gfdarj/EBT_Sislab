<!--#include file="includes/Sislab_Lib.asp"-->
<!-- #include file="includes/PadraoHTML.asp" -->
<!-- #include file="includes/global.asp" -->
<!-- #include file="includes/funcoes.asp" -->
<!-- #include file="includes/bib_mensagem.asp" -->
<%
if request("excluir") = "1" then
	tipoativ = request("tipoativ")
	if tipoativ = "" then tipoativ = "0"
	ssql = "exec sp_ApagaTipoAtividade " & tipoativ

	on error resume next
	Set rsRET = Env.oConn.execute(ssql)
	on error goto 0

	If Env.oConn.Errors.Count > 0 Then
		call erroDB(true, false, true, Env.oConn.Errors, "CadTipoAtividade.asp?tipoativ=" & tipoativ, "")
	else
		response.redirect "CadTipoAtividade.asp"
	end if
else
	if request("ehNovoTipoAtividade") = "1" then tipoativ = "" else tipoativ = request("tipoativ")
	descricao = ucase(request("desc"))

	ssql = "exec sp_CadTipoAtividade " & tipoativ & ",'" & descricao & "'"

	on error resume next
	Set rsRET = Env.oConn.execute(PreparaStrSQL(sSQL))
	on error goto 0

	If Env.oConn.Errors.Count > 0 Then
		call erroDB(true, false, true, Env.oConn.Errors, "CadTipoAtividade.asp?tipoativ=" & tipoativ, "")
	else
		response.redirect "CadTipoAtividade.asp?tipoativ=" & rsRET(0)
	end if
end if

set rsRET = nothing
%>