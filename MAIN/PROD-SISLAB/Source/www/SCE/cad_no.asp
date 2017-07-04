<!--#include file="../includes/global.asp" -->   <!-- constantes usada pelo menu -->
<!--#include file="includes/padraoHTML.asp"-->
<!--#include file="includes/global_SCE.asp"-->
<%
call ImprimeCabecalho ("", MENU_ON, true, "Cadastra Natureza de Operação", "", "history.go(-1);")
%>
<script language="javascript">
function ValidaCampos()
{
	var frm = document.formulario;
	if (frm.no_tipo.value == "")
	{
		alert("Defina o Tipo!");
		frm.no_tipo.focus();
		return false;
	}
	if (frm.no_descricao.value.length == 0)
	{
		alert("Defina a Descricao!");
		frm.no_descricao.focus();
		return false;
	}
	frm.submit();
	return true;
}
</script>
<form method=post action="cad_no2.asp" name="formulario">
<table width="100%">
	<tr>
		<td class=texto>
		<%if request("msg") <> "" then response.write "<strong>Natureza de Operação cadastrada com sucesso!</strong><br><br>"%></td>
	</tr>
	<tr> 
    	<td>
		  <table width="100%" cellpadding=0 cellspacing=0>
			  <tr valign="top">
			      <td class="texto">Tipo<br>
						<select name="no_tipo" class="form" style="width:170px" multiple>
							<option value="<%=MOV_ENTRADA%>">Entrada</option>
							<option value="<%=MOV_LOGISTICA_ENTRADA%>">Logística Entrada</option>
							<option value="<%=MOV_LOGISTICA_SAIDA%>">Logística Saída</option>
							<option value="<%=MOV_EXPEDICAO%>">Expedição</option>
							<option value="<%=MOV_EXPEDICAO_SUBST%>">Substituição</option>
						</select>
			      </td>
			      <td class="texto">Descrição da Natureza de Operação<br><input type="text" class="form" name="no_descricao" style="width:300" maxlength="50"></td>
			    </tr>
			</table>
	  </td>
	</tr>
	<tr class="texto"><td>&nbsp;</td></tr>
	<tr class="texto">
		<td>
			<table cellpadding="0" cellspacing="0">
			<tr class="texto">
			   <td>
			   	CDE<input type="checkbox" name="cde" value="1">
			   </td>
			   <td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>
			   <td>
			   	Defeito<input type="checkbox" name="defeito" value="1" >
			   </td>
			   <td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>
			   <td>
			   	Prazo de Retorno<input type="checkbox" name="prazo" value="1">
			   </td>
			   <td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>
			   <td>
			   	AS<input type="checkbox" name="as" value="1">
			   </td>
			</tr>
			</table>
		</td>
	</tr>
	<tr class="texto"><td>&nbsp;</td></tr>
	<tr>
	   <td><input type="button" name="Submit" value=" Cadastrar " class="form" onclick="ValidaCampos()"></td>
    </tr>
 </table>
</form>
<%
call ImprimeRodape (RODAPE_OFF)
%>