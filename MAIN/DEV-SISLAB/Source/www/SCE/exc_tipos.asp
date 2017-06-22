<!--#include file="includes\abre.asp"-->

<% ssql = "select * from sce_tipos where tipo_id ="&  request("tipo_id")
set rec = conn.execute(ssql)
ssql = "delete from sce_tipos where tipo_id = "& request("tipo_id")
conn.execute(ssql)
ssql = "select user_nome from sce_usuarios where user_id = "& session("user_id")
	set reco = conn.execute(ssql)
	acao = "O usuário "& reco("user_nome") &" excluiu a familia tipo "& rec("tipo_descricao") &"."
	
	data = year(now)&"/"&right(month(now)+100,2)&"/"&right(day(now)+100,2)&" "&right(hour(now)+100,2)&":"&right(minute(now)+100,2)&":"&right(second(now)+100,2)
	ssql = "insert into sce_historico (id_usuario,acao,data) values ("& session("user_id")&",'"& acao &"','"& data&"')"
	
	conn.execute(ssql)
response.redirect "sel_cad_tipo.asp?msg=1"%>