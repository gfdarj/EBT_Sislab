<!------- LIB ------->
<!--#include file="../Classes/Classe_Combo.asp"-->
<!------- SCE ------->
<!--#include file="includes/global_SCE.asp"-->
<!------- SISLAB ---->
<!--#include file="../includes/bib_str.asp"-->
<!--#include file="../includes/padraoHTML.asp"-->
<!--#include file="../includes/global.asp" -->   <!-- constantes usada pelo menu -->
<!--#include file="../includes/Geral_Lib.asp"-->
<!--#include file="../includes/Sislab_Lib.asp"-->
<!--#include file="../includes/controlesHTML.asp" -->
<%
Dim tipousuario : tipousuario = ""
Dim Ok_Alterar_Mov

Ok_Alterar_Mov = (Env.PerfilSce = PERFIL_ADM And request("mov_id") <> "")
If Env.PerfilSce = PERFIL_ADM Then tipousuario = " <span class='text-danger'>(Administrador)</span>"

If Ok_Alterar_Mov Then
    Tela.SetNomeTela = "SCE > Movimentação > Item" & tipousuario & " > Alteração"
Else
    Tela.SetNomeTela = "SCE > Movimentação > Item" & tipousuario
End If

Tela.SCE = True
Tela.SetCaminhoRelativo = "../"

Call Tela.MostraCabecalho()

If Env.UsuarioSCE() Then

    Dim Combo
    Set Combo = New TCombo

    'Call Tela.ImprimeMenuSce()
%>

<script type="text/javascript" src="../includes/anexo.js" ></script>
<script type="text/javascript" src="../ajax/max_ajax_ref.js" ></script>
<script type="text/javascript" src="../ajax/montaCombo.js" ></script>
<script type="text/javascript">
	/*** FUNÇÕES DO AJAX ***/
	function atualizarNO(valor) {
		var url = "../ajax/sce_mov_no_cmb.asp";
		url += "?tipo_mov=" + valor;

		var maxAjaxObj = new max.Ajax(url,{update:"",onComplete:
			function(texto,xml){
				montaCombo(document.all.noid, texto);
				var mostra = ((valor == '<%=MOV_ENTRADA%>') || (valor == '<%=MOV_EXPEDICAO%>') || (valor == '<%=MOV_EXPEDICAO_SUBST%>'));
				mostraCamposNO(mostra);
				mostraCalibracao(mostra);
				mostraCamposCde(false);
                mostraCamposAsa(false);
                ajax_AtualizaLocalizacao();
			}
		});
		maxAjaxObj.get();
	}
	function atualizarNOCampos(valor){
		var url = "../ajax/sce_mov_no_campos.asp";
		url += "?no_id=" + valor;

		var maxAjaxObj = new max.Ajax(url,{update:"",onComplete:
			function(texto,xml){
				var cde;
				var asa;

				cde = texto.substring(0,1);
				asa = texto.substring(1);

				mostraCamposCde((cde == "1"));
				mostraCamposAsa((asa == "1"));
			}
		});
		maxAjaxObj.get();
	}

	function mostraCamposNO(mostra) {
		var exibir;
        if (mostra) {
            ajax_comboFornecedor();
            exibir = 'block';
        }
        else {
            exibir = 'none';
        }
		document.all.id_fornecedor.style.display = exibir;
		document.all.id_notafiscal.style.display = exibir;
		document.all.id_documento.style.display = exibir;
		document.all.nf_id.value = '';
		document.all.enf_id.value = '';
		document.all.doc_id.value = '';
    }

	function mostraCamposCde(mostra) {
		var exibir;
		if (mostra) exibir = 'block'; else exibir = 'none';
		document.all.id_cde.style.display = exibir;
		document.all.cde.value = '';

        if (document.all.notipo.value == '<%=MOV_ENTRADA%>') {
		    LimpaEquipamentosSubstituidos(document.all.eq_id.value);
		    document.all.id_substituicaoeq.style.display = exibir;
		}
	}
	function mostraCamposAsa(mostra) {
		var exibir;
		if (mostra) exibir = 'block'; else exibir = 'none';
		document.all.id_asa.style.display = exibir;
		document.all.ag_numero.value = '';
    }

	function mostraCalibracao(mostra) {
		var exibir;
		if (mostra) exibir = 'block'; else exibir = 'none';
		document.all.id_calibracao.style.display = exibir;
		document.all.fl_calibracao.checked = false;
	}
