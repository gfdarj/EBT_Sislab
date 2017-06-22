<%
Dim senha 'guardam os valores provenientes da tentativa de login
Dim strMsg 'variavel com a mensagem de erro gerada pela SP
Dim objConn, tmp
On Error Resume Next
Response.Cookies("ADMPass") = ""
senha = Request.Form("senha")
strMsg = ""

If(senha <> "")Then
'	Set objConn = Server.CreateObject("ADODB.Connection")
'	objConn.Open "Provider=sqloledb;User ID=ESP_ADMIN_ACESSO_REMOTO;Password=" + senha + "; Initial Catalog=ESPECIALISTAS; Data Source=DBD"
'	If(objConn.Errors.Count > 0)Then
'		For each tmp in objConn.Errors
'			strMsg = strMsg + "Erro: " + tmp.Description + "<br/>"
'		Next
'		Set objConn = Nothing
'	Else
'		objConn.Close
'		Set objConn = Nothing
'		Response.Cookies("ADMPass").Expires = DateAdd("n", 20, Now())
'		Response.Cookies("ADMPass") = senha
'		Response.Redirect "admin_bd_remoto.asp"
'	End If
	If(senha <> "dbdadmin2000")Then
		strMsg = "Senha inválida"
	Else
		Response.Cookies("ADMPass").Expires = DateAdd("n", 20, Now())
		Response.Cookies("ADMPass") = "ok"
		Response.redirect "bd.asp"
	End If
End If%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<html>
<head>
	<title>Login - Administração Remota de Banco de Dados SQL Server</title>
	<link rel="stylesheet" href="../../css/cirap_adm.css">
</head>

<body>
<form name="LOGIN" action="default.asp" method="post">
<br>
<table align="center" border="0">
	<tr>
		<td align="right" nowrap><p class="texto">Senha:</p></td>
		<td align="left" nowrap><input type="Password" name="senha" size="15"></td>
	</tr>
	<tr>
		<td align="center" colspan="2" nowrap><p class="erro"><font size="2"><%=strMsg%></font></p></td>
	</tr>
	<tr>
		<td align="center" colspan="2" nowrap><button type="Button" onclick="validaCampos()">Entrar no Sistema de Administração</button></td>
	</tr>
</table>
</form>
<script language="JavaScript">
function validaCampos(){
	var formulario = document.LOGIN;
	if(formulario.senha.value == ""){
		alert("O campo com o senha do usuário não pode ser deixado em branco!\nPor favor, preencha-o e tente novamente");
		formulario.senha.focus();
	}
	else
		formulario.submit();
}
</script>
</body>
</html>

