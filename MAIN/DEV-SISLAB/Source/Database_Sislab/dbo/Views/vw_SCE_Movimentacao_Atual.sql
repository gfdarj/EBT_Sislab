
CREATE  VIEW [dbo].[vw_SCE_Movimentacao_Atual]
AS
	/**
		Exibe a ultima movimentacao dos itens.
		Criada em: 07/11/2003 - Gilberto Almeida
		Ultima alteracao:
	**/
	SELECT m.*, LEFT(CONVERT(VARCHAR, m.MOV_DATA, 114),8) AS MOV_HORA
	FROM SCE_Movimentacao m INNER JOIN
	(
		SELECT m1.EQ_ID, MAX(m1.MOV_ID) AS MOV_ID
		FROM SCE_Movimentacao m1 INNER JOIN (
			SELECT EQ_ID, MAX(MOV_DATA) AS MOV_DATA FROM SCE_Movimentacao
			--WHERE nf_id = 6251 -- EQ_ID = 16667
			GROUP BY EQ_ID
		) m2 ON (m1.EQ_ID = m2.EQ_ID AND m1.MOV_DATA = m2.MOV_DATA)
		GROUP BY m1.EQ_ID
	)
	mm ON (m.MOV_ID = mm.MOV_ID)
