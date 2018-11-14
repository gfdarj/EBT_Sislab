<% 'se nao for o 1 ou o 2 sai...
If( cint(Request.Cookies("login")("grpid")) <> 1 )and( cint(Request.Cookies("login")("grpid")) <> 2 )Then%>
<html>
<body>
<script type="text/javascript">
parent.location.href = "login.asp"
</script>
</body>
</html>
<%Response.End
End If%>
