<!--#include file="includes/abre.asp"-->

<%
if request("busca") <> "" then
	if request("enf_id") <> "" or request("notafiscal") <> "" then response.redirect "reserva_nf.asp?codbarras="&request("codbarras")&"&modelo="&request("modelo")&"&numeroserie="&request("numeroserie")&"&enf_id="&request("enf_id")&"&notafiscal="&request("notafiscal")&""
	ssql = "select * from sce_equipamentos where 1=1 "
	if request("codbarras") <> "" then
		ssql = ssql &"and eq_codigobarras = '"& request("codbarras") &"' "
	end if
	if request("modelo") <> "" then
		ssql = ssql &"and mod_id = "& request("modelo") &" "
	end if
	if request("numeroserie") <> "" then
		ssql = ssql &"and eq_numeroserie = "& request("numeroserie") &" "
	end if
	if request("nf_id") <> ""  then 
		ssql = ssql &"and nf_id = "& request("nf_id") &" "
	end if
	set rec = conn.execute(ssql)
	mode = request("modelo")
	if mode = "" then mode = 0
	if rec.eof then 
		a = "a"
	else
		response.redirect "reserva_eq.asp?ssql="&ssql&""
	end if
end if
if rec.eof then%>
<!--#include file="interface_s_rt.inc"-->
<div align="center">
   <table>
	<tr>
		<td width="780" class="titulo"><i>Reserva de Itens</i>&nbsp;>><a href="#" onclick="javascritp:history.back()">voltar</a><br><br><br>
		<%if request("eq_id") = "" or a <> "" then 
			response.write "Nenhum item encontrado com estes parâmetros.<br>"
			response.end
		end if%><br></td>
	</tr>
<%end if%>