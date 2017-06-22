<!--#include file="includes/abre.asp"-->
<%
if request("notafiscal") <>"" and request("enf_id") <> "" then
	ssql = "select nf_id from sce_nota_fiscal where enf_id = "& request("enf_id") &" and nf_numeronota = "& request("notafiscal")
	set rec = conn.execute(ssql)
	if not rec.eof then
		response.redirect "reserva2.asp?codbarras="&request("cod_barras")&"&modelo="&request("modelo")&"&numeroserie="&request("numeroserie")&"&nf_id="&rec("nf_id")&"&busca=1"
	else
		if request("nf_id") <> "" then response.redirect "mov_acessorio2.asp?codbarras="&request("cod_barras")&"&modelo="&request("modelo")&"&numeroserie="&request("numeroserie")&"&busca=1"
	end if
end if
if request("notafiscal") <>"" and request("enf_id") = "" then
	ssql = "select * from sce_nota_fiscal where nf_numeronota = "& request("notafiscal") &" order by enf_id"
	set rec = conn.execute(ssql)
end if
if request("notafiscal") ="" and request("enf_id") <> "" then
	ssql = "select * from sce_nota_fiscal where enf_id = "& request("enf_id") &" order by nf_numeronota"
	set rec = conn.execute(ssql)
end if
if request("notafiscal") ="" and request("enf_id") = "" then response.redirect "mov_acessorio2.asp?codbarras="&request("cod_barras")&"&modelo="&request("modelo")&"&numeroserie="&request("numeroserie")&"&busca=1"%>
<!--#include file="interface_s_rt.inc"-->
<div align="center">
   <table>
	<tr>
		<td width="780" class="titulo"><i>Reserva de Itens</i>&nbsp;>><a href="javascritp:history.back()">voltar</a><br><br><br><br></td>
	</tr>
    <tr valign="top">
	    <td class="titulo"><br><br></td>
	</tr>
	<tr valign="top">
	    <td class="titulo" align="center">
			<table width="500" cellpadding=0 cellspacing=1 bgcolor="#008080">
	  			<tr bgcolor="#c0c0c0"> 
			      <td bgcolor="#C0E0EF" class="titulo" align="center">Notas Encotradas</td>
				  <td bgcolor="#C0E0EF" class="titulo" align="center">Fornecedor</td>
				 </tr>
				 <%if not rec.eof then
					 while not rec.eof
					 	ssql = "select enf_nome from sce_empresa_nota_fiscal where enf_id = "& rec("enf_id")
						set rec2 = conn.execute(ssql)%>
						 <tr bgcolor="#c0c0c0"> 
					      <td bgcolor="#C0E0EF" class="texto" align="center"><a href="reserva2.asp?codbarras=<%=request("cod_barras")%>&modelo=<%=request("modelo")%>&numeroserie=<%=request("numeroserie")%>&nf_id=<%=rec("nf_id")%>&busca=1"><%=rec("nf_numeronota")%></a></td>
						  <td bgcolor="#C0E0EF" class="texto" align="center"><%=rec2("enf_nome")%></td>
						 </tr>
						 <%rec.movenext
					 wend
				else%>
				Não foi encontrada nenhuma nota fiscal com os parâmetros desejados.<br><br>
				<tr bgcolor="#c0c0c0"> 
			      <td bgcolor="#C0E0EF" class="texto" align="center">Se deseja voltar e fazer nova busca, clique <a href=# onclick="history.back();">aqui.</a></td>
				  <td bgcolor="#C0E0EF" class="texto" align="center">Se deseja continuar a busca de equipamentos, sem se importar com a nota fiscal, clique <a href=<%="mov_acessorio2.asp?codbarras="&request("codbarras")&"&modelo="&request("modelo")&"&numeroserie="&request("numeroserie")&"&busca=1"%>>aqui.</a></td>
				 </tr>
				<%end if%>
			 </table>		
		</td>
	</tr>
	</table>
</div>