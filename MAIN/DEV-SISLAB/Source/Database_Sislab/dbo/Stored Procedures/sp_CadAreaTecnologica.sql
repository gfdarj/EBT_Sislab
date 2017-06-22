CREATE PROCEDURE [dbo].[sp_CadAreaTecnologica]
	@pId SMALLINT,
	@pDescricao VARCHAR(510)
AS
BEGIN
	SET NOCOUNT ON 
	BEGIN TRANSACTION

	IF @pID IS NULL OR @pID = 0 BEGIN
		INSERT INTO Area_tecnologica (at_nome) VALUES (@pDescricao)
		IF @@ERROR <> 0 BEGIN
			ROLLBACK TRANSACTION
			RAISERROR( 'Não foi possível inserir Área Tecnológica', 16, 1)
			SELECT -1 AS SAIDA, 'Não foi possível inserir Área Tecnológica' AS MENSAGEM
			RETURN -1
		END
		SET @pID = @@IDENTITY
	END
	ELSE BEGIN
		UPDATE Area_tecnologica SET at_nome = @pDescricao
		WHERE at_id = @pId
		IF @@ERROR <> 0 BEGIN
			ROLLBACK TRANSACTION
			RAISERROR( 'Não foi possível atualizar Área Tecnológica', 16, 1)
			SELECT -1 AS SAIDA, 'Não foi possível atualizar Área Tecnológica' AS MENSAGEM
			RETURN -1
		END
	END

	COMMIT TRANSACTION
	SELECT @pID AS SAIDA, 'OK' AS MENSAGEM
	RETURN @pID
END
