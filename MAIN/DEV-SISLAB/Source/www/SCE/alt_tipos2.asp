<!--#include file="includes\abre.asp"-->

<% 
tipo_supertipo		= request.form("super_tipo")
if tipo_supertipo = "" then tipo_supertipo = 0
tipo_descricao		= ucase(request.form("tipo_descricao"))

ssql = "update sce_tipos set tipo_descricao = '"& tipo_descricao &"', tipo_supertipo = "& tipo_supertipo &" "
ssql = ssql &" where tipo_id = "& request("tipo_id")
conn.execute(ssql)
ssql = "select user_nome from sce_usuarios where user_id = "& session("user_id")
set reco = conn.execute(ssql)
acao = "O usuário "& reco("user_nome") &" atualizou a família tipo "& request("tipo_descricao") &" de código "& request("tipo_id")&"."
data = year(now)&"/"&right(month(now)+100,2)&"/"&right(day(now)+100,2)&" "&right(hour(now)+100,2)&":"&right(minute(now)+100,2)&":"&right(second(now)+100,2)
ssql = "insert into sce_historico (id_usuario,acao,data) values "
ssql = ssql &"("& session("user_id")&",'"& acao &"','"& data&"')"
conn.execute(ssql)
response.redirect "sel_cad_tipo.asp?msg=1"
%>