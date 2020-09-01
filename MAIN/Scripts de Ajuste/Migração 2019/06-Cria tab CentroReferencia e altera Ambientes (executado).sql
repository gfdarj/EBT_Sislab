
CREATE TABLE dbo.CentroReferencia (
	ID_CRT TINYINT NOT NULL,
	NM_CRT VARCHAR(100) NOT NULL,
	SIGLA_CRT VARCHAR(10)
)
GO

ALTER TABLE dbo.CentroReferencia ADD CONSTRAINT PK_CentroReferencia PRIMARY KEY (ID_CRT)
GO

INSERT INTO CentroReferencia (ID_CRT, NM_CRT, SIGLA_CRT) VALUES (1, 'CRT FUNDÃO', 'CRTFUN')
GO
INSERT INTO CentroReferencia (ID_CRT, NM_CRT, SIGLA_CRT) VALUES (2, 'CRT MORUMBI', 'CRTMBI')
GO
INSERT INTO CentroReferencia (ID_CRT, NM_CRT, SIGLA_CRT) VALUES (3, 'CRT CAMPINAS', 'CRTCPS')
GO



ALTER TABLE dbo.Ambientes ADD AMB_MODULO TINYINT
go

ALTER TABLE dbo.Ambientes ADD ID_CRT TINYINT
go

ALTER TABLE dbo.Ambientes
	ADD CONSTRAINT FK_Ambientes_CentroReferencia FOREIGN KEY (ID_CRT)
		REFERENCES dbo.CentroReferencia (ID_CRT)
GO


UPDATE AMBIENTES SET AMB_MODULO = 1, ID_CRT = 1
GO


ALTER TABLE dbo.SCE_Equipamentos ADD AMB_ID INT
go
ALTER TABLE dbo.SCE_Equipamentos
	ADD CONSTRAINT FK_SCE_Equipamentos_Ambientes FOREIGN KEY (AMB_ID)
		REFERENCES dbo.Ambientes (AMB_ID)
GO


ALTER TABLE UserCRT ADD ID_CRT TINYINT
go
ALTER TABLE dbo.UserCRT
	ADD CONSTRAINT FK_UserCRT_CentroReferencia FOREIGN KEY (ID_CRT)
		REFERENCES dbo.CentroReferencia (ID_CRT)
GO


/****** Object:  StoredProcedure [dbo].[sp_CadAmbiente]    Script Date: 07/19/2018 18:45:13 ******/
IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[dbo].[sp_CadAmbiente]') AND OBJECTPROPERTY(id,N'IsProcedure') = 1)
	DROP PROCEDURE [dbo].[sp_CadAmbiente]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[sp_CadAmbiente]
(
	@pId INT,
	@pDescricao VARCHAR(510),
	@pUsadoPorAg BIT,
	@pModulo TINYINT,
	@pCRT TINYINT
)
AS
BEGIN
	BEGIN TRANSACTION
	SET NOCOUNT ON 

	DECLARE @msg VARCHAR(8000)

	IF (@pID IS NULL) OR (@pID = 0) BEGIN
		INSERT INTO Ambientes (AMB_NOME, AMB_USADOPORAG, AMB_MODULO, ID_CRT) VALUES (@pDescricao, @pUsadoPorAg, @pModulo, @pCRT)
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
		UPDATE	Ambientes 
			SET AMB_NOME = @pDescricao, AMB_USADOPORAG = @pUsadoPorAg, AMB_MODULO = @pModulo, ID_CRT = @pCRT
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
GO

