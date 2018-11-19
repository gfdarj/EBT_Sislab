<!------- SCE ------->
<!--#include file="includes/SCE_Lib.asp"-->
<!------- SISLAB ---->
<!--#include file="../includes/bib_str.asp"-->
<!------- LIB ------->
<!--#include file="../Classes/Classe_SCE.asp"-->
<!--#include file="../Classes/Classe_Combo.asp"-->
<%
Tela.SetNomeTela = "SCE > Cadastro > Reserva de Equipamentos" : Tela.SetCaminhoRelativo = "../"
Call Tela.MostraCabecalho()

If Env.UsuarioSCE() Then
    Dim Combo
    Set Combo = New TCombo

    Dim Sce
    Set Sce = New TSce

    Call Tela.ImprimeMenuSce()
%>
<script type="text/javascript" src="includes/bib_obj.js"></script>
<script type="text/javascript" src="includes/bib_str.js"></script>
<%
    '-- CADASTRO / ALTERAÇÃO DE RESERVAS DE EQUIPAMENTOS PARA UMA AS --
    Dim rec, s, ag_numero, ambiente, linha, ehNovo, amb
    Dim responsavel, dt_inicio, dt_termino, dt_reserva, reservado, dt_hoje, obs
    Dim ehAgValido : ehAgValido = true
    Dim chr_SQL

    ag_numero = trim(cstr(request("ag_numero")))
    ''ag_numero = 968

    ambiente = ""
    responsavel = ""
    dt_reserva = ""
    dt_inicio = ""
    dt_termino = ""
    dt_hoje = Zeros(Day(Date), 2) & "/" & Zeros(Month(Date), 2) & "/" & Year(Date)
    ehNovo = True

    if ag_numero <> "" then
	    s =	"SELECT UPPER(a.AG_RESPONSAVEL) as AG_RESPONSAVEL, r.AG_NUMERO, r.AMB_ID, r.RES_RESPONSAVEL, convert(varchar, r.RES_DATACADASTRO, 103) as RES_DATACADASTRO, r.RES_OBSERVACAO, " & _
		    "convert(varchar, AG_DATAINICIO, 103) as AG_DATAINICIO, " & _
		    "convert(varchar, AG_DATATERMINO, 103) as AG_DATATERMINO " & _
		    "FROM SCE_Reserva r RIGHT JOIN Agendamento a ON a.AG_NUMERO = r.AG_NUMERO where a.AG_NUMERO = " & ag_numero
	    Set rec = Env.oConn.execute(s)
	    if not (rec.eof and rec.bof) then
		    ambiente = rec("AMB_ID")
		    if IsNull(ambiente) then ambiente = ""
		    responsavel = rec("AG_RESPONSAVEL")
		    if IsNull(responsavel) then responsavel = ""
		    dt_reserva = rec("RES_DATACADASTRO")
		    if IsNull(dt_reserva) then dt_reserva = ""
		    obs = rec("RES_OBSERVACAO")
		    if IsNull(obs) then obs = ""
		    dt_inicio = rec("AG_DATAINICIO")
		    dt_termino = rec("AG_DATATERMINO")

		    If dt_inicio > Date() Then ehAgValido = True Else ehAgValido = False

		    If IsNull(rec("RES_DATACADASTRO")) Then ehNovo = True Else ehNovo = False

		    rec.close
	    end if

    end if
%>

<script type="text/javascript">
<%
If ag_numero <> "" Then
%>
	//---- cria os combos de ambiente ---
	function comboAmbiente(escreve, id_combo, padrao) {
		var str = '';
		str += '<select name="' + id_combo + '" >';
<%
	chr_SQL = _
				"select a.AMB_ID as VALOR, a.AMB_NOME as DESCRICAO " & _
				"from Ambientes a INNER JOIN Reserva_ambientes ra ON a.AMB_ID = ra.AMB_ID " & _
				"where RAM_AS = " & ag_numero & " " & _
				"UNION " & _
				"select a.AMB_ID as VALOR, a.AMB_NOME as DESCRICAO " & _
				"from Ambientes a INNER JOIN SCE_Reserva ra ON a.AMB_ID = ra.AMB_ID " & _
				"where ra.AG_NUMERO = " & ag_numero & " " & _
				"order by a.AMB_Nome"
		'End If
	Set RS = Env.oConn.Execute(chr_SQL)

	While Not RS.Eof %>
		str += '<option value="<%=RS("VALOR")%>"' + (padrao == '<%=RS("VALOR")%>'? ' selected ' : '') + '><%=RS("DESCRICAO")%></option>';
<%		RS.MoveNext
	WEnd
%>
		str += '</select>';
		if(escreve) document.write(str);
		return str;
	}
	//-----------