</script>

<%
    Dim tipoNota, ssql, rec, rsMov
    'Dim temCDE : temCDE = false
    'Dim temAS : temAS = false
    Dim mov_id : mov_id = ""
    Dim status_eq, eq_id, no_id, mov_despachante, mov_solicitante, tipo, cde
    Dim asa, nf_id, doc_id, mov_data, enf_id, fl_calibracao, linha
    Dim bUltimaMovComCde, iUltimoTipoMov, sUltimoCde, RS

    eq_id = Replace(request("eq_id"), " ", "")
    status_eq = request("status")
    tipo = request("notipo")
    no_id = request("noid")
    enf_id = request("enf_id")
    nf_id = request("nf_id")
    mov_despachante = request("mov_despachante")
    mov_solicitante = request("mov_solicitante")
    cde = request("cde")
    asa = request("asa")
    doc_id = request("doc_id")
    mov_id = request("mov_id")
    bUltimaMovComCde = False

    if request("diaMov") <> "" and request("mesMov") <> "" and request("anoMov") <> "" then
	    mov_data = request("diaMov") & "/" & request("mesMov") & "/" & request("anoMov")
	    if request("horaMov") <> "" and request("minutoMov") <> "" then
		    mov_data = mov_data & " " & request("horaMov") & ":" & request("minutoMov")
	    else
		    mov_data = mov_data & " 00:00"
	    end if
	    mov_data = CDate(mov_data)
    else
	    mov_data = Now()
    end if

    if (Ok_Alterar_Mov) and (request("recarregouform") <> "SIM") then
	    mov_id = request("mov_id")
	    ssql =	"SELECT m.*, n.NO_TIPO, nf.ENF_ID FROM SCE_Movimentacao m LEFT JOIN SCE_Natureza_Operacao n " & _
			    "ON m.NO_ID = n.NO_ID LEFT JOIN SCE_Nota_Fiscal nf ON m.NF_ID = nf.NF_ID " & _
			    "WHERE MOV_ID = " & mov_id
	    Set rsMov = Env.oConn.Execute(ssql)
