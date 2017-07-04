

CREATE  PROCEDURE [dbo].[sp_CadPesquisa]
	@pPSQ_ID INT OUTPUT,
	@pUSERNAMECADASTRO VARCHAR(20),
	@pIP_CADASTRO VARCHAR(100),
	@pAG_NUMERO INT,
	@pNOME VARCHAR(300),
	@pTELEFONE VARCHAR(100),
	@pEMAIL VARCHAR(100),
	@pORGAOEMPRESA VARCHAR(100),
	@pORIGEM CHAR(1),
	@pR1 INT, @pR2 INT, @pR3 INT, @pR4 INT, @pR5 INT, @pR6 INT, @pR7 INT, @pR8 INT, @pR9 INT, @pR10 INT, @pR11 INT,
	@pC1 TEXT, @pC2 TEXT, @pC3 TEXT, @pC4 TEXT, @pC5 TEXT, @pC6 TEXT, @pC7 TEXT, @pC8 TEXT, @pC9 TEXT, @pC10 TEXT, @pC11 TEXT,
	@pC_3 TEXT,
	@pC_4 TEXT
AS
BEGIN
	/* Apaga uma ou todas as Ordens de Servico para um Agendamento */
	SET NOCOUNT ON
	BEGIN TRANSACTION

	IF @pPSQ_ID IS NULL OR @pPSQ_ID = 0 BEGIN
		INSERT INTO PesquisaSatisfacao (
			PSQ_UsernameCadastro,PSQ_IPCAdastro,PSQ_DataHoraCadastro,
			PSQ_NAg, PSQ_Nome,PSQ_Telefone,PSQ_Email,PSQ_OrgaoEmpresa,PSQ_origem,
			PSQ_R1, PSQ_R2, PSQ_R3, PSQ_R4, PSQ_R5, PSQ_R6, PSQ_R7, PSQ_R8, PSQ_R9, PSQ_R10, PSQ_R11,
			PSQ_C1, PSQ_C2, PSQ_C3, PSQ_C4, PSQ_C5, PSQ_C6, PSQ_C7, PSQ_C8, PSQ_C9, PSQ_C10, PSQ_C11, PSQ_C_3, PSQ_C_4
			)
			VALUES (@pUSERNAMECADASTRO, @pIP_CADASTRO, GETDATE(), @pAG_NUMERO, @pNOME, @pTELEFONE,
			@pEMAIL, @pORGAOEMPRESA, @pORIGEM, @pR1, @pR2, @pR3, @pR4, @pR5, @pR6, @pR7, @pR8, @pR9, @pR10, @pR11,
			@pC1, @pC2, @pC3, @pC4, @pC5, @pC6, @pC7, @pC8, @pC9, @pC10, @pC11, @pC_3, @pC_4
			)
		IF @@ERROR <> 0 BEGIN
			ROLLBACK TRANSACTION
			RAISERROR( 'Não foi possível inserir pesquisa de satisfação.', 16, 1 )
			SELECT -1 AS SAIDA
			RETURN -1
		END
		SET @pPSQ_ID = @@IDENTITY
	END
	ELSE BEGIN
		UPDATE PesquisaSatisfacao
			SET	PSQ_UsernameCadastro = @pUSERNAMECADASTRO,
				PSQ_IPCAdastro = @pIP_CADASTRO,
				--PSQ_DataHoraCadastro = GETDATE(),
				PSQ_NAg = @pAG_NUMERO,
				PSQ_Nome = @pNOME,
				PSQ_Telefone = @pTELEFONE,
				PSQ_Email = @pEMAIL,
				PSQ_OrgaoEmpresa = @pORGAOEMPRESA,
				PSQ_origem = @pORIGEM,
				PSQ_R1 = @pR1,
				PSQ_R2 = @pR2, PSQ_R3 = @pR3, PSQ_R4 = @pR4, PSQ_R5 = @pR5, PSQ_R6 = @pR6, 
				PSQ_R7 = @pR7, PSQ_R8 = @pR8, PSQ_R9 = @pR9, PSQ_R10 = @pR10, PSQ_R11 = @pR11,
				PSQ_C1 = @pC1, PSQ_C2 = @pC2, PSQ_C3 = @pC3, PSQ_C4 = @pC4, PSQ_C5 = @pC5, PSQ_C6 = @pC6,
				PSQ_C7 = @pC7, PSQ_C8 = @pC8, PSQ_C9 = @pC9, PSQ_C10 = @pC10, PSQ_C11 = @pC11,
				PSQ_C_3 = @pC_3, PSQ_C_4 = @pC_4
			WHERE PSQ_ID = @pPSQ_ID 
		IF @@ERROR <> 0 BEGIN
			ROLLBACK TRANSACTION
			RAISERROR( 'Não foi possível atualizar pesquisa de satisfação.', 16, 1 )
			SELECT -1 AS SAIDA
			RETURN -1
		END
	END
	COMMIT TRANSACTION
	SELECT @pPSQ_ID AS SAIDA
	RETURN @pPSQ_ID
END


