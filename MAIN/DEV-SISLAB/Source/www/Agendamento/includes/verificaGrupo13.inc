<% 'se nao for o 1 ou o 3 sai...
If( cint(Request.Cookies("login")("grpid")) <> 1 )and( cint(Request.Cookies("login")("grpid")) <> 3 )Then%>
<html>
<body>
<script language="JavaScript">
parent.location.href = "login.asp"
</script>
</body>
</html>
<%Response.End
End If%>
