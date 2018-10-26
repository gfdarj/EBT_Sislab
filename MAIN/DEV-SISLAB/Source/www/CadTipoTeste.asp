<!--#include file="includes/Sislab_Lib.asp"-->
<!-- #include file="includes/controlesHTML.asp" -->
<!-- #include file="includes/PadraoHTML.asp" -->
<!-- #include file="includes/global.asp" -->
<!-- #include file="includes/funcoes.asp" -->
<%
Tela.SetMostraMenu = MENU_ON
Tela.SetMostraImagem = True
Tela.SetNomeTela = "Cadastro de Tipo de Testes"
Tela.SetLinkVoltar = "location.href='sislab.asp'"
Call Tela.MostraCabecalho()
'''''Call Tela.ImprimeCabecalho2(TITULO_SITE, MENU_ON, true, "", "Cadastro de Tipo de Testes", "location.href='sislab.asp'", "")

if not Env.ehRAT then RESPONSE.REDIRECT "INDEX.ASP"
%>
<script language="javascript" src="includes/anexo.js"></script>
<script>
function BuscarUsuario(){
	var frm = document.forms[0];
	frm.action = "CadTipoTeste.asp";
	frm.method = "POST";
	frm.target = "_parent";
	frm.ehNovoTipoTeste.value = 0;
	frm.submit();
	frm.btnSalvar.disabled = false;
	frm.btnCancelar.disabled = false;	

}
function Cancela(){
	var frm = document.forms[0];
	frm.action = "sislab.asp";
	frm.method = "POST";
	frm.target = "_parent";
	frm.submit();
}
function ValidaCampos(){
	var frm = document.forms[0];
	if (frm.desc.value == ""){
		alert('É necessário informar a Descrição.');
		frm.desc.focus();
		return false
	}
	frm.action = "CadTipoTesteA.asp";
	frm.method = "POST";
	frm.target = "_parent";
	frm.submit();
}
function IncluirNovo(){
	var frm = document.forms[0];
	frm.ehNovoTipoTeste.value = 1;
	frm.desc.value = "";
	frm.desc.focus();
	frm.tipoteste.value = "";
	frm.btnIncluir.disabled = true;
	frm.btnExcluir.disabled = true;
	frm.btnSalvar.disabled = false;
	frm.btnCancelar.disabled = false;	

}
function Excluir() {
	var frm = document.forms[0];
	if(frm.tipoteste.value == '') {
		alert('Nenhum tipo de teste para exclusão !');
		frm.tipoteste.focus();
	}
	else {
		frm.excluir.value = '1';
		frm.action = "CadTipoTesteA.asp";
		frm.target = "_parent";
		frm.submit();
	}
}
</script>
<form method="post" action="CadTipoTesteA.asp" name="frm">
<input type="hidden" name="ehNovoTipoTeste" value="0">
<input type="hidden" name="excluir" value="0">
<table border="0" width="100%" cellpadding="2" cellspacing="0" class="table-bordered">
<tr> 
	<td colspan="2">
		&nbsp;<span class="texto-vermelho-bold"><b>Atenção na exclusão de uma especificações pois alguns relatórios podem ser prejudicados !</b></span>
		<br><br>
		&nbsp;<span class="texto-vermelho-bold"><b>*</span>&nbsp; Indica um Campo Obrigatório</b>
	</td>
</tr>

<tr><td colspan="2">&nbsp;</td></tr>

<tr><th align="left" colspan="2">Tipos de Atividades</td></tr>

<tr>
	<td width="120px">&nbsp;&nbsp;<b>Tipo de Atividade:</b></td>
	<td>
		<%call comboTipoTeste("tipoteste", Env.oConn, "", "N")%>&nbsp;&nbsp;
		<input  class="combo" type="button" value="Buscar" onclick="BuscarUsuario();">
	</td>
</tr>

<tr><td colspan="2">&nbsp;</td></tr>

<tr><th align="left" colspan="2">&nbsp;&nbsp;Dados do Tipo de Teste</th></tr>

<tr>
	<td width="100px">&nbsp;<span class="texto-vermelho-bold"><b>*</span>&nbsp;Descrição :</b></td>
	<td><input type="text" name="desc" size="60" class="texto1"></td>
<tr>

<tr><td colspan="2">&nbsp;</td></tr>

<tr>
	<td colspan="2">&nbsp;&nbsp;
		<input type="button" onclick="ValidaCampos()" value=" &nbsp;Salvar Dados&nbsp;" name="btnSalvar">
		<input type="button" onclick="IncluirNovo()" value=" &nbsp;&nbsp;Incluir &nbsp;&nbsp;" name="btnIncluir">
		<input type="button" onclick="Excluir()" value=" Excluir " name="btnExcluir">
		<input type="button" onclick="Cancela()" value=" &nbsp;&nbsp;Cancelar&nbsp;&nbsp;" name="btnCancelar">
	</td>
</tr>
</table>
</form>
<iframe width="770" height="200" name="escondido" style="display: none;"></iframe>
<script>
var frm = document.forms[0]
var frmAll = document.all;
<%
Dim tipoteste
tipoteste = request("tipoteste")
if tipoteste <> "" then
	ssql = "select * from Tipo_Teste where TIT_id = " & tipoteste & ""
'	response.write ssql
'	response.end
	call Env.RecordSet( true, objSiteRS, sSQL)
	if not objSiteRS.eof then%>
		frm.btnIncluir.disabled = false;
		frm.btnExcluir.disabled = false;
		frm.tipoteste.value = '<%=(objSiteRS("tit_id"))%>';
		frm.desc.value = '<%=(objSiteRS("tit_descricao"))%>';
<%	else%>
		frm.btnSalvar.disabled = true;
		frm.btnCancelar.disabled = true;	
<%	end if
else%>
	frm.btnSalvar.disabled = true;
	frm.btnCancelar.disabled = true;	
<%end if%>

</script>
<%
Call Tela.MostraRodape()
%>
