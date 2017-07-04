CREATE PROCEDURE [dbo].[sp_SCE_CADASTRA_ACEITE_RESERVA]
	@lista_itens VARCHAR(8000),
	@ag_numero INT,
	@user_id VARCHAR(20)
AS
/*** Cadastra uma nova movimentacao ***/
BEGIN
	DECLARE @msg_erro VARCHAR(8000), @mensagem VARCHAR(8000), @eq_codigobarras VARCHAR(20)

	SET NOCOUNT ON

	BEGIN TRANSACTION

	-- loop para inserir itens movimentados
	IF @lista_itens IS NOT NULL  BEGIN

		-- a lista de campos está definida da seguinte forma: ","
		DECLARE @separa_campo VARCHAR(1)
		SET @separa_campo = ','
	
		DECLARE @reg VARCHAR(8000), @fim BIT, @iini INT, @ifim INT
		DECLARE @aceite VARCHAR(1), @eq_id VARCHAR(10)

		SET @lista_itens = RTRIM( LTRIM( @lista_itens ) )
		SET @fim = 0
		SET @iini = 1
		WHILE ( @fim = 0 ) BEGIN
			SET @ifim = PATINDEX('%' + @separa_campo + '%', @lista_itens )
			IF @ifim = 0 
				SET @reg = SUBSTRING( @lista_itens, @iini, LEN( @lista_itens ) )
			ELSE
				SET @reg = SUBSTRING( @lista_itens, @iini, @ifim - 1 )

			SET @reg = LTRIM( RTRIM( @reg ) )

			SET @aceite = LEFT( @reg, 1 )

			IF  @aceite <> '1' AND @aceite <> '0'
				SET @aceite = NULL

			SET @eq_id = SUBSTRING( @reg, 3, LEN( @reg ) )

			UPDATE SCE_Reserva_Equipamentos SET REQ_ACEITO = @aceite
				WHERE AG_NUMERO = @ag_numero AND EQ_ID = @eq_id

			IF @@ERROR <> 0 BEGIN
				ROLLBACK TRANSACTION
				SET @msg_erro = 'Não foi possível aceitar os itens da reserva do agendamento ' + CAST(@ag_numero AS VARCHAR) + '.' 
				RAISERROR( @msg_erro , 16, 1)
				RETURN -1
			END

			-- pega o nome do usuario e o codigo de barras
			SELECT @eq_codigobarras = EQ_CODIGOBARRAS FROM SCE_Equipamentos WHERE EQ_ID = @eq_id

			SET @mensagem = 'O usuário ' + @user_id + ' aceitou a reserva do equipamento ' + @eq_codigobarras + ' para o agendamento ' + CAST(@ag_numero AS VARCHAR)
			EXEC sp_LogEvento @user_id, 'SCE', @mensagem
	
			IF @@ERROR <> 0 BEGIN
				ROLLBACK TRANSACTION
				RAISERROR( 'Não foi possível inserir no histórico', 16, 1)
				RETURN -1
			END

			SET @lista_itens = LTRIM(SUBSTRING( @lista_itens, @ifim + 1, LEN( @lista_itens ) ))
			IF @ifim = 0 SET @fim = 1
		END
	END

	COMMIT TRANSACTION
	RETURN 1
END
