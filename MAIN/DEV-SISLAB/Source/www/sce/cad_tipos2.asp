<!------- SCE ------->
<!------- SISLAB ---->
<!--#include file="../includes/Sislab_Lib.asp"-->
<%
tipo_supertipo = trim(replace(request.form("super_tipo"), "'", "&#39;"))
if tipo_supertipo = "" then tipo_supertipo = 0
tipo_descricao = trim(replace(request.form("tipo_descricao"), "'", "&#39;"))

strSql = " SELECT * FROM SCE_TIPOS  " &_
		 " WHERE tipo_descricao = '" & tipo_descricao  & "'"
set rsTipo = Env.oconn.execute(strSql)

if rsTipo.eof then
	sgp = trim(replace(request("sgp"), "'", "&#39;"))
	if sgp = "" then sgp = 0
	ssql = "insert into sce_tipos (tipo_supertipo,tipo_descricao) values "
	ssql = ssql&"("& tipo_supertipo &",'"& tipo_descricao &"')"
	Env.oconn.execute(ssql)

	acao = "O usuário "& Env.Usuario &" cadastrou a família tipo "& tipo_descricao
    Call Env.LogSCE(acao)

	response.redirect "cad_tipos.asp?msg=1"
else
	response.redirect "cad_tipos.asp?msg=2"	
end if
%>