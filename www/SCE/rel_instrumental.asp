<!--#include file="../includes/funcoes.asp" -->
<!-- #include file="includes/controlesHTML_SCE.asp" -->
<!--#include file="includes/global_SCE.asp" -->
<!--#include file="../includes/global.asp" -->   <!-- constantes usada pelo menu -->
<!--#include file="includes/padraoHTML.asp"-->
<!--#include file="includes/abre.asp"-->
<%
call ImprimeCabecalho ("", MENU_ON, true, "Relatório de Controle de Equipamento e Instrumental", "", "history.go(-1);")
%>
<form name="formulario" action="rel_instrumental2.asp" method="post">
<input type="hidden" value="" name="exportaExcel">
<table width="750px" class="texto">
<tr><td  valign="middle" class="titulo">Selecione o Item:</td></tr>
<tr><td>&nbsp;</td></tr>
<tr>
	<td>
		Código Barras:&nbsp;<input type="text" class="form" name="codbarras" size="25">
	</td>
	<td>
		Fabricantes:&nbsp;
		<%call comboBDSQL( "fabricante", conn, "select fab_id as VALOR, fab_nome as DESCRICAO from sce_fabricantes order by fab_nome", "", "N")%>
	</td>
</tr>
	
<tr><td>&nbsp;</td></tr>

<tr>
	<td>Modelo:&nbsp;<input type=text name=modelo class=form></td>
	<td>Descri&ccedil;&atilde;o:&nbsp;<input type="text" name="desc_modelo" class="form" size="50"></td>
</tr>

<tr class="texto"><td>&nbsp;</td></tr>

<tr>
	<td>Número de Série:&nbsp;<input type="text" class="form" name="numeroserie" maxlength="50"></td>
	<td>
		Instrumental:&nbsp;
		<select name="instrumental" class="combo">
			<option value="">Todos</option>
			<option value="1" selected>Sim</option>
			<option value="0">N&atilde;o</option>
		</select>
		&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
		Conforme:&nbsp;
		<select name="conforme" class="combo">
			<option value="">Todos</option>
			<option value="1">Sim</option>
			<option value="0">N&atilde;o</option>
		</select>
		&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
		Situa&ccedil;&atilde;o:&nbsp;
		<select name="status" class="combo">
			<option value="">Todos</option>
			<option value="<%=STATUS_EM_ESTOQUE%>">Em estoque</option>
			<option value="<%=STATUS_EM_USO%>">Em uso</option>
			<option value="<%=STATUS_EXPEDIDO%>">Expedido</option>
			<option value="<%=STATUS_EXPEDIDO_SUBST%>">Substituído</option>
		</select>
	</td>	
</tr>

<tr class="texto"><td>&nbsp;</td></tr>

<tr>
	<td colspan="2">
		Plataforma: <%call comboServicosPlataformas("plataforma", conn, "N", "P")%>
	</td>	
</tr>

<tr class="texto"><td>&nbsp;</td></tr>

<tr>
	<td>
		Controle do Instrumental:&nbsp;
		<select name="controle" class="form">
			<option value="">--</option>
			<option value="<%=CONTROLE_CALIBRACAO%>">Calibra&ccedil;&atilde;o</option>
			<option value="<%=CONTROLE_MANUTENCAO%>">Manuten&ccedil;&atilde;o</option>
			<option value="<%=CONTROLE_QUALIFICACAO%>">Qualifica&ccedil;&atilde;o</option>
		</select>
	</td>
	<td>A vencer em at&eacute; <input type="Text" class="form" name="vencimento" size="5"> dias</td>
</tr>

<tr class="texto"><td>&nbsp;</td></tr>
<tr>
	<td colspan="2">
		Per&iacute;odo:&nbsp;
		<%Call comboData("Ini")%>&nbsp;&nbsp;at&eacute;&nbsp;&nbsp;<%Call comboData("Fim")%>
	</td>
</tr>

<tr class="texto"><td>&nbsp;</td></tr>

<tr>
	<td>&nbsp;</td>
	<td align="center">

	<script language="javascript">
	function exportaParaExcel()
	{
		document.formulario.target = "_blank";
		document.formulario.exportaExcel.value = 'S';
		document.formulario.submit();
	}
	function envia()
	{
		document.formulario.target = "_self";
		document.formulario.exportaExcel.value = '';
		document.formulario.submit();
	}
	</script>

		<input type="button" name="buscar" value="próximo &gt;&gt;" class="form" onclick='javascript: envia();'>
		&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
		<input type="button" name="buscar" value="Exportar para Excel" class="form" onclick="javascript:exportaParaExcel();">
	</td>
</tr>
</table>
</form>
</form>
<%
conn.close
set conn=nothing

call ImprimeRodape (RODAPE_OFF)
%>