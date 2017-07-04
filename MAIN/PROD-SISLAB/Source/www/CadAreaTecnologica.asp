<!--#include file="includes/Sislab_Lib.asp"-->
<!--#include file="includes/controlesHTML.asp" -->
<!--#include file="includes/PadraoHTML.asp" -->
<!--#include file="includes/global.asp" -->
<!--#include file="includes/funcoes.asp" -->
<%
Response.Addheader "Expires","Mon, 26 Jul 1997 05:00:00 GMT" 
Response.Addheader "Cache-Control","no-cache, must-revalidate" 
Response.Addheader "Pragma","no-cache" 

call imprimeCabecalho2(TITULO_SITE, MENU_ON, true, "", "Cadastro de Área Tecnológica", "location.href='sislab.asp'", "")

if not Env.ehRAT then RESPONSE.REDIRECT "INDEX.ASP"
%>
<body bgcolor="#FFFFFF" topmargin=0 leftmargin=0>
<script language="javascript" src="includes/anexo.js"></script>
<script>
<%if request("Repetido") <> "" then%>
	alert('Não foi possível incluir a Área Tecnológica <%=request("Repetido")%>, pois esta já está cadastrado.')
<%end if%>
function BuscarUsuario(){
	var frm = document.forms[0];
	frm.action = "CadAreaTecnologica.asp";
	frm.method = "POST";
	frm.target = "_parent";
	frm.ehNovaAreaTec.value = 0;
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

	frm.action = "CadAreaTecnologicaA.asp";
	frm.method = "POST";
	frm.target = "_parent";
	frm.submit();
}
function IncluirNovo(){
	var frm = document.forms[0];
	frm.ehNovaAreaTec.value = 1;
	frm.desc.value = "";
	frm.desc.focus();
	frm.areatec.value = "";
	frm.btnIncluir.disabled = true;
	frm.btnSalvar.disabled = false;
	frm.btnCancelar.disabled = false;	
}
function Excluir() {
	var frm = document.forms[0];
	if(frm.areatec.value == '') {
		alert('Nenhuma área tecnológica selecionada para exclusão !');
		frm.areatec.focus();
	}
	else {
		frm.excluir.value = '1';
		frm.action = "CadAreaTecnologicaA.asp";
		frm.target = "_parent";
		frm.submit();
	}
}
</script>
<form method="post" action="CadAreaTecnologicaA.asp" name="frm">
<input type="Hidden" name="ehNovaAreaTec" value="0">
<input type="Hidden" name="excluir" value="0">
<table border="0" width="100%" cellpadding="2" cellspacing="0" class="tabela1">
<tr> 
	<td colspan="2">&nbsp;<span class="vermelho2"><b>*</span>&nbsp; Indica um Campo Obrigatório</b></td>
</tr>

<tr><td colspan="2">&nbsp;</td></tr>

<tr><th align="left" colspan="2">&nbsp;&nbsp;Áreas Tecnológicas</td></tr>

<tr>
	<td width="130px">&nbsp;&nbsp;<b>Área Tecnológica :</b></td>
	<td>
		<%call comboAreaTecnologica("areatec", objConn,"N")%>
		&nbsp;&nbsp;
		<input class="texto1" type="Button" value="Buscar" onclick="BuscarUsuario();">
	</td>
</tr>

<tr><td colspan="2">&nbsp;</td></tr>

<tr><th align="left" colspan="2">&nbsp;&nbsp;Dados da Área Tecnológica</th></tr>

<tr>
	<td width="130px">&nbsp;<span class="vermelho2"><b>*</span>&nbsp;Descrição :</b></td>
	<td><input type="Text" name="desc" size="60" class="texto1"></td>
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
areatec = request("areatec")
if areatec <> "" then
	ssql = "select * from area_Tecnologica where at_id = " & areatec & ""
	'response.write ssql
	'response.end
	call Env.RecordSet( true, objSiteRS, sSQL)
	if objSiteRS.eof = false then%>
		frm.btnIncluir.disabled = false;
		frm.areatec.value = '<%=ucase(objSiteRS("at_id"))%>'
		frm.desc.value = '<%=ucase(objSiteRS("at_nome"))%>'
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
