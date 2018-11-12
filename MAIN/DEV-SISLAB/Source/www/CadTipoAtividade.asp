<!--#include file="includes/Sislab_Lib.asp"-->
<!-- #include file="includes/controlesHTML.asp" -->
<!-- #include file="includes/PadraoHTML.asp" -->
<!-- #include file="includes/global.asp" -->
<!-- #include file="includes/funcoes.asp" -->
<%
Tela.SetMostraMenu = MENU_ON
Tela.SetMostraImagem = True
Tela.SetNomeTela = "Cadastro de Tipo de Atividade"
Tela.SetLinkVoltar = "location.href='sislab.asp'"
Call Tela.MostraCabecalho()
''''Call Tela.ImprimeCabecalho2(TITULO_SITE, MENU_ON, true, "", "Cadastro de Tipo de Atividade", "location.href='sislab.asp'", "")

if not Env.ehRAT then RESPONSE.REDIRECT "INDEX.ASP"
%>
<script type="text/javascript" src="includes/anexo.js"></script>
<script type="text/javascript">
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

<div class="margem-10">
    <form method="post" action="CadTipoAtividadeA.asp" name="frm">

        <input type="hidden" name="ehNovoTipoAtividade" value="0">
        <input type="hidden" name="excluir" value="0">

        <table class="largura-total">
        <tr> 
	        <td colspan="2"><span class="texto-vermelho-bold"><b>*</span>&nbsp; Indica um Campo Obrigatório</td>
        </tr>

        <tr><td colspan="2">&nbsp;</td></tr>

        <tr><th colspan="2">Tipos de Atividades</th></tr>

        <tr>
	        <td width="120px">Tipo de Atividade:</td>
	        <td>
		        <%call comboTipoAtividade("tipoativ", Env.oConn,"N")%>&nbsp;&nbsp;
		        <input   type="button" value="Buscar" onclick="BuscarUsuario();">
	        </td>
        </tr>

        <tr><td colspan="2">&nbsp;</td></tr>

        <tr><th colspan="2">Dados do Tipo de Atividade</th></tr>

        <tr>
	        <td width="100px">&nbsp;<span class="texto-vermelho-bold">*</span>&nbsp;Descrição:</td>
	        <td><input type="text" name="desc" size="60"></td>
        <tr>

        <tr><td colspan="2">&nbsp;</td></tr>

        <tr>
	        <td colspan="2">
		        <input type="button" onclick="ValidaCampos()" value=" &nbsp;Salvar Dados&nbsp;" name="btnSalvar">
		        <input type="button" onclick="IncluirNovo()" value=" &nbsp;&nbsp;Incluir &nbsp;&nbsp;" name="btnIncluir">
		        <input type="button" onclick="Excluir()" value=" Excluir " name="btnExcluir">
		        <input type="button" onclick="Cancela()" value=" &nbsp;&nbsp;Cancelar&nbsp;&nbsp;" name="btnCancelar">
	        </td>
        </tr>
        </table>
    </form>
    <iframe width="770" height="200" name="escondido" style="display: none;"></iframe>
</div>

<script type="text/javascript">
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
Call Tela.MostraRodape()
%>
