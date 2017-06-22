<!--#inc lude file="../../includes/conexao.inc" -->
<!--#include file="../../includes/Sislab_Lib.asp" -->
<!--#include file="../../includes/controlesHTML.asp" -->
<%
'-----------------------------------------------------------------------------
'-- Funcoes de banco de dados - SCE --
'-----------------------------------------------------------------------------

'-- monta combo de fornecedores
Sub comboFornecedor(nome, objConn, padrao, todos, tipo, completa)
	dim ssql

	ssql = "select enf_id as VALOR, (case when enf_nome is null then '' else LEFT(enf_nome, 50) end) + "

	if completa then
		ssql = ssql & "(case when enf_cidade is null or enf_cidade = '' then '' else ' / ' + enf_cidade end) + "
	end if

	ssql = ssql & _
			"(case when enf_cnpj is null or enf_cnpj = '' then '' else '&nbsp;&nbsp;(' + " & _
			"left(enf_cnpj, 2) + '.' + substring(enf_cnpj, 3, 3) + '.' + substring(enf_cnpj, 6, 3) + '/' + substring(enf_cnpj, 9, 4) + '-' + right(enf_cnpj, 2) + ')' end) "

	if completa then
		ssql = ssql & " + ' [' + ENF_TIPOEMPRESA + ']' "
	end if

	ssql = ssql & _
			"as DESCRICAO " & _
			"from sce_empresa_nota_fiscal "

	if ucase(tipo) = "FORNECEDOR" then
		ssql = ssql & "where enf_tipoempresa = 'F'"
	elseif ucase(tipo) = "TRANSPORTADORA" then
		ssql = ssql & "where enf_tipoempresa = 'T'"
	end if

	ssql = ssql & "order by enf_nome, enf_cidade"

	call comboBDSQL( nome, objConn, sSQL, padrao, todos )
End Sub


'-- monta uma combo de fornecedores mais avançada
Sub comboFornecedorFiltroCnpjDescricao(nome, objConn, padrao, todos, tipo, completa, cnpj, descricao)
	dim ssql

	ssql = "select enf_id as VALOR, (case when enf_nome is null then '' else LEFT(enf_nome, 50) end) + "

	if completa then
		ssql = ssql & "(case when enf_cidade is null or enf_cidade = '' then '' else ' / ' + enf_cidade end) + "
	end if

	ssql = ssql & _
			"(case when enf_cnpj is null or enf_cnpj = '' then '' else '&nbsp;&nbsp;(' + " & _
			"left(enf_cnpj, 2) + '.' + substring(enf_cnpj, 3, 3) + '.' + substring(enf_cnpj, 6, 3) + '/' + substring(enf_cnpj, 9, 4) + '-' + right(enf_cnpj, 2) + ')' end) "

	if completa then
		ssql = ssql & " + ' [' + ENF_TIPOEMPRESA + ']' "
	end if

	ssql = ssql & _
			"as DESCRICAO " & _
			"from sce_empresa_nota_fiscal " & _
			"where 1 = 1 "

	If cnpj <> "" Then ssql = ssql & "AND enf_cnpj LIKE '%" & cnpj & "%' "
	If descricao <> "" Then ssql = ssql & "AND enf_nome LIKE '%" & ucase(descricao) & "%' "

	if ucase(tipo) = "FORNECEDOR" then
		ssql = ssql & "AND enf_tipoempresa = 'F' "
	elseif ucase(tipo) = "TRANSPORTADORA" then
		ssql = ssql & "AND enf_tipoempresa = 'T' "
	end if

	ssql = ssql & "order by enf_nome, enf_cidade"

'response.write ssql
'response.end

	call comboBDSQL( nome, objConn, sSQL, padrao, todos )
End Sub


