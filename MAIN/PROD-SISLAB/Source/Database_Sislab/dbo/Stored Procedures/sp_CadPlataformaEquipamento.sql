CREATE PROCEDURE [dbo].[sp_CadPlataformaEquipamento]
	@pS_ID SMALLINT,
	@pEQ_ID_LISTA VARCHAR(8000)
AS
BEGIN
	BEGIN TRANSACTION
	SET NOCOUNT ON 

	DECLARE @msg VARCHAR(8000)
	DECLARE @Hoje DATETIME
	DECLARE @Dados VARCHAR(8000)
	DECLARE @reg VARCHAR(8000)
	DECLARE @separa_registro VARCHAR(1)
	DECLARE @fim INT
	DECLARE @ifim INT
	DECLARE @iini INT
	DECLARE @qtd_Lista INT

	SET @Hoje = GETDATE()

	IF (@pS_ID IS NULL) OR (@pS_ID = 0) BEGIN
		ROLLBACK TRANSACTION
		SET @msg = 'Nenhuma plataforma informada'
		RAISERROR(@msg, 16, 1)
		SELECT -1 AS SAIDA, @msg AS MENSAGEM
		RETURN -1
	END
	ELSE BEGIN
		-- passo a lista de strings para uma tabela temporaria
		CREATE TABLE #EQ_Lista (
			EQ_ID INT
		)

		IF @pEQ_ID_LISTA IS NOT NULL
		BEGIN
			SET @DADOS = rtrim(ltrim(@pEQ_ID_LISTA))
			SET @separa_registro = ','

			SET @fim = 0
			SET @iini = 1

			WHILE ( @fim = 0 ) BEGIN
				SET @ifim = PATINDEX('%' + @separa_registro + '%', @DADOS )
				IF @ifim = 0 begin
					SET @reg = SUBSTRING( @DADOS, @iini, LEN( @DADOS ) )
				END
				ELSE begin
					SET @reg = SUBSTRING( @DADOS, @iini, @ifim - 1 )
				END

				IF @reg IS NOT NULL OR @reg <> ''
				BEGIN
					INSERT INTO #EQ_Lista (EQ_ID) VALUES (CAST(@reg AS INT))
					IF @@ERROR <> 0 BEGIN
						ROLLBACK TRANSACTION
						SELECT -1 AS SAIDA, 'Não foi possível operar lista de equipamentos da plataforma' AS MENSAGEM
						RETURN -1
					END
				END

				SET @DADOS = LTRIM(SUBSTRING( @DADOS, @ifim + len(@separa_registro), LEN(@DADOS) ))
				IF @ifim = 0 SET @fim = 1
			END

			-- esta na base, mas nao esta na lista - FACO A SAIDA DO EQUIPAMENTO
			INSERT INTO Historico_Plataforma_Equipamentos
				SELECT @Hoje, 'S', EQ_ID, S_ID FROM Plataforma_Equipamentos
				WHERE S_ID = @pS_ID AND EQ_ID NOT IN (SELECT EQ_ID FROM #EQ_Lista)
			IF @@ERROR <> 0 BEGIN
				ROLLBACK TRANSACTION
				SELECT -1 AS SAIDA, 'Não foi possível operar lista de equipamentos da plataforma' AS MENSAGEM
				RETURN -1
			END

			-- esta na lista, e nao esta na base
			INSERT INTO Historico_Plataforma_Equipamentos
				-- lista de equipamentos sendo incluidos
				SELECT @Hoje, 'E', e.EQ_ID, @pS_ID FROM #EQ_Lista e
				WHERE NOT EXISTS (
					SELECT pe1.EQ_ID FROM Plataforma_Equipamentos pe1
					WHERE pe1.S_ID = @pS_ID AND e.EQ_ID = pe1.EQ_ID
				)
			IF @@ERROR <> 0 BEGIN
				ROLLBACK TRANSACTION
				SELECT -1 AS SAIDA, 'Não foi possível operar lista de equipamentos da plataforma' AS MENSAGEM
				RETURN -1
			END
		END
		ELSE BEGIN
			-- esta na base, mas nao esta na lista - FACO A SAIDA DO EQUIPAMENTO
			INSERT INTO Historico_Plataforma_Equipamentos
				SELECT @Hoje, 'S', EQ_ID, S_ID FROM Plataforma_Equipamentos
				WHERE S_ID = @pS_ID
			IF @@ERROR <> 0 BEGIN
				ROLLBACK TRANSACTION
				SELECT -1 AS SAIDA, 'Não foi possível operar lista de equipamentos da plataforma' AS MENSAGEM
				RETURN -1
			END
		END


		-- apago os equipamentos da plataforma
		DELETE FROM PLATAFORMA_EQUIPAMENTOS WHERE S_ID = @pS_ID
		IF @@ERROR <> 0 BEGIN
			ROLLBACK TRANSACTION
			SET @msg = 'Não foi possível excluir os equipamentos desta plataforma'
			RAISERROR(@msg, 16, 1)
			SELECT -1 AS SAIDA, @msg AS MENSAGEM
			RETURN -1
		END

		-- se lista vazia entao estou removendo os equipamentos
		IF @pEQ_ID_LISTA IS NOT NULL
		BEGIN
			INSERT INTO PLATAFORMA_EQUIPAMENTOS
				SELECT @pS_ID, EQ_ID FROM #EQ_Lista
			IF @@ERROR <> 0 BEGIN
				ROLLBACK TRANSACTION
				SELECT -1 AS SAIDA, 'Não foi possível cadastrar os equipamentos da plataforma' AS MENSAGEM
				RETURN -1
			END
		END

		DROP TABLE #EQ_Lista

		COMMIT TRANSACTION
		SELECT 1 AS SAIDA, 'OK' AS MENSAGEM
		RETURN 1
	END
END
