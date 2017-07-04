<!--#include file="includes/Sislab_Lib.asp"-->
<!-- #include file="includes/PadraoHTML.asp" -->
<!-- #include file="includes/global.asp" -->
<!-- #include file="includes/funcoes.asp" -->
<!-- #include file="includes/bib_mensagem.asp" -->
<%
Dim serv, descricao, tipo, rsRET, ssql, plat_pai
Dim Acao

Acao = Request("Acao")

if request("excluir") = "1" then
	serv = request("serv")
	if serv = "" then serv = "0"
	ssql = "exec sp_ApagaServPlataforma " & serv

	on error resume next
	Set rsRET = Env.oConn.execute(ssql)
	on error goto 0

	If Env.oConn.Errors.Count > 0 Then
		call erroDB(true, false, true, Env.oConn.Errors, "CadServPlataforma.asp?Acao=" & Acao & "&serv=" & serv, "")
	else
		response.redirect "CadServPlataforma.asp?Acao=" & Acao
	end if
else
	if request("ehNovoServ") = "1" then serv = "" else serv = request("serv")
	descricao = ucase(request("desc"))
	tipo = request("cmbPlataforma")
	plat_pai = request("plat_pai")

	ssql = "exec sp_CadServPlataforma " & serv & ",'" & descricao & "'," & tipo & "," & plat_pai

'response.write request("ehNovoServ") & "...." & request("serv") & " .... " & tipo
'response.write "<BR><BR>" & PreparaStrSQL(sSQL)
'response.end

	on error resume next
	Set rsRET = Env.oConn.execute(PreparaStrSQL(sSQL))
	on error goto 0

	If Env.oConn.Errors.Count > 0 Then
		call erroDB(true, false, true, Env.oConn.Errors, "CadServPlataforma.asp?Acao=" & Acao & "&serv=" & serv, "")
	else
		response.redirect "CadServPlataforma.asp?Acao=" & Acao & "&serv=" & rsRET(0)
	end if
end if

set rsRET = nothing
%>