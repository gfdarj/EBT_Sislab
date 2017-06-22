<!-- #INCLUDE FILE="includes/abre.asp" -->

<!--#include file="interface_s_rt.inc"-->
<script>
<!--#include file="includes/vform.js"-->
</script>
<center>
<%if instr(request("eq_id"),",") then
	vet = split(request("eq_id"),",")
	a = 0
	for i=0 to ubound(vet)
		ssql = "select * from sce_movimentacao where eq_id = "& vet(i) &" and reserva=1"
		set rec = conn.execute(ssql)
		if not rec.eof then a = 1
	next
	if a <> 1 then response.redirect "reserva5.asp?eq_id="& request("eq_id")&""
else
	ssql = "select * from sce_movimentacao where eq_id="& request("eq_id") &" and reserva=1"
	set rec = conn.execute(ssql)
	if rec.eof then response.redirect "reserva5.asp?eq_id= "& request("eq_id") &""
end if%>
  <table width="780">
	<tr>
		<td width="780" class="titulo"><i>Reserva de Itens</i>&nbsp;>><a href="javascritp:history.back()">voltar</a><br><br><br><br></td>
	</tr>
    <tr> 
		<td class="titulo">Item(s) Reservado(s)<br><br></td>
	</tr>
	
	<tr>
		<td valign="top" CLASS="texto"><br>
			<table cellpadding="14" cellspacing="0" align=center>
				<tr>
					<td valign="top" CLASS="texto">Fabricante
					</td>
					<td valign="top" CLASS="texto">Modelo
					</td>
					<td valign="top" CLASS="texto">Equipamento 
					</td>
					<td valign="top" CLASS="texto">Usuário
					</td>
					<td valign="top" CLASS="texto">Data de Pedido
					</td>
					<td valign="top" CLASS="texto">Data Prevista de Devolução
					</td>
					<td valign="top" CLASS="texto">Data de Recolhimento
					</td>
				</tr>
				<%
				if instr(request("eq_id"),",") then
					vet = split(request("eq_id"),",")
					for i=0 to ubound(vet)
						ssql = "select * from sce_movimentacao where eq_id = "& trim(vet(i)) &" and reserva=1 order by mov_data asc"
						set rec = conn.execute(ssql)
						while not rec.eof
							ssql= "select * from sce_equipamentos where eq_id = "& trim(vet(i)) 
							set rec2 = conn.execute(ssql)
							if not rec2.eof then
								eq = rec2("eq_codigobarras")
								ssql = "select a.*, b.* from sce_modelos a, sce_fabricantes b where a.mod_id = "& rec2("mod_id")&" and a.fab_id = b.fab_id"
								set rec2 = conn.execute(ssql)
								if not rec2.eof then
									modelo = rec2("mod_codnome")
									fabricante = rec2("fab_nome")
								end if
								ssql = "select * from sce_historico_reserva where mov_id = "& rec("mov_id")
								set rec2 = conn.execute(ssql)
								if not rec2.eof then
									data = rec("prazo")
									dat2 = mid(rec("mov_data"),9,2)&"/"&mid(rec("mov_data"),6,2)&"/"&left(rec("mov_data"),4)
									prazo = rec2("prazo")
									usuario = rec2("usuario")
									ssql = "select * from sce_usuarios where user_id = "& usuario
									set rec2 = conn.execute(ssql)
									usuario = rec2("user_nome")%>
									<tr>
										<td valign="top" CLASS="texto"><%=fabricante%>
									</td>
									<td valign="top" CLASS="texto"><%=modelo%>
									</td>
									<td valign="top" CLASS="texto"><%=eq%>
									</td>
									<td valign="top" CLASS="texto"><%=usuario%>
									</td>
									<td valign="top" CLASS="texto"><%=dat2%>
									</td>
									<td valign="top" CLASS="texto"><%data = dateadd("d",data,dat2)
									response.write data%>
									</td>
									<td valign="top" CLASS="texto"><%=prazo%>
									</td>
									</tr>
								<%end if
							end if
							rec.movenext
						wend
					next
				else
					ssql = "select * from sce_movimentacao where eq_id = "& request("eq_id") &" and reserva=1 order by mov_data asc"
					set rec = conn.execute(ssql)
					while not rec.eof
						ssql= "select * from sce_equipamentos where eq_id = "& request("eq_id") 
						set rec2 = conn.execute(ssql)
						if not rec2.eof then
						eq = rec2("eq_codigobarras")
						ssql = "select a.*, b.* from sce_modelos as a, sce_fabricantes as b where a.fab_id = b.fab_id and a.mod_id = "& rec2("mod_id")
						set rec2 = conn.execute(ssql)
						if not rec2.eof then
							modelo = rec2("mod_codnome")
							fabricante = rec2("fab_nome")
						end if
						ssql = "select * from sce_historico_reserva where mov_id = "& rec("mov_id")
						set rec2 = conn.execute(ssql)
						if not rec2.eof then
							usuario = rec2("usuario")
							data = rec("prazo")
							dat2 = mid(rec("mov_data"),9,2)&"/"&mid(rec("mov_data"),6,2)&"/"&left(rec("mov_data"),4)
							prazo = rec2("prazo")
							usuario = rec2("usuario")
							ssql = "select * from sce_usuarios where user_id = "& usuario
							set rec2 = conn.execute(ssql)
							usuario = rec2("user_nome")%>
							<tr>
								<td valign="top" CLASS="texto"><%=fabricante%>
								</td>
								<td valign="top" CLASS="texto"><%=modelo%>
								</td>
								<td valign="top" CLASS="texto"><%=eq%>
								</td>
								<td valign="top" CLASS="texto"><%=usuario%>
								</td>
								<td valign="top" CLASS="texto"><%=dat2%>
								</td>
								<td valign="top" CLASS="texto"><%data = dateadd("d",data,dat2)
								response.write data%>
								</td>
								<td valign="top" CLASS="texto"><%=prazo%>
								</td>
							</tr>
						<%end if
						end if
						rec.movenext
					wend
				end if%>
			</table>
		</td>
	</tr>
		
	<tr>
		<td valign="top" CLASS="texto"><br>
			<form name="formu" action="reserva5.asp?eq_id=<%=request("eq_id")%>" method=post>
			<input type=button value=" Voltar " class=form onclick="history.back();">&nbsp;&nbsp;<input type=button value=" Continuar Reserva " class=form onclick="document.formu.submit();"><br>
						</td>
					
	</tr>
	
 </table>
</form>

<!--#include file="interface_i.inc"-->
