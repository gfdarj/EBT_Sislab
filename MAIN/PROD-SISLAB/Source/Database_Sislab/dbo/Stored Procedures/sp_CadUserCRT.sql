CREATE PROCEDURE [dbo].[sp_CadUserCRT]
	@pEhNovoUsuario BIT,
	@pUsername VARCHAR(20),
	@pMatricula FLOAT,
	@pNome VARCHAR(510),
	@pCelular VARCHAR(510),
	@pRamal FLOAT,
	@pOrgao SMALLINT,
	@pRAT BIT,
	@pRT BIT,
	@pQG BIT,
	@pEXIBIR BIT,
	@pPerfilSce TINYINT
AS
BEGIN
	BEGIN TRANSACTION
	SET NOCOUNT ON 

	DECLARE @msg VARCHAR(8000)

	IF @pEhNovoUsuario = 0 BEGIN
		UPDATE USERCRT SET
			Matricula = @pMatricula,
			Nome = @pNome,
			Celular = @pCelular,
			Ramal = @pRamal,
			Orga_ID = @pOrgao,
			RAT = @pRAT,
			RT = @pRT,
			GQ = @pQG,
			EXIBIR = @pEXIBIR,
			ID_PERFIL_SCE = @pPerfilSce
		WHERE
			USERID = @pUsername
		IF @@ERROR <> 0 BEGIN
			ROLLBACK TRANSACTION
			SET @msg = 'Não foi possível atualizar os dados do usuário ' + @pUsername
			RAISERROR(@msg, 16, 1)
			SELECT -1 AS SAIDA, @msg AS MENSAGEM
			RETURN -1
		END
	END
	ELSE BEGIN
		INSERT INTO USERCRT (USERID,MATRICULA,NOME,CELULAR,RAMAL,ORGA_ID,RAT,RT,GQ,EXIBIR,ID_PERFIL_SCE)
		VALUES (@pUsername,@pMatricula,@pNome,@pCelular,@pRamal,@pOrgao,@pRAT,@pRT,@pQG,@pEXIBIR,@pPerfilSce)
		IF @@ERROR <> 0 BEGIN
			ROLLBACK TRANSACTION
			SET @msg = 'Não foi possível inserir os dados do usuário ' + @pUsername + '. Atenção ao tentar cadastrar um usuário cujo USERNAME já exista.'
			RAISERROR(@msg, 16, 1)
			SELECT -1 AS SAIDA, @msg AS MENSAGEM
			RETURN -1
		END
	END

	COMMIT TRANSACTION
	SELECT 1 AS SAIDA, 'OK' AS MENSAGEM
	RETURN 1
END
