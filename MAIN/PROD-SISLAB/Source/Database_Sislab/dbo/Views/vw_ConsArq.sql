CREATE VIEW [dbo].[vw_ConsArq]
AS
	SELECT a.AG_numero, a.AG_RESPONSAVEL, arq.ARQ_CODARQ, arq.ARQ_LINK, 
	(SELECT COUNT(HA_CODARQ) FROM HISTORICO_ARQUIVOS WHERE HA_CODARQ = arq.ARQ_CODARQ and HA_acao = 'VALIDAR') AS VALIDACAO,
	arq.ARQ_NOMEARQ, 
	arq.ARQ_CODARQTIPO, 
	arq.ARQ_RESPONSAVEL, 
	arq.ARQ_OBSERVACAO, arq.ARQ_VERSAO, 
	arq.ARQ_VINCULACAO, arq.ARQ_OCULTAR, 
	arq.ARQ_DATAAPROVACAO, 
	CASE
	WHEN arq.ARQ_CodArqTIPO IN (SELECT tar_codtipoarquivo  FROM tipoarquivo WHERE tar_docqual = 1 and tar_codtipoarquivo not in (7,20,18)) THEN 
		CASE
		WHEN arq.ARQ_CODARQ IN (SELECT HA_CODARQ FROM HISTORICO_ARQUIVOS) THEN 
				Convert(smalldatetime,(select dateAdd(YEAR,1,max(ha_dataatualizacao)) from Historico_Arquivos h 
				inner join arquivos arq1 on arq1.arq_codarq = h.ha_codarq WHERE H.HA_CODARQ = arq.ARQ_CODARQ)
					,103) 
		ELSE
			convert(smalldatetime,dateAdd(YEAR, 1, arq.ARQ_DataAprovacao),103)		
		END
	ELSE NULL
	END AS	ARQ_DATAEXPIRACAO,
	arq.ARQ_DATAATUALIZACAO, arq.IPCADASTRO, 
	arq.USERIDCADASTRO, 
	arq.ARQ_DESCRICAO, 
	arq.ARQ_NOTIFICACAOEXPIRACAO,
	TipoArquivo.TAR_TIPOARQUIVO, 
	TipoArquivo.TAR_CONFIDENCIAL, 
	arq.ARQ_IDORGAO, arq.ARQ_IDSITUACAO, 
	SituacaoArquivo.SAR_SITARQUIVO, 
	Orgao.ORGA_DESCRICAO, arq.ARQ_O1, 
	arq.ARQ_O2, arq.ARQ_O3
FROM TipoArquivo INNER JOIN SituacaoArquivo INNER JOIN Orgao INNER JOIN
	Arquivos arq ON Orgao.ORGA_ID = arq.ARQ_IDORGAO ON SituacaoArquivo.SAR_CODSITARQUIVO = arq.ARQ_IDSITUACAO
	ON TipoArquivo.TAR_CODTIPOARQUIVO = arq.ARQ_CODARQTIPO
	left JOIN DIAGRAMAS ON DIAGRAMAS.ARQ_CODARQ = arq.ARQ_CODARQ
	left JOIN AGENDAMENTO a ON DIAGRAMAS.AG_NUMERO = a.AG_NUMERO
