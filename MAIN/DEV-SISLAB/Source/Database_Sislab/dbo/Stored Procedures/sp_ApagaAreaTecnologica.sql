CREATE PROCEDURE [dbo].[sp_ApagaAreaTecnologica]
	@pId SMALLINT
AS
BEGIN
	BEGIN TRANSACTION
	SET NOCOUNT ON 

	DELETE FROM Area_tecnologica WHERE AT_ID = @pID
	IF @@ERROR <> 0 BEGIN
		ROLLBACK TRANSACTION
		RAISERROR('Não foi possível excluir a área tecnológica. Possivelmente existem referências à mesma na base de dados.', 16, 1)
		SELECT -1 AS SAIDA, 'Não foi possível excluir o usuário. Possivelmente existem referências à mesma na base de dados.' AS MENSAGEM
		RETURN -1
	END

	COMMIT TRANSACTION
	SELECT 1 AS SAIDA, 'OK' AS MENSAGEM
	RETURN 1
END
