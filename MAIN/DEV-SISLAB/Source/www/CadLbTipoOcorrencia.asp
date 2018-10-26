<!--#include file="includes/Sislab_Lib.asp"-->
<!--#include file="includes/controlesHTML.asp" -->
<!--#include file="includes/PadraoHTML.asp" -->
<!--#include file="includes/global.asp" -->
<!--#include file="includes/funcoes.asp" -->
<%
Response.Addheader "Expires","Mon, 26 Jul 1997 05:00:00 GMT" 
Response.Addheader "Cache-Control","no-cache, must-revalidate" 
Response.Addheader "Pragma","no-cache" 

Tela.SetMostraMenu = MENU_ON
Tela.SetMostraImagem = True
Tela.SetNomeTela = "Cadastro de Tipo de Ocorrência do LogBook"
Tela.SetLinkVoltar = "location.href='sislab.asp'"
Call Tela.MostraCabecalho()
''''call imprimeCabecalho2(TITULO_SITE, MENU_ON, true, "", "Cadastro de Tipo de Ocorrência do LogBook", "location.href='sislab.asp'", "")

If not Env.ehRAT Then
	RESPONSE.REDIRECT "INDEX.ASP"
End If
%>
<body bgcolor="#FFFFFF" topmargin=0 leftmargin=0>
<script language="javascript" src="includes/anexo.js"></script>
<script>
function Buscar(){
	var frm = document.forms[0];
	frm.action = "CadLbTipoOcorrencia.asp";
	frm.method = "POST";
	frm.target = "_parent";
	frm.ehNovoTipoOcorrencia.value = 0;
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

	frm.action = "CadLbTipoOcorrenciaA.asp";
	frm.method = "POST";
	frm.target = "_parent";
	frm.submit();
}
function IncluirNovo(){
	var frm = document.forms[0];
	frm.ehNovoTipoOcorrencia.value = 1;
	frm.desc.value = "";
	frm.desc.focus();
	frm.tipoocorrencia.value = "";
	frm.btnIncluir.disabled = true;
	frm.btnSalvar.disabled = false;
	frm.btnCancelar.disabled = false;	
}
function Excluir() {
	var frm = document.forms[0];
	if(frm.tipoocorrencia.value == '') {
		alert('Nenhum tipo de ocorrência selecionado para exclusão !');
		frm.tipoocorrencia.focus();
	}
	else {
		frm.excluir.value = '1';
		frm.action = "CadLbTipoOcorrenciaA.asp";
		frm.target = "_parent";
		frm.submit();
	}
}
</script>
<form method="post" action="CadLbTipoOcorrenciaA.asp" name="frm">
<input type="hidden" name="ehNovoTipoOcorrencia" value="0">
<input type="hidden" name="excluir" value="0">
<table border="0" width="100%" cellpadding="2" cellspacing="0" class="table-bordered">
<tr> 
	<td colspan="2">&nbsp;<span class="texto-vermelho-bold"><b>*</span>&nbsp; Indica um Campo Obrigatório</b></td>
</tr>

<tr><td colspan="2">&nbsp;</td></tr>

<tr><th align="left" colspan="2">&nbsp;&nbsp;Tipos de Ocorrência no LogBook</td></tr>

<tr>
	<td width="130px">&nbsp;&nbsp;<b>Tipo de Ocorrência:</b></td>
	<td>
		<%call comboBDSQL("tipoocorrencia", Env.oConn, "SELECT LBTO_ID as valor, LBTO_DESCRICAO as descricao FROM LB_TipoOcorrencia ORDER BY LBTO_DESCRICAO", "N", true)%>
		&nbsp;&nbsp;
		<input class="texto1" type="button" value="Buscar" onclick="Buscar();">
	</td>
</tr>

<tr><td colspan="2">&nbsp;</td></tr>

<tr><th align="left" colspan="2">&nbsp;&nbsp;Dados do Tipo de Ocorrência</th></tr>

<tr>
	<td width="130px">&nbsp;<span class="texto-vermelho-bold"><b>*</span>&nbsp;Descrição :</b></td>
	<td><input type="text" name="desc" size="60" class="texto1"></td>
<tr>

<tr><td colspan="2">&nbsp;</td></tr>

<tr>
	<td colspan="2">&nbsp;&nbsp;
		<input type="button" onclick="ValidaCampos()" value=" Salvar Dados " name="btnSalvar">
		<input type="button" onclick="IncluirNovo()" value=" Incluir " name="btnIncluir">
		<input type="button" onclick="Excluir()" value=" Excluir " name="btnExcluir">
		<input type="button" onclick="Cancela()" value=" Cancelar " name="btnCancelar">
	</td>
</tr>
</table>
</form>
<iframe width="770" height="200" name="escondido" style="display: none;"></iframe>
<script>
var frm = document.forms[0]
var frmAll = document.all
<%
tipoocorrencia = request("tipoocorrencia")
if tipoocorrencia <> "" then
	ssql = "select * from LB_TipoOcorrencia where LBTO_id = " & tipoocorrencia & ""
	'response.write ssql
	'response.end
	call Env.RecordSet( true, objSiteRS, sSQL)
	if objSiteRS.eof = false then%>
		frm.btnIncluir.disabled = false;
		frm.tipoocorrencia.value = '<%=ucase(objSiteRS("LBTO_ID"))%>'
		frm.desc.value = '<%=ucase(objSiteRS("LBTO_DESCRICAO"))%>'
	<%else%>
		frm.btnSalvar.disabled = true;
		frm.btnCancelar.disabled = true;	
	<%end if
else%>
	frm.btnSalvar.disabled = true;
	frm.btnCancelar.disabled = true;	
<%end if%>

</script>
<%
Call Tela.MostraRodape()
%>
