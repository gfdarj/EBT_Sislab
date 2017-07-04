<!--#include file="includes/abre.asp"-->
<%
ssql = "select * from sce_empresa_nota_fiscal where enf_nome = '"& trim(replace(request("nome"), "'", "&#39;")) &"'"
set rec = conn.execute(ssql)
if not rec.eof then%>
	<html>
		<body>
			<script>
				alert('Empresa já existente!');
				history.back();
			</script>
		</body>
	</html>
	<%response.end
end if
cnpj = request("cnpj")
if cnpj <> "" then
	cnpj = replace(replace(replace(cnpj,".",""),"/",""),"-","")
	ssql = "select * from sce_empresa_nota_fiscal where enf_cnpj = '"& cnpj &"'"
	set rec = conn.execute(ssql)
	if not rec.eof then%>
		<html>
			<body>
				<script>
					alert('CNPJ já cadastrado!');
					history.back();
				</script>
			</body>
		</html>
		<%response.end
	end if
end if
cpf = request("enf_cpf")
if cpf <> "" then
	cpf = replace(replace(replace(cpf,".",""),"/",""),"-","")
	ssql = "select * from sce_empresa_nota_fiscal where enf_cpf = '"& cpf &"'"
	set rec = conn.execute(ssql)
	if not rec.eof then%>
		<html>
			<body>
				<script>
					alert('CPF já cadastrado!');
					history.back();
				</script>
			</body>
		</html>
		<%response.end
	end if
end if
uf = request("enf_uf")
if uf = "" then uf = "null"

ssql = "insert into sce_empresa_nota_fiscal (enf_observacao,enf_contato,enf_fax,enf_tel,"
ssql = ssql &"enf_cep,enf_uf,enf_cidade,enf_endereco,enf_cnpj,enf_cpf,enf_ie,enf_nome,enf_ddd,enf_ddd_fax,enf_email,enf_tipoempresa) values "
ssql = ssql &"('"& ucase(request("observacao")) &"',"
ssql = ssql &"'"& ucase(trim(replace(request("contato"), "'", "&#39;"))) &"','"& trim(replace(request("fax"), "'", "&#39;")) &"','"& trim(replace(request("tel"), "'", "&#39;")) &"','"& trim(replace(request("cep"), "'", "&#39;")) &"',"
ssql = ssql & uf &",'"& ucase(trim(replace(request("cidade"), "'", "&#39;"))) & "','" & trim(replace(ucase(request("endereco")), "'", "&#39;")) &"','"& cnpj &"','"& cpf &"',"
ssql = ssql &"'"& trim(replace(request("ie"), "'", "&#39;")) &"','"& trim(replace(ucase(request("nome")), "'", "&#39;")) &"','"& trim(replace(request("ddd"), "'", "&#39;")) &"','"& trim(replace(request("ddd_fax"), "'", "&#39;")) &"','"& trim(replace(request("email"), "'", "&#39;")) &"', '" & request("tipoempresa")  & "')"
'response.write ssql
'response.end
conn.execute(ssql)

ssql = "select user_nome from sce_usuarios where user_id = "& session("user_id")
set reco = conn.execute(ssql)
acao = "O usuário "& reco("user_nome") &" cadastrou a empresa "& trim(replace(request("nome"), "'", "&#39;")) &"."
data = year(now)&"/"&right(month(now)+100,2)&"/"&right(day(now)+100,2)&" "&right(hour(now)+100,2)&":"&right(minute(now)+100,2)&":"&right(second(now)+100,2)
ssql = "insert into sce_historico (id_usuario,acao,data) values ("& session("user_id")&",'"& acao &"','"& data&"')"
conn.execute(ssql)

response.redirect "cad_empresas.asp?msg=1"
%>
 