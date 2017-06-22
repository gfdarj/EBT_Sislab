	SELECT 'ALTER TABLE ' + NAME + ' DISABLE TRIGGER ALL ' --+ CHAR(13) + 'GO' + CHAR(13) 
	FROM SYSOBJECTS
	WHERE TYPE = 'U'

	SELECT 'ALTER TABLE ' + NAME + ' NOCHECK CONSTRAINT ALL ' --+ CHAR(13) + 'GO' + CHAR(13) 
	FROM SYSOBJECTS
	WHERE TYPE = 'U'





SELECT OBJECT_NAME(object_id) AS Tabela, c.name AS Coluna, t.name AS TipoDados, 'set identity_insert ' + OBJECT_NAME(object_id) + ' on' 
FROM sys.COLUMNS c INNER JOIN sys.types t ON t.system_type_id = c.system_type_id 
WHERE is_identity = 'true' ORDER BY Tabela, Coluna


