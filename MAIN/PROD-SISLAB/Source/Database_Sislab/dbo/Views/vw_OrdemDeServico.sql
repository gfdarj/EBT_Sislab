
CREATE VIEW [dbo].[vw_OrdemDeServico]
AS
	/* Exibe os dados das Ordens de Servico e a sua situacao atual */
	SELECT 
		os.OS_ID,
		os.OS_RESPONSAVEL,
		os.AG_NUMERO,
		os.OS_FLAGREPETICAO,
		os.OS_TECNICOEXTERNO,
		os.OS_OBSERVACOES,
		t.T_ID,
		t.T_TITULO,
		t.T_DISPONIVEL,
		os.S_ID_SERVICO,
		s.S_DESCRICAO as S_DESCRICAO_SERVICO,
		os.S_ID_PLATAFORMA,
		p.S_DESCRICAO as S_DESCRICAO_PLATAFORMA,
		os.EQ_ID_AMOSTRA,
		eq.EQ_CODIGOBARRAS AS EQ_CODIGOBARRAS_AMOSTRA,
		h.HEOS_ID,
		h.HEOS_RESPONSAVEL,
		h.HEOS_DATAINICIO,
		h.HEOS_DATATERMINO,
		h.HEOS_MOTIVO,
		sit.ID_SITUACAO,
		sit.S_DESCRICAO
	FROM 
		Ordem_de_Servico os
		/*** Pega o status pela maior Data ***/
	INNER JOIN 
		Historico_EventosOS h ON os.AG_NUMERO = h.AG_NUMERO AND os.OS_ID = h.OS_ID
	INNER JOIN (
			SELECT h1.AG_NUMERO, h1.OS_ID, MAX(h1.HEOS_ID) AS HEOS_ID
			FROM Historico_EventosOS h1
			INNER JOIN (
					SELECT AG_NUMERO, hh1.OS_ID, MAX(hh1.HEOS_DATAINICIO) AS HEOS_DATAINICIO
					FROM Historico_EventosOS hh1
					GROUP BY hh1.AG_NUMERO, hh1.OS_ID
				) h2 ON h1.AG_NUMERO = h2.AG_NUMERO AND h1.OS_ID = h2.OS_ID AND h1.HEOS_DATAINICIO = h2.HEOS_DATAINICIO
			GROUP BY h1.AG_NUMERO, h1.OS_ID
		) h3 ON h3.HEOS_ID = h.HEOS_ID
	INNER JOIN 
		Situacoes sit ON h.ID_SITUACAO = sit.ID_SITUACAO
	LEFT JOIN
		Testes t ON t.T_ID = os.T_ID
	LEFT JOIN
		Servicos_Plataformas s ON s.S_ID = os.S_ID_SERVICO
	LEFT JOIN
		Servicos_Plataformas p ON p.S_ID = os.S_ID_PLATAFORMA
	LEFT JOIN
		SCE_Equipamentos eq ON eq.EQ_ID = os.EQ_ID_AMOSTRA
