<!--#include file="includes/Sislab_Lib.asp"-->
<!--#include file="includes/controlesHTML.asp" -->
<!--#include file="includes/PadraoHTML.asp" -->
<!--#include file="includes/global.asp" -->
<!--#include file="includes/funcoes.asp" -->
<%
Dim achou, amb_id, amb_nome, amb_usadoporag, amb_modulo, amb_crt, p_PerfilSCE


Call ImprimeCabecalho2(TITULO_SITE, MENU_ON, true, "", "Cadastro de Ambientes", "location.href='sislab.asp'", "")

if not Env.ehRAT then response.redirect "index.asp"
%>
<script language="javascript" src="includes/anexo.js"></script>
<script language="javascript">
	function BuscarAmbiente(){
		var frm = document.forms[0];
		frm.action = "CadAmbientes.asp";
		frm.target = "_parent";
		frm.ehNovoAmbiente.value = 0;
		frm.submit();
		frm.btnSalvar.disabled = false;
		frm.btnCancelar.disabled = false;	
	}
	function Cancela(){
		var frm = document.forms[0];
		frm.action = "sislab.asp";
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
		frm.action = "CadAmbientesA.asp";
		frm.target = "_parent";
		frm.submit();
	}
	function IncluirNovo(){
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
	function Excluir() {
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
<form method="post" action="CadAmbientewA.asp" name="frm">
<input type="Hidden" name="ehNovoAmbiente" value="0">
<input type="Hidden" name="excluir" value="0">
<table border="0" width="100%" cellpadding="2" cellspacing="0" class="tabela1">
<tr> 
	<td colspan="2">&nbsp;<span class="vermelho2"><b>*</span>&nbsp; Indica um Campo Obrigatório</b></td>
</tr>

<tr><td colspan="2">&nbsp;</td></tr>

<tr><th align="left" colspan="2">&nbsp;&nbsp;Busca de Ambientes</td></tr>

<tr>
	<td>&nbsp;&nbsp;Módulo do Sistema:</td>
	<td>
		<%=ModuloSistema("filtro_modulo", "")%>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
	    Centro de Referência:&nbsp;<%=CentroReferencia("filtro_crt", "")%>
	</td>
</tr>

<tr>
	<td width="110px">&nbsp;&nbsp;Ambiente:</td>
	<td>
		<%call comboBDSQL("ambiente", Env.oConn, "SELECT AMB_ID as valor, AMB_NOME as descricao FROM Ambientes ORDER BY AMB_NOME", "N", true)%>
		&nbsp;&nbsp;
		<input class="texto1" type="Button" value="Buscar" onclick="BuscarAmbiente();">
	</td>
</tr>
</table>

<br />

<table border="0" cellpadding="2" cellspacing="0" class="tabela1">

<tr><th align="left" colspan="2">&nbsp;&nbsp;Dados do Ambiente</th></tr>

<tr>
	<td >&nbsp;<span class="vermelho2"><b>*</span>&nbsp;Descrição :</b></td>
	<td><input type="Text" name="desc" size="60" class="texto1"></td>
<tr>

<tr>
	<td colspan="2">&nbsp;&nbsp;Reserva este ambiente apenas pela área do RAT (possuí AS)</b>&nbsp;
	<input type="Checkbox" name="usadoporag" value="1"></td>
<tr>

<tr>
	<td><span class="vermelho2"><b>*</b></span>&nbsp;<b>Centro de Referência:</b></td>
	<td>
	    <%=CentroReferencia("crt", amb_crt)%>
	</td>
</tr>

<tr>
	<td><span class="vermelho2"><b>*</b></span>&nbsp;<b>Módulo do Sistema:</b></td>
	<td>
        <%=ModuloSistema("modulo", amb_modulo)%>
	</td>
</tr>

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
<iframe name="escondido" style="display: none;"></iframe>

<script type="text/javascript" src="ajax/max_ajax_ref.js" ></script>
<script type="text/javascript">
    function ajax_comboAmbientes() {
        var frm = document.forms[0];
        var amb_id = ""; //documents.frm.ambiente.value;
        var id_crt = frm.filtro_crt.value;
        var amb_modulo = frm.filtro_modulo.value;
        var url = 'ajax/sislab_combo_ambiente.asp?amb_id=' + amb_id + '&id_crt=' + id_crt + '&amb_modulo=' + amb_modulo;
        var maxAjaxObj = new max.Ajax(url, {
            update: '', onComplete:
                function (texto, xml) {
                    var frm = document.forms[0];
                    frm.ambiente.innerHTML = texto;
                }
        });
        maxAjaxObj.get();
    }

    //documents.forms[0].filtro_modulo.onchange = ajax_comboAmbientes();
    //documents.forms[0].filtro_crt.onchange = ;
</script>


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
		frm.modulo.value = "<%=objSiteRS("ID_CRT")%>";
		frm.crt.value = "<%=objSiteRS("AMB_MODULO")%>";

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
Call imprimeRodape(RODAPE_OFF)


Function ModuloSistema(nome, valor) %>
    <select name="<%=nome%>" class="combo" onchange="ajax_comboAmbientes();">
<%  If Not p_PerfilSCE Then  %>
	    <option value="">--</option>
	    <option value="<%=Application("SISLAB_ID_APLICACAO_SISLAB")%>" <%=IIf(CStr(valor) = Cstr(Application("SISLAB_ID_APLICACAO_SISLAB")), "selected", "")%>>SISLAB</option>
<%  End If %>
	    <option value="<%=Application("SISLAB_ID_APLICACAO_SCE")%>" <%=IIf(CStr(valor) = Cstr(Application("SISLAB_ID_APLICACAO_SCE")), "selected", "")%>>SCE</option>
    </select>
<%
End Function


Function CentroReferencia(nome, valor)
    '-- pego os ambientes que não são reservados por AS, nestes, a reserva é feita pelo
    '-- cadastro de agendamento / área do RAT
    s = "SELECT crt.ID_CRT, crt.NM_CRT, crt.SIGLA_CRT FROM CentroReferencia crt ORDER BY crt.NM_CRT;"
    Call Env.RecordSet(True, objRS, s)
    If Not objRS.EOF Then
	    objRS.MoveFirst %>
		        <select class="combo" name="<%=nome%>" onchange="ajax_comboAmbientes();">
		            <option value="">--</option>
	 <% do while not objRS.EOF %>
    	    	    <option value="<%=objRS("ID_CRT")%>" <%=IIf(CStr(valor) = Cstr(objRS("ID_CRT")), " selected", "")%>><%=objRS("NM_CRT")%> - [<%=objRS("SIGLA_CRT")%>]</option>
	<%      objRS.movenext %>
	<%  loop %>
        		</select>
<%  end if
End Function
%>
