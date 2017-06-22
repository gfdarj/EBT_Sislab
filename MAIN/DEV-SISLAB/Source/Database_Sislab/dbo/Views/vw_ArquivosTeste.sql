
CREATE VIEW [dbo].[vw_ArquivosTeste]
AS
SELECT dbo.Diagramas.AG_Numero, 
    dbo.Diagramas.ARQ_CodArq, 
    dbo.ARQUIVOS.ARQ_Link, 
    dbo.ARQUIVOS.ARQ_NomeArq, 
    dbo.ARQUIVOS.ARQ_CodArqTIPO, 
    dbo.TipoArquivo.TAR_TipoArquivo, 
    dbo.ARQUIVOS.ARQ_Responsavel, 
    dbo.ARQUIVOS.ARQ_DataAtualizacao,
    dbo.SituacaoArquivo.SAR_SitArquivo
FROM dbo.Diagramas INNER JOIN
    dbo.ARQUIVOS ON 
    dbo.Diagramas.ARQ_CodArq = dbo.ARQUIVOS.ARQ_CodArq
     INNER JOIN
    dbo.TipoArquivo ON 
    dbo.ARQUIVOS.ARQ_CodArqTIPO = dbo.TipoArquivo.TAR_CodTipoArquivo
     INNER JOIN
    dbo.SituacaoArquivo ON 
    dbo.ARQUIVOS.ARQ_IDSituacao = dbo.SituacaoArquivo.SAR_CodSitArquivo