<%
End If
%>

function filtraItem() {
	var f = document.formulario;

	if( f.ag_numero.value == '' ) {
		alert('Nenhum agendamento foi selecionado.');
		f.ag_numero.focus();
	}
	else {
		var qryString = '?';
		qryString += 'ag_numero=<%=ag_numero%>&';
		qryString += 'modelo=' + f.modelo.value + '&';
		qryString += 'desc_modelo=' + f.desc_modelo.value + '&';
		qryString += 'fabricante=' + f.fabricante.value + '&';
		qryString += 'coditem=' + f.coditem.value + '&';
		qryString += 'instrumental=' + f.instrumental.value + '&';
		qryString += 'conforme=' + f.conforme.value + '&';
		qryString += 'notafiscal=' + f.notafiscal.value + '&';
		qryString += 'documento=' + f.documento.value + '&';
		qryString += 'fornecedor=' + f.fornecedor.value + '&';
		qryString += 'propriedade=' + f.propriedade.value + '&';
		qryString += 'status=' + f.status.value;
		window.open('cad_reserva_filtro.asp'+qryString, 'sce_cad_reserva', 'toolbar=no,location=no,directories=no,status=no,menubar=no,scrollbars=yes,resizable=yes,copyhistory=no,width=800,height=400,top=0,left=0');
	}
}
</script>

<div class="margem-10">
<iframe style="display: none;" name="escondido"></iframe>

<form method="post" name="formulario">
<input type="hidden" name="dt_hoje" value="<%=dt_hoje%>">
<input type="hidden" name="ehnovo" value="<%=ehNovo%>">
<select name="lista_itens" style="display: none; width:500px" multiple></select>

<table class="largura-total">
<%
if CStr(Request("cadastrou")) <> "" or CStr(Request("alterou")) <> "" or CStr(Request("excluiu")) <> "" then%>
<tr>
	<td colspan="2" align="center" valign="top">
<%
	if cstr(request("cadastrou")) = "1" then%>
		<b>Reserva Cadastrada com Sucesso !</b><%
	end if
	if cstr(request("alterou")) = "1" then%>
		<b>Reserva Atualizada com Sucesso !</b><%
	end if
	if cstr(request("excluiu")) = "1" then%>
		<b>Reserva Exclu&iacute;da com Sucesso !</b><%
	end if%>
	</td>
</tr><%
end if
%>
<tr>
	<td colspan="2" valign="top">
	    <strong>AS</strong><br />
		<%'call comboAgendamento("txtAS", "ag_numero", conn, cstr(ag_numero), "N")%>
		<%RW Combo.MeusAgendamentos(False, "txtAS", "ag_numero", CStr(ag_numero), "N")%>
		<script type="text/javascript">
			var f = document.formulario;
			f.ag_numero.onblur = BuscaDadosAS;
			f.ag_numero.onchange = BuscaDadosAS;
			f.txtAS.onblur = BuscaDadosAS;
			function BuscaDadosAS() {
				//f.action = "busca_dados_AS.asp?ag_numero=" + f.ag_numero.value;
				//f.target = "escondido";
				f.action = "cad_reserva.asp";
				f.target = "";
				f.submit();
			}
		</script>
	</td>
</tr>
<tr><td>&nbsp;</td></tr>
<tr>
	<td colspan="2">
		<table class="largura-total">
		<tr>
			<td valign="top">
				Ambiente(s):<br>
				<% amb = MontaAmbiente(ag_numero)%>
				<input type="hidden" name="total_ambiente" value="<%=amb%>">
			</td>
			<td valign="top">Respons&aacute;vel T&eacute;cnico<br>
				<%RW Combo.PadraoSql("ag_responsavel", "select upper(USERID) as VALOR, CAST(NOME as VARCHAR(40)) as DESCRICAO from USERCRT where USERID = '" & responsavel & "' order by Nome", responsavel, "")%>
			</td>
			<td valign="top" align="left">
				Inicio:<br><input type="text" name="ag_datainicio"  size="12" value="<%=dt_inicio%>" disabled>&nbsp;
			</td>
			<td valign="top" align="left">
				Fim:<BR><input type="text" name="ag_datatermino"  size="12" value="<%=dt_termino%>" disabled>
			</td>
		</tr>
		</table>
	</td>
