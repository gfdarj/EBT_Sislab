CREATE PROCEDURE [dbo].[SP_AG_ALOCA]

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
AND  (	(
	CONVERT(DATETIME, @tp_datainicial, 103) BETWEEN TP_DATAINICIAL AND TP_DATAFINAL 
	OR CONVERT(DATETIME, @tp_datafinal, 103) BETWEEN TP_DATAINICIAL AND TP_DATAFINAL	
	)
OR 	(
	CONVERT(DATETIME, @tp_datainicial, 103) < TP_DATAINICIAL 
	AND CONVERT(DATETIME, @tp_datafinal, 103) > TP_DATAFINAL	
	)
          )

IF @@ROWCOUNT = 0 
BEGIN
	INSERT INTO TAREFAS_PREVISTAS (TAREFA_ID, TP_DATAINICIAL, TP_DATAFINAL, PES_USERNAME, TP_OBSERVACAO, TAREFA_TIPO)
	VALUES (@tarefa_id, CONVERT(DATETIME,@tp_datainicial,103), CONVERT(DATETIME,@tp_datafinal,103), @pes_username, @tp_observacao, @tarefa_tipo)
	IF @@ERROR > 0
		RETURN -1
END
ELSE
	RETURN -2  -- Periodo de Alocacao Invalido

RETURN 1 -- Alocado com sucesso



