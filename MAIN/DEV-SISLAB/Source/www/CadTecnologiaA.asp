<!--#include file="includes/Sislab_Lib.asp"-->
<!-- #include file="includes/PadraoHTML.asp" -->
<!-- #include file="includes/global.asp" -->
<!-- #include file="includes/funcoes.asp" -->
<!-- #include file="includes/controleshtml.asp" -->
<!-- #include file="includes/emailHTML.ASP" -->
<!-- #include file="includes/bib_mensagem.asp" -->
<%
Dim ssql
Dim descricao, areatec, tecnologia

if request("excluir") = "1" then
	tecnologia = request("tecnologia")
	if tecnologia = "" then tecnologia = "0"
	ssql = "exec sp_ApagaTecnologia " & tecnologia

	on error resume next
	Set rsRET = Env.oConn.execute(ssql)
	on error goto 0

	If Env.oConn.Errors.Count > 0 Then
		call erroDB(true, false, true, Env.oConn.Errors, "CadTecnologia.asp?tecnologia=" & tecnologia, "")
	else
		response.redirect "CadTecnologia.asp"
	end if
else
	if request("ehNovaTecnologia") = "1" then tecnologia = "" else tecnologia = request("tecnologia")
	descricao = trim(request("desc"))
	areatec = trim(request("at_id"))

	ssql = "exec sp_CadTecnologia " & tecnologia & ",'" & descricao & "'," & areatec

'response.write PreparaStrSQL(sSQL)
'response.end

	on error resume next
	Set rsRET = Env.oConn.execute(PreparaStrSQL(sSQL))
	on error goto 0


	If Env.oConn.Errors.Count > 0 Then
		call erroDB(true, false, true, Env.oConn.Errors, "CadTecnologia.asp?tecnologia=" & tecnologia, "")
	else
		response.redirect "CadTecnologia.asp?tecnologia=" & rsRET(0)
	end if

end if

set rsRET = nothing
%>