ALTER TABLE PARTICIPANTES_EXTERNOS ADD PE_QUEMINCLUIU CHAR(3) DEFAULT 'CLI'
GO

UPDATE PARTICIPANTES_EXTERNOS SET PE_QUEMINCLUIU = 'CLI' WHERE PE_QUEMINCLUIU IS NULL
GO


DROP PROCEDURE dbo.sp_CadAgendamento
GO
CREATE PROCEDURE dbo.sp_CadAgendamento
	@separa_campo varchar(4),
	@separa_registro varchar(4),
	@pAG_NUMEROIn smallint OUTPUT,
	@pAG_TITULO varchar(50),
	@pRecebeMail bit,
	@pTA_ID smallint,
	@pAG_TECNOLOGIA smallint,
	@pAG_DATAINICIO char(20), -- smalldatetime
	@pAG_DATATERMINO char(20), -- smalldatetime
	@pAG_SIGILO bit,
	@pAG_OBJETIVO varchar(8000),
	@pAG_AMBIENTE varchar(8000),
	@pAG_RECURSOS varchar(8000),
	@pAG_OBSERVACAO varchar(8000),
	@pAG_USERNAME varchar(20),
	@pAG_ORGAO varchar(200),
	@pAG_CLIENTEEXTERNO varchar(200),
	@pAG_RETORNOCLIENTE money,
	@pAG_VALORCONTRATOCLIENTE money,
	@pAG_PLANODEMETAS INT,
	@pSTR_PARTICIPANTES_EBT VARCHAR(8000),
	@pSTR_PARTICIPANTES_NEBT VARCHAR(8000)
