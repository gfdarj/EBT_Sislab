CREATE VIEW [dbo].[vw_Total_Tecnologia_Fabricante]
AS
	/** 	Totaliza os agendamentos por tecnologia e fabricante por situacao
		do agendamento

		COPPETEC - Gilberto Almeida - 19/01/2004

		OBS: Comentado em 06/05/2004 para posterior alteração visando
		pegar os dados segundo a nova concepcao adotada (Equipamentos do SCE,
		logo os fabricantes IDEM)
	**/
	SELECT 'Sem Tecnologia' AS TEC_NOME,
		'Sem Fabricante' FAB_DESCRICAO, 
		'' AS S_DESCRICAO, 0 AS TOTAL_SITUACAO

	--SELECT TOP 100 PERCENT
	--	tec.TEC_NOME, 
	--	CASE WHEN agt.FAB_DESCRICAO IS NULL THEN '* Sem Fabricante' 
	--		ELSE agt.FAB_DESCRICAO END AS FAB_DESCRICAO, 
	--	sit.S_DESCRICAO, COUNT(*) AS TOTAL_SITUACAO
	--FROM Tecnologia tec
	--	INNER JOIN Agendamento a ON a.TEC_ID = tec.TEC_ID
	--	INNER JOIN vw_Agendamento_Teste agt ON a.AG_NUMERO = agt.AG_NUMERO
	--	INNER JOIN Historico_Eventos he ON agt.AG_NUMERO = he.AG_NUMERO
	--	INNER JOIN Situacoes sit ON sit.ID_SITUACAO = he.ID_SITUACAO
	--WHERE	/* pega APENAS o último evento da AS */
	--	he.HE_DATAinicio = (SELECT MAX(he1.HE_DATAinicio) from historico_eventos he1 where he1.ag_numero = he.ag_numero)
	--	AND  /* apenas equipamentos */
	--	agt.TIPO_EQUIPAMENTO = 'E'
	--GROUP BY tec.TEC_NOME, agt.FAB_DESCRICAO, sit.S_DESCRICAO
	--ORDER BY tec.TEC_NOME, agt.FAB_DESCRICAO, sit.S_DESCRICAO
