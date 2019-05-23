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
Tela.SetNomeTela = "Consulta > Família Tipo" : Tela.SetCaminhoRelativo = "../"
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
<form name="formulario" method="post" action="alt_tipos.asp">
<table class="largura-total">
	<tr>
		<td class=texto>
		<%if request("msg") <> "" then
			if cint(request("msg")) = 1 then response.write "Família Tipo alterada com sucesso!<br><br>"
			if cint(request("msg")) = 2 then response.write "Família Tipo excluída com sucesso!<br><br>"
		end if%></td>
	</tr> 
   <tr>
	    <th>Editar / Excluir Família Tipo :</th>
	</tr>
	<tr><td >&nbsp;</td></tr>
	<tr>
		<td valign="top" >
			<%ssql = "select * from sce_tipos order by tipo_descricao"
			set rec = Env.oconn.execute(ssql)
			if not rec.eof then%>
				<select name="tipo_id" size="15"  style="width:600">
				<%while not rec.eof%>
					<option value="<%=rec("tipo_id")%>"><%=rec("tipo_descricao")%></option>
					<%rec.movenext
				wend%>
				</select>
			<%else%>
				Não Existem Familia Tipo Cadastrada No Momento.
			<%end if%>
		</td>		
    </tr>
	<tr><td >&nbsp;</td></tr>
	<tr>
		<td valign=top ><input type=submit value=" Editar " ></td>
	</tr>
  </table>
    <br />
</form>
</div>
<%
Else
    RW Tela.Mensagem.AcessoRestritoSCE()
End If

Call Tela.MostraRodape()
%>
