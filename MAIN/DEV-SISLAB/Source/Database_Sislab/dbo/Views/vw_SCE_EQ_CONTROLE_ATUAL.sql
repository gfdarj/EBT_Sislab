CREATE VIEW [dbo].[vw_SCE_EQ_CONTROLE_ATUAL]
AS
/***
	Visao com os ultimos controles (Calibracao/Manutencao/Qualificacao)
	dos equipamentos, bem como seu prazo de vencimento

	Gilberto Almeida - COPPETEC
	30/10/2003
***/
SELECT e.EQ_ID, e.EQ_CODIGOBARRAS, e.EQ_NUMEROSERIE, e.EQ_LOCALIZACAO, 
	e.EQ_OBS, e.STATUS, e.EQ_OPER_DELTA, e.EQ_OPER_UMIDADE, e.EQ_OPER_WARMUP, 
	e.EQ_ARMA_DELTA, e.EQ_ARMA_UMIDADE, e.EQ_MANUT_PREVENTIVA, e.EQ_INSTRUMENTAL,
	e.EQ_PROPRIEDADE, e.EQ_CONFORME, m.MOD_ID, m.MOD_CODNOME, m.mod_descricao,
	f.fab_id, f.fab_nome,
	ec.EQC_DIAS, ec.EQC_DATA, ec.EQC_REGISTRO, ec.EQC_RESPONSAVEL, ec.EQC_TIPO, 
	ec.EQC_DATA + ec.EQC_DIAS AS EQC_VENCIMENTO
FROM SCE_Equipamentos e
	INNER JOIN SCE_Equipamentos_Controle ec ON
	e.EQ_ID = ec.EQ_ID
	INNER JOIN (
		SELECT ect.EQ_ID, MAX(ect.EQC_DATA) AS EQC_DATA, ect.EQC_TIPO
			FROM SCE_Equipamentos_Controle ect
			GROUP BY ect.EQ_ID, ect.EQC_TIPO
			--HAVING ect.EQC_TIPO = 'M'
	) ec1 ON 
	e.EQ_ID = ec1.EQ_ID AND ec.EQC_DATA = ec1.EQC_DATA AND ec.EQC_TIPO = ec1.EQC_TIPO
	INNER JOIN SCE_Modelos m ON 
	e.MOD_ID = m.MOD_ID
	INNER JOIN SCE_Fabricantes f ON 
	m.FAB_ID = f.fab_id
