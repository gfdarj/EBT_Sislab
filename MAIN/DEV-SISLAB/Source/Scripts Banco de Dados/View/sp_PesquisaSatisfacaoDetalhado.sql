IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[dbo].[sp_PesquisaSatisfacaoDetalhado]') AND OBJECTPROPERTY(id,N'IsProcedure') = 1)
	DROP PROCEDURE [dbo].[sp_PesquisaSatisfacaoDetalhado]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

/*
	cálculo da quantidade de respostas na pesquisa de satisfação
*/
CREATE PROCEDURE [dbo].[sp_PesquisaSatisfacaoDetalhado]
(
	@DATA_INICIO DATETIME = NULL, 
	@DATA_TERMINO DATETIME = NULL
) AS
BEGIN

	IF @DATA_INICIO IS NULL
		SET @DATA_INICIO  = '1980-01-01'
	IF @DATA_TERMINO IS NULL
		SET @DATA_TERMINO = '2050-12-31'

	CREATE TABLE #pesq
	(
		PSQ_ID INT,
		AG_NUMERO INT,
		RT VARCHAR(200),
		RAT VARCHAR(200),
		DT_TERMINO DATETIME
	)

	INSERT INTO #pesq
		SELECT 
			p.PSQ_ID,
			a.AG_NUMERO,
			a.AG_RESPONSAVEL,
			a.AG_RAT,
			he.HE_DATATERMINO as 'dt_termino'
		FROM
			Agendamento a 
			INNER JOIN Historico_Eventos he ON a.AG_NUMERO = he.AG_NUMERO
			LEFT JOIN pesquisaSatisfacao p ON a.AG_NUMERO = p.PSQ_Nag
		WHERE
			he.ID_SITUACAO = 8 /* AS finalizada */
		AND
			HE_DATATERMINO BETWEEN @DATA_INICIO AND @DATA_TERMINO


	SELECT 
		DT_TERMINO
		,AG_NUMERO
		,RAT
		,RT
		,CASE
			WHEN p1.PSQ_ID IS NULL THEN 'Não'
			ELSE 'Sim'
		END AS [TEM_PESQUISA]
		,CASE
			WHEN PSQ_R1 = 5 THEN 'Muito Satisfeito'
			WHEN PSQ_R1 = 4 THEN 'Satisfeito'
			WHEN PSQ_R1 = 3 THEN 'Indiferente'
			WHEN PSQ_R1 = 2 THEN 'Insatisfeito'
			WHEN PSQ_R1 = 1 THEN 'Muito Insatisfeito'
			WHEN PSQ_R1 IS NULL THEN 'Não Respondido'
		END AS [PSQ_R1]
		,CASE
			WHEN PSQ_R2 = 5 THEN 'Muito Satisfeito'
			WHEN PSQ_R2 = 4 THEN 'Satisfeito'
			WHEN PSQ_R2 = 3 THEN 'Indiferente'
			WHEN PSQ_R2 = 2 THEN 'Insatisfeito'
			WHEN PSQ_R2 = 1 THEN 'Muito Insatisfeito'
			WHEN PSQ_R2 IS NULL THEN 'Não Respondido'
		END AS [PSQ_R2]
		,CASE
			WHEN PSQ_R3 = 5 THEN 'Muito Satisfeito'
			WHEN PSQ_R3 = 4 THEN 'Satisfeito'
			WHEN PSQ_R3 = 3 THEN 'Indiferente'
			WHEN PSQ_R3 = 2 THEN 'Insatisfeito'
			WHEN PSQ_R3 = 1 THEN 'Muito Insatisfeito'
			WHEN PSQ_R3 IS NULL THEN 'Não Respondido'
		END AS [PSQ_R3]
		,CASE
			WHEN PSQ_R4 = 5 THEN 'Muito Satisfeito'
			WHEN PSQ_R4 = 4 THEN 'Satisfeito'
			WHEN PSQ_R4 = 3 THEN 'Indiferente'
			WHEN PSQ_R4 = 2 THEN 'Insatisfeito'
			WHEN PSQ_R4 = 1 THEN 'Muito Insatisfeito'
			WHEN PSQ_R4 IS NULL THEN 'Não Respondido'
		END AS [PSQ_R4]
		,CASE
			WHEN PSQ_R5 = 5 THEN 'Muito Satisfeito'
			WHEN PSQ_R5 = 4 THEN 'Satisfeito'
			WHEN PSQ_R5 = 3 THEN 'Indiferente'
			WHEN PSQ_R5 = 2 THEN 'Insatisfeito'
			WHEN PSQ_R5 = 1 THEN 'Muito Insatisfeito'
			WHEN PSQ_R5 IS NULL THEN 'Não Respondido'
		END AS [PSQ_R5]
		,CASE
			WHEN PSQ_R6 = 5 THEN 'Muito Satisfeito'
			WHEN PSQ_R6 = 4 THEN 'Satisfeito'
			WHEN PSQ_R6 = 3 THEN 'Indiferente'
			WHEN PSQ_R6 = 2 THEN 'Insatisfeito'
			WHEN PSQ_R6 = 1 THEN 'Muito Insatisfeito'
			WHEN PSQ_R6 IS NULL THEN 'Não Respondido'
		END AS [Tipo]
		,CASE
			WHEN PSQ_R7 = 5 THEN 'Muito Satisfeito'
			WHEN PSQ_R7 = 4 THEN 'Satisfeito'
			WHEN PSQ_R7 = 3 THEN 'Indiferente'
			WHEN PSQ_R7 = 2 THEN 'Insatisfeito'
			WHEN PSQ_R7 = 1 THEN 'Muito Insatisfeito'
			WHEN PSQ_R7 IS NULL THEN 'Não Respondido'
		END AS [PSQ_R7]
		,CASE
			WHEN PSQ_R8 = 5 THEN 'Muito Satisfeito'
			WHEN PSQ_R8 = 4 THEN 'Satisfeito'
			WHEN PSQ_R8 = 3 THEN 'Indiferente'
			WHEN PSQ_R8 = 2 THEN 'Insatisfeito'
			WHEN PSQ_R8 = 1 THEN 'Muito Insatisfeito'
			WHEN PSQ_R8 IS NULL THEN 'Não Respondido'
		END AS [PSQ_R8]
		,CASE
			WHEN PSQ_R9 = 5 THEN 'Muito Satisfeito'
			WHEN PSQ_R9 = 4 THEN 'Satisfeito'
			WHEN PSQ_R9 = 3 THEN 'Indiferente'
			WHEN PSQ_R9 = 2 THEN 'Insatisfeito'
			WHEN PSQ_R9 = 1 THEN 'Muito Insatisfeito'
			WHEN PSQ_R9 IS NULL THEN 'Não Respondido'
		END AS [PSQ_R9]
		,CASE
			WHEN PSQ_R10 = 5 THEN 'Muito Satisfeito'
			WHEN PSQ_R10 = 4 THEN 'Satisfeito'
			WHEN PSQ_R10 = 3 THEN 'Indiferente'
			WHEN PSQ_R10 = 2 THEN 'Insatisfeito'
			WHEN PSQ_R10 = 1 THEN 'Muito Insatisfeito'
			WHEN PSQ_R10 IS NULL THEN 'Não Respondido'
		END AS [PSQ_R10]
		,CASE
			WHEN PSQ_R11 = 5 THEN 'Muito Satisfeito'
			WHEN PSQ_R11 = 4 THEN 'Satisfeito'
			WHEN PSQ_R11 = 3 THEN 'Indiferente'
			WHEN PSQ_R11 = 2 THEN 'Insatisfeito'
			WHEN PSQ_R11 = 1 THEN 'Muito Insatisfeito'
			WHEN PSQ_R11 IS NULL THEN 'Não Respondido'
		END AS [PSQ_R11]
	FROM 
		PesquisaSatisfacao p1 RIGHT JOIN #pesq p2 ON p1.PSQ_ID = p2.PSQ_ID
	ORDER BY
		DT_TERMINO,
		AG_NUMERO

	DROP TABLE #pesq
END
GO
