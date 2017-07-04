<!--#include file="includes/abre.asp"-->
<%
cde = request("cde")
if cde="" then cde=0
defeito = request("defeito")
if defeito="" then defeito=0
prazo = request("prazo")
if prazo="" then prazo=0
asa = request("as")
if asa="" then asa=0
ssql = "insert into sce_natureza_operacao (no_descricao,cde,defeito,prazo,asa,no_tipo) values "
ssql = ssql &"('"& request("no_descricao") &"',"& cde &","& defeito &","& prazo&","& asa &","
ssql = ssql &request("no_tipo") & ")"
conn.execute(ssql)

ssql = "select user_nome from sce_usuarios where user_id = "& session("user_id")
set reco = conn.execute(ssql)
acao = "O usuário "& reco("user_nome") &" cadastrou a natureza de operação "& request("no_descricao") &"."
data = year(now)&"/"&right(month(now)+100,2)&"/"&right(day(now)+100,2)&" "&right(hour(now)+100,2)&":"&right(minute(now)+100,2)&":"&right(second(now)+100,2)
ssql = "insert into sce_historico (id_usuario,acao,data) values ("& session("user_id")&",'"& acao &"','"& data&"')"
conn.execute(ssql)
response.redirect "cad_no.asp?msg=1"
%>