<!------- SCE ------->
<!------- SISLAB ---->
<!--#include file="../includes/Sislab_Lib.asp"-->
<%
uf = request("enf_uf")
If uf = "" then uf = 0
ssql = "update sce_fabricantes set fab_nome = '"& replace(ucase(request("fab_nome")),"'","&#39;") &"' where fab_id = "& request("fab_id")
Env.oconn.execute(ssql)

acao = "O usuário "& Env.Usuario &" atualizou o fabricante "& replace(ucase(request("fab_nome")),"'","&#39;")

Call Env.LogSce(acao)

Response.Redirect "alt_fab.asp?msg=1"
%>