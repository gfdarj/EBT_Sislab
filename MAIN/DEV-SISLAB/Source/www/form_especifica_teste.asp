<!--#include file="includes/Sislab_Lib.asp"-->
<!--#include file="includes/global.asp" -->
<!--#include file="includes/PadraoHTML.asp" -->
<!--#include file="includes/ControlesHTML.asp" -->
<%
Dim objSiteRS, cont, sSQL, tot, rs_servico
Dim titulo, i, rs_teste
Dim num_erro, desc_erro, desc_equip, cod_teste
Dim disponivel, tempo, area_tec, tipo, area, pto_cc, pto_ca, pto_telefonicos, descricao, observacao, cabos_conectores, aterramento, rs_procedimentos
Dim auxTipoTeste
Dim int_Repeticao

Call Tela.ImprimeCabecalho2(TITULO_SITE, MENU_ON, true, "", "Cadastro de Testes", "location.href='form_atualiza_teste_sel.asp'", "")
cod_teste = request("cod_teste")

if cod_teste <> "" then
	call Env.RecordSet(true, rs_teste, "Select t.*, tt.TIT_DESCRICAO from testes t inner join tipo_teste tt on t.TIT_ID = tt.TIT_ID where t.t_id = " & cod_teste)
	if not rs_teste.EOF then
		titulo = rs_teste("T_TITULO")
		disponivel = rs_teste("T_DISPONIVEL")
		tipo = rs_teste("TIT_DESCRICAO")
		descricao = rs_teste("T_DESCRICAO")
		observacao = rs_teste("T_OBSERVACAO")
		auxTipoTeste = rs_teste("TIT_ID")
		int_Repeticao = rs_teste("T_PERIODOREPETICAO")
	end if
	call Env.RecordSet(false, rs_teste, null)
else
	titulo = null
	disponivel = null
	tipo = null
	descricao = null
	observacao = null
	auxTipoTeste = ""
	int_Repeticao = ""
end if
%>
<script language="JavaScript">
function validaCampos(frm)
{	//Valida os campos quando o formulário é submetido
	if (frm.txtTitulo.value == "") 
	{
		alert("Título do teste deve ser preenchido.");
		frm.txtTitulo.focus();
		return false;
	}
	else if (frm.rdoTipo.value == '')
	{
		alert("Selecione o tipo do teste.");
		frm.rdoTipo.focus();
		return false;
	}
	else if (isNaN(frm.periodoRepeticao.value))
	{
		alert("Entre com um valor entre 0 (Zero) e 99.");
		frm.periodoRepeticao.focus();
		return false;
	}
	else if (frm.periodoRepeticao.value < 0)
	{
		alert("Entre com um valor entre 0 (Zero) e 99.");
		frm.periodoRepeticao.focus();
		return false;
	}
	return true;
}
</script>
<form method="post" action="form_especifica_testeA.asp" name="frmEspecificaTeste" onSubmit="return validaCampos(this);">
<input type="hidden" value="<%= cod_teste%>" name="cod_teste">
<table border="0" width="100%" cellspacing="2" cellpadding="0" class="table-bordered">
<tr>
	<td width="550px">
		&nbsp;&nbsp;Título:<BR>
		&nbsp;&nbsp;<input type="text" class="texto1" value="<%=titulo%>" name="txtTitulo" size="100" maxlength="200">
	</td>
	<td>
		Tipo do teste:<BR>
		<%call comboTipoTeste("rdoTipo", Env.oConn, auxTipoTeste, "N")%>
	</td>
	<td align="center">
		Disponível:<BR>
		<input type="checkbox" name="chkDisponivel" <%if disponivel then Response.Write "checked"%>>
	</td>
</tr>
<tr><td height="5px"></td></tr>
<tr>
	<td>
		&nbsp;&nbsp;Descrição:<br>
		&nbsp;&nbsp;<TEXTAREA class="texto1" cols=100 name="txaDescricao" rows="6"><%= descricao%></TEXTAREA>
	</td>
	<td colspan="2" valign="top">
		Período de Repetição do Teste<br>
		<input class="texto1" size="3" maxlength="2" type="text" name="periodoRepeticao" value="<%=int_Repeticao%>"> mês(es)<BR>
		<i>(Zero ou Vazio indicam a <u>Não</u> repetição)</i>
	</td>
</tr>
<tr><td height="5px"></td></tr>
<tr>
	<td colspan="3">
		&nbsp;&nbsp;Observação:<br>
		&nbsp;&nbsp;<TEXTAREA class="texto1" cols=100 name="txaObservacao" rows="6"><%= observacao%></TEXTAREA>
	</td>
</tr>
<tr><td>&nbsp;</td></tr>
<tr>
	<td colspan="3">
	    <input type="submit" value="   Ok   " name="btnOk">
    	<input type="button" value="Cancelar" onclick="javascript:location.href='form_atualiza_teste_sel.asp';">
	</td>
</tr>
</table>
</form>
<%
Call Tela.MostraRodape()
%>
