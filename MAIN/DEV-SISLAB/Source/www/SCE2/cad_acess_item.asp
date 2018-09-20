<!------- SCE ------->
<!--#include file="includes/global_SCE.asp"-->
<!------- SISLAB ---->
<!--#include file="../includes/bib_str.asp"-->
<!--#include file="../includes/padraoHTML.asp"-->
<!--#include file="../includes/global.asp" -->   <!-- constantes usada pelo menu -->
<!--#include file="../includes/Geral_Lib.asp"-->
<!--#include file="../includes/Sislab_Lib.asp"-->
<!------- LIB ------->
<!--#include file="../Classes/Classe_Combo.asp"-->
<%
Tela.SetNomeTela = "SCE > Cadastro > Item" : Tela.SetCaminhoRelativo = "../"
Call Tela.MostraCabecalho()

If Env.UsuarioSCE() Then
    Dim Combo
    Set Combo = New TCombo

    Call Tela.ImprimeMenuSce()
%>
<script language="JavaScript" src="includes/bib_obj.js"></script>
<script language="JavaScript" src="includes/bib_str.js"></script>
<script>
	<!--#INCLUDE FILE="includes/vform.js" -->
	<!--#INCLUDE FILE="includes/montacnpj.inc" -->
	<!--#INCLUDE FILE="includes/estado.asp" -->
</script>
<%
Dim ssql, rec, recFab
Dim eq_id, descricao, instrumental, fab_id, fab_id_old, mod_id
Dim numeroserie, codbarras, codbarrasanterior, unidade, estoque, localizacao
Dim obs, manutencaopreventiva, deltaoperacao, umidadeoperacao
Dim warmupoperacao, deltaarmazenagem, umidadearmazenagem
Dim propriedade, status, conforme, valor, freq_calibracao
Dim id_Plataforma, id_PlataformaAnterior
Dim linha
Dim bln_AcessoRAT
Dim DtUltInventario
Dim iSeq

'bln_AcessoRAT = (Cstr(Session("status")) = Cstr(PERFIL_ADM))
bln_AcessoRAT = (Cstr(Session("status") )= Cstr(PERFIL_RAT))
eq_id = trim(cstr(request("eq_id")))

'-- form deu submit para ele proprio
if (request("enviou") = "1") then  '(eq_id = "") and 
	mod_id = cstr(request("mod_id"))
	fab_id = cstr(request("fab_id"))
	fab_id_old = fab_id
	descricao = request("descricao")
	instrumental = request("instrumental")
	numeroserie = request("numeroserie")
	codbarras = request("codbarras")
    codbarrasanterior = request("codbarrasanterior")
	unidade = request("unidade")
	estoque = request("estoque")
	localizacao = request("localizacao")
	obs = request("obs")
	manutencaopreventiva = request("manutencaopreventiva")
	deltaoperacao = request("deltaoperacao")
	umidadeoperacao = request("umidadeoperacao")
	warmupoperacao = request("warmupoperacao")
	deltaarmazenagem = request("deltaarmazenagem")
	umidadearmazenagem = request("umidadearmazenagem")
	propriedade = request("propriedade")
	conforme = request("conforme")
	status = request("status")
	id_Plataforma = request("plataforma")
	DtUltInventario = Request("DtUltInventario")
	freq_calibracao = Request("freq_calibracao")
else
	'-- suponho que foi chamado atraves de outro form para alteracao de um ITEM
	if eq_id <> "" then
		ssql = "SELECT e.*, p.S_ID, convert(varchar, EQ_DT_ULT_INVENTARIO, 103) + ' ' + LEFT(convert(varchar, EQ_DT_ULT_INVENTARIO, 108),5) AS ULT_INVENT, EQ_FREQ_CALIBRACAO "
		ssql = ssql & "FROM vw_SCE_Equipamentos e "
		ssql = ssql & "LEFT JOIN PLATAFORMA_EQUIPAMENTOS p ON e.ID = p.EQ_ID " 
		ssql = ssql & "WHERE e.ID = " & eq_id
		set rec = Env.oconn.execute(ssql)
		if not rec.eof then
			'-- pego dados do modelo
			mod_id = rec("MOD_ID")
			if isNull(mod_id) then mod_id = "" else mod_id = cstr(mod_id)

			'-- Pego o fabricante do modelo
			if mod_id <> "" then
				ssql = "select FAB_ID from SCE_Modelos where mod_id = " & mod_id
				set recFab = Env.oconn.execute(ssql)
				if not recFab.eof then
					fab_id = cstr(recFab("FAB_ID"))
				end if
				recFab.Close
				set recFab = Nothing
			end if

			localizacao = rec("EQ_LOCALIZACAO")
			if isNull(localizacao) then localizacao = ""
			obs = rec("EQ_OBS")
			if isNull(obs) then obs = ""

			id_Plataforma = rec("S_ID")
			If IsNull(id_Plataforma) Then id_Plataforma = ""
			id_PlataformaAnterior = id_Plataforma

			instrumental = rec("EQ_INSTRUMENTAL")
			if isNull(instrumental) then instrumental = ""
			numeroserie = rec("EQ_NUMEROSERIE")
			if isNull(numeroserie) then numeroserie = ""
			codbarras = rec("EQ_CODIGOBARRAS")
			if isNull(codbarras) then codbarras = ""
			codbarrasanterior = rec("EQ_CODIGOBARRASANTERIOR")
			if isNull(codbarrasanterior) then codbarrasanterior = ""
			manutencaopreventiva = rec("EQ_MANUT_PREVENTIVA")
			if isNull(manutencaopreventiva) then manutencaopreventiva = ""
			deltaoperacao = rec("EQ_OPER_DELTA")
			if isNull(deltaoperacao) then deltaoperacao = ""
			umidadeoperacao = rec("EQ_OPER_UMIDADE")
			if isNull(umidadeoperacao) then umidadeoperacao = ""
			warmupoperacao = rec("EQ_OPER_WARMUP")
			if isNull(warmupoperacao) then warmupoperacao = ""
			deltaarmazenagem = rec("EQ_ARMA_DELTA")
			if isNull(deltaarmazenagem) then deltaarmazenagem = ""
			umidadearmazenagem = rec("EQ_ARMA_UMIDADE")
			if isNull(umidadearmazenagem) then umidadearmazenagem = ""
			propriedade = rec("EQ_PROPRIEDADE")
			if isNull(propriedade) then propriedade = ""
			status = rec("STATUS")
			if isNull(status) then status = ""
			conforme = rec("EQ_CONFORME")
			DtUltInventario = rec("ULT_INVENT")
			freq_calibracao = rec("EQ_FREQ_CALIBRACAO")
			if IsNull(freq_calibracao) then freq_calibracao = ""
		end if
	end if
