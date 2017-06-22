


------>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>

CREATE  PROCEDURE [dbo].[sp_CadAgendamentoOS]
	@NOVA_OS BIT,
	@pT_ID  smallint,
	@pOS_ID  smallint,
	@pAG_NUMERO smallint,
 	@pOS_OBSERVACAO varchar(7000),
	@pID_SITUACAO smallint,
 	@pHEOS_MOTIVO varchar(200),
	@pHE_DataInicio varchar(20),
	@pS_ID_SERVICO smallint,
	@pS_ID_PLATAFORMA smallint,
	@pEQ_ID_AMOSTRA int
AS
BEGIN
	DECLARE	@SITUACAO_ATUAL SMALLINT,
		@PERIODO_REPETICAO SMALLINT,
		@DATA_HOJE DATETIME,
		@DATA_LIMITE_REPETICAO DATETIME,
		@dtt_Termino DATETIME,
		@int_Linha INT,
		@int_REPETICAO_AS INT,
		@int_REPETICAO_OS INT

	SET NOCOUNT ON
	SET @DATA_HOJE = GETDATE()

	---->>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
	---->>>>> Verifica se o teste que está sendo gravado
	---->>>>> necessita de repeticao. Caso seja positivo, verificaremos
	---->>>>> agendamento para saber se o mesmo já está marcado para
	---->>>>> repetição.
	---->>>>> A procedure deve retornar um aviso indicando que o agendamento 
	---->>>>> foi marcado com repetição
	---->>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
	SELECT
		@PERIODO_REPETICAO = T_PERIODOREPETICAO
	FROM
		Testes T
	WHERE
		T_ID = @pT_ID

	-->>> Nao tem período especificado ou não definido
	IF ((@PERIODO_REPETICAO IS NULL) OR (@PERIODO_REPETICAO = 0))
	BEGIN
		SET @int_REPETICAO_OS = 0
	END
	ELSE BEGIN
		SET @DATA_LIMITE_REPETICAO = DATEADD(mm, (@PERIODO_REPETICAO * -1), @DATA_HOJE)

		-->> OS: pego o ultimo teste finalizado ocorrido que não seja indeferido ou cancelado
		SELECT TOP 1
			@int_Linha = COUNT(*)
		FROM
			vw_OrdemDeServico OS
		WHERE
			OS.T_ID = @pT_ID
		AND
			OS.ID_SITUACAO NOT IN (13, 14) --> indeferido / cancelado
		AND
			OS.HEOS_DATATERMINO >= @DATA_LIMITE_REPETICAO
		AND
			OS.AG_NUMERO <> @pAG_NUMERO
		AND 
			OS_ID <> @pOS_ID

		-->>> Possui OS's dentro do período do teste, entao NÃO preciso marcar para repetição
		IF @int_Linha > 0
			SET @int_REPETICAO_OS = 0
		ELSE BEGIN
		-->>> Não possui OS's dentro do período do teste, logo preciso marcar para repetição
			SET @int_REPETICAO_OS = 1
			SET @int_REPETICAO_AS = 1
		END
	END


	-->>> Se NAO tem repeticao desta OS, verifico se a AS tem outra OS com FLAG de repetição marcado
	-->>> para manter o flag setado na AS
	IF @int_REPETICAO_OS = 0
	BEGIN
		SELECT TOP 1
			@int_Linha = COUNT(*)
		FROM
			vw_OrdemDeServico OS
		WHERE
			OS.AG_NUMERO = @pAG_NUMERO
		AND 
			OS_ID <> @pOS_ID
		AND
			OS_FLAGREPETICAO = 1

		IF @int_Linha > 0
			SET @int_REPETICAO_AS = 1
		ELSE
			SET @int_REPETICAO_AS = 0
	END


	BEGIN TRANSACTION

	IF @NOVA_OS = 1
	BEGIN
		-->> Insere nova OS
		INSERT INTO ORDEM_DE_SERVICO (OS_ID, AG_NUMERO, T_ID, S_ID_SERVICO, S_ID_PLATAFORMA, EQ_ID_AMOSTRA)
			VALUES (@pOS_ID, @pAG_NUMERO, @pT_ID, @pS_ID_SERVICO, @pS_ID_PLATAFORMA, @pEQ_ID_AMOSTRA)

	 	IF @@ERROR  <> 0 BEGIN
			ROLLBACK TRANSACTION
			SELECT 1 AS Erro, @int_REPETICAO_OS AS RepeticaoOS, @int_REPETICAO_AS AS RepeticaoAS
			RETURN 1
		END
	END


	--SE FOR UMA MUDANÇA DE STATUS
	IF NOT @pID_SITUACAO IS NULL BEGIN

		--SETO O STATUS ANTERIOR COMO FINALIZADO TENDO COMO DATA DE TERMINO O INICIO DO ESTADO ATUAL
		UPDATE HISTORICO_EVENTOSOS
	 		SET HEOS_DATATERMINO = CONVERT(SMALLDATETIME,@pHE_DataInicio,103)
		 	WHERE AG_NUMERO = @pAG_NUMERO AND HEOS_DATATERMINO IS NULL AND OS_ID = @pOS_ID
	 	IF @@ERROR  <> 0 BEGIN
			ROLLBACK TRANSACTION
			SELECT 1 AS Erro, @int_REPETICAO_OS AS RepeticaoOS, @int_REPETICAO_AS AS RepeticaoAS
			RETURN 1
		END

 		IF @pID_SITUACAO IN (13,14,15) BEGIN
			INSERT INTO HISTORICO_EVENTOSOS(AG_NUMERO,  ID_SITUACAO, HEOS_DATAINICIO, HEOS_DATATERMINO, HEOS_MOTIVO,OS_ID)
			VALUES(@pAG_NUMERO, @pID_SITUACAO, Convert(smalldatetime,@pHE_DataInicio,103), Convert(smalldatetime,@pHE_DataInicio,103), @pHEOS_MOTIVO,@pOS_ID)
		 	IF @@ERROR  <> 0 BEGIN
				ROLLBACK TRANSACTION
				SELECT 1 AS Erro, @int_REPETICAO_OS AS RepeticaoOS, @int_REPETICAO_AS AS RepeticaoAS
				RETURN 1
			END
		END 
		ELSE BEGIN
			INSERT INTO HISTORICO_EVENTOSOS(AG_NUMERO,  ID_SITUACAO, HEOS_DATAINICIO, HEOS_DATATERMINO, HEOS_MOTIVO,OS_ID)
			VALUES(@pAG_NUMERO, @pID_SITUACAO, Convert(smalldatetime,@pHE_DataInicio,103), NULL, @pHEOS_MOTIVO,@pOS_ID)
		 	IF @@ERROR  <> 0 BEGIN
				ROLLBACK TRANSACTION
				SELECT 1 AS Erro, @int_REPETICAO_OS AS RepeticaoOS, @int_REPETICAO_AS AS RepeticaoAS
				RETURN 1
			END
		END
	END

	--ATUALIZO OS DADOS
	UPDATE
		ORDEM_DE_SERVICO 
	SET
		OS_OBSERVACOES = @pOS_OBSERVACAO,
		T_ID = @pT_ID,
		S_ID_SERVICO = @pS_ID_SERVICO,
		S_ID_PLATAFORMA = @pS_ID_PLATAFORMA,
		EQ_ID_AMOSTRA = @pEQ_ID_AMOSTRA,
		OS_FLAGREPETICAO = @int_REPETICAO_OS
	WHERE 
		AG_NUMERO = @pAG_NUMERO 
	AND 
		OS_ID = @pOS_ID
 	IF @@ERROR  <> 0 BEGIN
		ROLLBACK TRANSACTION
		RAISERROR( 'Não foi possível atualizar a ordem de serviço.', 16, 1 )
		SELECT 1 AS Erro, @int_REPETICAO_OS AS RepeticaoOS, @int_REPETICAO_AS AS RepeticaoAS
		RETURN 1
	END


	-->>> atualizo o agendamento, marcando o mesmo com o FLAG de repetição
	UPDATE
		Agendamento
	SET
		AG_REPETIDO = @int_REPETICAO_AS
	WHERE
		AG_NUMERO = @pAG_NUMERO
 	IF @@ERROR  <> 0 BEGIN
		ROLLBACK TRANSACTION
		RAISERROR( 'Não foi possível atualizar o agendamento.', 16, 1 )
		SELECT 1 AS Erro, @int_REPETICAO_OS AS RepeticaoOS, @int_REPETICAO_AS AS RepeticaoAS
		RETURN 1
	END


	COMMIT TRANSACTION
	SELECT 0 AS Erro, @int_REPETICAO_OS AS RepeticaoOS, @int_REPETICAO_AS AS RepeticaoAS
	RETURN 0
END
