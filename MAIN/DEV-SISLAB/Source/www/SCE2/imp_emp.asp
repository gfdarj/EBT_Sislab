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
<table width="100%" >
	<tr>
	    <td >
			<table cellpadding="0" cellspacing="0">
				<tr>
					<td valign="top" >
					Empresa:&nbsp;<input type=text name=enf_nome >
					</td>
					<td width="40px"></td>
					<td valign="top" >
					CNPJ:&nbsp;<input type=text name=enf_cnpj >
					</td>
				<tr>
				<tr><td >&nbsp;</td></tr>
				<tr>
					<td valign="top" >
					Cidade:&nbsp;<input type=text name=enf_cidade >
					</td>
					<td width="40px"></td>
					<td valign="top" >
					Inscrição Estadual:&nbsp;<input type=text name=enf_ie >
					</td>
				<tr>
				<tr><td >&nbsp;</td></tr>
				<tr>
					<td valign="top" >
					Estado:&nbsp;
					<select name="enf_uf" >
						<option value=""></option>
              			<% for i =1 to 27 %>
			           <option value="<%=i%>"><%=retestado(i)%></option>
					  <% next %>
           			 </select>
					</td>
			</table>
		</td>
	</tr>
	<tr><td >&nbsp;</td></tr>
	<tr><td ><input type=submit value=" Gerar " ></td></tr>
 </table>
</form>
<%
Else
    RW Tela.Mensagem.AcessoRestritoSCE()
End If

Call Tela.MostraRodape()
%>