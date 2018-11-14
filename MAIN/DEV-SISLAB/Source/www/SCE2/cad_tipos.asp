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
Tela.SetNomeTela = "SCE > Cadastro > Família / Tipo" : Tela.SetCaminhoRelativo = "../"
Call Tela.MostraCabecalho()

If Env.UsuarioSCE() Then
    Dim Combo
    Set Combo = New TCombo

    Call Tela.ImprimeMenuSce()
%>
<script type="text/javascript">
function ValidaCampos()
{
	var frm = document.formulario;
	if (frm.tipo_descricao.value.length == 0)
	{
		alert('Defina a Descrição da Família Tipo!')
		frm.tipo_descricao.focus();
		return false;
	}
	return true;
}
</script>
<form method=post action="cad_tipos2.asp" name="formulario"  onsubmit="return ValidaCampos();">
<table width="100%">
	<tr>
		<td ><%
		msg = request("msg")
		if msg  = 1 then
		response.write "Tipo cadastrado com sucesso!<br><br>"
		elseif msg = 2 then
		response.write "Tipo já existente!<br><br>"
		end if%></td>
	</tr> 
	<tr >
		<td>Filho de:&nbsp;<br>
			<%RW Combo.PadraoSql("super_tipo", "select tipo_id as VALOR, tipo_descricao as DESCRICAO from sce_tipos order by tipo_descricao", "", "N")%>
		</td>
	</tr>
	<tr ><td>&nbsp;</td></tr>
	<tr ><td>Tipo:<br><input type="text"  name="tipo_descricao" style="width:600" maxlength="100"></td></tr>
	<tr ><td>&nbsp;</td></tr>
	<tr><td><input type="submit" name="Submit" value=" Cadastrar " ></td></tr>
 </table>
</form>
<%
Else
    RW Tela.Mensagem.AcessoRestritoSCE()
End If

Call Tela.MostraRodape()
%>