end if

fab_id_old = fab_id		'-- guardo o id do fabricante original

%>
<form method="post" name="formulario">
<input type="Hidden" name="enviou" value="1">
<input type="Hidden" name="eq_id" value="<%=eq_id%>">
<input type="Hidden" name="status" value="<%=status%>">

<table border="0">

<%'-- parametro passado por cad_acess_item2.asp caso o item tenha sido cadastrado com sucesso
	if request("cadastrou") <> "" then%>
	<tr valign="middle" align="center">
		<td class="texto1"><b>Equipamento atualizado com sucesso !!!</b></td>
	</tr>
	<tr><td>&nbsp;</td></tr>
<%	end if%>

<%'-- parametro passado por exc_item.asp caso o item tenha sido excluido com sucesso
	if request("excluiu") <> "" then%>
	<tr valign="middle" align="center">
		<td class="texto1"><b>Equipamento exclu&iacute;do com sucesso !!!</b></td>
	</tr>
	<tr><td>&nbsp;</td></tr>
<%	end if%>
	<tr> 

	<td>
		<table cellpadding="0" cellspacing="0" border="0">
		<tr> 
			<td class="texto1" colspan='3'>
			Plataforma<br>
			<%RW Combo.ServicosPlataformas("plataforma", "N", "P")%>
			<script language="JavaScript">
			    document.forms[0].plataforma.value = '<%=id_Plataforma%>';
			</script>
			<input type='hidden' name='plataformaAnterior' value='<%=id_PlataformaAnterior%>'>
			&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
<%					If bln_AcessoRAT Then
					    If instrumental Then Response.Write "Instrumental" Else Response.Write "&nbsp;" End If 	%>
				<input type="hidden" name="instrumental" value="<%if (instrumental) then Response.Write 1 Else Response.Write 0 End If%>">
<%					Else %>
				<input type="checkbox" name="instrumental" value="1" <%if instrumental then response.write "checked"%>>&nbsp;Instrumental
<%					end if%>
			</td>

<script type="text/javascript" src="../ajax/max_ajax_ref.js" ></script>
<script type="text/javascript">
	function atualizarInventario(eq_id, limpar){
		var url = "../ajax/sce_equip_inventario_upd.asp";
		url += "?eq_id=" + eq_id;
		if(limpar) url += "&limpar=S";

		var maxAjaxObj = new max.Ajax(url,{update:"",onComplete:
			function(texto,xml){
				document.all.dtUltInventario.value = texto;
			}
		});
		maxAjaxObj.get();
	}
</script>
			<td class="texto1" align="right" colspan="2">
<%              If Not VVVNZ(eq_id) Then %>
				<table bgcolor="#CCCCCC"  class="texto1" cellpadding="2" cellspacing="2" border="0">
				<tr>
					<td>
						Último Inventário:<br>&nbsp;&nbsp;&nbsp;<input type="text" id="dtUltInventario" name="dtUltInventario" size="19" class="texto1" value="<%=DtUltInventario%>">
<%				    'If session("status") = PERFIL_RAT Then %>
<%				    If session("status") = PERFIL_ADM Then %>
						&nbsp;&nbsp;<input type="button" value=" Marcar " class="texto1" onClick="javascript:atualizarInventario(<%=eq_id%>, false);">
						&nbsp;&nbsp;<input type="button" value="Desmarcar" class="texto1" onClick="javascript:atualizarInventario(<%=eq_id%>, true);">
<%				    End If %>
					</td>
				</tr>
				</table>
<%				Else %>
                <input type="hidden" name="dtUltInventario" value="<%=DtUltInventario%>" />
<%				End If %>
                &nbsp;
			</td>
		</tr>

		<tr><td bgcolor="#FFFFFF" align="left" colspan="3" class="texto1"><br></td></tr>

		<tr>
			<td bgcolor="#FFFFFF" align="left" class="texto1">
				Fabricante<br>
					<select name="fab_id" class="texto1" style="width:300;" onChange="javascript:buscaModelos(this.value);">
						<option value="">-- Escolha um Fabricante --</option>
                     <%RW Combo.OptionBD("select f.fab_id as VALOR, f.fab_nome as DESCRICAO from sce_fabricantes f order by f.fab_nome", "", fab_id) %>
					</select>
			</td>

  			<td bgcolor="#FFFFFF" align="left" class="texto1">
			    Modelo<br>
<%					If mod_id = "" then valor = 0 else valor = cint(mod_id)

					If bln_AcessoRAT Then
						ssql = "select m.mod_id as VALOR, m.mod_codnome + ' - ' + CAST(m.mod_descricao as VARCHAR(100)) as DESCRICAO from sce_modelos m where fab_id = " & fab_id & " AND mod_id = " & valor
						Set rec = Env.oconn.execute(ssql) %>

						<input type="hidden" name="mod_id" class="texto1" value="<%=valor%>">
						<input type="text" name="mod_desc" class="texto1" size="50" value="<%If Not rec.Eof Then Response.Write rec("descricao")%>" readonly>