AS
BEGIN
	/**
		Cadastra um novo agendamento com dados preenchidos em um primeiro
		momento apenas ao cliente. Posteriormente estes dados são complementados
		pelos RAT´s e RT´s
	**/
	SET NOCOUNT ON 
	BEGIN TRANSACTION

	IF  @pAG_NUMEROIn IS NULL  BEGIN
		--////////////////// INSERE AGENDAMENTO
		INSERT INTO AGENDAMENTO
			(AG_TITULO, TA_ID, TEC_ID,AG_DATASOLICITACAO, AG_DATAINICIO, AG_DATATERMINO, AG_SIGILO,  AG_OBJETIVO, AG_FLAGREMARCACAO, AG_MOTIVO,   AG_USERNAME, AG_ORGAO, AG_RECEBEMAIL,AG_AMBIENTE,AG_RECURSOS, AG_OBSERVACAO, AG_CLIENTEEXTERNO, AG_RETORNOCLIENTE, AG_VALORCONTRATOCLIENTE, AG_PLANODEMETAS)
			VALUES
			(UPPER(@pAG_TITULO), @pTA_ID, @pAG_TECNOLOGIA, getDate(), Convert(smalldatetime, @pAG_DATAINICIO, 103), Convert(smalldatetime, @pAG_DATATERMINO, 103), @pAG_SIGILO,  @pAG_OBJETIVO, 0, null,  @pAG_USERNAME, @pAG_ORGAO, @pRecebeMail,@pAG_AMBIENTE,@pAG_RECURSOS,@pAG_OBSERVACAO, @pAG_CLIENTEEXTERNO, @pAG_RETORNOCLIENTE, @pAG_VALORCONTRATOCLIENTE, @pAG_PLANODEMETAS)
		IF @@ERROR <> 0 BEGIN
			ROLLBACK TRANSACTION
			RAISERROR( 'Não foi possível inserir o agendamento', 16, 1 )
			SELECT -1 AS AG_NUMERO
			RETURN -1
		END

	 	set @pAG_NUMEROIn = @@Identity

		--////////////////// INSERE HISTORICO_EVENTOS
		INSERT INTO HISTORICO_EVENTOS(ID_SITUACAO, AG_NUMERO, HE_DATAINICIO, HE_DATATERMINO, HE_RESPONSAVEL)
	 		VALUES(1, @pAG_NUMEROIn, GETDATE(), NULL, NULL)
		IF @@ERROR <> 0 BEGIN
			ROLLBACK TRANSACTION
			RAISERROR( 'Não foi possível inserir eventos do agendamento', 16, 1 )
			SELECT -1 AS AG_NUMERO
			RETURN -1
		END
	END
	ELSE  BEGIN
		UPDATE AGENDAMENTO SET
			AG_TITULO = UPPER(@pAG_TITULO),
			TA_ID = @pTA_ID,
			TEC_ID = @pAG_TECNOLOGIA,
			AG_DATASOLICITACAO = getDate(),
			AG_DATAINICIO = Convert(smalldatetime, @pAG_DATAINICIO, 103),
			AG_DATATERMINO = Convert(smalldatetime, @pAG_DATATERMINO, 103),
			AG_SIGILO = @pAG_SIGILO,
			AG_OBJETIVO = @pAG_OBJETIVO,
			AG_USERNAME = @pAG_USERNAME,
			AG_ORGAO = @pAG_ORGAO,
			AG_AMBIENTE = @pAG_AMBIENTE,
			AG_RECURSOS = @pAG_RECURSOS,
			AG_OBSERVACAO = @pAG_OBSERVACAO,
			AG_RECEBEMAIL = @pRecebeMail,
			AG_CLIENTEEXTERNO = @pAG_CLIENTEEXTERNO,
			AG_RETORNOCLIENTE = @pAG_RETORNOCLIENTE,
			AG_VALORCONTRATOCLIENTE = @pAG_VALORCONTRATOCLIENTE,
			AG_PLANODEMETAS = @pAG_PLANODEMETAS
		WHERE	AG_NUMERO = @pAG_NUMEROIn

		IF @@ERROR <> 0 BEGIN
			ROLLBACK TRANSACTION
			RAISERROR( 'Não foi possível atualizar o agendamento', 16, 1 )
			SELECT -1 AS AG_NUMERO
			RETURN -1
		END
	END

	--VARIÁVEIS NECESSÁRIAS PARA QUEBRA DAS STRINGS
	DECLARE @reg VARCHAR(8000), @fim BIT, @iini INT, @ifim INT
	DECLARE @DADOS VARCHAR(8000)
	DECLARE @st1 VARCHAR(8000), @st2 VARCHAR(8000), @st3 VARCHAR(8000), @st4 VARCHAR(8000), @st5 VARCHAR(8000)

	-- apago os participantes antes de inserir
	DELETE FROM PARTICIPANTES_EXTERNOS WHERE AG_NUMERO = @pAG_NUMEROIn AND PE_QUEMINCLUIU = 'CLI'
	IF @@ERROR <> 0 BEGIN
		ROLLBACK TRANSACTION
		RAISERROR( 'Não foi possível excluir os participantes do agendamento', 16, 1 )
		SELECT -1 AS AG_NUMERO
		RETURN -1
	END

	--INSERÇÃO D0S CAMPOS RELATIVOS AOS PARICIPANTES Não EBT
	SET @DADOS = @pSTR_PARTICIPANTES_NEBT
	--RETIRO O ULTIMO SEPARADO DE REGISTRO
	SET @DADOS = REVERSE(SUBSTRING(REVERSE(@DADOS),LEN(@separa_registro)+1,LEN(@DADOS)))
	-- loop para inserir acessorios
	IF @DADOS IS NOT NULL BEGIN

		SET @DADOS = rtrim(ltrim(@DADOS))
		SET @fim = 0
		SET @iini = 1

		WHILE ( @fim = 0 ) BEGIN
			SET @ifim = PATINDEX('%' + @separa_registro + '%', @DADOS )
			IF @ifim = 0 begin
				SET @reg = SUBSTRING( @DADOS, @iini, LEN( @DADOS ) )
			end 
			ELSE begin
				SET @reg = SUBSTRING( @DADOS, @iini, @ifim - 1 )
			end
			--SELECT @reg

			-- retira os 3 campos da string de registro
			SET @st1 = SUBSTRING( @reg, 1, PATINDEX( '%' + @separa_campo + '%', @reg ) -1 )
			set @reg = SUBSTRING(@reg,len(@st1)+len(@separa_campo)+1,len(@reg))
			SET @st2 = SUBSTRING( @reg, 1, PATINDEX( '%' + @separa_campo + '%', @reg ) -1 )
			set @reg = SUBSTRING(@reg,len(@st2)+len(@separa_campo)+1,len(@reg))

			IF (PATINDEX('%' + @separa_registro + '%',@reg) > 0 )
				SET @st3 = SUBSTRING( @reg, 1, len(@reg) - LEN(@separa_registro)  )
			ELSE
				SET @st3 = SUBSTRING( @reg, 1, len(@reg))

			INSERT INTO PARTICIPANTES_EXTERNOS (AG_NUMERO, PE_NOME, PE_EMPRESA, PE_MOTIVO, PE_QUEMINCLUIU)
				VALUES (@pAG_NUMEROIn, @st1, @st2, @st3, 'CLI')
			IF @@ERROR <> 0 BEGIN
				ROLLBACK TRANSACTION
				RAISERROR( 'Não foi possível cadastrar os dados dos participantes', 16, 1)
				SELECT -1 AS AG_NUMERO
				RETURN -1
			END

			SET @DADOS = LTRIM(SUBSTRING( @DADOS, @ifim + len(@separa_registro), LEN(@DADOS) ))
			IF @ifim = 0 SET @fim = 1
		END
	END

	--INSERÇÃO D0S CAMPOS RELATIVOS AOS PARICIPANTES EBT
	SET @DADOS = @pSTR_PARTICIPANTES_EBT
	--RETIRO O ULTIMO SEPARADO DE REGISTRO
	SET @DADOS = REVERSE(SUBSTRING(REVERSE(@DADOS),LEN(@separa_registro)+1,LEN(@DADOS)))
	-- loop para inserir acessorios
	IF @DADOS IS NOT NULL BEGIN

		SET @DADOS = rtrim(ltrim(@DADOS))
		SET @fim = 0
		SET @iini = 1

		WHILE ( @fim = 0 ) BEGIN
			SET @ifim = PATINDEX('%' + @separa_registro + '%', @DADOS )
			IF @ifim = 0 begin
				SET @reg = SUBSTRING( @DADOS, @iini, LEN( @DADOS ) )
			end 
			ELSE begin
				SET @reg = SUBSTRING( @DADOS, @iini, @ifim - 1 )
			end
			--SELECT @reg

			-- retira os 3 campos da string de registro
			SET @st1 = SUBSTRING( @reg, 1, PATINDEX( '%' + @separa_campo + '%', @reg ) -1 )
			set @reg = SUBSTRING(@reg,len(@st1)+len(@separa_campo)+1,len(@reg))
			SET @st2 = SUBSTRING( @reg, 1, PATINDEX( '%' + @separa_campo + '%', @reg ) -1 )
			set @reg = SUBSTRING(@reg,len(@st2)+len(@separa_campo)+1,len(@reg))

			IF (PATINDEX('%' + @separa_registro + '%',@reg) > 0 )
				SET @st3 = SUBSTRING( @reg, 1, len(@reg) - LEN(@separa_registro)  )
			ELSE
				SET @st3 = SUBSTRING( @reg, 1, len(@reg))

			INSERT INTO PARTICIPANTES_EXTERNOS (AG_NUMERO, PE_USERNAME,PE_NOME, PE_EMPRESA, PE_MOTIVO, PE_QUEMINCLUIU)
				VALUES (@pAG_NUMEROIn, @st1, @st2, 'EBT', @st3, 'CLI')
			IF @@ERROR <> 0 BEGIN
				ROLLBACK TRANSACTION
				RAISERROR( 'Não foi possível cadastrar os dados dos participantes', 16, 1)
				SELECT -1 AS AG_NUMERO
				RETURN -1
			END

			SET @DADOS = LTRIM(SUBSTRING( @DADOS, @ifim + len(@separa_registro), LEN(@DADOS) ))
			IF @ifim = 0 SET @fim = 1
		END
	END

	COMMIT TRANSACTION
	SELECT @pAG_NUMEROIn as AG_NUMERO
	RETURN @pAG_NUMEROIn
