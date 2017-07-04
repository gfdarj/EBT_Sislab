

CREATE  PROCEDURE [dbo].[sp_ValidaCancelamento]
	@pAG_NUMERO SMALLINT,
	@pRESPONSAVEL VARCHAR(20),
	@pCANCELAMENTOACEITOPELORAT BIT
AS
BEGIN
	DECLARE	@Data SMALLDATETIME, 
		@Motivo VARCHAR(8000), 
		@os_id SMALLINT,
		@hd_marcacao SMALLINT

	SET @Data = GETDATE()

	/*** Valida e cancela um agendamento */
	SET NOCOUNT ON

	BEGIN TRANSACTION

	SELECT
		@Motivo = HD_MOTIVO, @hd_marcacao = HD_MARCACAO
	FROM
		Historico_Datas 
	WHERE
		AG_NUMERO = @pAG_NUMERO 
		AND HD_MARCACAO = (SELECT MAX(HD_MARCACAO) FROM Historico_Datas WHERE AG_NUMERO = @pAG_NUMERO)


	-- Indica se o RAT fez o cancelamento do pedido do usuário p/ que o agendamento
	-- fosse cancelado
	IF @pCANCELAMENTOACEITOPELORAT = 0
	BEGIN
		UPDATE Historico_Datas
		SET 
			HD_MOTIVO = 'SOLICITAÇÃO CANCELADA PELO RAT.' + CHAR(13) + CHAR(10) + @Motivo,
			HD_FLAGREMARCADO = @pCANCELAMENTOACEITOPELORAT
		WHERE AG_NUMERO = @pAG_NUMERO AND HD_MARCACAO = @hd_marcacao

		IF @@ERROR <> 0 BEGIN
			ROLLBACK TRANSACTION
			RAISERROR('Não foi possível atualizar o histórico de datas', 16, 1)
			RETURN (@@error)
		END
	END
	ELSE BEGIN

		UPDATE Historico_Datas
		SET 
			HD_FLAGREMARCADO = @pCANCELAMENTOACEITOPELORAT
		WHERE AG_NUMERO = @pAG_NUMERO AND HD_MARCACAO = @hd_marcacao

		IF @@ERROR <> 0 BEGIN
			ROLLBACK TRANSACTION
			RAISERROR('Não foi possível atualizar o histórico de datas', 16, 1)
			RETURN (@@error)
		END


		-- gravo a data no registro em aberto
		UPDATE HISTORICO_EVENTOS 
			SET HE_DATATERMINO = @Data
			WHERE AG_NUMERO = @pAG_NUMERO and HE_DATATERMINO IS NULL
		IF @@ERROR <> 0 BEGIN
			ROLLBACK TRANSACTION
			RAISERROR('Não foi possível atualizar o histórico de eventos', 16, 1)
			RETURN (@@error)
		END

		-- crio um novo evento para a situacao de cancelado
		INSERT INTO HISTORICO_EVENTOS
			(HE_RESPONSAVEL, ID_SITUACAO, AG_NUMERO, HE_DATAINICIO, HE_DATATERMINO, HE_MOTIVO)
		VALUES (@pRESPONSAVEL, 5, @pAG_NUMERO, @Data, @Data, 'CANCELADO PELO USUÁRIO')
		IF @@ERROR <> 0 BEGIN
			ROLLBACK TRANSACTION
			RAISERROR('Não foi possível inserir no histórico de eventos', 16, 1)
			RETURN (@@error)
		END


		-- cancelo as ordens de servico do agendamento que ainda nao estao em estado final
		DECLARE OS_Cursor CURSOR FOR 
			SELECT DISTINCT OS_ID FROM HISTORICO_EVENTOSOS
			WHERE AG_NUMERO = @pAG_NUMERO AND HEOS_DATATERMINO IS NULL

		OPEN OS_Cursor

		FETCH NEXT FROM OS_Cursor INTO @os_id

		WHILE @@FETCH_STATUS = 0
		BEGIN
			-- gravo a data no registro em aberto
			UPDATE HISTORICO_EVENTOSOS
				SET HEOS_DATATERMINO = @Data
				WHERE AG_NUMERO = @pAG_NUMERO and OS_ID = @os_id AND HEOS_DATATERMINO IS NULL
			IF @@ERROR <> 0 BEGIN
				ROLLBACK TRANSACTION
				RAISERROR('Não foi possível atualizar o histórico de eventos da OS', 16, 1)
				RETURN (@@error)
			END

			-- crio um novo evento para a situacao de OS cancelada
			INSERT INTO HISTORICO_EVENTOSOS (HEOS_RESPONSAVEL, AG_NUMERO, ID_SITUACAO, OS_ID, HEOS_DATAINICIO, HEOS_DATATERMINO, HEOS_MOTIVO)
			VALUES (@pRESPONSAVEL, @pAG_NUMERO, 14, @os_id, @Data, @Data, 'CANCELADO PELO USUÁRIO')
			IF @@ERROR <> 0 BEGIN
				ROLLBACK TRANSACTION
				RAISERROR('Não foi possível inserir o histórico de eventos da OS', 16, 1)
				RETURN (@@error)
			END

			FETCH NEXT FROM OS_Cursor INTO @os_id
		END

		CLOSE OS_Cursor
		DEALLOCATE OS_Cursor
	END

	-- desmarco o flag do agendamento para solicitacao de cancelamento
	UPDATE Agendamento SET AG_SOLICITOUCANCELAMENTO = 0 WHERE AG_NUMERO = @pAG_NUMERO
	IF @@ERROR <> 0 BEGIN
		ROLLBACK TRANSACTION
		RAISERROR('Não foi possível atualizar o agendamento', 16, 1)
		RETURN (@@error)
	END

	COMMIT TRANSACTION
 	RETURN 1
END