<%					Else %>

					<select name="mod_id" id="mod_id" class="texto1" style="width:280;" onChange="javascript:buscaPN(this.value);">
						<option value="">-- Escolha um Modelo --</option>
<%
						if fab_id <> "" or fab_id <> fab_id_old then
					        RW Combo.OptionBD("select m.mod_id as VALOR, m.mod_codnome + ' - ' + CAST(m.mod_descricao as VARCHAR(100)) as DESCRICAO from sce_modelos m where fab_id = " & fab_id & " ORDER BY m.mod_codnome, m.mod_descricao", "", valor)
						end if
%>
					</select>
<%					End If %>
			</td>

			<td class="texto1">
					PN:<br><input type="Text" value="" name="txtPN" id="txtPN" class="texto1" readonly="true">
			</td>
    		</tr>

		<tr><td bgcolor="#FFFFFF" align="left" colspan="3" class="texto1"><br></td></tr>
		<tr> 
			<td bgcolor="#FFFFFF" align="left" class="texto1">
				Número de Série:<br>
				<input type="text" class="texto1" name="numeroserie" size="40" maxlength="255" value="<%=numeroserie%>">
				<input type="Button" name="btn_ChecaNS" value="Verificar" class="texto1" title="Verifica se o número de série já está cadastrado em um equipamento" onClick="javascript:checaNS(this.value);">
			</td>

			<td class="texto1" colspan="1">
				Código de Barras<br>
				<input type="text" class="texto1" name="codbarras" style="width:200" maxlength="16" value="<%=codbarras%>">
			</td>

			<td class="texto1" colspan="2">
				Código de Barras Anterior<br>
				<input type="text" class="texto1" name="codbarrasanterior" style="width:200" maxlength="16" value="<%=codbarrasanterior%>">
			</td>
		</tr>

		<tr><td bgcolor="#FFFFFF" align="left" colspan="3" class="texto1">&nbsp;</td></tr>

		<tr class="texto1">
			<td>
				Localização<br>
				<input type="text" name="localizacao" class="texto1" size="50" maxlength="255" value="<%=localizacao%>">
				</td>
				<td colspan="2">
				Conforme<br>
<%				If bln_AcessoRAT Then %>
				<%if conforme or eq_id = "" then response.write "Sim" Else  response.write "Não" end if%>
				<input type="hidden" name="conforme" value="<%if conforme or eq_id = "" then response.write 1 Else  response.write 0 end if%>">
<%				Else %>
				<input type="Radio" name="conforme" value="1" <%if conforme or eq_id = "" then response.write "checked" end if%>>Sim&nbsp;&nbsp;&nbsp;
				<input type="Radio" name="conforme" value="0" <%if not conforme then response.write "checked" end if%>>N&atilde;o
<%				End If  %>
			</td>
    	</tr>

		<tr><td bgcolor="#FFFFFF" align="left" colspan="3" class="texto1"><br></td></tr>

		<tr>
      			<td bgcolor="#FFFFFF" colspan="3" class="texto1">Observações<br>
				<textarea class="texto1" name="obs" cols="140" rows="9"><%=obs%></textarea>
			</td>
		</tr>

		<tr><td colspan="3">&nbsp;</td></tr>
		<tr><td class="destaque" colspan="3">Dados de Manutenção</td></tr>
		<tr><td colspan="3">&nbsp;</td></tr>
		<tr>
      			<td colspan="3" class="texto1">Observações<br>
				<textarea class="texto1" name="manutencaopreventiva" cols="140" rows="9"><%=manutencaopreventiva%></textarea>
			</td>
		</tr>
		<tr><td colspan="3">&nbsp;</td></tr>
		<tr>
			<td colspan="3">
				<table width="100%" cellpadding="0" cellspacing="0" border="0">
				<tr> 
				    <td class="texto1" colspan="4">
					Opera&ccedil;&atilde;o<br>
					Delta: <input type="text" class="texto1" name="deltaoperacao" size="30" maxlength="50" value="<%=deltaoperacao%>">
					&nbsp;&nbsp;&nbsp;
					Umidade: <input type="text" class="texto1" name="umidadeoperacao" size="30" maxlength="50" value="<%=umidadeoperacao%>">
					&nbsp;&nbsp;&nbsp;
					Warm Up: <input type="text" class="texto1" name="warmupoperacao" size="30" maxlength="50" value="<%=warmupoperacao%>">
					</td>
				</tr>

				<tr><td class="texto1">&nbsp;</td></tr>

				<tr>
		      			<td class="texto1" colspan="4">
						Armazenagem<br>
						Delta: <input type="text" class="texto1" name="deltaarmazenagem" size="30" maxlength="50" value="<%=deltaarmazenagem%>">
						&nbsp;&nbsp;&nbsp;
						Umidade: <input type="text" class="texto1" name="umidadearmazenagem" size="30" maxlength="50" value="<%=umidadearmazenagem%>">
					</td>
				</tr>

				<tr><td>&nbsp;</td></tr>
				<tr><td class="destaque" colspan="4">Controle do Equipamento <!--(Calibra&ccedil;&atilde;o/Manuten&ccedil;&atilde;o/Qualifica&ccedil;&atilde;o)--></td></tr>
				<tr><td colspan="4">&nbsp;</td></tr>
				<tr>
					<td class="texto1" width="40%">
						&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
						Frequencia de Calibração: <input type="text" class="texto1" name="freq_calibracao" maxlength="7" size="5" value="<%=freq_calibracao%>">
					</td>
				</tr>

<script language="JavaScript">
var linha = 0;
var total_linhas = 0;
var frm = document.all.formulario;
</script>
<!--
				<tr>
					<td class="texto1" width="40%">Controle<br>
						<select name="controle" class="texto1" onChange="javascript:proxCampo(this, document.formulario.diascontrole);">
						<option value="">-- Selecione o controle --</option>
						<option value="<%'=CONTROLE_MANUTENCAO_PREVENTIVA%>">Manutenção Preventiva</option>
