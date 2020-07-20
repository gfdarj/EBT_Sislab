<!--#include file="includes/Sislab_Lib.asp"-->
<!--#include file="includes/controlesHTML.asp" -->
<!--#include file="includes/PadraoHTML.asp" -->
<!--#include file="includes/global.asp" -->
<!--#include file="includes/funcoes.asp" -->
<%
Call Tela.imprimeCabecalho2(TITULO_SITE, MENU_ON, true, "", "Cadastro de Órgão", "location.href='sislab.asp'", "")

if not Env.ehRAT then RESPONSE.REDIRECT "INDEX.ASP"
%>
<script type="text/javascript" src="includes/anexo.js"></script>
<script type="text/javascript">
    function BuscarOrgao(){
	    var frm = document.forms[0];
	    frm.action = "CadOrgao.asp";
	    frm.method = "POST";
	    frm.target = "_parent";
	    frm.ehNovoOrgao.value = 0;
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

	    if (frm.sigla.value == ""){
		    alert('É necessário informar a Sigla do Órgão.');
		    frm.sigla.focus();
		    return false
	    }
	    if (frm.desc.value == ""){
		    alert('É necessário informar a Descrição.');
		    frm.desc.focus();
		    return false
	    }
	    if (frm.chefe.value == ""){
		    alert('É necessário informar o Username do Chefe do Órgão.');
		    frm.chefe.focus();
		    return false
	    }
	    if (frm.hierarquia.value == ""){
		    alert('É necessário informar a Hierarquia.');
		    frm.hierarquia.focus();
		    return false
	    }

	    frm.action = "CadOrgaoA.asp";
	    frm.method = "POST";
	    frm.target = "_parent";
	    frm.submit();
    }
    function IncluirNovo(){
	    var frm = document.forms[0];
	    frm.ehNovoOrgao.value = 1;
	    frm.desc.value = "";
	    frm.sigla.value = "";
	    frm.sigla.focus();
	    frm.orga_id.value = "";
	    frm.fax.value = "";
	    frm.ramal.value = "";
	    frm.chefe.value = "";
	    frm.exibir.checked = true;
	    frm.hierarquia.value = "";
	    frm.btnIncluir.disabled = true;
	    frm.btnExcluir.disabled = true;
	    frm.btnSalvar.disabled = false;
	    frm.btnCancelar.disabled = false;	
    }
    function Excluir() {
	    var frm = document.forms[0];
	    if(frm.orga_id.value == '') {
		    alert('Nenhum órgão selecionado para exclusão !');
		    frm.orga_id.focus();
	    }
	    else {
		    frm.excluir.value = '1';
		    frm.action = "CadOrgaoA.asp";
		    frm.target = "_parent";
		    frm.submit();
	    }
    }
</script>

<div class="margem-10">
    <form method="post" action="CadOrgaoA.asp" name="frm">
        <input type="hidden" name="ehNovoOrgao" value="0">
        <input type="hidden" name="excluir" value="0">

        <table class="largura-total">
        <tr> 
	        <td colspan="2"><span class="texto-vermelho-bold"><b>*</span>&nbsp; Indica um Campo Obrigatório</b></td>
        </tr>

        <tr><td colspan="2">&nbsp;</td></tr>

        <tr><th align="left" colspan="2">Órgãos</th></tr>

        <tr>
	        <td width="100px">Órgão:</td>
	        <td>
		        <%call comboOrgaoHierarquia("orga_id", Env.oConn,"N")%>&nbsp;&nbsp;
		        <input type="button" class="btn btn-primary" value="Buscar" onclick="BuscarOrgao();">
	        </td>
        </tr>

        <tr><td colspan="2">&nbsp;</td></tr>

        <tr><th colspan="2">Dados do Órgão</th></tr>

        <tr>
	        <td width="100px"><span class="texto-vermelho-bold">*</span>&nbsp;Sigla:</td>
	        <td><input type="text" name="sigla" size="60"></td>
        <tr>

        <tr>
	        <td width="100px"><span class="texto-vermelho-bold">*</span>&nbsp;Descrição:</td>
	        <td><input type="text" name="desc" size="60"></td>
        <tr>

        <tr>
	        <td width="100px">Fax:</td>
	        <td><input type="text" name="fax" size="20"></td>
        <tr>

        <tr>
	        <td width="100px">Ramal:</td>
	        <td><input type="text" name="ramal" size="10"></td>
        <tr>

        <tr>
	        <td width="100px"><span class="texto-vermelho-bold">*</span>&nbsp;<span title="Username do responsável pelo órgão" style="text-decoration:underline;">Chefe</span>:</td>
	        <td><input type="text" name="chefe" size="30"></td>
        <tr>

        <tr>
	        <td width="100px">Exibir:</td>
	        <td><input type="Checkbox" name="exibir" value="1" checked></td>
        <tr>

        <tr>
	        <td width="100px"><span class="texto-vermelho-bold">*</span>&nbsp;<span title="Número inteiro que Indica a posição hierárquica do órgão dentro do cadastro" style="text-decoration:underline;">Hierarquia</span>:</td>
	        <td><input type="text" name="hierarquia" size="10"></td>
        <tr>

        <tr><td colspan="2">&nbsp;</td></tr>

        <tr>
	        <td colspan="2">
		        <input type="button" class="btn btn-primary" onclick="ValidaCampos()" value=" &nbsp;&nbsp;Salvar Dados&nbsp;&nbsp;" name="btnSalvar"/>
		        <input type="button" class="btn btn-primary" onclick="IncluirNovo()" value=" &nbsp;&nbsp;Incluir &nbsp;&nbsp;" name="btnIncluir"/>
		        <input type="button" class="btn btn-primary" onclick="Excluir()" value=" Excluir " name="btnExcluir">
		        <input type="button" class="btn btn-primary" onclick="Cancela()" value=" &nbsp;&nbsp;Cancelar&nbsp;&nbsp;" name="btnCancelar"/>
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
    orga_id = request("orga_id")
    if orga_id <> "" then
	    ssql = "select * from Orgao where orga_id = " & orga_id & ""
	    'response.write ssql
	    'response.end
	    call Env.RecordSet( true, objSiteRS, sSQL)
	    if objSiteRS.eof = false then%>
		    frm.btnIncluir.disabled = false;
		    frm.btnExcluir.disabled = false;
		    frm.orga_id.value = '<%=ucase(objSiteRS("ORGA_ID"))%>';
		    frm.sigla.value = '<%=ucase(objSiteRS("ORGA_SIGLA"))%>';
		    frm.desc.value = '<%=ucase(objSiteRS("ORGA_DESCRICAO"))%>';
		    frm.fax.value = '<%=ucase(objSiteRS("ORGA_FAX"))%>';
		    frm.ramal.value = '<%=ucase(objSiteRS("ORGA_RAMAL"))%>';
		    frm.chefe.value = '<%=ucase(objSiteRS("ORGA_USERIDCHEFE"))%>';
		    frm.exibir.checked = <%if objSiteRS("ORGA_EXIBIR") then response.write "true" else response.write "false"%>;
		    frm.hierarquia.value = '<%=objSiteRS("ORGA_HIERARQUIA")%>';
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
