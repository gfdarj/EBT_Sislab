<!--#include file="includes/abre.asp"-->
<%
data =  year(now)&"/"&right(month(now)+100,2)&"/"&right(day(now)+100,2)

ssql = "select max(doc_id) as doc_id from SCE_documentacao"
set rec = conn.execute(ssql)
if rec.eof then
	numero = 1
else
	numero = cint(rec("doc_id"))+1
end if

enf_id = request("enf_id")
if enf_id = "" then enf_id = "null"

ssql  ="insert into sce_documentacao (doc_responsavel,doc_datadocumento,doc_observacao,doc_nome,doc_ide,doc_fone,doc_mail,doc_empresa,doc_id,enf_id) values "
ssql = ssql &"('"& ucase(trim(replace(request("doc_responsavel"), "'", """"))) &"','"& data &"', "
ssql = ssql &"'"& ucase(trim(replace(request("doc_observacao"), "'", """"))) &"', "
ssql = ssql &"'"& ucase(trim(replace(request("doc_nome"), "'", """"))) &"', '"& trim(replace(request("doc_ide"), "'", """"))
ssql = ssql & "', '" & trim(replace(request("doc_fone"), "'", """")) &"', '"& trim(replace(request("doc_mail"), "'", """")) &"','"& ucase(trim(replace(request("doc_empresa"), "'", """"))) &"','"& numero &"',"& enf_id &")"

'response.write ssql
'response.end

conn.execute(ssql)
'response.write ssql
'response.end

ssql = "select user_nome from sce_usuarios where user_id = "& session("user_id")
set reco = conn.execute(ssql)

ssql = "select doc_id from sce_documentacao order by doc_id desc"
set rec = conn.execute(ssql)

acao = "O usuário "& reco("user_nome") &" cadastrou o documento "& rec("doc_id") &"."
data = year(now)&"/"&right(month(now)+100,2)&"/"&right(day(now)+100,2)&" "&right(hour(now)+100,2)&":"&right(minute(now)+100,2)&":"&right(second(now)+100,2)

ssql = "insert into sce_historico (id_usuario,acao,data) values ("& session("user_id")&",'"& acao &"','"& data&"')"
conn.execute(ssql)

response.redirect "cad_doc.asp?msg=1"
%>