<!--#include file="../includes/global.asp" -->   <!-- constantes usada pelo menu -->
<!--#include file="includes/padraoHTML.asp"-->
<!--#include file="includes/abre.asp"-->
<!--#include file="includes/bib_str.asp"-->
<!--#include file="includes/bib_bd.asp"-->
<%
'-- RELATORIO CONSOLIDADO DE MOVIMENTACOES
Dim RS
Dim ano
Dim mes
Dim conta
Dim dtt_Criacao

call ImprimeCabecalho ("", MENU_ON, true, "Relatório Consolidado de Movimentação", "", "history.go(-1);")
%>
<table width="100%" class="texto" border="0">
<tr><td class="titulo" colspan="3">Posi&ccedil;&atilde;o consolidada de Movimentações<%If Request("ano") <> "" Then Response.Write " (<i>" & Request("ano") & "</i>)"%></td></tr>
<tr><td>&nbsp;</td></tr>

<%
If request("ano") = "" Then
%>
<tr>
	<td>
		<form name="formulario" method="post">
		Selecione o ano desejado:&nbsp;
		<input type="Text" class="form" size="5" maxlength="4" name="ano" value="<%=Year(Date)%>">&nbsp;
		<input type="Submit" class="form" value="Pesquisar">
		</form>
		<script language="JavaScript">
			document.forms[0].ano.focus();
		</script>
	</td>
</tr>
<tr>
	<td>&nbsp;&nbsp;<b>(*)</b> <i>Este procedimento poderá levar algum tempo caso haja necessidade de reconstrução a tabela de consultas</i></td>
</tr>
<%
Else
%>
<tr>
	<td>
		<table width="100%" cellpadding="2" cellspacing="0" class="texto" border="1">
