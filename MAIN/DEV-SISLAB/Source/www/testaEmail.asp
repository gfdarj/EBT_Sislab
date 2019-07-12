<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8" />
    <title>TESTA ENVIO E-MAIL</title>
</head>

<body>
<%
    Dim usuario

    usuario = Replace(Ucase(Request.ServerVariables("REMOTE_USER")), "EMBRATEL\", "")

    Response.Write "NOW: " & Now
    Response.Write "<Br><br>Application('SISLAB_AMBIENTE'): " & Application("SISLAB_AMBIENTE")
    Response.Write "<Br><br>Request.ServerVariables('REMOTE_USER'): " & Request.ServerVariables("REMOTE_USER")
    Response.Write "<Br><br>Replace(Request.ServerVariables('REMOTE_USER') ...): " & usuario

    'Dim str1, str2
    'str1 = "embratel\t3lail"
    'str2 = "t3lail"
    'Response.Write "<br><br>AQUI: " & InStr(UCase(str1), UCase(str2))
%>
<% 
    If Request("enviou") = "1" Then
        Call Enviar_EmailGenerico(Request("email"), Request("email"), Request("email"), Request("email"), "Assunto teste Enviar_Email", "Texto do teste Enviar_Email")
        Call Enviar_Email(Request("email"), Request("email"), "Assunto teste Enviar_Email", "Texto do teste Enviar_Email")

        Response.Write "<br><br><span style='color: red; margin-left: 120px;'>E-mails enviados para " & Request("email") & " !</span>"
    End If

    Dim campo
    If Request("email") <> "" Then
        campo = Request("email")
    Else
        campo = usuario & "@embratel.com.br"
    End If
%>
    <form>
        <input type="hidden" name="enviou" value="1" />
        <br />
        Informe o Email: <input type="text" name="email" value="<%=campo%>" size="50"/> <input type="submit" value="Enviar" />
    </form>

</body>
</html>


<%
'----------------------------------------------------------------------------------------------
'-- Envia um email com os parametros selecionados
'----------------------------------------------------------------------------------------------
Sub Enviar_EmailGenerico(de_email, de_nome, para_email, para_nome, assunto, texto)

'rw "de: " & de_nome & "<" & de_email & ">"
'rw "<br>para:" & para_nome & "<" & para_email & ">"
'rw "<BR><BR>assunto: " & assunto
'rw "<BR><BR>texto: " & texto
're

	If Application("SISLAB_AMBIENTE") = "LOC" Then
		Exit Sub
	End If

'response.write "<BR><BR><BR>de_email 1: " & de_email
    If InStr(UCase(de_email), UCase("T3LAIL")) > 0 Then
        de_email = "laila.sousa@claro.com.br"
    End If
    If InStr(UCase(de_email), UCase("T3MZEN")) > 0 Then
        de_email = "maria.neta@claro.com.br"
    End If
    'If Left(UCase(de_email), 6) = "T3LAIL" Then
    '    de_email = "laila.sousa@claro.com.br"
    'End If
    'If Left(UCase(de_email), 6) = "T3MZEN" Then
    '    de_email = "maria.neta@claro.com.br"
    'End If
'response.write "<BR>de_email 2: " & de_email

'response.write "<BR><BR>para_email 1: " & para_email
    If InStr(UCase(para_email), UCase("T3LAIL")) > 0 Then
        para_email = "laila.sousa@claro.com.br"
    End If
    If InStr(UCase(para_email), UCase("T3MZEN")) > 0 Then
        para_email = "maria.neta@claro.com.br"
    End If
    'If Left(UCase(para_email), 6) = "T3LAIL" Then
    '    para_email = "laila.sousa@claro.com.br"
    'End If
    'If Left(UCase(para_email), 6) = "T3MZEN" Then
    '    para_email = "maria.neta@claro.com.br"
    'End If
'response.write "<BR>para_email 2: " & para_email
'exit sub

	Dim objMail
	'Set objMail = Server.CreateObject("CDONTS.NewMail") 
	'objMail.from = de_nome & "<" & de_email & ">"
	'objMail.to = para_nome & "<" & para_email & ">"
	'objMail.MailFormat = 0  ' formato MIME
	'objMail.BodyFormat = 0  ' html
	'objMail.subject = assunto 
	'objMail.body = _
	'		"<html>" & _
	'		"<head><title>" & assunto & "</title></head>" & _
	'		"<body>" & Replace(texto, VbCrLf, "<BR>") & "</body>" & _
	'		"</html>"
	'objMail.send
	'set objmail = nothing


    Set myMail = CreateObject("CDO.Message")
    myMail.Subject = assunto
    myMail.From = de_email
    myMail.To = para_email
    'myMail.From = de_nome & "<" & de_email & ">"
    'myMail.To = para_nome & "<" & para_email & ">"
    myMail.TextBody = texto




    myMail.Configuration.Fields.Item("http://schemas.microsoft.com/cdo/configuration/smtpserver") = "smtp.gmail.com"

    myMail.Configuration.Fields.Item("http://schemas.microsoft.com/cdo/configuration/smtpserverport") = 465
    myMail.Configuration.Fields.Item("http://schemas.microsoft.com/cdo/configuration/smtpauthenticate") = 1
            
    'Abaixo você preencherá o nome do usuário. Se o seu e-mail é @hotmail, @xbox, @live,
    '@msn ou outros serviços associados à Windows Live, é necessário que você preencha
    'o seu endereço completo no campo abaixo.
    'Se você usa GMail, você deve suprimir o @gmail.com e no campo abaixo deixar apenas
    'o nome do usuário.
    myMail.Configuration.Fields.Item("http://schemas.microsoft.com/cdo/configuration/sendusername") = "gilberto.rjo"
    myMail.Configuration.Fields.Item("http://schemas.microsoft.com/cdo/configuration/sendpassword") = "Timbau230175c"




'    myMail.Configuration.Fields.Item("http://schemas.microsoft.com/cdo/configuration/sendusing") = 2
'    ''* Name or IP of remote SMTP server
'    myMail.Configuration.Fields.Item("http://schemas.microsoft.com/cdo/configuration/smtpserver") = "localhost"
'    '* Server port
'    'myMail.Configuration.Fields.Item("http://schemas.microsoft.com/cdo/configuration/smtpserverport") = 25
'    myMail.Configuration.Fields.Update

    myMail.Send
    set myMail = nothing

End Sub


'----------------------------------------------------------------------------------------------
'-- Envia um email com os parametros selecionados
'----------------------------------------------------------------------------------------------
Sub Enviar_Email(para_email, para_nome, assunto, texto)
	Dim objMail

'response.write "<BR>para_email 1: " & para_email
    If InStr(UCase(para_email), UCase("T3LAIL")) > 0 Then
        para_email = "laila.sousa@claro.com.br"
    End If
    If InStr(UCase(para_email), UCase("T3MZEN")) > 0 Then
        para_email = "maria.neta@claro.com.br"
    End If
    'If Left(UCase(para_email), 6) = "T3LAIL" Then
    '    para_email = "laila.sousa@claro.com.br"
    'End If
    'If Left(UCase(para_email), 6) = "T3MZEN" Then
    '    para_email = "maria.neta@claro.com.br"
    'End If
'response.write "<BR>para_email 2: " & para_email
'exit sub

	If Application("SISLAB_AMBIENTE") <> "LOC" Then
		Set objMail = Server.CreateObject("CDONTS.NewMail") 
		objMail.from = EMAILDEENVIODOSISLAB & "<" & EMAILDEENVIODOSISLAB & ">"
		objMail.to = para_nome & "<" & para_email & ">"
		objMail.MailFormat = 0  ' formato MIME
		objMail.BodyFormat = 0  ' html
		objMail.subject = assunto 
		objMail.body = _
			"<html>" & _
			"<head><title>" & assunto & "</title></head>" & _
			"<body>" & Replace(texto, VbCrLf, "<BR>") & "</body>" & _
			"</html>"
		objMail.send
		set objmail = nothing
	End If
End Sub
%>