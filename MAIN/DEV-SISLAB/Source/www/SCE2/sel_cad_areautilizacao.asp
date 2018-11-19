<!------- SCE ------->
<!--#include file="includes/global_SCE.asp"-->
<!------- SISLAB ---->
<!--#include file="../includes/bib_str.asp"-->
<!--#include file="../includes/padraoHTML.asp"-->
<!--#include file="../includes/global.asp" -->   <!-- constantes usada pelo menu -->
<!--#include file="../includes/Geral_Lib.asp"-->
<!--#include file="../includes/Sislab_Lib.asp"-->
<%
Tela.SetNomeTela = "SCE > Consulta > Área de Utilização" : Tela.SetCaminhoRelativo = "../"
Call Tela.MostraCabecalho()

If Env.UsuarioSCE() Then
    Call Tela.ImprimeMenuSce()
%>
<script type="text/javascript">
    function navselecao()
    {
        document.formulario.submit();
    }
</script>
<div class="margem-10">
<form name="formulario" method="post" action="alt_areasutilizacao.asp">
<table class="largura-total">
	<tr>
		<td >
		<%if request("msg") <> "" then
			if cint(request("msg")) = 1 then response.write "Area de Utilização alterada com sucesso!<br><br>"
			if cint(request("msg")) = 2 then response.write "Area de Utilização excluída com sucesso!<br><br>"
		end if%>
		</td>
	</tr>
  	<tr>
	    <th>Editar Areas de Utilização Cadastradas:</th>
	</tr>
	<tr><td >&nbsp;</td></tr>
	<tr>
		<td valign="top" valign="middle" >
		<%ssql = "select * from sce_areautilizacao order by au_descricao"
		set rec = Env.oconn.execute(ssql)
		if not rec.eof then%>
			<select name="au_id" size="15"  style="width:600">
			<%while not rec.eof%>
				<option value="<%=rec("au_id")%>"><%=rec("au_descricao")%></option>
				<%rec.movenext
			wend%>
			</select>
		<%else
			response.write "Não Existem Areas de Utilização Cadastradas No Momento."
		end if%>
		</td>
    </tr>
	<tr><td >&nbsp;</td></tr>
	<tr>
	    <td  valign="middle"><input type=submit value=" Alterar " ></td>
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
