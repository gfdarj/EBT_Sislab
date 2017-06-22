<!--#include file="includes\abre.asp"-->
<%
ssql = "select * from sce_fabricantes where fab_nome = '"& trim(replace(request("nome"), "'", "&#39;")) & "'"
set rec = conn.execute(ssql)
if not rec.eof then%>
	<html>
	<meta 
		<body>
			<script>
				alert('Fabricante já existente!');
				document.location.href = "cad_fab2.asp";
			</script>
		</body>
	</html>
	<%response.end
end if
ssql = "insert into sce_fabricantes (fab_nome) values ('"& trim(replace(request("nome"), "'", "&#39;")) &"')"
'response.write ssql
'response.end
conn.execute(ssql)
ssql = "select user_nome from sce_usuarios where user_id = "& session("user_id")
	set reco = conn.execute(ssql)
	acao = "O usuário "& reco("user_nome") &" cadastrou o fabricante "& trim(replace(request("nome"), "'", "&#39;")) &"."
	data = year(now)&"/"&right(month(now)+100,2)&"/"&right(day(now)+100,2)&" "&right(hour(now)+100,2)&":"&right(minute(now)+100,2)&":"&right(second(now)+100,2)
	ssql = "insert into sce_historico (id_usuario,acao,data) values ("& session("user_id")&",'"& acao &"','"& data&"')"
	conn.execute(ssql)
response.redirect "cad_fab.asp?msg=1"%>s
 