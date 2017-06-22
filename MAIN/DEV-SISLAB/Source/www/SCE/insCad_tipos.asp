<!--#include file="includes\abre.asp"-->

<% 
tipo_supertipo		= trim(replace(request.form("super_tipo"), "'", "&#39;"))
if tipo_supertipo = "" then tipo_supertipo = 0
tipo_descricao		= trim(replace(request.form("tipo_descricao"), "'", "&#39;"))

	strSql = " SELECT * FROM SCE_TIPOS  " &_
			 " WHERE tipo_descricao = '" & tipo_descricao  & "'"
	
	set rsTipo = conn.execute(strSql)
	
	if rsTipo.eof then
	
 
		sgp = trim(replace(request("sgp"), "'", "&#39;"))
		if sgp = "" then sgp = 0
		ssql = "insert into sce_tipos (tipo_supertipo,tipo_descricao) values "
		ssql = ssql&"("& tipo_supertipo &",'"& tipo_descricao &"')"
		conn.execute(ssql)
		ssql = "select user_nome from sce_usuarios where user_id = "& session("user_id")
			set reco = conn.execute(ssql)
			acao = "O usuário "& reco("user_nome") &" cadastrou a família tipo "& tipo_descricao &"."
			data = year(now)&"/"&right(month(now)+100,2)&"/"&right(day(now)+100,2)&" "&right(hour(now)+100,2)&":"&right(minute(now)+100,2)&":"&right(second(now)+100,2)
			ssql = "insert into sce_historico (id_usuario,acao,data) values ("& session("user_id")&",'"& acao &"','"& data&"')"
			conn.execute(ssql)
		response.redirect "cad_tipos.asp?msg=1"
		
	else
	
		response.redirect "cad_tipos.asp?msg=2"
	
	end if
%>