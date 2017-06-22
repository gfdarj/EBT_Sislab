CREATE VIEW [dbo].[vw_IndicadorServicos]
AS
SELECT AG_Numero, AT_NOME, AG_DATAINICIO, 
    AG_DATATERMINO, A.AG_Responsavel, 
    CASE WHEN ((AG_DataInicio <= '09 apr 2003') AND 
    (AG_DataTermino <= '30 jun 2003')) 
    THEN cast(SUM(datediff(day, '09 apr 2003', 
    AG_DATATERMINO)) AS decimal) 
    WHEN ((AG_DataInicio <= '09 apr 2003') AND 
    (AG_DataTermino > '30 jun 2003')) THEN (82) 
    WHEN ((AG_DataInicio > '09 apr 2003') AND 
    (AG_DataTermino <= '30 jun 2003')) 
    THEN cast(SUM(datediff(day, AG_DATAINICIO, 
    AG_DATATERMINO)) AS decimal) 
    WHEN ((AG_DataInicio > '09 apr 2003') AND 
    (AG_DataTermino > '30 jun 2003')) 
    THEN cast(SUM(datediff(day, AG_DATAINICIO, '30 jun 2003')) 
    + 1 AS decimal) END AS [Dias de Eventos], cast(datediff(day, 
    AG_DATAINICIO, AG_DATATERMINO) AS decimal) 
    AS TotalDias
FROM Agendamento A LEFT JOIN
    Area_Tecnologica ATE ON ATE.AT_ID = A.AT_ID
WHERE ((AG_DataTermino BETWEEN dateadd(month, - 3, 
    '30 jun 2003') AND '30 jun 2003') OR
    (AG_DataInicio BETWEEN dateadd(month, - 3, '30 jun 2003') 
    AND '30 jun 2003') OR
    ((AG_DataInicio < dateadd(month, - 3, '30 jun 2003')) AND 
    (Ag_DataTermino > '30 jun 2003'))) AND 
    NOT (A.AG_Responsavel = 'cterra' OR
    A.AG_Responsavel = 'storres' OR
    A.AG_Responsavel = 'dppon' OR
    A.AG_Responsavel = 'antunes' OR
    A.AG_Responsavel = 'josesp' OR
    A.AG_Responsavel = 'crcunha' OR
    A.AG_Responsavel = 'vidal' OR
    (A.AG_Responsavel IS NULL)) AND 
    NOT (AG_DATATERMINO < '09 apr 2003')
GROUP BY ATE.AT_Nome, A.ag_responsavel, AG_DATAINICIO, 
    AG_DATATERMINO, AG_Numero
