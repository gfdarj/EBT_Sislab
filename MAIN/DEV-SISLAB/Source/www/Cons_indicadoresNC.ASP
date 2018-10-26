<!--#include file="includes/Sislab_Lib.asp"-->
<!--#include file="includes/PadraoHTML.asp" -->
<!--#include file="includes/global.asp" -->
<!--#include file="includes/controlesHTML.asp" -->
<%
If IsEmpty( Env.usuario ) Then response.redirect "msgAcessoNA.asp"

Dim ssql, dataIni, dataFim, objEfi, objConn

Tela.SetMostraMenu = MENU_ON
Tela.SetMostraImagem = True
Tela.SetNomeTela = "Consulta de Indicadores de Não Conformidade"
Call Tela.MostraCabecalho()
'''''call imprimeCabecalho2(TITULO_SITE, MENU_ON, true, "", "Consulta de Indicadores de Não Conformidade", "location.href='sislab.asp'", "")
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

<form method="post" action="cons_indicadoresNC.asp" name="formulario" onsubmit="return ValidaCampos();">
<input type="hidden" name="submited" value="0">
<table width="100%" class="table-bordered" border="0">
<tr>
	<td>
		&nbsp;<span class="texto-vermelho-bold">&raquo;</span>&nbsp;<span class="texto1b" style="font-size: 12px; font-weight: bold;">
			Selecione o período desejado da consulta
		</span>
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
<tr><td>&nbsp;</td></tr>
</table>
</form>
<%
'-- o form foi enviado
if request("submited") = "1" then
	dataIni = request("anoIni") & "-" & request("mesIni") & "-" & request("diaIni")
	dataFim = request("anoFim") & "-" & request("mesFim") & "-" & request("diaFim")

	sSQL = "exec sp_Indicador_Nao_Conformidade '" & dataIni & "','" & dataFim & "';"
	Set ObjEfi = Env.oConn.Execute(sSQL)
%>
<table class="table-bordered" cellpadding="3" cellspacing="3" align="left" border="1" style="border: solid thin;">
<tr>
	<th>Total de Ocorrências</th>
	<th>Não Conformidades</th>
</tr>
<%	if not (ObjEfi.EOF and ObjEfi.BOF) then%>
<tr>
	<td><%=ObjEfi("denominador")%> ocorrências</td>
	<td><%=ObjEfi("numerador")%> ocorrências (<%=FormatNumber(ObjEfi("porcentagem"),2)%>%)</td>
</tr>
<%	else%>
<tr><td colspan="2"><i>Nenhum indicador encontrado !</i></td></tr>
<%	end if%>
</table>
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

Call Tela.MostraRodape()
%>