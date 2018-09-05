<!------- SCE ------->
<!------- SISLAB ---->
<!--#include file="../includes/Sislab_Lib.asp"-->
<%
ssql = "select * from sce_fabricantes where fab_nome = '"& trim(replace(request("nome"), "'", "&#39;")) & "'"
set rec = Env.oconn.execute(ssql)
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
Env.oconn.execute(ssql)

acao = "O usuário "& Env.Usuario &" cadastrou o fabricante "& trim(replace(request("nome"), "'", "&#39;")) &"."
data = year(now)&"/"&right(month(now)+100,2)&"/"&right(day(now)+100,2)&" "&right(hour(now)+100,2)&":"&right(minute(now)+100,2)&":"&right(second(now)+100,2)
ssql = "insert into sce_historico (id_usuario,acao,data) values ('" & Env.Usuario & "','"& acao &"','"& data&"')"
Env.oconn.execute(ssql)

response.redirect "cad_fab.asp?msg=1"
%>
 