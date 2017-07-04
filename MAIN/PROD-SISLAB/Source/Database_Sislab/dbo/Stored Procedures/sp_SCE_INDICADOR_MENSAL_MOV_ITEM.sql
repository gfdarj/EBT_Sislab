CREATE PROCEDURE [dbo].[sp_SCE_INDICADOR_MENSAL_MOV_ITEM]
	@ano_base INT
AS
BEGIN
	/*
	Retorna um SELECT com os totais de itens movimentados.

	Criado em: 16/02/2004 - Gilberto F. Almeida - COPPETEC
	*/
	SELECT
		mes.MES, 
		CASE WHEN qtde_entrada.TOTAL IS NULL THEN 0 ELSE qtde_entrada.TOTAL END AS ENTRADA, 
		CASE WHEN qtde_logentrada.TOTAL IS NULL THEN 0 ELSE qtde_logentrada.TOTAL END AS ENTRADA_LOG, 
		CASE WHEN qtde_logsaida.TOTAL IS NULL THEN 0 ELSE qtde_logsaida.TOTAL END AS SAIDA_LOG,
		CASE WHEN qtde_saida.TOTAL IS NULL THEN 0 ELSE qtde_saida.TOTAL END AS SAIDA
	FROM
		(
		SELECT 1 AS MES UNION SELECT 2 UNION SELECT 3 UNION SELECT 4 UNION SELECT 5 
		UNION SELECT 6 UNION SELECT 7 UNION SELECT 8 UNION SELECT 9 UNION SELECT 10
		UNION SELECT 11 UNION SELECT 12
		) mes
	 	LEFT JOIN 
		(
			SELECT MONTH(m.MOV_DATA) AS MES, COUNT(*) AS 'TOTAL'
			FROM SCE_Movimentacao m INNER JOIN SCE_Natureza_Operacao n ON m.NO_ID = n.NO_ID
			WHERE n.NO_TIPO = 1 /* 1 = entrada */
				AND YEAR(m.MOV_DATA) = @ano_base
			GROUP BY MONTH(m.MOV_DATA)
		) qtde_entrada
		ON mes.MES= qtde_entrada.MES
 		LEFT JOIN 
		(
			SELECT MONTH(m.MOV_DATA) AS MES, COUNT(*) AS 'TOTAL'
			FROM SCE_Movimentacao m INNER JOIN SCE_Natureza_Operacao n ON m.NO_ID = n.NO_ID
			WHERE n.NO_TIPO = 2 /* 2 = log entrada */
				AND YEAR(m.MOV_DATA) = @ano_base
			GROUP BY MONTH(m.MOV_DATA)
		) qtde_logentrada
		ON mes.MES= qtde_logentrada.MES
 		LEFT JOIN 
		(
			SELECT MONTH(m.MOV_DATA) AS MES, COUNT(*) AS 'TOTAL'
			FROM SCE_Movimentacao m INNER JOIN SCE_Natureza_Operacao n ON m.NO_ID = n.NO_ID
			WHERE n.NO_TIPO = 3 /* 3 = saida/expedicao */
				AND YEAR(m.MOV_DATA) = @ano_base
			GROUP BY MONTH(m.MOV_DATA)
		) qtde_saida
		ON mes.MES= qtde_saida.MES
 		LEFT JOIN 
		(
			SELECT MONTH(m.MOV_DATA) AS MES, COUNT(*) AS 'TOTAL'
			FROM SCE_Movimentacao m INNER JOIN SCE_Natureza_Operacao n ON m.NO_ID = n.NO_ID
			WHERE n.NO_TIPO = 4 /* 4 = log saida */
				AND YEAR(m.MOV_DATA) = @ano_base
			GROUP BY MONTH(m.MOV_DATA)
		) qtde_logsaida
		ON mes.MES= qtde_logsaida.MES
	ORDER BY mes.MES
END
