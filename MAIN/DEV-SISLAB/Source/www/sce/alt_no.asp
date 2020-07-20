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
Tela.SetNomeTela = "Cadastro > Editar Natureza de Operação" : Tela.SetCaminhoRelativo = "../"
Call Tela.MostraCabecalho()

If Env.UsuarioSCE() Then
    'Dim Combo
    'Set Combo = New TCombo

    'Call Tela.ImprimeMenuSce()
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
	frm.no_tipo.disabled = false;
	frm.submit();
	return true;
}
</script>
<%
ssql = "select * from sce_natureza_operacao where no_id = "& request("no_id")
set rec = Env.oconn.execute(ssql)
%>

<div class="margem-10">

<form method=post action="alt_no2.asp" name="formulario">
<input type="hidden" name="no_id" value="<%=request("no_id")%>">
<table width="790px">
  	<tr><td class="destaque">Editar / Excluir Natureza de Operação:</td></tr>
	<tr ><td>&nbsp;</td></tr>
	<tr> 
    	<td>
		  <table width="100%" cellpadding=0 cellspacing=0 height=80>
		  <tr> 
		      <td bgcolor="#FFFFFF"  valign="top">Tipo<br>
					<select name="no_tipo"  style="width:170px" multiple>
					 <option value="<%=MOV_ENTRADA%>" <%if rec("NO_TIPO") = MOV_ENTRADA then response.write " selected"%>>Entrada </option>
					 <option value="<%=MOV_LOGISTICA_ENTRADA%>" <%if rec("NO_TIPO") = MOV_LOGISTICA_ENTRADA then response.write " selected"%>>Logística Entrada</option>
					 <option value="<%=MOV_LOGISTICA_SAIDA%>" <%if rec("NO_TIPO") = MOV_LOGISTICA_SAIDA then response.write " selected"%>>Logística Saída</option>
					 <option value="<%=MOV_EXPEDICAO%>" <%if rec("NO_TIPO") = MOV_EXPEDICAO then response.write " selected"%>>Expedição</option>
					 <option value="<%=MOV_EXPEDICAO_SUBST%>" <%if rec("NO_TIPO") = MOV_EXPEDICAO_SUBST then response.write " selected"%>>Substituição</option>
					</select>
		      </td>
		      <td bgcolor="#FFFFFF"  valign="top">Descrição da Natureza de Operação<br><input type="text"  name="no_descricao" style="width:300" maxlength="50" value="<%=rec("no_descricao")%>"></td>
		    </tr>
			</table>
	  </td>
	</tr>
	<tr> 
	   <td bgcolor="#FFFFFF" >
	   	<input type="checkbox" name="cde" value="1"  <%if rec("cde")=True then response.write "checked"%>>CDE
	   </td>
    </tr>
	<tr> 
	   <td bgcolor="#FFFFFF" >
    	   	<input type="checkbox" name="defeito" value="1"  <%if rec("defeito")=True then response.write "checked"%>>Defeito
	   </td>
    </tr>
	<tr> 
	   <td bgcolor="#FFFFFF" >
            <input type="checkbox" name="prazo" value="1"  <%if rec("prazo")=True then response.write "checked"%>>Prazo de Retorno
	   </td>
    </tr>
	<tr> 
	   <td bgcolor="#FFFFFF" >
	   	    <input type="checkbox" name="as" value="1"  <%if rec("asa")=True then response.write "checked"%>>AS
	   </td>
    </tr>
	<script>
	function func2(){
		document.formulario.action = "exc_no.asp";
		document.formulario.submit();
	}
	</script>
	<tr><td>&nbsp;</td></tr>
	<tr> 
	   <td>
           <input type="button" class="btn btn-primary" name="Submit" value="Alterar"  onClick="ValidaCampos()">
           &nbsp;&nbsp;
           <input type="button" class="btn btn-primary" name="Submit" value="Excluir"  onClick="func2()">
	   </td>
    </tr>
 </table>
</form>
</div>
<%
Else
    RW Tela.Mensagem.AcessoRestritoSCE()
End If

Call Tela.MostraRodape()
%>
