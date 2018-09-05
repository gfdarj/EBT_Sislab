<!------- SCE ------->
<!------- SISLAB ---->
<!--#include file="../includes/Sislab_Lib.asp"-->
<%
data =  year(now)&"/"&right(month(now)+100,2)&"/"&right(day(now)+100,2)

ssql = "select max(doc_id) as doc_id from SCE_documentacao"
set rec = Env.oconn.execute(ssql)
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
Env.oconn.execute(ssql)
'response.write ssql
'response.end

acao = "O usuário " & Env.Usuario & " cadastrou o documento "& rec("doc_id")
Call Env.LogSCE(acao)

response.redirect "cad_doc.asp?msg=1"
%>