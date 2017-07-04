CREATE VIEW [dbo].[vw_SCE_Equipamentos_a_PassarCarga]
AS
	/***
	Visao que pega os equipamentos que podem ser passados como carga a outro técnico.

	OBS: Tive que fazer esta visão pois o código utilizado no form ASP não estava funcionando
	de acordo devido a existência de um NOT EXISTS. Eu não sei o problema que acontecia, mas
	ao criar esta view e realizar o join e o not exists a query funcionou aparentemente direito.

	Gilberto Almeida - 05/02/2004
	***/
	SELECT e.EQ_ID, e.EQ_CODIGOBARRAS, e.MOD_CODNOME, e.MOD_DESCRICAO, u.NOME AS NOME_RESPONSAVEL, RESERVA, a.AG_NUMERO
	FROM vw_SCE_Movimentacao_Atual m 
		INNER JOIN vw_SCE_Equipamentos_Fabricantes e ON m.EQ_ID = e.EQ_ID 
		INNER JOIN SCE_Natureza_Operacao no1 ON m.NO_ID = no1.NO_ID 
		INNER JOIN Agendamento a ON a.AG_NUMERO = m.ASA 
		INNER JOIN UserCRT u ON u.USERID = a.AG_RESPONSAVEL 
	WHERE 	(no1.ASA = 1) AND (no1.NO_TIPO = 4) /* Possui AS e Natureza Op = Saida Logistica */
