<!--#include file="includes/controlesHTML_SCE.asp" -->
<!--#include file="../includes/funcoes.asp" -->
<!--#include file="../includes/global.asp" -->   <!-- constantes usada pelo menu -->
<!--#include file="includes/padraoHTML.asp"-->
<!--#INCLUDE FILE="includes/abre.asp" -->
<!--#INCLUDE FILE="includes/global_SCE.asp" -->
<!--#INCLUDE FILE="includes/bib_str.asp" -->

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
		if (mostra) exibir = 'block'; else exibir = 'none';
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
Dim tipousuario : tipousuario = ""
Dim Ok_Alterar_Mov : Ok_Alterar_Mov = False 
Dim mov_id : mov_id = ""
Dim status_eq, eq_id, no_id, mov_despachante, mov_solicitante, tipo, cde
Dim asa, nf_id, doc_id, mov_data, enf_id, fl_calibracao, linha
Dim bUltimaMovComCde, iUltimoTipoMov, sUltimoCde

eq_id = request("eq_id")
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

Ok_Alterar_Mov = (session("status") = PERFIL_ADM and request("mov_id") <> "")

if session("status") = PERFIL_ADM then tipousuario = " <span style='color:#800000;'>(Administrador)</span>"

if Ok_Alterar_Mov then
	call ImprimeCabecalho("", MENU_OFF, false, "Altera Movimentação de Item" & tipousuario, "", "window.close();")
else
	call ImprimeCabecalho("", MENU_ON, true, "Movimentação de Item" & tipousuario, "", "history.go(-1);")
end if

if (Ok_Alterar_Mov) and (request("recarregouform") <> "SIM") then
	mov_id = request("mov_id")
	ssql =	"SELECT m.*, n.NO_TIPO, nf.ENF_ID FROM SCE_Movimentacao m LEFT JOIN SCE_Natureza_Operacao n " & _
			"ON m.NO_ID = n.NO_ID LEFT JOIN SCE_Nota_Fiscal nf ON m.NF_ID = nf.NF_ID " & _
			"WHERE MOV_ID = " & mov_id
	Set rsMov = Conn.Execute(ssql)
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
'	Set rsMov = Conn.Execute(ssql)
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
<script language="JavaScript">
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
	else if( frm.solicitante.value == "" ) {
		alert("Nenhum solicitante foi informado");
		frm.solicitante.focus();
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
	else {<%
if session("status") <> PERFIL_ADM then%>
		document.formulario.diaMov.disabled = false;
		document.formulario.mesMov.disabled = false;
		document.formulario.anoMov.disabled = false;
		document.formulario.horaMov.disabled = false;
		document.formulario.minutoMov.disabled = false;<%
end if

if Ok_Alterar_Mov then%>
<%
else%>
<%
end if%>
		frm.action = "mov_acessorios.asp";
		frm.submit();
	}
}
</script>
<form name="formulario" method="post">
<input type=hidden name="mov_id" value="<%=mov_id%>">
<input type="hidden" name="eq_id" value="<%=eq_id%>">
<input type="hidden" name="ehReserva" value="NAO">
<input type="hidden" name="recarregouform" value="SIM">
<input type="Hidden" name="status" value="<%=status_eq%>">  <!-- pego o estado dos itens consultados para movimentar -->
<table width="100%" border="0" CLASS="texto">
<%
'-- Se alterei uma movimentacao exibe uma msg de confirmaçao OK
if request("alterouOK") = "1" then%>
<tr><td class="titulo" align="center">Movimenta&ccedil;&atilde;o atualizada com sucesso !</td></tr><%
end if

if session("status") = PERFIL_ADM then%>
<tr>
	<td style="color: #800000;">
		<b>ATEN&Ccedil;&Atilde;O !</b><br><br>
		<blockquote>
			Estas movimentações podem estar sendo feitas para itens com diferentes <i>Status</i>
		</blockquote>
	</td>
</tr>
<%
end if%>
<tr>
	<td class="titulo">
		Movimenta&ccedil;&atilde;o de itens <u>
<%if status_eq = CStr(STATUS_EXPEDIDO) then response.write "Expedido(s)"%>
<%if status_eq = CStr(STATUS_EXPEDIDO_SUBST) then response.write "Substituído(s)"%>
<%if status_eq = CStr(STATUS_EM_USO) then response.write "Em Uso"%>
<%if status_eq = CStr(STATUS_EM_ESTOQUE) then response.write "Em Estoque"%>
<%if status_eq = CStr(STATUS_CADASTRADO) then response.write "Cadastrado(s)"%>
		</u>
	</td>
</tr>
<tr><td>&nbsp;</td></tr>
</tr>
<tr>
	<td>
		<table cellpadding="0" width="100%" CLASS="texto">
		<tr>
			<td width="200px">
				Tipo de Movimentação:<br>
				<select name="notipo" class="form" onChange="javascript:atualizarNO(this.value);">
					<option value="">--</option>
