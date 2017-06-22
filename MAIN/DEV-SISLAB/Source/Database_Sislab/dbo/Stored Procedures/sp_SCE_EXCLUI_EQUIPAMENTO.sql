
CREATE PROCEDURE [dbo].[sp_SCE_EXCLUI_EQUIPAMENTO]
	@eq_id INT,
	@user_id VARCHAR(50)
AS
/*** Remove um equipamento consumivel bem como suas movimentações ***/
BEGIN
	SET NOCOUNT ON
	BEGIN TRANSACTION

-- teste de Erro !!!!
--ROLLBACK TRANSACTION
--RAISERROR( 'Não foi possível EXCLUIR equipamento', 16, 1)
--RETURN -1

	DECLARE @cod_barras VARCHAR(255), @user_nome VARCHAR(255)

	IF @eq_id IS NOT NULL BEGIN
		DELETE FROM SCE_Historico_Movimentacao WHERE EQ_ID = @eq_id
		IF @@error <> 0
		BEGIN
			ROLLBACK TRANSACTION
			RAISERROR( 'Não foi possível excluir o histórico de movimentações deste equipamento', 16, 1)
			RETURN -1
		END

		DELETE FROM SCE_Movimentacao WHERE EQ_ID = @eq_id
		IF @@error <> 0
		BEGIN
			ROLLBACK TRANSACTION
			RAISERROR( 'Não foi possível excluir as movimentações deste equipamento', 16, 1)
			RETURN -1
		END

		DELETE FROM SCE_Equipamentos_Controle WHERE EQ_ID = @eq_id
		IF @@error <> 0
		BEGIN
			ROLLBACK TRANSACTION
			RAISERROR( 'Não foi possível excluir os controles de calibração/manutenção/qualificação do equipamento', 16, 1)
			RETURN -1
		END

		DELETE FROM SCE_Acessorios WHERE EQ_ID = @eq_id
		IF @@error <> 0
		BEGIN
			ROLLBACK TRANSACTION
			RAISERROR( 'Não foi possível excluir os acessórios do equipamento', 16, 1)
			RETURN -1
		END

		SELECT @cod_barras = EQ_CODIGOBARRAS FROM SCE_Equipamentos WHERE EQ_ID = @eq_id

		DELETE FROM SCE_Equipamentos WHERE EQ_ID = @eq_id
		IF @@error <> 0
		BEGIN
			ROLLBACK TRANSACTION
			RAISERROR( 'Não foi possível excluir este equipamento', 16, 1)
			RETURN -1
		END

		-- histórico da operação
		SELECT @user_nome = USER_NOME FROM SCE_Usuarios WHERE USER_ID = @user_id

		INSERT INTO SCE_Historico (ID_USUARIO, ACAO, DATA)
			VALUES (@user_id, 'O usuário ' + @user_nome + ' excluiu o equipamento ' + @cod_barras + '.', GETDATE())
		IF @@error <> 0
		BEGIN
			ROLLBACK TRANSACTION
			RAISERROR( 'Não foi registrar o histórico de exclusão do equipamento', 16, 1)
			RETURN -1
		END
	END
	ELSE BEGIN
		ROLLBACK TRANSACTION
		RAISERROR( 'O código do equipamento consumível é inválido', 16, 1)
		RETURN -1
	END

	COMMIT TRANSACTION
	RETURN 1
END