<%
	ano = Request("ano")
	'Set RS = Conn.Execute("EXEC sp_SCE_REL_GERENCIAL_NF " & ano)
	'Set RS = Conn.Execute("SELECT *, CONVERT(VARCHAR, DATACRIACAO, 103) + ' ' + LEFT(CONVERT(VARCHAR, DATACRIACAO, 114), 5) AS DATAATUALIZACAO FROM SCE_Rel_Gerencial_Anual_NF_Mov WHERE ANO = " & ano & " ORDER BY ANO, CHAVE")


	'>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>

	Dim chr_SQL

	chr_SQL = "SELECT MAX(DATACRIACAO) FROM SCE_Rel_Gerencial_Anual_NF_Mov"
	Set RS = Conn.Execute(chr_SQL)
	If IsNull(RS(0)) Then dtt_Criacao = Date() Else dtt_Criacao = RS(0)
	RS.Close

	If Date() - dtt_Criacao > 6 Then
		chr_SQL = 	VbCrLf & _
				"DECLARE @mes INT," & VbCrLf & _
				"	@chave INT," & VbCrLf & _
				"	@relatorio VARCHAR(200)," & VbCrLf & _
				"	@auxmes INT," & VbCrLf & _
				"	@auxrelat VARCHAR(200)," & VbCrLf & _
				"	@total INT," & VbCrLf & _
				"	@ano INT," & VbCrLf & _
				"	@anoAtual INT" & VbCrLf & _
				"" & VbCrLf & _
				"CREATE TABLE #tb_relat (" & VbCrLf & _
				"	CHAVE SMALLINT, --identificador sequencial utilizado para ordenação pela interface" & VbCrLf & _
				"	ANO SMALLINT," & VbCrLf & _
				"	MES SMALLINT," & VbCrLf & _
				"	RELATORIO VARCHAR(200)," & VbCrLf & _
				"	VALOR INT" & VbCrLf & _
				")" & VbCrLf & _
				"" & VbCrLf & _
				"DELETE FROM dbo.SCE_Rel_Gerencial_Anual_NF_Mov" & VbCrLf & _
				"" & VbCrLf & _
				"" & VbCrLf & _
				"SET @ano = (SELECT MIN(YEAR(MOV_DATA)) FROM SCE_Movimentacao)" & VbCrLf & _
				"SET @anoAtual = (SELECT MIN(YEAR(GETDATE())))" & VbCrLf & _
				"" & VbCrLf & _
				"-->>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>" & VbCrLf & _
				"-- Coleta os dados necessários para a composição da tabela" & VbCrLf & _
				"-- usada pela interface de relatórios" & VbCrLf & _
				"-->>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>" & VbCrLf & _
				"WHILE @ano <= @anoAtual" & VbCrLf & _
				"BEGIN" & VbCrLf & _
				"	SET @mes = 1" & VbCrLf & _
				"" & VbCrLf & _
				"	WHILE @mes < 13" & VbCrLf & _
				"	BEGIN" & VbCrLf & _
				"		-- NOTA FISCAL ENTRADA" & VbCrLf & _
				"		SELECT @total = count(*)" & VbCrLf & _
				"		FROM SCE_Nota_Fiscal nf " & VbCrLf & _
				"		WHERE nf.NF_TIPO = 1" & VbCrLf & _
				"		AND YEAR(nf_recebimento) = @ano AND (MONTH(nf_recebimento) = @mes)" & VbCrLf & _
				"" & VbCrLf & _
				"		INSERT INTO #tb_relat VALUES (1, @ano, @mes, 'NOTA FISCAL ENTRADA CADASTRADA', @total)" & VbCrLf & _
				"" & VbCrLf & _
				"" & VbCrLf & _
				"		-- MOVIMENTACAO NOTAS ENTRADA" & VbCrLf & _
				"		SELECT @total = count(distinct m.nf_id)" & VbCrLf & _
				"		FROM SCE_Nota_Fiscal nf " & VbCrLf & _
				"		INNER JOIN SCE_Movimentacao m " & VbCrLf & _
				"		ON m.NF_ID = nf.NF_ID" & VbCrLf & _
				"		WHERE nf.NF_TIPO = 1" & VbCrLf & _
				"		AND YEAR(nf_recebimento) = @ano AND (MONTH(nf_recebimento) = @mes)" & VbCrLf & _
				"" & VbCrLf & _
				"		INSERT INTO #tb_relat VALUES (2, @ano, @mes, 'NOTA FISCAL ENTRADA COM ITEM ASSOCIADO', @total)" & VbCrLf & _
				"" & VbCrLf & _
				"" & VbCrLf & _
				"		-- EQUIPAMENTOS EM NOTAS DE ENTRADA" & VbCrLf & _
				"		select @total = count(*)" & VbCrLf & _
				"		FROM SCE_Nota_Fiscal nf " & VbCrLf & _
				"		INNER JOIN SCE_Movimentacao m " & VbCrLf & _
				"		ON m.NF_ID = nf.NF_ID" & VbCrLf & _
				"		INNER JOIN SCE_Equipamentos e" & VbCrLf & _
				"		ON e.EQ_ID = m.EQ_ID" & VbCrLf & _
				"		WHERE nf.NF_TIPO = 1" & VbCrLf & _
				"		AND YEAR(nf_recebimento) = @ano AND (MONTH(nf_recebimento) = @mes)" & VbCrLf & _
				"" & VbCrLf & _
				"		INSERT INTO #tb_relat VALUES (3, @ano, @mes, 'ITENS COM ASSOCIAÇÃO À NOTA FISCAL ENTRADA', @total)" & VbCrLf & _
				"" & VbCrLf & _
				"" & VbCrLf & _
				"		-- ACESSORIO EM NOTA DE ENTRADA" & VbCrLf & _
				"		select @total = count(*)" & VbCrLf & _
				"		FROM SCE_Nota_Fiscal nf " & VbCrLf & _
				"		INNER JOIN SCE_Movimentacao m " & VbCrLf & _
				"		ON m.NF_ID = nf.NF_ID" & VbCrLf & _
				"		INNER JOIN SCE_Equipamentos e" & VbCrLf & _
				"		ON e.EQ_ID = m.EQ_ID" & VbCrLf & _
				"		INNER JOIN SCE_Acessorios a" & VbCrLf & _
				"		ON a.EQ_ID = e.EQ_ID" & VbCrLf & _
				"		WHERE nf.NF_TIPO = 1" & VbCrLf & _
				"		AND YEAR(nf_recebimento) = @ano AND (MONTH(nf_recebimento) = @mes)" & VbCrLf & _
				"" & VbCrLf & _
				"		INSERT INTO #tb_relat VALUES (4, @ano, @mes, 'ACESSORIOS COM ASSOCIAÇÃO À NOTA FISCAL ENTRADA', @total)" & VbCrLf & _
				"" & VbCrLf & _
				"" & VbCrLf & _
				"		-- NOTA FISCAL SAIDA" & VbCrLf & _
				"		SELECT @total = count(*)" & VbCrLf & _
				"		FROM SCE_Nota_Fiscal nf " & VbCrLf & _
				"		WHERE nf.NF_TIPO = 2" & VbCrLf & _
				"		AND YEAR(nf_recebimento) = @ano AND (MONTH(nf_recebimento) = @mes)" & VbCrLf & _
				"" & VbCrLf & _
				"		INSERT INTO #tb_relat VALUES (5, @ano, @mes, 'NOTA FISCAL SAÍDA CADASTRADA', @total)" & VbCrLf & _
				"" & VbCrLf & _
				"" & VbCrLf & _
				"		-- MOVIMENTACAO NOTAS SAIDA" & VbCrLf & _
				"		SELECT @total = count(distinct m.nf_id)" & VbCrLf & _
				"		FROM SCE_Nota_Fiscal nf " & VbCrLf & _
				"		INNER JOIN SCE_Movimentacao m " & VbCrLf & _
				"		ON m.NF_ID = nf.NF_ID" & VbCrLf & _
				"		WHERE nf.NF_TIPO = 2" & VbCrLf & _
				"		AND YEAR(nf_recebimento) = @ano AND (MONTH(nf_recebimento) = @mes)" & VbCrLf & _
				"" & VbCrLf & _
				"		INSERT INTO #tb_relat VALUES (6, @ano, @mes, 'NOTA FISCAL SAÍDA COM ITEM ASSOCIADO', @total)" & VbCrLf & _
				"" & VbCrLf & _
				"" & VbCrLf & _
				"		-- EQUIPAMENTOS EM NOTAS DE SAIDA" & VbCrLf & _
				"		select @total = count(*)" & VbCrLf & _
				"		FROM SCE_Nota_Fiscal nf " & VbCrLf & _
				"		INNER JOIN SCE_Movimentacao m " & VbCrLf & _
				"		ON m.NF_ID = nf.NF_ID" & VbCrLf & _
				"		INNER JOIN SCE_Equipamentos e" & VbCrLf & _
				"		ON e.EQ_ID = m.EQ_ID" & VbCrLf & _
				"		WHERE nf.NF_TIPO = 2" & VbCrLf & _
				"		AND YEAR(nf_recebimento) = @ano AND (MONTH(nf_recebimento) = @mes)" & VbCrLf & _
				"" & VbCrLf & _
				"		INSERT INTO #tb_relat VALUES (7, @ano, @mes, 'ITENS COM ASSOCIAÇÃO À NOTA FISCAL SAÍDA', @total)" & VbCrLf & _
				"" & VbCrLf & _
				"" & VbCrLf & _
				"		-- ACESSORIO EM NOTA DE SAIDA" & VbCrLf & _
				"		select @total = count(*)" & VbCrLf & _
				"		FROM SCE_Nota_Fiscal nf " & VbCrLf & _
				"		INNER JOIN SCE_Movimentacao m " & VbCrLf & _
				"		ON m.NF_ID = nf.NF_ID" & VbCrLf & _
				"		INNER JOIN SCE_Equipamentos e" & VbCrLf & _
				"		ON e.EQ_ID = m.EQ_ID" & VbCrLf & _
				"		INNER JOIN SCE_Acessorios a" & VbCrLf & _
				"		ON a.EQ_ID = e.EQ_ID" & VbCrLf & _
				"		WHERE nf.NF_TIPO = 2" & VbCrLf & _
				"		AND YEAR(nf_recebimento) = @ano AND (MONTH(nf_recebimento) = @mes)" & VbCrLf & _
				"" & VbCrLf & _
				"		INSERT INTO #tb_relat VALUES (8, @ano, @mes, 'ACESSORIOS COM ASSOCIAÇÃO À NOTA FISCAL SAÍDA', @total)" & VbCrLf & _
				"" & VbCrLf & _
				"" & VbCrLf & _
				"		-- MOVIMENTACAO DE SAIDA DO LOG - INFRA-ESTRUTURA" & VbCrLf & _
				"		-- acrescentado em 08/03/2006" & VbCrLf & _
				"		SELECT @total = count(distinct m.mov_id)" & VbCrLf & _
				"		FROM SCE_Movimentacao m " & VbCrLf & _
				"		INNER JOIN SCE_Natureza_Operacao n" & VbCrLf & _
				"		ON m.NO_ID = n.NO_ID" & VbCrLf & _
				"		WHERE n.NO_TIPO = 4 -- Logística saída" & VbCrLf & _
				"		AND YEAR(m.mov_data) = @ano AND (MONTH(m.mov_data) = @mes)" & VbCrLf & _
				"		AND n.NO_ID = 527  -- LAB - Saída para infraestrutura do laboratório" & VbCrLf & _
				"" & VbCrLf & _
				"		INSERT INTO #tb_relat VALUES (9, @ano, @mes, 'ALOCAÇÃO DE ITENS PARA INFRA-ESTRUTURA', @total)" & VbCrLf & _
				"" & VbCrLf & _
				"" & VbCrLf & _
				"		-- ACESSORIOS SAIDA LOG - INFRA-ESTRUTURA" & VbCrLf & _
				"		SELECT @total = count(*)" & VbCrLf & _
				"		FROM SCE_Movimentacao m " & VbCrLf & _
				"		INNER JOIN SCE_Natureza_Operacao n" & VbCrLf & _
				"		ON m.NO_ID = n.NO_ID" & VbCrLf & _
				"		INNER JOIN SCE_Equipamentos e" & VbCrLf & _
				"		ON e.EQ_ID = m.EQ_ID" & VbCrLf & _
				"		INNER JOIN SCE_Acessorios a" & VbCrLf & _
				"		ON a.EQ_ID = e.EQ_ID" & VbCrLf & _
				"		WHERE n.NO_TIPO = 4 -- Logística saída" & VbCrLf & _
				"		AND YEAR(m.mov_data) = @ano AND (MONTH(m.mov_data) = @mes)" & VbCrLf & _
				"		AND n.NO_ID = 527  -- LAB - Saída para infraestrutura do laboratório" & VbCrLf & _
				"" & VbCrLf & _
				"		INSERT INTO #tb_relat VALUES (10, @ano, @mes, 'ALOCAÇÃO DE ACESSÓRIOS PARA INFRA-ESTRUTURA', @total)" & VbCrLf & _
				"" & VbCrLf & _
				"" & VbCrLf & _
				"		-- MOVIMENTO COM AGENDAMENTO DE SAIDA LOG" & VbCrLf & _
				"		SELECT @total = count(distinct m.ASA)" & VbCrLf & _
				"		FROM SCE_Movimentacao m " & VbCrLf & _
				"		INNER JOIN SCE_Natureza_Operacao n" & VbCrLf & _
				"		ON m.NO_ID = n.NO_ID" & VbCrLf & _
				"		WHERE n.NO_TIPO = 3" & VbCrLf & _
				"		AND YEAR(m.mov_data) = @ano AND (MONTH(m.mov_data) = @mes)" & VbCrLf & _
				"		AND ((m.ASA is not null) OR (m.ASA <> ''))" & VbCrLf & _
				"" & VbCrLf & _
				"		INSERT INTO #tb_relat VALUES (11, @ano, @mes, 'ALOCAÇÃO DE RESERVAS PARA O LAB', @total)" & VbCrLf & _
				"" & VbCrLf & _
				"" & VbCrLf & _
				"		-- MOVIMENTACAO DE SAIDA DO LOG" & VbCrLf & _
				"		SELECT @total = count(distinct m.mov_id)" & VbCrLf & _
				"		FROM SCE_Movimentacao m " & VbCrLf & _
				"		INNER JOIN SCE_Natureza_Operacao n" & VbCrLf & _
				"		ON m.NO_ID = n.NO_ID" & VbCrLf & _
				"		WHERE n.NO_TIPO = 3" & VbCrLf & _
				"		AND YEAR(m.mov_data) = @ano AND (MONTH(m.mov_data) = @mes)" & VbCrLf & _
				"		AND ((m.ASA is not null) OR (m.ASA <> ''))" & VbCrLf & _
				"" & VbCrLf & _
				"		INSERT INTO #tb_relat VALUES (12, @ano, @mes, 'ALOCAÇÃO DE ITENS RESERVADOS', @total)" & VbCrLf & _
				"" & VbCrLf & _
				"" & VbCrLf & _
				"		-- ACESSORIOS SAIDA LOG" & VbCrLf & _
				"		SELECT @total = count(*)" & VbCrLf & _
				"		FROM SCE_Movimentacao m " & VbCrLf & _
				"		INNER JOIN SCE_Natureza_Operacao n" & VbCrLf & _
				"		ON m.NO_ID = n.NO_ID" & VbCrLf & _
				"		INNER JOIN SCE_Equipamentos e" & VbCrLf & _
				"		ON e.EQ_ID = m.EQ_ID" & VbCrLf & _
				"		INNER JOIN SCE_Acessorios a" & VbCrLf & _
				"		ON a.EQ_ID = e.EQ_ID" & VbCrLf & _
				"		WHERE n.NO_TIPO = 3" & VbCrLf & _
				"		AND YEAR(mov_data) = @ano AND (MONTH(mov_data) = @mes)" & VbCrLf & _
				"		AND ((m.ASA is not null) OR (m.ASA <> ''))" & VbCrLf & _
				"" & VbCrLf & _
				"		INSERT INTO #tb_relat VALUES (13, @ano, @mes, 'ALOCAÇÃO DE ACESSÓRIOS RESERVADOS', @total)" & VbCrLf & _
				"" & VbCrLf & _
				"" & VbCrLf & _
				"		-- MOVIMENTO COM AGENDAMENTO DE ENTRADA LOG" & VbCrLf & _
				"		SELECT @total = count(distinct m.ASA)" & VbCrLf & _
				"		FROM SCE_Movimentacao m " & VbCrLf & _
				"		INNER JOIN SCE_Natureza_Operacao n" & VbCrLf & _
				"		ON m.NO_ID = n.NO_ID" & VbCrLf & _
				"		WHERE n.NO_TIPO = 2" & VbCrLf & _
				"		AND YEAR(m.mov_data) = @ano AND (MONTH(m.mov_data) = @mes)" & VbCrLf & _
				"		AND ((m.ASA is not null) OR (m.ASA <> ''))" & VbCrLf & _
				"" & VbCrLf & _
				"		INSERT INTO #tb_relat VALUES (14, @ano, @mes, 'DESALOCAÇÃO DE RESERVAS DO LAB', @total)" & VbCrLf & _
				"" & VbCrLf & _
				"" & VbCrLf & _
				"		-- MOVIMENTACAO DE ENTRADA NO LOG" & VbCrLf & _
				"		SELECT @total = count(distinct m.mov_id)" & VbCrLf & _
				"		FROM SCE_Movimentacao m " & VbCrLf & _
				"		INNER JOIN SCE_Natureza_Operacao n" & VbCrLf & _
				"		ON m.NO_ID = n.NO_ID" & VbCrLf & _
				"		WHERE n.NO_TIPO = 2" & VbCrLf & _
				"		AND YEAR(m.mov_data) = @ano AND (MONTH(m.mov_data) = @mes)" & VbCrLf & _
				"		AND ((m.ASA is not null) OR (m.ASA <> ''))" & VbCrLf & _
				"" & VbCrLf & _
				"		INSERT INTO #tb_relat VALUES (15, @ano, @mes, 'DESALOCAÇÃO DE ITENS RESERVADOS', @total)" & VbCrLf & _
				"" & VbCrLf & _
				"" & VbCrLf & _
				"		-- ACESSORIOS ENTRADA LOG" & VbCrLf & _
				"		SELECT @total = count(*)" & VbCrLf & _
				"		FROM SCE_Movimentacao m " & VbCrLf & _
				"		INNER JOIN SCE_Natureza_Operacao n" & VbCrLf & _
				"		ON m.NO_ID = n.NO_ID" & VbCrLf & _
				"		INNER JOIN SCE_Equipamentos e" & VbCrLf & _
				"		ON e.EQ_ID = m.EQ_ID" & VbCrLf & _
				"		INNER JOIN SCE_Acessorios a" & VbCrLf & _
				"		ON a.EQ_ID = e.EQ_ID" & VbCrLf & _
				"		WHERE n.NO_TIPO = 2" & VbCrLf & _
				"		AND YEAR(mov_data) = @ano AND (MONTH(mov_data) = @mes)" & VbCrLf & _
				"		AND ((m.ASA is not null) OR (m.ASA <> ''))" & VbCrLf & _
				"" & VbCrLf & _
				"		INSERT INTO #tb_relat VALUES (16, @ano, @mes, 'DESALOCAÇÃO DE ACESSÓRIOS RESERVADOS', @total)" & VbCrLf & _
				"" & VbCrLf & _
				"		------------------------------------------------------------------------------------------" & VbCrLf & _
				"" & VbCrLf & _
				"		SET @mes = @mes + 1" & VbCrLf & _
				"	END" & VbCrLf & _
				"" & VbCrLf & _
				"	SET @ano = @ano + 1" & VbCrLf & _
				"END" & VbCrLf & _
				"" & VbCrLf & _
				"-->>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>" & VbCrLf & _
				"-- Preenche a tabela com os novos dados coletados" & VbCrLf & _
				"-->>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>" & VbCrLf & _
				"DECLARE cur_TMP CURSOR FOR" & VbCrLf & _
				"	SELECT CHAVE, ANO, MES, relatorio, VALOR" & VbCrLf & _
				"	FROM #tb_relat " & VbCrLf & _
				"	ORDER BY RELATORIO, ANO, MES" & VbCrLf & _
				"" & VbCrLf & _
				"OPEN cur_TMP" & VbCrLf & _
				"FETCH NEXT FROM cur_TMP INTO @chave, @ano, @mes, @relatorio, @total" & VbCrLf & _
				"" & VbCrLf & _
				"SET @auxmes = 1" & VbCrLf & _
				"SET @auxrelat = @relatorio" & VbCrLf & _
				"" & VbCrLf & _
				"WHILE @@FETCH_STATUS = 0" & VbCrLf & _
				"BEGIN" & VbCrLf & _
				"	IF @mes = 1" & VbCrLf & _
				"		INSERT INTO SCE_Rel_Gerencial_Anual_NF_Mov (CHAVE, RELATORIO, ANO, MES1) VALUES (@chave, @relatorio, @ano, @total)" & VbCrLf & _
				"	ELSE IF @mes = 2 " & VbCrLf & _
				"		UPDATE SCE_Rel_Gerencial_Anual_NF_Mov SET MES2 = @total WHERE RELATORIO = @relatorio AND ANO = @ano" & VbCrLf & _
				"	ELSE IF @mes = 3" & VbCrLf & _
				"		UPDATE SCE_Rel_Gerencial_Anual_NF_Mov SET MES3 = @total WHERE RELATORIO = @relatorio AND ANO = @ano" & VbCrLf & _
				"	ELSE IF @mes = 4" & VbCrLf & _
				"		UPDATE SCE_Rel_Gerencial_Anual_NF_Mov SET MES4 = @total WHERE RELATORIO = @relatorio AND ANO = @ano" & VbCrLf & _
				"	ELSE IF @mes = 5" & VbCrLf & _
				"		UPDATE SCE_Rel_Gerencial_Anual_NF_Mov SET MES5 = @total WHERE RELATORIO = @relatorio AND ANO = @ano" & VbCrLf & _
				"	ELSE IF @mes = 6" & VbCrLf & _
				"		UPDATE SCE_Rel_Gerencial_Anual_NF_Mov SET MES6 = @total WHERE RELATORIO = @relatorio AND ANO = @ano" & VbCrLf & _
				"	ELSE IF @mes = 7" & VbCrLf & _
				"		UPDATE SCE_Rel_Gerencial_Anual_NF_Mov SET MES7 = @total WHERE RELATORIO = @relatorio AND ANO = @ano" & VbCrLf & _
				"	ELSE IF @mes = 8" & VbCrLf & _
				"		UPDATE SCE_Rel_Gerencial_Anual_NF_Mov SET MES8 = @total WHERE RELATORIO = @relatorio AND ANO = @ano" & VbCrLf & _
				"	ELSE IF @mes = 9" & VbCrLf & _
				"		UPDATE SCE_Rel_Gerencial_Anual_NF_Mov SET MES9 = @total WHERE RELATORIO = @relatorio AND ANO = @ano" & VbCrLf & _
				"	ELSE IF @mes = 10" & VbCrLf & _
				"		UPDATE SCE_Rel_Gerencial_Anual_NF_Mov SET MES10 = @total WHERE RELATORIO = @relatorio AND ANO = @ano" & VbCrLf & _
				"	ELSE IF @mes = 11" & VbCrLf & _
				"		UPDATE SCE_Rel_Gerencial_Anual_NF_Mov SET MES11 = @total WHERE RELATORIO = @relatorio AND ANO = @ano" & VbCrLf & _
				"	ELSE IF @mes = 12" & VbCrLf & _
				"		UPDATE SCE_Rel_Gerencial_Anual_NF_Mov SET MES12 = @total WHERE RELATORIO = @relatorio AND ANO = @ano" & VbCrLf & _
				"" & VbCrLf & _
				"	FETCH NEXT FROM cur_TMP INTO @chave, @ano, @mes, @relatorio, @total" & VbCrLf & _
				"" & VbCrLf & _
				"	SET @auxmes = @auxmes + 1" & VbCrLf & _
				"END" & VbCrLf & _
				"" & VbCrLf & _
				"CLOSE cur_TMP" & VbCrLf & _
				"DEALLOCATE cur_TMP" & VbCrLf & _
				"" & VbCrLf & _
				"DROP TABLE #tb_relat" & VbCrLf

		On Error Resume Next
		Call Conn.BeginTrans
		Call Conn.Execute(chr_SQL)
		If Err.Number <> 0 Then
			Call Conn.RollbackTrans
			Response.Write "<b>Erro na consulta SQL !!!</b>"
		End If
		Call Conn.CommitTrans
