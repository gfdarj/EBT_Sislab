<!--#include file="includes/Sislab_Lib.asp"-->
<!-- #include file="includes/controlesHTML.asp" -->
<!-- #include file="includes/PadraoHTML.asp" -->
<!-- #include file="includes/global.asp" -->
<!-- #include file="includes/funcoes.asp" -->
<%
if not Env.ehRat then RESPONSE.REDIRECT "INDEX.ASP"
%>
<script type="text/javascript" src="includes/anexo.js"></script>
<script type="text/javascript">
<%if request("ServicoRepetido") <> "" then%>
	alert('Não foi possível incluir o Serviço <%=request("ServicoRepetido")%>, pois este já está cadastrado.')
<%end if%>

<%if request("Acao") <> "S" and request("Acao") <> "P" then%>
	alert('Esta ação é inválida !')
	location.href = 'sislab.asp';
<%end if%>

    function BuscarServicosPlataformas(quem)
    {
	    var frm = document.forms[0];
	    frm.action = "CadServPlataforma.asp?Acao=<%=request("Acao")%>";
    //	frm.target = "_parent";
	    frm.ehNovoServ.value = 0;
	    frm.ehServicoPlataforma.value = quem;
	    frm.submit();
	    frm.btnSalvar.disabled = false;
	    frm.btnCancelar.disabled = false;
    }
    function Cancela(){
	    var frm = document.forms[0];
	    frm.action = "sislab.asp";
    //	frm.target = "_parent";
	    frm.submit();
    }
    function ValidaCampos(){
	    var frm = document.forms[0];

	    if (frm.desc.value == ""){
		    alert('É necessário informar a Descrição.');
		    frm.desc.focus();
		    return false;
	    }
	    frm.action = "CadServPlataformaA.asp";
    //	frm.target = "_parent";
	    frm.submit();
    }
    function IncluirNovo(){
	    var frm = document.forms[0];
	    frm.ehNovoServ.value = 1;
	    frm.desc.value = "";
	    frm.desc.focus();
	    frm.serv.value = "";
	    frm.plat_pai.value = "";
	    frm.btnIncluir.disabled = true;
	    frm.btnExcluir.disabled = true;
	    frm.btnSalvar.disabled = false;
	    frm.btnCancelar.disabled = false;	
    }
    function Excluir() {
	    var frm = document.forms[0];
	    if(frm.serv.value == '') {
		    alert('Nenhum serviço ou sistema selecionado para exclusão !');
		    frm.serv.focus();
	    }
	    else {
		    frm.excluir.value = '1';
		    frm.action = "CadServPlataformaA.asp";
    //		frm.target = "_parent";
		    frm.submit();
	    }
    }
</script>
<%
if request("Acao") <> "S" and request("Acao") <> "P" then
	response.end
else
	Dim titulo
	if request("Acao") = "S" then Titulo = "Serviços"
	if request("Acao") = "P" then Titulo = "Plataformas"
end if

Call Tela.imprimeCabecalho2(TITULO_SITE, MENU_ON, true, "", "Cadastro de " & titulo, "location.href='sislab.asp'", "")
%>
<div class="margem-10">
    <form method="post" action="CadServPlataformaA.asp" name="frm">
        <input type="hidden" name="ehNovoServ" value="0">
        <input type="hidden" name="ehServicoPlataforma" value="">
        <input type="hidden" name="excluir" value="0">
        <input type="hidden" name="acao" value="<%=Request("Acao")%>">

        <table class="largura-total">
        <tr> 
	        <td><span class="texto-vermelho-bold">*</span>&nbsp; Indica um Campo Obrigatório</td>
        </tr>

        <tr><td>&nbsp;</td></tr>

        <tr><th><%=titulo%></th></tr>

        <tr>
	        <td><%=titulo%>: &nbsp;
		        <%call comboServicosPlataformas("serv", objConn, "N", request("Acao"))%>
		        <input  type="button" class="btn btn-primary" value="Buscar" onclick="BuscarServicosPlataformas('<%=request("Acao")%>');">
		        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
	        </td>
        </tr>

        <tr><td>&nbsp;</td></tr>

        <tr><th>Dados do Gerais</th></tr>

        <tr>
	        <td>
		        <table class="largura-total">
		        <tr>
			        <td width="110px"><span class="texto-vermelho-bold">*</span>&nbsp;Descrição:</td>
			        <td width="*"><input type="text" name="desc" size="60"></td>
		        </tr>
		        </table>
	        </td>
        </tr>

<%
if request("Acao") = "P" then
%>
		<input type="hidden" name="cmbPlataforma" value="0">
        <tr><td>&nbsp;</td></tr>
        <tr>
	        <td>
		        <table class="largura-total">
		        <tr>
			        <td width="110px">Plataforma Pai:</td>
			        <td width="*">
				        <%call comboServicosPlataformas("plat_pai", objConn,"N", "P")%>
			        </td>
		        </tr>
		        </table>
	        </td>
        </tr>
<%
else%>
		<input type="hidden" name="plat_pai" value="">
		<input type="hidden" name="cmbPlataforma" value="1">
<%
end if
%>
        <tr><td>&nbsp;</td></tr>

        <tr>
	        <td>&nbsp;&nbsp;
		        <input type="button" class="btn btn-primary" onclick="ValidaCampos()" value=" &nbsp;&nbsp;Salvar Dados&nbsp;&nbsp;" name="btnSalvar">
		        <input type="button" class="btn btn-primary" onclick="IncluirNovo()" value=" &nbsp;&nbsp;Incluir &nbsp;&nbsp;" name="btnIncluir">
		        <input type="button" class="btn btn-primary" onclick="Excluir()" value=" Excluir " name="btnExcluir">
		        <input type="button" class="btn btn-primary" onclick="Cancela()" value=" &nbsp;&nbsp;Cancelar&nbsp;&nbsp;" name="btnCancelar">
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
Dim serv
serv = request("serv")
if serv <> "" then
	ssql = "select * from Servicos_Plataformas where s_id = " & serv & ""
	'response.write ssql
	'response.end
	call Env.RecordSet( true, objSiteRS, sSQL)
	if objSiteRS.eof = false then%>
		frm.btnIncluir.disabled = false;
		frm.btnExcluir.disabled = false;
		frm.serv.value = '<%=ucase(objSiteRS("s_id"))%>'
		frm.desc.value = '<%=ucase(objSiteRS("s_descricao"))%>'
		frm.plat_pai.value = '<%=objSiteRS("s_id_pai")%>';
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
