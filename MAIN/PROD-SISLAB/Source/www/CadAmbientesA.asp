<!--#include file="includes/Sislab_Lib.asp"-->
<!-- #include file="includes/PadraoHTML.asp" -->
<!-- #include file="includes/global.asp" -->
<!-- #include file="includes/funcoes.asp" -->
<!-- #include file="includes/bib_mensagem.asp" -->
<%
Dim ambiente, descricao, rsRET, ssql, usadoporag, modulo, qualCRT

'-- ATENCAO: Se ocorre um erro no SQL (constraint por ex.), o RECORDSET 
'-- nao é preenchido, ficando assim como NOTHING. Para isso verifico na conexao
'-- o acontecimento de algum erro. Caso positivo, chamo uma rotina para processar
'-- e pegar o erro através de um RAISERROR (T-SQL)

If request("excluir") = "1" then
	ambiente = request("ambiente")
	if ambiente = "" then ambiente = "0"

	ssql = "exec sp_ApagaAmbiente " & ambiente

	on error resume next
	Set rsRET = Env.oConn.execute(ssql)
	on error goto 0

	If Env.oConn.Errors.Count > 0 Then
		call erroDB(true, false, true, Env.oConn.Errors, "CadAmbientes.asp?ambiente=" & ambiente, "")
	else
		response.redirect "CadAmbientes.asp"
	end if
Else
	if CStr(request("ehNovoAmbiente")) = "1" then ambiente = "" else ambiente = request("ambiente")

	descricao = ucase(request("desc"))
	usadoporag = request("usadoporag")
	if usadoporag = "" then usadoporag = "0"
    modulo = request("modulo")
    qualCRT = request("crt")

	ssql = "exec sp_CadAmbiente " & ambiente & ", '" & descricao & "'," & usadoporag & ", " & modulo & ", " & qualCRT

'response.write "ehNovoAmbiente: " & request("ehNovoAmbiente")
'response.write "<BR><BR>" & PreparaStrSQL(sSQL)
'response.end

'	on error resume next
	Set rsRET = Env.oConn.execute(PreparaStrSQL(sSQL))
'	on error goto 0


	If Env.oConn.Errors.Count > 0 Then
		call erroDB(true, false, true, Env.oConn.Errors, "CadAmbientes.asp?ambiente=" & ambiente, "")
	else
		response.redirect "CadAmbientes.asp?ambiente=" & rsRET(0)
	end if
End if

set rsRET = nothing
%>
