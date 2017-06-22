
CREATE PROCEDURE [dbo].[sp_CadTipoTeste]
	@pId SMALLINT,
	@pDescricao VARCHAR(510)
AS
BEGIN
	BEGIN TRANSACTION
	SET NOCOUNT ON 

	DECLARE @msg VARCHAR(8000)

	IF (@pID IS NULL) OR (@pID = 0) BEGIN
		INSERT INTO tipo_teste (tit_descricao) VALUES (@pDescricao)
		IF @@ERROR <> 0 BEGIN
			ROLLBACK TRANSACTION
			SET @msg = 'Não foi possível inserir o tipo de teste ' + @pDescricao
			RAISERROR(@msg, 16, 1)
			SELECT -1 AS SAIDA, @msg AS MENSAGEM
			RETURN -1
		END
		SET @pID = @@IDENTITY
	END
	ELSE BEGIN
		UPDATE tipo_teste
		SET tit_descricao = @pDescricao
		WHERE tit_id = @pId
		IF @@ERROR <> 0 BEGIN
			ROLLBACK TRANSACTION
			SET @msg = 'Não foi possível atualizar o tipo de teste ' + @pDescricao
			RAISERROR(@msg, 16, 1)
			SELECT -1 AS SAIDA, @msg AS MENSAGEM
			RETURN -1
		END
	END

	COMMIT TRANSACTION
	SELECT @pID AS SAIDA, 'OK' AS MENSAGEM
	RETURN @pID
END
