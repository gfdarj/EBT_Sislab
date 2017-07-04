
CREATE VIEW [dbo].[vw_Agendamento]
AS
	/* Exibe os dados do agendamento e a sua situacao atual */
	SELECT a.*, h.HE_RESPONSAVEL, h.HE_DATAINICIO, h.HE_DATATERMINO, h.HE_MOTIVO, 
		s.ID_SITUACAO, s.S_DESCRICAO, ta.TA_DESCRICAO, t.TEC_NOME, ts.TS_DESCRICAO
	FROM Agendamento a 
	/*** Pega o status pela maior Data ***/
		INNER JOIN Historico_Eventos h ON a.AG_NUMERO = h.AG_NUMERO
		INNER JOIN (
			SELECT h1.AG_NUMERO, MAX(h1.HE_ID) AS HE_ID
			FROM Historico_Eventos h1
				INNER JOIN (
					SELECT AG_NUMERO, MAX(HE_DATAINICIO) AS HE_DATAINICIO 
					FROM Historico_Eventos hh1
					--WHERE hh1.AG_NUMERO = h.AG_NUMERO
					GROUP BY hh1.AG_NUMERO
				) h2 ON h1.AG_NUMERO = h2.AG_NUMERO AND h1.HE_DATAINICIO = h2.HE_DATAINICIO
			GROUP BY h1.AG_NUMERO
		) h3 ON h3.HE_ID = h.HE_ID
		INNER JOIN Situacoes s ON h.ID_SITUACAO = s.ID_SITUACAO
		LEFT JOIN Tipo_Atividade ta ON ta.TA_ID = a.TA_ID
		LEFT JOIN Tecnologia t ON t.TEC_ID = a.TEC_ID
		LEFT JOIN Tipo_Sigilo ts on ts.TS_ID = a.AG_SIGILO

	/*** Pega o status pela maior ID ***/
	--	INNER JOIN Historico_Eventos h ON a.AG_NUMERO = h.AG_NUMERO
	--	-- pego o STATUS do agendamento pelo ultimo registro inserido para o mesmo
	--	INNER JOIN (
	--		SELECT h1.AG_NUMERO, MAX(h1.HE_ID) AS HE_ID
	--		FROM Historico_Eventos h1
	--		GROUP BY h1.AG_NUMERO
	--	) h3 ON h3.HE_ID = h.HE_ID
	--	INNER JOIN Situacoes s ON h.ID_SITUACAO = s.ID_SITUACAO
	--	LEFT JOIN Tipo_Atividade ta ON ta.TA_ID = a.TA_ID
	--	LEFT JOIN Tecnologia t ON t.TEC_ID = a.TEC_ID
	--	LEFT JOIN Tipo_Sigilo ts on ts.TS_ID = a.AG_SIGILO
