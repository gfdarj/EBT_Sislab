<!--#include file="includes/Sislab_Lib.asp"-->
<!-- #include file="includes/controlesHTML.asp" -->
<!-- #include file="includes/PadraoHTML.asp" -->
<!-- #include file="includes/global.asp" -->
<!-- #include file="includes/funcoes.asp" -->
<%
call imprimeCabecalho2(TITULO_SITE, MENU_ON, true, "", "Cadastro de Tipo de Atividade", "location.href='sislab.asp'", "")

if not Env.ehRAT then RESPONSE.REDIRECT "INDEX.ASP"
%>
<script language="javascript" src="includes/anexo.js"></script>
<script>
function BuscarUsuario(){
	var frm = document.forms[0];
	frm.action = "CadTipoAtividade.asp";
	frm.method = "POST";
	frm.target = "_parent";
	frm.ehNovoTipoAtividade.value = 0;
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
	frm.action = "CadTipoAtividadeA.asp";
	frm.method = "POST";
	frm.target = "_parent";
	frm.submit();
}
function IncluirNovo(){
	var frm = document.forms[0];
	frm.ehNovoTipoAtividade.value = 1;
	frm.desc.value = "";
	frm.desc.focus();
	frm.tipoativ.value = "";
	frm.btnIncluir.disabled = true;
	frm.btnExcluir.disabled = true;
	frm.btnSalvar.disabled = false;
	frm.btnCancelar.disabled = false;	

}
function Excluir() {
	var frm = document.forms[0];
	if(frm.tipoativ.value == '') {
		alert('Nenhum tipo de atividade selecionada para exclusão !');
		frm.tipoativ.focus();
	}
	else {
		frm.excluir.value = '1';
		frm.action = "CadTipoAtividadeA.asp";
		frm.target = "_parent";
		frm.submit();
	}
}
</script>
<form method="post" action="CadTipoAtividadeA.asp" name="frm">
<input type="Hidden" name="ehNovoTipoAtividade" value="0">
<input type="Hidden" name="excluir" value="0">
<table border="0" width="100%" cellpadding="2" cellspacing="0" class="tabela1">
<tr> 
	<td colspan="2">&nbsp;<span class="vermelho2"><b>*</span>&nbsp; Indica um Campo Obrigatório</b></td>
</tr>

<tr><td colspan="2">&nbsp;</td></tr>

<tr><th align="left" colspan="2">Tipos de Atividades</td></tr>

<tr>
	<td width="120px">&nbsp;&nbsp;<b>Tipo de Atividade:</b></td>
	<td>
		<%call comboTipoAtividade("tipoativ", Env.oConn,"N")%>&nbsp;&nbsp;
		<input  class="combo" type="Button" value="Buscar" onclick="BuscarUsuario();">
	</td>
</tr>

<tr><td colspan="2">&nbsp;</td></tr>

<tr><th align="left" colspan="2">&nbsp;&nbsp;Dados do Tipo de Atividade</th></tr>

<tr>
	<td width="100px">&nbsp;<span class="vermelho2"><b>*</span>&nbsp;Descrição :</b></td>
	<td><input type="Text" name="desc" size="60" class="texto1"></td>
<tr>

<tr><td colspan="2">&nbsp;</td></tr>

<tr>
	<td colspan="2">&nbsp;&nbsp;
		<input type="Button" onclick="ValidaCampos()" value=" &nbsp;Salvar Dados&nbsp;" name="btnSalvar">
		<input type="Button" onclick="IncluirNovo()" value=" &nbsp;&nbsp;Incluir &nbsp;&nbsp;" name="btnIncluir">
		<input type="Button" onclick="Excluir()" value=" Excluir " name="btnExcluir">
		<input type="Button" onclick="Cancela()" value=" &nbsp;&nbsp;Cancelar&nbsp;&nbsp;" name="btnCancelar">
	</td>
</tr>
</table>
</form>
<iframe width="770" height="200" name="escondido" style="display: none;"></iframe>
<script>
var frm = document.forms[0]
var frmAll = document.all;
<%
Dim tipoativ
tipoativ = request("tipoativ")
if tipoativ <> "" then
	ssql = "select * from tipo_atividade where ta_id = " & tipoativ & ""
'	response.write ssql
'	response.end
	call Env.RecordSet( true, objSiteRS, sSQL)
	if not objSiteRS.eof then%>
		frm.btnIncluir.disabled = false;
		frm.btnExcluir.disabled = false;
		frm.tipoativ.value = '<%=(objSiteRS("ta_id"))%>';
		frm.desc.value = '<%=(objSiteRS("ta_descricao"))%>';
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
call imprimeRodape(RODAPE_OFF)
%>