</tr>
<tr><td colspan="2">&nbsp;</td></tr>

<!-- Filtros para consulta de itens -->
<tr>
	<td colspan="2">
		<p><strong>Filtros:</strong> <small>(Selecione os campos abaixo para filtrar os dados do equipamento)</small></p>
		
		<table class="largura-total">
			<tr>
				<td>Modelo:</td>
				<td><input type="text" name="modelo" size="50"></td>

				<td>Descri&ccedil;&atilde;o:</td>
				<td><input type="text" name="desc_modelo" size="50"></td>
			</tr>
			<tr>
				<td>Fabricante:&nbsp;</td><td><%RW Combo.PadraoSql("fabricante", "select f.fab_id as VALOR, f.fab_nome as DESCRICAO from sce_fabricantes f order by f.fab_nome", "", "N")%></td>
				<td>Cod.Barras:</td>
				<td>
					<input type="text" name="coditem" size="25">
					&nbsp;&nbsp;&nbsp;&nbsp;
					<input type="button" value="Filtrar &gt;&gt;"  onClick="javascript:filtraItem();">
				</td>
			</tr>
			<tr>
				<td>Nota Fiscal:</td>
				<td colspan="3">
					<input type="text" name="notafiscal" size="6" >
					<%RW Combo.SituacaoEquipamento("status", true, true, true, STATUS_EM_ESTOQUE)%>
					&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
					&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
					<%RW Combo.SimNaoInstrumental("instrumental", true)%>
				</td>
			</tr>
			<tr>
				<td>Documento:</td>
				<td colspan="3">
					<input type="text" name="documento" size="6" >
					&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
					<%RW Combo.EquipamentoConforme("conforme", true)%>
					&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
					<%RW Combo.PropriedadeEquipamento("propriedade", True)%>
				</td>
			</tr>
			<tr>
				<td>Fornecedor:</td>
				<td colspan="3">
				<%RW Combo.Fornecedor("fornecedor", "", "N", "FORNECEDOR", false)%>
				&nbsp;
				</td>
			</tr>
		</table>
	</td>
</tr>
<!-- Fim - Filtros para consulta de itens -->

