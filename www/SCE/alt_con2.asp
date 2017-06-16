<!-- #include file="../includes/global.asp" -->   <!-- constantes usada pelo menu -->
<!--#include file="includes/padraoHTML.asp"-->
<!--#include file="includes/abre.asp"-->
<%
call ImprimeCabecalho ("", MENU_ON, true, "Consulta Consumível", "", "history.go(-1);")

ssql = "select a.* from sce_consumiveis a where 1=1"
if request("localizacao") <> "" then
	ssql = ssql &" and a.con_localizacao like '%"& request("localizacao") &"%'"
end if
'if request("enf_id") <> "" then
'	ssql = ssql &" and h.enf_id = "& request("enf_id")
'end if
'if request("notafiscal") <> "" then
'	ssql = ssql &" and h.nf_numeronota = "& request("notafiscal")
'end if
if request("descricao") <> "" then
	ssql = ssql &" and a.con_desc like '%"& request("descricao") &"%'"
end if
ssql = ssql & " order by a.con_desc"

'response.write ssql
'response.end
set rec = conn.execute(ssql)%>

<table width="100%">
	<%if not rec.eof then%>
    	<tr> 
	      <td align="center"  height="300" valign="top">
  			<table  cellpadding=0 cellspacing=0 align=center>
				<tr>
					<td class="texto" align="center" valign="top" width="200"><strong>Consumível</strong>
					</td>
					<td class="texto" align="center" valign="top" width="200"><strong>Localização</strong>
					</td>
				</tr>
				<%i = 0
				inicio = request("inicio")
				if inicio = "" or inicio = "1" then 
					inicio = 0
				else
					for cont = 0 to cint(inicio)*20
						rec.movenext
						if rec.eof then exit for
					next
				end if
				a = 0
				if not rec.eof then
					while not rec.eof
						i = i+1
						if i<=20 then
							a = 1%>
								<tr>
									<td class="texto" align="center" valign="top" width="200">
										<br><a href="alt_con3.asp?con_id=<%=rec("con_id")%>"><%=rec("con_desc")%></a>
									</td>
									<td class="texto" align="center" valign="top" width="200">
										<br><%=rec("con_localizacao")%>
									</td>
									<!-- td class="texto" align="center" valign="top" width="200">
										<br><a href="alt_con3.asp?con_id=<%'=rec("con_id")%>&fabricante=<%'=rec("enf_id")%>"><%'=rec("con_desc")%></a>
									</td>
									<td class="texto" align="center" valign="top" width="200">
										<br><%'=rec("enf_nome")%>
									</td>
									<td class="texto" align="center" valign="top" width="200">
										<br><%'=rec("nf_numeronota")%>
									</td -->
								</tr>
						<%end if
						rec.movenext
					wend%>
					</table>
					 
					<%if a <> 1 then%>
						<div class=texto><br><br>
								<strong>Nenhum consumível cadastrado.</strong>
							</td>
						</tr>
					<%end if
				end if%>
			
	<%else%>
		<tr>
			<td class="texto" align="center" height="300" valign="top">
				<strong>Nenhum consumivel cadastrado foi movimentado</strong>
			</td>
		</tr>
	<%end if%>
  </table>
  <div align=center class=texto><br><br><br>
  	<%cont = rec.recordcount/20
	cont = fix(cont)
	if cont>0 then response.write "Páginas:&nbsp;&nbsp;"
'	response.write cont
if inicio = 0 then inicio = 1
	if cont >=1 then
		for i=1 to cont
			if cint(inicio) <> i then%>
				&nbsp;<!--a href="rel_con.asp?inicio=<%=i%>"><%=i%></a-->
				&nbsp;<a href="alt_con2.asp?inicio=<%=i%>"><%=i%></a>
			<%else%>
				(<%=i%>)
			<%end if
		next
	end if%>
  </div>
  </td>
		</tr>
  </table>
<%
conn.close
set conn=nothing
call ImprimeRodape (RODAPE_OFF)
%>
