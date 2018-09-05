<!--#include file="../includes/Sislab_Lib.asp"-->
<%
ssql = "select * from sce_areautilizacao where au_id = "& request("au_id")
set rec = Env.oconn.execute(ssql)
ssql = "delete from sce_areautilizacao where au_id = "& request("au_id")
Env.oconn.execute(ssql)

ssql = "delete from sce_areasutil_modelo where au_id = "& request("au_id")
Env.oconn.execute(ssql)

acao = "O usuário "& Env.Usuario &" excluiu a área "& rec("au_descricao") &"."
Call Env.LogSce(acao)

response.redirect "sel_cad_areautilizacao.asp?msg=2"
%>