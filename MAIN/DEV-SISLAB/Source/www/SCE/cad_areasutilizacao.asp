<!--#include file="../includes/global.asp" -->   <!-- constantes usada pelo menu -->
<!--#include file="includes/padraoHTML.asp"-->
<%
call ImprimeCabecalho ("", MENU_ON, true, "Cadastra Área de Utilização", "", "history.go(-1);")
%>
<script language="javascript">
function ValidaCampos()
{
	var frm = document.formulario;
	if (frm.au_descricao.value.length == 0)
	{
		alert("Defina a Descricao!");
		frm.au_descricao.focus();
		return false;
	}
	return true;
}
</script>
<form method=post action="insCad_areasutilizacao.asp" name="formulario"  onsubmit="return ValidaCampos();">
<input type="hidden" name="tipocomando" value="">
<input type="hidden" name="au_id" value="">
<table width="100%">
	<tr>
		<td class=texto>
		<%if request("msg") <> "" then response.write "Área cadastrada com sucesso!<br><br>"%></td>
	</tr>
	<tr> 
		<td class="texto">
			Descrição da Área de Utilização<br>
			<input type="text" class="form" name="au_descricao" style="width:600" maxlength="50">
		</td>
	</tr> 
	<tr class="texto"><td>&nbsp;</td></tr>
	<tr class="texto">
		<td><input type="submit" name="Submit" value=" Cadastrar " class="form"></td>
	</tr>
</table>
</form>
<%
call ImprimeRodape (RODAPE_OFF)
%>