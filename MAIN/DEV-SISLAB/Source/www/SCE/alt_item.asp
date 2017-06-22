<%
'-- categoria = E equipamentos(itens)  ou  C consumiveis
Dim categoria
if trim(request("categoria")) = "" then categoria = "E" else categoria = request("categoria")
Response.redirect "cad_acess_item.asp?eq_id=" & request("eq_id") & "&categoria=" & categoria
%>
