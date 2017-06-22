<!--#include file="../includes/global.asp" -->   <!-- constantes usada pelo menu -->
<!--#include file="includes/padraoHTML.asp"-->
<!--#include file="includes/abre.asp"-->
<%
call ImprimeCabecalho ("", MENU_ON, true, "Relatório de Calibragem", "", "history.go(-1);")
%>
<table width="100%">
	<tr class="texto"><td>&nbsp;</td></tr>
</table>

<p class="texto">
Estamos construindo esta nova funcionalidade
</p>

<%
conn.close
set conn=nothing

call ImprimeRodape (RODAPE_OFF)

response.end
%>

<script language="javascript">
function ValidaCampos()
{
	var frm = document.formulario;
	if (frm.enf_nome.value.length == 0)
	{
		alert("Defina o Nome da Empresa!");
		frm.enf_nome.focus()
		return false;
	}
	return true;
}
</script>
<div align="center">
<table width="780" >	
	<tr>
		<td ><!--#include file="includes/menu_rel.asp"--></td>
	</tr>
   <tr>
	    <td class="titulo">Relatórios de Itens que devem ser Calibrados</td>
  	</tr>
	<tr>
	    <td class="titulo" valign="top" align="center">
	<%
	server.scripttimeout = "99999"
			var = "Calib"
			ssql= "select top 1 no_id from sce_natureza_operacao where no_descricao like '%"& var &"%'"
			set rec = conn.execute(ssql)
			if not rec.eof then
				no_id = rec("no_id")
			else
				no_id = 0
			end if
			ssql = "select eq_id,eq_codigobarras,status,eq_calibracao from sce_equipamentos order by eq_calibracao"
			set rec = conn.execute(ssql)
			if not rec.eof then%>
				<table >
				<%while not rec.eof
					if rec("status") <> 1 and no_id <> 0 then
						ssql = "select top 1 mov_data,prazo,mov_id from sce_movimentacao where no_id = "& no_id &" and eq_id = "& rec("eq_id") &" and reserva = 0 order by mov_data desc"
						set rec2 = conn.execute(ssql)
						if not rec2.eof then
							'response.end
							cdate(data = rec2("mov_data"))
							prazo = rec2("prazo")
							if trim(prazo) <> "" and trim(data) <> "" then
								p = dateadd("d",data,prazo)
								data2 = year(now)&"/"&right(month(now)+100,2)&"/"&right(day(now)+100,2)&" "&right(hour(now)+100,2)&":"&right(minute(now)+100,2)&":"&right(second(now)+100,2)
								p2 = datediff("d",p,data2)
								if p2<0 then
									p2 = datediff("d",data2,p)
								end if
								if p2<=21 then
									a = 1%>
									<tr>
										<td class=texto>
											&nbsp;
										</td>
									</tr>
									<tr>
										<td class=texto valign="top">
											<a href=calibracao.asp?eq_id=<%=rec("eq_id")%>&mov_id=<%=rec2("mov_id")%>><%=rec("eq_codigobarras")%></a>
										</td>
									</tr>
								<%end if
							end if
						else
							calibracao = rec("eq_calibracao")
							if calibracao = "0" then calibracao = 30
						'	response.end
							ssql = "select top 1 mov_data,prazo,mov_id from sce_movimentacao where eq_id = "& rec("eq_id") &" order by mov_data asc"
							set rec2 = conn.execute(ssql)
							if not rec2.eof then
								p = dateadd("d",calibracao,rec2("mov_data"))
								data2 = year(now)&"/"&right(month(now)+100,2)&"/"&right(day(now)+100,2)&" "&right(hour(now)+100,2)&":"&right(minute(now)+100,2)&":"&right(second(now)+100,2)
								p2 = datediff("d",p,data2)
								if p2<0 then
									p2 = datediff("d",data2,p)
								end if
								if p2<=21 then
									a = 1%>
									<tr>
										<td class=texto>
											&nbsp;
										</td>
									</tr>
									<tr>
										<td class=texto valign="top">
											<a href=calibracao.asp?eq_id=<%=rec("eq_id")%>><%=rec("eq_codigobarras")%></a>
										</td>
									</tr>
								<%end if
							end if
						end if
					else
						calibracao = rec("eq_calibracao")
						if calibracao = "0" then calibracao = 30
						ssql = "select top 1 mov_data,prazo,mov_id from sce_movimentacao where eq_id = "& rec("eq_id") &" order by mov_data asc"
						set rec2 = conn.execute(ssql)
						if not rec2.eof then
'							p = dateadd("d",calibracao,rec2("mov_data"))
							data2 = year(now)&"/"&right(month(now)+100,2)&"/"&right(day(now)+100,2)&" "&right(hour(now)+100,2)&":"&right(minute(now)+100,2)&":"&right(second(now)+100,2)
							p2 = datediff("d",p,data2)
							if p2<0 then
								p2 = datediff("d",data2,p)
							end if
							if p2<=21 then
								a = 1%>
								<tr>
									<td class=texto>
										&nbsp;
									</td>
								</tr>
								<tr>
									<td class=texto valign="top">
										<a href=calibracao.asp?eq_id=<%=rec("eq_id")%>><%=rec("eq_codigobarras")%></a>
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
						<td class=texto valign="top">
							Nenhum ítem para calibração no prazo de 21 dias
						</td>
					</tr>
				<%end if%>
				</table>
			<%else%>
				<table height="300">
					<tr>
						<td class=texto>
							&nbsp;
						</td>
					</tr>
					<tr>
						<td class=texto valign="top">
							Nenhum ítem para calibração no prazo de 21 dias
						</td>
					</tr>
				</table>
			<%end if%>
