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
Tela.SetNomeTela = "Cadastro > Alterar Fabricante" : Tela.SetCaminhoRelativo = "../"
Call Tela.MostraCabecalho()

If Env.UsuarioSCE() Then
    'Dim Combo
    'Set Combo = New TCombo

    'Call Tela.ImprimeMenuSce()

ssql = "select * from sce_fabricantes where fab_id = "& request("fab_id")
set rec = Env.oconn.execute(ssql)
%>
<div class="margem-10">
<form method=post action="alt_fab3.asp" name="formulario">
<input type="hidden" name="fab_id" value="<%=request("fab_id")%>">
<table width="100%">
    <tr> 
		<td >Nome do Fabricante<br>
					<input type="text"  name="fab_nome" style="width:600px" maxlength="100" value="<%=rec("fab_nome")%>">
		</td>
	</tr>
	<script type="text/javascript">
	    function func2(){
		    document.formulario.action = "exc_fabricantes.asp";
	    }
	</script>
	<tr><td >&nbsp;</td></tr>
	<tr> 
		<td><input type="submit" class="btn btn-primary" name="Submit" value=" Alterar " >&nbsp;&nbsp;
		    <input type="submit" class="btn btn-primary" name="Submit" value=" Excluir "  onclick="func2();">
		</td>
    </tr>
</form>
</table>
</div>
<%
Else
    RW Tela.Mensagem.AcessoRestritoSCE()
End If

Call Tela.MostraRodape()
%>
