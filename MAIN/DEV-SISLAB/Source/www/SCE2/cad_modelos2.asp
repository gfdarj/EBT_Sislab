<!------- SCE ------->
<!------- SISLAB ---->
<!--#include file="../includes/Sislab_Lib.asp"-->
<% 
mod_codnome	= trim(replace(request.form("mod_codnome"), "'", "&#39;"))
mod_obs			= trim(replace(request.form("mod_obs"), "'", "&#39;"))
fab_id			= trim(replace(request.form("fab_id"), "'", "&#39;"))
tipo_id			= trim(replace(request.form("tipo_id"), "'", "&#39;"))
sgp			= trim(replace(request.form("sgp"), "'", "&#39;"))
if tipo_id = "" then tipo_id = 0
if sgp = "" then sgp = 0
if fab_id = "" then fab_id = 0

strSql = " SELECT pn_partnumber FROM SCE_PARTNUMBERMODELO" &_
		 " WHERE pn_partnumber = '" & trim(replace(request.form("p_number"), "'", "&#39;")) & "'"

set rsPartnumber = Env.oconn.execute(strSql)

if rsPartnumber.eof then
	ssql = "insert into sce_modelos (mod_codnome,fab_id,tipo_id,mod_net,mod_obs,sgp,cod_sgp,mod_descricao) values "
	ssql = ssql &"('"& mod_codnome &"',"& fab_id &","& tipo_id &",'"& request("mod_net") &"',"
	ssql = ssql &"'"& replace(replace(replace(request("mod_obs"),"'","&acute;"),"""","&quot;"),chr(13),"<br>") &"',"
	ssql = ssql & sgp &",'"& request("cod_sgp") &"','"& replace(replace(replace(request("mod_descricao"),"'","&acute;"),"""","&quot;"),chr(13),"<br>") &"')"
	'response.write ssql
	'response.end
	Env.oconn.execute(ssql)

	ssql = "select mod_id from sce_modelos order by mod_id desc"
	set rec = Env.oconn.execute(ssql)
	if request("p_number") <> "" then
		ssql = "insert into sce_partnumbermodelo (mod_id,pn_partnumber) values "
		ssql = ssql &"("& rec("mod_id") &",'"& request("p_number") &"')"
		Env.oconn.execute(ssql)
	end if

	if request("au_id") <> "" then
		ssql = "insert into sce_areasutil_modelo (mod_id,au_id) values "
		ssql = ssql &"("& rec("mod_id") &",'"& request("au_id") &"')"
		Env.oconn.execute(ssql)
	end if

	acao = "O usuário "& Env.Usuario &" cadastrou o modelo "& mod_codnome
    Call Env.LogSce(acao)

	response.redirect "cad_modelos.asp?msg=1"	
else
    response.redirect "cad_modelos.asp?msg=2"
End if
%>