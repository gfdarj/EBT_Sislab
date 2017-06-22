




CREATE PROCEDURE [dbo].[sp_ApagaTipoArquivo]
	@pId SMALLINT
AS
BEGIN
	BEGIN TRANSACTION
	SET NOCOUNT ON 

	DELETE FROM TipoArquivo WHERE TAR_CODTIPOARQUIVO = @pID
	IF @@ERROR <> 0 BEGIN
		ROLLBACK TRANSACTION
		RAISERROR('Não foi possível excluir o tipo de arquivo. Possivelmente existem referências ao mesmo na base de dados.', 16, 1)
		SELECT -1 AS SAIDA, 'Não foi possível excluir o tipo de arquivo. Possivelmente existem referências ao mesmo na base de dados.' AS MENSAGEM
		RETURN -1
	END

	COMMIT TRANSACTION
	SELECT 1 AS SAIDA, 'OK' AS MENSAGEM
	RETURN 1
END
