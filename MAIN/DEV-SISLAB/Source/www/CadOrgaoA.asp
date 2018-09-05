<!--#include file="includes/padraoHTML.asp"-->
<!--#include file="includes/bib_mensagem.asp"-->
<!--#include file="includes/Sislab_Lib.asp"-->
<%
Dim orga_id, objSP, rsRET
Dim ehNovo, sigla, descricao, fax, ramal, exibir, chefe, hierarquia

if request("excluir") = "1" then
	orga_id = request("orga_id")
	if orga_id = "" then orga_id = "0"
	ssql = "exec sp_ApagaOrgao " & orga_id

	on error resume next
	Set rsRET = Env.oConn.execute(ssql)
	on error goto 0

	If Env.oConn.Errors.Count > 0 Then
		call erroDB(true, false, true, Env.oConn.Errors, "CadOrgao.asp?orga_id=" & orga_id, "")
	else
		response.redirect "CadOrgao.asp"
	end if
else
	ehNovo = (request("ehNovoUsuario") = "1")
	orga_id = request("orga_id")

	if ehNovo or orga_id = "" then orga_id = null

	sigla = ucase(request("sigla"))
	if sigla = "" then sigla = null

	desc = ucase(request("desc"))
	if descricao = "" then descricao = null

	fax = ucase(request("fax"))
	if fax = "" then fax = null

	ramal = ucase(request("ramal"))
	if ramal = "" then ramal = null
	
	exibir = request("exibir")
	if (exibir = "") or IsNull(exibir) then exibir = 0
	
	chefe = ucase(request("chefe"))
	if chefe = "" then chefe = null
	
	hierarquia = request("hierarquia")
	if IsNumeric(hierarquia) then hierarquia = CInt(hierarquia) else hierarquia = null
	
	call Env.StoredProcedure(true, objSP, "sp_CadOrgao")
	with objSP
		.Parameters.Append .CreateParameter("RETURN_VALUE", adInteger, adParamReturnValue) 

		.Parameters.Append .CreateParameter("@orga_id", adsmallint, adParamInput, , orga_id)
		.Parameters.Append .CreateParameter("@orga_sigla", advarchar, adParamInput, 20, sigla)
		.Parameters.Append .CreateParameter("@orga_descricao", advarchar, adParamInput, 100, desc)
		.Parameters.Append .CreateParameter("@orga_fax", advarchar, adParamInput, 20, fax)
		.Parameters.Append .CreateParameter("@orga_ramal", advarchar, adParamInput, 20, ramal)
		.Parameters.Append .CreateParameter("@orga_exibir", adboolean, adParamInput, , exibir)
		.Parameters.Append .CreateParameter("@orga_useridchefe", advarchar, adParamInput, 20, chefe)
		.Parameters.Append .CreateParameter("@orga_hierarquia", adsmallint, adParamInput, , hierarquia)
		on error resume next
		.Execute
		on error goto 0

		orga_id = .Parameters("RETURN_VALUE")
	end with
	call Env.StoredProcedure(false, objSP, null)
	
	If Env.oConn.Errors.Count > 0 Then
		Call ErroDB(true, false, true, Env.oConn.Errors, "CadOrgao.asp?orga_id=" & request("orga_id"), "")
	Else
		response.redirect "CadOrgao.asp?orga_id=" & orga_id
	End If
End If
%>