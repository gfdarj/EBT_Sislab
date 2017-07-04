
CREATE VIEW [dbo].[vw_SCE_Equipamentos]
AS
/***
	Visão de contendo a UNIÃO de todos os itens ( Equipamentos e Consumiveis )

	Gilberto Almeida - COPPETEC
	Criado em: 27/08/2003
	Alterada em: 05/04/2012 - retirado as referencias de consumiveis
***/
SELECT
	e.EQ_ID as ID, NULL as COD_SGP, e.EQ_LOCALIZACAO, 
	cast(e.EQ_OBS as varchar(8000)) as EQ_OBS, 
	e.MOD_ID, null AS EQ_SGP, e.EQ_CODIGOBARRAS, e.EQ_CODIGOBARRASANTERIOR, e.EQ_NUMEROSERIE, 
	e.STATUS, e.EQ_PROPRIEDADE, e.EQ_OPER_DELTA,
	e.EQ_OPER_UMIDADE, e.EQ_OPER_WARMUP, e.EQ_ARMA_DELTA, e.EQ_ARMA_UMIDADE, 
	cast(e.EQ_MANUT_PREVENTIVA as varchar(8000)) as EQ_MANUT_PREVENTIVA, 
	e.EQ_INSTRUMENTAL, e.EQ_CONFORME,
	null as NF_ID, null as CON_UNIDADE, null as CON_MODELO_PN, 
	null as CON_ESTOQUE, 
	null as con_uso, null as con_desc, 
	e.EQ_DT_ULT_INVENTARIO, 
	EQ_FREQ_CALIBRACAO
FROM
	SCE_Equipamentos e
