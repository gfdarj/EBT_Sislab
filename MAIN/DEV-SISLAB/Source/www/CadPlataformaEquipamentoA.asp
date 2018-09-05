<!--#include file="includes/Sislab_Lib.asp"-->
<!--#include file="includes/PadraoHTML.asp" -->
<!--#include file="includes/global.asp" -->
<!--#include file="includes/funcoes.asp" -->
<!--#include file="includes/bib_mensagem.asp" -->
<%
Dim rsRET, ssql

'-- ATENCAO: Se ocorre um erro no SQL (constraint por ex.), o RECORDSET 
'-- nao é preenchido, ficando assim como NOTHING. Para isso verifico na conexao
'-- o acontecimento de algum erro. Caso positivo, chamo uma rotina para processar
'-- e pegar o erro através de um RAISERROR (T-SQL)

plataforma = ucase(request("plataforma"))
equipamentos = request("listaEquipamentos")

ssql = "exec sp_CadPlataformaEquipamento " & plataforma & ",'" & equipamentos & "'"

on error resume next
Set rsRET = Env.oConn.execute(PreparaStrSQL(sSQL))
on error goto 0

'response.write PreparaStrSQL(sSQL)
'response.end

If Env.oConn.Errors.Count > 0 Then
	call erroDB(true, false, true, Env.oConn.Errors, "CadPlataformaEquipamento.asp?plataforma=" & plataforma, "")
else
	response.redirect "CadPlataformaEquipamento.asp?plataforma=" & plataforma
end if

set rsRET = nothing
%>