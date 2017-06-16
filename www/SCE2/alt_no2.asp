<!------- SISLAB ---->
<!--#include file="../includes/Sislab_Lib.asp"-->
<%
cde = request("cde")
if cde="" then cde=0
defeito = request("defeito")
if defeito="" then defeito=0
prazo = request("prazo")
if prazo="" then prazo=0
asa = request("as")
if asa="" then asa=0

ssql = "update sce_natureza_operacao set no_descricao = '"& trim(replace(request("no_descricao"), "'", "&#39;")) &"',"
ssql = ssql &"cde = "& cde &",prazo = "& prazo &",defeito = "& defeito &",asa = "& asa & ", "
ssql = ssql &"no_tipo = " & request("no_tipo") & " "
ssql = ssql &"where no_id = "& request("no_id")
Env.oconn.execute(ssql)

acao = "O usuário "& Env.Usuario &" atualizou a natureza de operação "& trim(replace(request("no_descricao"), "'", "&#39;")) &" de código "& request("no_id")

Call Env.LogSce(acao)

response.redirect "sel_cad_no.asp?msg=1"
%>