<tr><td colspan="2">&nbsp;</td></tr>
<script type="text/javascript">
    var linha = 0;
    var total_linhas = 0;

    function InsereItem(qtde) {
	    var i, datacontrole, dataag, datahoje, undef;
	    var newrow;	var newtd;	var newtxt;

	    if( document.all.ag_numero.value == '' ) {
		    alert('Nenhum agendamento foi selecionado.');
		    f.ag_numero.focus();
		    return false
	    }
	    if(qtde > 30) {
		    alert("Só é permitido incluir até 30 itens de uma única vez");
		    return false;
	    }

	    for(i=0; i< qtde; i++) {
		    linha++;
		    total_linhas++;

		    //-- apendo uma nova linha e suas colunas
		    newrow=document.createElement("tr");

		    newtd=document.createElement("td");
		    newtxt=document.createTextNode("item"+linha);
		    newtd.appendChild(newtxt);
		    newtd.setAttribute("id","linha_"+linha+"_col_1");
		    newtd.setAttribute("eq_id","");
		    newrow.appendChild(newtd);

    //		newtd.innerHTML = inputText(false, 'item_'+linha, '', 21, 16, 'onKeyUp="proxCampo(this, dt_ini_' + linha + ');" onBlur="javascript:validaCodBarras(document.all.item_' + linha + ', ' + linha + ');"') + "<br><span id='" + "linha_"+linha+"_col_2' style='font-size: 8px; color: gray;'><i>-- descrição do item --</i></span>";
		    newtd.innerHTML = inputText(false, 'item_'+linha, '', 21, 16, 'onKeyUp="proxCampo(this, dt_ini_' + linha + ');" onBlur="javascript:validaCodBarras(document.all.item_' + linha + ', ' + linha + ');"');
		    newtd.vAlign = "top";

		    newtd=document.createElement("td");
		    newtxt=document.createTextNode("-- descrição do item --");
		    newtd.appendChild(newtxt);
		    newtd.setAttribute("id", "linha_" + linha + "_col_2");
		    newtd.setAttribute("class", "texto1");
		    newrow.appendChild(newtd);

		    newtd=document.createElement("td");
		    newtd.vAlign = "top";
		    newtxt=document.createTextNode("data ini");
		    newtd.appendChild(newtxt);
		    newtd.setAttribute("id","linha_"+linha+"_col_3");
		    newtd.setAttribute("class", "texto1");
		    newrow.appendChild(newtd);

		    //
		    dataag = document.all.ag_datainicio.value;
		    datahoje = document.all.dt_hoje.value;

		    if( concatenaData(dataag) >= concatenaData(datahoje) )
			    datacontrole = document.all.ag_datainicio.value;
		    else
			    datacontrole = document.all.dt_hoje.value;
		    //

		    newtd.innerHTML = inputText(false, 'dt_ini_'+linha, datacontrole, 13, 10, 'onKeyPress="formataData(this);" onKeyUp="proxCampo(this, dt_fim_' + linha + ');"');

		    newtd=document.createElement("td");
		    newtd.vAlign = "top";
		    newtxt=document.createTextNode("data fim");
		    newtd.appendChild(newtxt);
		    newtd.setAttribute("id","linha_"+linha+"_col_4");
		    newtd.setAttribute("class", "texto1");
		    newrow.appendChild(newtd);

		    newtd.innerHTML = inputText(false, 'dt_fim_'+linha, document.all.ag_datatermino.value, 13, 10, 'onKeyPress="formataData(this);" onKeyUp="proxCampo(this, cmb_setup_' + linha + ');"');

		    newtd=document.createElement("td");
		    newtd.vAlign = "top";
		    newtxt=document.createTextNode("Eq. Setup");
		    newtd.appendChild(newtxt);
		    newtd.setAttribute("id","linha_"+linha+"_col_5");
		    newtd.setAttribute("align","center");
		    newtd.setAttribute("class", "texto1");
		    newrow.appendChild(newtd);

		    newtd.innerHTML = comboAmostraEq(false, 'cmb_setup_'+linha, 'E');

		    newtd=document.createElement("td");
		    newtd.vAlign = "top";
		    newtxt=document.createTextNode("Ambiente");
		    newtd.appendChild(newtxt);
		    newtd.setAttribute("id","linha_"+linha+"_col_6");
		    newtd.setAttribute("align","center");
		    newtd.setAttribute("class", "texto1");
		    newrow.appendChild(newtd);

		    newtd.innerHTML = comboAmbiente(false, 'cmb_amb_'+linha, '');

		    newtd=document.createElement("td");
		    newtd.vAlign = "top";
		    newtxt=document.createTextNode(" ");
		    newtd.appendChild(newtxt);
		    newtd.setAttribute("id","linha_"+linha+"_col_7");
		    newtd.setAttribute("align","center");
		    newtd.setAttribute("class", "texto1");
		    newrow.appendChild(newtd);

		    //linha 8
		    newtd=document.createElement("td");
		    newtd.vAlign = "top";
		    newtxt=document.createTextNode('x');
		    newtd.appendChild(newtxt);
		    newtd.setAttribute("id","linha_"+linha+"_col_8");
		    newtd.setAttribute("align","center");
		    newtd.setAttribute("class", "texto1");
		    newrow.appendChild(newtd);

		    newrow.setAttribute("id","linha_" + linha);

		    //linha 9
		    newtd=document.createElement("td");
		    newtd.vAlign = "top";
		    newtxt=document.createTextNode('x');
		    newtd.appendChild(newtxt);
		    newtd.setAttribute("id","linha_"+linha+"_col_9");
		    newtd.setAttribute("align","center");
		    newtd.setAttribute("class", "texto1");
		    newrow.appendChild(newtd);

		    newrow.setAttribute("id","linha_" + linha);

		    // troca o conteúdo da ultima coluna colocando
		    newtd.innerHTML = '<span onclick="javascript:RemoveItem('+linha+');" style="cursor: hand;"><img src="img/btn_excluir.gif"></span>';
		    newtd.vAlign = "top";

		    document.getElementById("tb_reserva_body").appendChild(newrow);

		    document.all["item_"+linha].eq_id = "";
		    document.all["item_"+linha].focus();
	    }
	    return linha;
    }
    function RemoveItem(l) {
	    document.getElementById("linha_"+l).removeNode(true);
	    total_linhas--;
    }
    function validaCodBarras(codbarras, linhaTabela) {  // valida um codigo de barras digitado na tabela de itens
	    //if(codbarras.value.length == codbarras.maxLength) {
    //	 (codbarras.value.length > 0) && 
    //	if( (document.all["item_" + linhaTabela].eq_id == "") ) {
		    document.formulario.action = "busca_item_valido.asp?ag_numero=<%=ag_numero%>&cod_barras=" + codbarras.value + "&linhaTabela=" + linhaTabela;
		    document.formulario.target = "escondido";
		    document.formulario.submit();
    //	}
    //	else {
		    //if( (codbarras.value.length != 0) && (document.all["item_" + linhaTabela].eq_id != "") ) {
    //		if( document.all["item_" + linhaTabela].eq_id != "" ) {
    //			document.all["linha_" + linhaTabela + "_col_2"].innerText = "-- descrição do item --";
    //			document.all["item_" + linhaTabela].eq_id = "";
    //		}
    //	}
    }
