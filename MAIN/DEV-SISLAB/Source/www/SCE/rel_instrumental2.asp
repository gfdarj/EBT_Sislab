<!-- #include file="../includes/global.asp" -->   <!-- constantes usada pelo menu -->
<!-- #include file="../includes/controlesXLS.asp" -->
<!--#include file="includes/padraoHTML.asp"-->
<!--#include file="includes/abre.asp"-->
<!--#include file="includes/bib_str.asp"-->
<!--#include file="includes/bib_bd.asp"-->
<%
'-- GERA UMA LISTAGEM DE EQUIPAMENTOS
'-- RELATORIO DE EQUIPAMENTOS/INSTRUMENTAIS

Dim bln_exportaExcel
Dim ssql, where, dt_ini, dt_fim, rec, recInst, cont, bg
Dim descricaoeq : descricaoeq = "Equipamento"

bln_exportaExcel = (Request("exportaExcel") = "S")

if request("diaIni") <> "" and request("mesIni") <> "" and request("anoIni") <> "" and _
	request("diaFim") <> "" and request("mesFim") <> "" and request("anoFim") <> "" then
	dt_ini = request("diaIni") & "/" & request("mesIni") & "/" & request("anoIni")
	dt_fim = request("diaFim") & "/" & request("mesFim") & "/" & request("anoFim")
else
	dt_ini = ""
	dt_fim = ""
end if

ssql =	""
where = ""

if request("instrumental") <> "" then
	if where <> "" then where = where & " AND "
	where = where &"EQ_INSTRUMENTAL = " & request("instrumental")
	descricaoeq = "Instrumental"
end if
if request("vencimento") <> "" then
	if where <> "" then where = where & " AND "
	where = where &"EQC_VENCIMENTO <= GETDATE() + " & request("vencimento") & " "
end if
if request("codbarras") <> "" then
	if where <> "" then where = where & " AND "
	where = where &"EQ_CODIGOBARRAS like '%"& trim(request("codbarras")) &"%' "
end if
if request("fabricante") <> "" then
	if where <> "" then where = where & " AND "
	where = where &"FAB_ID = " & request("fabricante") & " "
end if
if request("modelo") <> "" then
	if where <> "" then where = where & " AND "
	where = where &"MOD_CODNOME like '%"& trim(request("modelo")) &"%' "
end if
if request("desc_modelo") <> "" then
	if where <> "" then where = where & " AND "
	where = where &"MOD_DESCRICAO like '%"& trim(request("desc_modelo")) &"%' "
end if
if request("numeroserie") <> "" then
	if where <> "" then where = where & " AND "
	where = where &"EQ_NUMEROSERIE like '%" & trim(request("numeroserie")) &"%' "
end if
if request("conforme") <> "" then
	if where <> "" then where = where & " AND "
	where = where &"EQ_CONFORME = " & request("conforme") & " "
end if
if request("status") <> "" then
	if where <> "" then where = where & " AND "
	where = where &"STATUS = " & request("status") & " "
end if

If request("plataforma") <> "" Then
	if where <> "" then where = where & " AND "
	where = where & "EXISTS (SELECT plat.EQ_ID FROM PLATAFORMA_EQUIPAMENTOS plat " & _
		"WHERE plat.S_ID = " & request("plataforma") & " AND plat.EQ_ID = e.EQ_ID) "
End If

if request("controle") <> "" then
	if where <> "" then where = where & " AND "
	where = where &"EQC_TIPO = '" & request("controle") & "' "
end if
if dt_ini <> "" and dt_fim <> "" then
	if where <> "" then where = where & " AND "
	where = where & "EQC_DATA BETWEEN CONVERT(datetime, '" & dt_ini & "', 103) AND CONVERT(datetime, '" & dt_fim & "', 103) "
end if

if where <> "" then where = "WHERE " & where


If Not bln_exportaExcel Then

	ssql =	"SELECT e.EQ_ID, e.EQ_CODIGOBARRAS, e.MOD_CODNOME, e.MOD_DESCRICAO, " & _
			"e.EQ_INSTRUMENTAL, EQ_NUMEROSERIE, e.EQ_CONFORME, e.STATUS, e.EQ_LOCALIZACAO, e.FAB_NOME, " & _
			"EQC_TIPO, CONVERT(varchar, EQC_VENCIMENTO, 103) AS EQC_VENCIMENTO FROM vw_SCE_EQ_CONTROLE_ATUAL e "

	ssql = ssql & where & " order by /*EQ_CODIGOBARRAS,*/ EQC_TIPO, CAST(EQC_VENCIMENTO AS DATETIME);"

	Set rec = conn.execute(ssql)

	call ImprimeCabecalho ("", MENU_ON, true, "Relatório de Controle de Equipamento e Instrumental", "", "history.go(-1);")
%>
<table width="100%" class="texto" border="0">
<tr>
	<td class="titulo" colspan="2">
		<table width="100%" cellpadding="0" cellspacing="0" class="texto"><tr><td><b>Listagem de <%=descricaoeq%></td><td align="right" class="texto"><!--Total de itens encontrados: <%'=rec.recordcount%>--></td></tr></table>
	</td>