'response.Write "SSQL: " & ssql & "<BR>"
'response.End

	    if not (rsMov.Eof and rsMov.Bof) then
		    if IsNull(rsMov("EQ_ID")) then eq_id = "" else eq_id = CStr(rsMov("EQ_ID"))
		    if IsNull(rsMov("NO_ID")) then no_id = "" else no_id = CStr(rsMov("NO_ID"))
		    if IsNull(rsMov("MOV_DESPACHANTE")) then mov_despachante = "" else mov_despachante = rsMov("MOV_DESPACHANTE")
		    if IsNull(rsMov("MOV_SOLICITANTE")) then mov_solicitante = "" else mov_solicitante = rsMov("MOV_SOLICITANTE")
		    if IsNull(rsMov("NO_TIPO")) then tipo = "" else tipo = CStr(rsMov("NO_TIPO"))
		    if IsNull(rsMov("CDE")) then cde = "" else cde = rsMov("CDE")
		    if IsNull(rsMov("ASA")) then asa = "" else asa = CStr(rsMov("ASA"))
		    if IsNull(rsMov("NF_ID")) then nf_id = "" else nf_id = CStr(rsMov("NF_ID"))
		    if IsNull(rsMov("DOC_ID")) then doc_id = "" else doc_id = CStr(rsMov("DOC_ID"))
		    if IsNull(rsMov("MOV_DATA")) then mov_data = "" else mov_data = rsMov("MOV_DATA")
		    if IsNull(rsMov("ENF_ID")) then enf_id = "" else enf_id = CStr(rsMov("ENF_ID"))
		    if IsNull(rsMov("FL_CALIBRACAO")) then fl_calibracao = "" else fl_calibracao = CStr(rsMov("FL_CALIBRACAO"))
	    end if
	    rsMov.Close
	    Set rsMov = Nothing
    'Else
    '	ssql =	"SELECT TIPO, CDE, FL_CALIBRACAO FROM vw_SCE_Movimentacao_Atual " & _
    '			"WHERE EQ_ID IN (" & eq_id & ")"
    '	Set rsMov = Env.oConn.Execute(ssql)
    '	if not (rsMov.Eof and rsMov.Bof) then
    '		linha = 0
    '		iUltimoTipoMov = 0
    '		sUltimoCde = ""
    '		While Not rsMov.Eof 
    '			if IsNull(rsMov("FL_CALIBRACAO")) then fl_calibracao = "" else fl_calibracao = CStr(rsMov("FL_CALIBRACAO"))
    '			if IsNull(rsMov("TIPO")) then iUltimoTipoMov = "" else iUltimoTipoMov = CStr(rsMov("TIPO"))
    '			if IsNull(rsMov("CDE")) then sUltimoCde = "" else sUltimoCde = CStr(rsMov("CDE"))
    '			rsMov.MoveNext
    '			linha = linha + 1
    '		WEnd
    '
    '		'# Verifica quantos equipamentos estao sendo movimentados. Se for apenas 1, pego a ultima movimentacao do equipamento
    '		If linha = 1 And sUltimoCde <> "" Then
    '			bUltimaMovComCde = True
    '		End If
    '	end if
    '	rsMov.Close
    '	Set rsMov = Nothing
    End If

    'response.write "AQUI<BR>"
    'response.write eq_id & "<BR>"
    'response.write status_eq & "<BR>"
    'response.write "tipo: " & tipo & "<BR>"
    'response.write "request tipo: " & request("notipo") & "<BR>"
    'response.write no_id & "<BR>"
    'response.write enf_id & "<BR>"
    'response.write nf_id & "<BR>"
    'response.write mov_despachante & "<BR>"
    'response.write mov_solicitante & "<BR>"
    'response.write tipo & "<BR>"
    'response.write cde & "<BR>"
    'response.write asa & "<BR>"
    'response.write doc_id & "<BR>"
    'response.write "recarrega: " & request("recarregouform") & "<BR>"
    'response.write ssql & "<BR>"
    'response.write 'rsMov("EQ_ID")
    'response.write enf_id & "   NF:" & nf_id
    'response.end
%>
<script type="text/javascript">
    var frm = document.forms[0];

    function validaMovimentacao() {
	    var frm = document.forms[0];

	    if( frm.notipo.value == "" ) {
		    alert("Tipo de movimentação não foi selecionado");
		    frm.notipo.focus();
	    }
	    else if( frm.noid.value == "" ) {
		    alert("Natureza da Operação não foi selecionada");
		    frm.noid.focus();
	    }
        else if (frm.solicitante.value == "") {
            alert("Nenhum solicitante foi informado");
            frm.solicitante.focus();
        }
        else if (frm.localizacao.value == "") {
            alert("Informe a localização do(s) equipamento(s)");
            frm.localizacao.focus();
        }
	    else if(isNaN(frm.cde.value)) {
		    alert("CDE inválido");
		    frm.cde.focus();
	    }
	    else if( frm.diaMov.value == "" ) {
		    alert("Nenhum dia para a movimentação foi informado");
		    frm.diaMov.focus();
	    }
	    else if( frm.mesMov.value == "" ) {
		    alert("Nenhum mês para a movimentação foi informado");
		    frm.mesMov.focus();
	    }
	    else if( frm.anoMov.value == "" ) {
		    alert("Nenhum ano para a movimentação foi informado");
		    frm.anoMov.focus();
	    }
	    else if( frm.horaMov.value == "" ) {
		    alert("Nenhuma hora para a movimentação foi informada");
		    frm.horaMov.focus();
	    }
	    else if( frm.minutoMov.value == "" ) {
		    alert("Nenhum minuto para a movimentação foi informado");
		    frm.minutoMov.focus();
	    }
	    else if(!ValidaEquipamentosSubstituidos(frm.eq_id.value))
        {
		    alert("Existem códigos inválidos para equipamentos de substituição");
	    }
	    else {<%
if Env.PerfilSce <> PERFIL_ADM then %>
		    document.formulario.diaMov.disabled = false;
		    document.formulario.mesMov.disabled = false;
		    document.formulario.anoMov.disabled = false;
		    document.formulario.horaMov.disabled = false;
		    document.formulario.minutoMov.disabled = false;<%
end if

if Ok_Alterar_Mov then %>
<%
else%>
<%
end if%>
		    frm.action = "mov_acessorios.asp";
		    frm.submit();
	    }
    }

    function LimpaEquipamentosSubstituidos(eqs)
    {
        var a = eqs.split(",");
        var i;
        var texto;

        for (i=0; i<a.length; i++) {
            document.getElementById('id' + a[i]).value = '';
            document.getElementById('linhaEQ_ID' + a[i]).innerHTML = '&nbsp;';
        }

        return true;
    }
    function ValidaEquipamentosSubstituidos(eqs)
    {
        var a = eqs.split(",");
        var i;
        var texto;

        for (i=0; i<a.length; i++)
        {
            texto = document.getElementById('linhaEQ_ID' + a[i]).innerText.replace(' ', '');
            if ((texto != 'Ok') && (texto != '')) {
                return false;
            }
        }
        return true;
    }
