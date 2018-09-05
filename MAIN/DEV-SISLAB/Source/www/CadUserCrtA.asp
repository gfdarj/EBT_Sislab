<!------- SISLAB ---->
<!--#include file="includes/Sislab_Lib.asp"-->
<!--#include file="includes/PadraoHTML.asp" -->
<!--#include file="includes/global.asp" -->
<!--#include file="includes/funcoes.asp" -->
<!--#include file="includes/bib_mensagem.asp" -->
<%
Dim username, rsRET

if request("excluir") = "1" then
	username = ucase(request("user"))
	ssql = "exec sp_ApagaUserCRT '" & username & "'"

	on error resume next
	Set rsRET = Env.oConn.execute(ssql)
	on error goto 0

	If Env.oConn.Errors.Count > 0 Then
		call erroDB(true, false, true, Env.oConn.Errors, "cadUserCRT.asp?user=" & username, "")
	else
		response.redirect "cadUserCRT.asp"
	end if
else
	ehNovoUsuario = request("ehNovoUsuario")
	username = ucase(request("username"))
	matricula = Replace(Replace(Replace(request("matricula"), "-", ""), ".", ""), "/", "")
	If Not IsNumeric(matricula) Then matricula = 0
	Nome = request("Nome")
	celular = request("celular")
	Ramal = request("Ramal")
	orgao = request("orgao")

	if (request("chkRAT") = "on") THEN chkRAT = 1 ELSE chkRAT = 0
	if (request("chkRT") = "on") THEN chkRT = 1 ELSE chkRT = 0
	if (request("chkGQ") = "on") THEN chkGQ = 1 ELSE chkGQ = 0
	if (request("chkEXIBIR") = "on") THEN chkEXIBIR = 1 ELSE chkEXIBIR = 0

	perfilSce = IIf(Request("perfilSce") = "", "NULL", Request("perfilSce"))

	ssql = "exec sp_CadUserCRT " & ehNovoUsuario & ",'" & username & "'," & matricula & ",'" & Nome & "','" & celular & "'," & _
		   Ramal & "," & orgao & "," & chkRAT & "," & chkRT & "," & chkGQ & "," & chkEXIBIR & "," & perfilSce

	'response.write ssql
	'response.end
	on error resume next
	Set rsRET = Env.oConn.execute(PreparaStrSQL(sSQL))
	on error goto 0

	If Env.oConn.Errors.Count > 0 Then
		call erroDB(true, false, true, Env.oConn.Errors, "cadUserCRT.asp?user=" & username, "")
	else
		response.redirect "cadUserCRT.asp?user=" & username
	end if
end if
%>