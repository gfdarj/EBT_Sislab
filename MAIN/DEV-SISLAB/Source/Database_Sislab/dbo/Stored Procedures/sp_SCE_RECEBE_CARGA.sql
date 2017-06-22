CREATE  PROCEDURE [dbo].[sp_SCE_RECEBE_CARGA]
	@eq_id VARCHAR(8000),
	@ag_numero_dest INT,
	@user_id VARCHAR(20)
AS
BEGIN
	/***
		Recebe a carga passada por um RT à outro. Gera 2 movimentacoes, uma
		de entrada na logistica, outra de saida em nome do outro usuario

		COPPETEC: Gilberto Almeida
		Criado: 12/11/2003	Ultima alteracao:
	***/
	SET NOCOUNT ON

	BEGIN TRANSACTION

	-- pega o nome do usuario e o codigo de barras
	DECLARE @MSG VARCHAR(8000)

	IF (@eq_id IS NOT NULL) OR (@eq_id <> '') BEGIN
		DECLARE @iini INT, @fim INT, @ifim INT
		DECLARE @separa_registro VARCHAR(1), @reg VARCHAR(255)
		DECLARE @eq_codigobarras VARCHAR(20)
		DECLARE @resp_origem VARCHAR(20), @resp_destino VARCHAR(20)
		DECLARE @ag_numero_orig INT, @hoje DATETIME

		SET @hoje = GETDATE()
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

			UPDATE SCE_Passagem_Carga 
				SET PAS_APROVADO = 1, PAS_DATARECEBIMENTO = GETDATE()
				WHERE AG_NUMERO_DEST = @ag_numero_dest AND EQ_ID = CAST(@reg AS INT)
			IF @@ERROR <> 0 BEGIN
				ROLLBACK TRANSACTION
				RAISERROR( 'Não foi possível realizar o recebimento de carga.', 16, 1)
				RETURN -1
			END

			-- responsavel do ag de origem
			SELECT @resp_origem = a.AG_RESPONSAVEL, @ag_numero_orig = a.AG_NUMERO
				FROM Agendamento a INNER JOIN
				SCE_Passagem_Carga p ON a.AG_NUMERO = p.AG_NUMERO_ORIG
				WHERE AG_NUMERO_DEST = @ag_numero_dest AND p.EQ_ID = @reg

			-- responsavel do ag de destino
			SELECT @resp_destino = a.AG_RESPONSAVEL FROM Agendamento a INNER JOIN
				SCE_Passagem_Carga p ON a.AG_NUMERO = p.AG_NUMERO_DEST
				WHERE AG_NUMERO_DEST = @ag_numero_dest AND p.EQ_ID = @reg

			-- entrada log
			EXEC sp_SCE_CADASTRA_MOVIMENTACAO NULL, @reg, @hoje, 525 /*LAB - Devolução de teste no laboratório*/, @user_id, @resp_origem, 2 /*Entrada Log*/, NULL, @ag_numero_orig, 0, NULL, NULL, 1, NULL /* Localizacao do item */
			IF @@ERROR <> 0 BEGIN
				ROLLBACK TRANSACTION
				RAISERROR( 'Não foi possível movimentar a entrada dos itens.', 16, 1)
				RETURN -1
			END

			-- saida log
			EXEC sp_SCE_CADASTRA_MOVIMENTACAO NULL, @reg, @hoje, 524 /*LAB - Saída para teste c/ AS no laboratório*/, @user_id, @resp_destino, 4 /*Saida Log*/, NULL, @ag_numero_dest, 0, NULL, NULL, 1, NULL /* Localizacao do item */
			IF @@ERROR <> 0 BEGIN
				ROLLBACK TRANSACTION
				RAISERROR( 'Não foi possível movimentar a saída dos itens.', 16, 1)
				RETURN -1
			END


			-- pega o nome do usuario e o codigo de barras
			SELECT @eq_codigobarras = EQ_CODIGOBARRAS FROM SCE_Equipamentos WHERE EQ_ID = @reg

			SET @MSG = 'O usuário ' + @user_id + ' recebeu a carga do equipamento ' + @eq_codigobarras

			EXEC sp_LogEvento @user_id, 'SCE', @MSG

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

	COMMIT TRANSACTION
	RETURN 1
END
