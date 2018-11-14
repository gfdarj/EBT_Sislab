<!------- SCE ------->
<!--#include file="includes/global_SCE.asp"-->
<!------- SISLAB ---->
<!--#include file="../includes/bib_str.asp"-->
<!--#include file="../includes/padraoHTML.asp"-->
<!--#include file="../includes/global.asp" -->   <!-- constantes usada pelo menu -->
<!--#include file="../includes/Geral_Lib.asp"-->
<!--#include file="../includes/Sislab_Lib.asp"-->
<%
Tela.SetNomeTela = "SCE > Relatório > Termo de Responsabilidade" : Tela.SetCaminhoRelativo = "../"
Call Tela.MostraCabecalho()

If Env.UsuarioSCE() Then

    Call Tela.ImprimeMenuSce()
%>

<script type="text/javascript">
function geraTermo() {
	if(document.all.doc_id.value == "") {
		alert("Selecione um documento");
		document.all.doc_id.focus();
		return false;
	}
	else
		return true;
}
</script>
<form name="formulario" method="post" action="rel_termoresp2.asp" onsubmit="javascript:return geraTermo();" target="_blank">
<table width="100%"  cellpadding="2" cellspacing="0">
<tr>
	<td>
		Documento:&nbsp;
		<select name="doc_id" >
			<option value="">--</option><%
ssql = "select * from sce_documentacao order by doc_id"
set rec = Env.oconn.execute(ssql)
if not rec.eof then
	while not rec.eof%>
			<option value="<%=rec("doc_id")%>" <%if doc_id = CStr(rec("doc_id")) then response.write "selected"%>><%=Zeros(rec("doc_id"), 4)%></option>
<%		rec.movenext
	wend
end if%>
	</select>
	</td>
	<td>
		Título:&nbsp;
		<input  type="text" name="titulo" size="70" value="<b><u>Termo de Responsabilidade</u></b>">
	</td>
</tr>
<tr><td>&nbsp;</td></tr>
<tr>
	<td colspan="2">
		Descrição:<br>
		<textarea name="descricao" rows="12" cols="90">
	Declaro para os devidos fins que, o(s) material(is) abaixo relacionado(s) encontra(m)-se sob a minha responsabilidade e uso, estando "<b>NÃO CONFORME</b>" relativo ao <b>PR.5.8-004/DO.5.8-001</b> do <b>Manual da Qualidade do CRT</b>, e através deste, responsabilizo-me pela sua regularização no prazo de 03 dias úteis a contar desta data junto ao <b>Setor de Logística do CRT</b>, no que concerne a confecção da Nota Fiscal do(s) material(is), isentando a EMBRATEL S/A durante o período em que este se encontrar nas suas instalações, de toda e qualquer responsabilidade sobre pagamento de sinistros e/ou problemas técnicos que possam ocorrer no equipamento.
		</textarea>
	</td>
</tr>
<tr><td>&nbsp;</td></tr>
<tr>
	<td colspan="2">
	<input  type="submit" value=" Gerar Termo de Responsabilidade ">
	</td>
</table>
</form>
<%
Else
    RW Tela.Mensagem.AcessoRestritoSCE()
End If

Call Tela.MostraRodape()
%>
