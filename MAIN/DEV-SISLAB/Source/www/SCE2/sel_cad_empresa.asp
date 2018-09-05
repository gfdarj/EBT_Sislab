<!------- SCE ------->
<!--#include file="includes/global_SCE.asp"-->
<!--#include file="includes/estado.asp" -->
<!------- SISLAB ---->
<!--#include file="../includes/bib_str.asp"-->
<!--#include file="../includes/padraoHTML.asp"-->
<!--#include file="../includes/global.asp" -->   <!-- constantes usada pelo menu -->
<!--#include file="../includes/Geral_Lib.asp"-->
<!--#include file="../includes/Sislab_Lib.asp"-->
<!------- LIB ------->
<!--#include file="../Lib/Classe_Combo.asp"-->
<%
Tela.SetNomeTela = "SCE > Consulta > Empresa" : Tela.SetCaminhoRelativo = "../"
Call Tela.MostraCabecalho()

If Env.UsuarioSCE() Then
    Dim Combo
    Set Combo = New TCombo

    Call Tela.ImprimeMenuSce()
%>
<script language=javascript>
function filtrar()
{
	var f = document.all.formulario;

	if((f.txtCNPJ.value == '') && (f.txtDescricao.value == ''))
	{
		alert('Preencha um dos critérios da pesquisa.');
		f.txtCNPJ.focus();
	}
	else if(isNaN(f.txtCNPJ.value))
	{
		alert('O filtro CNPJ deve ser numérico e sem pontuação.');
		f.txtCNPJ.focus();
	}
	else
	{
		location.href = 'sel_cad_empresa.asp?CNPJ=' + f.txtCNPJ.value + '&DESC=' + f.txtDescricao.value;
	}
}
</script>
<form name="formulario" method="post" action="alt_empresas.asp">
  <table width="100%">
	<tr>
		<td class=texto>
		<%if request("msg") <> "" then
			if cint(request("msg")) = 1 then response.write "<b>Empresa alterada com sucesso</b><br>"
			if cint(request("msg")) = 2 then response.write "<b>Empresa excluída com sucesso</b><br>"
			response.write "<br>"
		end if%>
		</td>
	</tr>
   <tr>
	    <td class="texto">
			<table>
				<tr>
					<td class="destaque">Editar / Excluir Empresas Cadastradas</td>
				</tr>
				<tr><td>&nbsp;</td></tr>

				<tr>
					<td class="texto1"><b>Filtro</b></td>
				</tr>
				<tr>
					<td class="texto1">
						Cnpj: <input type="Text" name="txtCNPJ" class="texto1" size="15" maxlength="14">
						&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
						Descrição: <input type="Text" name="txtDescricao" size="40" maxlength="50" class="texto1">
						&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
						<input type="Button" value="Filtrar" onclick="javascript:filtrar();" class="texto1">
					</td>
				</tr>

				<tr><td>&nbsp;</td></tr>

<%
If request("CNPJ") <> "" Or request("Desc") <> "" Then
%>
				<tr>
					<td valign="top" class=texto>
<%RW Combo.FornecedorFiltroCnpjDescricao("enf_id", "", false, "", true, request("CNPJ"), request("Desc"))%>
					<script language="JavaScript">document.all.enf_id.size = 20;</script>
					</td>
				</tr>
				<tr><td>&nbsp;</td></tr>
				<tr>
					<td class="texto"><%if a <> 1 then%><input type="submit" value=" Alterar " class="texto1"><%end if%></td>
			    </tr>
<%
End If
%>
			</table>
		</td>
	</tr>
 </table>
</form>
</center>

<script language="javascript">
//document.forms(0).enf_id[0].selected = true;
</script>
<%
Else
    RW Tela.Mensagem.AcessoRestritoSCE()
End If

Call Tela.MostraRodape()
%>