</script>

<div class="margem-10">
    <form name="formulario" method="post">
        <input type=hidden name="mov_id" value="<%=mov_id%>">
        <input type="hidden" name="eq_id" value="<%=eq_id%>">
        <input type="hidden" name="ehReserva" value="NAO">
        <input type="hidden" name="recarregouform" value="SIM">
        <input type="hidden" name="status" value="<%=status_eq%>">  <!-- pego o estado dos itens consultados para movimentar -->

        <table class="largura-total">
<%
'-- Se alterei uma movimentacao exibe uma msg de confirmaçao OK
    if request("alterouOK") = "1" then%>
            <tr><td class="texto-centralizado">Movimentação atualizada com sucesso !</td></tr>
<%  end if

'    if Env.PerfilSce = PERFIL_ADM then%>
<!--<tr>
	<td style="color: #800000;">
		<b>ATENÇÃO !</b><br><br>
		<blockquote>
			Estas movimentações podem estar sendo feitas para itens com diferentes <i>Status</i>
		</blockquote>
	</td>
</tr>
-->
<%
'    end if%>
            <tr>
	            <th>
		            Movimentação de itens <span class="text-warning">
<%  if status_eq = CStr(STATUS_EXPEDIDO) then response.write "Expedido(s)" %>
<%  if status_eq = CStr(STATUS_EXPEDIDO_SUBST) then response.write "Substituído(s)" %>
<%  if status_eq = CStr(STATUS_EM_USO) then response.write "Em Uso" %>
<%  if status_eq = CStr(STATUS_EM_ESTOQUE) then response.write "Em Estoque" %>
<%  if status_eq = CStr(STATUS_CADASTRADO) then response.write "Cadastrado(s)" %>
                    </span>
	            </th>
            </tr>
            <tr><td>&nbsp;</td></tr>
            <tr>
	            <td>
                    <table class="largura-total">
		            <tr>
			            <td width="200px">
				            Tipo de Movimentação:<br>
				            <select name="notipo"  onChange="javascript:atualizarNO(this.value);">
					            <option value="">--</option>
<%if Env.PerfilSce = PERFIL_ADM or (status_eq = CStr(STATUS_EXPEDIDO) or status_eq = CStr(STATUS_EXPEDIDO_SUBST) or status_eq = CStr(STATUS_CADASTRADO)) then%>
					        	<option value="<%=MOV_ENTRADA%>" <%if tipo = MOV_ENTRADA then response.write "selected"%>>Entrada</option>
<%end if%>

<%if Env.PerfilSce = PERFIL_ADM or (status_eq = CStr(STATUS_EM_USO)) then%>
        						<option value="<%=MOV_LOGISTICA_ENTRADA%>" <%if tipo = MOV_LOGISTICA_ENTRADA then response.write "selected"%>>Logística Entrada</option>
<%end if%>
<%if Env.PerfilSce = PERFIL_ADM or (status_eq = CStr(STATUS_EM_ESTOQUE)) then%>
						        <option value="<%=MOV_LOGISTICA_SAIDA%>" <%if tipo = MOV_LOGISTICA_SAIDA then response.write "selected"%>>Logística Saída</option>
						        <option value="<%=MOV_EXPEDICAO%>" <%if tipo = MOV_EXPEDICAO then response.write "selected"%>>Expedição</option>
						        <option value="<%=MOV_EXPEDICAO_SUBST%>" <%if tipo = MOV_EXPEDICAO_SUBST then response.write "selected"%>>Substituição</option>