<%'If not bln_AcessoRAT Then%>
						<option value="">--------</option>
						<option value="<%'=CONTROLE_CALIBRACAO%>">Calibra&ccedil;&atilde;o</option>
						<option value="<%'=CONTROLE_MANUTENCAO%>">Manutenção Corretiva</option>
						<option value="<%'=CONTROLE_QUALIFICACAO%>">Qualifica&ccedil;&atilde;o</option>
<%'End If%>
						</select>
					</td>
					<td class="texto1" width="90px">Dias<br>
						<input type="text" name="diascontrole" class="texto1" size="5" maxlength="6" onKeyPress="javascript:proxCampo(this, document.formulario.diacontrole);">
					</td>
					<td class="texto1" colspan="2">Data do Controle<br>
						<%'Call ComboData("controle")%>
					</td>
				</tr>
				<tr><td class="texto1">&nbsp;</td></tr>
				<tr>
					<td class="texto1" width="40%">Registro / Certificado / CDE / RMA<br>
						<input type="text" class="texto1" name="registrocontrole" size="30" maxlength="50" onKeyPress="javascript:proxCampo(this, document.formulario.responsavelcontrole);">
					</td>
					<td colspan="2" class="texto1">Respons&aacute;vel<br>
						<input type="text" class="texto1" name="responsavelcontrole" size="30" maxlength="50" onKeyPress="javascript:proxCampo(this, document.formulario.btnInsereControle);">
					</td>
					<td align="right" valign="bottom"><button name="btnInsereControle" class="texto1" onClick="javascript:InsereControle();">&gt;&gt;&nbsp;Adicionar Controle</button>&nbsp;</td>
				</tr>

				<tr><td>&nbsp;</td></tr>
				<tr>
					<td colspan="4">
