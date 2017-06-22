<!-- #include file="../includes/global.asp" -->   <!-- constantes usada pelo menu -->
<!--#include file="includes/padraoHTML.asp"-->
<!-- #INCLUDE FILE="includes/abre.asp" -->
<%
call ImprimeCabecalho ("", MENU_ON, true, "Edição de Modelos", "", "history.go(-1);")

Dim ssql, rec, where
%>
<table width="100%">	
	<tr>
		<td>
<%
ssql =	"select distinct m.mod_id, m.mod_descricao, f.fab_id, m.mod_codnome, f.fab_nome, pn.pn_partnumber " & _
			"from sce_fabricantes f inner join sce_modelos m on f.fab_id = m.fab_id " & _
			"left join sce_partnumbermodelo pn on pn.mod_id = m.mod_id " & _
			"where "
where = ""
if request("partnumber") <> "" then
	where = "pn.pn_partnumber Like '%"& request("partnumber") &"%' "
end if

if request("modelo") <> "" then
	if where <> "" then where = where & " and "
	where = where & "m.mod_codnome Like '%"& request("modelo") &"%' "
end if

if request("fab_id") <> "" then
	if where <> "" then where = where & " and "
	where = where & "m.fab_id = " & request("fab_id") &" "
end if

if request("descricao") <> "" then
	if where <> "" then where = where & " and "
	where = where & "m.mod_descricao Like '%" & request("descricao") &"%' "
end if

ssql = ssql & where & "order by mod_codnome, fab_nome"
'response.write ssql
'response.end
set rec = conn.execute(Ssql)

'-- se achou 1 registro pulo direto para a edicao do mesmo
if rec.recordcount = 1 then
	response.redirect "alt_modelos.asp?mod_id=" & rec("mod_id")
else%>
			<table width="100%">
			<tr>
				<td class="titulo" align="center"><%=rec.recordcount%> modelo(s) encontrado(s)</td>
			</tr>
			<tr><td class="texto">&nbsp;</td></tr>
			</table>
			
			<table width="600px" border="1" align="center" cellpadding="0" cellspacing="0"><%
		if not (rec.eof and rec.bof) then%>
			<tr class="texto" bgcolor="#C0E0EF">
				<th>Modelo</th>
				<th>Fabricante</th>
				<th>Descri&ccedil;&atilde;o</th>
				<th>Part Number</th>
			</tr>
<%			while not rec.eof%>
			<tr class="texto" bgcolor="#C0E0EF">
				<td><a href=alt_modelos.asp?mod_id=<%=rec("mod_id")%>><%=rec("mod_codnome")%></a></td>
				<td><%if isnull(rec("fab_nome")) then response.write "&nbsp;" else response.write rec("fab_nome")%></td>
				<td><%if isnull(rec("mod_descricao")) then response.write "&nbsp;" else response.write rec("mod_descricao") end if%></td>
				<td><%if isnull(rec("pn_partnumber")) then response.write "&nbsp;" else response.write rec("pn_partnumber") end if%></td>
			</tr>
<%				rec.MoveNext
			wend
		end if%>
			</table><%
end if
rec.close
set rec = nothing
%>
		</td>
	</tr>
	<tr class="texto"><td>&nbsp;</td></tr>
	<tr><td align="center"><input type="button" class="form" value="Voltar" onclick="javascript:history.go(-1);"></td></tr>
</table>
</form>
<br>
<%
conn.close
set conn=nothing
call ImprimeRodape (RODAPE_OFF)
%>
