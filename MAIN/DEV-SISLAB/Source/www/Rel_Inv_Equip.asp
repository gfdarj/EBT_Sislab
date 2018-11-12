<!--#include file="includes/Sislab_Lib.asp"-->
<!--#include file="includes/PadraoHTML.asp" -->
<!--#include file="includes/global.asp" -->
<!--#include file="includes/funcoes.asp" -->
<!--#include file="includes/controleshtml.asp" -->
<!--#include file="includes/controleshtml_SCE.asp" -->
<%
Dim EH_CRT, EH_RAT
Dim chr_BgColor, chr_EstiloTD

EH_CRT = Env.UsuarioCRT()
EH_RAT = Env.EhRat()
chr_BgColor = "#E8E8E8"
chr_EstiloTD = "style='border-bottom: solid " & chr_BgColor & " thin;'"

If Not EH_RAT Then
	RR "index.asp"
	RE
End If

Tela.SetMostraMenu = MENU_ON
Tela.SetMostraImagem = True
Tela.SetNomeTela = "Relatório para Inventário de Equipamentos"
Tela.SetLinkVoltar = ""
Call Tela.MostraCabecalho()
'''''Call Tela.ImprimeCabecalho2(TITULO_SITE, MENU_ON, true, "", "Relatório para Inventário de Equipamentos", "", "")
%>
<script type="text/javascript">
    function ValidaCampos() {
	    var frm = document.frmFiltro;

	    if(isNaN(frm.notafiscal.value)) {
		    alert('Nota fiscal não é válida.');
		    frm.notafiscal.focus(); return false;
	    }
	    else if(isNaN(frm.qtdmov.value)) {
		    alert('Quantidade de movimento não é válido.');
		    frm.qtdmov.focus(); return false;
	    }
	    else {
		    showAguarde(); return true;
	    }
    }
</script>

<form name="frmFiltro" method="post" action="rel_inv_equip_A.asp" onSubmit="javascript:return ValidaCampos();">

<table border="0" width="100%" class="table-bordered" cellpadding="3" cellspacing="3">
<tr>
	<td>
		&nbsp;<span class="texto1B" style="font-size: 12px;">Selecione uma das opções de filtro para consulta</span>
	</td>
</tr>
<tr>
	<td>
		<table border="0" width="100%" class="table-bordered" cellpadding="3" cellspacing="0" style="background: <%=chr_BgColor%>;">
		<tr>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
		</tr>

		<tr>
			<td colspan="2">Código Barras: <input type="text" name="codigobarras" size="20" maxlength="16" class="texto1"></td>
			<td colspan="2">Localização: <input type="text" name="localizacao" size="20" class="texto1"></td>
			<td colspan="6">Modelo: <input type="text" name="modelo" size="20" class="texto1"></td>
		</tr>

		<tr>
			<td colspan="2">Nota Fiscal: <input type="text" name="notafiscal" size="10" class="texto1"></td>
			<td colspan="2">
				Propriedade:
				<select name="propriedade" >
					<option value="">Todos</option>
					<option value="M">Comodato (Embratel)</option>
					<option value="C">CRT</option>
					<option value="O">Outros (Embratel)</option>
					<option value="T">Terceiros</option>
				</select>
			</td>
			<td colspan="6">Qtde de Movimentos: <input type="text" name="qtdmov" size="6" maxlength="5" class="texto1"></td>
		</tr>

		<tr>
			<td colspan="8">Fornecedor: <%call comboFornecedor("idfornecedor", Env.oConn, "", "N", "FORNECEDOR", False)%></td>
			<td colspan="2">Status:
				<select name="status" >
					<option value="">Todos</option>
					<option value="0">Cadastrado</option>
					<option value="2">Em Uso</option>
					<option value="1">Estoque</option>
					<option value="3">Expedido</option>
				</select>
			</td>
		</tr>

		<tr><td>&nbsp;</td></tr>

		<tr>
			<td colspan="5">Ordenação:
				<select name="ordenacao" >
					<option value="E.EQ_CODIGOBARRAS">Código de Barras</option>
					<option value="QTD_MOV.TOTAL_MOVIMENTOS">Quantidade de Movimentos</option>
					<option value="E.STATUS">Status do Equipamento</option>
				</select>
				<select name="tipoordenacao" >
					<option value="ASC">Ascendente</option>
					<option value="DESC">Descendente</option>
				</select>
			</td>
			<td colspan="5" align="right">
				Registros por Página:
				<select name="registroporpagina" >
					<option value="10">10</option>
					<option value="30">30</option>
					<option value="50">50</option>
					<option value="100">100</option>
				</select>
			</td>
		</tr>
		</table>
	</td>
</tr>
<tr><td></td></tr>
<tr>
	<td align="right">
		<input type="submit" name="btnConsultar" Value="Consultar" class="texto1">
	</td>
</tr>
</table>
</form>
<%
Call Tela.MostraRodape()
%>
