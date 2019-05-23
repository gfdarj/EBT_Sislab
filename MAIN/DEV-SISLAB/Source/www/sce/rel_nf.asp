<!------- LIB ------->
<!--#include file="../Classes/Classe_Combo.asp"-->
<!------- SCE ------->
<!--#include file="includes/global_SCE.asp"-->
<!------- SISLAB ---->
<!--#include file="../includes/bib_str.asp"-->
<!--#include file="../includes/padraoHTML.asp"-->
<!--#include file="../includes/global.asp" -->   <!-- constantes usada pelo menu -->
<!--#include file="../includes/Geral_Lib.asp"-->
<!--#include file="../includes/Sislab_Lib.asp"-->
<%
Tela.SCE = True
Tela.SetNomeTela = "Relatório > Nota Fiscal" : Tela.SetCaminhoRelativo = "../"
Call Tela.MostraCabecalho()

If Env.UsuarioSCE() Then

    Dim Combo
    Set Combo = New TCombo

    'Call Tela.ImprimeMenuSce()
%>
<script type="text/javascript">
function navselecao()
{
    document.formulario.submit();
}
</script>
<div class="margem-10">
<form name="formulario" method="post" action="rel_nf2.asp">
<table class="largura-total">
	<tr>
	    <td>
			<table class="largura-total">
				<tr>
					<td>
						Número da Nota:&nbsp;<input type="text" name="nf_numeronota"  size="10">
						&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
<!--						CFOP:&nbsp;<input type="text" name="nf_cfop"  size="7"> -->
						Tipo:&nbsp;
						<select name="tiponota" >
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
						Período de Emissão:&nbsp;<%=Combo.Data("e_ini")%>&nbsp;&nbsp;
						até&nbsp;&nbsp;<%=Combo.Data("e_fim")%>
					</td>
				</tr>
				<tr><td>&nbsp;</td></tr>
				<tr class="3">
					<td>
						Período de Entrada:&nbsp;<%=Combo.Data("ent_ini")%>&nbsp;&nbsp;
						até&nbsp;&nbsp;<%=Combo.Data("ent_fim")%>
					</td>
				</tr>
				<tr><td>&nbsp;</td></tr>
				<tr class="3">
					<td>
						Período de Recebimento:&nbsp;<%=Combo.Data("r_ini")%>&nbsp;&nbsp;
						até;&nbsp;&nbsp;<%=Combo.Data("r_fim")%>
					</td>
				</tr>
			</table>
		</td>
	</tr>
	<tr><td>&nbsp;</td></tr>
	<tr>
		<td colspan="2">
		Fornecedor:&nbsp;
		<%=Combo.Fornecedor("enf_id", "", "N", "FORNECEDOR", false)%>
		</td>
	</tr>
	<tr><td>&nbsp;</td></tr>
	<tr>
		<td colspan="2">
		Natureza da Operação:&nbsp;
		<%=Combo.PadraoSql("no_id", "select no_id as VALOR, no_descricao as DESCRICAO from sce_natureza_operacao order by no_descricao", "", "N")%>
		</td>
	</tr>
	<tr><td>&nbsp;</td></tr>
	<tr>
		<td>
			<input type="Checkbox" name="pendentes" value="1">&nbsp;Notas Pendentes&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
			<input type="Checkbox" name="vencidas" value="1">&nbsp;Notas Vencidas&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
			<input type="Checkbox" name="avencer" value="1">&nbsp;Notas &agrave; vencer
		</td>
	</tr>
	<tr><td>&nbsp;</td></tr>
	<tr>
		<td colspan="2">
		Ordenar resultado por&nbsp;
		<select name="ordenacao" >
			<option value="0" selected>Nota Fiscal</option>
			<option value="1">Fornecedor, Data Vencimento, Nota Fiscal</option>
			<option value="2">Data Vencimento, Fornecedor, Nota Fiscal</option>
		</select>
		</td>
	</tr>
	<tr><td>&nbsp;</td></tr>
	<tr><td><input type=submit value=" Gerar " ></td></tr>
</table>
</form>
</div>
<%
Else
    RW Tela.Mensagem.AcessoRestritoSCE()
End If

Call Tela.MostraRodape()
%>