<!-- #include file="../includes/global.asp" -->   <!-- constantes usada pelo menu -->
<!--#include file="includes/padraoHTML.asp"-->
<!--#include file="includes/global_SCE.asp"-->
<!-- #INCLUDE FILE="includes/abre.asp" -->
<%
call ImprimeCabecalho ("", MENU_ON, true, "Editar Natureza de Operação", "", "history.go(-1);")
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
	frm.no_tipo.disabled = false;
	frm.submit();
	return true;
}
</script>
<%
ssql = "select * from sce_natureza_operacao where no_id = "& request("no_id")
set rec = conn.execute(ssql)
%>
<form method=post action="alt_no.asp" name="formulario">
<input type="hidden" name="no_id" value="<%=request("no_id")%>">
<table width="790px">
  	<tr><td class="titulo">Editar / Excluir Natureza de Operação:</td></tr>
	<tr class="texto"><td>&nbsp;</td></tr>
	<tr> 
    	<td>
		  <table width="100%" cellpadding=0 cellspacing=0 height=80>
			  <tr> 
			      <td bgcolor="#FFFFFF" class="texto">Tipo<br>
						<select name="no_tipo" class="form" style="width:170px" multiple>
						 <option value="<%=MOV_ENTRADA%>" <%if rec("NO_TIPO") = MOV_ENTRADA then response.write " selected"%>>Entrada </option>
						 <option value="<%=MOV_LOGISTICA_ENTRADA%>" <%if rec("NO_TIPO") = MOV_LOGISTICA_ENTRADA then response.write " selected"%>>Logística Entrada</option>
						 <option value="<%=MOV_LOGISTICA_SAIDA%>" <%if rec("NO_TIPO") = MOV_LOGISTICA_SAIDA then response.write " selected"%>>Logística Saída</option>
						 <option value="<%=MOV_EXPEDICAO%>" <%if rec("NO_TIPO") = MOV_EXPEDICAO then response.write " selected"%>>Expedição</option>
						 <option value="<%=MOV_EXPEDICAO_SUBST%>" <%if rec("NO_TIPO") = MOV_EXPEDICAO_SUBST then response.write " selected"%>>Substituição</option>
						</select>
			      </td>
			      <td bgcolor="#FFFFFF" class="texto">Descrição da Natureza de Operação<br><input type="text" class="form" name="no_descricao" style="width:300" maxlength="50" value="<%=rec("no_descricao")%>"></td>
			    </tr>
			</table>
	  </td>
	</tr>
	<tr> 
	   <td bgcolor="#FFFFFF" class="texto">
	   	CDE<input type="checkbox" name="cde" value="1"  <%if rec("cde")=True then response.write "checked"%>>
	   </td>
    </tr>
	<tr> 
	   <td bgcolor="#FFFFFF" class="texto">
	   	Defeito<input type="checkbox" name="defeito" value="1"  <%if rec("defeito")=True then response.write "checked"%>>
	   
	   </td>
    </tr>
	<tr> 
	   <td bgcolor="#FFFFFF" class="texto">
	   	Prazo de Retorno<input type="checkbox" name="prazo" value="1"  <%if rec("prazo")=True then response.write "checked"%>>
	   
	   </td>
    </tr>
	<tr> 
	   <td bgcolor="#FFFFFF" class="texto">
	   	AS<input type="checkbox" name="as" value="1"  <%if rec("asa")=True then response.write "checked"%>>
	   
	   </td>
    </tr>
	<script>
	function func2(){
		document.formulario.action = "exc_no.asp";
		document.formulario.submit();
	}
	</script>
	<tr> 
	   <td><input type="button" name="Submit" value="Alterar" class="form" onClick="ValidaCampos()">&nbsp;&nbsp;<input type="button" name="Submit" value="Excluir" class="form" onClick="func2()"></td>
    </tr>
 </table>
</form>
<%
conn.close
set conn=nothing
call ImprimeRodape (RODAPE_OFF)
%>
