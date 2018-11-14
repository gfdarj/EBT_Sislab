<% 'se nao for o 1 sai...
If( cint(Request.Cookies("login")("grpid")) <> 1 )Then%>
<html>
<body>
<script type="text/javascript">
parent.location.href = "login.asp"
</script>
</body>
</html>
<%Response.End
End If%>
