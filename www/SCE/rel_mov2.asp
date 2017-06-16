<!--#include file="../includes/Geral_Lib.asp" -->   <!-- constantes usada pelo menu -->
<!--#include file="../includes/global.asp" -->   <!-- constantes usada pelo menu -->
<!--#include file="includes/padraoHTML.asp"-->
<!--#include file="includes/global_SCE.asp" -->
<!--#INCLUDE FILE="includes/bib_str.asp" -->
<!--#INCLUDE FILE="includes/abre.asp" -->
<%
'-- request("ssql") é utilizado na exclusao de um movimento, faz com que esta página seja
'-- recarregada
if trim(request("ssql")) = "" then

	ssql = "SELECT a.eq_id, a.eq_codigobarras as [EQ_CODIGOBARRAS_M], d.ASA AS [AS_M], "
	ssql = ssql & "CONVERT(VARCHAR, d.MOV_DATA, 103) AS [DATA_M], "
	ssql = ssql & "LEFT(CONVERT(VARCHAR, d.MOV_DATA, 114),8) AS [HORA_M], "
	ssql = ssql &"d.MOV_ID, c.fab_nome AS [FAB_NOME_M], b.MOD_CODNOME AS [MOD_CODNOME_M], "
	ssql = ssql &"d.MOV_SOLICITANTE AS [MOV_SOLICITANTE_M], d.MOV_PASSAGEM, h.nf_numeronota AS[NF_NUMERONOTA_M], "
	ssql = ssql &"d.CDE AS [CDE_M], doc.DOC_ID AS [DOC_ID_M], no_descricao as [NO_DESCRICAO_M] "
	ssql = ssql &"FROM SCE_Equipamentos a "
	ssql = ssql &"INNER JOIN SCE_Modelos b ON a.MOD_ID = b.MOD_ID INNER JOIN "
	ssql = ssql &"SCE_Fabricantes c ON b.FAB_ID = c.fab_id INNER JOIN "
	ssql = ssql &"SCE_Movimentacao d ON a.EQ_ID = d.EQ_ID "
	ssql = ssql &"LEFT OUTER JOIN SCE_Natureza_Operacao f ON d.NO_ID = f.NO_ID "
	ssql = ssql &"LEFT JOIN SCE_Nota_Fiscal h ON d.nf_id = h.nf_id "
	ssql = ssql &"LEFT JOIN SCE_Documentacao doc ON doc.doc_id = d.doc_id "

	if request("enf_id") <> "" then
		ssql = ssql &" and h.enf_id = "& request("enf_id")
	end if
	'-- estava como: d.RESERVA = 0 , como eu nao sabia o motivo e para nao alterar muito
	'-- o codigo, entao coloquei este 1 = 1
	ssql = ssql &" WHERE 1 = 1 "
	if request("noid") <> "" then
		ssql = ssql &" and f.no_id = "& request("noid")
	end if
	if request("documento") <> "" and isnumeric(request("documento")) then
		ssql = ssql & " and d.doc_id = " & request("documento") & " "
	end if
	if request("codbarras") <> "" then
		ssql = ssql &" and a.eq_codigobarras like '%"& request("codbarras") &"%'"
	end if
	If request("plataforma") <> "" Then
		ssql = ssql & _
			" AND EXISTS (SELECT plat.EQ_ID FROM PLATAFORMA_EQUIPAMENTOS plat " & _
			"WHERE plat.S_ID = " & request("plataforma") & " AND plat.EQ_ID = a.EQ_ID) "
	End If
	if request("localizacao") <> "" then
		ssql = ssql &" and a.eq_localizacao like '%"& request("localizacao") &"%'"
	end if
	if request("fabricante") <> "" then
		ssql = ssql &" and  b.fab_id = "& request("fabricante")
	end if
	if request("modelo") <> "" then
		ssql = ssql &" and b.mod_codnome like '%"& request("modelo") &"%'"
	end if
	if request("notafiscal") <> "" then
		'ssql = ssql &" and RTRIM(LTRIM(h.nf_numeronota)) = '" & Trim(request("notafiscal")) & "' "
		ssql = ssql &" and h.nf_numeronota like '"& request("notafiscal") &"'"
	end if
	if request("numeroserie") <> "" then
		ssql = ssql &" and a.eq_numeroserie like '%"& request("notipo") &"%'"
	end if
	if request("asa") <> "" then
		ssql = ssql &" and d.asa like '%"& request("asa") &"%'"
	end if
	if request("solicitante") <> "" then
		ssql = ssql &" and d.mov_solicitante like '%"& request("solicitante") &"%'"
	end if
	if request("cde") <> "" then
		ssql = ssql &" and LTRIM(RTRIM(d.CDE)) = '"& trim(request("cde")) & "' "
	end if
	if request("dia") <> "" and request("mes") <> "" and request("ano") <> "" then
		data = request("dia") &"/"& request("mes") &"/"& request("ano")
		ssql =	ssql &" and d.MOV_DATA between CONVERT(datetime, '"& data &"', 103) AND " & _
				"CONVERT(datetime, '"& data &"', 103) + 1"
	end if
	ssql = ssql & " order by a.eq_codigobarras ASC, d.MOV_DATA DESC, d.mov_id desc"
else
	ssql = request("ssql")
