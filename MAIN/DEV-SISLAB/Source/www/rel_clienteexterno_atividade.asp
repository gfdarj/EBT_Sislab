<!--#include file="includes/Sislab_Lib.asp"-->
<!--#include file="includes/PadraoHTML.asp" -->
<!--#include file="includes/global.asp" -->
<!--#include file="includes/controleshtml.asp" -->
<!--#include file="includes/funcoes.asp" -->
<%
dim col : col = 0							'-- coluna atual
dim total_colunas : total_colunas = 0		'-- total de colunas (atividades)
dim total_cliente : total_cliente = 0		'-- total por orgao
dim total_geral : total_geral = 0			'-- total geral
dim ehRepetido : ehRepetido = True			'-- indica a repeticao de um orgao

Dim nome_coluna(), total_por_coluna()		'-- arrays com os nomes e totais por coluna

Dim objRS, s, cliente

if request("index") = "1" then
	call ImprimeCabecalho2("", MENU_OFF, false, "100%", "Relatório de Clientes Externos por Atividade", "SO_IMPRESSORA", "")
else
	call ImprimeCabecalho2(TITULO_SITE, MENU_ON, true, "", "Relatório de Clientes Externos por Atividade", "", "")
end if
%>
<table class="texto1" border="1" width="100%" cellpadding="2" cellspacing="0" style="border: thin solid #000000;">
<tr class="realce">
	<th>Cliente Externo / Tipo Atividade</th>
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
s = "SELECT * FROM vw_total_Clienteexterno_Atividade ---- WHERE AG_CLIENTEEXTERNO <> '' OR AG_CLIENTEEXTERNO IS NOT NULL"
call Env.Recordset(true, objRS, s)
if not (objRS.Eof and objRS.Bof) then
	while not objRS.Eof%>
<tr>
<%		total_cliente = 0
		cliente = objRS("AG_CLIENTEEXTERNO")
		ehRepetido = True%>

	<td><%if not IsNull(cliente) then response.write cliente else response.write "nulo"%>&nbsp;</td>

<%		while (ehRepetido) and (not objRS.Eof)
			total_cliente = total_cliente + objRS("TOTAL_POR_ATIVIDADE")
			call SomaColunas(objRS("TOTAL_POR_ATIVIDADE"), objRS("TA_DESCRICAO"))%>

	<td align="right"><%=objRS("TOTAL_POR_ATIVIDADE")%>&nbsp;</td>

<%			objRS.MoveNext
			if not objRS.Eof then
				if cliente <> objRS("AG_CLIENTEEXTERNO") then
					ehRepetido = False
					objRS.MovePrevious
				end if
			end if
		wend%>

	<td align="right"><%=total_cliente%></td>
</tr>

<%		total_geral = total_geral + total_cliente
		if not objRS.Eof then objRS.MoveNext
	wend
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
