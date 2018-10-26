<!------- LIB ------->
<!--#include file="./Classes/Classe_Combo.asp"-->
<!------- SISLAB ---->
<!--#include file="includes/Sislab_Lib.asp"-->
<!--#include file="includes/controlesHTML.asp" -->
<!--#include file="includes/PadraoHTML.asp" -->
<!--#include file="includes/global.asp" -->
<!--#include file="includes/funcoes.asp" -->
<%
Dim Combo

Set Combo = New TCombo

Tela.SetMostraMenu = MENU_ON
Tela.SetMostraImagem = True
Tela.SetNomeTela = "Cadastro de Usuários CRT"
Tela.SetLinkVoltar = "location.href='sislab.asp'"
Call Tela.MostraCabecalho()
'''''Call imprimeCabecalho2(TITULO_SITE, MENU_ON, true, "", "Cadastro de Usuários CRT", "location.href='sislab.asp'", "")

If Not Env.ehRAT Then Response.Redirect "INDEX.ASP"
%>
<script type="text/javascript" src="includes/ValidacaoEmail.js"></script>
<script type="text/javascript" src="includes/anexo.js"></script>
<script type="text/javascript">
    function BuscarUsuario(){
	    var frm = document.forms[0];
	    frm.action = "CadUserCRT.asp";
	    frm.method = "POST";
	    frm.target = "_parent";
	    frm.ehNovoUsuario.value = 0;
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

	    if (frm.username.value == ""){
		    alert('É necessário informar o UserName.');
		    frm.username.focus();
		    return false
	    }
	    if (!validacaoEmail(frm.username.value))
	    {
	        alert('UserName inválido.');
	        frm.username.focus();
	        return false
	    }
	    if (frm.matricula.value == ""){
		    alert('É necessário informar a matrícula.');
		    frm.matricula.focus();
		    return false
	    }
	    if (isNaN(frm.matricula.value)){
		    alert('O Campo matrícula deve ser numérico.');
		    frm.matricula.focus();
		    return false
	    }
	    if (frm.Nome.value == ""){
		    alert('É necessário informar o Nome.');
		    frm.Nome.focus();
		    return false
	    }
	    if (isNaN(frm.Ramal.value)){
		    alert('O Campo ramal deve ser numérico.');
		    frm.Ramal.focus();
		    return false
	    }
	    if (frm.orgao.value == ""){
		    alert('É necessário informar o órgão.');
		    frm.orgao.focus();
		    return false
	    }
	    frm.username.disabled = false
	    frm.action = "CadUserCRTA.asp";
	    frm.method = "POST";
	    frm.target = "_parent";
	    frm.submit();
    }
    function IncluirNovo(){
	    var frm = document.forms[0];
	    frm.ehNovoUsuario.value = 1;
	    frm.username.disabled = false;
	    frm.username.style.backgroundColor = "#FFFFFF";	
	    frm.user.value  = ''
	    frm.username.value = ''
	    frm.matricula.value = ''
	    frm.Nome.value = ''
	    frm.celular.value = ''
	    frm.Ramal.value = ''
	    frm.orgao.value = ''		
	    frm.chkRAT.checked = false;
	    frm.chkRT.checked = false;
	    frm.chkGQ.checked = false;
	    frm.chkexibir.checked = false;
	    frm.username.focus();
	    frm.btnIncluir.disabled = true;
	    frm.btnExcluir.disabled = true;
	    frm.btnSalvar.disabled = false;
	    frm.btnCancelar.disabled = false;	
    }
    function Excluir() {
	    var frm = document.forms[0];
	    if(frm.user.value == '') {
		    alert('Nenhum usuário selecionado para exclusão !');
		    frm.user.focus();
	    }
	    else {
		    frm.excluir.value = '1';
		    frm.action = "CadUserCRTA.asp";
		    frm.target = "_parent";
		    frm.submit();
	    }
    }
</script>
<form method="post" action="CadUserCRTA.asp" name="frm">
<input type="hidden" name="ehNovoUsuario" value="0">
<input type="hidden" name="excluir" value="0">

<table border="0" width="100%" cellpadding="2" cellspacing="0" class="table-bordered">
<tr><td></td><td></td></tr>
<tr> 
	<td colspan="2">&nbsp;<span class="texto-vermelho-bold"><b>*</span>&nbsp; Indica um Campo Obrigatório</b></td>
</tr>
<tr><td colspan="2">&nbsp;</td></tr>
<tr><th align="left" colspan="2">Usuários do CRT</td></tr>
<tr>
	<td>&nbsp;&nbsp;<b>Usuários CRT:</b></td>
	<td>
		<%call comboUSERCRTVIVOEMORTOS("user", Env.oConn,"N")%>&nbsp;&nbsp;
		<input  class="texto1" type="button" value="Buscar" onclick="BuscarUsuario();">
	</td>
</tr>
<tr><td colspan="2">&nbsp;</td></tr>
<tr><th align="left" colspan="2">Dados do Usuário</th></tr>
<tr>
	<td>&nbsp;<span class="texto-vermelho-bold"><b>*</span>&nbsp;Username:</b></td>
	<td>
		<input type="text" name="username" size="50" maxlength="80" class="texto1">
		&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
		<span class="texto-vermelho-bold"><b>*</span>&nbsp;Matrícula:</b>&nbsp;
		<input type="text" name="matricula" class="texto1" size="15">
	</td>
<tr>
<tr>
	<td>&nbsp;<span class="texto-vermelho-bold"><b>*</span>&nbsp;Nome:</b></td>
	<td>
		<input type="text" name="Nome" size="60" class="texto1">
	</td>
</tr>
<tr>
	<td>&nbsp;<span class="texto-vermelho-bold"><b>*</span>&nbsp;Celular:</b></td>
	<td>
		<input type="text" name="celular" size="20" class="texto1">
		&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
		<span class="texto-vermelho-bold"><b>*</span>&nbsp;Ramal:</b>&nbsp;
		<input type="text" name="Ramal" size="20" class="texto1">
	</td>
</tr>
<tr>
	<td>&nbsp;<span class="texto-vermelho-bold"><b>*</span>&nbsp;Orgão:</b></td>
	<td>
		<%call comboOrgao("orgao",Env.oConn,"N")%>
	</td>
</tr>
<tr>
	<td colspan="2">&nbsp;&nbsp;RAT:
		<input type="Checkbox" name="chkRAT" class="texto1">
		&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
		RT:&nbsp;<input type="Checkbox" name="chkRT" class="texto1">
		&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
		GQ:&nbsp;<input type="Checkbox" name="chkGQ" class="texto1">
		&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
		Visível:&nbsp;<input type="Checkbox" name="chkexibir" class="texto1">
		&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
		Perfil SCE:&nbsp;<%=Combo.PadraoSql("perfilSce", "SELECT ID_PERFIL AS VALOR, NM_PERFIL AS DESCRICAO FROM Perfil_SCE ORDER BY ID_PERFIL", "", "N")%>
	</td>
</tr>

<tr><td colspan="2">&nbsp;</td></tr>

<tr>
	<td colspan="2">&nbsp;&nbsp;
		<input type="button" class="texto1" onclick="ValidaCampos()" value=" &nbsp;&nbsp;Salvar Dados&nbsp;&nbsp;" name="btnSalvar"/>
		<input type="button" class="texto1" onclick="IncluirNovo()" value=" &nbsp;&nbsp;Incluir Usuário &nbsp;&nbsp;" name="btnIncluir"/>
		<input type="button" class="texto1" onclick="Excluir()" value=" Excluir " name="btnExcluir">
		<input type="button" class="texto1" onclick="Cancela()" value=" &nbsp;&nbsp;Cancelar&nbsp;&nbsp;" name="btnCancelar"/>
	</td>
</tr>
</table>
</form>
<iframe width="770" height="200" name="escondido" style="display: none;"></iframe>
<script>
var frm = document.forms[0];
<%
USER = request("user")
ssql = "select * from usercrt where userid = '" & user & "'"
'response.write ssql
'response.end
call Env.RecordSet(True, objSiteRS, sSQL)
if objSiteRS.eof = false then
%>
	frm.username.disabled = true;
	frm.username.style.backgroundColor = "#EEEEEE";	
	frm.btnIncluir.disabled = false;
	frm.btnExcluir.disabled = false;
	frm.user.value = '<%=ucase(objSiteRS("userid"))%>'
	frm.username.value = '<%=ucase(objSiteRS("userid"))%>'
	frm.matricula.value = '<%=ucase(objSiteRS("matricula"))%>'
	frm.Nome.value = '<%=ucase(objSiteRS("Nome"))%>'
	frm.celular.value = '<%=ucase(objSiteRS("celular"))%>'
	frm.Ramal.value = '<%=ucase(objSiteRS("Ramal"))%>'
	frm.orgao.value = '<%=ucase(objSiteRS("orga_id"))%>'		
	<%if objSiteRS("RAT")= TRUE then%>
		frm.chkRAT.checked = true;
	<%end if%>
	<%if objSiteRS("RT")= TRUE then%>
		frm.chkRT.checked = true;
	<%end if%>
	<%if objSiteRS("GQ")= TRUE then%>
		frm.chkGQ.checked = true;
	<%end if%>
	<%if objSiteRS("EXIBIR")= TRUE then%>
		frm.chkexibir.checked = true;
	<%end if%>
	<%if Not IsNull(objSiteRS("ID_PERFIL_SCE")) then%>
	    frm.perfilSce.value = <%=objSiteRS("ID_PERFIL_SCE")%>;
	<%end if%>
<%else%>
	frm.btnSalvar.disabled = true;
	frm.btnCancelar.disabled = true;	
<%end if%>
</script>
<%
Set Combo = Nothing

Call Tela.MostraRodape()
%>
