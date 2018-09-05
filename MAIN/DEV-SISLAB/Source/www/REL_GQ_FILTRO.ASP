<!--#include file="includes/Sislab_Lib.asp"-->
<!--#include file="includes/PadraoHTML.asp" -->
<!--#include file="includes/global.asp" -->
<!--#include file="includes/controleshtml.asp" -->
<!--#include file="includes/funcoes.asp" -->
<%
call ImprimeCabecalho2(TITULO_SITE, MENU_ON, true, "", "Relatório de Acompanhamento de AS", "location.href='rel_gq_filtro.asp';", "")

Dim objSiteRS, objSiteMail, objArquivos, contte, contat, sSQL, tot,auxbarq, objsiteCRT
Dim auxareateste,auxtipoteste,auxsituacaoteste,auxdiasteste, auxdescricao, auxsolicitante
Dim auxRT, auxRAT, auxusername, EH_CRT, auxorgao, auxtecnologia, auxorgaosel,auxAs

EH_CRT = Env.UsuarioCRT
%>
<script language="javascript">
function testaPreenchimento()
{
	var f = document.forms[0];

	//alert(f.diadataIniCad.value);

	if((f.tiposigilo.value == '') && (f.situacao.value == '') &&
		(f.tempesquisa.value == '') && (f.rt.value == '') &&
		(f.participante.value == '') && (f.sol_dias.value == '') &&
		(f.ini_dias.value == '') && (!f.chkRoteiro.checked) &&
		(!f.chkLaudo.checked) && (!f.chkRelEnsaio.checked) &&
		(!f.chkEquipSis.checked) && (f.tip_te.value == '') &&
		((f.diadataIniCad.value == '') || (f.mesdataIniCad.value == '') || (f.anodataIniCad.value == '')) &&
		((f.diadataFimCad.value == '') || (f.mesdataFimCad.value == '') || (f.anodataFimCad.value == '')) &&
		((f.diadataIniCadSol.value == '') || (f.mesdataIniCadSol.value == '') || (f.anodataIniCadSol.value == '')) &&
		((f.diadataFimCadSol.value == '') || (f.mesdataFimCadSol.value == '') || (f.anodataFimCadSol.value == '')) )
		return false;
	else {
		//alert('aqui');
		return true;
	}
}
function montaExcel()
{
	if(testaPreenchimento())
	{
		//var tmp, x;
	    //x = window.open("", "janelaRelatorioExcel", "width=800, height=600, toolbar=no, status=no, menubar=yes, scrollbars=yes, left=0, top=0, resizable=yes");
	    //document.forms[0].target = "janelaRelatorioExcel";
	    //tmp = document.forms[0].target;
		//document.forms[0].submit();
		//document.forms[0].target = tmp;
		//x.close();

	    document.forms[0].target = "_blank";
	    document.forms[0].submit();
	}
	else
		alert('Selecione ao menos uma condição de filtro !');
}
</script>
<iframe width="770" height="50" name="1111___janelaRelatorioExcel" style="display: none;"></iframe>

<form name="formteste" method="post" action="rel_gq.asp">
<input type=hidden name="doformteste" value=1>
<table width="100%" class="tabela1" cellpadding="3" cellspacing="3">
<tr>
	<td>
		&nbsp;<span class="vermelho2">&raquo;</span>&nbsp;<span class="texto1b" style="font-size: 12px;">Selecione uma das opções de filtro para consulta</span>
	</td>
</tr>
<tr>
	<td>
		Tipo Sigilo: &nbsp;
		<%call comboBDSQL ("tiposigilo", Env.oConn, "Select TS_ID as valor,TS_Descricao as descricao from Tipo_Sigilo order by Ts_ID asc", "", true)%>
	</td>
</tr>
<tr>
	<td>
		Situação:&nbsp;
		<select name="situacao"  class="combo">
			<option value="">Todas as Situações</option>
			<option value="NC">Todas Não Concluídas</option>
			<%call comboBD(Env.oConn,"Select ID_Situacao as valor,left(S_DESCRICAO,35) as descricao from Situacoes where S_OS = 0 order by ID_Situacao asc;")%>
		</select>
		&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
		Resposta à Pesquisa de Satisfação:
		<select name="tempesquisa" class="combo">
			<option value="">Todos os agendamentos</option>
			<option value="Sim">Apenas agendamentos com resposta</option>
			<option value="Não">Apenas agendamentos sem resposta</option>
		</select>
	</td>
</tr>
<tr>
	<td>
		Responsável Técnico:&nbsp;
		<%Call comboRtTodos("rt", Env.oConn, True)%>
	</td>
</tr>
<tr>
	<td>
		Username ou nome do participante:&nbsp;
		<input type="text" size="20" maxlength="50" name="participante" class="texto1">
	</td>
</tr>
<tr>
	<td>
		Solicitado nos últimos <input class="texto1" name="sol_dias" size="3" maxlength="10"> dias
	</td>
</tr>
<tr>
	<td>
		Iniciado nos últimos <input class="texto1" name="ini_dias" size="3" maxlength="10"> dias
	</td>
</tr>
<tr>
	<td>
		Checa falta de Roteiro <input type="Checkbox" name="chkRoteiro">
		&nbsp;&nbsp;&nbsp;&nbsp;
		Checa falta de Laudo&nbsp;<input type="Checkbox" name="chkLaudo">
		&nbsp;&nbsp;&nbsp;&nbsp;
		Checa falta de Relatório de Ensaio&nbsp;<input type="Checkbox" name="chkRelEnsaio">
	</td>
</tr>
<tr>
	<td>
		Checa Necessidade de Relatório de Ensaio&nbsp;<input type="Checkbox" name="chkEquipSis">
	</td>
</tr>
<tr>
	<td>
		Tipo de Teste:&nbsp;
		<%call comboBDSQL( "tip_te",Env.oConn, "Select TA_DESCRICAO as valor,TA_DESCRICAO as descricao from TIPO_ATIVIDADE ORDER BY TA_DESCRICAO", "", true)%>
		&nbsp;&nbsp;&nbsp;&nbsp;
		<!--Área Tecnológica:&nbsp;
		<%'call comboAreaTecnologica("at_id", Env.oConn, "N")%>
		-->
	</td>
</tr>
<tr>
	<td>
		<a href="#" title="Selecione uma data para pesquisa. Caso uma das datas estejam em branco é considerado apenas a data selecionada como limite inferior ou superior, conforme o preenchimento."><u>Solicitado pelo cliente entre </u></a>&nbsp;
		<%call comboData("dataIniCad")%>&nbsp;e&nbsp;<%call comboData("dataFimCad")%>
	</td>
</tr>
<tr>
	<td>
		<a href="#" title="Selecione uma data para pesquisa. Caso uma das datas estejam em branco é considerado apenas a data selecionada como limite inferior ou superior, conforme o preenchimento."><u>Período agendado pelo cliente </u></a>&nbsp;
		<%call comboData("dataIniCadSol")%>&nbsp;até&nbsp;<%call comboData("dataFimCadSol")%>
	</td>
</tr>
<tr>
	<td>
		<input type=button name="Filtro" Value="Gerar Planilha" onclick="montaExcel();" class="texto1">
	</td>
</tr>
</table>
</form>
<%
Call imprimeRodape(RODAPE_OFF)
%>
