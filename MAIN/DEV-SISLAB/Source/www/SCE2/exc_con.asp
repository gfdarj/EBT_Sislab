<!-- #INCLUDE FILE="includes/abre.asp" -->
<%ssql = "delete from sce_consumiveis where con_id = "& request("con_id")
conn.execute(ssql)
response.redirect "alt_con.asp?msg=2"%> 