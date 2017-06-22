CREATE PROCEDURE [dbo].[sp_CadTecnologia]
	@pId SMALLINT,
	@pDescricao VARCHAR(510),
	@pAreaTecnologica SMALLINT
AS
BEGIN
	BEGIN TRANSACTION
	SET NOCOUNT ON 

	DECLARE @msg VARCHAR(8000)

	IF (@pID IS NULL) OR (@pID = 0) BEGIN
		INSERT INTO tecnologia (tec_nome, at_id) VALUES (UPPER(@pDescricao), @pAreaTecnologica)
		IF @@ERROR <> 0 BEGIN
			ROLLBACK TRANSACTION
			SET @msg = 'Não foi possível inserir a tecnologia ' + @pDescricao
			RAISERROR(@msg, 16, 1)
			SELECT -1 AS SAIDA, @msg AS MENSAGEM
			RETURN -1
		END
		SET @pID = @@IDENTITY
	END
	ELSE BEGIN
		UPDATE	tecnologia SET tec_nome = UPPER(@pDescricao), at_id = @pAreaTecnologica
		WHERE	tec_id = @pId
		IF @@ERROR <> 0 BEGIN
			ROLLBACK TRANSACTION
			SET @msg = 'Não foi possível atualizar a tecnologia ' + @pDescricao
			RAISERROR(@msg, 16, 1)
			SELECT -1 AS SAIDA, @msg AS MENSAGEM
			RETURN -1
		END
	END

	COMMIT TRANSACTION
	SELECT @pID AS SAIDA, 'OK' AS MENSAGEM
	RETURN @pID
END
