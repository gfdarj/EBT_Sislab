<!--#include file="includes/abre.asp"-->
<%ssql = "select * from sce_natureza_operacao where no_id = "& request("no_id")
set rec = conn.execute(ssql)
ssql = "delete from sce_natureza_operacao where no_id = "& request("no_id")
conn.execute(ssql)

ssql = "select user_nome from sce_usuarios where user_id = "& session("user_id")
set reco = conn.execute(ssql)
acao = "O usuário "& reco("user_nome") &" excluiu a natureza de operação "& rec("no_descricao") &"."
data = year(now)&"/"&right(month(now)+100,2)&"/"&right(day(now)+100,2)&" "&right(hour(now)+100,2)&":"&right(minute(now)+100,2)&":"&right(second(now)+100,2)
ssql = "insert into sce_historico (id_usuario,acao,data) values ("& session("user_id")&",'"& acao &"','"& data&"')"
conn.execute(ssql)
response.redirect "sel_cad_no.asp?msg=2"
%>