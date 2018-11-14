<!------- SCE ------->
<!--#include file="includes/global_SCE.asp"-->
<!------- SISLAB ---->
<!--#include file="../includes/bib_str.asp"-->
<!--#include file="../includes/padraoHTML.asp"-->
<!--#include file="../includes/global.asp" -->   <!-- constantes usada pelo menu -->
<!--#include file="../includes/Geral_Lib.asp"-->
<!--#include file="../includes/Sislab_Lib.asp"-->
<!------- LIB ------->
<!--#include file="../Classes/Classe_Combo.asp"-->
<%
Tela.SetNomeTela = "SCE > Relatório > Passagem de Carga"
Tela.SetCaminhoRelativo = "../"

Call Tela.MostraCabecalho()

If Env.UsuarioSCE() Then
    Dim Combo
    Set Combo = New TCombo

    Call Tela.ImprimeMenuSce()
%>
<form name="formulario" action="rel_pas2.asp" method="post">
<table width="100%" >
<tr>
	<td>Agendamento:<br>
		<%=Combo.MeusAgendamentos(False, "txtAS", "ag_numero", "", "N")%>

	</td>
</tr>
<tr><td>&nbsp;</td></tr>
<tr>
	<td>Responsável<br>
	<%=Combo.UserCRT("ag_responsavel", "N")%>
	</td>
</tr>
<tr><td>&nbsp;</td></tr>
<tr><td><input type="submit"  value=" Gerar "></td></tr>
</table>
</form>
<%
Else
    RW Tela.Mensagem.AcessoRestritoSCE()
End If

Call Tela.MostraRodape()
%>
