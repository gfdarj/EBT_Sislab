<!--#include file="includes/abre.asp"-->
<%
ssql = "select * from sce_usuarios where user_login = '"& trim(replace(request("login"), "'", "&#39;")) &"'"
set rec = conn.execute(ssql)
if not rec.eof then%>
	<html>
		<body>
			<script>
				alert('Login já existente! Tente outro login.');
				history.back();
			</script>
		</body>
	</html>
	<%response.end
end if
ssql = "insert into sce_usuarios (user_nome,user_email,user_login,user_senha,user_status) values "
ssql = ssql &"('"& trim(replace(request("nome"), "'", "&#39;")) &"','"& trim(replace(request("email"), "'", "&#39;")) &"','"& trim(replace(request("login"), "'", "&#39;")) &"', CAST('"& trim(replace(request("senha"), "'", "&#39;"))&"' AS VARBINARY), "& trim(replace(request("status"), "'", "&#39;")) &")"
conn.execute(ssql)
ssql = "select user_nome from sce_usuarios where user_id = "& session("user_id")
	set reco = conn.execute(ssql)
	acao = "O usuário "& reco("user_nome") &" cadastrou o usuário "& trim(replace(request("nome"), "'", "&#39;")) &"."
	data = year(now)&"/"&right(month(now)+100,2)&"/"&right(day(now)+100,2)&" "&right(hour(now)+100,2)&":"&right(minute(now)+100,2)&":"&right(second(now)+100,2)
	ssql = "insert into sce_historico (id_usuario,acao,data) values ("& session("user_id")&",'"& acao &"','"& data&"')"
	conn.execute(ssql)
response.redirect "cad_usu.asp?msg=1"%>