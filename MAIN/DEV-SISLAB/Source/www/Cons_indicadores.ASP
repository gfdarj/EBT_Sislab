<!--#include file="includes/Sislab_Lib.asp"-->
<!-- #include file="includes/PadraoHTML.asp" -->
<!-- #include file="includes/global.asp" -->
<!-- #include file="includes/controlesHTML.asp" -->
<%
Dim objRS, sSQL, dataIni, dataFim, Total

If IsEmpty( Env.usuario ) Then response.redirect "msgAcessoNA.asp"

call imprimeCabecalho2(TITULO_SITE, MENU_ON, true, "", "Consulta de Indicadores", "location.href='sislab.asp'", "")
%>
<script language="javascript">
function ValidaCampos() {
	var d = document.forms[0];
	if((d.diaIni.value == '') || (d.mesIni.value == '') || (d.anoIni.value == '') || (d.diaFim.value == '') || (d.mesFim.value == '') || (d.anoFim.value == '')) {
		alert('O período informado é inválido');
		return false;
	}
	else {
		var dI = d.anoIni.value + '' + d.mesIni.value + '' + d.diaIni.value;
		var dF = d.anoFim.value + '' + d.mesFim.value + '' + d.diaFim.value;

		if(dI > dF) {
			alert('Data inicial é maior que a data final');
			return false;
		}
	}
	d.submited.value = 1;
	return true;
}
</script>
<form method="post" action="cons_indicadores.asp" name="formulario" onsubmit="return ValidaCampos();">
<input type="Hidden" name="submited" value="0">
<table width="100%" class="tabela1" border="0">
<tr>
	<td>
		&nbsp;<span class="vermelho2">&raquo;</span>&nbsp;<span class="texto1b" style="font-size: 12px;">Selecione um Indicador</span>
	</td>
</tr>
<tr><td>&nbsp;</td></tr>
<tr>
	<td>
		<input type="radio" name="cmbIndicador" value="1" checked>Eventos por Atividade (por nº de dias)
		&nbsp;&nbsp;&nbsp;
		<input type="radio" name="cmbIndicador" value="0">Eventos por Responsável (por nº de dias)
	</td>
</tr>
<tr><td>&nbsp;</td></tr>
<tr>
	<td>
		&nbsp;Período :&nbsp;<%call comboData("Ini")%>&nbsp;até&nbsp;<%call comboData("Fim")%>
		&nbsp;&nbsp;&nbsp;
		<input type="submit" class="texto1" value="Pesquisar">
	</td>
</tr>
</table>
</form>
<br>
<%
'-- o form foi enviado
if request("submited") = "1" then%>
<table class="tabela1" cellpadding="3" cellspacing="3" align="left" border="1" style="border: solid thin;">
<%
	dataIni = request("anoIni") & "-" & request("mesIni") & "-" & request("diaIni")
	dataFim = request("anoFim") & "-" & request("mesFim") & "-" & request("diaFim")

	sSQL = "EXEC sp_Indicador_Eventos_Atividade '" & dataIni & "', '" & dataFim & "' "
	if request("cmbIndicador") = "0" then
		sSQL = sSQL & ", 'RESPONSAVEL'"
	else
		sSQL = sSQL & ", 'ATIVIDADE'"
	end if
	'call RecordSet(true, objRS, sSQL, objConn)

'response.write ssql
'response.end

	Set objRS = Env.oConn.Execute(sSQL)
	if not objRS.Eof then
		total = objRS(1)
		objRS.MoveNext%>
<tr><th><%=objRS.Fields(0).Name%></th><th><%=objRS.Fields(1).Name%></th></tr>
<%		while not objRS.Eof%>
<tr><td><%if IsNull(objRS(0)) then response.write "&lt;Vazio&gt;" else response.write objRS(0) end if%></td><td align="right">&nbsp;<%=objRS(1)%></td></tr>
<%			objRS.MoveNext
		wend%>
<tr><td><b>TOTAL</b></td><td align="right"><b><%=total%></b></td></tr>
<%	else%>
<tr><td colspan="2" align="center">Nenhum registro encontrado</td></tr>
<%	end if%>
</table>
<br>
<script language="javascript">
	var d = document.forms[0];

	d.diaIni.value = '<%=request("diaIni")%>';
	d.mesIni.value = '<%=request("mesIni")%>';
	d.anoIni.value = '<%=request("anoIni")%>';
	d.diaFim.value = '<%=request("diaFim")%>';
	d.mesFim.value = '<%=request("mesFim")%>';
	d.anoFim.value = '<%=request("anoFim")%>';
</script>
<%
end if

call imprimeRodape(RODAPE_OFF)
%>
