CREATE PROCEDURE [dbo].[sp_SCE_EXCLUI_RESERVA]
	@ag_numero INT,
	@user_id VARCHAR(50)
AS
/*** Remove uma reserva de equipamentos ***/
BEGIN
	SET NOCOUNT ON
	BEGIN TRANSACTION

	DECLARE @user_nome VARCHAR(255), @as INT

	IF @ag_numero IS NOT NULL BEGIN

		DELETE FROM SCE_Reserva_Equipamentos WHERE AG_NUMERO = @ag_numero
		IF @@error <> 0
		BEGIN
			ROLLBACK TRANSACTION
			RAISERROR( 'Não foi possível excluir os itens da reserva', 16, 1)
			RETURN -1
		END

		DELETE FROM SCE_Reserva WHERE AG_NUMERO = @ag_numero
		IF @@error <> 0
		BEGIN
			ROLLBACK TRANSACTION
			RAISERROR( 'Não foi possível excluir a reserva de equipamentos', 16, 1)
			RETURN -1
		END

		-- histórico da operação
		SELECT @user_nome = USER_NOME FROM SCE_Usuarios WHERE USER_ID = @user_id

		INSERT INTO SCE_Historico (ID_USUARIO, ACAO, DATA)
			VALUES (@user_id, 'O usuário ' + @user_nome + ' excluiu a reserva de equipamentos para a AS ' + CAST(@ag_numero as VARCHAR) + '.', GETDATE())
		IF @@error <> 0
		BEGIN
			ROLLBACK TRANSACTION
			RAISERROR( 'Não foi registrar o histórico de exclusão da reserva', 16, 1)
			RETURN -1
		END
	END
	ELSE BEGIN
		ROLLBACK TRANSACTION
		RAISERROR( 'O código da reserva é inválido', 16, 1)
		RETURN -1
	END

	COMMIT TRANSACTION
	RETURN 1
END
