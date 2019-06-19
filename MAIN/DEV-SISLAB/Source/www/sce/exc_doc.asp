<!------- SCE ------->
<!--#include file="includes/global_SCE.asp"-->

<!------- SISLAB ---->
<!--#include file="../includes/Geral_Lib.asp"-->
<!--#include file="../includes/Sislab_Lib.asp"-->

<%
Dim ssql, rec

ssql = "select doc_nome from sce_documentacao where doc_id = "& request("doc_id")
set rec = Env.oConn.execute(ssql)

ssql = "delete from sce_documentacao where doc_id = "& request("doc_id")
Env.oConn.execute(ssql)

acao = "O usuário " & Env.Ebt.NomeReduzido() & " excluiu o documento " & rec(0) & "."
data = year(now) & "/" & right(month(now)+100,2) & "/" & right(day(now)+100,2) & " " & right(hour(now)+100,2) & ":" & right(minute(now)+100,2) & ":" & right(second(now)+100,2)

ssql = "insert into sce_historico (id_usuario,acao,data) values ('" & Env.Usuario & "', '" & acao & "', '" & data & "')"
Env.oConn.execute(ssql)

response.redirect "alt_doc.asp?msg=2"
%>