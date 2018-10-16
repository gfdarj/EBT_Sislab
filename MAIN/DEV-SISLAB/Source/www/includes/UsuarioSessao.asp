<!-- #include file="conexao.inc" -->
<%
'-- Armazena as informacoes do usuario em uma sessao
function ehUsuarioLogado(user)
	if ucase(Request.cookies("SISLAB")("usuario")) = ucase(user) then
		ehUsuarioLogado = true
	else
		ehUsuarioLogado = false
	end if
end function

function souUsuarioCRT()
	souUsuarioCRT = Request.cookies("SISLAB")("usuarioCRT")
end function

function souRAT()
	souRAT = CBool(Request.cookies("SISLAB")("ehRAT"))
end function

function ArmazenaCaminhoAnterior()
	Response.cookies("SISLAB")("caminhoAnt")  = Request.ServerVariables("HTTP_REFERER")
end function

function RetornaCaminhoAnterior()
	if Request.cookies("SISLAB")("caminhoAnt") <> "" then
		RetornaCaminhoAnterior = Request.cookies("SISLAB")("caminhoAnt")
	else
		RetornaCaminhoAnterior = "msgAcessoNA.ASP"
	end if
end function

function LogaUsuarioNaoCRT()
	'session.Timeout = 20
	Response.Cookies("SISLAB").Expires = Date + 700

	Response.cookies("SISLAB")("usuarioCRT") = false
	Response.cookies("SISLAB")("ehRT") = false
	Response.cookies("SISLAB")("ehRAT") = false
	Response.cookies("SISLAB")("ehGQ") = false
	Response.cookies("SISLAB")("usuario") = replace(ucase(Request.ServerVariables("REMOTE_USER")),"EMBRATEL\","")
'	Response.cookies("SISLAB")("matricula") = ""
	Response.cookies("SISLAB")("PaginaInicial") = "index.asp"
	Response.cookies("SISLAB")("usuarioCRT_Cadastrado") = False

	Call BuscaDadosEmbratel(true,"")

	LogaUsuarioNaoCRT = false
end function

function LogaUsuario(user)
	Dim usuarioCRT : usuarioCRT = false
	Dim objConn, sSQL,obj1,objRS

	On Error Resume Next

	Response.Cookies("SISLAB").Expires = Date + 700

	'-- Rodando Local, armazeno os valores manualmente
	If Application("AMBIENTE") = "LOC" Then
		Response.cookies("SISLAB")("usuario") = "JOSESP"
	Else
		If user = "" then
			Response.cookies("SISLAB")("usuario") = replace(ucase(Request.ServerVariables("REMOTE_USER")),"EMBRATEL\","")
		Else
			Response.cookies("SISLAB")("usuario") = ucase(user)
		End if
	End If

	Response.cookies("SISLAB")("PaginaInicial") = "index.asp"

	'### Verificacao da existencia do usuário
	sSQL= "select USERID, RAT, GQ,RT from UserCRT where UPPER(USERID) = '" & Request.cookies("SISLAB")("usuario") & "' and exibir = 1"
	call Connection( true, objConn )
	call RecordSet( true, objRS, sSQL, objConn )

	'### Armazenamento das informações do usuário logado
	if not (objRS.BOF and objRS.EOF) Then 
		usuarioCRT = true
		Response.cookies("SISLAB")("ehRT") = CBool(objRS("RT"))
		Response.cookies("SISLAB")("ehRAT") = CBool(objRS("RAT"))
		Response.cookies("SISLAB")("ehGQ") = CBool(objRS("GQ"))

		Call BuscaDadosEmbratel(true,"")

		Response.cookies("SISLAB")("usuarioCRT") = usuarioCRT
		LogaUsuario = usuarioCRT
	else
		call LogaUsuarioNaoCRT
		LogaUsuario =  Request.cookies("SISLAB")("ehFuncionario")
	end if
	call RecordSet( false, objRS, null, objConn )

	'-- Devido aos usuários do SCE não serem cadastrados, coloquei este novo Cookie
	'-- para testar no menu RECURSOS se o usuário esta cadastrado ou nao, independente do
	'-- flag EXIBIR
	Response.cookies("SISLAB")("usuarioCRT_Cadastrado") = False

	sSQL= "select USERID from UserCRT where UPPER(USERID) = '" & Request.cookies("SISLAB")("usuario") & "'"
	call Connection( true, objConn )
	call RecordSet( true, objRS, sSQL, objConn )
	if not (objRS.Eof and objRS.Bof) then Response.cookies("SISLAB")("usuarioCRT_Cadastrado") = True
	call RecordSet( false, objRS, null, objConn )

	call Connection( false, objConn )

	If Err.Number = 0 Then
		LogaUsuario = True
	Else
		LogaUsuario = False
	End If

	On Error Goto 0
end function

'-- pega os dados basicos do usuario
Function BuscaDadosEmbratel(armazenaSessao, usuario)
	dim musuario, sql, objConn, objRS

	If Application("AMBIENTE") = "LOC" Then

		Response.cookies("SISLAB")("ehFuncionario") = true
		Response.cookies("SISLAB")("Nome_Reduzido") = "Nome de Teste Local"
		Response.cookies("SISLAB")("Sigla_Orgao") = "LOCAL"
		Response.cookies("SISLAB")("DN") = "0"
		Response.cookies("SISLAB")("UF_Com") = "RJ"
		Response.cookies("SISLAB")("CID_COM") = "9876-5432"
		Response.cookies("SISLAB")("TEL1_COM") = "1234-5678"
		Response.cookies("SISLAB")("ehGerente") = true
		Response.cookies("SISLAB")("Sigla_Orgao_Gerente") = "LOCAL"

	Else
		Response.cookies("SISLAB")("ehGerente") = false
		Response.cookies("SISLAB")("Sigla_Orgao_Gerente") = ""


		musuario = Request.cookies("SISLAB")("usuario")
		if usuario <> "" then musuario = usuario

        Set ebt1 = New TEbt

        Call ebt1.LoginUsuario(musuario)

		Response.cookies("SISLAB")("matricula") = ebt1.Matricula()

		'if armazenaSessao then
			Response.cookies("SISLAB")("ehFuncionario") = ebt1.EhFuncionario()
			Response.cookies("SISLAB")("Nome_Reduzido") = ebt1.NomeReduzido()
	 		Response.cookies("SISLAB")("Sigla_Orgao") = ebt1.SiglaOrgao
			Response.cookies("SISLAB")("DN") = ""
			Response.cookies("SISLAB")("UF_Com") = ""
	 		Response.cookies("SISLAB")("CID_COM") = ""
			Response.cookies("SISLAB")("TEL1_COM") = ebt1.Ramal()
		    Response.cookies("SISLAB")("ehGerente") = ebt1.EhGerente()
			Response.cookies("SISLAB")("Sigla_Orgao_Gerente") = ebt1.SiglaOrgaoGerente()
		'else
		'	set	BuscaDadosEmbratel = ""
		'end if

		Set ebt1  = nothing

	End If

End function

sub verificaSessao()
	IF Request.cookies("SISLAB")("usuario") = "" THEN call logaUsuario()
end sub
%>