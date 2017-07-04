CREATE PROCEDURE [dbo].[sp_ApagaAgendamento]
	@pAG_NUMERO INT
AS
BEGIN
	/* Apaga um Agendamento e TODAS as suas OS´s */
	SET NOCOUNT ON
	BEGIN TRANSACTION

	EXEC sp_ApagaOrdemDeServico @pAG_NUMERO, NULL
	IF @@ERROR <> 0 BEGIN
		ROLLBACK TRANSACTION
		RAISERROR( 'Não foi possível excluir as OS´s do agendamento.', 16, 1 )
		RETURN -1
	END

	DELETE from tarefas_previstas WHERE tarefa_id = @pAG_NUMERO and tarefa_tipo = 0
	IF @@ERROR <> 0 BEGIN
		ROLLBACK TRANSACTION
		RAISERROR( 'Não foi possível excluir as tarefas do agendamento.', 16, 1 )
		RETURN -1
	END

	DELETE Historico_Eventos WHERE AG_NUMERO = @pAG_NUMERO
	IF @@ERROR <> 0 BEGIN
		ROLLBACK TRANSACTION
		RAISERROR( 'Não foi possível excluir o histórico de eventos do agendamento.', 16, 1 )
		RETURN -1
	END

	DELETE Agenda_Servicos_Plataforma WHERE AG_NUMERO = @pAG_NUMERO
	IF @@ERROR <> 0 BEGIN
		ROLLBACK TRANSACTION
		RAISERROR( 'Não foi possível excluir o serviço do agendamento.', 16, 1 )
		RETURN -1
	END

	DELETE Diagramas WHERE AG_NUMERO = @pAG_NUMERO
	IF @@ERROR <> 0 BEGIN
		ROLLBACK TRANSACTION
		RAISERROR( 'Não foi possível excluir os arquivos relacionados ao agendamento.', 16, 1 )
		RETURN -1
	END

	DELETE LogBook_Agendamento WHERE AG_NUMERO = @pAG_NUMERO
	IF @@ERROR <> 0 BEGIN
		ROLLBACK TRANSACTION
		RAISERROR( 'Não foi possível excluir as ocorrências deste agendamento.', 16, 1 )
		RETURN -1
	END

	DELETE Participantes_Externos WHERE AG_NUMERO = @pAG_NUMERO
	IF @@ERROR <> 0 BEGIN
		ROLLBACK TRANSACTION
		RAISERROR( 'Não foi possível excluir os participantes externos do agendamento.', 16, 1 )
		RETURN -1
	END

	DELETE Historico_Datas WHERE AG_NUMERO = @pAG_NUMERO
	IF @@ERROR <> 0 BEGIN
		ROLLBACK TRANSACTION
		RAISERROR( 'Não foi possível excluir o histórico de datas do agendamento.', 16, 1 )
	END

	DELETE Agendamento WHERE AG_NUMERO = @pAG_NUMERO
	IF @@ERROR <> 0 BEGIN
		ROLLBACK TRANSACTION
		RAISERROR( 'Não foi possível excluir o agendamento.', 16, 1 )
		RETURN -1
	END

	COMMIT TRANSACTION
	RETURN 1
END