END
GO


DROP PROCEDURE dbo.sp_CadAgendamentoRAT
GO
CREATE PROCEDURE dbo.sp_CadAgendamentoRAT
	@separa_campo varchar(4),
	@separa_registro varchar(4),
	@pAG_NUMERO smallint,
	@pTA_ID smallint,
 	@pID_SITUACAO smallint,
 	@pHE_MOTIVO varchar(200),
 	@pAG_Responsavel varchar(20),
 	@pAG_RAT varchar(20),
	@pHE_DataInicio varchar(20),
	@pAG_NECESSITA_OS BIT,
	@pAG_Relat_RAT text,
	@repeticao BIT,
	@executante BIT,
	@pAMBIENTES VARCHAR(8000),
	@pSTR_PARTICIPANTES_EBT VARCHAR(8000)
AS
BEGIN
	SET NOCOUNT ON

	BEGIN TRANSACTION

	DECLARE @SITUACAO_ATUAL SMALLINT

	SELECT @SITUACAO_ATUAL = ID_SITUACAO FROM HISTORICO_EVENTOS WHERE AG_NUMERO = @pAG_NUMERO AND HE_DATATERMINO IS NULL

	--SE FOR UMA MUDANÇA DE STATUS
	IF @SITUACAO_ATUAL <> @pID_SITUACAO BEGIN

		--SETO O STATUS ANTERIOR COMO FINALIZADO TENDO COMO DATA DE TERMINO O INICIO DO ESTADO ATUAL
		UPDATE HISTORICO_EVENTOS
 		SET HE_DATATERMINO = CONVERT(SMALLDATETIME,@pHE_DataInicio,103)
	 	WHERE AG_NUMERO = @pAG_NUMERO AND HE_DATATERMINO IS NULL
	 	IF @@ERROR  <> 0 BEGIN
			ROLLBACK TRANSACTION
			SELECT -1 AS SAIDA, 'Não foi possível atualizar histórico de eventos' AS MENSAGEM
			RETURN -1
		END

 		--SE FOR UMA SITUAÇÃO FINAL EU SETO EM TAREFAS PREVISTAS COMO TENDO TERMINADO
		IF @pID_SITUACAO IN (4, 5, 8) BEGIN
	 		INSERT INTO HISTORICO_EVENTOS(AG_NUMERO, HE_RESPONSAVEL, ID_SITUACAO, HE_DATAINICIO, HE_DATATERMINO, HE_MOTIVO)
 			VALUES(@pAG_NUMERO, @pAG_Responsavel, @pID_SITUACAO, Convert(smalldatetime,@pHE_DataInicio,103), Convert(smalldatetime,@pHE_DataInicio,103), @pHE_MOTIVO)
		 	IF @@ERROR  <> 0 BEGIN
				ROLLBACK TRANSACTION
				SELECT -1 AS SAIDA, 'Não foi possível inserir histórico de eventos' AS MENSAGEM
				RETURN -1
			END

			UPDATE Tarefas_Previstas SET TP_DATAFINAL = Convert(smalldatetime,@pHE_DataInicio,103) WHERE TAREFA_ID = @pAG_NUMERO and Tarefa_Tipo = 0
		 	IF @@ERROR  <> 0 BEGIN
				ROLLBACK TRANSACTION
				SELECT -1 AS SAIDA, 'Não foi possível atualizar tarefas do técnico' AS MENSAGEM
				RETURN -1
			END
 		END

		--SE NÃO APENOS INSIRO NA TABELA HISTORICO EVENTOS A SITUAÇÃO ATUAL
	 	ELSE BEGIN
 			INSERT INTO HISTORICO_EVENTOS(AG_NUMERO, HE_RESPONSAVEL, ID_SITUACAO, HE_DATAINICIO, HE_MOTIVO)
	 			VALUES(@pAG_NUMERO, @pAG_Responsavel, @pID_SITUACAO, Convert(smalldatetime,@pHE_DataInicio,103), @pHE_MOTIVO)
		 	IF @@ERROR  <> 0 BEGIN
				ROLLBACK TRANSACTION
				SELECT -1 AS SAIDA, 'Não foi possível inserir histórico de eventos' AS MENSAGEM
				RETURN -1
			END
	 	END
	END


	-- apago os ambientes reservados ao agendamento (apenas os q são de uso para testes)
	DELETE FROM Reserva_Ambientes 
	WHERE RAM_AS = @pAG_NUMERO AND 
		EXISTS (SELECT AMB_ID FROM Ambientes WHERE AMB_ID = Reserva_Ambientes.AMB_ID AND AMB_USADOPORAG = 1)
 	IF @@ERROR  <> 0 BEGIN
		ROLLBACK TRANSACTION
		SELECT -1 AS SAIDA, 'Não foi possível excluir reserva de ambientes' AS MENSAGEM
		RETURN -1
	END

	--VARIÁVEIS NECESSÁRIAS PARA QUEBRA DAS STRINGS
	DECLARE @reg VARCHAR(8000), @fim BIT, @iini INT, @ifim INT
	DECLARE @DADOS VARCHAR(8000)
	DECLARE @st1 VARCHAR(8000), @st2 VARCHAR(8000), @st3 VARCHAR(8000), @st4 VARCHAR(8000), @st5 VARCHAR(8000)

	SET @DADOS = @pAMBIENTES

	--RETIRO O ULTIMO SEPARADO DE REGISTRO
	SET @DADOS = REVERSE(SUBSTRING(REVERSE(@DADOS),LEN(@separa_registro)+1,LEN(@DADOS)))

	-- loop para inserir os ambientes
	IF (@DADOS IS NOT NULL) AND (@DADOS <> '') BEGIN
		DECLARE @AG_DATAINICIO DATETIME, @AG_DATATERMINO DATETIME
		DECLARE @CONTATO VARCHAR(50)

		SELECT @AG_DATAINICIO = AG_DATAINICIO, @AG_DATATERMINO = AG_DATATERMINO,
			@CONTATO = AG_USERNAME
			FROM AGENDAMENTO WHERE AG_NUMERO = @pAG_NUMERO

		SET @DADOS = rtrim(ltrim(@DADOS))
		SET @fim = 0
		SET @iini = 1

		WHILE ( @fim = 0 ) BEGIN
			SET @ifim = PATINDEX('%' + @separa_registro + '%', @DADOS )
			IF @ifim = 0 begin
				SET @reg = SUBSTRING( @DADOS, @iini, LEN( @DADOS ) )
			end 
			ELSE begin
				SET @reg = SUBSTRING( @DADOS, @iini, @ifim - 1 )
			end
			
			INSERT INTO Reserva_Ambientes 
				(RAM_DataInicio, RAM_DataFim, RAM_Horario, 
				RAM_Titulo, RAM_Descricao, AMB_ID, 
				RAM_Contato, RAM_Responsavel, RAM_AS)
				VALUES 
				( @AG_DATAINICIO, @AG_DATATERMINO, 'PERÍODO DE DURAÇÃO DESTA AS', 'RESERVA PARA AS:' + CAST(@pAG_NUMERO AS VARCHAR), 
				'RESERVA DO AMBIENTE PARA O AGENDAMENTO', @reg, @CONTATO,
				@pAG_Responsavel, @pAG_NUMERO)
			IF @@ERROR <> 0 BEGIN
				ROLLBACK TRANSACTION
				SELECT -1 AS SAIDA, 'Não foi possível cadastrar ambientes' AS MENSAGEM
				RETURN -1
			END

			SET @DADOS = LTRIM(SUBSTRING( @DADOS, @ifim + len(@separa_registro), LEN(@DADOS) ))
			IF @ifim = 0 SET @fim = 1
		END
	END


	--ATUALIZO OS DADOS DA AS
	UPDATE AGENDAMENTO 
	SET AG_RAT = @pAG_RAT,
	        AG_RESPONSAVEL = @pAG_Responsavel,
	        AG_NECESSITA_OS = @pAG_NECESSITA_OS,
	        AG_REPETIDO = @repeticao,
	        AG_EXECUTANTE = @executante,
 	        TA_ID = @pTA_ID,
	        AG_Relat_RAT = @pAG_Relat_RAT
	WHERE	AG_NUMERO = @pAG_NUMERO
 	IF @@ERROR  <> 0 BEGIN
		ROLLBACK TRANSACTION
		SELECT -1 AS SAIDA, 'Não foi possível atualizar agendamento' AS MENSAGEM
		RETURN -1
	END


	-- apago os participantes incluidos pelo RAT
	DELETE FROM PARTICIPANTES_EXTERNOS WHERE AG_NUMERO = @pAG_NUMERO AND PE_QUEMINCLUIU = 'RAT'
	IF @@ERROR <> 0 BEGIN
		ROLLBACK TRANSACTION
		RAISERROR( 'Não foi possível excluir os participantes do agendamento', 16, 1 )
		SELECT -1 AS AG_NUMERO
		RETURN -1
	END


	--INSERÇÃO D0S CAMPOS RELATIVOS AOS PARICIPANTES EBT
	SET @DADOS = @pSTR_PARTICIPANTES_EBT
	--RETIRO O ULTIMO SEPARADO DE REGISTRO
	SET @DADOS = REVERSE(SUBSTRING(REVERSE(@DADOS),LEN(@separa_registro)+1,LEN(@DADOS)))
	-- loop para inserir acessorios
	IF @DADOS IS NOT NULL BEGIN

		SET @DADOS = rtrim(ltrim(@DADOS))
		SET @fim = 0
		SET @iini = 1

		WHILE ( @fim = 0 ) BEGIN
			SET @ifim = PATINDEX('%' + @separa_registro + '%', @DADOS )
			IF @ifim = 0 begin
				SET @reg = SUBSTRING( @DADOS, @iini, LEN( @DADOS ) )
			end 
			ELSE begin
				SET @reg = SUBSTRING( @DADOS, @iini, @ifim - 1 )
			end
			--SELECT @reg

			-- retira os 3 campos da string de registro
			SET @st1 = SUBSTRING( @reg, 1, PATINDEX( '%' + @separa_campo + '%', @reg ) -1 )
			set @reg = SUBSTRING(@reg,len(@st1)+len(@separa_campo)+1,len(@reg))
			SET @st2 = SUBSTRING( @reg, 1, PATINDEX( '%' + @separa_campo + '%', @reg ) -1 )
			set @reg = SUBSTRING(@reg,len(@st2)+len(@separa_campo)+1,len(@reg))

			IF (PATINDEX('%' + @separa_registro + '%',@reg) > 0 )
				SET @st3 = SUBSTRING( @reg, 1, len(@reg) - LEN(@separa_registro)  )
			ELSE
				SET @st3 = SUBSTRING( @reg, 1, len(@reg))

			INSERT INTO PARTICIPANTES_EXTERNOS (AG_NUMERO, PE_USERNAME,PE_NOME, PE_EMPRESA, PE_MOTIVO, PE_QUEMINCLUIU)
				VALUES (@pAG_NUMERO, @st1, @st2, 'EBT', @st3, 'RAT')
			IF @@ERROR <> 0 BEGIN
				ROLLBACK TRANSACTION
				RAISERROR( 'Não foi possível cadastrar os dados dos participantes', 16, 1)
				SELECT -1 AS AG_NUMERO
				RETURN -1
			END

			SET @DADOS = LTRIM(SUBSTRING( @DADOS, @ifim + len(@separa_registro), LEN(@DADOS) ))
			IF @ifim = 0 SET @fim = 1
		END
	END

	COMMIT TRANSACTION

	SELECT @pAG_NUMERO AS SAIDA, 'OK' AS MENSAGEM
	RETURN @pAG_NUMERO
