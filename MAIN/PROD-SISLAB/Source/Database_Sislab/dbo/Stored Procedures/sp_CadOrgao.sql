CREATE PROCEDURE [dbo].[sp_CadOrgao]
	@orga_id INT,
	@orga_sigla VARCHAR(20),
	@orga_descricao VARCHAR(100),
	@orga_fax VARCHAR(50),
	@orga_ramal VARCHAR(50),
	@orga_exibir BIT,
	@orga_useridchefe VARCHAR(20),
	@orga_hierarquia SMALLINT
AS
BEGIN
	BEGIN TRANSACTION
	SET NOCOUNT ON 

	DECLARE @msg VARCHAR(8000)

	IF @orga_id IS NULL BEGIN
		INSERT INTO Orgao 
			(ORGA_SIGLA, ORGA_DESCRICAO, ORGA_FAX, ORGA_RAMAL, ORGA_EXIBIR, ORGA_USERIDCHEFE, ORGA_HIERARQUIA, ORGA_TIPO)
			VALUES
			(@orga_sigla, @orga_descricao, @orga_fax, @orga_ramal, @orga_exibir, @orga_useridchefe, @orga_hierarquia, 0)
		IF @@ERROR <> 0 BEGIN
			ROLLBACK TRANSACTION
			SET @msg = 'Não foi possível inserir órgão ' + @orga_descricao
			RAISERROR(@msg, 16, 1)
			SELECT -1 AS SAIDA, @msg AS MENSAGEM
			RETURN -1
		END
		SET @orga_id = @@IDENTITY
	END
	ELSE BEGIN
		UPDATE Orgao SET
				ORGA_SIGLA = @orga_sigla,
				ORGA_DESCRICAO = @orga_descricao,
				ORGA_FAX = @orga_fax,
				ORGA_RAMAL = @orga_ramal,
				ORGA_EXIBIR = @orga_exibir,
				ORGA_USERIDCHEFE = @orga_useridchefe,
				ORGA_HIERARQUIA = @orga_hierarquia
			WHERE ORGA_ID = @orga_id
		IF @@ERROR <> 0 BEGIN
			ROLLBACK TRANSACTION
			SET @msg = 'Não foi possível atualizar órgão ' + @orga_descricao
			RAISERROR(@msg, 16, 1)
			SELECT -1 AS SAIDA, @msg AS MENSAGEM
			RETURN -1
		END
	END

	COMMIT TRANSACTION
	SELECT @orga_id AS SAIDA, 'OK' AS MENSAGEM
	RETURN @orga_id
END
