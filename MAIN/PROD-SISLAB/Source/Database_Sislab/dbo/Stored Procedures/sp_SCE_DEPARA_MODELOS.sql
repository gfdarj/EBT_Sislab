CREATE PROCEDURE [dbo].[sp_SCE_DEPARA_MODELOS]
	@mod_id_old INT,
	@mod_id_new INT
AS
BEGIN
	/* DE - PARA de modelos */
	SET NOCOUNT ON
	BEGIN TRANSACTION

	UPDATE SCE_Equipamentos SET MOD_ID = @mod_id_new WHERE MOD_ID = @mod_id_old
	IF @@ERROR <> 0 BEGIN
		ROLLBACK TRANSACTION
		RAISERROR('Não foi possível atualizar os equipamentos', 16, 1)
		RETURN -1
	END

	DELETE FROM SCE_Modelos WHERE MOD_ID = @mod_id_old
	IF @@ERROR <> 0 BEGIN
		ROLLBACK TRANSACTION
		RAISERROR('Não foi possível excluir o modelo antigo', 16, 1)
		RETURN -1
	END

	COMMIT TRANSACTION
	RETURN 1
END
