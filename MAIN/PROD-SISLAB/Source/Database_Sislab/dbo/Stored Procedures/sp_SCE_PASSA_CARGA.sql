CREATE PROCEDURE [dbo].[sp_SCE_PASSA_CARGA]
	@eq_id VARCHAR(8000),
	@ag_numero_orig INT,
	@ag_numero_dest INT,
	@user_id VARCHAR(20)
AS
BEGIN
	/***
		Cadastra uma passagem de carga (equipamentos) de uma AS para outra.
		Posteriormente quando o RT da AS destino receber a carga, sera gerada
		uma movimentacao de entrada no LOG e outra de saida para o novo RT

		COPPETEC: Gilberto Almeida
		Criado: 11/11/2003	Ultima alteracao: 18/04/2012
	***/
	SET NOCOUNT ON

	DECLARE @MSG VARCHAR(8000)

	BEGIN TRANSACTION

	-- Apago a passagem de carga que ainda nao foi aprovada pelo usuario
	DELETE FROM SCE_Passagem_Carga WHERE AG_NUMERO_ORIG = @ag_numero_orig AND PAS_APROVADO = 0
	IF @@ERROR <> 0 BEGIN
		ROLLBACK TRANSACTION
		RAISERROR( 'Não foi possível remover passagem de carga.', 16, 1)
		RETURN -1
	END

	IF (@eq_id IS NOT NULL) OR (@eq_id <> '') BEGIN
		DECLARE @iini INT, @fim INT, @ifim INT
		DECLARE @separa_registro VARCHAR(1), @reg VARCHAR(255)
		DECLARE @eq_codigobarras VARCHAR(20)

		SET @separa_registro = ','

		SET @eq_id = rtrim(ltrim( @eq_id ))
		SET @fim = 0
		SET @iini = 1
		WHILE ( @fim = 0 ) BEGIN
			SET @ifim = PATINDEX('%' + @separa_registro + '%', @eq_id )
			IF @ifim = 0 
				SET @reg = SUBSTRING( @eq_id, @iini, LEN( @eq_id ) )
			ELSE
				SET @reg = SUBSTRING( @eq_id, @iini, @ifim - 1 )

			INSERT INTO SCE_Passagem_Carga ( AG_NUMERO_ORIG, AG_NUMERO_DEST, EQ_ID, PAS_APROVADO )
				VALUES ( @ag_numero_orig, @ag_numero_dest, @reg, 0 )
			IF @@ERROR <> 0 BEGIN
				ROLLBACK TRANSACTION
				RAISERROR( 'Não foi possível solicitar a passagem de carga.', 16, 1)
				RETURN -1
			END

			-- pega o nome do usuario e o codigo de barras
			SELECT @eq_codigobarras = EQ_CODIGOBARRAS FROM SCE_Equipamentos WHERE EQ_ID = @reg

			SET @MSG = 'O usuário ' + @user_id + ' passou a carga do equipamento ' + @eq_codigobarras

			EXEC sp_LogEvento @USER_ID, 'SCE', @MSG

			IF @@ERROR <> 0 BEGIN
				ROLLBACK TRANSACTION
				RAISERROR( 'Não foi possível inserir no histórico', 16, 1)
				RETURN -1
			END
			--

			SET @eq_id = LTRIM(SUBSTRING( @eq_id, @ifim + 1, LEN( @eq_id ) ))
			IF @ifim = 0 SET @fim = 1
		END
	END
	ELSE BEGIN

		SET @MSG = 'O usuário ' + @user_id + ' removeu a carga do agendamento ' + CAST(@ag_numero_orig as VARCHAR)

		EXEC sp_LogEvento @USER_ID, 'SCE', @MSG

		IF @@ERROR <> 0 BEGIN
			ROLLBACK TRANSACTION
			RAISERROR( 'Não foi possível inserir no histórico', 16, 1)
			RETURN -1
		END
	END

	COMMIT TRANSACTION
	RETURN 1
END
