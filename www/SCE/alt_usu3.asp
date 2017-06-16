<!--#include file="includes/abre.asp"-->
<%
ssql = "update sce_usuarios set user_nome = '"& trim(replace(request("nome"), "'", "&#39;")) &"', user_email = '"& trim(replace(request("email"), "'", "&#39;")) &"', "
ssql = ssql &"user_login = '"& trim(replace(request("login"), "'", "&#39;")) &"', user_senha = CAST('"& trim(replace(request("senha"), "'", "&#39;")) &"' AS VARBINARY), user_status = "& request("status") & " "
ssql = ssql &"where user_id = "& trim(replace(request("id"), "'", "&#39;"))
conn.execute(ssql)
ssql = "select user_nome from sce_usuarios where user_id = "& session("user_id")
set reco = conn.execute(ssql)
acao = "O usuário " & reco("user_nome") & " atualizou o usuário " & trim(replace(request("nome"), "'", "&#39;")) &" de código "& trim(replace(request("id"), "'", "&#39;"))&"."


data = year(now)&"/"&right(month(now)+100,2)&"/"&right(day(now)+100,2)&" "&right(hour(now)+100,2)&":"&right(minute(now)+100,2)&":"&right(second(now)+100,2)
ssql = "insert into sce_historico (id_usuario,acao,data) values "
ssql = ssql &"("& session("user_id")&",'"& acao &"','"& data&"')"
conn.execute(ssql)
response.redirect "alt_usu.asp?msg=1"%>