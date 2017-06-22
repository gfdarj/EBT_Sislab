<!--#include file="includes/Sislab_Lib.asp"-->
<!--#include file="includes/PadraoHTML.asp" -->
<!--#include file="includes/global.asp" -->
<!--#include file="includes/funcoes.asp" -->
<!--#include file="includes/bib_mensagem.asp" -->
<%
Dim objSiteRS, cont, sSQL, tot

dim Titulo, Disponivel, Tipo, Descricao, Observacao
dim retorno, SQL, bitDisponivel, cmdTeste, cod_teste
Dim int_PeriodoRepeticao

cod_teste = Request("cod_teste")
Titulo = Request("txtTitulo")
Disponivel = Request("chkDisponivel")
Tipo = Request("rdoTipo")
Descricao = Request("txaDescricao")
Observacao = Request("txaObservacao")
int_PeriodoRepeticao = Request("PeriodoRepeticao")


If int_PeriodoRepeticao = "" Then int_PeriodoRepeticao = "0"
if cod_teste = "" or cod_teste = "0" then cod_teste = null
if Titulo = "" then Titulo = null
if Disponivel = "on" then
	bitDisponivel = "1"
else
	bitDisponivel = "0"
end if
if Tipo = "" then Tipo = null
if Descricao = "" then Descricao = null
if Observacao = "" then Observacao = null

if request("excluir") = "1" then
	call Env.StoredProcedure(true, cmdTeste, "sp_ApagaTeste")

	cmdTeste.Parameters.Append cmdTeste.CreateParameter("RETURN_VALUE", adInteger, adParamReturnValue) 
	cmdTeste.Parameters.Append cmdTeste.CreateParameter("@pT_ID", adsmallint, adParamInput, , cod_teste)

else
	call Env.StoredProcedure(true, cmdTeste, "sp_CadTeste")

	cmdTeste.Parameters.Append cmdTeste.CreateParameter("RETURN_VALUE", adInteger, adParamReturnValue) 

	cmdTeste.Parameters.Append cmdTeste.CreateParameter("@pT_ID", adsmallint, adParamInput)
	cmdTeste.Parameters.Append cmdTeste.CreateParameter("@pT_TITULO", advarchar, adParamInput, 200)
	cmdTeste.Parameters.Append cmdTeste.CreateParameter("@pT_DISPONIVEL", adboolean, adParamInput)
	cmdTeste.Parameters.Append cmdTeste.CreateParameter("@pT_DESCRICAO", advarchar, adParamInput, 200)
	cmdTeste.Parameters.Append cmdTeste.CreateParameter("@pT_OBSERVACAO", advarchar, adParamInput, 200)
	cmdTeste.Parameters.Append cmdTeste.CreateParameter("@pTIT_ID", adsmallint, adParamInput)
	cmdTeste.Parameters.Append cmdTeste.CreateParameter("@pT_PERIODOREPETICAO", adsmallint, adParamInput)

	cmdTeste.Parameters("@pT_ID") = cod_teste
	cmdTeste.Parameters("@pT_TITULO") = Titulo
	cmdTeste.Parameters("@pT_DISPONIVEL") = bitDisponivel
	cmdTeste.Parameters("@pTIT_ID") = Tipo
	cmdTeste.Parameters("@pT_OBSERVACAO") = Observacao
	cmdTeste.Parameters("@pT_DESCRICAO") = Descricao
	cmdTeste.Parameters("@pT_PERIODOREPETICAO") = int_PeriodoRepeticao
end if

on error resume next
cmdTeste.Execute()
on error goto 0

retorno = cmdTeste.Parameters("RETURN_VALUE")

'response.write "aqui !!! " & retorno
'response.end

if retorno < 0 then
	if request("excluir") = "1" then
		call erroDB(true, false, true, Env.oConn.Errors, "form_atualiza_teste_sel.asp", "")
	else
		call erroDB(true, false, true, Env.oConn.Errors, "form_especifica_teste.asp?cod_teste=" & cod_teste, "")
	end if
else
	if request("excluir") = "1" then
		response.redirect "form_atualiza_teste_sel.asp"	'-- a exclusao está na lista de testes
	else
		response.redirect "form_especifica_teste.asp?cod_teste=" & retorno
	end if
end if

call Env.StoredProcedure(false, cmdTeste, null)
%>
