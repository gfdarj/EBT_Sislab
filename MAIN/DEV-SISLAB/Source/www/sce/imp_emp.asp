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
Tela.SCE = True
Tela.SetNomeTela = "Relatório > Empresa" : Tela.SetCaminhoRelativo = "../"
Call Tela.MostraCabecalho()

If Env.UsuarioSCE() Then

    'Call Tela.ImprimeMenuSce()
%>
<script type="text/javascript">
function navselecao()
{
    document.formulario.submit();
}
</script>
<div class="margem-10">
<form name="formulario" method="post" action="imp_emp2.asp">
<table class="largura-total">
	<tr>
	    <td >
			<table>
				<tr>
					<td>
					Empresa:&nbsp;<input type=text name=enf_nome >
					</td>
					<td width="40px"></td>
					<td>
					CNPJ:&nbsp;<input type=text name=enf_cnpj >
					</td>
				<tr>
				<tr><td>&nbsp;</td></tr>
				<tr>
					<td>
					Cidade:&nbsp;<input type=text name=enf_cidade >
					</td>
					<td width="40px"></td>
					<td>
					Inscrição Estadual:&nbsp;<input type=text name=enf_ie >
					</td>
				<tr>
				<tr><td >&nbsp;</td></tr>
				<tr>
					<td>
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
	<tr><td>&nbsp;</td></tr>
	<tr><td><input type=submit value=" Gerar Relatório " ></td></tr>
 </table>
</form>
<br />
</div>
<%
Else
    RW Tela.Mensagem.AcessoRestritoSCE()
End If

Call Tela.MostraRodape()
%>