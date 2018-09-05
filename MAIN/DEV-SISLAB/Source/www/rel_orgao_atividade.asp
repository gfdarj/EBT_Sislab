<!--#include file="includes/Sislab_Lib.asp"-->
<!-- #include file="includes/PadraoHTML.asp" -->
<!-- #include file="includes/global.asp" -->
<!-- #include file="includes/controleshtml.asp" -->
<!-- #include file="includes/funcoes.asp" -->
<%
dim col : col = 0							'-- coluna atual
dim total_colunas : total_colunas = 0		'-- total de colunas (atividades)
dim total_org : total_org = 0				'-- total por orgao
dim total_geral : total_geral = 0			'-- total geral
dim ehRepetido : ehRepetido = True			'-- indica a repeticao de um orgao

dim nome_coluna(), total_por_coluna()		'-- arrays com os nomes e totais por coluna

dim objRS, s, orgao

'-- chamado pelo index.asp
if request("index") = "1" then
	call ImprimeCabecalho2("", MENU_OFF, false, "100%", "Relatório de Órgão por Atividade", "SO_IMPRESSORA", "")
else
	call ImprimeCabecalho2(TITULO_SITE, MENU_ON, true, "", "Relatório de Órgão por Atividade", "", "")
end if
%>
<table class="texto1" border="1" width="100%" cellpadding="2" cellspacing="0" style="border: thin solid #000000;">
<tr class="realce">
	<th>&Oacute;rg&atilde;o / Tipo Atividade</th>
<%
s = "SELECT * FROM Tipo_Atividade ORDER BY TA_DESCRICAO"
call Env.Recordset(true, objRS, s)
if not (objRS.Eof and objRS.Bof) then
	Redim preserve nome_coluna(objRS.recordcount)
	Redim preserve total_por_coluna(objRS.recordcount)

	while not objRS.Eof
		total_colunas = total_colunas + 1
		nome_coluna(total_colunas) = ucase(objRS("TA_DESCRICAO"))%>

	<th><%=ucase(objRS("TA_DESCRICAO"))%></th>

<%		objRS.MoveNext
	wend%>
	<th>TOTAL</th><%
end if
call Env.Recordset(false, objRS, null)
%>
</tr>

<%
s = "SELECT * FROM vw_Total_Orgao_Atividade ---- WHERE AG_ORGAO <> '' OR AG_ORGAO IS NOT NULL"
call Env.Recordset(true, objRS, s)
if not (objRS.Eof and objRS.Bof) then
	while not objRS.Eof%>
<tr>
<%		total_org = 0
		orgao = objRS("AG_ORGAO")
		ehRepetido = True%>

	<td><%if not IsNull(orgao) then response.write orgao else response.write "nulo"%>&nbsp;</td>

<%		while (ehRepetido) and (not objRS.Eof)
			total_org = total_org + objRS("TOTAL_POR_ATIVIDADE")
			call SomaColunas(objRS("TOTAL_POR_ATIVIDADE"), objRS("TA_DESCRICAO"))%>

	<td align="right"><%=objRS("TOTAL_POR_ATIVIDADE")%>&nbsp;</td>

<%			objRS.MoveNext
			if not objRS.Eof then
				if orgao <> objRS("AG_ORGAO") then
					ehRepetido = False
					objRS.MovePrevious
				end if
			end if
		wend%>

	<td align="right"><%=total_org%></td>
</tr>

<%		total_geral = total_geral + total_org
		if not objRS.Eof then objRS.MoveNext
	wend
else%>
<tr><td colspan="<%=total_colunas + 2%>" align="center"><i>Nenhum registro encontrado</i></td></tr><%
end if
call Env.Recordset(false, objRS, null)
%>
<tr class="realce">
	<td><b>TOTAL</b></td>
<%
for col = 1 to total_colunas
	Response.write "<td align='right'><b>" & total_por_coluna(col) & "</b>&nbsp;</td>"
next
%>
	<td align="right"><b><%=total_geral%></b></td>
</tr>

</table>
<%
if request("index") = "1" then
	Call imprimeRodape(RODAPE_OFF)
else
	Call imprimeRodape(RODAPE_ON)
end if


'---------------------------------------------------------------------------------------------
'-- Procuro pelo nome da coluna para achar o indice correto do array que guardo
'-- o somatorio por coluna
'---------------------------------------------------------------------------------------------
Sub SomaColunas(valor, coluna)
	for col = 1 to total_colunas
		if nome_coluna(col) = ucase(coluna) then _
			total_por_coluna(col) = total_por_coluna(col) + valor
	next
End Sub
%>
