<!------- SCE ------->
<!--#include file="includes/global_SCE.asp"-->
<!------- SISLAB ---->
<!--#include file="../includes/bib_str.asp"-->
<!--#include file="../includes/padraoHTML.asp"-->
<!--#include file="../includes/global.asp" -->   <!-- constantes usada pelo menu -->
<!--#include file="../includes/Geral_Lib.asp"-->
<!--#include file="../includes/Sislab_Lib.asp"-->
<%
Tela.SetNomeTela = "SCE > Consulta > Natureza de Operação" : Tela.SetCaminhoRelativo = "../"
Call Tela.MostraCabecalho()

If Env.UsuarioSCE() Then
    'Dim Combo
    'Set Combo = New TCombo

    Call Tela.ImprimeMenuSce()
%>
<script language=javascript>
function navselecao()
{
    document.formulario.submit();
}
</script>
<form name="formulario" method="post" action="alt_no.asp">
<table>
	<tr>
		<div >
		<%if request("msg") <> "" then
			if cint(request("msg")) = 1 then response.write "Natureza de Operação alterada com sucesso.<br><br>"
			if cint(request("msg")) = 2 then response.write "Natureza de Operação excluída com sucesso.<br><br>"
		end if
		%></div></td>
	</tr> 
    <tr> 
		<td class="destaque">Editar / Excluir Natureza de Operação</td>
	</tr>
	<tr><td >&nbsp;</td></tr>
	<tr>
		<td VALIGN="TOP" >
			<%ssql = "select * from sce_natureza_operacao order by no_descricao"
			set rec = Env.oconn.execute(ssql)
			if not rec.eof then%>
				<select name="no_id" size="15"  style="width:600" >
				<%while not rec.eof%>
					<option value="<%=rec("no_id")%>"><%=rec("no_descricao")%></option>
					<%rec.movenext
				wend%>
				</select>
			<%else
				response.write "Não existem Naturezas de Operação cadastradas no momento."
			end if%>
		</td>
	</tr>
	<tr>
		<td class="texto" align="left"><br><br><input type=submit value=" Editar " ></td>
    </tr>
  </table>
</form>
<%
Else
    RW Tela.Mensagem.AcessoRestritoSCE()
End If

Call Tela.MostraRodape()
%>
