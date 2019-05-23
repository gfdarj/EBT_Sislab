<!------- SISLAB ---->
<!--#include file="../includes/Sislab_Lib.asp"-->
<%
tipo_supertipo		= request.form("super_tipo")
if tipo_supertipo = "" then tipo_supertipo = 0
tipo_descricao		= ucase(request.form("tipo_descricao"))

ssql = "update sce_tipos set tipo_descricao = '"& tipo_descricao &"', tipo_supertipo = "& tipo_supertipo &" "
ssql = ssql &" where tipo_id = "& request("tipo_id")
Env.oconn.execute(ssql)

acao = "O usuário "& Env.Usuario &" atualizou a família tipo "& request("tipo_descricao") &" de código "& request("tipo_id")
Call Env.LogSce(acao)

response.redirect "sel_cad_tipo.asp?msg=1"
%>