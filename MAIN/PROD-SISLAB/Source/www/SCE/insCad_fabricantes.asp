<!--#include file="includes\abre.asp"-->
<%
cod = request("sgp")
if cod = "" then cod = 0
ssql = "insert into sce_fabricantes (cod_sgp,fab_pais,fab_nomefantasia,sgp) values "
ssql = ssql &"('"& request("cod_sgp") &"','"& request("fab_pais") &"','"& request("fab_nomefantasia") &"',"& cod &")"
conn.execute(ssql)
'response.write ssql
response.redirect "cad_fabricantes.asp?msg=1"%>
