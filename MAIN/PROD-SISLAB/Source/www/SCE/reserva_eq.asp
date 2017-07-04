<!--#include file="includes/abre.asp"-->
<%set rec = conn.execute(request("ssql"))%>
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
		Escolha um Item<br><br>
		<form action="reserva4.asp" method=post>
			<table width="500" cellpadding=0 cellspacing=1 bgcolor="#008080">
	  			<tr bgcolor="#c0c0c0"> 
				<td bgcolor="#C0E0EF" class="titulo" align="center">Fabricante</td>
				 
				 <td bgcolor="#C0E0EF" class="titulo" align="center">Modelo</td>
				 
			      <td bgcolor="#C0E0EF" class="titulo" align="center">Itens</td>
				 
				 <td bgcolor="#C0E0EF" class="titulo" align="center">Situação</td>
				 </tr>
				 <%if not rec.eof then
					 while not rec.eof
						fabricante = ""
						modelo = ""
					 	ssql = "select a.*, b.* from sce_modelos a, sce_fabricantes b where a.mod_id = "& rec("mod_id")&" and a.fab_id = b.fab_id"
								set rec2 = conn.execute(ssql)
								if not rec2.eof then
									modelo = rec2("mod_codnome")
									fabricante = rec2("fab_nome")
								end if
						select case rec("status")
							case 1
								status = "Em Estoque"
							case 2
								status = "Em Uso"
							case 3
								status = "Expedido"
						end select%>
						 <tr bgcolor="#c0c0c0"> 
						 <td bgcolor="#C0E0EF" class="texto" align="center"><input type=checkbox name=eq_id value="<%=rec("eq_id")%>"><%=fabricante%></td>
						 <td bgcolor="#C0E0EF" class="texto" align="center"><%=modelo%></td>
					      <td bgcolor="#C0E0EF" class="texto" align="center"><%=rec("eq_codigobarras")%></td>
						  <td bgcolor="#C0E0EF" class="texto" align="center"><%=status%></td>
						 </tr>
						 <%rec.movenext
					 wend
				end if%>
				
			 </table>		
		
		</td>
	</tr>
	<tr > 
       	<td class="texto" align="center"><br>
			<input type=submit value=" Escolher " class=form>&nbsp;&nbsp;
		</td>
	</tr>
	
	</table>
	</form>
</div>