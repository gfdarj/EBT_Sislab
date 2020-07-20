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
Tela.SetNomeTela = "Cadastro > Família / Tipo" : Tela.SetCaminhoRelativo = "../"
Call Tela.MostraCabecalho()

If Env.UsuarioSCE() Then
    Dim Combo
    Set Combo = New TCombo

    'Call Tela.ImprimeMenuSce()
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

<div class="margem-10">
    <form method=post action="cad_tipos2.asp" name="formulario"  onsubmit="return ValidaCampos();">
        <table class="largura-total">
	    <tr>
		    <td><%
		        msg = request("msg")
		        If msg  = 1 Then
		            Response.Write "Tipo cadastrado com sucesso!<br><br>"
		        ElseIf msg = 2 Then
		            Response.Write "Tipo já existente!<br><br>"
		        End If %>
		    </td>
	    </tr> 
	    <tr>
		    <td>
                Filho de:&nbsp;<br>
			    <%RW Combo.PadraoSql("super_tipo", "select tipo_id as VALOR, tipo_descricao as DESCRICAO from sce_tipos order by tipo_descricao", "", "N")%>
		    </td>
	    </tr>
	    <tr><td>&nbsp;</td></tr>
	    <tr><td>Tipo:<br><input type="text" name="tipo_descricao" style="width:600" maxlength="100"></td></tr>
	    <tr><td>&nbsp;</td></tr>
	    <tr><td><input type="submit" class="btn btn-primary" name="Submit" value="Cadastrar" ></td></tr>
     </table>
    </form>
</div>
<%
Else
    RW Tela.Mensagem.AcessoRestritoSCE()
End If

Call Tela.MostraRodape()
%>