CREATE VIEW [dbo].[vw_consLogBook]
AS
SELECT dbo.LB_TipoOcorrencia.LBTO_DESCRICAO, 
    dbo.UserCRT.NOME, dbo.LB_LogBook.*
FROM dbo.LB_LogBook INNER JOIN
    dbo.LB_TipoOcorrencia ON 
    dbo.LB_LogBook.LBTO_ID = dbo.LB_TipoOcorrencia.LBTO_ID LEFT
     OUTER JOIN
    dbo.UserCRT ON 
    dbo.LB_LogBook.LB_RESPEXEC = dbo.UserCRT.USERID
