<!--#include file="includes/Sislab_Lib.asp"-->
<!--#include file="includes/controlesHTML.asp" -->
<!--#include file="includes/PadraoHTML.asp" -->
<!--#include file="includes/global.asp" -->
<!--#include file="includes/funcoes.asp" -->
<%
Call Tela.ImprimeCabecalho2(TITULO_SITE, MENU_ON, true, "", "Cadastro de Área Tecnológica", "location.href='sislab.asp'", "")

if not Env.ehRAT then RESPONSE.REDIRECT "INDEX.ASP"
%>
<script type="text/javascript" src="includes/anexo.js"></script>
<script type="text/javascript">
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

<div class="margem-10">
    <form method="post" action="CadAreaTecnologicaA.asp" name="frm">

        <input type="hidden" name="ehNovaAreaTec" value="0">
        <input type="hidden" name="excluir" value="0">

        <table class="largura-total">
        <tr> 
	        <td colspan="2"><span class="texto-vermelho-bold"><b>*</span>&nbsp; Indica um Campo Obrigatório</b></td>
        </tr>

        <tr><td colspan="2">&nbsp;</td></tr>

        <tr><th align="left" colspan="2">Áreas Tecnológicas</td></tr>

        <tr>
	        <td width="130px">Área Tecnológica:</td>
	        <td>
		        <%call comboAreaTecnologica("areatec", objConn,"N")%>
		        &nbsp;&nbsp;
		        <input  type="button" value="Buscar" onclick="BuscarUsuario();">
	        </td>
        </tr>

        <tr><td colspan="2">&nbsp;</td></tr>

        <tr><th align="left" colspan="2">Dados da Área Tecnológica</th></tr>

        <tr>
	        <td width="130px"><span class="texto-vermelho-bold"><b>*</span>&nbsp;Descrição:</b></td>
	        <td><input type="text" name="desc" size="60" ></td>
        <tr>

        <tr><td colspan="2">&nbsp;</td></tr>

        <tr>
	        <td colspan="2">
		        <input type="button" onclick="ValidaCampos()" value=" Salvar Dados " name="btnSalvar">
		        <input type="button" onclick="IncluirNovo()" value=" Incluir " name="btnIncluir">
		        <input type="button" onclick="Excluir()" value=" Excluir " name="btnExcluir">
		        <input type="button" onclick="Cancela()" value=" Cancelar " name="btnCancelar">
	        </td>
        </tr>
        </table>
    </form>
    <iframe width="770" height="200" name="escondido" style="display: none;"></iframe>
</div>

<script type="text/javascript">
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
Call Tela.MostraRodape()
%>
