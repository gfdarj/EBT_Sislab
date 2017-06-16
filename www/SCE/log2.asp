<!--#include file="../includes/global.asp" -->   <!-- constantes usada pelo menu -->
<!--#include file="includes/padraoHTML.asp"-->
<!--#include file="includes/abre.asp"-->
<%
call ImprimeCabecalho ("", MENU_ON, true, "Histórico Geral", "", "history.go(-1);")
%>
<div align="center">
<table width="100%">
   <tr>
	    <td class="titulo">Listagem do Histórico<br><br></td>
  	</tr>

    	<tr> 
	      <td align="center"  height="300" valign="top">
  			<table  cellpadding=0 cellspacing=0 align=center>
			<%if request("nome") <> "" or request("username") <> "" then 
				ssql = "select * from sce_usuarios where 1 = 1 "
				if request("nome") <> "" then ssql = ssql &"and user_nome like '%"& request("nome") &"%' "
				if request("username") <> "" then ssql = ssql &"and user_login like '%"& request("username") &"%' "
				set rec2 = conn.execute(ssql)
				if not rec2.eof then%>
				<tr>
					<td class="texto" align="center" valign="top" width="100"><strong>Usuário</strong>
					</td>
					<td class="texto" align="center" valign="top" width="100"><strong>Data/Hora</strong>
					</td>
					<td class="texto" align="center" valign="top" width="500"><strong>Ação</strong>
					</td>
				</tr>
				<%
				while not rec2.eof
					ssql = "select * from sce_historico where id_usuario = "& rec2("user_id") &" order by data desc"
					set rec = conn.execute(ssql)
					if not rec.eof then
						i = 0
						inicio = request("inicio")
						if inicio = "" or inicio = "1" then 
							inicio = 0
						else
							for cont = 0 to (cint(inicio)-1)*20
								rec.movenext
								if rec.eof then exit for
							next
						end if
						if not rec.eof then
							while not rec.eof
								i = i+1
								if i<=20 then%>
									<tr>
										<td class="texto" align="center" valign="top" width="100">
										<br><%=rec2("user_nome")%></a>
									</td>
									<td class="texto" align="center" valign="top" width="100">
										<br><%=mid(rec("data"),9,2)&"/"&mid(rec("data"),6,2)&"/"&left(rec("data"),4)&" "&right(rec("data"),7)%>
									</td>
									<td class="texto" align="center" valign="top" width="500">
										<br><%=rec("acao")%>
									</td>
								</tr>
								<%end if
								rec.movenext
							wend
						end if
					end if
					rec2.movenext
				wend
				else%>
					<tr>
						<td class="texto" align="center" height="300" valign="top">
							<strong>Não existe Histórico com estes dados.</strong>
						</td>
					</tr>
				<%end if
			else
				ssql = "select * from sce_historico where 1=1 "
				if request("dia") <> "" and request("mes") <> "" and request("ano") <> "" then
					ssql = ssql&" and data like '%"& request("ano")&"/"&right(request("mes")+100,2)&"/"&right(request("dia")+100,2) &"%'"
				end if
				ssql = ssql &" order by id_usuario, data desc"
'			response.write ssql
	'			response.end
				set rec = conn.execute(ssql)
				if not rec.eof then%>
					<tr>
						<td class="texto" align="center" valign="top" width="100"><strong>Usuário</strong>
						</td>
						<td class="texto" align="center" valign="top" width="100"><strong>Data/Hora</strong>
						</td>
						<td class="texto" align="center" valign="top" width="500"><strong>Ação</strong>
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
					if not rec.eof then
						while not rec.eof
							i = i+1
							if i<=20  then
								ssql = "select * from sce_usuarios where user_id = "& rec("id_usuario")
								set rec2 = conn.execute(ssql)
								if not rec2.eof then%>
									<tr>
										<td class="texto" align="center" valign="top" width="100">
											<br><%=rec2("user_nome")%></a>
										</td>
										<td class="texto" align="center" valign="top" width="100">
											<br><%=mid(rec("data"),9,2)&"/"&mid(rec("data"),6,2)&"/"&left(rec("data"),4)&" "&right(rec("data"),8)%>
										</td>
										<td class="texto" align="center" valign="top" width="500">
											<br><%=rec("acao")%>
										</td>
									</tr>
								<%end if
							end if
							rec.movenext
						wend
					end if
				else%>
					<tr>
						<td class="texto" align="center" height="300" valign="top">
							<strong>Não existe Histórico com estes dados.</strong>
						</td>
					</tr>
				<%end if
			end if%>
			</table>
			<div align=center class=texto><br><br><br>
  	<%
	if isobject(rec) then
	cont = rec.recordcount/20
	cont = fix(cont)
	if cont>0 then response.write "Páginas:&nbsp;&nbsp;"
'	response.write cont
if inicio = 0 then inicio = 1
	if cont >=1 then
		for i=1 to cont
			if cint(inicio) <> i then%>
				&nbsp;<a href="log2.asp?inicio=<%=i%>&nome=<%=request("nome")%>&username=<%=request("username")%>&dia=<%=request("dia")%>&mes=<%=request("mes")%>&ano=<%=request("ano")%>"><%=i%></a>
			<%else%>
				(<%=i%>)
			<%end if
		next
	end if
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