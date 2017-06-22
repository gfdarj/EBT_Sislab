CREATE PROCEDURE [dbo].[SP_AG_RELOCA]

@tp_id			INT,
@tarefa_id		SMALLINT,
@tp_datainicial		VARCHAR(10),
@tp_datafinal		VARCHAR(10),
@pes_username	VARCHAR(10),
@tp_observacao	VARCHAR(8000),
@tarefa_tipo		BIT

AS

SET NOCOUNT ON

SELECT TP_ID FROM TAREFAS_PREVISTAS
WHERE 
	PES_USERNAME = @pes_username 
AND	TAREFA_ID = @tarefa_id
AND	TAREFA_TIPO = @tarefa_tipo
AND 	TP_ID <> @tp_id
AND (	(
	CONVERT(DATETIME, @tp_datainicial, 103) BETWEEN TP_DATAINICIAL AND TP_DATAFINAL 
	OR CONVERT(DATETIME, @tp_datafinal, 103) BETWEEN TP_DATAINICIAL AND TP_DATAFINAL	
	)
OR 	(
	CONVERT(DATETIME, @tp_datainicial, 103) < TP_DATAINICIAL 
	AND CONVERT(DATETIME, @tp_datafinal, 103) > TP_DATAFINAL	
	)
         )


IF @@ROWCOUNT > 0 
	RETURN -2  -- Periodo de Alocacao Invalido
ELSE
BEGIN
	UPDATE TAREFAS_PREVISTAS 
	SET 
		TAREFA_ID = @tarefa_id,
		TP_DATAINICIAL = CONVERT(DATETIME,@tp_datainicial,103), 
		TP_DATAFINAL = CONVERT(DATETIME,@tp_datafinal,103), 
		PES_USERNAME = @pes_username, 
		TP_OBSERVACAO = @tp_observacao, 
		TAREFA_TIPO = @tarefa_tipo
	WHERE TP_ID = @tp_id
	IF @@ERROR > 0
		RETURN -1
	ELSE
		RETURN 1 -- Alocado com sucesso
END