</tr>
<tr><td colspan="2" width="40px">&nbsp;</td></tr>
<tr><td colspan="2"><i>Os itens em destaque (<span class="vencido">&nbsp;&nbsp;</span>) est&atilde;o com vencidos.</i></td></tr>
<%
	if not (rec.eof and rec.bof) then%>
<tr>
	<td class="titulo" colspan="2">
		<table width="100%" class="texto" border="1" cellpadding="2" cellspacing="0">
		<tr>
			<th>*</th>
			<th>C&oacute;d. Barras</th>
			<th>Modelo</th>
			<th>Descri&ccedil;&atilde;o</th>
			<th>Num.S&eacute;rie</th>
			<th>Fabricante</th>
			<th>Status</th>
			<th>Vencimento</th>
		</tr>
<%		cont = 0
		while not rec.eof
			cont = cont+1
			'if (cont mod 2) = 0 then bg = 1 else bg = 0
			bg = 1  '-- tirei a modificacao das cores devido a cor dos eq´s vencidos
%>
	<tr <%if not IsNull(rec("EQC_VENCIMENTO")) then if cdate(rec("EQC_VENCIMENTO")) < date() then response.write "class='vencido'" else if bg = 0 then response.write "bgcolor='#C0E0EF'" end if end if else if bg = 0 then response.write "bgcolor='#C0E0EF'" end if %>>
			<td align="center"><%=rec("EQC_TIPO")%></td>
			<td><%=rec("EQ_CODIGOBARRAS")%></td>
			<td><%=rec("MOD_CODNOME")%></td>
			<td><%=rec("MOD_DESCRICAO")%></td>
			<td><%=rec("EQ_NUMEROSERIE")%></td>
			<td><%=rec("FAB_NOME")%></td>
			<td align="center"><%=PegaStatusItem(Conn, rec("EQ_ID"), true)%></td>
			<td align="center"><%if IsNull(rec("EQC_VENCIMENTO")) then response.write "&nbsp;" else response.write rec("EQC_VENCIMENTO")%></td>
		</tr>
<%			rec.MoveNext
		wend%>
		</table>
	</td>
</tr>
<tr><td colspan="2">&nbsp;</td></tr>
<tr>
	<td><i>(*): C - Calibra&ccedil;&atilde;o / M - Manuten&ccedil;&atilde;o / Q - Qualifica&ccedil;&atilde;o</i></td>
	<td align="right">Total de itens encontrados: <%=rec.recordcount%></td>
</tr>
<%
	else
%>
<tr><td align="center" class="titulo">Nenhum <%=lcase(descricaoeq)%> encontrado !</td></tr>
<%
	End if
%>
<tr><td colspan="2">&nbsp;</td></tr>
</table>
<%
	call ImprimeRodape (RODAPE_OFF)
Else
	ssql =	"SELECT '''' + e.EQ_CODIGOBARRAS as [Código de Barras], e.MOD_CODNOME as [Modelo], e.MOD_DESCRICAO as [Descrição], " & _
			"CASE WHEN e.EQ_INSTRUMENTAL = 1 THEN 'Sim' ELSE 'Não' END AS [Instrumental], EQ_NUMEROSERIE as [N.Série], " & _
			"CASE WHEN e.EQ_CONFORME = 1 THEN 'Sim' ELSE 'Não' END as [Conforme], " & _
			"CASE WHEN e.STATUS = " & STATUS_EM_ESTOQUE & " THEN 'Em Estoque'" & _
			"	WHEN e.STATUS = " & STATUS_CADASTRADO & " THEN 'Cadastrado'" & _
			"	WHEN e.STATUS = " & STATUS_EXPEDIDO & " THEN 'Expedido'" & _
			"	WHEN e.STATUS = " & STATUS_EXPEDIDO_SUBST & " THEN 'Substituído'" & _
			"	WHEN e.STATUS = " & STATUS_EM_USO & " THEN 'Em Uso'" & _
			"END as [Status], e.EQ_LOCALIZACAO as [Localização], e.FAB_NOME as [Fabricante], " & _
			"CASE WHEN EQC_TIPO = 'M' THEN 'Manutenção' " & _
			"	WHEN EQC_TIPO = 'C' THEN 'Calibração' " & _
			"	WHEN EQC_TIPO = 'Q' THEN 'Qualificação' " & _
			"END as [Tipo], " & _
			"CONVERT(varchar, EQC_VENCIMENTO, 103) AS [Vencimento] FROM vw_SCE_EQ_CONTROLE_ATUAL e "
'response.write ssql
'response.end
	ssql = ssql & where & " order by /*EQ_CODIGOBARRAS,*/ EQC_TIPO, CAST(EQC_VENCIMENTO AS DATETIME);"

	Set rec = conn.execute(ssql)

	Call CriaExcelGeral("Relatório de Controle de Equipamento e Instrumental", rec, null)

End If

conn.close
set conn=nothing
%>
