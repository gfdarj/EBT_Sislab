<!--#include file="includes/Sislab_Lib.asp"-->
<!-- #include file="includes/PadraoHTML.asp" -->
<!-- #include file="includes/global.asp" -->
<!-- #include file="includes/controleshtml.asp" -->
<!-- #include file="includes/funcoes.asp" -->
<%
dim total_geral : total_geral = 0			'-- total geral

dim objRS, s, tecnologia

'-- indica se foi chamado a partir do index
if request("index") = "1" then
	call ImprimeCabecalho2("", MENU_OFF, false, "100%", "Relatório de Tecnologias por Fabricante", "SO_IMPRESSORA", "")
else
	call ImprimeCabecalho2(TITULO_SITE, MENU_ON, true, "", "Relatório de Tecnologias por Fabricante", "", "")
end if
%>
<table class="texto1" border="1" width="100%" cellpadding="2" cellspacing="0" style="border: thin solid #000000;">
<tr class="realce">
	<th>TECNOLOGIA</th>
	<th>FABRICANTE</th>
	<th>SITUAÇÂO</th>
	<th>TOTAL</th>
</tr>
<%
s = "SELECT * FROM vw_Total_Tecnologia_Fabricante ---- WHERE FAB_DESCRICAO <> '' OR AG_ORGAO IS NOT NULL"
call Env.Recordset(true, objRS, s)
if not (objRS.Eof and objRS.Bof) then
	tecnologia = ""
	while not objRS.Eof%>
<tr>
	<td><%if tecnologia <> objRS("TEC_NOME") then response.write objRS("TEC_NOME")%>&nbsp;</td>
	<td><%=objRS("FAB_DESCRICAO")%>&nbsp;</td>
	<td><%=objRS("S_DESCRICAO")%>&nbsp;</td>
	<td align="right"><%=objRS("TOTAL_SITUACAO")%>&nbsp;</td>
</tr>
<%		tecnologia = objRS("TEC_NOME")
		total_geral = total_geral + objRS("TOTAL_SITUACAO")
		objRS.MoveNext
	wend%>
<tr class="realce"><th align="left" colspan="3">TOTAL</th><th align="right"><%=total_geral%></th></tr>
<%
else%>
<tr><td colspan="4" align="center"><i>Nenhum registro encontrado</i></td></tr><%
end if
call Env.Recordset(false, objRS, null)
%>
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
