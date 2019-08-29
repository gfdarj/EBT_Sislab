<!------- SISLAB ---->
<!--#include file="../includes/Sislab_Lib.asp"-->
<%
Dim p_number, mod_codnome, mod_obs, fab_id, tipo_id, sgp, au_id

p_number    = Trim(UCASE(Request("p_number")))
mod_codnome	= trim(ucase(request.form("mod_codnome")))
mod_obs		= trim(ucase(request.form("mod_obs")))
fab_id		= request.form("fab_id")
tipo_id		= request.form("tipo_id")
sgp			= request.form("sgp")
au_id       = Request("au_id")

if au_id = "" then au_id = "NULL"
if p_number = "" Then p_number = "NULL" Else p_number = "'" & p_number & "'"
if tipo_id = "" then tipo_id = 0
if sgp = "" then sgp = 0
if fab_id = "" then fab_id = 0

ssql = "UPDATE sce_modelos set mod_codnome = '"& mod_codnome &"', fab_id = "& fab_id &","
ssql = ssql &"tipo_id = "& tipo_id &", mod_net = '"& request("mod_net") &"',"
ssql = ssql &"mod_obs='" & replace(replace(mod_obs,"'","&#39;"),"""","&quot;") & "',"
ssql = ssql &"sgp = " & sgp & ", cod_sgp = '" & request("cod_sgp") &"',"
ssql = ssql &"mod_descricao = '" & replace(replace(ucase(request("mod_descricao")),"'","&#39;"),"""","&quot;") & "', "
ssql = ssql &"mod_partnumber = " & p_number & ", "
ssql = ssql &"au_id = " & au_id & " "
ssql = ssql &"where mod_id = " & request("mod_id")
'response.write ssql
'response.end
Env.oconn.execute(ssql)

acao = "O usuário "& Env.Usuario &" atualizou o modelo "& request("mod_codnome") &" de código "& request("mod_id")
Call Env.LogSce(acao)

response.redirect "sel_cad_modelo.asp?msg=1"
%>