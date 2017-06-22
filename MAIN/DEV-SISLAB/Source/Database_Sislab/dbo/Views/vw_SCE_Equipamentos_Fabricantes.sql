
CREATE   VIEW [dbo].[vw_SCE_Equipamentos_Fabricantes] 
AS
	/***
		Visão exibindo todos os equipamentos e seus fabricantes / modelos
		Coppetec - Gilberto Almeida - 23/09/2003

		Atualizado em: 10/10/2006
	***/
	SELECT -- DISTINCT 
		e.EQ_ID, e.EQ_CODIGOBARRAS, e.EQ_CODIGOBARRASANTERIOR, e.EQ_LOCALIZACAO, e.EQ_INSTRUMENTAL, 
		e.EQ_CONFORME,m.MOD_CODNOME, m.MOD_DESCRICAO, f.FAB_ID, f.FAB_NOME, e.STATUS, e.EQ_NUMEROSERIE,
		CASE
			WHEN STATUS = 2 THEN 'Em Uso'
			WHEN STATUS = 1 THEN 'Estoque'
			WHEN STATUS = 3 THEN 'Expedido'
			WHEN STATUS = 0 THEN 'Cadastrado'
		END AS DESC_STATUS,
		e.EQ_OPER_DELTA, e.EQ_OPER_UMIDADE, e.EQ_OPER_WARMUP, e.EQ_ARMA_DELTA,
		e.EQ_ARMA_UMIDADE, e.EQ_MANUT_PREVENTIVA, e.EQ_PROPRIEDADE
	FROM	SCE_Equipamentos e INNER join sce_modelos m on e.mod_id = m.mod_id
		INNER join sce_fabricantes f on f.fab_id = m.fab_id
