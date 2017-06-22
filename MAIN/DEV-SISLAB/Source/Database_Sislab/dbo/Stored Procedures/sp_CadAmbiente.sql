CREATE PROCEDURE [dbo].[sp_CadAmbiente]
	@pId SMALLINT,
	@pDescricao VARCHAR(510),
	@pUsadoPorAg BIT
AS
BEGIN
	BEGIN TRANSACTION
	SET NOCOUNT ON 

	DECLARE @msg VARCHAR(8000)

	IF (@pID IS NULL) OR (@pID = 0) BEGIN
		INSERT INTO Ambientes (AMB_NOME, AMB_USADOPORAG) VALUES (@pDescricao, @pUsadoPorAg)
		IF @@ERROR <> 0 BEGIN
			ROLLBACK TRANSACTION
			SET @msg = 'Não foi possível inserir o ambiente ' + @pDescricao
			RAISERROR(@msg, 16, 1)
			SELECT -1 AS SAIDA, @msg AS MENSAGEM
			RETURN -1
		END
		SET @pID = @@IDENTITY
	END
	ELSE BEGIN
		UPDATE	Ambientes SET AMB_NOME = @pDescricao, AMB_USADOPORAG = @pUsadoPorAg
		WHERE	AMB_ID = @pId
		IF @@ERROR <> 0 BEGIN
			ROLLBACK TRANSACTION
			SET @msg = 'Não foi possível atualizar o ambiente ' + @pDescricao
			RAISERROR(@msg, 16, 1)
			SELECT -1 AS SAIDA, @msg AS MENSAGEM
			RETURN -1
		END
	END

	COMMIT TRANSACTION
	SELECT @pID AS SAIDA, 'OK' AS MENSAGEM
	RETURN @pID
END
