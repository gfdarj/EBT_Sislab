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
Tela.SetNomeTela = "Cadastro > Área de utilização" : Tela.SetCaminhoRelativo = "../"
Call Tela.MostraCabecalho()

If Env.UsuarioSCE() Then
    'Call Tela.ImprimeMenuSce()
%>
<script type="text/javascript">
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
<div class="margem-10">
    <form method=post action="Cad_areasutilizacao2.asp" name="formulario"  onsubmit="return ValidaCampos();">
        <input type="hidden" name="tipocomando" value="">
        <input type="hidden" name="au_id" value="">

        <table class="largura-total">
	        <tr>
		        <td>
		        <%if request("msg") <> "" then response.write "Área cadastrada com sucesso!<br><br>"%></td>
	        </tr>
	        <tr> 
		        <td>
			        Descrição da Área de Utilização<br>
			        <input type="text"  name="au_descricao" size="70"  maxlength="50">
		        </td>
	        </tr> 
	        <tr ><td>&nbsp;</td></tr>
	        <tr >
		        <td><input type="submit" name="Submit" value=" Cadastrar " ></td>
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