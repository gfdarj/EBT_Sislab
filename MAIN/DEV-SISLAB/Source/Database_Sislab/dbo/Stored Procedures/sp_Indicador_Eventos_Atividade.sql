CREATE PROCEDURE [dbo].[sp_Indicador_Eventos_Atividade]
	@dataIni AS DATETIME,
	@dataFim AS DATETIME,
	@Retorno AS VARCHAR(50)
AS
BEGIN
	/***
		Calcula os indicadores de Atidade dentro de uma faixa de datas.
		O calculo pode ser feito por tipo de atividade ou por responsável ou ambos

		Obs: A primeira linha do recordset é sempre o somatório dos índices

		Gilberto - COPPETEC
		Criado em: 13/04/2004
	***/
	SET NOCOUNT ON

	-- crio uma tabela temporária para calculo dos indicadores
	CREATE TABLE #Indicadores (
		Nome VARCHAR(50),
		Inicio DATETIME,
		Fim DATETIME,
		Agendamento INT,
		Responsavel VARCHAR(20),
		Dias INT
	)

	INSERT INTO #Indicadores (nome, inicio, fim, Agendamento, Responsavel, dias)
		SELECT ta.TA_DESCRICAO, AG_DATAINICIO, a.AG_DATATERMINO, a.AG_NUMERO, a.AG_RESPONSAVEL,
		CASE	-- calculo a média do mês
			WHEN (CONVERT(DATETIME, AG_DATAINICIO, 103) <= @dataIni) and (CONVERT(DATETIME, AG_DATATERMINO, 103) <= @dataFim)
			THEN CAST(datediff(day, @dataIni, CONVERT(DATETIME, AG_DATATERMINO, 103)) AS DECIMAL) + 1

			WHEN (CONVERT(DATETIME, AG_DATAINICIO, 103) <= @dataIni) and (CONVERT(DATETIME, AG_DATATERMINO, 103) > @dataFim)
			THEN CAST(datediff(day, @dataIni, @dataFim) AS DECIMAL) + 1

			WHEN  (CONVERT(DATETIME, AG_DATAINICIO, 103) > @dataIni) and (CONVERT(DATETIME, AG_DATATERMINO, 103) <= @dataFim)
			THEN CAST(datediff(day, CONVERT(DATETIME, AG_DATAINICIO, 103), CONVERT(DATETIME, AG_DATATERMINO, 103)) AS DECIMAL) + 1

			WHEN  (CONVERT(DATETIME, AG_DATAINICIO, 103) > @dataIni) and (CONVERT(DATETIME, AG_DATATERMINO, 103) > @dataFim)
			THEN CAST(datediff(day, CONVERT(DATETIME, AG_DATAINICIO, 103), @dataFim) AS DECIMAL) + 1
		END
		FROM Agendamento a LEFT JOIN Tipo_Atividade ta on ta.TA_ID = a.TA_ID
		WHERE (CONVERT(DATETIME, AG_DATATERMINO, 103) BETWEEN @dataIni and @dataFim) OR 
			(CONVERT(DATETIME, AG_DATAINICIO, 103) BETWEEN @dataIni and @dataFim) OR
			((CONVERT(DATETIME, AG_DATAINICIO, 103) < @dataIni) AND (CONVERT(DATETIME, AG_DATATERMINO, 103) > @dataFim))
		--GROUP BY ta.TA_DESCRICAO, AG_DATAINICIO, AG_DATATERMINO
	IF @@ERROR <> 0
	BEGIN
		RAISERROR('Erro ao criar tabela temporária #Indicadores', 16, 1)
		RETURN -1
	END

	SET @Retorno = UPPER(@Retorno)

	IF @Retorno IS NULL OR @Retorno = 'ATIVIDADE'
	BEGIN
		SELECT	nome AS 'Atividade', CAST(CAST(SUM(dias) AS DECIMAL) / (DATEDIFF(DAY, @dataIni, @dataFim) + 1) AS DECIMAL(10,2)) AS 'Média'
		FROM #Indicadores
		GROUP BY Nome WITH CUBE
		ORDER BY 'Média' DESC;
	END

	IF @Retorno IS NULL OR @Retorno = 'RESPONSAVEL'
	BEGIN
		SELECT	Responsavel AS 'Responsável', CAST(CAST(SUM(dias) AS DECIMAL) / (DATEDIFF(DAY, @dataIni, @dataFim) + 1) AS DECIMAL(10,2)) AS 'Média'
		FROM #Indicadores
		GROUP BY Responsavel WITH CUBE
		ORDER BY 'Média' DESC;
	END

	DROP TABLE #Indicadores

	RETURN 1
END
