CREATE PROCEDURE [dbo].[sp_ApagaTecnologia]
	@pId SMALLINT
AS
BEGIN
	BEGIN TRANSACTION
	SET NOCOUNT ON 

	DELETE FROM Tecnologia WHERE TEC_ID = @pId
	IF @@ERROR <> 0 BEGIN
		ROLLBACK TRANSACTION
		RAISERROR('Não foi possível excluir a tecnologia. Possivelmente existem referências na base de dados.', 16, 1)
		SELECT -1 AS SAIDA, 'Não foi possível excluir a tecnologia. Possivelmente existem referências na base de dados.' AS MENSAGEM
		RETURN -1
	END

	COMMIT TRANSACTION
	SELECT 1 AS SAIDA, 'OK' AS MENSAGEM
	RETURN 1
END
