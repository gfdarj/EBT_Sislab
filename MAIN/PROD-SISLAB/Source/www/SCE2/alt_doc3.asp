<!------- SISLAB ---->
<!--#include file="../includes/Sislab_Lib.asp"-->
<%
enf_id = trim(replace(request("enf_id"), "'", "&#39;"))
if Trim(enf_id) = "" then enf_id = "NULL"
ssql =	_
	"update sce_documentacao set doc_responsavel = '" & _
		trim(replace(request("doc_responsavel"), "'", "&#39;")) & _
		"', doc_observacao = '"& trim(replace(request("doc_observacao"), "'", "&#39;")) & _
		"', doc_nome = '"& trim(replace(request("doc_nome"), "'", "&#39;")) & _
		"', doc_ide = '"& trim(replace(request("doc_ide"), "'", "&#39;")) & _
		"', doc_empresa = '"& trim(replace(request("doc_empresa"), "'", "&#39;")) & _
		"', doc_fone = '"& trim(replace(request("doc_fone"), "'", "&#39;")) & _
		"', doc_mail = '"& trim(replace(request("doc_mail"), "'", "&#39;")) & _
		"',enf_id = "& enf_id & " " & _
		" where doc_id = "& trim(replace(request("doc_id"), "'", "&#39;"))
'response.write ssql
Env.oconn.execute(ssql)

acao = "O usuário " & Env.Usuario & " atualizou o documento " & request("doc_id")
Call Env.LogSce(acao)

response.redirect "alt_doc.asp?msg=1"
%>