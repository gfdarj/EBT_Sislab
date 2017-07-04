<!--#include file="includes/abre.asp"-->
<%
Dim uf, enf_cnpj
uf = trim(replace(request("enf_uf"), "'", "&#39;"))
if uf = "" then uf = "null"

enf_cnpj = trim( replace(replace(replace(replace(request("enf_cnpj"), "'", ""), ".", ""), "/", ""), "-", "") )
if enf_cnpj = "" then enf_cnpj = "null" else enf_cnpj = "'" & enf_cnpj & "'"

ssql = "update sce_empresa_nota_fiscal set enf_observacao = '"& replace(replace(ucase(request("enf_observacao")),"'","&acute;"),"""","&quot;") &"', "
ssql = ssql &"enf_contato = '"& trim(replace(ucase(request("enf_contato")), "'", "&#39;")) &"', enf_fax = '"& trim(replace(request("enf_fax"), "'", "&#39;")) &"', enf_tel = '"& trim(replace(request("enf_tel"), "'", "&#39;")) &"', "
ssql = ssql &"enf_cep = '"& trim(replace(request("enf_cep"), "'", "&#39;")) &"', enf_uf = "& uf &", enf_cidade = '"& trim(replace(ucase(request("enf_cidade")), "'", "&#39;")) &"', "
ssql = ssql &"enf_endereco = '"& trim(replace(ucase(request("enf_endereco")), "'", "&#39;")) &"', enf_cnpj = "& enf_cnpj &", enf_cpf = '"& trim(replace(request("enf_cpf"), "'", "&#39;")) &"', enf_ie = '"& trim(replace(request("enf_ie"), "'", "&#39;")) &"', "
ssql = ssql &"enf_nome = '"& trim(replace(ucase(request("enf_nome")), "'", "&#39;")) &"', enf_ddd = '"& trim(replace(request("ddd"), "'", "&#39;")) &"', enf_ddd_fax = '"& trim(replace(request("ddd_fax"), "'", "&#39;")) &"', "
ssql = ssql &"enf_email = '"& trim(replace(request("email"), "'", "&#39;")) &"', enf_tipoempresa = '" & request("tipoempresa") & "' "
ssql = ssql &"where enf_id = "& trim(replace(request("enf_id"), "'", "&#39;"))
conn.execute(ssql)

acao = "O usuário "& session("user_id")&" atualizou a empresa "& trim(replace(request("enf_nome"), "'", "&#39;")) &" de cnpj "& trim(replace(request("enf_cnpj"), "'", "&#39;"))&"."
data = year(now)&"/"&right(month(now)+100,2)&"/"&right(day(now)+100,2)&" "&right(hour(now)+100,2)&":"&right(minute(now)+100,2)&":"&right(second(now)+100,2)
ssql = "insert into sce_historico (id_usuario,acao,data) values "
ssql = ssql &"("& session("user_id")&",'"& acao &"','"& data&"')"
conn.execute(ssql)

response.redirect "sel_cad_empresa.asp?msg=1"
%>