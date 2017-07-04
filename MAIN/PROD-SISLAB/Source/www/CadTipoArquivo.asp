<!--#include file="includes/Sislab_Lib.asp"-->
<!-- #include file="includes/controlesHTML.asp" -->
<!-- #include file="includes/PadraoHTML.asp" -->
<!-- #include file="includes/global.asp" -->
<!-- #include file="includes/funcoes.asp" -->
<%
call imprimeCabecalho2(TITULO_SITE, MENU_ON, true, "", "Cadastro de Tipo de Arquivo", "location.href='sislab.asp'", "")

if not Env.ehRAT then RESPONSE.REDIRECT "INDEX.ASP"
%>
<script language="javascript" src="includes/anexo.js"></script>
<script>
function Buscar(){
	var frm = document.forms[0];
	frm.action = "CadTipoArquivo.asp";
	frm.method = "POST";
	frm.target = "_parent";
	frm.ehNovoTipoArquivo.value = 0;
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

	frm.action = "CadTipoArquivoA.asp";
	frm.method = "POST";
	frm.target = "_parent";
	frm.submit();
}
function IncluirNovo(){
	var frm = document.forms[0];
	frm.ehNovoTipoArquivo.value = 1;
	frm.desc.value = "";
	frm.desc.focus();
	frm.tipoarquivo.value = "";
	frm.confidencial[1].checked = true;
	frm.docquali[1].checked = true;
	frm.btnIncluir.disabled = true;
	frm.btnSalvar.disabled = false;
	frm.btnCancelar.disabled = false;	
}
function Excluir() {
	var frm = document.forms[0];
	if(frm.tipoarquivo.value == '') {
		alert('Nenhum tipo de arquivo selecionado para exclusão !');
		frm.tipoarquivo.focus();
	}
	else {
		frm.excluir.value = '1';
		frm.action = "CadTipoArquivoA.asp";
		frm.target = "_parent";
		frm.submit();
	}
}
</script>
<form method="post" action="CadTipoArquivoA.asp" name="frm">
<input type="Hidden" name="ehNovoTipoArquivo" value="0">
<input type="Hidden" name="excluir" value="0">
<table border="0" width="100%" cellpadding="2" cellspacing="0" class="tabela1">
<tr> 
	<td colspan="2">&nbsp;<span class="vermelho2"><b>*</span>&nbsp; Indica um Campo Obrigatório</b></td>
</tr>

<tr><td colspan="2">&nbsp;</td></tr>

<tr><th align="left" colspan="2">&nbsp;&nbsp;Tipos de Arquivo</td></tr>

<tr>
	<td width="130px">&nbsp;&nbsp;<b>Tipo de Arquivo:</b></td>
	<td>
		<%call comboBDSQL("tipoarquivo", Env.oConn, "SELECT TAR_CODTIPOARQUIVO as valor, TAR_TIPOARQUIVO as descricao FROM TipoArquivo ORDER BY TAR_TIPOARQUIVO", "N", true)%>
		&nbsp;&nbsp;
		<input class="texto1" type="Button" value="Buscar" onclick="Buscar();">
	</td>
</tr>

<tr><td colspan="2">&nbsp;</td></tr>

<tr><th align="left" colspan="2">&nbsp;&nbsp;Dados do Tipo de Arquivo</th></tr>

<tr>
	<td width="130px">&nbsp;<span class="vermelho2"><b>*</span>&nbsp;Descrição :</b></td>
	<td><input type="Text" name="desc" size="100" maxlength="300" class="texto1"></td>
<tr>

<tr>
	<td width="130px">&nbsp;<span class="vermelho2"><b>*</span>&nbsp;Confidencial :</b></td>
	<td>
		<input type="Radio" name="confidencial" value="1">Sim
		&nbsp;&nbsp;&nbsp;&nbsp;
		<input type="Radio" name="confidencial" value="0" checked>Não
	</td>
<tr>

<tr>
	<td width="130px">&nbsp;<span class="vermelho2"><b>*</span>&nbsp;Doc. Qualidade :</b></td>
	<td>
		<input type="Radio" name="docquali" value="1">Sim
		&nbsp;&nbsp;&nbsp;&nbsp;
		<input type="Radio" name="docquali" value="0" checked>Não
	</td>
<tr>

<tr><td colspan="2">&nbsp;</td></tr>

<tr>
	<td colspan="2">&nbsp;&nbsp;
		<input type="Button" onclick="ValidaCampos()" value=" Salvar Dados " name="btnSalvar">
		<input type="Button" onclick="IncluirNovo()" value=" Incluir " name="btnIncluir">
		<input type="Button" onclick="Excluir()" value=" Excluir " name="btnExcluir">
		<input type="Button" onclick="Cancela()" value=" Cancelar " name="btnCancelar">
	</td>
</tr>
</table>
</form>
<iframe width="770" height="200" name="escondido" style="display: none;"></iframe>
<script>
var frm = document.forms[0]
var frmAll = document.all
<%
tipoarquivo = request("tipoarquivo")
if tipoarquivo <> "" then
	ssql = "select * from TipoArquivo where TAR_CODTIPOARQUIVO = " & tipoarquivo & ""
	'response.write ssql
	'response.end
	call Env.RecordSet( true, objSiteRS, sSQL)
	if objSiteRS.eof = false then%>
		frm.btnIncluir.disabled = false;
		frm.tipoarquivo.value = '<%=objSiteRS("TAR_CODTIPOARQUIVO")%>';
		frm.desc.value = '<%=objSiteRS("TAR_TIPOARQUIVO")%>';

<%		If objSiteRS("TAR_CONFIDENCIAL") Then %>
		frm.confidencial[0].checked = true;
<%		else %>
		frm.confidencial[1].checked = true;
<%		end if %>

<%		If objSiteRS("TAR_DocQual") Then %>
		frm.docquali[0].checked = true;
<%		else %>
		frm.docquali[1].checked = true;
<%		end if %>

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
call imprimeRodape(RODAPE_OFF)
%>
