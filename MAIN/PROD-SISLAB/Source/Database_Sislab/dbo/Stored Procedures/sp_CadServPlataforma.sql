CREATE PROCEDURE [dbo].[sp_CadServPlataforma]
	@pId SMALLINT,
	@pDescricao VARCHAR(510),
	@pTipo BIT,
	@pId_Pai SMALLINT
AS
BEGIN
	BEGIN TRANSACTION
	SET NOCOUNT ON 

	DECLARE @msg VARCHAR(8000)

	IF (@pID IS NULL) OR (@pID = 0) BEGIN
		INSERT INTO Servicos_Plataformas (s_descricao,s_servico,s_id_pai)
		VALUES (UPPER(@pDescricao), @pTipo, @pId_Pai)
		IF @@ERROR <> 0 BEGIN
			ROLLBACK TRANSACTION
			SET @msg = 'Não foi possível inserir o serviço/sistema ' + @pDescricao
			RAISERROR(@msg, 16, 1)
			SELECT -1 AS SAIDA, @msg AS MENSAGEM
			RETURN -1
		END
		SET @pID = @@IDENTITY
	END
	ELSE BEGIN
		UPDATE Servicos_Plataformas SET
			s_descricao = UPPER(@pDescricao),
			s_servico = @pTipo,
			s_id_pai = @pId_Pai
		WHERE	s_id = @pId
		IF @@ERROR <> 0 BEGIN
			ROLLBACK TRANSACTION
			SET @msg = 'Não foi possível atualizar o serviço/sistema ' + @pDescricao
			RAISERROR(@msg, 16, 1)
			SELECT -1 AS SAIDA, @msg AS MENSAGEM
			RETURN -1
		END
	END

	COMMIT TRANSACTION
	SELECT @pID AS SAIDA, 'OK' AS MENSAGEM
	RETURN @pID
END
