<%@LANGUAGE = VBSCRIPT ENABLESESSIONSTATE = FALSE%>
<%OPTION EXPLICIT
Response.Buffer = True
Response.Expires = 0
'Response.Cookies("login").Expires = DateAdd("n", 20, Now())
On Error Resume Next%>


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