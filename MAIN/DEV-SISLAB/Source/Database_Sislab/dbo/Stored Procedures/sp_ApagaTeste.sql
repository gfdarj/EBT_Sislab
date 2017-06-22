CREATE PROCEDURE [dbo].[sp_ApagaTeste]
	@pT_ID SMALLINT
AS
BEGIN
	BEGIN TRANSACTION
	SET NOCOUNT ON 

	DELETE FROM Testes WHERE T_ID = @pT_ID
	IF @@ERROR <> 0 BEGIN
		ROLLBACK TRANSACTION
		RAISERROR('Não foi possível excluir o teste. Possivelmente existem referências ao mesmo na base de dados.', 16, 1)
		SELECT -1 AS SAIDA, 'Não foi possível excluir o ambiente. Possivelmente existem referências ao mesmo na base de dados.' AS MENSAGEM
		RETURN -1
	END

	COMMIT TRANSACTION
	SELECT 1 AS SAIDA, 'OK' AS MENSAGEM
	RETURN 1
END
