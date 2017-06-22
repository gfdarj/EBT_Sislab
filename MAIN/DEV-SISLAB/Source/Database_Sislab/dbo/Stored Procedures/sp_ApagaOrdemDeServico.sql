


CREATE  PROCEDURE [dbo].[sp_ApagaOrdemDeServico]
	@pAG_NUMERO INT,
	@pOS_ID INT
AS
BEGIN
	DECLARE @int_REPETICAO_AS BIT,
		@int_Linha INT

	/* Apaga uma ou todas as Ordens de Servico para um Agendamento */
	BEGIN TRANSACTION
	SET NOCOUNT ON

	IF @pOS_ID IS NULL BEGIN
		SET @int_REPETICAO_AS = 0

		DELETE Historico_EventosOS WHERE AG_NUMERO = @pAG_NUMERO
		IF @@ERROR <> 0 BEGIN
			ROLLBACK TRANSACTION
			RAISERROR( 'Não foi possível excluir o histórico de eventos da OS.', 16, 1 )
			SELECT -1 AS SAIDA
			RETURN -1
		END

		DELETE Ordem_de_Servico WHERE AG_NUMERO = @pAG_NUMERO
		IF @@ERROR <> 0 BEGIN
			ROLLBACK TRANSACTION
			RAISERROR( 'Não foi possível excluir as OS´s do agendamento.', 16, 1 )
			SELECT -1 AS SAIDA
			RETURN -1
		END
	END
	ELSE BEGIN
		DELETE Historico_EventosOS WHERE AG_NUMERO = @pAG_NUMERO AND OS_ID = @pOS_ID
		IF @@ERROR <> 0 BEGIN
			ROLLBACK TRANSACTION
			RAISERROR( 'Não foi possível excluir o histórico de eventos da OS.', 16, 1 )
			SELECT -1 AS SAIDA
			RETURN -1
		END

		DELETE Ordem_de_Servico WHERE AG_NUMERO = @pAG_NUMERO AND OS_ID = @pOS_ID
		IF @@ERROR <> 0 BEGIN
			ROLLBACK TRANSACTION
			RAISERROR( 'Não foi possível excluir as OS´s do agendamento.', 16, 1 )
			SELECT -1 AS SAIDA
			RETURN -1
		END


		-->>> conto quantas OS marcadas para repetição existem
		SELECT TOP 1
			@int_Linha = COUNT(*)
		FROM
			vw_OrdemDeServico OS
		WHERE
			OS.AG_NUMERO = @pAG_NUMERO
		AND
			OS_FLAGREPETICAO = 1

		IF @int_Linha > 0
			SET @int_REPETICAO_AS = 1
		ELSE
			SET @int_REPETICAO_AS = 0
	END


	-->>> atualizo o agendamento, marcando o mesmo com o FLAG de repetição
	UPDATE
		Agendamento
	SET
		AG_REPETIDO = @int_REPETICAO_AS
	WHERE
		AG_NUMERO = @pAG_NUMERO
 	IF @@ERROR  <> 0 BEGIN
		ROLLBACK TRANSACTION
		RAISERROR( 'Não foi possível atualizar o agendamento.', 16, 1 )
		SELECT -1 AS SAIDA
		RETURN -1
	END


	COMMIT TRANSACTION
	SELECT 1 AS SAIDA
	RETURN 1
END
