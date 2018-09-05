<!------- SCE ------->
<!--#include file="includes/global_SCE.asp"-->
<!------- SISLAB ---->
<!--#include file="../includes/bib_str.asp"-->
<!--#include file="../includes/padraoHTML.asp"-->
<!--#include file="../includes/global.asp" -->   <!-- constantes usada pelo menu -->
<!--#include file="../includes/Geral_Lib.asp"-->
<!--#include file="../includes/Sislab_Lib.asp"-->
<%
Tela.SetNomeTela = "SCE > Cadastro > Alterar Fabricante" : Tela.SetCaminhoRelativo = "../"
Call Tela.MostraCabecalho()

If Env.UsuarioSCE() Then
    'Dim Combo
    'Set Combo = New TCombo

    Call Tela.ImprimeMenuSce()

ssql = "select * from sce_fabricantes where fab_id = "& request("fab_id")
set rec = Env.oconn.execute(ssql)
%>
<form method=post action="alt_fab3.asp" name="formulario">
<input type="hidden" name="fab_id" value="<%=request("fab_id")%>">
<table width="100%">
    <tr> 
		<td class="texto1">Nome do Fabricante<br>
					<input type="text" class="texto1" name="fab_nome" style="width:600px" maxlength="100" value="<%=rec("fab_nome")%>">
		</td>
	</tr>
	<script>
	function func2(){
		document.formulario.action = "exc_fabricantes.asp"
	}
	</script>
	<tr><td class="texto1">&nbsp;</td></tr>
	<tr> 
		<td><input type="submit" name="Submit" value=" Alterar " class="texto1">&nbsp;&nbsp;
		    <input type="submit" name="Submit" value=" Excluir " class="texto1" onclick="func2();">
		</td>
    </tr>
</form>
</table>
<%
Else
    RW Tela.Mensagem.AcessoRestritoSCE()
End If

Call Tela.MostraRodape()
%>
