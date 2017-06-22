<!--#include file="includes/abre.asp"-->
<%ssql = "select user_nome from sce_usuarios where user_id = "& request("id")
set rec = conn.execute(ssql)

nome_usuario = rec("user_nome")

ssql = "delete from sce_usuarios where user_id = "& request("id")
conn.execute(ssql)
ssql = "select user_nome from sce_usuarios where user_id = "& session("user_id")
	set reco = conn.execute(ssql)
	acao = "O usuário "& reco("user_nome") &" excluiu o usuário "& nome_usuario &"."
	data = year(now)&"/"&right(month(now)+100,2)&"/"&right(day(now)+100,2)&" "&right(hour(now)+100,2)&":"&right(minute(now)+100,2)&":"&right(second(now)+100,2)
	ssql = "insert into sce_historico (id_usuario,acao,data) values ("& session("user_id")&",'"& acao &"','"& data&"')"
	conn.execute(ssql)
response.redirect "alt_usu.asp?msg=2"%>