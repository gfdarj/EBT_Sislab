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
Tela.SetNomeTela = "Cadastro > Consulta Fabricantes" : Tela.SetCaminhoRelativo = "../"
Call Tela.MostraCabecalho()

If Env.UsuarioSCE() Then
    'Dim Combo
    'Set Combo = New TCombo

    'Call Tela.ImprimeMenuSce()
%>
<script type="text/javascript">
    function navselecao()
    {
        document.formulario.submit();
    }
</script>
<div class="margem-10">
<form name="formulario" method="post" action="alt_fab2.asp">
<table class="largura-total">
	<tr>
		<td>
		<%if request("msg") <> "" then
			if cint(request("msg")) = 1 then response.write "Fabricante alterado com sucesso<br><br>"
			if cint(request("msg")) = 2 then response.write "Fabricante excluído com sucesso<br><br>"
		end if%></td>
	</tr>
   <tr>
	    <td >
			<table>
				<tr>
					<th>Editar / Excluir Fabricantes Cadastrados</th>
				</tr>
				<tr><td >&nbsp;</td></tr>
				<tr>
					<td valign="top" >
						<%ssql = "select * from sce_fabricantes order by fab_nome"
						set rec = Env.oconn.execute(ssql)
						if not rec.eof then%>
							<select name="fab_id" size="15"  style="width:600px">
							<%while not rec.eof%>
				<option value="<%=rec("fab_id")%>"><%=rec("fab_nome")%></option>
								<%rec.movenext
							wend%>
							</select>
						<%else
							a = 1
							response.write "Não existem Fabricantes cadastradas no momento."
						end if%>
					</td>
				</tr>
				<tr><td >&nbsp;</td></tr>
				<tr>
					<td ><%if a <> 1 then%><input type=submit value=" Alterar " ><%end if%></td>
			    </tr>
			</table>
		</td>
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
