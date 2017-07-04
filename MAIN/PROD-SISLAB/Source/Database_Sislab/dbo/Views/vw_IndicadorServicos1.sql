CREATE VIEW [dbo].[vw_IndicadorServicos1]
AS
SELECT AT_NOME, cast(SUM([Dias de Eventos]) AS decimal) 
    / 82 AS Media
FROM vw_IndicadorServicos
GROUP BY at_nome
