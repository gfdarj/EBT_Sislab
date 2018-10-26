<!--#include file="includes/Sislab_Lib.asp"-->
<!-- #include file="includes/controlesHTML.asp" -->
<!-- #include file="includes/PadraoHTML.asp" -->
<!-- #include file="includes/global.asp" -->
<!-- #include file="includes/funcoes.asp" -->
<%
Tela.SetMostraMenu = MENU_ON
Tela.SetMostraImagem = True
Tela.SetNomeTela = "Cadastro de Tecnologia"
Tela.SetLinkVoltar = "location.href='sislab.asp'"
Call Tela.MostraCabecalho()
''''Call Tela.ImprimeCabecalho2(TITULO_SITE, MENU_ON, true, "", "Cadastro de Tecnologia", "location.href='sislab.asp'", "")

if not Env.ehRAT then RESPONSE.REDIRECT "INDEX.ASP"
%>
<script language="javascript" src="includes/anexo.js"></script>
<script>
function BuscarUsuario(){
	var frm = document.forms[0];
	frm.action = "CadTecnologia.asp";
	frm.method = "POST";
	frm.target = "_parent";
	frm.ehNovaTecnologia.value = 0;
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
	frm.action = "CadTecnologiaA.asp";
	frm.method = "POST";
	frm.target = "_parent";
	frm.submit();
}
function IncluirNovo(){
	var frm = document.forms[0];
	frm.ehNovaTecnologia.value = 1;
	frm.desc.value = "";
	frm.at_id.value = "";
	frm.desc.focus();
	frm.tecnologia.value = "";
	frm.btnIncluir.disabled = true;
	frm.btnExcluir.disabled = true;
	frm.btnSalvar.disabled = false;
	frm.btnCancelar.disabled = false;	
}
function Excluir() {
	var frm = document.forms[0];
	if(frm.tecnologia.value == '') {
		alert('Nenhuma tecnologia selecionada para exclusão !');
		frm.tecnologia.focus();
	}
	else {
		frm.excluir.value = '1';
		frm.action = "CadTecnologiaA.asp";
		frm.target = "_parent";
		frm.submit();
	}
}
</script>
<form method="post" action="CadTecnologiaA.asp" name="frm">
<input type="hidden" name="ehNovaTecnologia" value="0">
<input type="hidden" name="excluir" value="0">
<table border="0" width="100%" cellpadding="2" cellspacing="0" class="table-bordered">
<tr> 
	<td colspan="2">&nbsp;<span class="texto-vermelho-bold"><b>*</span>&nbsp; Indica um Campo Obrigatório</b></td>
</tr>

<tr><td colspan="2">&nbsp;</td></tr>

<tr><th align="left" colspan="2">Tecnologias</td></tr>

<tr>
	<td width="130px">&nbsp;&nbsp;<b>Tecnologia:</b></td>
	<td>
		<%call comboTecnologia("tecnologia", Env.oConn,"N")%>&nbsp;&nbsp;
		<input  class="texto1" type="button" value="Buscar" onclick="BuscarUsuario();"></input>
	</td>
</tr>

<tr><td colspan="2">&nbsp;</td></tr>

<tr><th align="left" colspan="2">&nbsp;&nbsp;Dados da Área Tecnológica</th></tr>

<tr>
	<td width="130px">&nbsp;<span class="texto-vermelho-bold"><b>*</span>&nbsp;Descrição :</b></td>
	<td><input type="text" name="desc" size="60" class="texto1"></td>
<tr>

<tr>
	<td width="130px">&nbsp;&nbsp;<b>Área Tecnológica :</b></td>
	<td><%call comboAreaTecnologica("at_id", Env.oConn, "N")%></td>
<tr>

<tr><td colspan="2">&nbsp;</td></tr>

<tr>
	<td colspan="2">&nbsp;&nbsp;
		<input type="button" onclick="ValidaCampos()" value=" &nbsp;&nbsp;Salvar Dados&nbsp;&nbsp;" name="btnSalvar"/>
		<input type="button" onclick="IncluirNovo()" value=" &nbsp;&nbsp;Incluir &nbsp;&nbsp;" name="btnIncluir"/>
		<input type="button" onclick="Excluir()" value=" Excluir " name="btnExcluir">
		<input type="button" onclick="Cancela()" value=" &nbsp;&nbsp;Cancelar&nbsp;&nbsp;" name="btnCancelar"/>
	</td>
</tr>
</table>
</form>
<iframe width="770" height="200" name="escondido" style="display: none;"></iframe>
<script>
var frm = document.forms[0]
var frmAll = document.all
<%
tecnologia = request("tecnologia")
if tecnologia <> "" then
	ssql = "select * from tecnologia where tec_id = " & tecnologia
	'response.write ssql
	'response.end
	call Env.RecordSet( true, objSiteRS, sSQL)
	if objSiteRS.eof = false then%>
		frm.btnIncluir.disabled = false;
		frm.btnExcluir.disabled = false;
		frm.tecnologia.value = '<%=ucase(objSiteRS("tec_id"))%>';
		frm.desc.value = '<%=ucase(objSiteRS("tec_nome"))%>';
		frm.at_id.value = '<%=objSiteRS("AT_ID")%>';
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
