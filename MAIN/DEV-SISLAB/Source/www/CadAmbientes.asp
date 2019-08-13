<!--#include file="includes/Sislab_Lib.asp"-->
<!--#include file="includes/controlesHTML.asp" -->
<!--#include file="includes/PadraoHTML.asp" -->
<!--#include file="includes/global.asp" -->
<!--#include file="includes/funcoes.asp" -->
<%
If Not Env.ehRAT Then Response.Redirect "index.asp"

Dim ambiente, achou, amb_id, amb_nome, amb_usadoporag, amb_modulo, amb_crt, p_PerfilSCE

p_PerfilSCE = (Env.PerfilSce = PERFIL_LOG)
ambiente = Trim(Request("ambiente"))
achou = False
amb_id = ""
amb_nome = ""
amb_usadoporag = False
amb_modulo = ""
amb_crt = ""

Tela.SetMostraMenu = MENU_ON
Tela.SetMostraImagem = True
Tela.SetNomeTela = "Cadastro de Ambientes"
Tela.SetLinkVoltar = "location.href='sislab.asp'"
Call Tela.MostraCabecalho()
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
        frm.crt.value = "";
        frm.usadoporag.checked = false;
        frm.modulo.value = "";
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
        <div class="linha-fundo" style="width: 100%"><strong>Busca de Ambientes</strong></div>
        <br />
        <div>
            <p>
                Módulo do Sistema:&nbsp;<%=ModuloSistema("filtro_modulo", "")%>
                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
	            Centro de Referência:&nbsp;<%=CentroReferencia("filtro_crt", "")%>
            </p>
            <p>
	            Ambiente Selecionado:&nbsp;
<%
                    call comboBDSQL("ambiente", _
                        Env.oConn, _
                        "SELECT a.AMB_ID as valor, a.AMB_NOME + ' (' + crt.NM_CRT + ' / ' + CASE WHEN AMB_MODULO = " & Application("SISLAB_ID_APLICACAO_SISLAB") & " THEN 'SISLAB' ELSE 'SCE' END + ')' as descricao FROM Ambientes a INNER JOIN CentroReferencia crt ON a.ID_CRT = crt.ID_CRT " & _
                        IIf(p_PerfilSCE, "WHERE a.AMB_MODULO = " & Application("SISLAB_ID_APLICACAO_SCE"), "") & " " & _
                        "ORDER BY a.AMB_NOME", _
                        "N", "N") 
%>
		        &nbsp;&nbsp;
                <input  type="button" value="Buscar" onclick="BuscarAmbiente();">
            </p>

        </div>

        <br />
<%
If ambiente <> "" then
	ssql = "select * from ambientes where amb_id = " & ambiente
	'response.write ssql
	'response.end
	Call Env.RecordSet(true, objSiteRS, sSQL)
	If Not objSiteRS.Eof Then
        achou = True

        amb_id = Cstr(objSiteRS("amb_id"))
		amb_nome = Cstr(objSiteRS("amb_nome"))
        amb_usadoporag = Cstr(objSiteRS("amb_usadoporag"))
        amb_modulo = Cstr(objSiteRS("amb_modulo"))
        amb_crt = Cstr(objSiteRS("id_crt"))
    End If
    Set objSiteRS = Nothing
End If
%>
        <div class="linha-fundo" style="width: 100%"><strong>Dados do Ambiente</strong></div>

        <br />

        <table border="0" width="100%" cellpadding="2" cellspacing="0" class="table-condensed">
            <tr>
	            <td style="width: 170px;"><span class="texto-vermelho-bold"><b>*</b></span>&nbsp;Descrição :</td>
	            <td><input type="text" name="desc" size="60" value="<%=amb_nome%>" ></td>
            </tr>

            <tr>
	            <td colspan="2">Reserva este ambiente apenas pela área do RAT (possuí AS)&nbsp;<input type="Checkbox" name="usadoporag" value="1"></td>
            <tr>

            <tr>
	            <td><span class="texto-vermelho-bold"><b>*</b></span>&nbsp;Centro de Referência:</td>
	            <td>
	                <%=CentroReferencia("crt", amb_crt)%>
	            </td>
            </tr>

            <tr>
	            <td><span class="texto-vermelho-bold"><b>*</b></span>&nbsp;Módulo do Sistema:</td>
	            <td>
                    <%=ModuloSistema("modulo", amb_modulo)%>
	            </td>
            </tr>

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

<script type="text/javascript">
    var frm = document.forms[0];
    var frmAll = document.all;
<%
If ambiente <> "" Then
	If achou Then %>
		frm.btnIncluir.disabled = false;
		frm.btnExcluir.disabled = false;
		frm.ambiente.value = '<%=amb_id%>';
<%		if amb_usadoporag Then %>
		frm.usadoporag.checked = true;
<%      else %>
        frm.usadoporag.checked = false;
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


Function ModuloSistema(nome, valor) %>
    <select name="<%=nome%>" onchange="ajax_comboAmbientes();">
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
		        <select name="<%=nome%>" onchange="ajax_comboAmbientes();">
		            <option value="">--</option>
	 <% do while not objRS.EOF %>
    	    	    <option value="<%=objRS("ID_CRT")%>" <%=IIf(CStr(valor) = Cstr(objRS("ID_CRT")), " selected", "")%>><%=objRS("NM_CRT")%> - [<%=objRS("SIGLA_CRT")%>]</option>
	<%      objRS.movenext %>
	<%  loop %>
        		</select>
<%  end if
End Function
%>

