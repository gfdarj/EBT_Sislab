CREATE PROCEDURE [dbo].[SP_AG_REMOVE] 

@tp_id		INT

AS

DELETE FROM TAREFAS_PREVISTAS WHERE TP_ID=@tp_id
IF @@ERROR > 0
	RETURN -1
ELSE
	RETURN 1 -- Removido com sucesso

