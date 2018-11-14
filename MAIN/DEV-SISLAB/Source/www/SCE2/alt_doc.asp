<!------- SCE ------->
<!--#include file="includes/global_SCE.asp"-->
<!------- SISLAB ---->
<!--#include file="../includes/bib_str.asp"-->
<!--#include file="../includes/padraoHTML.asp"-->
<!--#include file="../includes/global.asp" -->   <!-- constantes usada pelo menu -->
<!--#include file="../includes/Geral_Lib.asp"-->
<!--#include file="../includes/Sislab_Lib.asp"-->
<%
Tela.SetNomeTela = "SCE > Consulta > Documento" : Tela.SetCaminhoRelativo = "../"
Call Tela.MostraCabecalho()

If Env.UsuarioSCE() Then
    Call Tela.ImprimeMenuSce()
%>
<script>
	<!--#include file="includes/vform.js"-->
</script>
<form method=post action="alt_doc2.asp" name="formulario">
<table width="100%">
	<tr>
		<td >
		<%if request("msg")<>"" then 
			if cint(request("msg")) = 1 then response.write "<br><strong>Documento alterado com sucesso!</strong><br><br>"
			if cint(request("msg")) = 2 then response.write "<br><strong>Documento excluído com sucesso!</strong><br><br>"
		end if%></td>
	</tr>
    <tr>
	    <td class="destaque">Edição de Documentos</td>
    </tr>
	<tr><td >&nbsp;</td></tr>
	<tr>
		<td valign="top" valign="middle" >
		<%ssql = "select * from sce_documentacao order by doc_id"
		set rec = Env.oconn.execute(ssql)
		if not rec.eof then%>
			<select name="doc_id" size="15"  style="width:600">
			<%while not rec.eof%>
				<option value="<%=rec("doc_id")%>"><%=Zeros(rec("doc_id"),4)%> / Resp: <%=rec("doc_responsavel")%> / Cliente: <%=rec("DOC_NOME")%></option>
				<%rec.movenext
			wend%>
			</select>
		<%else
			response.write "Não Existe Documentação Cadastradas No Momento."
		end if%>
		</td>
    </tr>
	<tr><td >&nbsp;</td></tr>
	<tr>
	    <td valign="middle" class="titulo"><input type="submit" value=" Editar " ></td>
	</tr>
 </table>
 </form>
<%
Else
    RW Tela.Mensagem.AcessoRestritoSCE()
End If

Call Tela.MostraRodape()
%>
