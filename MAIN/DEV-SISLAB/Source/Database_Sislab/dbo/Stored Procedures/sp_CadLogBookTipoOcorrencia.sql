CREATE PROCEDURE [dbo].[sp_CadLogBookTipoOcorrencia]
	@pId SMALLINT,
	@pDescricao VARCHAR(510)
AS
BEGIN
	SET NOCOUNT ON 
	BEGIN TRANSACTION

	IF @pID IS NULL OR @pID = 0 BEGIN
		INSERT INTO LB_TipoOcorrencia (LBTO_DESCRICAO) VALUES (@pDescricao)
		IF @@ERROR <> 0 BEGIN
			ROLLBACK TRANSACTION
			RAISERROR( 'Não foi possível inserir tipo de ocorrência', 16, 1)
			SELECT -1 AS SAIDA, 'Não foi possível inserir tipo de ocorrência' AS MENSAGEM
			RETURN -1
		END
		SET @pID = @@IDENTITY
	END
	ELSE BEGIN
		UPDATE LB_TipoOcorrencia SET LBTO_DESCRICAO = @pDescricao
		WHERE LBTO_id = @pId
		IF @@ERROR <> 0 BEGIN
			ROLLBACK TRANSACTION
			RAISERROR( 'Não foi possível atualizar tipo de ocorrência', 16, 1)
			SELECT -1 AS SAIDA, 'Não foi possível atualizar tipo de ocorrência' AS MENSAGEM
			RETURN -1
		END
	END

	COMMIT TRANSACTION
	SELECT @pID AS SAIDA, 'OK' AS MENSAGEM
	RETURN @pID
END