</script>
</table>

<table class="largura-total">
<tr>
	<td colspan="2">
		<p><strong>Itens Reservados:</strong></p>
		&nbsp;&nbsp;&nbsp;&nbsp;
		(qtde:&nbsp;<input type="text" name="qtd_item" value="1" size="3" >&nbsp;
		<a href="#" onClick="javascript:InsereItem(document.all.qtd_item.value);">novo item</a>)
		<table class="largura-total table-condensed table-bordered table-striped table-hover"  border="1" id="tb_reserva">
		<tr>
			<th align="left" width="150px">Item</th>
			<th width="*" align="left">Descrição</th>
			<th width="85px">Data ini</th>
			<th width="85px">Data fim</th>
			<th width="110px">Eq. Setup</th>
			<th width="110px">Ambiente</th>
			<th width="55px" align="center">Aceito</th>
			<th width="20px" align="center" title="Item está movimentado para esta AS">&nbsp;Uso&nbsp;</th>
			<th width="20px"><img src="img/btn_branco.gif"></th>
		</tr>
		<tbody id="tb_reserva_body">
<%
'-- MONTO A LISTA DE ITENS RESERVADOS --
if ag_numero <> "" then

	s =	"select r.EQ_ID, convert(varchar, r.REQ_DATAINICIO, 103) as REQ_DATAINICIO, r.REQ_EQSETUP, " & _
		"convert(varchar, r.REQ_DATATERMINO, 103) as REQ_DATATERMINO, r.REQ_ACEITO, r.REQ_MOVIMENTOU, " & _
		"e.EQ_CODIGOBARRAS, (m.MOD_CODNOME + ' <==> ' + m.MOD_DESCRICAO) as DESCRICAO, r.AMB_ID, mov.ASA " & _
		"from SCE_Reserva_Equipamentos r inner join SCE_Equipamentos e " & _
		"on r.eq_id = e.eq_id inner join SCE_Modelos m " & _
		"on m.mod_id = e.mod_id left join vw_SCE_Movimentacao_Atual mov on e.EQ_ID = mov.EQ_ID " & _
		"where AG_NUMERO = " & ag_numero & _
		"order by REQ_DATAINICIO, REQ_DATATERMINO, EQ_CODIGOBARRAS"
	set rec = Env.oConn.execute(s)

	if not (rec.eof and rec.bof) then
		linha = 1
		Dim EmUso
		while not rec.eof

			EmUso = "Não"
			If Not IsNull(rec("ASA")) Then 
				If CStr(rec("ASA")) = Request("ag_numero") Then
					EmUso = "Sim"
				End If
			End If

			'-- VERIFICO SE O ITEM ESTA RESERVADO --
			reservado = Sce.VerificaReservaItem(True, ag_numero, rec("EQ_ID"), false)