<%end if%>
	 			            </select>
			            </td>
			            <td align="left" width="*">
				            Natureza de Operação:<br>
				            <div id="div_noid" align="left">
				                <select name="noid" id="noid"  onChange="javascript:atualizarNOCampos(this.value);">
				                    <option value="">--</option>
				                </select>
				            </div>
			            </td>
		            </tr>
		            </table>
	            </td>
            </tr>

            <tr id="id_fornecedor" style="display:none;">
	            <td valign="top"><br>
		            Fornecedor:<br>
		            <%'=Combo.Fornecedor("enf_id", "", "N", "FORNECEDOR", false)%>
                    <select name="enf_id" onchange="ajax_comboNotaFiscal()">
                    </select>
		            <script type="text/javascript">
			            //document.all.enf_id.onchange = enviaDados;
	                   function ajax_comboFornecedor()
                       {
                           var url = "../ajax/sce_combo_fornecedor.asp?tipo=F&completa=F";
                           var maxAjaxObj = new max.Ajax(url,{update:'',onComplete:
                               function(texto,xml) {
                                   document.all.enf_id.innerHTML = texto;
                               }
                           });
                           maxAjaxObj.get();
                       }
		            </script>
	            </td>
            </tr>

            <tr id="id_notafiscal" style="display:none;">
	            <td valign="top"><br>
		            Nota Fiscal:<br>
