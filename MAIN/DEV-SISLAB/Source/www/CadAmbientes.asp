<!--#include file="includes/Sislab_Lib.asp"-->
<!--#include file="includes/controlesHTML.asp" -->
<!--#include file="includes/PadraoHTML.asp" -->
<!--#include file="includes/global.asp" -->
<!--#include file="includes/funcoes.asp" -->
<%
Tela.SetMostraMenu = MENU_ON
Tela.SetMostraImagem = True
Tela.SetNomeTela = "Cadastro de Ambientes"
Tela.SetLinkVoltar = "location.href='sislab.asp'"
Call Tela.MostraCabecalho()
''''Call Tela.ImprimeCabecalho2(TITULO_SITE, MENU_ON, true, "", "Cadastro de Ambientes", "location.href='sislab.asp'", "")

if not Env.ehRAT then response.redirect "index.asp"
%>
<script type="text/javascript" src="includes/anexo.js"></script>
<script type="text/javascript">
    function BuscarAmbiente()
    {
		var frm = document.forms[0];
		frm.action = "CadAmbientes.asp";
		frm.target = "_parent";
		frm.ehNovoAmbiente.value = 0;
		frm.submit();
		frm.btnSalvar.disabled = false;
		frm.btnCancelar.disabled = false;	
	}
    function Cancela()
    {
		var frm = document.forms[0];
		frm.action = "sislab.asp";
		frm.target = "_parent";
		frm.submit();
	}
    function ValidaCampos()
    {
		var frm = document.forms[0];

		if (frm.desc.value == ""){
			alert('É necessário informar a Descrição.');
			frm.desc.focus();
			return false
		}
		frm.action = "CadAmbientesA.asp";
		frm.target = "_parent";
		frm.submit();
	}
    function IncluirNovo()
    {
		var frm = document.forms[0];
		frm.ehNovoAmbiente.value = 1;
		frm.desc.value = "";
		frm.desc.focus();
		frm.ambiente.value = "";
		frm.btnIncluir.disabled = true;
		frm.btnExcluir.disabled = true;
		frm.btnSalvar.disabled = false;
		frm.btnCancelar.disabled = false;	
	}
    function Excluir()
    {
		var frm = document.forms[0];
		if(frm.ambiente.value == '') {
			alert('Nenhum ambiente selecionado para exclusão !');
			frm.ambiente.focus();
		}
		else {
			frm.excluir.value = '1';
			frm.action = "CadAmbientesA.asp";
			frm.target = "_parent";
			frm.submit();
		}
	}
</script>

<div class="margem-10">
    <form method="post" action="CadAmbientewA.asp" name="frm">

        <input type="hidden" name="ehNovoAmbiente" value="0">
        <input type="hidden" name="excluir" value="0">

	    <div><span class="texto-vermelho-bold"><b>*</b></span>&nbsp; Indica um Campo Obrigatório</div>
        <br />
        <div class="linha-fundo" style="width: 100%"><strong>Lista de Ambientes</strong></div>
        <br />
        <div>
	        <b>Ambiente:&nbsp;</b>
            <%call comboBDSQL("ambiente", Env.oConn, "SELECT AMB_ID as valor, AMB_NOME as descricao FROM Ambientes ORDER BY AMB_NOME", "N", true)%>
		    &nbsp;&nbsp;
            <input  type="button" value="Buscar" onclick="BuscarAmbiente();">
        </div>

        <br />

        <div class="linha-fundo" style="width: 100%"><strong>Dados do Ambiente</strong></div>

        <br />

        <table border="0" width="100%" cellpadding="2" cellspacing="0" class="table-condensed">

        <tr>
	        <td width="100px"><span class="texto-vermelho-bold"><b>*</span>&nbsp;Descrição :</b></td>
	        <td><input type="text" name="desc" size="60" ></td>
        </tr>

        <tr>
	        <td colspan="2">Reserva este ambiente apenas pela área do RAT (possuí AS)</b>&nbsp;
	        <input type="Checkbox" name="usadoporag" value="1"></td>
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
    <iframe name="escondido" style="display: none;"></iframe>
</div>

<script>
var frm = document.forms[0];
var frmAll = document.all;
<%
Dim ambiente
ambiente = request("ambiente")
if ambiente <> "" then
	ssql = "select * from ambientes where amb_id = " & ambiente
	'response.write ssql
	'response.end
	call Env.RecordSet( true, objSiteRS, sSQL)
	if objSiteRS.eof = false then%>
		frm.btnIncluir.disabled = false;
		frm.btnExcluir.disabled = false;
		frm.ambiente.value = '<%=ucase(objSiteRS("amb_id"))%>';
		frm.desc.value = '<%=ucase(objSiteRS("amb_nome"))%>';
<%		if objSiteRS("amb_usadoporag") then%>
		frm.usadoporag.checked = true;
<%		end if%>
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
