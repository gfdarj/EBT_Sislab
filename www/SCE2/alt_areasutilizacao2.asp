<!--#include file="../includes/Sislab_Lib.asp"-->
<%
cod = trim(replace(request("au_codareautil"), "'", "&#39;"))
if cod = "" then cod = 0

ssql = "update sce_areautilizacao set au_codareautil = "& cod &", au_descricao = '"& trim(replace(request("au_descricao"), "'", "&#39;")) &"' where au_id = "& trim(replace(request("au_id"), "'", "&#39;"))
Env.oconn.execute(ssql)

acao = "O usuário "& Env.Usuario &" atualizou a area de utilização "& trim(replace(request("au_descricao"), "'", "&#39;")) &" de código "& request("au_id")
Call Env.LogSce(acao)

response.redirect "sel_cad_areautilizacao.asp?msg=1"
%>