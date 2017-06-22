<%
'session.abandon
Dim bln_EmJanela : bln_EmJanela = (Request("janela") = "1")

Response.Write "<HTML>" & VbCrLf & _
				"<HEAD>" & VbCrLf & _
				"	<TITLE>SISLAB - Sess&atilde;o expirada</TITLE>" & VbCrLf & _
				"	<meta http-equiv='pragma' content='no-cache'>" & VbCrLf & _
				"	<!--<meta http-equiv='refresh' content='2; url=login.asp'>-->" & VbCrLf & _
				"</HEAD>" & VbCrLf
%>
<body marginwidth="2" marginheight="10" bgcolor="#FFFFFF">
	<center>
	<br>
	<br>
	<font face="verdana" color=#777777 size=5 style="font-size:20pt;">
	Atualização de Informações:</font><br><br>
	<center>
	<table width="70%" align='center'>
	<tr><td>
	<center>
	<br>
	<br>
	<br>
	<font face="verdana" color=#CC7777 size=5 style="font-size:18pt;">
	USUÁRIO <%=replace(ucase(Request.ServerVariables("REMOTE_USER")),"EMBRATEL\","")%> NÃO  ESTÁ AUTORIZADO A ACESSAR ESTA ÁREA OU A SUA SESSÃO ESTÁ EXPIRADA.<BR><BR>
<%
If bln_EmJanela Then
	Response.Write "CLIQUE <a href='javascript:window.close();'>AQUI</a> PARA FECHAR ESTA JANELA"
Else
	Response.Write "REINICIE O BROWSER OU CLIQUE <a href='index.asp'>AQUI</a>, E CASO O ERRO PERSISTA CONTATE O ADMINISTRADOR DO SITE</font>"
End If
%>
	<br>
	<br>
	<font face="verdana" color=#AAAAAA size=4 style="font-size:14pt;">
	<br>
	<br>
	</font>
	<br>
	<br>
	<br>
	</center>
	</td>
	</tr>
	</table>
</body>
</html>
