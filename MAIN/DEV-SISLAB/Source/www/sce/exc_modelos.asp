<!------- SISLAB ---->
<!--#include file="../includes/Sislab_Lib.asp"-->
<%
ssql = "SELECT MOD_CODNOME from sce_modelos where mod_id = "& request("mod_id")
set rec = Env.oconn.execute(ssql)

ssql = "delete from sce_modelos where mod_id = "& request("mod_id")
Env.oconn.execute(ssql)

acao = "O usuário "& Env.Usuario &" excluiu o modelo "& rec("mod_codnome")
Call Env.LogSce(acao)

Response.Redirect "sel_cad_modelo.asp?msg=2"
%>