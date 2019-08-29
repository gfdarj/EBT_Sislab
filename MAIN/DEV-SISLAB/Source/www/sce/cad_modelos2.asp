<!------- SCE ------->
<!------- SISLAB ---->
<!--#include file="../includes/Sislab_Lib.asp"-->
<% 
Dim p_number, mod_codnome, mod_obs, fab_id, tipo_id, sgp, au_id

p_number    = Trim(UCASE(Request("p_number")))
au_id       = Request("au_id")
mod_codnome	= trim(replace(request.form("mod_codnome"), "'", "&#39;"))
mod_obs			= trim(replace(request.form("mod_obs"), "'", "&#39;"))
fab_id			= trim(replace(request.form("fab_id"), "'", "&#39;"))
tipo_id			= trim(replace(request.form("tipo_id"), "'", "&#39;"))
sgp			= trim(replace(request.form("sgp"), "'", "&#39;"))
if tipo_id = "" then tipo_id = "NULL"
if sgp = "" then sgp = "NULL"
if fab_id = "" then fab_id = "NULL"
if au_id = "" then au_id = "NULL"
if p_number = "" Then p_number = "NULL" Else p_number = "'" & p_number & "'"


strSql = " SELECT mod_partnumber FROM sce_modelos " &_
		 " WHERE mod_partnumber IS NOT NULL AND mod_partnumber = " & p_number 

Set rsPartnumber = Env.oconn.execute(strSql)

If rsPartnumber.eof Then
	ssql = "insert into sce_modelos (mod_codnome, fab_id, tipo_id, mod_net, mod_obs, sgp, cod_sgp, mod_descricao, mod_partnumber, au_id) values "
	ssql = ssql &"('"& mod_codnome &"',"& fab_id &","& tipo_id &",'"& request("mod_net") &"',"
	ssql = ssql &"'"& replace(replace(replace(request("mod_obs"),"'","&acute;"),"""","&quot;"),chr(13),"<br>") &"',"
	ssql = ssql & sgp &",'"& request("cod_sgp") & "','" & replace(replace(replace(request("mod_descricao"),"'","&acute;"),"""","&quot;"),chr(13),"<br>") & "', "
    ssql = ssql & p_number & ", " & au_id & ")"
	'response.write ssql
	'response.end
	Env.oconn.execute(ssql)

	acao = "O usuário "& Env.Usuario &" cadastrou o modelo "& mod_codnome
    Call Env.LogSce(acao)

	response.redirect "cad_modelos.asp?msg=1"	
Else
    response.redirect "cad_modelos.asp?msg=2"
End If
%>