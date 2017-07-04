CREATE PROCEDURE [dbo].[sp_SCE_INDICADOR_MENSAL_VALOR_NOTAFISCAL]
	@ano_base INT
AS
BEGIN
	/*
	Retorna um SELECT com os totais de notas fiscais de entrada e de
	saída em um dado ano.

	Criado em: 16/02/2004 - Gilberto F. Almeida - COPPETEC
	*/
	SELECT
		mes.MES, 
		CASE WHEN qtde_entrada.TOTAL IS NULL THEN 0 ELSE qtde_entrada.TOTAL END AS ENTRADA, 
		CASE WHEN qtde_saida.TOTAL IS NULL THEN 0 ELSE qtde_saida.TOTAL END AS SAIDA
	FROM
		(
		SELECT 1 AS MES UNION SELECT 2 UNION SELECT 3 UNION SELECT 4 UNION SELECT 5 
		UNION SELECT 6 UNION SELECT 7 UNION SELECT 8 UNION SELECT 9 UNION SELECT 10
		UNION SELECT 11 UNION SELECT 12
		) mes
	 	LEFT JOIN 
		(
			SELECT MONTH(NF_RECEBIMENTO) AS MES, SUM(NF_VALORTOTAL) AS 'TOTAL'
			FROM SCE_Nota_Fiscal nf
			WHERE nf.NF_TIPO = 1 /* 1 = entrada / 2 = saida */
				AND YEAR(nf.NF_RECEBIMENTO) = @ano_base
			GROUP BY MONTH(nf.NF_RECEBIMENTO)
		) qtde_entrada
		ON mes.MES= qtde_entrada.MES
 		LEFT JOIN 
		(
			SELECT MONTH(NF_RECEBIMENTO) AS MES, SUM(NF_VALORTOTAL) AS 'TOTAL'
			FROM SCE_Nota_Fiscal nf 
			WHERE nf.NF_TIPO = 2 /* 1 = entrada / 2 = saida */
				AND YEAR(nf.NF_RECEBIMENTO) = @ano_base
			GROUP BY MONTH(nf.NF_RECEBIMENTO)
		) qtde_saida
		ON mes.MES= qtde_saida.MES
	ORDER BY mes.MES
END
