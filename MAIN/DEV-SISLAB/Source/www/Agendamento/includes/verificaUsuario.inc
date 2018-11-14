<%If( Request.Cookies("login")("usrlogin") = "" )Then%>
<html>
<body>
<script type="text/javascript">
parent.location.href = "login.asp"
</script>
</body>
</html>
<%Response.End
End If%>