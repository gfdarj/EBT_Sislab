<!--#include file="../includes/funcoes.asp" -->
<!--#include file="includes/controlesHTML_SCE.asp" -->
<!--#include file="../includes/global.asp" -->   <!-- constantes usada pelo menu -->
<!--#include file="includes/global_SCE.asp"-->
<!--#include file="includes/padraoHTML.asp"-->
<!--#include file="includes/abre.asp"-->
<!-- #INCLUDE FILE="includes/estado.asp" -->
<%
call ImprimeCabecalho ("", MENU_ON, true, "Relatório de Notas Fiscais", "", "history.go(-1);")
%>
<script language=javascript>
function navselecao()
{
    document.formulario.submit();
}
</script>
<form name="formulario" method="post" action="rel_nf2.asp">
<table width="100%" class="texto">
	<tr>
	    <td>
			<table cellpadding="0" cellspacing="0" class="texto">
				<tr>
					<td>
						Número da Nota:&nbsp;<input type="text" name="nf_numeronota" class="form" size="10">
						&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
<!--						CFOP:&nbsp;<input type="text" name="nf_cfop" class="form" size="7"> -->
						Tipo:&nbsp;
						<select name="tiponota" class="form">
						<option value="">--</option>
						<option value="<%=NF_ENTRADA%>">Entrada</option>
						<option value="<%=NF_SAIDA%>">Sa&iacute;da</option>
						</select>
					</td>
					<td width="40px">&nbsp;</td>
					<td>&nbsp;</td>
				</tr>
				<tr><td>&nbsp;</td></tr>
				<tr class="3">
					<td>
						Per&iacute;odo de Emissão:&nbsp;<%Call comboData("e_ini")%>&nbsp;&nbsp;
						at&eacute;&nbsp;&nbsp;<%Call comboData("e_fim")%>
					</td>
				</tr>
				<tr><td>&nbsp;</td></tr>
				<tr class="3">
					<td>
						Per&iacute;odo de Entrada:&nbsp;<%Call ComboData("ent_ini")%>&nbsp;&nbsp;
						at&eacute;&nbsp;&nbsp;<%Call ComboData("ent_fim")%>
					</td>
				</tr>
				<tr><td>&nbsp;</td></tr>
				<tr class="3">
					<td>
						Per&iacute;odo de Recebimento:&nbsp;<%Call ComboData("r_ini")%>&nbsp;&nbsp;
						at&eacute;&nbsp;&nbsp;<%Call ComboData("r_fim")%>
					</td>
				</tr>
			</table>
		</td>
	</tr>
	<tr><td>&nbsp;</td></tr>
	<tr>
		<td colspan="2">
		Fornecedor:&nbsp;
		<%call comboFornecedor("enf_id", conn, "", "N", "FORNECEDOR", false)%>
		</td>
	</tr>
	<tr><td>&nbsp;</td></tr>
	<tr>
		<td colspan="2">
		Natureza da Opera&ccedil;&atilde;o:&nbsp;
		<%call comboBDSQL( "no_id", conn, "select no_id as VALOR, no_descricao as DESCRICAO from sce_natureza_operacao order by no_descricao", "", "N")%>
		</td>
	</tr>
	<tr><td>&nbsp;</td></tr>
	<tr>
		<td>
			<input type="Checkbox" name="pendentes" value="1">Notas Pendentes&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
			<input type="Checkbox" name="vencidas" value="1">Notas Vencidas&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
			<input type="Checkbox" name="avencer" value="1">Notas &agrave; vencer
		</td>
	</tr>
	<tr><td>&nbsp;</td></tr>
	<tr>
		<td colspan="2">
		Ordenar resultado por...&nbsp;
		<select name="ordenacao" class="combo">
			<option value="0" selected>Nota Fiscal</option>
			<option value="1">Fornecedor, Data Vencimento, Nota Fiscal</option>
			<option value="2">Data Vencimento, Fornecedor, Nota Fiscal</option>
		</select>
		</td>
	</tr>
	<tr><td>&nbsp;</td></tr>
	<tr><td class="texto"><input type=submit value=" Gerar " class=form></td></tr>
</table>
</form>
<%
conn.close
set conn=nothing

call ImprimeRodape (RODAPE_OFF)
%>