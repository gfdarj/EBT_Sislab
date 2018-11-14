<!--#include file="includes/Sislab_Lib.asp"-->
<!-- #include file="includes/controlesHTML.asp" -->
<!-- #include file="includes/PadraoHTML.asp" -->
<!-- #include file="includes/global.asp" -->
<!-- #include file="includes/funcoes.asp" -->
<%
Tela.SetMostraMenu = MENU_ON
Tela.SetMostraImagem = True
Tela.SetNomeTela = "Cadastro de Tipo de Arquivo"
Tela.SetLinkVoltar = "location.href='sislab.asp'"
Call Tela.MostraCabecalho()
''''Call Tela.ImprimeCabecalho2(TITULO_SITE, MENU_ON, true, "", "Cadastro de Tipo de Arquivo", "location.href='sislab.asp'", "")

If not Env.ehRAT then
	RESPONSE.REDIRECT "INDEX.ASP"
End If
%>
<script type="text/javascript" src="includes/anexo.js"></script>
<script type="text/javascript">
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

<div class="margem-10">
    <form method="post" action="CadTipoArquivoA.asp" name="frm">
        <input type="hidden" name="ehNovoTipoArquivo" value="0">
        <input type="hidden" name="excluir" value="0">

        <table class="largura-total">
        <tr> 
	        <td colspan="2">
		        <span class="texto-vermelho-bold">*</span>&nbsp; Indica um Campo Obrigatório
	        </td>
        </tr>

        <tr><td colspan="2">&nbsp;</td></tr>

        <tr><th colspan="2">Tipos de Arquivo</th></tr>

        <tr>
	        <td width="130px">Tipo de Arquivo:</td>
	        <td>
		        <%call comboBDSQL("tipoarquivo", Env.oConn, "SELECT TAR_CODTIPOARQUIVO as valor, TAR_TIPOARQUIVO as descricao FROM TipoArquivo ORDER BY TAR_TIPOARQUIVO", "N", true)%>
		        &nbsp;&nbsp;
		        <input type="button" value="Buscar" onclick="Buscar();">
	        </td>
        </tr>

        <tr><td colspan="2">&nbsp;</td></tr>

        <tr><th colspan="2">Dados do Tipo de Arquivo</th></tr>

        <tr>
	        <td width="130px"><span class="texto-vermelho-bold">*</span>&nbsp;Descrição:</td>
	        <td><input type="text" name="desc" size="100" maxlength="300" ></td>
        <tr>

        <tr><td colspan="2">&nbsp;</td></tr>

        <tr>
	        <td width="130px"><span class="texto-vermelho-bold">*</span>&nbsp;Confidencial:</td>
	        <td>
		        <input type="Radio" name="confidencial" value="1">Sim
		        &nbsp;&nbsp;&nbsp;&nbsp;
		        <input type="Radio" name="confidencial" value="0" checked>Não
	        </td>
        <tr>

        <tr><td colspan="2">&nbsp;</td></tr>

        <tr>
	        <td width="130px"><span class="texto-vermelho-bold">*</span>&nbsp;Doc. Qualidade:</td>
	        <td>
		        <input type="Radio" name="docquali" value="1">Sim
		        &nbsp;&nbsp;&nbsp;&nbsp;
		        <input type="Radio" name="docquali" value="0" checked>Não
	        </td>
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
Call Tela.MostraRodape()
%>
