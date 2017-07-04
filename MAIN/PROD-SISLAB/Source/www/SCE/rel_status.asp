<!-- #INCLUDE FILE="includes/abre.asp" -->


<!--#include file="interface_s.inc"-->
<%' on error resume next%>

<div align="center">
<table width="780" >	
	<tr>
		<td ><!--#include file="includes/menu_rel.asp"--></td>
	</tr>
   <tr>
	    <td class="titulo" valign="top">Relatórios de Itens para manutenção<br><br>
	<%
	server.scripttimeout = "99999"
			var = "Manu"
			ssql= "select no_id from sce_natureza_operacao where no_descricao like '%"& var &"%'"
			set rec = conn.execute(ssql)
			if not rec.eof then
				no_id = rec("no_id")
			else
				no_id = 0
			end if
			ssql = "select * from sce_equipamentos order by eq_manutencao"
			set rec = conn.execute(ssql)
			if not rec.eof then%>
				<table align="center" >
				<%while not rec.eof
					if rec("status") <> 1 and no_id <> 0 then
						ssql = "select * from sce_movimentacao where no_id = "& no_id &" and eq_id = "& rec("eq_id") &" and reserva = 0 order by mov_data desc"
						set rec2 = conn.execute(ssql)
						if not rec2.eof then
							data = cdate(rec2("mov_data"))
							prazo = rec2("prazo")
							if trim(prazo) <> "" and trim(data) <> "" then
								p = dateadd("d",data,prazo)
								data2 = year(now)&"/"&right(month(now)+100,2)&"/"&right(day(now)+100,2)&" "&right(hour(now)+100,2)&":"&right(minute(now)+100,2)&":"&right(second(now)+100,2)
								p2 = datediff("d",p,data2)
								if p2<0 then
									p2 = datediff("d",data2,p)
								end if
								if p2<=21 then
									a=1%>
									<tr>
										<td class=texto>
											&nbsp;
										</td>
									</tr>
									<tr>
										<td class=texto>
											<a href=manutencao.asp?eq_id=<%=rec("eq_id")%>&mov_id=<%=rec2("mov_id")%>><%=rec("eq_codigobarras")%></a>
										</td>
									</tr>
								<%end if
							end if
						else
							calibracao = rec("eq_manutencao")
							if calibracao = "0" then calibracao = 30
							ssql = "select * from sce_movimentacao where eq_id = "& rec("eq_id") &" order by mov_data asc"
							set rec2 = conn.execute(ssql)
							if not rec2.eof then
								p = dateadd("d",calibracao,rec2("mov_data"))
								data2 = year(now)&"/"&right(month(now)+100,2)&"/"&right(day(now)+100,2)&" "&right(hour(now)+100,2)&":"&right(minute(now)+100,2)&":"&right(second(now)+100,2)
								p2 = datediff("d",p,data2)
								if p2<0 then
									p2 = datediff("d",data2,p)
								end if
								if p2<=21 then
									a=1%>
									<tr>
										<td class=texto>
											&nbsp;
										</td>
									</tr>
									<tr>
										<td class=texto>
											<a href=manutencao.asp?eq_id=<%=rec("eq_id")%>><%=rec("eq_codigobarras")%></a>
										</td>
									</tr>
								<%end if
							end if
						end if
					else
						calibracao = rec("eq_manutencao")
						if calibracao = "0" then calibracao = 30
						ssql = "select * from sce_movimentacao where eq_id = "& rec("eq_id") &" order by mov_data asc"
						set rec2 = conn.execute(ssql)
						if not rec2.eof then
							p = dateadd("d",calibracao,rec2("mov_data"))
							data2 = year(now)&"/"&right(month(now)+100,2)&"/"&right(day(now)+100,2)&" "&right(hour(now)+100,2)&":"&right(minute(now)+100,2)&":"&right(second(now)+100,2)
							p2 = datediff("d",p,data2)
							if p2<0 then
								p2 = datediff("d",data2,p)
							end if
							if p2<=21 then
								a=1%>
								<tr>
									<td class=texto>
										&nbsp;
									</td>
								</tr>
								<tr>
									<td class=texto>
										<a href=manutencao.asp?eq_id=<%=rec("eq_id")%>><%=rec("eq_codigobarras")%></a>
									</td>
								</tr>
							<%end if
						end if
					end if
					rec.movenext
				wend
				if a <> 1 then%>
					<tr>
						<td class=texto>
							&nbsp;
						</td>
					</tr>
					<tr>
						<td class=texto>
							Nenhum ítem para manutenção no prazo de 21 dias
						</td>
					</tr>
				<%end if%>
				</table>
			<%else%>
				<table>
					<tr>
						<td class=texto>
							&nbsp;
						</td>
					</tr>
					<tr>
						<td class=texto>
							Nenhum ítem para manutenção no prazo de 21 dias
						</td>
					</tr>
				</table>
			<%end if%>
<!--#include file="interface_i.inc"-->
