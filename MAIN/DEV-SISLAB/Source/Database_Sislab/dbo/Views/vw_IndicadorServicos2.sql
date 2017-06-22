CREATE VIEW [dbo].[vw_IndicadorServicos2]
AS
SELECT AG_Responsavel, cast(SUM([Dias de Eventos]) 
    AS decimal) / 82 AS Media
FROM vw_IndicadorServicos
GROUP BY ag_responsavel

