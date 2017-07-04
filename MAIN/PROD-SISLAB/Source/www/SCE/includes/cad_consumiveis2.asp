<!--#include file="includes/abre.asp"-->
<%ssql = "insert into sce_consumiveis (con_descricao,tic_id) values "
ssql = ssql &"('"& request("descricao") &"',"& request("tic_id") &")"
conn.execute(ssql)
response.redirect "cad_consumiveis.asp?msg=1"%>