%>		<tr id="linha_<%=linha%>">
			<td id="linha_<%=linha%>_col_1" valign="top" >
				<script type="text/javascript">inputText(true, 'item_<%=linha%>', '<%=rec("EQ_CODIGOBARRAS")%>', 21, 16, 'onKeyUp="proxCampo(this, document.formulario.dt_ini_<%=linha%>);" onBlur="javascript:validaCodBarras(this, <%=linha%>);"');</script>
				<!--<span id='linha_<%=linha%>_col_2' style='font-size: 8px; color: gray;'><i><%'=rec("DESCRICAO")%></i></span>-->
			</td>
			<td id="linha_<%=linha%>_col_2" ><%=rec("DESCRICAO")%></td>
			<td id="linha_<%=linha%>_col_3"  valign="top"><script type="text/javascript">inputText(true, 'dt_ini_<%=linha%>', '<%=rec("REQ_DATAINICIO")%>', 13, 10, 'onKeyPress="formataData(this);" onKeyUp="proxCampo(this, document.all.dt_fim_<%=linha%>);"');</script></td>
			<td id="linha_<%=linha%>_col_4"  valign="top"><script type="text/javascript">inputText(true, 'dt_fim_<%=linha%>', '<%=rec("REQ_DATATERMINO")%>', 13, 10, 'onKeyPress="formataData(this);" onKeyUp="proxCampo(this, document.all.cmb_setup_<%=linha%>);"');</script></td>
			<td id="linha_<%=linha%>_col_5"  align="center" valign="top"><script type="text/javascript">comboAmostraEq(true, 'cmb_setup_<%=linha%>', '<%=rec("REQ_EQSETUP")%>');</script></td>
			<td id="linha_<%=linha%>_col_6"  align="center" valign="top"><script type="text/javascript">comboAmbiente(true, 'cmb_amb_<%=linha%>', '<%=rec("AMB_ID")%>');</script></td>
			<td id="linha_<%=linha%>_col_7"  align="center" valign="top"><%if isNull(rec("REQ_ACEITO")) then response.write "&nbsp;" else response.write SimNao(rec("REQ_ACEITO"))%></td>
			<td id="linha_<%=linha%>_col_8"  valign="top" align="center" title="Item está movimentado para esta AS"><%=EmUso%></td>
			<td id="linha_<%=linha%>_col_9"  valign="top">
<%			if (rec("REQ_ACEITO")) and (Env.PerfilSCE = PERFIL_RAT) or rec("REQ_MOVIMENTOU") or (not ehAgValido)then%>
				<img src="img/btn_branco.gif">

				<script type="text/javascript">
				    document.all.item_<%=linha%>.disabled = true;
				    document.all.dt_ini_<%=linha%>.disabled = true;
				    document.all.dt_fim_<%=linha%>.disabled = true;
				    document.all.cmb_setup_<%=linha%>.disabled = true;
				    document.all.cmb_amb_<%=linha%>.disabled = true;
				</script>

<%			else %>
				<span onClick="javascript:RemoveItem(<%=linha%>);" style="cursor: hand;"><img src="img/btn_excluir.gif"></span>
<%			end if%>
			</td>
			<script type="text/javascript">
				document.all["item_<%=linha%>"].eq_id = "<%=rec("EQ_ID")%>";
			</script>
		</tr>
<%			Call Sce.MarcaItemReservado((reservado <> "") , linha)
			rec.MoveNext
			linha = linha + 1
		wend%>
		<script type="text/javascript">linha = <%=linha%>; total_linhas = <%=linha%>;</script>
<%	end if
end if
%>
		</tbody>
		</table>
	</td>
</tr>
<tr><td colspan="2">&nbsp;</td></tr>
<tr>
	<td colspan="2">
	    Observações:<br />
		<textarea name="obs"  rows="10" cols="110"><%=obs%></textarea>
	</td>
</tr>
<tr><td colspan="2">&nbsp;</td></tr>
</table>

<p>
	<input type="button" name="Submit" value="<%if ehNovo then response.write "Cadastrar Reserva" else response.write "Alterar Reserva"%>"  onClick="javascript:cadastraReserva();">&nbsp;&nbsp;