'		On Error Goto 0
	End If

	Set RS = Conn.Execute("SELECT *, CONVERT(VARCHAR, DATACRIACAO, 103) + ' ' + LEFT(CONVERT(VARCHAR, DATACRIACAO, 114), 5) AS DATAATUALIZACAO FROM SCE_Rel_Gerencial_Anual_NF_Mov WHERE ANO = " & ano & " ORDER BY ANO, CHAVE")

	'>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>



	If RS.Eof And RS.Bof Then
%>
		<tr><td align='center'><b><i>Nenhuma informação encontrada !</i></b></td></tr>
<%	Else %>
		<tr style="font-weight: bold;">
			<td>Movimento</td>
			<td align="center">Jan</td>
			<td align="center">Fev</td>
			<td align="center">Mar</td>
			<td align="center">Abr</td>
			<td align="center">Mai</td>
			<td align="center">Jun</td>
			<td align="center">Jul</td>
			<td align="center">Ago</td>
			<td align="center">Set</td>
			<td align="center">Out</td>
			<td align="center">Nov</td>
			<td align="center">Dez</td>
		</tr>
<%
		conta = 0
		dtt_Criacao = RS("DATAATUALIZACAO")
		While Not RS.Eof
%>
		<tr valign="top" <%If (conta mod 2) = 0 Then Response.Write "class='linha_par'"%>>
			<td><%=RS("RELATORIO")%></td>
<%			For mes = 1 To 12 %>
			<td align="center"><%=RS("MES"& mes)%></td>
<%			Next %>
		</tr>
<%			RS.MoveNext
			conta = conta + 1
		WEnd%>
		<tr><td colspan="13" align="right"><i>Atualizado em <%=dtt_Criacao%></i></td></tr>
<%	End If%>
		</table>
	</td>
</tr>
<%
End If
%>
<tr><td>&nbsp;</td></tr>
</table>
<%
conn.close
set conn=nothing

call ImprimeRodape (RODAPE_OFF)
%>