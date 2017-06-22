<!--#include file="includes/abre.asp"-->
<%ssql = "delete from sce_transportadora where trans_id = "& request("trans_id")
conn.execute(ssql)
response.redirect "sel_cad_transportadora.asp?msg=2"%>