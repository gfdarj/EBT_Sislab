<!--#include file="includes/abre.asp"-->
<%
ssql = "select *, convert(VARCHAR, user_senha) as senha from sce_usuarios where user_login = '"& request("login") &"'"
set rec = conn.execute(ssql)
if rec.eof then
	response.redirect "index.asp?msg=1"
else
	if ucase(trim(rec("SENHA"))) <> ucase(trim(request("senha"))) then
		response.redirect "index.asp?msg=2"
	else
		session("user_id") = rec("user_id")
		session("status") = rec("user_status")
		session.TimeOut = 40

		set reco = conn.execute(ssql)
		acao = "O usuário "& reco("user_nome") &" se logou no sistema."
		data = year(now)&"/"&right(month(now)+100,2)&"/"&right(day(now)+100,2)&" "&right(hour(now)+100,2)&":"&right(minute(now)+100,2)&":"&right(second(now)+100,2)
		ssql = "insert into sce_historico (id_usuario,acao,data) values "
		ssql = ssql &"("& session("user_id") &",'"& acao &"','"& data &"')"
		conn.execute(ssql)

		response.redirect "index2.asp"
	end if
end if

conn.close
set conn = nothing
%>
