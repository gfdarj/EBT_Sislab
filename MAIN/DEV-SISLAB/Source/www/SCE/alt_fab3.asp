<!--#include file="includes/abre.asp"-->
<%uf = request("enf_uf")
if uf = "" then uf = 0
ssql = "update sce_fabricantes set fab_nome = '"& replace(ucase(request("fab_nome")),"'","&#39;") &"' where fab_id = "& request("fab_id")
conn.execute(ssql)
ssql = "select user_nome from sce_usuarios where user_id = "& session("user_id")
set reco = conn.execute(ssql)
acao = "O usuário "& ucase(reco("user_nome")) &" atualizou o fabricante "& replace(ucase(request("fab_nome")),"'","&#39;") &"."
data = year(now)&"/"&right(month(now)+100,2)&"/"&right(day(now)+100,2)&" "&right(hour(now)+100,2)&":"&right(minute(now)+100,2)&":"&right(second(now)+100,2)
ssql = "insert into sce_historico (id_usuario,acao,data) values "
ssql = ssql &"("& session("user_id")&",'"& acao &"','"& data&"')"
conn.execute(ssql)
response.redirect "alt_fab.asp?msg=1"%>