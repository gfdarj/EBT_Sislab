<!------- SCE ------->
<!--#include file="includes/global_SCE.asp"-->
<!------- SISLAB ---->
<!--#include file="../includes/bib_str.asp"-->
<!--#include file="../includes/padraoHTML.asp"-->
<!--#include file="../includes/global.asp" -->   <!-- constantes usada pelo menu -->
<!--#include file="../includes/Geral_Lib.asp"-->
<!--#include file="../includes/Sislab_Lib.asp"-->
<%
Tela.SetNomeTela = "SCE > Cadastro > Natureza de Operação" : Tela.SetCaminhoRelativo = "../"
Call Tela.MostraCabecalho()

If Env.UsuarioSCE() Then
    Call Tela.ImprimeMenuSce()
%>
<script type="text/javascript">
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
<form method="post" action="cad_no2.asp" name="formulario">
<table width="100%">
	<tr>
		<td >
		<%if request("msg") <> "" then response.write "<strong>Natureza de Operação cadastrada com sucesso!</strong><br><br>"%></td>
	</tr>
	<tr> 
    	<td>
		  <table width="100%" cellpadding=0 cellspacing=0>
			  <tr valign="top">
			      <td >Tipo<br>
						<select name="no_tipo"  style="width:170px" multiple>
							<option value="<%=MOV_ENTRADA%>">Entrada</option>
							<option value="<%=MOV_LOGISTICA_ENTRADA%>">Logística Entrada</option>
							<option value="<%=MOV_LOGISTICA_SAIDA%>">Logística Saída</option>
							<option value="<%=MOV_EXPEDICAO%>">Expedição</option>
							<option value="<%=MOV_EXPEDICAO_SUBST%>">Substituição</option>
						</select>
			      </td>
			      <td >Descrição da Natureza de Operação<br><input type="text"  name="no_descricao" style="width:300" maxlength="50"></td>
			    </tr>
			</table>
	  </td>
	</tr>
	<tr ><td>&nbsp;</td></tr>
	<tr >
		<td>
			<table cellpadding="0" cellspacing="0">
			<tr >
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
	<tr ><td>&nbsp;</td></tr>
	<tr>
	   <td><input type="button" name="Submit" value=" Cadastrar "  onclick="ValidaCampos()"></td>
    </tr>
 </table>
</form>
<%
Else
    RW Tela.Mensagem.AcessoRestritoSCE()
End If

Call Tela.MostraRodape()
%>
