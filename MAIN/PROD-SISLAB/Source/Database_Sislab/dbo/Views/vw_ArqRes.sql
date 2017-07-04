CREATE VIEW [dbo].[vw_ArqRes]
AS
	SELECT	a.ARQ_CodArq, a.ARQ_Link, a.ARQ_NomeArq, a.ARQ_CodArqTIPO, 
		a.ARQ_Responsavel, a.ARQ_Observacao, a.ARQ_Vinculacao, 
		a.ARQ_Versao, a.ARQ_Ocultar, a.ARQ_DataAtualizacao, a.ARQ_DataAprovacao, 
		CASE	WHEN a.ARQ_CodArqTIPO IN (SELECT tar_codtipoarquivo  FROM tipoarquivo WHERE tar_docqual = 1 and tar_codtipoarquivo not in (7,20,18)) 
			THEN convert(smalldatetime,dateAdd(YEAR, a.ARQ_VALIDACAO + 1, a.ARQ_DataAprovacao),103)
		ELSE
			NULL 
		END AS ARQ_DataExpiracao, 
		a.IPCadastro, a.UserIdCadastro, a.ARQ_Descricao, a.ARQ_IDSituacao, 
		ta.TAR_CodTipoArquivo, ta.TAR_TipoArquivo, sa.SAR_SitArquivo, 
		sa.SAR_CodSitArquivo, a.ARQ_O1, a.ARQ_O2, a.ARQ_O3
	FROM ARQUIVOS a
		INNER JOIN SituacaoArquivo sa ON a.ARQ_IDSituacao = sa.SAR_CodSitArquivo
		INNER JOIN TipoArquivo ta ON a.ARQ_CodArqTIPO = ta.TAR_CodTipoArquivo
