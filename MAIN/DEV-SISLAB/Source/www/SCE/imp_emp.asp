<!--#include file="../includes/global.asp" -->   <!-- constantes usada pelo menu -->
<!--#include file="includes/padraoHTML.asp"-->
<!-- #INCLUDE FILE="includes/estado.asp" -->
<%
call ImprimeCabecalho ("", MENU_ON, true, "Relatório de Empresas", "", "history.go(-1);")
%>
<script language=javascript>
function navselecao()
{
    document.formulario.submit();
}
</script>
<form name="formulario" method="post" action="imp_emp2.asp">
<table width="100%">
	<tr>
	    <td class="texto">
			<table cellpadding="0" cellspacing="0">
				<tr>
					<td valign="top" class=texto>
					Empresa:&nbsp;<input type=text name=enf_nome class=form>
					</td>
					<td width="40px"></td>
					<td valign="top" class=texto>
					CNPJ:&nbsp;<input type=text name=enf_cnpj class=form>
					</td>
				<tr>
				<tr><td class="texto">&nbsp;</td></tr>
				<tr>
					<td valign="top" class=texto>
					Cidade:&nbsp;<input type=text name=enf_cidade class=form>
					</td>
					<td width="40px"></td>
					<td valign="top" class=texto>
					Inscrição Estadual:&nbsp;<input type=text name=enf_ie class=form>
					</td>
				<tr>
				<tr><td class="texto">&nbsp;</td></tr>
				<tr>
					<td valign="top" class=texto>
					Estado:&nbsp;
					<select name="enf_uf" class="form">
						<option value=""></option>
              			<% for i =1 to 27 %>
			           <option value="<%=i%>"><%=retestado(i)%></option>
					  <% next %>
           			 </select>
					</td>
			</table>
		</td>
	</tr>
	<tr><td class="texto">&nbsp;</td></tr>
	<tr><td class="texto"><input type=submit value=" Gerar " class=form></td></tr>
 </table>
</form>
<%
call ImprimeRodape (RODAPE_OFF)
%>