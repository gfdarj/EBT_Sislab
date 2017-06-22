<!------- SCE ------->
<!--#include file="includes/global_SCE.asp"-->
<!------- SISLAB ---->
<!--#include file="../includes/bib_str.asp"-->
<!--#include file="../includes/padraoHTML.asp"-->
<!--#include file="../includes/global.asp" -->   <!-- constantes usada pelo menu -->
<!--#include file="../includes/Geral_Lib.asp"-->
<!--#include file="../includes/Sislab_Lib.asp"-->
<%
Tela.SetNomeTela = "SCE > Consulta > Altera Área de Utilização" : Tela.SetCaminhoRelativo = "../"
Call Tela.MostraCabecalho()

If Env.UsuarioSCE() Then
    Call Tela.ImprimeMenuSce()
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
set rec = Env.oconn.execute(ssql)%>
<form method=post action="alt_areasutilizacao2.asp" name="formulario"  onsubmit="return ValidaCampos();">
<input type="hidden" name="au_id" value="<%=request("au_id")%>">
<table width="100%" align="left" >
    <tr> 
      <td>
  <table width="100%" cellpadding=0 cellspacing=0>
  
    <tr> 
      <td class="texto1" colspan="10" bgcolor="#FFFFFF" align="left"> 
			Descrição da Área de Utilização<br>
			<input type="text" class="texto1" name="au_descricao" style="width:600" maxlength="100" value="<%=rec("au_descricao")%>">&nbsp;&nbsp;
			</b>
      </td>
    </tr>
</table>
      </td>
    </tr>
	<tr class="texto1"><td>&nbsp;</td></tr>
    <tr> 
	<script>
	function func(){
	    document.formulario.action = "exc_areasutilizacao.asp";
		}
	</script>
      <td>
          <input type="submit" name="Submit" value=" Editar " class="texto1">  <input type="submit" name="Submit" value=" Excluir " class="texto1" onclick="func();">
      </td>
    </tr>
  </table>
</form>
<%
Else
    RW Tela.Mensagem.AcessoRestritoSCE()
End If

Call Tela.MostraRodape()
%>
