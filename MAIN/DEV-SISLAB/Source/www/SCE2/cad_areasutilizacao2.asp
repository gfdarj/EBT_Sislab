<!------- SCE ------->
<!------- SISLAB ---->
<!--#include file="../includes/Sislab_Lib.asp"-->
<% 
sgp				= trim(replace(request.form("sgp"),  "'","&#39;"))
au_descricao	= trim(replace(request.form("au_descricao"),  "'","&#39;"))
au_codareautil	= trim(replace(request.form("au_codareautil"),  "'","&#39;"))
if sgp = "" then sgp = 0
if au_codareautil = "" then au_codareautil = 0

ssql = "select * from sce_areautilizacao where au_descricao = '"& au_descricao &"'"
set rec = Env.oconn.execute(ssql)
if not rec.eof then
%>
	<html>
		<body>
			<script>
				alert('Área de Utilização já existente!');
				history.back();
			</script>
		</body>
	</html>
<%  response.end
end if

ssql = "insert into sce_areautilizacao (au_descricao,au_codareautil,cod_sgp) values "
ssql = ssql &"('"& au_descricao &"','"& au_codareautil &"','"& sgp &"')"
Env.oconn.execute(Ssql)

acao = "O usuário "& Env.Usuario &" cadastrou a area de utilização "& trim(replace(request("au_descricao"),  "'","&#39;"))
Call Env.LogSCE(acao)

response.redirect "cad_areasutilizacao.asp?msg=1"
%>
