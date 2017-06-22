<!--#include file="includes/abre.asp"-->
<%cod = trim(replace(request("au_codareautil"), "'", "&#39;"))
if cod = "" then cod = 0
ssql = "update sce_areautilizacao set au_codareautil = "& cod &", au_descricao = '"& trim(replace(request("au_descricao"), "'", "&#39;")) &"' where au_id = "& trim(replace(request("au_id"), "'", "&#39;"))
conn.execute(ssql)
ssql = "select user_nome from sce_usuarios where user_id = "& session("user_id")
set reco = conn.execute(ssql)
acao = "O usuário "& reco("user_nome") &" atualizou a area de utilização "& trim(replace(request("au_descricao"), "'", "&#39;")) &" de código "& request("au_id")&"."
data = year(now)&"/"&right(month(now)+100,2)&"/"&right(day(now)+100,2)&" "&right(hour(now)+100,2)&":"&right(minute(now)+100,2)&":"&right(second(now)+100,2)
ssql = "insert into sce_historico (id_usuario,acao,data) values "
ssql = ssql &"("& session("user_id")&",'"& acao &"','"& data&"')"
conn.execute(ssql)
response.redirect "sel_cad_areautilizacao.asp?msg=1"%>