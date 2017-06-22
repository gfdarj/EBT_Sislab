CREATE PROCEDURE [dbo].[sp_CADASTRA_ARQUIVOS]
	@ACAO VARCHAR(10),
	@pAG_NUMERO INT,
	@DATA_ACAO VARCHAR(20),
	@pARQ_CODARQ INT,
	@pARQ_CODARQTIPO INT,
	@pARQ_LINK VARCHAR (400),
	@pARQ_NOMEARQ VARCHAR(200),
	@pARQ_RESPONSAVEL VARCHAR(20),
	@pARQ_IDORGAO smallINT,
	@pARQ_OBSERVACAO VARCHAR(510),
	@pARQ_VERSAO VARCHAR(100),
	@pARQ_OCULTAR bit,
	@pARQ_DATAAPROVACAO VARCHAR(20),
	@pIPCADASTRO VARCHAR(40),
	@pUSERIDCADASTRO VARCHAR(16),
	@pARQ_DESCRICAO VARCHAR(510),
	@pARQ_IDSITUACAO INT,
	@pARQ_OS INT,
	@pARQ_O1 INT,
	@pARQ_O2 INT,
	@pARQ_O3 INT
AS
BEGIN
	SET NOCOUNT ON 

	BEGIN TRANSACTION

	DECLARE @RETORNO INT
	SET @RETORNO = @pARQ_CODARQ

	IF @ACAO = 'VALIDAR' BEGIN
		INSERT INTO HISTORICO_ARQUIVOS (HA_CODARQ,HA_USUARIO,HA_DATAATUALIZACAO,HA_ACAO) 
			VALUES (@pARQ_CODARQ,@pUSERIDCADASTRO,CONVERT(SMALLDATETIME,@DATA_ACAO,103),@ACAO)
		IF (@@ERROR <> 0) BEGIN 
			ROLLBACK TRANSACTION
			SELECT -1 as 'saida'
			RAISERROR('Não foi possível inserir no histórico', 16, 1)
			RETURN -1
		END
	END

	IF @ACAO = 'EXCLUIR' BEGIN	
		DELETE diagramas where Arq_codArq = @pARQ_CODARQ
		IF (@@ERROR <> 0) BEGIN 
			ROLLBACK TRANSACTION
			SELECT -1 as 'saida'
			RAISERROR('Não foi possível apagar diagramas', 16, 1)
			RETURN -1
		END
		DELETE FROM HISTORICO_ARQUIVOS WHERE HA_CODARQ = @pARQ_CODARQ
		IF (@@ERROR <> 0) BEGIN 
			ROLLBACK TRANSACTION
			SELECT -1 as 'saida'
			RAISERROR('Não foi possível excluir o histórico', 16, 1)
			RETURN -1
		END
		DELETE arquivos Where Arq_codArq= @pARQ_CODARQ
		IF (@@ERROR <> 0) BEGIN 
			ROLLBACK TRANSACTION
			SELECT -1 as 'saida'
			RAISERROR('Não foi possível apagar os arquivos', 16, 1)
			RETURN -1
		END
	END
	
	IF @ACAO = 'INSERIR' BEGIN
		INSERT INTO ARQUIVOS 
			(ARQ_NOTIFICACAOEXPIRACAO, ARQ_LINK, ARQ_NOMEARQ, ARQ_CODARQTIPO, ARQ_Observacao, ARQ_Descricao, 
			 ARQ_Responsavel, ARQ_IDOrgao, ARQ_DATAAPROVACAO, ARQ_DATAATUALIZACAO, IPcadastro, UserIDCadastro, ARQ_IDSituacao, 
			 ARQ_Ocultar, ARQ_Versao, ARQ_OS, ARQ_O1, ARQ_O2, ARQ_O3) 	
			VALUES	(0, @pARQ_LINK, @pARQ_NOMEARQ, @pARQ_CODARQTIPO, @pARQ_Observacao, @pARQ_Descricao,
			 @pARQ_Responsavel, @pARQ_IDOrgao, CONVERT(smalldatetime,@pARQ_DATAAPROVACAO,103), getDate(),@pIPcadastro, @pUSERIDCADASTRO, @pARQ_IDSituacao, 
			 @pARQ_Ocultar, @pARQ_Versao, @pARQ_OS, @pARQ_O1, @pARQ_O2, @pARQ_O3) 	
		IF (@@ERROR <> 0) BEGIN 
			ROLLBACK TRANSACTION
			SELECT -1 as 'saida'
			RAISERROR('Não foi possível inserir o arquivo', 16, 1)
			RETURN -1
		END

		SET @RETORNO = @@IDENTITY

		IF not @pAG_NUMERO is null BEGIN
			INSERT INTO Diagramas (AG_Numero, ARQ_CodARQ) VALUES (@pAG_NUMERO, @RETORNO)
			IF (@@ERROR <> 0) BEGIN 
				ROLLBACK TRANSACTION
				SELECT -1 as 'saida'
				RAISERROR('Não foi possível inserir diagrama', 16, 1)
				RETURN -1
			END
		END
	END

	IF @ACAO = 'ALTERAR' BEGIN
		DELETE Diagramas where  ARQ_CodARQ = @pARQ_CODARQ
		IF (@@ERROR <> 0) BEGIN 
			ROLLBACK TRANSACTION
			SELECT -1 as 'saida'
			RAISERROR('Não foi possível excluir diagramas', 16, 1)
			RETURN -1
		END

		UPDATE ARQUIVOS SET
			ARQ_LINK = @pARQ_LINK,
			ARQ_NOMEARQ = @pARQ_NOMEARQ,
			ARQ_CODARQTIPO = @pARQ_CODARQTIPO,
			ARQ_Observacao = @pARQ_Observacao,
			ARQ_Descricao = @pARQ_Descricao,
			ARQ_Responsavel = @pARQ_Responsavel,
			ARQ_IDOrgao = @pARQ_IDOrgao,
			ARQ_DATAAPROVACAO = CONVERT(smalldatetime,@pARQ_DATAAPROVACAO,103),
			ARQ_DATAATUALIZACAO = getDate(),
			IPcadastro = @pIPcadastro,
			UserIDCadastro = @pUSERIDCADASTRO,
			ARQ_IDSituacao = @pARQ_IDSituacao,
			ARQ_Ocultar = @pARQ_Ocultar,
			ARQ_Versao = @pARQ_Versao,
			ARQ_OS = @pARQ_OS,
			ARQ_O1 = @pARQ_O1,
			ARQ_O2 = @pARQ_O2,
			ARQ_O3 = @pARQ_O3
		WHERE  Arq_codArq= @pARQ_CODARQ
		IF (@@ERROR <> 0) BEGIN 
			ROLLBACK TRANSACTION
			SELECT -1 as 'saida'
			RAISERROR('Não foi possível atualisar o arquivo', 16, 1)
			RETURN -1
		END

		IF @pAG_NUMERO is not null BEGIN
			INSERT INTO Diagramas (AG_Numero, ARQ_CodARQ)
				VALUES (@pAG_NUMERO, @pARQ_CODARQ)
			IF (@@ERROR <> 0) BEGIN 
				ROLLBACK TRANSACTION
				SELECT -1 as 'saida'
				RAISERROR('Não foi possível inserir diagrama', 16, 1)
				RETURN -1
			END
		END
	END

	COMMIT TRANSACTION
	SELECT @RETORNO as 'saida'

	RETURN 1
END