<script language="JavaScript">
var linha = 0;
var total_linhas = 0;
var frm = document.all.formulario;
function ValidaControle() {
	if(frm.controle.value == '') {
		alert('Tipo do controle deve ser selecionado');
		frm.controle.focus();
	}
	else if( (frm.diascontrole.value == '') && (frm.controle.value == '<%'=CONTROLE_CALIBRACAO%>') ) {
		alert('Número de dias deve ser preenchido para uma calibração');
		frm.diascontrole.focus();
	}
	else if((frm.diacontrole.value == '') || (frm.mescontrole.value == '') || (frm.anocontrole.value == '')) {
		alert('Data inválida');
		frm.diacontrole.focus();
	}
	else if(frm.registrocontrole.value == '') {
		alert('Registro/Certificado/CDE/RMA deve ser preenchido');
		frm.registrocontrole.focus();
	}
	else if(frm.responsavelcontrole.value == '') {
		alert('Responsável pelo controle deve ser preenchido');
		frm.responsavelcontrole.focus();
	}
	else
		return true;
	return false;
}
function InsereControle() {
	var i, datacontrole;
	var newrow;	var newtd;	var newtxt;

	if(!ValidaControle()) return false;

	linha++;
	total_linhas++;

	//-- apendo uma nova linha e suas colunas
	newrow=document.createElement("tr");

	newtd=document.createElement("td");
	if(frm.controle.value == "<%'=CONTROLE_CALIBRACAO%>")
		newtxt=document.createTextNode("Calibração");
	else if(frm.controle.value == "<%'=CONTROLE_MANUTENCAO%>")
		newtxt=document.createTextNode("Manutenção Corretiva");
	else if(frm.controle.value == "<%'=CONTROLE_MANUTENCAO_PREVENTIVA%>")
		newtxt=document.createTextNode("Manutenção Preventiva");
	else
		newtxt=document.createTextNode("Qualificação");

	newtd.appendChild(newtxt);
	newtd.setAttribute("id","linha_"+linha+"_col_1");
	newrow.appendChild(newtd);

	newtd=document.createElement("td");
	newtxt=document.createTextNode((frm.diascontrole.value == "" ? " " : frm.diascontrole.value));
	newtd.appendChild(newtxt);
	newtd.setAttribute("id","linha_"+linha+"_col_2");
	newtd.setAttribute("align","center");
	newrow.appendChild(newtd);

	newtd=document.createElement("td");
	datacontrole = frm.diacontrole.value+"/"+frm.mescontrole.value+"/"+frm.anocontrole.value;
	newtxt=document.createTextNode(datacontrole);
	newtd.appendChild(newtxt);
	newtd.setAttribute("id","linha_"+linha+"_col_3");
	newtd.setAttribute("align","center");
	newrow.appendChild(newtd);

	newtd=document.createElement("td");
	newtxt=document.createTextNode(frm.registrocontrole.value);
	newtd.appendChild(newtxt);
	newtd.setAttribute("id","linha_"+linha+"_col_4");
	newrow.appendChild(newtd);

	newtd=document.createElement("td");
	newtxt=document.createTextNode(frm.responsavelcontrole.value);
	newtd.appendChild(newtxt);
	newtd.setAttribute("id","linha_"+linha+"_col_5");
	newrow.appendChild(newtd);

	newtd=document.createElement("td");
	newtxt=document.createTextNode('x');
	newtd.appendChild(newtxt);
	newtd.setAttribute("id","linha_"+linha+"_col_6");
	newtd.setAttribute("align","center");
	newrow.appendChild(newtd);

	newrow.setAttribute("id","linha_" + linha);
	newrow.setAttribute("eqc_id", "0");   // ID do registro na tabela, caso exista

	// troca o conteúdo da ultima coluna colocando
	newtd.innerHTML = '<span onclick="javascript:RemoveControle('+linha+');" style="cursor: hand;"><img src="img/btn_excluir.gif"></span>';

	// vou inserir a linha na ordem correta
	var tb = document.getElementById("tb_controle_body");

	if(total_linhas == 1)
		tb.appendChild(newrow);
	else {
		var row, col1, col3;
		var node = null;
		var i = 0;
		var okay = false;

//alert(document.getElementById(tb.childNodes.item(i).id + "_col_1"));
//alert(document.getElementById(tb.childNodes.item(i).id + "_col_3"));

		while((i<total_linhas-1) && (!okay)) {

			if(document.getElementById(tb.childNodes.item(i).id + "_col_1") != null) {
				col1 = document.getElementById(tb.childNodes.item(i).id + "_col_1").innerText.substr(0,1);
				col3 = document.getElementById(tb.childNodes.item(i).id + "_col_3").innerText;
	
				if(frm.controle.value <= col1) {
					// Caso o "controle" seja igual tenho que percorrer todos os controles do
					// mesmo tipo
					if(frm.controle.value == col1) {
						if(concatenaData(datacontrole) <= concatenaData(col3)) {
							node = document.getElementById(tb.childNodes.item(i).id);
							okay = true;
						}
						else {
							// Enquanto a data a ser inserida for maior que as datas cadastradas
							// a tabela é percorrida
							i++;
							if(i < total_linhas - 1) {
								col3 = document.getElementById(tb.childNodes.item(i).id + "_col_3").innerText;
								col1 = document.getElementById(tb.childNodes.item(i).id + "_col_1").innerText.substr(0,1);
								while((i<total_linhas-1) && (frm.controle.value == col1) && (concatenaData(datacontrole) > concatenaData(col3))) {
									i++;
									if(i < total_linhas - 1) {
										col3 = document.getElementById(tb.childNodes.item(i).id + "_col_3").innerText;
										col1 = document.getElementById(tb.childNodes.item(i).id + "_col_1").innerText.substr(0,1);
									}
								}
								if(i < total_linhas - 1) {
									node = document.getElementById(tb.childNodes.item(i).id);
									okay = true;
								}
							}
						}
					}
					else {
						node = document.getElementById(tb.childNodes.item(i).id);
						okay = true;
					}
				}
			}
			i++;
		}

		// Insere o valor digitado
		if((node == null))
			tb.appendChild(newrow);
		else
			tb.insertBefore(newrow, node);
	}
}
function RemoveControle(l) {
	document.getElementById("linha_"+l).removeNode(true);
	total_linhas--;
}
</script>
						<select name="lista_controles" multiple style="display: none; width:500px;"></select>
						<table id="tb_controle" class="texto1" width="100%" cellpadding="2" cellspacing="0" border="1">
						<tr class="texto1">
							<th width="100px" align="left">Controle</th>
							<th width="50px">Dias</th>
							<th width="100px">Data Controle</th>
							<th align="left">Registro / Certif. / CDE / RMA</th>
							<th align="left">Respons&aacute;vel</th>
							<th><img src="img/btn_branco.gif"></th>
						</tr>
						<tbody id="tb_controle_body">
<%'				if eq_id <> "" then
'					ssql = "select EQC_ID, EQC_DIAS, convert(varchar, EQC_DATA, 103) AS EQC_DATA, EQC_REGISTRO, EQC_RESPONSAVEL, EQC_TIPO "
'					ssql = ssql & "from sce_equipamentos_controle where eq_id = "& eq_id & " "
'					ssql = ssql & "order by EQC_TIPO ASC, CAST(EQC_DATA AS DATETIME) DESC"
'					set rec = conn.execute(ssql)
'					linha = 0
'					while not rec.eof
'						linha = linha + 1%>
						<tr id="linha_<%'=linha%>" eqc_id="<%'=rec("EQC_ID")%>">
							<td id="linha_<%'=linha%>_col_1">
<%'					Select Case rec("EQC_TIPO")
'							Case CONTROLE_CALIBRACAO
'								Response.write "Calibração"
'							Case CONTROLE_MANUTENCAO
'								Response.write "Manutenção Corretiva"
'							Case CONTROLE_MANUTENCAO_PREVENTIVA
'								Response.write "Manutenção Preventiva"
'							Case CONTROLE_QUALIFICACAO
'								Response.write "Qualificação"
'						End Select%>
							</td>
							<td id="linha_<%'=linha%>_col_2" align="center"><%'if IsNull(rec("EQC_DIAS")) then response.write "&nbsp;" else response.write rec("EQC_DIAS")%></td>
							<td id="linha_<%'=linha%>_col_3" align="center"><%'=rec("EQC_DATA")%></td>
							<td id="linha_<%'=linha%>_col_4"><%'=rec("EQC_REGISTRO")%></td>
							<td id="linha_<%'=linha%>_col_5"><%'=rec("EQC_RESPONSAVEL")%></td>
							<td id="linha_<%'=linha%>_col_6" align="center">

<%'					If (bln_AcessoRAT And (rec("EQC_TIPO") = CONTROLE_MANUTENCAO_PREVENTIVA)) Or _
'							((Not bln_AcessoRAT) And (rec("EQC_TIPO") <> CONTROLE_MANUTENCAO_PREVENTIVA)) _
'						Then%>
								<span onClick="javascript:RemoveControle(<%'=linha%>);" style="cursor: hand;"><img src="img/btn_excluir.gif"></span>
<%'					Else %>
							&nbsp;
<%'					End If %>

							</td>
						</tr>
<%'						rec.MoveNext
'					wend%>
						<script language="JavaScript">
							linha = <%'=rec.RecordCount%>;
							total_linhas = <%'=rec.RecordCount%>;
						</script>
<%'					set rec = Nothing
'				end if%>
						</tbody>
						</table>
						</td>
					</tr>
					</table>
				</td>
			</tr>
-->
		</table>
      </td>
    </tr>

	<tr><td colspan="3">&nbsp;</td></TR>

	<tr><td class="texto1" colspan="3">Acessórios do Equipamento</td></tr>
	<tr>
		<td colspan="3">
  			<table width="100%" cellspacing="2" cellpadding="2" border="0">
				<tr>
				    <td valign="top" class="texto1">
					<button name="adicionar" class="texto1" onClick="NovoAcessorio();">Novo acess&oacute;rio</button><br>
					Qtde: <input type="Text" name="qtde_acessorios" size="4" maxlength="5" class="texto1" value="1">
					</td>

<script language="JavaScript">
var separa_campo = "¿?¿";
var linha_acess = 0;
var total_linhas_acess = 0;
var seq_acess = 0;

/* Cria uma nova combo conformidade para o acessorio Sim/Nao */
function ComboConformeAcessorio(escreve, id_combo) {
	var str = '';
	str += '<select name="' + id_combo + '" class="texto1">';
	str += '<option value="1">Sim</option>';
	str += '<option value="0">Não</option>';
	str += '</select>';
	if(escreve) document.write(str);
	return str;
}

/* Cria uma nova combo de situacoes para o acessorio */
function ComboSituacaoAcessorio(escreve, id_combo) {
	var str = '';
	str += '<select name="' + id_combo + '" class="texto1">';
	str += '<option value="<%=STATUS_EM_ESTOQUE%>">Em Estoque</option>';
	str += '<option value="<%=STATUS_EM_USO%>">Em Uso</option>';
	str += '<option value="<%=STATUS_EXPEDIDO%>">Expedido</option>';
	str += '<option value="<%=STATUS_EXPEDIDO_SUBST%>">Substituído</option>';
	str += '</select>';
	if(escreve) document.write(str);
	return str;
}

/* varre todas as linhas criadas validando os acessórios */
function ValidaAcessorios() {
	var i;
	if(total_linhas_acess > 0) {
		for(i=1; i<=linha_acess; i++)
			if(document.getElementById("desc_acess_"+i) != null) {
				if(document.getElementById("desc_acess_"+i).value == '') {
					alert('Acessório inválido (sequencial ' + document.getElementById("linha_acess_" + i + "_col_1").innerText + ')');
					document.getElementById("desc_acess_"+i).focus();
					return false;
				}
			}
	}
	return true;
}

/* Insere um novo acessorio */
function NovoAcessorio() {
	var i, datacontrole;
	var newrow;	var newtd;	var newtxt;

	// valido a quantidade de novos acessorios
	if(isNaN(document.all.qtde_acessorios.value) || (document.all.qtde_acessorios.value == '') ) {
		alert('Quantidade de acessórios não é válida');
		document.all.qtde_acessorios.focus();
		return;
	}
	else if((document.all.qtde_acessorios.value > 100) || (document.all.qtde_acessorios.value < 1)) {
		alert('Quantidade deve estar entre 0 e 100');
		document.all.qtde_acessorios.focus();
		return;
	}


	for(i=0; i<document.all.qtde_acessorios.value;i++) {
		seq_acess++;			// sequencial
		linha_acess++;
		total_linhas_acess++;
	
		//-- apendo uma nova linha e suas colunas
		newrow=document.createElement("tr");

		newtd=document.createElement("td");
		newtxt=document.createTextNode(total_linhas_acess);
		newtd.appendChild(newtxt);
		newtd.setAttribute("id","linha_acess_"+linha_acess+"_col_1");
		newrow.appendChild(newtd);
	
		newtd=document.createElement("td");
		newtxt=document.createTextNode("x");
		newtd.appendChild(newtxt);
		newtd.setAttribute("id","linha_acess_"+linha_acess+"_col_2");
		newrow.appendChild(newtd);
	
		newtd.innerHTML = "<input type='Text' class='form' size='80' maxlength='255' name='desc_acess_" + linha_acess + "'>";
	
		newtd=document.createElement("td");
		newtxt=document.createTextNode("BLA");
		newtd.appendChild(newtxt);
		newtd.setAttribute("id","linha_acess_"+linha_acess+"_col_3");
		newrow.appendChild(newtd);
	
		newtd.innerHTML = ComboSituacaoAcessorio(false, "status_acess_" + linha_acess);
	
		newtd=document.createElement("td");
		newtxt=document.createTextNode("BLA");
		newtd.appendChild(newtxt);
		newtd.setAttribute("id","linha_acess_"+linha_acess+"_col_4");
		newtd.setAttribute("align","center");
		newrow.appendChild(newtd);
	
		newtd.innerHTML = comboSimNao(false, "conforme_acess_" + linha_acess, 1);

		newtd=document.createElement("td");
		newtxt=document.createTextNode('x');
		newtd.appendChild(newtxt);
		newtd.setAttribute("id","linha_acess_"+linha_acess+"_col_5");
		newtd.setAttribute("align","center");
		newrow.appendChild(newtd);
	
		// troca o conteúdo da ultima coluna colocando
		newtd.innerHTML = '<span onclick="javascript:RemoveAcessorio('+linha_acess+');" style="cursor: hand;"><img src="img/btn_excluir.gif"></span>';
	
		newrow.setAttribute("id","linha_acess_" + linha_acess);

		document.getElementById("tb_acessorios_body").appendChild(newrow);
	}
	document.getElementById("desc_acess_"+linha_acess).focus();
}

/* Remove um acessorio da tabela, reordenando os sequenciais */
function RemoveAcessorio(linha) {
	var i, j=1; tb = document.getElementById("tb_acessorios_body");

	document.getElementById("linha_acess_"+linha).removeNode(true);
	total_linhas_acess--;

	// renumera o sequencial varrendo os itens
	for(i = 1; i<=linha_acess; i++) {
		if(document.getElementById("linha_acess_"+i) != null) {
			document.getElementById("linha_acess_" + i + "_col_1").innerText = j++;
		}
	}
}
</script>

				    <td valign="top" class="texto1">
						<!-- select utilizada para concatenar a lista de acessorios -->
						<select name="lista_acessorios" style="display:none" multiple></select>
						<table id="tb_acessorios" class="texto1" width="100%" cellpadding="0" cellspacing="0" border="1">
						<tr class="texto1">
							<th width="50px">Seq.</th>
							<th width="450px">Descri&ccedil;&atilde;o</th>
							<th width="100px">Situa&ccedil;&atilde;o</th>
							<th width="100px">Conforme</th>
							<th><img src="img/btn_branco.gif"></th>
						</tr>
						<tbody id="tb_acessorios_body">
<%		if eq_id <> "" then
			ssql = "select * from SCE_Acessorios where EQ_ID = " & eq_id & " "
			ssql = ssql & "order by SEQUENCIAL"
			set rec = Env.oconn.execute(ssql)
			iSeq = 0
			if not (rec.eof or rec.bof) then
				while not rec.eof%>
						<tr class="texto1" id="linha_acess_<%=rec("SEQUENCIAL")%>">
							<td id="linha_acess_<%=rec("SEQUENCIAL")%>_col_1"><%=rec("SEQUENCIAL")%></td>
							<td id="linha_acess_<%=rec("SEQUENCIAL")%>_col_2"><input type="Text" class="texto1" size="80" maxlength="255" name="desc_acess_<%=rec("SEQUENCIAL")%>" value="<%=rec("DESCRICAO")%>"></td>
							<td id="linha_acess_<%=rec("SEQUENCIAL")%>_col_3"><script language="JavaScript">ComboSituacaoAcessorio(true, "status_acess_<%=rec("SEQUENCIAL")%>");document.all.status_acess_<%=rec("SEQUENCIAL")%>.value=<%=rec("STATUS")%></script></td>
							<td id="linha_acess_<%=rec("SEQUENCIAL")%>_col_4" align="center"><script language="JavaScript">comboSimNao(true, "conforme_acess_<%=rec("SEQUENCIAL")%>", <%=cint(rec("CONFORME"))%>);</script></td>
							<td id="linha_acess_<%=rec("SEQUENCIAL")%>_col_5" align="center">

<%				    If bln_AcessoRAT Then %>
							&nbsp;
<%				    Else %>
							<span onClick="javascript:RemoveAcessorio('<%=rec("SEQUENCIAL")%>');" style="cursor: hand;"><img src="img/btn_excluir.gif"></span>
<%				    End If %>
							</td>

						</tr>
<%					iSeq = rec("SEQUENCIAL")
                    rec.MoveNext
				WEnd
%>
			<script language="JavaScript">
				linha_acess = <%=iSeq%>;
				total_linhas_acess = <%=iSeq%>;
				seq_acess = <%=iSeq%>;
			</script>
<%
			end if
			Set rec = Nothing
		end if %>
						</tbody>
						</table>

					</td>
				</tr>
			</table>
	  	</td>
	</tr>

	<tr><td colspan="3">&nbsp;</td></tr>

	<tr>	
		<td class="texto1" colspan="3">Propriedade:<br>
<%If bln_AcessoRAT Then
		Select Case propriedade
		Case EQ_PROPRIEDADE_TER
			Response.write "Terceiros"
		Case EQ_PROPRIEDADE_EBT
			Response.write "Embratel"
		Case EQ_PROPRIEDADE_CRT
			Response.write "Embratel CRT"
		Case EQ_PROPRIEDADE_COM
			Response.write "Comodato"
		End Select
%>
			<input type="hidden" name="propriedade" value="<%=propriedade%>">
<%Else %>
			<input type="Radio" name="propriedade" value="<%=EQ_PROPRIEDADE_TER%>" <%if propriedade = EQ_PROPRIEDADE_TER or propriedade = "" then response.write "checked"%>>Terceiros&nbsp;&nbsp;&nbsp;&nbsp;
			<input type="Radio" name="propriedade" value="<%=EQ_PROPRIEDADE_EBT%>" <%if propriedade = EQ_PROPRIEDADE_EBT then response.write "checked"%>>Embratel - Outros&nbsp;&nbsp;&nbsp;&nbsp;
			<input type="Radio" name="propriedade" value="<%=EQ_PROPRIEDADE_CRT%>" <%if propriedade = EQ_PROPRIEDADE_CRT then response.write "checked"%>>Embratel - CRT&nbsp;&nbsp;&nbsp;&nbsp;
			<input type="Radio" name="propriedade" value="<%=EQ_PROPRIEDADE_COM%>" <%if propriedade = EQ_PROPRIEDADE_COM then response.write "checked"%>>Embratel - Comodato
<%End If %>
		</td>
	</tr>

	<tr><td colspan="3"><hr width="700" size="1"></td></TR>

	<tr> 
		<td align="right" colspan="3">
		  	<input type="button" name="Submit" value="<%if eq_id = "" then response.write "Cadastrar" else response.write "Alterar"%>" class="texto1" onClick="javascript:CadastraItem();">&nbsp;&nbsp;
<%'-- se for um equipamneto ja cadastrado entao exibo o botao excluir
if eq_id <> "" then%>
		  	<input type="button" name="btnNovo" value="Novo Equipamento" class="texto1" onClick="javascript:NovoEquipamento();">&nbsp;&nbsp;
	  		<input type="button" name="btnExcluir" value="Excluir" class="texto1" onClick="javascript:ExcluirItem();">&nbsp;&nbsp;
		<script language="JavaScript">
		function ExcluirItem() {
<%If bln_AcessoRAT Then%>
			alert(MSG_SEM_ACESSO);
<%	else%>
			location.href = 'exc_item.asp?eq_id=<%=eq_id%>';
<%	end if%>
		}
		</script><%
end if%>
		</td>
	</tr>
</table>
</form>
<iframe name="escondido" style="display: none;"></iframe>

<script>
var MSG_SEM_ACESSO = "ATENÇÂO !!!\n\nUsuário sem privilégios para executar esta operação";

function NovoEquipamento() {
<%
If bln_AcessoRAT Then%>
	alert(MSG_SEM_ACESSO);<%
else
%>	location.href = 'cad_acess_item.asp';<%
end if%>
}

// valida e submete os dados do item para cadastro
function CadastraItem() {
<%
'If bln_AcessoRAT Then%>
//	alert(MSG_SEM_ACESSO);
<%
'else
%>
	var frm = document.all.formulario;

	if(frm.fab_id.value == '') {
		alert('Nenhum fabricante selecionado');
		frm.fab_id.focus();
	}
	else if(frm.mod_id.value == '') {
		alert('Nenhum modelo selecionado');
		frm.mod_id.focus();
	}
//	else if(frm.localizacao.value == '') {
//		alert('Localização do equipamento não foi informada');
//		frm.localizacao.focus();
//	}
	else if(frm.codbarras.value == '') {
		alert('Código de barras deve ser preenchido');
		frm.codbarras.focus();
	}
	else if(isNaN(frm.codbarras.value)) {
		alert('Código de barras inválido');
		frm.codbarras.focus();
		frm.codbarras.select();
	}
	else if(frm.codbarras.value.length < 16) {
		alert('Código de barras incompleto');
		frm.codbarras.focus();
		frm.codbarras.select();
	}
	else if(isNaN(frm.freq_calibracao.value)) {
		alert('Frequencia de calibração inválida');
		frm.freq_calibracao.focus();
		frm.freq_calibracao.select();
	}
	else if(!ValidaAcessorios()) {
		// valida o preenchimento dos acessorios, caso existam
	}
	else {
		var oOption, i, tb;

		// se contem controles de instrumental concatena a lista
		if(total_linhas > 0) {
			frm.lista_controles.length = 0;  // limpa o select

			// varre a tabela concatenando seus valores no VALUE do select
			tb = document.getElementById("tb_controle_body");
			for(i=1; i<=linha; i++) {
				if(document.getElementById("linha_" + i) != null) {
					oOption = document.createElement("OPTION");
					frm.lista_controles.options.add(oOption);
					oOption.innerText = document.getElementById("linha_" + i).eqc_id;  // ID do registro na tabela, caso exista
					oOption.innerText += separa_campo;
					oOption.innerText += document.getElementById("linha_" + i + "_col_1").innerText;
					oOption.innerText += separa_campo;
					oOption.innerText += document.getElementById("linha_" + i + "_col_2").innerText;
					oOption.innerText += separa_campo;
					oOption.innerText += document.getElementById("linha_" + i + "_col_3").innerText;
					oOption.innerText += separa_campo;
					oOption.innerText += document.getElementById("linha_" + i + "_col_4").innerText;
					oOption.innerText += separa_campo;
					oOption.innerText += document.getElementById("linha_" + i + "_col_5").innerText;

//alert(oOption.innerText);

					oOption.value = oOption.innerText;
					oOption.selected = true;
				}
			}
		}

//return false;

		// se contém ACESSORIOS, concatena a lista
		if(total_linhas_acess > 0) {
			frm.lista_acessorios.length = 0;  // limpa o select

			// varre a tabela concatenando seus valores no VALUE do select
			tb = document.getElementById("tb_acessorios_body");
			for(i=1; i<=linha_acess; i++) {
				if(document.getElementById("linha_acess_" + i) != null) {
					oOption = document.createElement("OPTION");
					frm.lista_acessorios.options.add(oOption);
					oOption.innerText = document.getElementById("linha_acess_" + i + "_col_1").innerText;
					oOption.innerText += separa_campo;
					oOption.innerText += document.getElementById("desc_acess_" + i).value;
					oOption.innerText += separa_campo;
					oOption.innerText += document.getElementById("status_acess_" + i).value;
					oOption.innerText += separa_campo;
					oOption.innerText += document.getElementById("conforme_acess_" + i).value;
					oOption.value = oOption.innerText;
					oOption.selected = true;
				}
			}
		}

		// envia os dados para gravacao
		frm.action="cad_acess_item2.asp"
		frm.target='';
		frm.submit();
	}<%
'end if%>
}

function checaNS(eu)
{
	var frm = document.all.formulario;
	frm.action = 'cad_acess_item_checaNS.asp?';
	frm.target = 'escondido';
	frm.submit();
}
function buscaModelos(eu)
{
	var frm = document.all.formulario;
	frm.action = 'cad_acess_item_buscaMod.asp?';
	frm.target = 'escondido';
	frm.submit();
}
function buscaPN(eu)
{
	var frm = document.all.formulario;
	frm.action = 'cad_acess_item_buscaPN.asp?';
	frm.target = 'escondido';
	frm.submit();
}

buscaPN(<%=mod_id%>);


<%
'=============================================================================================================
'Se for RAT tenho que colocar todos os controles como READ ONLY,deixando somente os controles de manutencao. Somente a
'opcao de Preventiva !
'=============================================================================================================
If bln_AcessoRAT Then
%>
	var meuForm = document.all;

		meuForm.instrumental.readOnly = true;
		meuForm.fab_id.readOnly = true;
		meuForm.mod_id.readOnly = true;
		meuForm.txtPN.readOnly = true;
		meuForm.numeroserie.readOnly = true;
		meuForm.btn_ChecaNS.disabled = true;
		meuForm.codbarras.readOnly = true;
		meuForm.localizacao.readOnly = true;
		meuForm.obs.readOnly = true;
		meuForm.manutencaopreventiva.readOnly = true;
		meuForm.deltaoperacao.readOnly = true;
		meuForm.umidadeoperacao.readOnly = true;
		meuForm.warmupoperacao.readOnly = true;
		meuForm.deltaarmazenagem.readOnly = true;
		meuForm.umidadearmazenagem.readOnly = true;

		meuForm.adicionar.disabled = true;

		meuForm.qtde_acessorios.disabled = true;
<%
End If
%>
</script>
<%
Else
    RW Tela.Mensagem.AcessoRestritoSCE()
End If

Call Tela.MostraRodape()
%>
