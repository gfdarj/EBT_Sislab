<!--#include file="includes/Sislab_Lib.asp"-->
<!-- #include file="includes/PadraoHTML.asp" -->
<!-- #include file="includes/global.asp" -->
<!-- #include file="includes/funcoes.asp" -->
<!-- #include file="includes/bib_mensagem.asp" -->
<%
Dim tipoarquivo, descricao, rsRET, ssql

'-- ATENCAO: Se ocorre um erro no SQL (constraint por ex.), o RECORDSET 
'-- nao é preenchido, ficando assim como NOTHING. Para isso verifico na conexao
'-- o acontecimento de algum erro. Caso positivo, chamo uma rotina para processar
'-- e pegar o erro através de um RAISERROR (T-SQL)

if request("excluir") = "1" then
	tipoarquivo = request("tipoarquivo")
	if tipoarquivo = "" then tipoarquivo = "0"
	ssql = "exec sp_ApagaTipoArquivo " & tipoarquivo

	on error resume next
	Set rsRET = Env.oConn.execute(ssql)
	on error goto 0

	If Env.oConn.Errors.Count > 0 Then
		call erroDB(true, false, true, Env.oConn.Errors, "CadTipoArquivo.asp?tipoarquivo=" & tipoarquivo, "")
	else
		response.redirect "CadTipoArquivo.asp"
	end if
else
	if request("ehNovoTipoArquivo") = "1" then tipoarquivo = "" else tipoarquivo = request("tipoarquivo")
	descricao = request("desc")
	confidencial = request("confidencial")
	docquali = request("docquali")

	ssql = "exec sp_CadTipoArquivo " & tipoarquivo & ",'" & descricao & "'," & confidencial & "," & docquali

'response.write PreparaStrSQL(sSQL)
'response.end

	on error resume next
	Set rsRET = Env.oConn.execute(PreparaStrSQL(sSQL))
	on error goto 0

	If Env.oConn.Errors.Count > 0 Then
		call erroDB(true, false, true, Env.oConn.Errors, "CadTipoArquivo.asp?tipoarquivo=" & tipoarquivo, "")
	else
		response.redirect "CadTipoArquivo.asp?tipoarquivo=" & rsRET(0)
	end if
end if

set rsRET = nothing
%>