Sub comboMeusAgendamentos(meuAgendamento, nomeText, nomeCombo, objConn, padrao, todos)
	Dim where
	if meuAgendamento then
		where = "UPPER(AG_RESPONSAVEL) = '" & Replace(Ucase(Request.ServerVariables("REMOTE_USER")), "EMBRATEL\", "") & "' "
	else
		where = "UPPER(AG_RESPONSAVEL) <> '" & Replace(Ucase(Request.ServerVariables("REMOTE_USER")), "EMBRATEL\", "") & "' "
	end if
	call comboAgendamentoJS(nomeText, nomeCombo)
	call comboBDSQL( nomeCombo, objConn, _
		"select AG_NUMERO as VALOR, Cast(AG_NUMERO as VARCHAR(10)) + " & _
		"CASE WHEN AG_OBJETIVO IS NULL THEN '' ELSE ' - ' + SUBSTRING(AG_OBJETIVO, 1, 50) END as DESCRICAO " & _
		"from Agendamento where " & where & " order by AG_NUMERO desc", padrao, todos)
End Sub

'-- monta combo de Nota Fiscal
Sub comboNotaFiscal(nomeText, nomeCombo, objConn, padrao, todos, tipoNF, filtroFornecedor)
	Dim sSQL, where
%>	<script language="JavaScript">
	function comboNotaFiscalBuscaNF() {
		var frm = document.forms[0];
		var combo = frm.<%=nomeCombo%>;
		indice = -1;
		for(i=0; i<combo.length; i++)
			if (combo[i].text.substr(0, frm.<%=nomeText%>.value.length) == frm.<%=nomeText%>.value)
				indice = i;

		if (indice != -1)
	  		combo.options[indice].selected = true
		else
			combo.options[0].selected = true
	}
	</script>
	<input class="form" type="Text" name="<%=nomeText%>" size="4" onKeyUp="comboNotaFiscalBuscaNF();">&nbsp;
<%	if tipoNF = NF_ENTRADA then
		where = "where NF_TIPO = " & NF_ENTRADA
	elseif tipoNF = NF_SAIDA then
		where = "where NF_TIPO = " & NF_SAIDA
	else
		where = ""
	end if

	if filtroFornecedor <> "" then
		if where = "" then
			where = "where "
		else
			where = where & " and "
		end if
		where = where & "e.ENF_ID = " & filtroFornecedor & " "
	end if

	sSQL =	"select nf_id as VALOR, CAST(nf.nf_numeronota as VARCHAR) + " & _
			"' - ' + e.enf_nome as DESCRICAO from sce_nota_fiscal nf inner join " & _
			"sce_empresa_nota_fiscal e on e.enf_id = nf.enf_id " & where & " " & _
			"order by nf.nf_numeronota"

'response.write ssql & "<BR>"
'response.write (filtroFornecedor = "")

	call comboBDSQL( nomeCombo, objConn, sSQL, padrao, todos)
End Sub

Function Bool2Str(valor)
	if valor then Bool2Str = "Sim" else Bool2Str = "N&atilde;o"
End Function

'-- UTILIZADA PELAS TELAS DE CADASTRO DE RESERVA DE ITENS --
Function MarcaItemReservado(reservado, linhaTabela)
	Dim color
	if reservado then color = "#FF0000" else color = "#000000"
%>	<script language="JavaScript">
	f.document.all["linha_<%=linhaTabela%>"].style.color = '<%=color%>';
	f.document.all["item_<%=linhaTabela%>"].style.color = '<%=color%>';
	f.document.all["dt_ini_<%=linhaTabela%>"].style.color = '<%=color%>';
	f.document.all["dt_fim_<%=linhaTabela%>"].style.color = '<%=color%>';
	f.document.all["cmb_setup_<%=linhaTabela%>"].style.color = '<%=color%>';
	</script>
<%
End Function

Sub ComboConforme(nome, mesmalinha)
%>
	Conforme<%if mesmalinha then response.write ":&nbsp;" else response.write "<br>"%>
	<select name="<%=nome%>" class="combo">
		<option value="">Todos</option>
		<option value="1">Sim</option>
		<option value="0">N&atilde;o</option>
	</select>
<%
End Sub

Sub ComboPropriedadeEq(nome, mesmalinha)
%>
	Propriedade<%if mesmalinha then response.write ":&nbsp;" else response.write "<br>"%>
	<select name="<%=nome%>" class="combo">
		<option value="">Todos</option>
		<option value="<%=EQ_PROPRIEDADE_TER%>">Terceiros</option>
		<option value="<%=EQ_PROPRIEDADE_COM%>">Embratel - Comodato</option>
		<option value="<%=EQ_PROPRIEDADE_CRT%>">Embratel - CRT</option>
		<option value="<%=EQ_PROPRIEDADE_EBT%>">Embratel - Outros</option>
		<option value="<%=EQ_PROPRIEDADE_COM & "','" & EQ_PROPRIEDADE_EBT & "','" & EQ_PROPRIEDADE_CRT%>">Embratel - Todos</option>
	</select>
<%
End Sub

Sub ComboSituacaoEq(nome, mesmalinha, todos, mostraCadastrado, padrao)
	'-- OBS: Precisa das constantes em GLOBAL.ASP
%>
	Situa&ccedil;&atilde;o<%if mesmalinha then response.write ":&nbsp;" else response.write "<br>"%>
	<select name="status" class="combo">
		<option value=""><%if todos then response.write "Todos" else response.write "--"%></option>
<%	if mostraCadastrado then%>
		<option value="<%=STATUS_CADASTRADO%>" <%if padrao = STATUS_CADASTRADO then response.write "selected"%>>Cadastrado</option>
<%	end if%>
		<option value="<%=STATUS_EM_ESTOQUE%>" <%if padrao = STATUS_EM_ESTOQUE then response.write "selected"%>>Em estoque</option>
		<option value="<%=STATUS_EM_USO%>" <%if padrao = STATUS_EM_USO then response.write "selected"%>>Em uso</option>
		<option value="<%=STATUS_EXPEDIDO%>" <%if padrao = STATUS_EXPEDIDO then response.write "selected"%>>Expedido</option>
		<option value="<%=STATUS_EXPEDIDO_SUBST%>" <%if padrao = STATUS_EXPEDIDO_SUBST then response.write "selected"%>>Substituído</option>
	</select>
<%
End Sub

Sub ComboInstrumental(nome, mesmalinha)
%>
		Instrumental<%if mesmalinha then response.write ":&nbsp;" else response.write "<br>"%>
		<select name="instrumental" class="combo">
			<option value="">Todos</option>
			<option value="1">Sim</option>
			<option value="0">N&atilde;o</option>
		</select>
<%
End Sub

Sub ComboAmostraEq(nome, mesmalinha)
%>
		Eq. Setup<%if mesmalinha then response.write ":&nbsp;" else response.write "<br>"%>
		<select name="setup" class="combo">
			<option value="">Todos</option>
			<option value="<%=EQSETUP_AMOSTRA%>">Amostra</option>
			<option value="<%=EQSETUP_EQUIPAMENTO%>">Equipamento</option>
		</select>
<%
End Sub

%>
