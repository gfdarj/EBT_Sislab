<%If( Request.Cookies("login")("usrlogin") = "" )Then%>
<html>
<body>
<script language="JavaScript">
parent.location.href = "login.asp"
</script>
</body>
</html>
<%Response.End
End If%>