<%'-- se for um equipamneto ja cadastrado entao exibo o botao excluir
if not ehNovo then%>
	<input type="button" name="btnNovo" value="Nova Reserva"  onClick="javascript:location.href='cad_reserva.asp';">&nbsp;&nbsp;
	<input type="button" name="btnExcluir" value="Excluir Reserva"  onClick="javascript:excluirReserva();">&nbsp;&nbsp;
		<script type="text/javascript">
		function excluirReserva() {
			location.href = 'exc_reserva.asp?ag_numero=<%=ag_numero%>';
		}
		</script><%
end if%>
</p>

</form>
<br />
</div>

<script type="text/javascript">
function validaListaItens() {
	var i, j, k;
	/* varre a tabela de itens */
	for(i=1; i<=linha; i++) {
		if(document.all["linha_"+i] != null) {
			/* so valido linhas que nao foram aceitas ou movimentadas */
			if(document.all["dt_ini_"+i].disabled == false)
			{
				if((document.all["item_"+i].eq_id == "")) {
					alert("Item não preenchido ou incorreto");
					document.all["item_"+i].focus();
					return false;
				}
				else if(document.all["dt_ini_"+i].value == "") {
					alert("Data de inicio não preenchida");
					document.all["dt_ini_"+i].focus();
					return false;
				}
				else if( (concatenaData(document.all["dt_ini_"+i].value) < concatenaData(document.all.ag_datainicio.value) ) || (concatenaData(document.all["dt_ini_"+i].value) > concatenaData(document.all.ag_datatermino.value)) ) {
					alert("Data de inicio não está de acordo com o período do agendamento");
					document.all["dt_ini_"+i].focus();
					return false;
				}
				else if( (concatenaData(document.all["dt_fim_"+i].value) < concatenaData(document.all["dt_ini_"+i].value) ) || (concatenaData(document.all["dt_fim_"+i].value) < concatenaData(document.all.ag_datainicio.value) ) || (concatenaData(document.all["dt_fim_"+i].value) > concatenaData(document.all.ag_datatermino.value)) ) {
					alert("Data de término não está de acordo com o período do agendamento");
					document.all["dt_fim_"+i].focus();
					return false;
				}
				else if(document.all["dt_fim_"+i].value == "") {
					alert("Data de término não preenchida");
					document.all["dt_fim_"+i].focus();
					return false;
				}
				else if(!isDate(document.all["dt_ini_"+i].value)) {
					alert("Data de inicio inválida");
					document.all["dt_ini_"+i].focus();
					document.all["dt_ini_"+i].select();
					return false;
				}
				else if(!isDate(document.all["dt_fim_"+i].value)) {
					alert("Data de término inválida");
					document.all["dt_fim_"+i].focus();
					document.all["dt_fim_"+i].select();
					return false;
				}
				/* varre a lista a procura de itens repetidos */
				for(j=i+1; j<=linha; j++) {
					if(document.all["item_"+j] != null) {
						if(document.all["item_"+i].eq_id == document.all["item_"+j].eq_id) {
							alert("Item já existe na lista");
							document.all["item_"+j].focus();
							document.all["item_"+j].select();
							return false;
						}
					}
				} // for
			}
		}
	}
	return true;
}

function validaReserva(frm) {
	var ret = false;
	if(frm.ag_numero.value == '') {
		alert('Nenhum agendamento selecionado.');
		frm.ag_numero.focus();
	}
	else if(frm.total_ambiente.value == '0') {
		alert('Nenhum ambiente cadsatrado !\n\nSolicite ao RAT o cadastro dos ambientes desta AS.');
		frm.ag_numero.focus();
	}
	else if(frm.ag_responsavel.value == '') {
		alert('Nenhum responsável selecionado.');
		frm.ag_responsavel.focus();
	}
//	else if(frm.amb_id.value == '') {
//		alert('Nenhum ambiente selecionado.');
//		frm.amb_id.focus();
//	}
	else if(total_linhas < 1) {
		alert('Nenhum item foi cadastrado na lista.');
	}
	else if(!validaListaItens()) {
		// valido os itens e as mensgens sao executadas pela funcao
	}
	else { ret = true; }
	return ret;
}

