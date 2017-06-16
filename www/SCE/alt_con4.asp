<!-- #INCLUDE FILE="includes/abre.asp" -->
<%ssql = "update sce_consumiveis set con_desc = '"& request("descricao") &"', con_localizacao = '"& request("localizacao") &"', "
ssql = ssql &"con_obs = '"& replace(replace(replace(request("obs"),"'","&acute;"),"""","&quot;"),chr(13),"<br>") &"',"
ssql = ssql &" nf_id = "& request("nf_id") &" where con_id = "& request("con_id")
conn.execute(ssql)
response.redirect "alt_con.asp?msg=1"%> 