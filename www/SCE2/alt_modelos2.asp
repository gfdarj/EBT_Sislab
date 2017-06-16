<!------- SISLAB ---->
<!--#include file="../includes/Sislab_Lib.asp"-->
<% 
mod_codnome	= trim(ucase(request.form("mod_codnome")))
mod_obs		= trim(ucase(request.form("mod_obs")))
fab_id		= request.form("fab_id")
tipo_id		= request.form("tipo_id")
sgp			= request.form("sgp")
if tipo_id = "" then tipo_id = 0
if sgp = "" then sgp = 0
if fab_id = "" then fab_id = 0

ssql = "update sce_modelos set mod_codnome = '"& mod_codnome &"', fab_id = "& fab_id &","
ssql = ssql &"tipo_id = "& tipo_id &", mod_net = '"& request("mod_net") &"',"
ssql = ssql &"mod_obs='"& replace(replace(mod_obs,"'","&#39;"),"""","&quot;") &"',"
ssql = ssql &"sgp = "& sgp &", cod_sgp = '"& request("cod_sgp") &"',"
ssql = ssql &"mod_descricao = '"& replace(replace(ucase(request("mod_descricao")),"'","&#39;"),"""","&quot;") &"' "
ssql = ssql &"where mod_id = "& request("mod_id")
'response.write ssql
'response.end
Env.oconn.execute(ssql)
if request("p_number") <> "" then
	ssql = "select id from sce_partnumbermodelo where mod_id = "& request("mod_id")
	set rec = Env.oconn.execute(ssql)
	if not rec.eof then
		ssql = "update sce_partnumbermodelo set pn_partnumber = '"& request("p_number") &"' "
		ssql = ssql &"where id = "& rec("id")
		Env.oconn.execute(ssql)
	end if
end if
if request("au_id") <> "" then
	ssql = "select id from sce_areasutil_modelo where mod_id = "& request("mod_id")
	set rec = Env.oconn.execute(ssql)
	if not rec.eof then
		ssql = "update sce_areasutil_modelo set au_id = "& request("au_id") &" "
		ssql = ssql&"where id = "& rec("id")
		Env.oconn.execute(ssql)
	end if
end if

acao = "O usuário "& Env.Usuario &" atualizou o modelo "& request("mod_codnome") &" de código "& request("mod_id")
Call Env.LogSce(acao)

response.redirect "sel_cad_modelo.asp?msg=1"
%>