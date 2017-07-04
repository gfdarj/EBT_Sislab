<!------- SISLAB ---->
<!--#include file="../includes/Sislab_Lib.asp"-->
<%
ssql = "select * from sce_tipos where tipo_id ="&  request("tipo_id")
set rec = Env.oconn.execute(ssql)

ssql = "delete from sce_tipos where tipo_id = "& request("tipo_id")
Env.oconn.execute(ssql)

acao = "O usuário "& Env.Usuario &" excluiu a familia tipo "& rec("tipo_descricao")
Call Env.LogSce(acao)

response.redirect "sel_cad_tipo.asp?msg=1"
%>