<%			if tipo = cstr(MOV_ENTRADA) then
				tipoNota = NF_ENTRADA
			elseif tipo = cstr(MOV_EXPEDICAO) Or tipo = cstr(MOV_EXPEDICAO_SUBST) then
				tipoNota = NF_SAIDA
			else
				tipoNota = "0"
			end if
            ''''''''''''''' DEIXAVA LENTA A TELA - FOI SUBSTITUIDA PELO AJAX
			'RW Combo.NotaFiscal("txtnf_id", "nf_id", nf_id, "N", tipoNota, enf_id) %>

                    <select name="nf_id" >
                    </select>
		            <script type="text/javascript">
	                   function ajax_comboNotaFiscal()
                       {
                           var nt = document.all.notipo.value;

                           if (nt == "<%=MOV_ENTRADA%>")
                               nt = "<%=NF_ENTRADA%>";
                           else if ((nt == "<%=MOV_EXPEDICAO%>") || (nt == "<%=MOV_EXPEDICAO_SUBST%>"))
                               nt = "<%=NF_SAIDA%>";
                           else
                               nt = "0";

                           //alert("enf_id: " + document.all.enf_id.value + "  .... notipo: " + nt );
                           var url = "../ajax/sce_combo_notaFiscal.asp?tipo=" + nt + "&fornecedor=" + document.all.enf_id.value;
                           var maxAjaxObj = new max.Ajax(url,{update:'',onComplete:
                               function(texto,xml) {
                                   document.all.nf_id.innerHTML = texto;
                               }
                           });
                           maxAjaxObj.get();
                       }
		            </script>

	            </td>
            </tr>

            <tr>
	            <td>
		            <table width="450px"  cellpadding="0" cellspacing="0">
		            <tr>
			            <td valign="top" id="id_documento" style="display:none;"><br>
				            Documento:<br>
				            <select name="doc_id" >
					            <option value=0></option>
<%			ssql = "select * from sce_documentacao order by doc_id"
			set rec = Env.oconn.execute(ssql)
			if not rec.eof then
				while not rec.eof%>
					            <option value="<%=rec("doc_id")%>" <%if doc_id = CStr(rec("doc_id")) then response.write "selected"%>><%=Zeros(rec("doc_id"), 4)%></option>
<%					rec.movenext
				wend
			end if%>
				            </select>
			            </td>
			            <td valign="top" ><br>
				            <div id="id_cde" style="display:none;">
				            CDE:<br>
				            <input type="text" name="cde"  value="<%=cde%>"><br>
				            </div>
			            </td>
		            </tr>
		            </table>
	            </td>
            </tr>

            <tr>
	            <td>
		            <table>
		            <tr>
			            <td valign="top" width="200px"><br>
				            Solicitante:<br>
				            <input type="text" name="solicitante"  value="<%=mov_solicitante%>">
				            <br>
			            </td>
			            <td id="id_calibracao" style="display:none;">
				            <br>
				            <input type="checkbox" name="fl_calibracao" value="1" title="Marque esta opção se o(s) item(ns) é expedido ou retorna de uma Calibração"> Calibração (<span class="text-danger">Se calibração OK, marcar este item!</span>)
			            </td>
		            </tr>
		            </table>
	            </td>
            </tr>

            <tr id="id_asa" style="display:none;">
	            <td valign="top"  colspan="2"><br>
		            AS:<br>
                    <%=Combo.MeusAgendamentos(False, "txtAg_numero", "ag_numero", asa, "N")%> <br>
	            </td>
            </tr>
            <tr><td>&nbsp;</td></tr>
            <tr>
	            <td>
		            Localização/Ambiente: (<i>* campo obrigatório</i>)<BR>
<%
                    call comboBDSQL("localizacao", Env.oConn, "SELECT NULL as valor, '*** Selecione o Tipo de Movimentação ***' as descricao ", "N", "N") 
%>
                    <script type="text/javascript">
                        function ajax_AtualizaLocalizacao()
                        {
                            var frm = document.forms[0];
                            var amb_id = ""; //documents.frm.ambiente.value;
                            var id_crt = "1";  //Tabela CentroReferencia
                            var amb_modulo;
                            var notipo = frm.notipo.value;

                            if ((notipo == "<%=MOV_ENTRADA%>") || (notipo == "<%=MOV_LOGISTICA_ENTRADA%>") || (notipo == "<%=MOV_EXPEDICAO%>") || (notipo == "<%=MOV_EXPEDICAO_SUBST%>"))
                                amb_modulo = "<%=Application("SISLAB_ID_APLICACAO_SCE")%>";
                            else // MOV_LOGISTICA_SAIDA = <%=MOV_LOGISTICA_SAIDA%>
                                amb_modulo = "<%=Application("SISLAB_ID_APLICACAO_SISLAB")%>";

                            var url = '../ajax/sislab_combo_ambiente.asp?amb_id=' + amb_id + '&id_crt=' + id_crt + '&amb_modulo=' + amb_modulo;

                            var maxAjaxObj = new max.Ajax(url, {
                                update: '', onComplete:
                                    function (texto, xml) {
                                        var frm = document.forms[0];
                                        frm.localizacao.innerHTML = texto;
                                    }
                            });
                            maxAjaxObj.get();
                        }
                    </script>

	            </td>
            </tr>

            <tr>
	            <td valign="top" width="100px">
		            <table  cellpadding="2" cellspacing="0" border="0" width="400px">
		            <tr>
			            <td><Br>Data Real da Movimentação:<br><%=Combo.Data("Mov")%></td>
			            <td><Br>Hora da Movimentação:<br><%=Combo.Horario("Mov")%></td>
		            </tr>
		            </table>
	            </td>
            </tr>
            <tr id="id_substituicaoeq" style="display:none;">
                <td>
		            <table class="largura-total">
                        <tr><td>&nbsp;</td></tr>
                        <tr><td class="destaque">Item(ns) movimentados (preencha se houve a troca ou substituição de SGP)</td></tr>
                        <tr>
                            <td valign="top">
<%  'exibe os equipamentos que estão sendo movimentados
    ssql = "SELECT EQ_ID, EQ_CODIGOBARRAS, MOD_CODNOME, DESC_STATUS, EQ_CODIGOBARRASANTERIOR " & _
           "FROM vw_SCE_Equipamentos_Fabricantes " & _
           "WHERE EQ_ID IN (" & eq_id & ")"
    Set RS = Env.oConn.Execute(ssql) %>
		                        <table class="largura-total table-bordered table-condensed">
		                        <tr><th>Cód. Barras (novo)</th><th>Modelo</th><th>Situação</th><th>Cód. Barras Anterior (substituído)</th></tr>
<%  Dim sclasse
    linha=0
    While Not RS.Eof
        If (linha Mod 2) = 0 Then
            sclasse = "Azul1Bg"
        Else
            sclasse = ""
        End If
%>
		                        <tr>
			                        <td class="<%=sclasse%>"><%=RS("EQ_CODIGOBARRAS")%></td>
			                        <td class="<%=sclasse%>"><%=RS("MOD_CODNOME")%></td>
			                        <td class="<%=sclasse%>"><%=RS("DESC_STATUS")%></td>
			                        <td class="<%=sclasse%>" align="center">
			                            <input type="text"  name="eq_id<%=RS("EQ_ID")%>" id="id<%=RS("EQ_ID")%>" value="<%=RS("EQ_CODIGOBARRASANTERIOR")%>" maxlength="16" size="21" onblur="javascript:TestaEquipamento(this, <%=RS("EQ_ID")%>, false);" onkeyup="javascript:TestaEquipamento(this, <%=RS("EQ_ID")%>, true);" onkeypress="javascript:onlynum(this);">
			                        </td>
			                        <td id="linhaEQ_ID<%=RS("EQ_ID")%>">&nbsp;</td>
		                        </tr>
<%      RS.MoveNext
        linha = linha + 1
    WEnd %>
                                <script type="text/javascript">
                                    function TestaEquipamento(eu, eq_id, keypress) {
                                        if (eu.value != '') {
                                            //chama a função para testar o equipamento
                                            if (((eu.value.length > 15) && (keypress)) || ((eu.value.length <= 15) && (!keypress))) {
                                                var url = "../ajax/sce_testa_codbarras.asp";
                                                url += "?codbarras=" + eu.value;

                                                var maxAjaxObj = new max.Ajax(url, { update: "", onComplete:
			                                    function(texto, xml) {
			                                        if (texto == '0') {
			                                            document.getElementById('linhaEQ_ID' + eq_id).innerHTML = '<span class="circ_desat">Equipamento não encontrado</span>';
			                                        }
			                                        else if (texto == '') {
			                                            document.getElementById('linhaEQ_ID' + eq_id).innerHTML = '';
			                                        }
			                                        else {
			                                            document.getElementById('linhaEQ_ID' + eq_id).innerHTML = '<span class="circ_ativ">Ok</span>';
			                                        }
			                                    }
                                                });
                                                maxAjaxObj.get();
                                            }
                                        }
                                        else
                                            document.getElementById('linhaEQ_ID' + eq_id).innerHTML = '';

                                        return true;
                                    }
                                    </script>
                                </table>
                            </td>
                        </tr>
                    </table>
                </td>
            </tr>

            <tr>
	            <td valign="top" ><br><%
if Ok_Alterar_Mov then%>
		            <input type="button" value=" Alterar este Movimento "  onClick="javascript:validaMovimentacao();"><%
else%>
            		<input type="button" value=" Movimentar "  onClick="javascript:validaMovimentacao();"><%
end if
%>		            <br>
            	</td>
            </tr>
        </table>
    </form>
</div>

<script type="text/javascript">
<%if tipo <> "" then%>
document.formulario.notipo.value='<%=tipo%>';
atualizarNO(<%=tipo%>);
<%end if%>

document.formulario.diaMov.value = "<%=Zeros(Day(mov_data),2)%>";
document.formulario.mesMov.value = "<%=Zeros(Month(mov_data),2)%>";
document.formulario.anoMov.value = "<%=Year(mov_data)%>";

document.formulario.horaMov.value = "<%=Zeros(Hour(mov_data),2)%>";
document.formulario.minutoMov.value = "<%=Zeros(Minute(mov_data),2)%>";

<%
if Env.PerfilSce <> PERFIL_ADM then %>
document.formulario.diaMov.disabled = true;
document.formulario.mesMov.disabled = true;
document.formulario.anoMov.disabled = true;
document.formulario.horaMov.disabled = true;
document.formulario.minutoMov.disabled = true;
<%
end if%>

<%if fl_calibracao = "1" then%>
document.all.fl_calibracao.checked = true;
<%end if%>
</script>


<%
    Set Combo = Nothing
    Set Env = Nothing
Else
    RW Tela.Mensagem.AcessoRestritoSCE()
End If

Call Tela.MostraRodape()
%>
