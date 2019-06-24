<!------- SCE ------->
<!--#include file="includes/global_SCE.asp"-->

<!------- SISLAB ---->
<!--#include file="../includes/Geral_Lib.asp"-->
<!--#include file="../includes/Sislab_Lib.asp"-->

<%
ssql = "select * from sce_fabricantes where fab_id = " & request("fab_id")
set rec = Env.oConn.execute(ssql)

ssql = "delete from sce_fabricantes where fab_id = " & request("fab_id")
Env.oConn.execute(ssql)

'ssql = "select user_nome from sce_usuarios where user_id = " & session("user_id")
'set reco = Env.oConn.execute(ssql)

acao = "O usuário "& Env.Usuario &" excluiu o fabricante " & rec("fab_nome") &"."
data = year(now)&"/"&right(month(now)+100,2)&"/"&right(day(now)+100,2)&" "&right(hour(now)+100,2)&":"&right(minute(now)+100,2)&":"&right(second(now)+100,2)

ssql = "insert into sce_historico (id_usuario,acao,data) values ('" & Env.Usuario & "', '"& acao &"','" & data & "')"
Env.oConn.execute(ssql)

Response.Redirect "alt_fab.asp?msg=2"
%>