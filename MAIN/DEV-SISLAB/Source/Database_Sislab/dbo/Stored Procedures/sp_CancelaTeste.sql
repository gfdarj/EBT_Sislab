

CREATE  PROCEDURE [dbo].[sp_CancelaTeste]
	@pAG_NUMERO SMALLINT,
	@pAG_MOTIVO VARCHAR(7000)
AS
BEGIN
	/*** Solicita o cancelamento de um agendamento */
	SET NOCOUNT ON

	BEGIN TRANSACTION

	-- marca para cancelamento e desmarca para Remarcacao de datas
	UPDATE Agendamento
		SET AG_SOLICITOUCANCELAMENTO = 1, AG_FLAGREMARCACAO = 0
		WHERE AG_NUMERO = @pAG_NUMERO
	IF @@ERROR <> 0 BEGIN
		RAISERROR('Não foi possível marcar o agendamento para ser cancelado.', 16, 1)
		ROLLBACK TRANSACTION
		RETURN -1
	END

	-- crio uma entrada no histórico de datas para guardar o motivo do cancelamento
	SELECT AG_NUMERO FROM Historico_datas WHERE AG_NUMERO = @pAG_NUMERO
	IF @@ROWCOUNT > 0 BEGIN
		INSERT INTO Historico_datas 
			(AG_NUMERO, HD_MARCACAO, HD_DATAINICIO, HD_DATATERMINO, HD_FLAGREMARCADO, HD_MOTIVO)
			SELECT AG_NUMERO, HD_MARCACAO + 1, HD_DATAINICIO, HD_DATATERMINO, 0, 'SOLICITAÇÃO DE CANCELAMENTO' + CHAR(13) + CHAR(10) + @pAG_MOTIVO
			from historico_datas
  			where AG_NUMERO = @pAG_NUMERO and HD_MARCACAO = (SELECT max(HD_MARCACAO) FROM historico_datas WHERE AG_NUMERO = @pAG_NUMERO)
		IF @@ERROR <> 0 BEGIN
			RAISERROR('Não foi possível inserir no histórico de datas.', 16, 1)
			ROLLBACK TRANSACTION
			RETURN -1
		END
	END
	ELSE BEGIN	-- nao existem registros em Historico_Datas
		INSERT INTO Historico_datas 
			(AG_NUMERO, HD_MARCACAO, HD_DATAINICIO, HD_DATATERMINO, HD_FLAGREMARCADO, HD_MOTIVO)
			VALUES (@pAG_NUMERO , 1, GETDATE(), GETDATE(), 0, 'SOLICITAÇÃO DE CANCELAMENTO' + CHAR(13) + CHAR(10) + @pAG_MOTIVO)
		IF @@ERROR <> 0 BEGIN
			RAISERROR('Não foi possível inserir no histórico de datas.', 16, 1)
			ROLLBACK TRANSACTION
			RETURN -1
		END
	END

	COMMIT TRANSACTION
	RETURN 1
END


