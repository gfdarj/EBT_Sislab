




CREATE PROCEDURE [dbo].[sp_CadTipoArquivo]
	@pId SMALLINT,
	@pDescricao VARCHAR(480),
	@pConfidencial BIT,
	@pDocQuali BIT
AS
BEGIN
	SET NOCOUNT ON 
	BEGIN TRANSACTION

	IF @pID IS NULL OR @pID = 0 BEGIN
		INSERT INTO TipoArquivo (TAR_TIPOARQUIVO, TAR_CONFIDENCIAL, TAR_DocQual) 
			VALUES (@pDescricao, @pConfidencial, @pDocQuali)
		IF @@ERROR <> 0 BEGIN
			ROLLBACK TRANSACTION
			RAISERROR( 'Não foi possível inserir tipo de arquivo', 16, 1)
			SELECT -1 AS SAIDA, 'Não foi possível inserir tipo de arquivo' AS MENSAGEM
			RETURN -1
		END
		SET @pID = @@IDENTITY
	END
	ELSE BEGIN
		UPDATE TipoArquivo 
		SET 	TAR_TIPOARQUIVO = @pDescricao,
			TAR_CONFIDENCIAL = @pConfidencial, 
			TAR_DocQual = @pDocQuali
		WHERE TAR_CODTIPOARQUIVO = @pId
		IF @@ERROR <> 0 BEGIN
			ROLLBACK TRANSACTION
			RAISERROR( 'Não foi possível atualizar tipo de arquivo', 16, 1)
			SELECT -1 AS SAIDA, 'Não foi possível atualizar tipo de arquivo' AS MENSAGEM
			RETURN -1
		END
	END

	COMMIT TRANSACTION
	SELECT @pID AS SAIDA, 'OK' AS MENSAGEM
	RETURN @pID
END
