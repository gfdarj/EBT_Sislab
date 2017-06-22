CREATE PROCEDURE [dbo].[sp_ApagaUserCRT]
	@pUsername VARCHAR(20)
AS
BEGIN
	BEGIN TRANSACTION
	SET NOCOUNT ON 

	DELETE FROM USERCRT WHERE USERID = @pUsername
	IF @@ERROR <> 0 BEGIN
		ROLLBACK TRANSACTION
		RAISERROR('Não foi possível excluir o usuário. Possivelmente existem referências ao mesmo na base de dados.', 16, 1)
		SELECT -1 AS SAIDA, 'Não foi possível excluir o usuário. Possivelmente existem referências ao mesmo na base de dados.' AS MENSAGEM
		RETURN -1
	END

	COMMIT TRANSACTION
	SELECT 1 AS SAIDA, 'OK' AS MENSAGEM
	RETURN 1
END
