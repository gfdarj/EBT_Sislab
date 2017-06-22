CREATE PROCEDURE [dbo].[sp_SCE_EXCLUI_MOVIMENTACAO]
	@mov_id INT,
	@user_id INT
AS
	/*** Apago uma nova movimentacao existente ***/
BEGIN
	DECLARE @msg_erro VARCHAR(8000), @user_nome VARCHAR(100), @eq_codigobarras VARCHAR(20)

	SET NOCOUNT ON

	BEGIN TRANSACTION

	-- pega o nome do usuario e o codigo de barras
	SELECT @user_nome = USER_NOME FROM SCE_Usuarios WHERE USER_ID = @user_id
	SELECT @eq_codigobarras = EQ_CODIGOBARRAS FROM SCE_Equipamentos 
		WHERE EQ_ID = (SELECT EQ_ID FROM SCE_Movimentacao WHERE MOV_ID = @mov_id)

	IF @mov_id IS NOT NULL BEGIN
		DELETE FROM SCE_Movimentacao WHERE MOV_ID = @mov_id
		IF @@ERROR <> 0 BEGIN
			ROLLBACK TRANSACTION
			RAISERROR( 'Não foi possível apagar esta movimentação', 16, 1)
			RETURN -1
		END
	END


	SET @msg_erro = 'O usuário ' + @user_nome + ' apagou o movimento #' + CAST(@mov_id AS VARCHAR) + ' do equipamento ' + @eq_codigobarras + '.'

	INSERT INTO SCE_Historico ( ID_USUARIO, ACAO, DATA ) 
		VALUES ( @user_id, @msg_erro, CONVERT( VARCHAR, GETDATE(), 103) )
	IF @@ERROR <> 0 BEGIN
		ROLLBACK TRANSACTION
		RAISERROR( 'Não foi possível inserir no histórico', 16, 1)
		RETURN -1
	END

	COMMIT TRANSACTION
	RETURN 1
END
