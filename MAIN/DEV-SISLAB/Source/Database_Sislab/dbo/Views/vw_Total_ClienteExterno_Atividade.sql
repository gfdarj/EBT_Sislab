CREATE VIEW [dbo].[vw_Total_ClienteExterno_Atividade]
AS
	/** 
		Totaliza os agendamentos por cliente externo e tipo de atividade

		COPPETEC - Gilberto Almeida - 14/01/2004

		OBS: a instrucao abaixo foi necessaria pois o SQL Server possui 2 formas de trabalhar.
		usando SET ANSI_NULLS ON ele nao aceita comparacoes do tipo CAMPO = NULL, para tal
		temos que desligar o comando SET. Como estou dentro de uma view fica mais facil utilizar
		a comparacao desta maneira

			(CASE WHEN o.AG_ORGAO IS NULL THEN '' ELSE o.AG_ORGAO END) = (CASE WHEN aa.AG_ORGAO IS NULL THEN '' ELSE aa.AG_ORGAO END)
	**/
	SELECT ALL TOP 100 PERCENT 
		--CASE WHEN o.AG_CLIENTEEXTERNO IS NULL THEN '- Nenhum cliente externo' ELSE o.AG_CLIENTEEXTERNO END AS AG_CLIENTEEXTERNO,
		o.AG_CLIENTEEXTERNO,
		ta.ta_descricao,
		CASE WHEN
		(
			SELECT COUNT(*)
			FROM Agendamento aa left JOIN Tipo_Atividade ata ON aa.TA_ID = ata.TA_ID
			WHERE ta.ta_descricao = ata.ta_descricao AND (CASE WHEN o.AG_CLIENTEEXTERNO IS NULL THEN '' ELSE o.AG_CLIENTEEXTERNO END) = (CASE WHEN aa.AG_CLIENTEEXTERNO IS NULL THEN '' ELSE aa.AG_CLIENTEEXTERNO END)
			GROUP BY aa.AG_CLIENTEEXTERNO, ata.TA_DESCRICAO
		) IS NULL THEN 0 
		ELSE
		(
			SELECT COUNT(*)
			FROM Agendamento aa left JOIN Tipo_Atividade ata ON aa.TA_ID = ata.TA_ID
			WHERE ta.ta_descricao = ata.ta_descricao AND (CASE WHEN o.AG_CLIENTEEXTERNO IS NULL THEN '' ELSE o.AG_CLIENTEEXTERNO END) = (CASE WHEN aa.AG_CLIENTEEXTERNO IS NULL THEN '' ELSE aa.AG_CLIENTEEXTERNO END)
			GROUP BY aa.AG_CLIENTEEXTERNO, ata.TA_DESCRICAO
		) END AS TOTAL_POR_ATIVIDADE
	FROM Tipo_Atividade ta 
		LEFT JOIN Agendamento a on ta.ta_id = ta.ta_id
		LEFT JOIN (SELECT DISTINCT AG_CLIENTEEXTERNO FROM Agendamento) o on a.AG_CLIENTEEXTERNO = o.AG_CLIENTEEXTERNO
	WHERE o.AG_CLIENTEEXTERNO IS NOT NULL
	GROUP BY o.AG_CLIENTEEXTERNO, ta.ta_descricao
	ORDER BY o.AG_CLIENTEEXTERNO, ta.ta_descricao