END
GO


DROP PROCEDURE dbo.sp_CadAgendamentoRT
GO
CREATE PROCEDURE dbo.sp_CadAgendamentoRT
	@separa_campo varchar(4),
	@separa_registro varchar(4),
	@STR_SERVICO VARCHAR(8000),
	@STR_SISTEMA VARCHAR(8000),	
	@pAG_Relat_RT text,
	@pAG_NUMERO smallint,
	@pSTR_PARTICIPANTES_EBT VARCHAR(8000)
AS
BEGIN
	SET NOCOUNT ON 
	BEGIN TRANSACTION

	UPDATE AGENDAMENTO SET AG_Relat_RT = @pAG_Relat_RT
		WHERE AG_NUMERO = @pAG_NUMERO
	IF @@ERROR <> 0 BEGIN
		ROLLBACK TRANSACTION
		RAISERROR( 'Não foi atualizar o agendamento', 16, 1)
		RETURN -1
	END

	--VARIÁVEIS NECESSÁRIAS PARA QUEBRA DAS STRINGS
	DECLARE @reg VARCHAR(8000), @fim BIT, @iini INT, @ifim INT
	DECLARE @DADOS VARCHAR(8000)
	DECLARE @st1 VARCHAR(8000), @st2 VARCHAR(8000), @st3 VARCHAR(8000)

	SET @DADOS = @STR_SISTEMA

	DELETE FROM AGENDA_SERVICOS_PLATAFORMA WHERE AG_NUMERO = @pAG_NUMERO
	IF @@ERROR <> 0 BEGIN
		ROLLBACK TRANSACTION
		RAISERROR( 'Não foi possível excluir os serviços', 16, 1)
		RETURN -1
	END

	--RETIRO O ULTIMO SEPARADO DE REGISTRO
	SET @DADOS = REVERSE(SUBSTRING(REVERSE(@DADOS),LEN(@separa_registro)+1,LEN(@DADOS)))

	-- loop para inserir os sistemas
	IF @DADOS IS NOT NULL BEGIN
		SET @DADOS = rtrim(ltrim(@DADOS))
		SET @fim = 0
		SET @iini = 1

		WHILE ( @fim = 0 ) BEGIN
			SET @ifim = PATINDEX('%' + @separa_registro + '%', @DADOS )
			IF @ifim = 0 begin
				SET @reg = SUBSTRING( @DADOS, @iini, LEN( @DADOS ) )
			end 
			ELSE begin
				SET @reg = SUBSTRING( @DADOS, @iini, @ifim - 1 )
			end
			SELECT @reg
			
			-- retira os 3 campos da string de registro
			SET @st1 = SUBSTRING( @reg, 1, PATINDEX( '%' + @separa_campo + '%', @reg ) -1 )

			/*IF (PATINDEX('%' + @separa_registro + '%',@reg) > 0 )
				SET @st3 = SUBSTRING( @reg, 1, len(@reg) - LEN(@separa_registro)  )
			ELSE
				SET @st3 = SUBSTRING( @reg, 1, len(@reg))*/

			INSERT INTO AGENDA_SERVICOS_PLATAFORMA (AG_NUMERO, S_ID)
				VALUES (@pAG_NUMERO,@st1)
			IF @@ERROR <> 0 BEGIN
				ROLLBACK TRANSACTION
				RAISERROR( 'Não foi possível cadastrar os dados dos serviços', 16, 1)
				RETURN -1
			END

			SET @DADOS = LTRIM(SUBSTRING( @DADOS, @ifim + len(@separa_registro), LEN(@DADOS) ))
			IF @ifim = 0 SET @fim = 1
		END
	END

	SET @DADOS = @STR_SERVICO
	--RETIRO O ULTIMO SEPARADO DE REGISTRO
	SET @DADOS = REVERSE(SUBSTRING(REVERSE(@DADOS),LEN(@separa_registro)+1,LEN(@DADOS)))

	-- loop para inserir os servicos
	IF @DADOS IS NOT NULL BEGIN
		SET @DADOS = rtrim(ltrim(@DADOS))
		SET @fim = 0
		SET @iini = 1

		WHILE ( @fim = 0 ) BEGIN
			SET @ifim = PATINDEX('%' + @separa_registro + '%', @DADOS )
			IF @ifim = 0 begin
				SET @reg = SUBSTRING( @DADOS, @iini, LEN( @DADOS ) )
			end 
			ELSE begin
				SET @reg = SUBSTRING( @DADOS, @iini, @ifim - 1 )
			end
			SELECT @reg
			-- retira os 3 campos da string de registro
			SET @st1 = SUBSTRING( @reg, 1, PATINDEX( '%' + @separa_campo + '%', @reg ) -1 )

			/*IF (PATINDEX('%' + @separa_registro + '%',@reg) > 0 )
				SET @st3 = SUBSTRING( @reg, 1, len(@reg) - LEN(@separa_registro)  )
			ELSE
				SET @st3 = SUBSTRING( @reg, 1, len(@reg))*/

			INSERT INTO AGENDA_SERVICOS_PLATAFORMA (AG_NUMERO, S_ID)
				VALUES (@pAG_NUMERO,@st1)
			IF @@ERROR <> 0 BEGIN
				ROLLBACK TRANSACTION
				RAISERROR( 'Não foi possível cadastrar os dados dos serviços', 16, 1)
				RETURN -1
			END

			SET @DADOS = LTRIM(SUBSTRING( @DADOS, @ifim + len(@separa_registro), LEN(@DADOS) ))
			IF @ifim = 0 SET @fim = 1
		END
	END


	-- apago os participantes incluidos pelo RAT
	DELETE FROM PARTICIPANTES_EXTERNOS WHERE AG_NUMERO = @pAG_NUMERO AND PE_QUEMINCLUIU = 'RTE'
	IF @@ERROR <> 0 BEGIN
		ROLLBACK TRANSACTION
		RAISERROR( 'Não foi possível excluir os participantes do agendamento', 16, 1 )
		SELECT -1 AS AG_NUMERO
		RETURN -1
	END


	--INSERÇÃO D0S CAMPOS RELATIVOS AOS PARICIPANTES EBT
	SET @DADOS = @pSTR_PARTICIPANTES_EBT
	--RETIRO O ULTIMO SEPARADO DE REGISTRO
	SET @DADOS = REVERSE(SUBSTRING(REVERSE(@DADOS),LEN(@separa_registro)+1,LEN(@DADOS)))
	-- loop para inserir acessorios
	IF @DADOS IS NOT NULL BEGIN

		SET @DADOS = rtrim(ltrim(@DADOS))
		SET @fim = 0
		SET @iini = 1

		WHILE ( @fim = 0 ) BEGIN
			SET @ifim = PATINDEX('%' + @separa_registro + '%', @DADOS )
			IF @ifim = 0 begin
				SET @reg = SUBSTRING( @DADOS, @iini, LEN( @DADOS ) )
			end 
			ELSE begin
				SET @reg = SUBSTRING( @DADOS, @iini, @ifim - 1 )
			end
			--SELECT @reg

			-- retira os 3 campos da string de registro
			SET @st1 = SUBSTRING( @reg, 1, PATINDEX( '%' + @separa_campo + '%', @reg ) -1 )
			set @reg = SUBSTRING(@reg,len(@st1)+len(@separa_campo)+1,len(@reg))
			SET @st2 = SUBSTRING( @reg, 1, PATINDEX( '%' + @separa_campo + '%', @reg ) -1 )
			set @reg = SUBSTRING(@reg,len(@st2)+len(@separa_campo)+1,len(@reg))

			IF (PATINDEX('%' + @separa_registro + '%',@reg) > 0 )
				SET @st3 = SUBSTRING( @reg, 1, len(@reg) - LEN(@separa_registro)  )
			ELSE
				SET @st3 = SUBSTRING( @reg, 1, len(@reg))

			INSERT INTO PARTICIPANTES_EXTERNOS (AG_NUMERO, PE_USERNAME,PE_NOME, PE_EMPRESA, PE_MOTIVO, PE_QUEMINCLUIU)
				VALUES (@pAG_NUMERO, @st1, @st2, 'EBT', @st3, 'RTE')
			IF @@ERROR <> 0 BEGIN
				ROLLBACK TRANSACTION
				RAISERROR( 'Não foi possível cadastrar os dados dos participantes', 16, 1)
				SELECT -1 AS AG_NUMERO
				RETURN -1
			END

			SET @DADOS = LTRIM(SUBSTRING( @DADOS, @ifim + len(@separa_registro), LEN(@DADOS) ))
			IF @ifim = 0 SET @fim = 1
		END
	END

	COMMIT TRANSACTION
	RETURN 1
END
GO
