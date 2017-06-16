<!--#include file="includes\abre.asp"-->
<% 
	sgp						= trim(replace(request.form("sgp"),  "'","&#39;"))
	au_descricao		= trim(replace(request.form("au_descricao"),  "'","&#39;"))
	au_codareautil	= trim(replace(request.form("au_codareautil"),  "'","&#39;"))
	if sgp = "" then sgp = 0
	if au_codareautil = "" then au_codareautil = 0
ssql = "select * from sce_areautilizacao where au_descricao = '"& au_descricao &"'"
set rec = conn.execute(ssql)
if not rec.eof then%>
	<html>
		<body>
			<script>
				alert('Área de Utilização já existente!');
				history.back();
			</script>
		</body>
	</html>
	<%response.end
end if	
ssql = "insert into sce_areautilizacao (au_descricao,au_codareautil,cod_sgp) values "
ssql = ssql &"('"& au_descricao &"','"& au_codareautil &"','"& sgp &"')"
conn.execute(Ssql)
ssql = "select user_nome from sce_usuarios where user_id = "& session("user_id")
	set reco = conn.execute(ssql)
	acao = "O usuário "& reco("user_nome") &" cadastrou a area de utilização "& trim(replace(request("au_descricao"),  "'","&#39;")) &"."
	data = year(now)&"/"&right(month(now)+100,2)&"/"&right(day(now)+100,2)&" "&right(hour(now)+100,2)&":"&right(minute(now)+100,2)&":"&right(second(now)+100,2)
	ssql = "insert into sce_historico (id_usuario,acao,data) values ("& session("user_id")&",'"& acao &"','"& data&"')"
	conn.execute(ssql)
response.redirect "cad_areasutilizacao.asp?msg=1"%> 