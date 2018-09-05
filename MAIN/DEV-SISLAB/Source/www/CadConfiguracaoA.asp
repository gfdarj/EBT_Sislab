<!--#include file="includes/Sislab_Lib.asp"-->
<!--#include file="includes/PadraoHTML.asp" -->
<!--#include file="includes/global.asp" -->
<!--#include file="includes/funcoes.asp" -->
<!--#include file="includes/bib_mensagem.asp" -->
<%
Dim areaTec, descricao, rsRET, ssql

'-- ATENCAO: Se ocorre um erro no SQL (constraint por ex.), o RECORDSET 
'-- nao é preenchido, ficando assim como NOTHING. Para isso verifico na conexao
'-- o acontecimento de algum erro. Caso positivo, chamo uma rotina para processar
'-- e pegar o erro através de um RAISERROR (T-SQL)

if request("excluir") = "1" then
	areatec = request("areatec")
	if areatec = "" then areatec = "0"
	ssql = "exec sp_ApagaAreaTecnologica " & areatec

	on error resume next
	Set rsRET = Env.oConn.execute(ssql)
	on error goto 0

	If Env.oConn.Errors.Count > 0 Then
		call erroDB(true, false, true, Env.oConn.Errors, "CadAreaTecnologica.asp?areatec=" & areatec, "")
	else
		response.redirect "CadAreaTecnologica.asp"
	end if
else
	if request("ehNovaareatec") = "1" then areatec = "" else areatec = request("areatec")
	descricao = ucase(request("desc"))

	ssql = "exec sp_CadAreaTecnologica " & areatec & ",'" & descricao & "'"

'response.write PreparaStrSQL(sSQL)
'response.end

	on error resume next
	Set rsRET = Env.oConn.execute(PreparaStrSQL(sSQL))
	on error goto 0

	If Env.oConn.Errors.Count > 0 Then
		call erroDB(true, false, true, Env.oConn.Errors, "CadAreaTecnologica.asp?areatec=" & areatec, "")
	else
		response.redirect "CadAreaTecnologica.asp?areatec=" & rsRET(0)
	end if
end if

set rsRET = nothing
%>