function cadastraReserva() {
<%
if (not ehAgValido) and (Env.PerfilSCE = PERFIL_RAT) then
%>
	alert("ATENÇÂO !\n\nEste agendamento não pode mais ser alterado por um RT em razão\nda proximidade do seu início.");
<%
else
%>
	var frm = document.forms[0];
	var oOption, i, tb;
	//var separa_campo = "¿?¿";		//mudei o separador para ","
	var separa_campo = ",";

	if(validaReserva(frm)) {

		// pega os itens e concatena a lista
		if(total_linhas > 0) {
			frm.lista_itens.length = 0;  // limpa o select

			// varre a tabela concatenando seus valores no VALUE do select
			tb = document.getElementById("tb_reserva_body");
			for(i=1; i<=linha; i++) {
				if(document.getElementById("linha_" + i) != null) {
					oOption = document.createElement("OPTION");
					frm.lista_itens.options.add(oOption);
					oOption.innerText = document.all["item_"+i].eq_id;  // ID do registro na tabela, caso exista
					oOption.innerText += separa_campo;
					//oOption.innerText += document.getElementById("item_" + i).value;  // cod barras
					//oOption.innerText += separa_campo;
					oOption.innerText += document.getElementById("dt_ini_" + i).value;
					oOption.innerText += separa_campo;
					oOption.innerText += document.getElementById("dt_fim_" + i).value;
					oOption.innerText += separa_campo;
					oOption.innerText += document.getElementById("cmb_setup_" + i).value;
					oOption.innerText += separa_campo;
					oOption.innerText += document.getElementById("cmb_amb_" + i).value;
					oOption.innerText += separa_campo;
					oOption.innerText += aceitoSimNao(document.getElementById("linha_" + i + "_col_7").innerText);
					oOption.value = oOption.innerText;
					oOption.selected = true;
				}
			}
		}
		frm.target = "";
		frm.action = "cad_reserva2.asp";
		frm.submit();
	} // valida reserva
<%
end if
%>
}

function aceitoSimNao(valor) {
	if( (valor == "Sim") || (valor == "SIM"))
		return 1;
	else if((valor == "Não") || (valor == "N&atilde;o"))
		return 0;
	else 
		return 9; // no banco de dados este valor sera transformado em NULL
}

f.ag_datainicio.value = "<%=dt_inicio%>";
f.ag_datatermino.value = "<%=dt_termino%>";
f.ag_responsavel.value = "<%=responsavel%>";
f.conforme.value = "1";
</script>
<%
    Set Sce = Nothing
    Set Combo = Nothing
    Set Env = Nothing
Else
    RW Tela.Mensagem.AcessoRestritoSCE()
End If

Call Tela.MostraRodape()


'##############################################################################
Function MontaAmbiente(ag_numero)
'##############################################################################
	Dim chr_SQL
	Dim RS

	If ag_numero = "" Then Exit Function

	'chr_SQL = "select AMB_ID as VALOR, AMB_NOME as DESCRICAO from Ambientes order by AMB_Nome"
	'If ag_numero <> "" Then
		'If Trim(cstr(ambiente)) <> "" Then
			chr_SQL = _
				"select a.AMB_ID as VALOR, a.AMB_NOME as DESCRICAO " & _
				"from Ambientes a INNER JOIN Reserva_ambientes ra ON a.AMB_ID = ra.AMB_ID " & _
				"where RAM_AS = " & ag_numero & " " & _
				"UNION " & _
				"select a.AMB_ID as VALOR, a.AMB_NOME as DESCRICAO " & _
				"from Ambientes a INNER JOIN SCE_Reserva ra ON a.AMB_ID = ra.AMB_ID " & _
				"where ra.AG_NUMERO = " & ag_numero & " " & _
				"order by a.AMB_Nome"
		'End If
	'	call comboBDSQL("amb_id", conn, chr_SQL, cstr(ambiente), "N")
	'Else
	'	call comboBDSQL("amb_id", conn, chr_SQL, cstr(ambiente), "N")
	'End If

	MontaAmbiente = 0

	Set RS = Env.oconn.Execute(chr_SQL)
	If Not RS.Eof Then
		MontaAmbiente = 1
		While Not RS.Eof
			Response.Write "&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;" & RS("Descricao")
			RS.MoveNext
			If Not RS.Eof Then Response.Write "<BR>"
		WEnd
	End If

	Response.Write "<BR>"

End Function
%>
