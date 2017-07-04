<!-- #include file="../includes/global.asp" -->   <!-- constantes usada pelo menu -->
<!--#include file="includes/padraoHTML.asp"-->
<!-- #INCLUDE FILE="includes/abre.asp" -->
<%
call ImprimeCabecalho ("", MENU_ON, true, "Altera Área de Utilização", "", "history.go(-1);")
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
<%ssql = "select * from sce_areautilizacao where au_id = "& request("au_id")
set rec = conn.execute(ssql)%>
<form method=post action="alt_area2.asp" name="formulario"  onsubmit="return ValidaCampos();">
<input type="hidden" name="au_id" value="<%=request("au_id")%>">
<table width="100%" align="left" >
    <tr> 
      <td>
  <table width="100%" cellpadding=0 cellspacing=0>
  
    <tr> 
      <td class="texto" colspan="10" bgcolor="#FFFFFF" align="left"> 
			Descrição da Área de Utilização<br>
			<input type="text" class="form" name="au_descricao" style="width:600" maxlength="100" value="<%=rec("au_descricao")%>">&nbsp;&nbsp;
			</b>
      </td>
    </tr>
</table>
      </td>
    </tr>
	<tr class="texto"><td>&nbsp;</td></tr>
    <tr> 
	<script>
	function func(){
		document.formulario.action = "exc_area.asp";
		}
	</script>
      <td>
          <input type="submit" name="Submit" value=" Editar " class="form">  <input type="submit" name="Submit" value=" Excluir " class="form" onclick="func();">
      </td>
    </tr>
  </table>
</form>
<%
conn.close
set conn=nothing
call ImprimeRodape (RODAPE_OFF)
%>
