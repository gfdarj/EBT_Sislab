CREATE VIEW [dbo].[vw_Total_Orgao_Atividade]
AS
	/** 
		Totaliza os agendamentos por órgao do solicitante e tipo de atividade

		COPPETEC - Gilberto Almeida - 13/01/2004
	**/
	SELECT ALL TOP 100 PERCENT 
		CASE WHEN o.AG_ORGAO IS NULL THEN '- Nenhum órgão definido' ELSE o.AG_ORGAO END AS AG_ORGAO,
		ta.ta_descricao,
		CASE WHEN
		(
			SELECT COUNT(*)
			FROM Agendamento aa left JOIN Tipo_Atividade ata ON aa.TA_ID = ata.TA_ID
			WHERE ta.ta_descricao = ata.ta_descricao AND aa.AG_ORGAO = o.AG_ORGAO
			GROUP BY aa.AG_ORGAO, ata.TA_DESCRICAO
		) IS NULL THEN 0 
		ELSE
		(
			SELECT COUNT(*)
			FROM Agendamento aa left JOIN Tipo_Atividade ata ON aa.TA_ID = ata.TA_ID
			WHERE ta.ta_descricao = ata.ta_descricao AND aa.AG_ORGAO = o.AG_ORGAO
			GROUP BY aa.AG_ORGAO, ata.TA_DESCRICAO
		) END AS TOTAL_POR_ATIVIDADE
	FROM Tipo_Atividade ta 
		LEFT JOIN Agendamento a on ta.ta_id = ta.ta_id
		LEFT JOIN (SELECT DISTINCT AG_ORGAO FROM Agendamento) o on a.AG_ORGAO = o.AG_ORGAO
	GROUP BY o.AG_ORGAO, ta.ta_descricao
	ORDER BY o.AG_ORGAO, ta.ta_descricao
