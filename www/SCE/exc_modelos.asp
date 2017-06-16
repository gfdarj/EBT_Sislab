<!--#include file="includes/abre.asp"-->
<%
ssql = "select * from sce_modelos where mod_id = "& request("mod_id")
set rec = conn.execute(ssql)
ssql = "delete from sce_areasutil_modelo where mod_id = "& request("mod_id")
conn.execute(ssql)
ssql = "delete from SCE_PartNumberModelo where mod_id = "& request("mod_id")
conn.execute(ssql)
ssql = "delete from sce_modelos where mod_id = "& request("mod_id")
conn.execute(ssql)
ssql = "select user_nome from sce_usuarios where user_id = "& session("user_id")
set reco = conn.execute(ssql)

acao = "O usuário "& reco("user_nome") &" excluiu o modelo "& rec("mod_codnome") &"."
data = year(now)&"/"&right(month(now)+100,2)&"/"&right(day(now)+100,2)&" "&right(hour(now)+100,2)&":"&right(minute(now)+100,2)&":"&right(second(now)+100,2)
ssql = "insert into sce_historico (id_usuario,acao,data) values ("& session("user_id")&",'"& acao &"','"& data&"')"
conn.execute(ssql)

response.redirect "sel_cad_modelo.asp?msg=2"
%>