end if

''response.write ssql
''response.end

set rec = conn.execute(ssql)

call ImprimeCabecalho ("", MENU_ON, true, "Relatório de Movimentação de Item", "", "history.go(-1);")

if session("status") = PERFIL_ADM then%>
<script language="JavaScript">
function alteraMovimentacao(mov_id) {
	var d = document.forms[0];
	d.mov_id.value = mov_id;
	d.action = "sel_mov_acessorio.asp";
	d.target = "_blank";
	d.submit();
}
function excluiMovimentacao(mov_id) {
	var d = document.forms[0];
	if( confirm("Deseja realmente apagar este movimento ?" ) ) {
		d.mov_id.value = mov_id;
		d.action = "exc_mov.asp";
		d.target = "";
		d.submit();
	}
}
</script>
<form name="formulario" action="sel_mov_acessorio.asp" method="post">
<input type="Hidden" name="mov_id" value="">
<input type="Hidden" name="ssql" value="<%=ssql%>"
</form>
<%
end if

Dim url_xls
url_xls = "<div align='right'><a href=""../excel.asp?TITULO=Relatório de Movimentação de Item&SQL=" & Server.UrlEncode(ssql) & """ target='_blank' alt='Exporta esta listagem para o Excel'><font color='#008000'><b>XLS</b></font></a></div>"
%>
<table width="100%" cellpadding="2" cellspacing="0" class="texto">
<tr>
	<td><p class="titulo">Listagem do relatório de movimentação de itens</p></td>
	<td align="right"><%=url_xls%></td>
</tr>
</table>
<BR>
<table width="100%" cellpadding="2" cellspacing="0" class="texto" <%if not (rec.eof and rec.bof) then response.write "border=""1"""%>>
<%
if rec.eof and rec.bof then%>
	<tr><td align="center" class="titulo"><i>Nenhum registro encontrado !</i></td></tr><%
else%>
	<tr>
<%	if session("status") = PERFIL_ADM then%>
		<th align="center" valign="top"><img src="img/edit_branco.gif" border="0"></th>
		<th align="center" valign="top"><img src="img/btn_branco.gif" border="0"></th>
<%	end if%>
		<th align="center" valign="top" width="80">Item</th>
		<th align="center" valign="top" width="200">Modelo</th>
		<th align="center" valign="top" width="200">Fabricante</th>
		<th align="center" valign="top" width="50">AS</th>
		<th align="center" valign="top" width="70">Solicitante</th>
		<th align="center" valign="top" width="70">CDE</th>
		<th align="center" valign="top" width="70">NF</th>
		<th align="center" valign="top" width="70">Doc</th>
		<th align="center" valign="top" width="600">Data de Movimentação (tipo)</th>
	</tr>
<%	Dim bg, cont
	cont = 0
	while not rec.eof
		cont = cont + 1
		if (cont mod 2) = 0 then bg = 1 else bg = 0
%>
	<tr <%if bg = 0 then response.write "bgcolor='#C0E0EF'"%>>
<%		if session("status") = PERFIL_ADM then%>
		<td><a href="#" onClick="javascript:alteraMovimentacao(<%=rec("MOV_ID")%>);"><img src="img/edit.gif" border="0" alt="Clique aqui para editar esta movimentação"></a></td>
		<td><a href="#" onClick="javascript:excluiMovimentacao(<%=rec("MOV_ID")%>);"><img src="img/btn_excluir.gif" border="0" alt="Clique aqui para apagar esta movimento"></a></td>
<%		end if%>
		<td class="texto" align="center" valign="top">
			<%=ConverteNuloHTML(rec("eq_codigobarras_M"))%>
		</td>
		<td class="texto" align="center" valign="top">
			<%=ConverteNuloHTML(rec("mod_codnome_M"))%>
		</td>
		<td class="texto" align="center" valign="top">
			<%=ConverteNuloHTML(rec("fab_nome_M"))%>
		</td>
		<td class="texto" align="center" valign="top">
			<%=ConverteNuloHTML(rec("as_M"))%>
		</td>
		<td class="texto" align="center" valign="top">
			<%=ConverteNuloHTML(rec("mov_solicitante_M"))%>
			<%if rec("MOV_PASSAGEM") then response.write "&nbsp;<b>(*)</b>" end if%>
		</td>
		<td class="texto" align="center" valign="top">
			<%=ConverteNuloHTML(rec("cde_M"))%>
		</td>
		<td class="texto" align="center" valign="top">
			<%=ConverteNuloHTML(rec("nf_numeronota_M"))%>
		</td>
		<td class="texto" align="center" valign="top">
			<%=Zeros(ConverteNuloHTML(rec("DOC_ID_M")),4)%>
		</td>
		<td class="texto" align="center" valign="top">
			<%=ConverteNuloHTML(ConcatenaDataHora(rec("data_M"), rec("hora_M")))%><br><%="("&ConverteNuloHTML(rec("no_descricao_M"))&")"%>
		</td>
	</tr>
<%		rec.movenext
	wend
end if%>
</table>
<p align="left" class="texto"><i><b>(*)</b> Movimenta&ccedil;&atilde;o de passagem de carga</i></p>
<br>
<%
conn.close
set conn=nothing
call ImprimeRodape (RODAPE_OFF)
%>
