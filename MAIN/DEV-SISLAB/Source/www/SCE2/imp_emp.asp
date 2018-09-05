<!------- SCE ------->
<!--#include file="includes/global_SCE.asp"-->
<!--#include file="includes/estado.asp"-->
<!------- SISLAB ---->
<!--#include file="../includes/bib_str.asp"-->
<!--#include file="../includes/padraoHTML.asp"-->
<!--#include file="../includes/global.asp" -->   <!-- constantes usada pelo menu -->
<!--#include file="../includes/Geral_Lib.asp"-->
<!--#include file="../includes/Sislab_Lib.asp"-->
<%
Tela.SetNomeTela = "SCE > Relatório > Empresa" : Tela.SetCaminhoRelativo = "../"
Call Tela.MostraCabecalho()

If Env.UsuarioSCE() Then

    Call Tela.ImprimeMenuSce()
%>
<script language=javascript>
function navselecao()
{
    document.formulario.submit();
}
</script>
<form name="formulario" method="post" action="imp_emp2.asp">
<table width="100%" class="texto1">
	<tr>
	    <td class="texto1">
			<table cellpadding="0" cellspacing="0">
				<tr>
					<td valign="top" class="texto1">
					Empresa:&nbsp;<input type=text name=enf_nome class="texto1">
					</td>
					<td width="40px"></td>
					<td valign="top" class="texto1">
					CNPJ:&nbsp;<input type=text name=enf_cnpj class="texto1">
					</td>
				<tr>
				<tr><td class="texto1">&nbsp;</td></tr>
				<tr>
					<td valign="top" class="texto1">
					Cidade:&nbsp;<input type=text name=enf_cidade class="texto1">
					</td>
					<td width="40px"></td>
					<td valign="top" class="texto1">
					Inscrição Estadual:&nbsp;<input type=text name=enf_ie class="texto1">
					</td>
				<tr>
				<tr><td class="texto1">&nbsp;</td></tr>
				<tr>
					<td valign="top" class="texto1">
					Estado:&nbsp;
					<select name="enf_uf" class="texto1">
						<option value=""></option>
              			<% for i =1 to 27 %>
			           <option value="<%=i%>"><%=retestado(i)%></option>
					  <% next %>
           			 </select>
					</td>
			</table>
		</td>
	</tr>
	<tr><td class="texto1">&nbsp;</td></tr>
	<tr><td class="texto1"><input type=submit value=" Gerar " class="texto1"></td></tr>
 </table>
</form>
<%
Else
    RW Tela.Mensagem.AcessoRestritoSCE()
End If

Call Tela.MostraRodape()
%>