<%if session("status") = PERFIL_ADM or (status_eq = CStr(STATUS_EXPEDIDO) or status_eq = CStr(STATUS_EXPEDIDO_SUBST) or status_eq = CStr(STATUS_CADASTRADO)) then%>
						<option value="<%=MOV_ENTRADA%>" <%if tipo = MOV_ENTRADA then response.write "selected"%>>Entrada</option>
<%end if%>

<%if session("status") = PERFIL_ADM or (status_eq = CStr(STATUS_EM_USO)) then%>
						<option value="<%=MOV_LOGISTICA_ENTRADA%>" <%if tipo = MOV_LOGISTICA_ENTRADA then response.write "selected"%>>Logística Entrada</option>
<%end if%>
<%if session("status") = PERFIL_ADM or (status_eq = CStr(STATUS_EM_ESTOQUE)) then%>
						<option value="<%=MOV_LOGISTICA_SAIDA%>" <%if tipo = MOV_LOGISTICA_SAIDA then response.write "selected"%>>Logística Saída</option>
						<option value="<%=MOV_EXPEDICAO%>" <%if tipo = MOV_EXPEDICAO then response.write "selected"%>>Expedição</option>
						<option value="<%=MOV_EXPEDICAO_SUBST%>" <%if tipo = MOV_EXPEDICAO_SUBST then response.write "selected"%>>Substituição</option>
<%end if%>
	 			</select>
			</td>
			<td align="left" width="*">
				Natureza de Operação:<br>
				<div id="div_noid" align="left">
				<select name="noid" id="noid" class="texto" onChange="javascript:atualizarNOCampos(this.value);">
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
<%		call comboFornecedor("enf_id", conn, enf_id, "N", "", false)%>
		<script language="JavaScript">
			//document.all.enf_id.onchange = enviaDados;
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
				tipoNota = ""
			end if
			Call comboNotaFiscal("txtnf_id", "nf_id", Conn, nf_id, "N", tipoNota, enf_id)%>
	</td>
</tr>

<tr>
	<td>
		<table width="450px" class="texto" cellpadding="0" cellspacing="0">
		<tr>
			<td valign="top" id="id_documento" style="display:none;"><br>
				Documento:<br>
				<select name="doc_id" class="form">
					<option value=0></option>
<%			ssql = "select * from sce_documentacao order by doc_id"
			set rec = conn.execute(ssql)
			if not rec.eof then
				while not rec.eof%>
					<option value="<%=rec("doc_id")%>" <%if doc_id = CStr(rec("doc_id")) then response.write "selected"%>><%=Zeros(rec("doc_id"), 4)%></option>
<%					rec.movenext
				wend
			end if%>
				</select>
			</td>
			<td valign="top" CLASS="texto"><br>
				<div id="id_cde" style="display:none;">
				CDE:<br>
				<input type="text" name="cde" class="form" value="<%=cde%>"><br>
				</div>
			</td>
		</tr>
		</table>
	</td>
</tr>

<tr>
	<td>
		<table class="texto" cellpadding="0" cellspacing="0">
		<tr>
			<td valign="top" width="200px"><br>
				Solicitante:<br>
				<input type="text" name="solicitante" class="form" value="<%=mov_solicitante%>">
				<br>
			</td>
			<td id="id_calibracao" style="display:none;">
				<br>
				<input type="checkbox" name="fl_calibracao" value="1" title="Marque esta opção se o(s) item(ns) é expedido ou retorna de uma Calibração"> Calibração (<font color="red">Se calibração OK, marcar este item!</font>)
			</td>
		</tr>
		</table>
	</td>
</tr>

<tr id="id_asa" style="display:none;">
	<td valign="top" CLASS="texto" colspan="2"><br>
		AS:<br>
<%	Call comboAgendamento("txtAg_numero", "ag_numero", Conn, asa, "N")%> <br>
	</td>
</tr>

<tr><td>&nbsp;</td></tr>
<tr>
	<td>
		Localização: (<i>Informar apenas quando for devolução</i>)<BR>
		<input type="text" class="form" name="localizacao" size="25" value="">
	</td>
</tr>

<tr>
	<td valign="top" width="100px">
		<table class="texto" cellpadding="2" cellspacing="0" border="0" width="400px">
		<tr>
			<td><Br>Data Real da Movimentação:<br><%Call comboData("Mov")%></td>
			<td><Br>Hora da Movimentação:<br><%Call comboHorario("Mov")%></td>
		</tr>
		</table>
	</td>
</tr>
<tr>
	<td valign="top" CLASS="texto"><br><%
if Ok_Alterar_Mov then%>
		<input type="button" value=" Alterar este Movimento " class="form" onClick="javascript:validaMovimentacao();"><%
else%>
		<input type="button" value=" Movimentar " class="form" onClick="javascript:validaMovimentacao();"><%
end if
%>		<br>
	</td>
</tr>
 </table>
</form>
<script language="JavaScript">
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
if session("status") <> PERFIL_ADM then%>
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
conn.close
set conn=nothing
call ImprimeRodape (RODAPE_OFF)
%>
