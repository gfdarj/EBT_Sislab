/****** Object:  StoredProcedure [dbo].[SP_AG_ALOCA]    Script Date: 07/19/2018 18:45:13 ******/
IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[dbo].[SP_AG_ALOCA]') AND OBJECTPROPERTY(id,N'IsProcedure') = 1)
	DROP PROCEDURE [dbo].[sp_Ag_Aloca]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[sp_Ag_Aloca] (
	@tarefa_id		INT,
	@tp_datainicial	VARCHAR(10),
	@tp_datafinal	VARCHAR(10),
	@pes_username	VARCHAR(80),
	@tp_observacao	VARCHAR(8000),
	@tarefa_tipo	BIT
)
AS
BEGIN
	SET NOCOUNT ON

	SELECT TP_ID FROM TAREFAS_PREVISTAS
	WHERE 
		PES_USERNAME = @pes_username 
	AND	TAREFA_ID = @tarefa_id
	AND	TAREFA_TIPO = @tarefa_tipo
	AND  (	(
		CONVERT(DATETIME, @tp_datainicial, 103) BETWEEN TP_DATAINICIAL AND TP_DATAFINAL 
		OR CONVERT(DATETIME, @tp_datafinal, 103) BETWEEN TP_DATAINICIAL AND TP_DATAFINAL	
		)
	OR 	(
		CONVERT(DATETIME, @tp_datainicial, 103) < TP_DATAINICIAL 
		AND CONVERT(DATETIME, @tp_datafinal, 103) > TP_DATAFINAL	
		)
			  )

	IF @@ROWCOUNT = 0 
	BEGIN
		INSERT INTO TAREFAS_PREVISTAS (TAREFA_ID, TP_DATAINICIAL, TP_DATAFINAL, PES_USERNAME, TP_OBSERVACAO, TAREFA_TIPO)
		VALUES (@tarefa_id, CONVERT(DATETIME,@tp_datainicial,103), CONVERT(DATETIME,@tp_datafinal,103), @pes_username, @tp_observacao, @tarefa_tipo)
		IF @@ERROR > 0
			RETURN -1
	END
	ELSE
		RETURN -2  -- Periodo de Alocacao Invalido

	RETURN 1 -- Alocado com sucesso
END
GO

/****** Object:  StoredProcedure [dbo].[SP_AG_BUSCA_FERIADOS]    Script Date: 07/19/2018 18:45:13 ******/
IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[dbo].[SP_AG_BUSCA_FERIADOS]') AND OBJECTPROPERTY(id,N'IsProcedure') = 1)
	DROP PROCEDURE [dbo].[sp_Ag_Busca_Feriados]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[sp_Ag_Busca_Feriados] (
	@data	VARCHAR(10)
)
AS
BEGIN
	DECLARE @datainicio DATETIME, @datafim DATETIME
	SET @datainicio = CONVERT(DATETIME, @data, 103)
	SET @datafim =DATEADD(DD, 13, CONVERT(DATETIME, @data, 103))

	SELECT FER_ID, FER_ANOINICIO, FER_ANOFIM, FER_DATA,
		CONVERT(DATETIME, CAST(DAY(FER_DATA) AS VARCHAR)+'/'+CAST(MONTH(FER_DATA) AS VARCHAR)+'/'+CAST(YEAR(@datainicio) AS VARCHAR), 103) AS DATA_FERIADO,
		FER_DESCRICAO 
	FROM FERIADO
	WHERE(   
			( FER_ANOINICIO <= YEAR(CONVERT(DATETIME, @data, 103)) AND FER_ANOFIM >= YEAR(CONVERT(DATETIME, @data, 103)) ) 
	OR		( FER_ANOINICIO IS NULL AND FER_ANOFIM IS NULL )    
		)
	AND	(
		( @datainicio <= CONVERT(DATETIME, CAST(DAY(FER_DATA) AS VARCHAR)+'/'+CAST(MONTH(FER_DATA) AS VARCHAR)+'/'+CAST(YEAR(@datainicio) AS VARCHAR), 103)
	AND	@datafim >= CONVERT(DATETIME, CAST(DAY(FER_DATA) AS VARCHAR)+'/'+CAST(MONTH(FER_DATA) AS VARCHAR)+'/'+CAST(YEAR(@datainicio) AS VARCHAR), 103) )
	OR
		( @datainicio <= CONVERT(DATETIME, CAST(DAY(FER_DATA) AS VARCHAR)+'/'+CAST(MONTH(FER_DATA) AS VARCHAR)+'/'+CAST(YEAR(@datafim) AS VARCHAR), 103)
	AND	@datafim >= CONVERT(DATETIME, CAST(DAY(FER_DATA) AS VARCHAR)+'/'+CAST(MONTH(FER_DATA) AS VARCHAR)+'/'+CAST(YEAR(@datafim) AS VARCHAR), 103) )
		)
	ORDER BY DATA_FERIADO

	PRINT CAST(@datainicio AS VARCHAR) + ' a ' + CAST(@datafim AS VARCHAR)
END
GO

/****** Object:  StoredProcedure [dbo].[SP_AG_CADASTRA_TAREFA]    Script Date: 07/19/2018 18:45:13 ******/
IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[dbo].[SP_AG_CADASTRA_TAREFA]') AND OBJECTPROPERTY(id,N'IsProcedure') = 1)
	DROP PROCEDURE [dbo].[sp_Ag_Cadastra_Tarefa]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[sp_Ag_Cadastra_Tarefa] (
	@tar_descricao		VARCHAR(255)
)
AS
BEGIN
	SET NOCOUNT ON

	SELECT TAR_ID FROM TAREFAS WHERE TAR_DESCRICAO = @tar_descricao

	IF @@ROWCOUNT = 0 
	BEGIN
		INSERT INTO TAREFAS (TAR_DESCRICAO)
		VALUES (@tar_descricao)
		IF @@ERROR > 0
			RETURN -1
		ELSE
			RETURN @@IDENTITY
	END
	ELSE
		RETURN -2  -- Nome já cadastrado
END
GO


/****** Object:  StoredProcedure [dbo].[SP_AG_PESSOAS_POR_PERIODO]    Script Date: 07/19/2018 18:45:13 ******/
IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[dbo].[SP_AG_PESSOAS_POR_PERIODO]') AND OBJECTPROPERTY(id,N'IsProcedure') = 1)
	DROP PROCEDURE [dbo].[sp_Ag_Pessoas_Por_Periodo]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[sp_Ag_Pessoas_Por_Periodo]
(
	@datainicial VARCHAR(10),
	@datafinal VARCHAR(10),
	@username VARCHAR(80)
)
AS
BEGIN
	DECLARE @D1 SMALLDATETIME
	DECLARE @D2 SMALLDATETIME
	SET @D1 = CONVERT(SMALLDATETIME, @datainicial, 103)
	SET @D2 = CONVERT(SMALLDATETIME, @datafinal, 103)

	IF @username = '-1' OR @username IS NULL BEGIN
		SELECT PES_USERNAME, NOME, TAREFA_ID, 'TAR' AS TAREFA_TIPO, T.TAR_DESCRICAO AS DESCRICAO, TP_DATAINICIAL, TP_DATAFINAL, NULL AS ID_SITUACAO, NULL AS S_DESCRICAO
		FROM TAREFAS_PREVISTAS AS TP
		INNER JOIN TAREFAS AS T ON TP.TAREFA_ID = T.TAR_ID AND TAREFA_TIPO = 1
		INNER JOIN USERCRT AS U ON TP.PES_USERNAME = U.USERID
		WHERE 	(@D1 BETWEEN TP_DATAINICIAL AND TP_DATAFINAL)
		OR	(@D2 BETWEEN TP_DATAINICIAL AND TP_DATAFINAL)
		OR	(TP_DATAINICIAL > @D1 AND TP_DATAFINAL < @D2)

		UNION

		-- RT
		SELECT a.AG_RESPONSAVEL, u.NOME, AG_NUMERO, 'AS' AS  TAREFA_TIPO, A.AG_TITULO AS DESCRICAO, a.AG_DATAINICIO, a.AG_DATATERMINO, ID_SITUACAO, S_DESCRICAO
		FROM vw_Agendamento AS A INNER JOIN USERCRT AS U ON a.AG_RESPONSAVEL = U.USERID
		WHERE 	(@D1 BETWEEN AG_DATAINICIO AND AG_DATATERMINO)
		OR	(@D2 BETWEEN AG_DATAINICIO AND AG_DATATERMINO)
		OR	(AG_DATAINICIO > @D1 AND AG_DATATERMINO < @D2)

		UNION

		-- RAT
		SELECT a.AG_RAT, u.NOME, AG_NUMERO, 'AS' AS  TAREFA_TIPO, A.AG_TITULO AS DESCRICAO, a.AG_DATAINICIO, a.AG_DATATERMINO, ID_SITUACAO, S_DESCRICAO
		FROM vw_Agendamento AS A INNER JOIN USERCRT AS U ON a.AG_RAT = U.USERID
		WHERE 	(@D1 BETWEEN AG_DATAINICIO AND AG_DATATERMINO)
		OR	(@D2 BETWEEN AG_DATAINICIO AND AG_DATATERMINO)
		OR	(AG_DATAINICIO > @D1 AND AG_DATATERMINO < @D2)

		ORDER BY PES_USERNAME, TAREFA_TIPO, TAREFA_ID
	END
	ELSE 
	BEGIN
		SELECT PES_USERNAME, NOME, TAREFA_ID, 'TAR' AS TAREFA_TIPO, T.TAR_DESCRICAO AS DESCRICAO, TP_DATAINICIAL, TP_DATAFINAL, NULL AS ID_SITUACAO, NULL AS S_DESCRICAO
		FROM TAREFAS_PREVISTAS AS TP
		INNER JOIN TAREFAS AS T ON TP.TAREFA_ID = T.TAR_ID AND TAREFA_TIPO = 1
		INNER JOIN USERCRT AS U ON TP.PES_USERNAME = U.USERID
		WHERE 	((@D1 BETWEEN TP_DATAINICIAL AND TP_DATAFINAL)
		OR	(@D2 BETWEEN TP_DATAINICIAL AND TP_DATAFINAL)
		OR	(TP_DATAINICIAL > @D1 AND TP_DATAFINAL < @D2))
		AND UPPER(TP.PES_USERNAME) = UPPER(@username)

		UNION

		-- RT
		SELECT a.AG_RESPONSAVEL, u.NOME, AG_NUMERO, 'AS' AS  TAREFA_TIPO, A.AG_TITULO AS DESCRICAO, a.AG_DATAINICIO, a.AG_DATATERMINO, ID_SITUACAO, S_DESCRICAO
		FROM vw_Agendamento AS A INNER JOIN USERCRT AS U ON a.AG_RESPONSAVEL = U.USERID
		WHERE 	((@D1 BETWEEN AG_DATAINICIO AND AG_DATATERMINO)
		OR	(@D2 BETWEEN AG_DATAINICIO AND AG_DATATERMINO)
		OR	(AG_DATAINICIO > @D1 AND AG_DATATERMINO < @D2))
		AND UPPER(a.AG_RESPONSAVEL) = UPPER(@username)

		UNION

		-- RAT
		SELECT a.AG_RAT, u.NOME, AG_NUMERO, 'AS' AS  TAREFA_TIPO, A.AG_TITULO AS DESCRICAO, a.AG_DATAINICIO, a.AG_DATATERMINO, ID_SITUACAO, S_DESCRICAO
		FROM vw_Agendamento AS A INNER JOIN USERCRT AS U ON a.AG_RAT = U.USERID
		WHERE 	((@D1 BETWEEN AG_DATAINICIO AND AG_DATATERMINO)
		OR	(@D2 BETWEEN AG_DATAINICIO AND AG_DATATERMINO)
		OR	(AG_DATAINICIO > @D1 AND AG_DATATERMINO < @D2))
		AND UPPER(a.AG_RAT) = UPPER(@username)

		ORDER BY PES_USERNAME, TAREFA_TIPO, TAREFA_ID
	END
END
GO


/****** Object:  StoredProcedure [dbo].[SP_AG_RELOCA]    Script Date: 07/19/2018 18:45:13 ******/
IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[dbo].[SP_AG_RELOCA]') AND OBJECTPROPERTY(id,N'IsProcedure') = 1)
DROP PROCEDURE [dbo].[sp_Ag_Reloca]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[sp_Ag_Reloca]
(
	@tp_id			INT,
	@tarefa_id		INT,
	@tp_datainicial	VARCHAR(10),
	@tp_datafinal	VARCHAR(10),
	@pes_username	VARCHAR(80),
	@tp_observacao	VARCHAR(8000),
	@tarefa_tipo	BIT
)
AS
BEGIN
	SET NOCOUNT ON

	SELECT TP_ID FROM TAREFAS_PREVISTAS
	WHERE 
		PES_USERNAME = @pes_username 
	AND	TAREFA_ID = @tarefa_id
	AND	TAREFA_TIPO = @tarefa_tipo
	AND 	TP_ID <> @tp_id
	AND (	(
		CONVERT(DATETIME, @tp_datainicial, 103) BETWEEN TP_DATAINICIAL AND TP_DATAFINAL 
		OR CONVERT(DATETIME, @tp_datafinal, 103) BETWEEN TP_DATAINICIAL AND TP_DATAFINAL	
		)
	OR 	(
		CONVERT(DATETIME, @tp_datainicial, 103) < TP_DATAINICIAL 
		AND CONVERT(DATETIME, @tp_datafinal, 103) > TP_DATAFINAL	
		)
			 )


	IF @@ROWCOUNT > 0 
		RETURN -2  -- Periodo de Alocacao Invalido
	ELSE
	BEGIN
		UPDATE TAREFAS_PREVISTAS 
		SET 
			TAREFA_ID = @tarefa_id,
			TP_DATAINICIAL = CONVERT(DATETIME,@tp_datainicial,103), 
			TP_DATAFINAL = CONVERT(DATETIME,@tp_datafinal,103), 
			PES_USERNAME = @pes_username, 
			TP_OBSERVACAO = @tp_observacao, 
			TAREFA_TIPO = @tarefa_tipo
		WHERE TP_ID = @tp_id
		IF @@ERROR > 0
			RETURN -1
		ELSE
			RETURN 1 -- Alocado com sucesso
	END
END
GO

/****** Object:  StoredProcedure [dbo].[SP_AG_REMOVE]    Script Date: 07/19/2018 18:45:13 ******/
IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[dbo].[SP_AG_REMOVE]') AND OBJECTPROPERTY(id,N'IsProcedure') = 1)
DROP PROCEDURE [dbo].[sp_Ag_Remove]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[sp_Ag_Remove]
(
	@tp_id		INT
)
AS
BEGIN
	DELETE FROM TAREFAS_PREVISTAS WHERE TP_ID=@tp_id
	IF @@ERROR > 0
		RETURN -1
	ELSE
		RETURN 1 -- Removido com sucesso
END
GO


/****** Object:  StoredProcedure [dbo].[sp_ApagaAgendamento]    Script Date: 07/19/2018 18:45:13 ******/
IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[dbo].[sp_ApagaAgendamento]') AND OBJECTPROPERTY(id,N'IsProcedure') = 1)
DROP PROCEDURE [dbo].[sp_ApagaAgendamento]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[sp_ApagaAgendamento]
(
	@pAG_NUMERO INT
)
AS
BEGIN
	/* Apaga um Agendamento e TODAS as suas OS´s */
	SET NOCOUNT ON
	BEGIN TRANSACTION

	EXEC sp_ApagaOrdemDeServico @pAG_NUMERO, NULL
	IF @@ERROR <> 0 BEGIN
		ROLLBACK TRANSACTION
		RAISERROR( 'Não foi possível excluir as OS´s do agendamento.', 16, 1 )
		RETURN -1
	END

	DELETE from tarefas_previstas WHERE tarefa_id = @pAG_NUMERO and tarefa_tipo = 0
	IF @@ERROR <> 0 BEGIN
		ROLLBACK TRANSACTION
		RAISERROR( 'Não foi possível excluir as tarefas do agendamento.', 16, 1 )
		RETURN -1
	END

	DELETE Historico_Eventos WHERE AG_NUMERO = @pAG_NUMERO
	IF @@ERROR <> 0 BEGIN
		ROLLBACK TRANSACTION
		RAISERROR( 'Não foi possível excluir o histórico de eventos do agendamento.', 16, 1 )
		RETURN -1
	END

	DELETE Agenda_Servicos_Plataforma WHERE AG_NUMERO = @pAG_NUMERO
	IF @@ERROR <> 0 BEGIN
		ROLLBACK TRANSACTION
		RAISERROR( 'Não foi possível excluir o serviço do agendamento.', 16, 1 )
		RETURN -1
	END

	DELETE Diagramas WHERE AG_NUMERO = @pAG_NUMERO
	IF @@ERROR <> 0 BEGIN
		ROLLBACK TRANSACTION
		RAISERROR( 'Não foi possível excluir os arquivos relacionados ao agendamento.', 16, 1 )
		RETURN -1
	END

	DELETE LogBook_Agendamento WHERE AG_NUMERO = @pAG_NUMERO
	IF @@ERROR <> 0 BEGIN
		ROLLBACK TRANSACTION
		RAISERROR( 'Não foi possível excluir as ocorrências deste agendamento.', 16, 1 )
		RETURN -1
	END

	DELETE Participantes_Externos WHERE AG_NUMERO = @pAG_NUMERO
	IF @@ERROR <> 0 BEGIN
		ROLLBACK TRANSACTION
		RAISERROR( 'Não foi possível excluir os participantes externos do agendamento.', 16, 1 )
		RETURN -1
	END

	DELETE Historico_Datas WHERE AG_NUMERO = @pAG_NUMERO
	IF @@ERROR <> 0 BEGIN
		ROLLBACK TRANSACTION
		RAISERROR( 'Não foi possível excluir o histórico de datas do agendamento.', 16, 1 )
	END

	DELETE Agendamento WHERE AG_NUMERO = @pAG_NUMERO
	IF @@ERROR <> 0 BEGIN
		ROLLBACK TRANSACTION
		RAISERROR( 'Não foi possível excluir o agendamento.', 16, 1 )
		RETURN -1
	END

	COMMIT TRANSACTION
	RETURN 1
END
GO

/****** Object:  StoredProcedure [dbo].[sp_ApagaAmbiente]    Script Date: 07/19/2018 18:45:13 ******/
IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[dbo].[sp_ApagaAmbiente]') AND OBJECTPROPERTY(id,N'IsProcedure') = 1)
DROP PROCEDURE [dbo].[sp_ApagaAmbiente]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[sp_ApagaAmbiente]
(
	@pId INT
)
AS
BEGIN
	BEGIN TRANSACTION
	SET NOCOUNT ON 

	DELETE FROM Ambientes WHERE AMB_ID = @pId
	IF @@ERROR <> 0 BEGIN
		ROLLBACK TRANSACTION
		RAISERROR('Não foi possível excluir o ambiente. Possivelmente existem referências ao mesmo na base de dados.', 16, 1)
		SELECT -1 AS SAIDA, 'Não foi possível excluir o ambiente. Possivelmente existem referências ao mesmo na base de dados.' AS MENSAGEM
		RETURN -1
	END

	COMMIT TRANSACTION
	SELECT 1 AS SAIDA, 'OK' AS MENSAGEM
	RETURN 1
END
GO

/****** Object:  StoredProcedure [dbo].[sp_ApagaAreaTecnologica]    Script Date: 07/19/2018 18:45:13 ******/
IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[dbo].[sp_ApagaAreaTecnologica]') AND OBJECTPROPERTY(id,N'IsProcedure') = 1)
DROP PROCEDURE [dbo].[sp_ApagaAreaTecnologica]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[sp_ApagaAreaTecnologica]
(
	@pId INT
)
AS
BEGIN
	BEGIN TRANSACTION
	SET NOCOUNT ON 

	DELETE FROM Area_tecnologica WHERE AT_ID = @pID
	IF @@ERROR <> 0 BEGIN
		ROLLBACK TRANSACTION
		RAISERROR('Não foi possível excluir a área tecnológica. Possivelmente existem referências à mesma na base de dados.', 16, 1)
		SELECT -1 AS SAIDA, 'Não foi possível excluir o usuário. Possivelmente existem referências à mesma na base de dados.' AS MENSAGEM
		RETURN -1
	END

	COMMIT TRANSACTION
	SELECT 1 AS SAIDA, 'OK' AS MENSAGEM
	RETURN 1
END
GO


/****** Object:  StoredProcedure [dbo].[sp_ApagaLogBookAcaoTomada]    Script Date: 07/19/2018 18:45:13 ******/
IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[dbo].[sp_ApagaLogBookAcaoTomada]') AND OBJECTPROPERTY(id,N'IsProcedure') = 1)
DROP PROCEDURE [dbo].[sp_ApagaLogBookAcaoTomada]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[sp_ApagaLogBookAcaoTomada]
(
	@pACT_ID INT OUTPUT
)
AS
BEGIN
	DELETE FROM LB_ACOESTOMADAS_ARQUIVOS WHERE ACT_ID = @pACT_ID
	IF @@ERROR <> 0 BEGIN
		ROLLBACK TRANSACTION
		RAISERROR( 'Não foi possível excluir os arquivos desta ação.', 16, 1 )
		SELECT -1 AS SAIDA
		RETURN -1
	END

	DELETE FROM LB_ACOESTOMADAS WHERE ACT_ID = @pACT_ID
	IF @@ERROR <> 0 BEGIN
		ROLLBACK TRANSACTION
		RAISERROR( 'Não foi possível atualizar esta ação.', 16, 1 )
		SELECT -1 AS SAIDA
		RETURN -1
	END
	COMMIT TRANSACTION
	SELECT @pACT_ID AS SAIDA
	RETURN @pACT_ID
END
GO


/****** Object:  StoredProcedure [dbo].[sp_ApagaLogBookAcaoTomadaArquivos]    Script Date: 07/19/2018 18:45:13 ******/
IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[dbo].[sp_ApagaLogBookAcaoTomadaArquivos]') AND OBJECTPROPERTY(id,N'IsProcedure') = 1)
DROP PROCEDURE [dbo].[sp_ApagaLogBookAcaoTomadaArquivos]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[sp_ApagaLogBookAcaoTomadaArquivos]
(
	@pACA_ID INT OUTPUT
)
AS
BEGIN
	DELETE FROM LB_ACOESTOMADAS_ARQUIVOS WHERE ACA_ID = @pACA_ID
	IF @@ERROR <> 0 BEGIN
		ROLLBACK TRANSACTION
		RAISERROR( 'Não foi possível excluir o arquivo.', 16, 1 )
		SELECT -1 AS SAIDA
		RETURN -1
	END
	COMMIT TRANSACTION
	SELECT @pACA_ID AS SAIDA
	RETURN @pACA_ID
END
GO

/****** Object:  StoredProcedure [dbo].[sp_ApagaLogBookTipoOcorrencia]    Script Date: 07/19/2018 18:45:13 ******/
IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[dbo].[sp_ApagaLogBookTipoOcorrencia]') AND OBJECTPROPERTY(id,N'IsProcedure') = 1)
	DROP PROCEDURE [dbo].[sp_ApagaLogBookTipoOcorrencia]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[sp_ApagaLogBookTipoOcorrencia]
(
	@pId INT
)
AS
BEGIN
	BEGIN TRANSACTION
	SET NOCOUNT ON 

	DELETE FROM LB_TipoOcorrencia WHERE LBTO_ID = @pID
	IF @@ERROR <> 0 BEGIN
		ROLLBACK TRANSACTION
		RAISERROR('Não foi possível excluir o tipo de ocorrência. Possivelmente existem referências ao mesmo na base de dados.', 16, 1)
		SELECT -1 AS SAIDA, 'Não foi possível excluir o tipo de ocorrência. Possivelmente existem referências ao mesmo na base de dados.' AS MENSAGEM
		RETURN -1
	END

	COMMIT TRANSACTION
	SELECT 1 AS SAIDA, 'OK' AS MENSAGEM
	RETURN 1
END
GO

/****** Object:  StoredProcedure [dbo].[sp_ApagaOrdemDeServico]    Script Date: 07/19/2018 18:45:13 ******/
IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[dbo].[sp_ApagaOrdemDeServico]') AND OBJECTPROPERTY(id,N'IsProcedure') = 1)
	DROP PROCEDURE [dbo].[sp_ApagaOrdemDeServico]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE  PROCEDURE [dbo].[sp_ApagaOrdemDeServico]
(
	@pAG_NUMERO INT,
	@pOS_ID INT
)
AS
BEGIN
	DECLARE @int_REPETICAO_AS BIT,
		@int_Linha INT

	/* Apaga uma ou todas as Ordens de Servico para um Agendamento */
	BEGIN TRANSACTION
	SET NOCOUNT ON

	IF @pOS_ID IS NULL BEGIN
		SET @int_REPETICAO_AS = 0

		DELETE Historico_EventosOS WHERE AG_NUMERO = @pAG_NUMERO
		IF @@ERROR <> 0 BEGIN
			ROLLBACK TRANSACTION
			RAISERROR( 'Não foi possível excluir o histórico de eventos da OS.', 16, 1 )
			SELECT -1 AS SAIDA
			RETURN -1
		END

		DELETE Ordem_de_Servico WHERE AG_NUMERO = @pAG_NUMERO
		IF @@ERROR <> 0 BEGIN
			ROLLBACK TRANSACTION
			RAISERROR( 'Não foi possível excluir as OS´s do agendamento.', 16, 1 )
			SELECT -1 AS SAIDA
			RETURN -1
		END
	END
	ELSE BEGIN
		DELETE Historico_EventosOS WHERE AG_NUMERO = @pAG_NUMERO AND OS_ID = @pOS_ID
		IF @@ERROR <> 0 BEGIN
			ROLLBACK TRANSACTION
			RAISERROR( 'Não foi possível excluir o histórico de eventos da OS.', 16, 1 )
			SELECT -1 AS SAIDA
			RETURN -1
		END

		DELETE Ordem_de_Servico WHERE AG_NUMERO = @pAG_NUMERO AND OS_ID = @pOS_ID
		IF @@ERROR <> 0 BEGIN
			ROLLBACK TRANSACTION
			RAISERROR( 'Não foi possível excluir as OS´s do agendamento.', 16, 1 )
			SELECT -1 AS SAIDA
			RETURN -1
		END


		-->>> conto quantas OS marcadas para repetição existem
		SELECT TOP 1
			@int_Linha = COUNT(*)
		FROM
			vw_OrdemDeServico OS
		WHERE
			OS.AG_NUMERO = @pAG_NUMERO
		AND
			OS_FLAGREPETICAO = 1

		IF @int_Linha > 0
			SET @int_REPETICAO_AS = 1
		ELSE
			SET @int_REPETICAO_AS = 0
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
		SELECT -1 AS SAIDA
		RETURN -1
	END


	COMMIT TRANSACTION
	SELECT 1 AS SAIDA
	RETURN 1
END
GO

/****** Object:  StoredProcedure [dbo].[sp_ApagaOrgao]    Script Date: 07/19/2018 18:45:13 ******/
IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[dbo].[sp_ApagaOrgao]') AND OBJECTPROPERTY(id,N'IsProcedure') = 1)
	DROP PROCEDURE [dbo].[sp_ApagaOrgao]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[sp_ApagaOrgao]
(
	@pId INT
)
AS
BEGIN
	BEGIN TRANSACTION
	SET NOCOUNT ON 

	DELETE FROM Orgao WHERE ORGA_ID = @pId
	IF @@ERROR <> 0 BEGIN
		ROLLBACK TRANSACTION
		RAISERROR('Não foi possível excluir o órgão. Possivelmente existem referências ao mesmo na base de dados.', 16, 1)
		SELECT -1 AS SAIDA, 'Não foi possível excluir o órgão. Possivelmente existem referências ao mesmo na base de dados.' AS MENSAGEM
		RETURN -1
	END

	COMMIT TRANSACTION
	SELECT 1 AS SAIDA, 'OK' AS MENSAGEM
	RETURN 1
END
GO

/****** Object:  StoredProcedure [dbo].[sp_ApagaServPlataforma]    Script Date: 07/19/2018 18:45:13 ******/
IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[dbo].[sp_ApagaServPlataforma]') AND OBJECTPROPERTY(id,N'IsProcedure') = 1)
	DROP PROCEDURE [dbo].[sp_ApagaServPlataforma]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[sp_ApagaServPlataforma]
(
	@pId INT
)
AS
BEGIN
	BEGIN TRANSACTION
	SET NOCOUNT ON 

	DELETE FROM Servicos_Plataformas WHERE S_ID = @pId
	IF @@ERROR <> 0 BEGIN
		ROLLBACK TRANSACTION
		RAISERROR('Não foi possível excluir o serviço/sistema. Possivelmente existem referências ao mesmo na base de dados.', 16, 1)
		SELECT -1 AS SAIDA, 'Não foi possível excluir o serviço/sistema. Possivelmente existem referências ao mesmo na base de dados.' AS MENSAGEM
		RETURN -1
	END

	COMMIT TRANSACTION
	SELECT 1 AS SAIDA, 'OK' AS MENSAGEM
	RETURN 1
END
GO

/****** Object:  StoredProcedure [dbo].[sp_ApagaTecnologia]    Script Date: 07/19/2018 18:45:13 ******/
IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[dbo].[sp_ApagaTecnologia]') AND OBJECTPROPERTY(id,N'IsProcedure') = 1)
	DROP PROCEDURE [dbo].[sp_ApagaTecnologia]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[sp_ApagaTecnologia]
(
	@pId INT
)
AS
BEGIN
	BEGIN TRANSACTION
	SET NOCOUNT ON 

	DELETE FROM Tecnologia WHERE TEC_ID = @pId
	IF @@ERROR <> 0 BEGIN
		ROLLBACK TRANSACTION
		RAISERROR('Não foi possível excluir a tecnologia. Possivelmente existem referências na base de dados.', 16, 1)
		SELECT -1 AS SAIDA, 'Não foi possível excluir a tecnologia. Possivelmente existem referências na base de dados.' AS MENSAGEM
		RETURN -1
	END

	COMMIT TRANSACTION
	SELECT 1 AS SAIDA, 'OK' AS MENSAGEM
	RETURN 1
END
GO


/****** Object:  StoredProcedure [dbo].[sp_ApagaTeste]    Script Date: 07/19/2018 18:45:13 ******/
IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[dbo].[sp_ApagaTeste]') AND OBJECTPROPERTY(id,N'IsProcedure') = 1)
DROP PROCEDURE [dbo].[sp_ApagaTeste]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[sp_ApagaTeste]
(
	@pT_ID INT
)
AS
BEGIN
	BEGIN TRANSACTION
	SET NOCOUNT ON 

	DELETE FROM Testes WHERE T_ID = @pT_ID
	IF @@ERROR <> 0 BEGIN
		ROLLBACK TRANSACTION
		RAISERROR('Não foi possível excluir o teste. Possivelmente existem referências ao mesmo na base de dados.', 16, 1)
		SELECT -1 AS SAIDA, 'Não foi possível excluir o ambiente. Possivelmente existem referências ao mesmo na base de dados.' AS MENSAGEM
		RETURN -1
	END

	COMMIT TRANSACTION
	SELECT 1 AS SAIDA, 'OK' AS MENSAGEM
	RETURN 1
END
GO

/****** Object:  StoredProcedure [dbo].[sp_ApagaTipoArquivo]    Script Date: 07/19/2018 18:45:13 ******/
IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[dbo].[sp_ApagaTipoArquivo]') AND OBJECTPROPERTY(id,N'IsProcedure') = 1)
	DROP PROCEDURE [dbo].[sp_ApagaTipoArquivo]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[sp_ApagaTipoArquivo]
(
	@pId INT
)
AS
BEGIN
	BEGIN TRANSACTION
	SET NOCOUNT ON 

	DELETE FROM TipoArquivo WHERE TAR_CODTIPOARQUIVO = @pID
	IF @@ERROR <> 0 BEGIN
		ROLLBACK TRANSACTION
		RAISERROR('Não foi possível excluir o tipo de arquivo. Possivelmente existem referências ao mesmo na base de dados.', 16, 1)
		SELECT -1 AS SAIDA, 'Não foi possível excluir o tipo de arquivo. Possivelmente existem referências ao mesmo na base de dados.' AS MENSAGEM
		RETURN -1
	END

	COMMIT TRANSACTION
	SELECT 1 AS SAIDA, 'OK' AS MENSAGEM
	RETURN 1
END
GO

/****** Object:  StoredProcedure [dbo].[sp_ApagaTipoAtividade]    Script Date: 07/19/2018 18:45:13 ******/
IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[dbo].[sp_ApagaTipoAtividade]') AND OBJECTPROPERTY(id,N'IsProcedure') = 1)
	DROP PROCEDURE [dbo].[sp_ApagaTipoAtividade]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[sp_ApagaTipoAtividade]
	@pId INT
AS
BEGIN
	BEGIN TRANSACTION
	SET NOCOUNT ON 

	DELETE FROM Tipo_Atividade WHERE TA_ID = @pId
	IF @@ERROR <> 0 BEGIN
		ROLLBACK TRANSACTION
		RAISERROR('Não foi possível excluir o tipo da atividade. Possivelmente existem referências ao mesmo na base de dados.', 16, 1)
		SELECT -1 AS SAIDA, 'Não foi possível excluir o tipo da atividade. Possivelmente existem referências ao mesmo na base de dados.' AS MENSAGEM
		RETURN -1
	END

	COMMIT TRANSACTION
	SELECT 1 AS SAIDA, 'OK' AS MENSAGEM
	RETURN 1
END
GO


/****** Object:  StoredProcedure [dbo].[sp_ApagaTipoTeste]    Script Date: 07/19/2018 18:45:13 ******/
IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[dbo].[sp_ApagaTipoTeste]') AND OBJECTPROPERTY(id,N'IsProcedure') = 1)
	DROP PROCEDURE [dbo].[sp_ApagaTipoTeste]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE  PROCEDURE [dbo].[sp_ApagaTipoTeste]
(
	@pId INT
)
AS
BEGIN
	BEGIN TRANSACTION
	SET NOCOUNT ON 

	DELETE FROM Tipo_Teste WHERE TIT_ID = @pId
	IF @@ERROR <> 0 BEGIN
		ROLLBACK TRANSACTION
		RAISERROR('Não foi possível excluir o tipo de teste. Possivelmente existem referências ao mesmo na base de dados.', 16, 1)
		SELECT -1 AS SAIDA, 'Não foi possível excluir o tipo de teste. Possivelmente existem referências ao mesmo na base de dados.' AS MENSAGEM
		RETURN -1
	END

	COMMIT TRANSACTION
	SELECT 1 AS SAIDA, 'OK' AS MENSAGEM
	RETURN 1
END
GO

/****** Object:  StoredProcedure [dbo].[sp_ApagaUserCRT]    Script Date: 07/19/2018 18:45:13 ******/
IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[dbo].[sp_ApagaUserCRT]') AND OBJECTPROPERTY(id,N'IsProcedure') = 1)
DROP PROCEDURE [dbo].[sp_ApagaUserCRT]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[sp_ApagaUserCRT]
(
	@pUsername VARCHAR(80)
)
AS
BEGIN
	BEGIN TRANSACTION
	SET NOCOUNT ON 

	DELETE FROM USERCRT WHERE USERID = @pUsername
	IF @@ERROR <> 0 BEGIN
		ROLLBACK TRANSACTION
		RAISERROR('Não foi possível excluir o usuário. Possivelmente existem referências ao mesmo na base de dados.', 16, 1)
		SELECT -1 AS SAIDA, 'Não foi possível excluir o usuário. Possivelmente existem referências ao mesmo na base de dados.' AS MENSAGEM
		RETURN -1
	END

	COMMIT TRANSACTION
	SELECT 1 AS SAIDA, 'OK' AS MENSAGEM
	RETURN 1
END
GO


/****** Object:  StoredProcedure [dbo].[sp_CadAgendamento]    Script Date: 07/19/2018 18:45:13 ******/
IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[dbo].[sp_CadAgendamento]') AND OBJECTPROPERTY(id,N'IsProcedure') = 1)
	DROP PROCEDURE [dbo].[sp_CadAgendamento]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE   PROCEDURE [dbo].[sp_CadAgendamento]
	@separa_campo varchar(4),
	@separa_registro varchar(4),
	@pAG_NUMEROIn INT OUTPUT,
	@pAG_TITULO varchar(50),
	@pRecebeMail bit,
	@pAG_TECNOLOGIA INT,
	@pAG_DATAINICIO char(20), -- smalldatetime
	@pAG_DATATERMINO char(20), -- smalldatetime
	@pAG_SIGILO bit,
	@pAG_OBJETIVO varchar(8000),
	@pAG_AMBIENTE varchar(8000),
	@pAG_RECURSOS varchar(8000),
	@pAG_OBSERVACAO varchar(8000),
	@pAG_USERNAME varchar(80),
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

	DECLARE @pAG_USERNAMEint VARCHAR(80)
	DECLARE @pAG_ORGAOint VARCHAR(200)


	SET NOCOUNT ON 
	BEGIN TRANSACTION

	IF  @pAG_NUMEROIn IS NULL  BEGIN
		--////////////////// INSERE AGENDAMENTO
		INSERT INTO AGENDAMENTO
			(AG_TITULO, TEC_ID,AG_DATASOLICITACAO, AG_DATAINICIO, AG_DATATERMINO, AG_SIGILO,  AG_OBJETIVO, AG_FLAGREMARCACAO, AG_MOTIVO,   AG_USERNAME, AG_ORGAO, AG_RECEBEMAIL,AG_AMBIENTE,AG_RECURSOS, AG_OBSERVACAO, AG_CLIENTEEXTERNO, AG_RETORNOCLIENTE, AG_VALORCONTRATOCLIENTE, AG_PLANODEMETAS)
			VALUES
			(UPPER(@pAG_TITULO), @pAG_TECNOLOGIA, getDate(), Convert(smalldatetime, @pAG_DATAINICIO, 103), Convert(smalldatetime, @pAG_DATATERMINO, 103), @pAG_SIGILO,  @pAG_OBJETIVO, 0, null,  @pAG_USERNAME, @pAG_ORGAO, @pRecebeMail,@pAG_AMBIENTE,@pAG_RECURSOS,@pAG_OBSERVACAO, @pAG_CLIENTEEXTERNO, @pAG_RETORNOCLIENTE, @pAG_VALORCONTRATOCLIENTE, @pAG_PLANODEMETAS)
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
		SELECT
			@pAG_USERNAMEint = AG_USERNAME,
			@pAG_ORGAOint = AG_ORGAO
		FROM
			AGENDAMENTO
		WHERE
			AG_NUMERO = @pAG_NUMEROIn

		IF (@pAG_ORGAO = ' ') OR (@pAG_ORGAO = '') OR (@pAG_ORGAO = '--')
			SET @pAG_ORGAO = NULL

		IF (@pAG_ORGAOint = ' ') OR (@pAG_ORGAOint = '') OR (@pAG_ORGAOint = '--')
			SET @pAG_ORGAOint = NULL

		-- se for o mesmo solicitante
		IF @pAG_USERNAMEint = @pAG_USERNAME
		BEGIN
			-- entao vejo o parametro orgao, se for nulo mantenho o original
			IF (@pAG_ORGAO IS NOT NULL) OR (@pAG_ORGAOint IS NOT NULL)
			BEGIN
				IF @pAG_ORGAOint IS NULL
					SET @pAG_ORGAOint = @pAG_ORGAO
			END
		END
		ELSE
		BEGIN
			IF @pAG_ORGAO IS NULL
				SET @pAG_ORGAOint = NULL
			ELSE
				SET @pAG_ORGAOint = @pAG_ORGAO
		END


		UPDATE AGENDAMENTO SET
			AG_TITULO = UPPER(@pAG_TITULO),
			TEC_ID = @pAG_TECNOLOGIA,
			/*AG_DATASOLICITACAO = getDate(),*/
			AG_DATAINICIO = Convert(smalldatetime, @pAG_DATAINICIO, 103),
			AG_DATATERMINO = Convert(smalldatetime, @pAG_DATATERMINO, 103),
			AG_SIGILO = @pAG_SIGILO,
			AG_OBJETIVO = @pAG_OBJETIVO,
			AG_USERNAME = @pAG_USERNAME,
			AG_ORGAO = @pAG_ORGAOint,
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


/****** Object:  StoredProcedure [dbo].[sp_CadAgendamentoOS]    Script Date: 07/19/2018 18:45:13 ******/
IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[dbo].[sp_CadAgendamentoOS]') AND OBJECTPROPERTY(id,N'IsProcedure') = 1)
	DROP PROCEDURE [dbo].[sp_CadAgendamentoOS]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE  PROCEDURE [dbo].[sp_CadAgendamentoOS]
(
	@NOVA_OS BIT,
	@pT_ID  int,
	@pOS_ID  int,
	@pAG_NUMERO int,
 	@pOS_OBSERVACAO varchar(7000),
	@pID_SITUACAO INT,
 	@pHEOS_MOTIVO varchar(200),
	@pHE_DataInicio varchar(20),
	@pS_ID_SERVICO int,
	@pS_ID_PLATAFORMA int,
	@pEQ_ID_AMOSTRA int
)
AS
BEGIN
	DECLARE	@SITUACAO_ATUAL INT,
		@PERIODO_REPETICAO INT,
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
GO


/****** Object:  StoredProcedure [dbo].[sp_CadAgendamentoRAT]    Script Date: 07/19/2018 18:45:13 ******/
IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[dbo].[sp_CadAgendamentoRAT]') AND OBJECTPROPERTY(id,N'IsProcedure') = 1)
	DROP PROCEDURE [dbo].[sp_CadAgendamentoRAT]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE  PROCEDURE [dbo].[sp_CadAgendamentoRAT]
(
	@separa_campo varchar(4),
	@separa_registro varchar(4),
	@pAG_NUMERO INT,
	@pTA_ID INT,
 	@pID_SITUACAO INT,
 	@pHE_MOTIVO varchar(200),
 	@pAG_Responsavel varchar(80),
 	@pAG_RAT varchar(80),
	@pHE_DataInicio varchar(20),
	@pAG_NECESSITA_OS BIT,
	@pAG_Relat_RAT text,
	@repeticao BIT,
	@executante BIT,
	@pAMBIENTES VARCHAR(8000),
	@pSTR_PARTICIPANTES_EBT VARCHAR(8000)
)
AS
BEGIN
	SET NOCOUNT ON

	BEGIN TRANSACTION

	DECLARE @SITUACAO_ATUAL INT

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


/****** Object:  StoredProcedure [dbo].[sp_CadAgendamentoRT]    Script Date: 07/19/2018 18:45:13 ******/
IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[dbo].[sp_CadAgendamentoRT]') AND OBJECTPROPERTY(id,N'IsProcedure') = 1)
	DROP PROCEDURE [dbo].[sp_CadAgendamentoRT]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[sp_CadAgendamentoRT]
(
	@separa_campo varchar(4),
	@separa_registro varchar(4),
	@STR_SERVICO VARCHAR(8000),
	@STR_SISTEMA VARCHAR(8000),	
	@pAG_Relat_RT text,
	@pAG_NUMERO INT,
	@pSTR_PARTICIPANTES_EBT VARCHAR(8000)
)
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
	@pUsadoPorAg BIT
)
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
GO

/****** Object:  StoredProcedure [dbo].[sp_CadAreaTecnologica]    Script Date: 07/19/2018 18:45:13 ******/
IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[dbo].[sp_CadAreaTecnologica]') AND OBJECTPROPERTY(id,N'IsProcedure') = 1)
	DROP PROCEDURE [dbo].[sp_CadAreaTecnologica]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[sp_CadAreaTecnologica]
	@pId INT,
	@pDescricao VARCHAR(510)
AS
BEGIN
	SET NOCOUNT ON 
	BEGIN TRANSACTION

	IF @pID IS NULL OR @pID = 0 BEGIN
		INSERT INTO Area_tecnologica (at_nome) VALUES (@pDescricao)
		IF @@ERROR <> 0 BEGIN
			ROLLBACK TRANSACTION
			RAISERROR( 'Não foi possível inserir Área Tecnológica', 16, 1)
			SELECT -1 AS SAIDA, 'Não foi possível inserir Área Tecnológica' AS MENSAGEM
			RETURN -1
		END
		SET @pID = @@IDENTITY
	END
	ELSE BEGIN
		UPDATE Area_tecnologica SET at_nome = @pDescricao
		WHERE at_id = @pId
		IF @@ERROR <> 0 BEGIN
			ROLLBACK TRANSACTION
			RAISERROR( 'Não foi possível atualizar Área Tecnológica', 16, 1)
			SELECT -1 AS SAIDA, 'Não foi possível atualizar Área Tecnológica' AS MENSAGEM
			RETURN -1
		END
	END

	COMMIT TRANSACTION
	SELECT @pID AS SAIDA, 'OK' AS MENSAGEM
	RETURN @pID
END
GO


/****** Object:  StoredProcedure [dbo].[sp_CADASTRA_ARQUIVOS]    Script Date: 07/19/2018 18:45:13 ******/
IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[dbo].[sp_CADASTRA_ARQUIVOS]') AND OBJECTPROPERTY(id,N'IsProcedure') = 1)
	DROP PROCEDURE [dbo].[sp_CADASTRA_ARQUIVOS]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[sp_CADASTRA_ARQUIVOS]
	@ACAO VARCHAR(10),
	@pAG_NUMERO INT,
	@DATA_ACAO VARCHAR(20),
	@pARQ_CODARQ INT,
	@pARQ_CODARQTIPO INT,
	@pARQ_LINK VARCHAR (400),
	@pARQ_NOMEARQ VARCHAR(200),
	@pARQ_RESPONSAVEL VARCHAR(80),
	@pARQ_IDORGAO INT,
	@pARQ_OBSERVACAO VARCHAR(510),
	@pARQ_VERSAO VARCHAR(100),
	@pARQ_OCULTAR bit,
	@pARQ_DATAAPROVACAO VARCHAR(20),
	@pIPCADASTRO VARCHAR(40),
	@pUSERIDCADASTRO VARCHAR(80),
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
			VALUES (@pARQ_CODARQ, @pUSERIDCADASTRO, CONVERT(SMALLDATETIME,@DATA_ACAO,103), @ACAO)
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
GO


/****** Object:  StoredProcedure [dbo].[sp_CadDePara]    Script Date: 07/19/2018 18:45:13 ******/
IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[dbo].[sp_CadDePara]') AND OBJECTPROPERTY(id,N'IsProcedure') = 1)
	DROP PROCEDURE [dbo].[sp_CadDePara]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[sp_CadDePara]
(
	@separa_campo varchar(4),
	@separa_registro varchar(4),
	@pTabela VARCHAR(50),
	@pDE	 VARCHAR(8000),
	@pPARA 	 VARCHAR(510)
)
AS
BEGIN
	SET NOCOUNT ON 
	BEGIN TRANSACTION

	--VARIÁVEIS NECESSÁRIAS PARA QUEBRA DAS STRINGS
	DECLARE @reg VARCHAR(7000), @fim BIT, @iini INT, @ifim INT
	DECLARE @DADOS VARCHAR(7000)
	DECLARE @st1 VARCHAR(255), @st2 VARCHAR(255)

	SET @DADOS = @pDE

	--RETIRO O ULTIMO SEPARADO DE REGISTRO
	SET @DADOS = REVERSE(SUBSTRING(REVERSE(@DADOS),LEN(@separa_registro)+1,LEN(@DADOS)))

	IF @pTabela = 'ClienteExterno' BEGIN
		--EXECUTAR PARA SEPARAR AS OCORRÊNCIAS
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
				SET @st1 = SUBSTRING( @reg, 1, PATINDEX( '%' + @separa_campo + '%', @reg ) -1 )

				-----------------------------------------------------------------------------------
				--EXECUTAR ESTE SCRIPT PRA CADA STRING
				-----------------------------------------------------------------------------------
				UPDATE AGENDAMENTO 
				SET AG_CLIENTEEXTERNO  = @pPARA
				WHERE AG_CLIENTEEXTERNO = @st1
				IF @@ERROR <> 0 BEGIN
					ROLLBACK TRANSACTION
					RAISERROR( 'Não foi possível realizar substituição', 16, 1)
					RETURN -1
				END
				-----------------------------------------------------------------------------------

				SET @DADOS = LTRIM(SUBSTRING( @DADOS, @ifim + len(@separa_registro), LEN(@DADOS) ))
				IF @ifim = 0 SET @fim = 1
			END
		END
	END

	IF @pTabela = 'Orgao' BEGIN
		--EXECUTAR PARA SEPARAR AS OCORRÊNCIAS
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
				SET @st1 = SUBSTRING( @reg, 1, PATINDEX( '%' + @separa_campo + '%', @reg ) -1 )

				-----------------------------------------------------------------------------------
				--EXECUTAR ESTE SCRIPT PRA CADA STRING
				-----------------------------------------------------------------------------------
				UPDATE AGENDAMENTO 
				SET ag_orgao  = @pPARA
				WHERE ag_orgao = @st1
				IF @@ERROR <> 0 BEGIN
					ROLLBACK TRANSACTION
					RAISERROR( 'Não foi possível realizar substituição', 16, 1)
					RETURN -1
				END
				-----------------------------------------------------------------------------------

				SET @DADOS = LTRIM(SUBSTRING( @DADOS, @ifim + len(@separa_registro), LEN(@DADOS) ))
				IF @ifim = 0 SET @fim = 1
			END
		END
	END

	IF @pTabela = 'TipoAtividade' BEGIN
		--EXECUTAR PARA SEPARAR AS OCORRÊNCIAS
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
				SET @st1 = SUBSTRING( @reg, 1, PATINDEX( '%' + @separa_campo + '%', @reg ) -1 )

				-----------------------------------------------------------------------------------
				--EXECUTAR ESTE SCRIPT PRA CADA STRING
				-----------------------------------------------------------------------------------
				UPDATE AGENDAMENTO 
				SET TA_ID  = CONVERT(INTEGER,@pPARA)
				WHERE TA_ID = CONVERT(INTEGER,@st1)
				IF @@ERROR <> 0 BEGIN
					ROLLBACK TRANSACTION
					RAISERROR( 'Não foi possível realizar substituição', 16, 1)

					RETURN -1
				END
	
				--CRIADO PARA CONTROLAR CASOS EM QUE ENTRE O CONJUNTO  DAS CLAUSULAS "DE" TENHA UM ELEMENTO DA CLAUSULA PARA
				IF @pPARA <> @st1 BEGIN
					DELETE FROM TIPO_ATIVIDADE WHERE TA_ID = CONVERT(INTEGER,@st1)
					IF @@ERROR <> 0 BEGIN
						ROLLBACK TRANSACTION
						RAISERROR( 'Não foi possível realizar substituição', 16, 1)
						RETURN -1
					END
				END
				-----------------------------------------------------------------------------------

				SET @DADOS = LTRIM(SUBSTRING( @DADOS, @ifim + len(@separa_registro), LEN(@DADOS) ))
				IF @ifim = 0 SET @fim = 1
			END
		END
	END

	IF @pTabela = 'Tecnologia' BEGIN
		--EXECUTAR PARA SEPARAR AS OCORRÊNCIAS
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
				SET @st1 = SUBSTRING( @reg, 1, PATINDEX( '%' + @separa_campo + '%', @reg ) -1 )

				-----------------------------------------------------------------------------------
				--EXECUTAR ESTE SCRIPT PRA CADA STRING
				-----------------------------------------------------------------------------------
				UPDATE AGENDAMENTO 
				SET TEC_ID  = CONVERT(INTEGER,@pPARA)
				WHERE TEC_ID = CONVERT(INTEGER,@st1)
				IF @@ERROR <> 0 BEGIN
					ROLLBACK TRANSACTION
					RAISERROR( 'Não foi possível realizar substituição', 16, 1)
					RETURN -1
				END

				--CRIADO PARA CONTROLAR CASOS EM QUE ENTRE O CONJUNTO  DAS CLAUSULAS "DE" TENHA UM ELEMENTO DA CLAUSULA PARA	
				IF @pPARA <> @st1 BEGIN
					DELETE FROM TECNOLOGIA WHERE TEC_ID = CONVERT(INTEGER,@st1)
					IF @@ERROR <> 0 BEGIN
						ROLLBACK TRANSACTION
						RAISERROR( 'Não foi possível realizar substituição', 16, 1)
						RETURN -1
					END
				END
				-----------------------------------------------------------------------------------

				SET @DADOS = LTRIM(SUBSTRING( @DADOS, @ifim + len(@separa_registro), LEN(@DADOS) ))
				IF @ifim = 0 SET @fim = 1
			END
		END
	END

	IF @pTabela = 'Testes' BEGIN
		--EXECUTAR PARA SEPARAR AS OCORRÊNCIAS
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
				SET @st1 = SUBSTRING( @reg, 1, PATINDEX( '%' + @separa_campo + '%', @reg ) -1 )

				-----------------------------------------------------------------------------------
				--EXECUTAR ESTE SCRIPT PRA CADA STRING
				-----------------------------------------------------------------------------------
				--CRIADO PARA CONTROLAR CASOS EM QUE ENTRE O CONJUNTO  DAS CLAUSULAS "DE" TENHA UM ELEMENTO DA CLAUSULA PARA	
				IF @pPARA <> @st1 BEGIN
					-------------------------------------------------------------------
					UPDATE ORDEM_DE_SERVICO
					SET T_ID  = CONVERT(INTEGER,@pPARA)
					WHERE T_ID = CONVERT(INTEGER,@st1)
					IF @@ERROR <> 0 BEGIN
						ROLLBACK TRANSACTION
						RAISERROR( 'Não foi possível realizar substituição', 16, 1)
						RETURN -1
					END
					-------------------------------------------------------------------
					DELETE FROM TESTES WHERE T_ID = CONVERT(INTEGER,@st1)
					IF @@ERROR <> 0 BEGIN
						ROLLBACK TRANSACTION
						RAISERROR( 'Não foi possível realizar substituição', 16, 1)
						RETURN -1
					END
				END
				-----------------------------------------------------------------------------------

				SET @DADOS = LTRIM(SUBSTRING( @DADOS, @ifim + len(@separa_registro), LEN(@DADOS) ))
				IF @ifim = 0 SET @fim = 1
			END

		END
	END

	IF @pTabela = 'LB_TipoOcorrencia' BEGIN
		--EXECUTAR PARA SEPARAR AS OCORRÊNCIAS
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
				SET @st1 = SUBSTRING( @reg, 1, PATINDEX( '%' + @separa_campo + '%', @reg ) -1 )

				-----------------------------------------------------------------------------------
				--EXECUTAR ESTE SCRIPT PRA CADA STRING
				-----------------------------------------------------------------------------------
				--CRIADO PARA CONTROLAR CASOS EM QUE ENTRE O CONJUNTO  DAS CLAUSULAS "DE" TENHA UM ELEMENTO DA CLAUSULA PARA	
				IF @pPARA <> @st1 BEGIN
					-------------------------------------------------------------------
					UPDATE LB_LogBook
					SET LBTO_ID  = CONVERT(INTEGER,@pPARA)
					WHERE LBTO_ID = CONVERT(INTEGER,@st1)
					IF @@ERROR <> 0 BEGIN
						ROLLBACK TRANSACTION
						RAISERROR( 'Não foi possível realizar substituição', 16, 1)
						RETURN -1
					END
					-------------------------------------------------------------------
					DELETE FROM LB_TipoOcorrencia WHERE LBTO_ID = CONVERT(INTEGER,@st1)
					IF @@ERROR <> 0 BEGIN
						ROLLBACK TRANSACTION
						RAISERROR( 'Não foi possível realizar substituição', 16, 1)
						RETURN -1
					END
				END
				-----------------------------------------------------------------------------------

				SET @DADOS = LTRIM(SUBSTRING( @DADOS, @ifim + len(@separa_registro), LEN(@DADOS) ))
				IF @ifim = 0 SET @fim = 1
			END
		END
	END


	IF @pTabela = 'TipoArquivo' BEGIN
		--EXECUTAR PARA SEPARAR AS OCORRÊNCIAS
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
				SET @st1 = SUBSTRING( @reg, 1, PATINDEX( '%' + @separa_campo + '%', @reg ) -1 )

				-----------------------------------------------------------------------------------
				--EXECUTAR ESTE SCRIPT PRA CADA STRING
				-----------------------------------------------------------------------------------
				--CRIADO PARA CONTROLAR CASOS EM QUE ENTRE O CONJUNTO  DAS CLAUSULAS "DE" TENHA UM ELEMENTO DA CLAUSULA PARA	
				IF @pPARA <> @st1 BEGIN
					-------------------------------------------------------------------
					UPDATE Arquivos
					SET ARQ_CODARQTIPO  = CONVERT(INTEGER,@pPARA)
					WHERE ARQ_CODARQTIPO = CONVERT(INTEGER,@st1)
					IF @@ERROR <> 0 BEGIN
						ROLLBACK TRANSACTION
						RAISERROR( 'Não foi possível realizar substituição', 16, 1)
						RETURN -1
					END
					-------------------------------------------------------------------
					DELETE FROM TipoArquivo WHERE TAR_CODTIPOARQUIVO = CONVERT(INTEGER,@st1)
					IF @@ERROR <> 0 BEGIN
						ROLLBACK TRANSACTION
						RAISERROR( 'Não foi possível realizar substituição', 16, 1)
						RETURN -1
					END
				END
				-----------------------------------------------------------------------------------

				SET @DADOS = LTRIM(SUBSTRING( @DADOS, @ifim + len(@separa_registro), LEN(@DADOS) ))
				IF @ifim = 0 SET @fim = 1
			END
		END
	END


	IF @pTabela = 'OrgaoInterno' BEGIN
		--EXECUTAR PARA SEPARAR AS OCORRÊNCIAS
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
				SET @st1 = SUBSTRING( @reg, 1, PATINDEX( '%' + @separa_campo + '%', @reg ) -1 )

				-----------------------------------------------------------------------------------
				--EXECUTAR ESTE SCRIPT PRA CADA STRING
				-----------------------------------------------------------------------------------
				--CRIADO PARA CONTROLAR CASOS EM QUE ENTRE O CONJUNTO  DAS CLAUSULAS "DE" TENHA UM ELEMENTO DA CLAUSULA PARA	
				IF @pPARA <> @st1 BEGIN
					-------------------------------------------------------------------
					UPDATE UserCRT
					SET ORGA_ID = CONVERT(INTEGER,@pPARA)
					WHERE ORGA_ID = CONVERT(INTEGER,@st1)
					IF @@ERROR <> 0 BEGIN
						ROLLBACK TRANSACTION
						RAISERROR( 'Não foi possível realizar substituição', 16, 1)
						RETURN -1
					END
					-------------------------------------------------------------------
					UPDATE Arquivos
					SET ARQ_IDORGAO = CONVERT(INTEGER,@pPARA)
					WHERE ARQ_IDORGAO = CONVERT(INTEGER,@st1)
					IF @@ERROR <> 0 BEGIN
						ROLLBACK TRANSACTION
						RAISERROR( 'Não foi possível realizar substituição', 16, 1)
						RETURN -1
					END
					-------------------------------------------------------------------
					DELETE FROM Orgao WHERE ORGA_ID = CONVERT(INTEGER,@st1)
					IF @@ERROR <> 0 BEGIN
						ROLLBACK TRANSACTION
						RAISERROR( 'Não foi possível realizar substituição', 16, 1)
						RETURN -1
					END
				END
				-----------------------------------------------------------------------------------

				SET @DADOS = LTRIM(SUBSTRING( @DADOS, @ifim + len(@separa_registro), LEN(@DADOS) ))
				IF @ifim = 0 SET @fim = 1
			END
		END
	END


	IF @pTabela = 'TipoTeste' BEGIN
		--EXECUTAR PARA SEPARAR AS OCORRÊNCIAS
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
				SET @st1 = SUBSTRING( @reg, 1, PATINDEX( '%' + @separa_campo + '%', @reg ) -1 )

				-----------------------------------------------------------------------------------
				--EXECUTAR ESTE SCRIPT PRA CADA STRING
				-----------------------------------------------------------------------------------
				UPDATE Testes
				SET TIT_ID = @pPARA
				WHERE TIT_ID = @st1
				IF @@ERROR <> 0 BEGIN
					ROLLBACK TRANSACTION
					RAISERROR( 'Não foi possível realizar substituição', 16, 1)
					RETURN -1
				END
				-----------------------------------------------------------------------------------

				DELETE FROM Tipo_Teste
				WHERE TIT_ID = @st1
				IF @@ERROR <> 0 BEGIN
					ROLLBACK TRANSACTION
					RAISERROR( 'Não foi possível realizar substituição', 16, 1)
					RETURN -1
				END
				-----------------------------------------------------------------------------------

				SET @DADOS = LTRIM(SUBSTRING( @DADOS, @ifim + len(@separa_registro), LEN(@DADOS) ))
				IF @ifim = 0 SET @fim = 1
			END
		END
	END


	IF (@pTabela = 'Plataformas') OR (@pTabela = 'Servicos') BEGIN
		--EXECUTAR PARA SEPARAR AS OCORRÊNCIAS
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
				SET @st1 = SUBSTRING( @reg, 1, PATINDEX( '%' + @separa_campo + '%', @reg ) -1 )

				-----------------------------------------------------------------------------------
				--EXECUTAR ESTE SCRIPT PRA CADA STRING
				-----------------------------------------------------------------------------------
				IF (@pTabela = 'Plataformas') 
				BEGIN

					--apaga o histórico de eventos, caso a OS venha a ser excluída
					DELETE FROM Historico_EventosOS 
					WHERE AG_NUMERO IN (
						SELECT AG_NUMERO FROM Ordem_de_Servico a1
						WHERE S_ID_PLATAFORMA = @pPARA
						AND EXISTS (
							SELECT a2.ag_numero FROM Ordem_de_Servico a2
							WHERE a2.S_ID_PLATAFORMA = @st1 and a1.ag_numero = a2.ag_numero
						)
					)
					IF @@ERROR <> 0 BEGIN
						ROLLBACK TRANSACTION
						RAISERROR( 'Não foi possível realizar substituição', 16, 1)
						RETURN -1
					END

					--Verifica os casos que existem OS com os 2 servicos/plataformas
					DELETE FROM Ordem_de_Servico
					WHERE S_ID_PLATAFORMA = @pPARA AND AG_NUMERO IN (
						SELECT AG_NUMERO FROM Ordem_de_Servico a1
						WHERE S_ID_PLATAFORMA = @pPARA
						AND EXISTS (
							SELECT a2.ag_numero FROM Ordem_de_Servico a2
							WHERE a2.S_ID_PLATAFORMA = @st1 and a1.ag_numero = a2.ag_numero
						)
					)
					IF @@ERROR <> 0 BEGIN
						ROLLBACK TRANSACTION
						RAISERROR( 'Não foi possível realizar substituição', 16, 1)
						RETURN -1
					END

					UPDATE Ordem_de_Servico
					SET S_ID_PLATAFORMA = @pPARA
					WHERE S_ID_PLATAFORMA = @st1
					IF @@ERROR <> 0 BEGIN
						ROLLBACK TRANSACTION
						RAISERROR( 'Não foi possível realizar substituição', 16, 1)
						RETURN -1
					END
				END

				-----------------------------------------------------------------------------------

				IF (@pTabela = 'Servicos')
				BEGIN
					--Verifica os casos que existem OS com os 2 servicos/plataformas
					DELETE FROM Ordem_de_Servico
					WHERE S_ID_SERVICO = @pPARA AND AG_NUMERO IN (
						SELECT AG_NUMERO FROM Ordem_de_Servico a1
						WHERE S_ID_SERVICO = @pPARA
						AND EXISTS (
							SELECT a2.ag_numero FROM Ordem_de_Servico a2
							WHERE a2.S_ID_SERVICO = @st1 and a1.ag_numero = a2.ag_numero
						)
					)
					IF @@ERROR <> 0 BEGIN
						ROLLBACK TRANSACTION
						RAISERROR( 'Não foi possível realizar substituição', 16, 1)
						RETURN -1
					END

					UPDATE Ordem_de_Servico
					SET S_ID_SERVICO = @pPARA
					WHERE S_ID_SERVICO = @st1
					IF @@ERROR <> 0 BEGIN
						ROLLBACK TRANSACTION
						RAISERROR( 'Não foi possível realizar substituição', 16, 1)
						RETURN -1
					END
				END
				-----------------------------------------------------------------------------------
				UPDATE Historico_Plataforma_Equipamentos
				SET S_ID = @pPARA
				WHERE S_ID = @st1
				IF @@ERROR <> 0 BEGIN
					ROLLBACK TRANSACTION
					RAISERROR( 'Não foi possível realizar substituição', 16, 1)
					RETURN -1
				END
				-----------------------------------------------------------------------------------

				--Apaga os equipamentos que ficarao duplicados em uma plataforma
				DELETE FROM Plataforma_Equipamentos
				WHERE S_ID = @pPARA AND EQ_ID IN (
					SELECT EQ_ID FROM Plataforma_Equipamentos a1
					WHERE s_id = @pPARA
					AND EXISTS (
						SELECT a2.EQ_ID FROM Plataforma_Equipamentos a2
						WHERE a2.s_id = @st1 and a1.EQ_ID = a2.EQ_ID
					)
				)
				IF @@ERROR <> 0 BEGIN
					ROLLBACK TRANSACTION
					RAISERROR( 'Não foi possível realizar substituição', 16, 1)
					RETURN -1
				END

				UPDATE Plataforma_Equipamentos
				SET S_ID = @pPARA
				WHERE S_ID = @st1
				IF @@ERROR <> 0 BEGIN
					ROLLBACK TRANSACTION
					RAISERROR( 'Não foi possível realizar substituição', 16, 1)
					RETURN -1
				END
				-----------------------------------------------------------------------------------
				DELETE FROM Agenda_Servicos_Plataforma
				WHERE S_ID = @pPARA AND AG_NUMERO IN (
					SELECT AG_NUMERO FROM Agenda_Servicos_Plataforma a1
					WHERE s_id = @pPARA
					and EXISTS (
						SELECT a2.ag_numero FROM Agenda_Servicos_Plataforma a2
						WHERE a2.s_id = @st1 and a1.ag_numero = a2.ag_numero
					)
				)
				IF @@ERROR <> 0 BEGIN
					ROLLBACK TRANSACTION
					RAISERROR( 'Não foi possível realizar substituição', 16, 1)
					RETURN -1
				END

				UPDATE Agenda_Servicos_Plataforma
				SET S_ID = @pPARA
				WHERE S_ID = @st1
				IF @@ERROR <> 0 BEGIN
					ROLLBACK TRANSACTION
					RAISERROR( '222 Não foi possível realizar substituição', 16, 1)
					RETURN -1
				END
				-----------------------------------------------------------------------------------
				UPDATE Servicos_Plataformas
				SET S_ID_PAI = @pPARA
				WHERE S_ID_PAI = @st1
				IF @@ERROR <> 0 BEGIN
					ROLLBACK TRANSACTION
					RAISERROR( 'Não foi possível realizar substituição', 16, 1)
					RETURN -1
				END
				-----------------------------------------------------------------------------------
				/*DELETE FROM Servicos_Plataformas
				WHERE S_ID = @st1
				IF @@ERROR <> 0 BEGIN
					ROLLBACK TRANSACTION
					RAISERROR( 'Não foi possível realizar substituição', 16, 1)
					RETURN -1
				END*/
				-----------------------------------------------------------------------------------

				SET @DADOS = LTRIM(SUBSTRING( @DADOS, @ifim + len(@separa_registro), LEN(@DADOS) ))
				IF @ifim = 0 SET @fim = 1
			END
		END
	END

	COMMIT TRANSACTION
	RETURN 1
END
GO



/****** Object:  StoredProcedure [dbo].[sp_CadLogBookAcaoTomada]    Script Date: 07/19/2018 18:45:13 ******/
IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[dbo].[sp_CadLogBookAcaoTomada]') AND OBJECTPROPERTY(id,N'IsProcedure') = 1)
	DROP PROCEDURE [dbo].[sp_CadLogBookAcaoTomada]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE  PROCEDURE [dbo].[sp_CadLogBookAcaoTomada]
(
	@pACT_ID INT OUTPUT,
	@pACT_LB INT,
	@pACT_DESCRICAO VARCHAR(255),
	@pACT_RESPONSAVEL VARCHAR(80),
	@pACT_EXECUTANTE VARCHAR(200),
	@pACT_PRAZO SMALLDATETIME,
	@pACT_DATACONCLUSAO SMALLDATETIME,
	@pACT_EFICACIA TINYINT,
	@pACT_OBS TEXT,
	@pACT_TIPOACAO INT,
	@pACT_ARQUIVO VARCHAR(5000),
	@pACT_USUARIOCADASTROU VARCHAR(80)
)
AS
BEGIN
	SET NOCOUNT ON
	BEGIN TRANSACTION

	IF @pACT_ID IS NULL OR 	@pACT_ID = 0 BEGIN
		INSERT INTO LB_ACOESTOMADAS 
			VALUES (@pACT_LB, @pACT_DESCRICAO, @pACT_EXECUTANTE, @pACT_PRAZO,
			@pACT_DATACONCLUSAO, @pACT_EFICACIA, @pACT_OBS, @pACT_TIPOACAO, @pACT_RESPONSAVEL)
		IF @@ERROR <> 0 BEGIN
			ROLLBACK TRANSACTION
			RAISERROR( 'Não foi possível incluir esta ação.', 16, 1 )
			SELECT -1 AS SAIDA
			RETURN -1
		END
		SET @pACT_ID = @@IDENTITY
	END
	ELSE BEGIN
		UPDATE LB_ACOESTOMADAS 
			SET ACT_LB = @pACT_LB,
			ACT_DESCRICAO = @pACT_DESCRICAO,
			ACT_RESPONSAVEL = @pACT_RESPONSAVEL,
			ACT_EXECUTANTE = @pACT_EXECUTANTE,
			ACT_PRAZO = @pACT_PRAZO,
			ACT_DATACONCLUSAO = @pACT_DATACONCLUSAO, 
			ACT_EFICACIA = @pACT_EFICACIA, 
			ACT_OBS = @pACT_OBS, 
			ACT_TIPOACAO = @pACT_TIPOACAO
			WHERE ACT_ID = @pACT_ID
		IF @@ERROR <> 0 BEGIN
			ROLLBACK TRANSACTION
			RAISERROR( 'Não foi possível atualizar esta ação.', 16, 1 )
			SELECT -1 AS SAIDA
			RETURN -1
		END
	END


	IF @pACT_ARQUIVO IS NOT NULL
	BEGIN
		INSERT INTO LB_ACOESTOMADAS_ARQUIVOS
			VALUES (@pACT_ID, @pACT_LB, @pACT_ARQUIVO, @pACT_USUARIOCADASTROU, GETDATE())
		IF @@ERROR <> 0 BEGIN
			ROLLBACK TRANSACTION
			RAISERROR( 'Não foi possível anexar o arquivo desta esta ação.', 16, 1 )
			SELECT -1 AS SAIDA
			RETURN -1
		END
	END

	COMMIT TRANSACTION
	SELECT @pACT_ID AS SAIDA
	RETURN @pACT_ID
END
GO


/****** Object:  StoredProcedure [dbo].[sp_CadLogBookTipoOcorrencia]    Script Date: 07/19/2018 18:45:13 ******/
IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[dbo].[sp_CadLogBookTipoOcorrencia]') AND OBJECTPROPERTY(id,N'IsProcedure') = 1)
	DROP PROCEDURE [dbo].[sp_CadLogBookTipoOcorrencia]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[sp_CadLogBookTipoOcorrencia]
(
	@pId INT,
	@pDescricao VARCHAR(510)
)
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
GO


/****** Object:  StoredProcedure [dbo].[sp_CadOrgao]    Script Date: 07/19/2018 18:45:13 ******/
IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[dbo].[sp_CadOrgao]') AND OBJECTPROPERTY(id,N'IsProcedure') = 1)
	DROP PROCEDURE [dbo].[sp_CadOrgao]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[sp_CadOrgao]
(
	@orga_id INT,
	@orga_sigla VARCHAR(50),
	@orga_descricao VARCHAR(100),
	@orga_fax VARCHAR(50),
	@orga_ramal VARCHAR(50),
	@orga_exibir BIT,
	@orga_useridchefe VARCHAR(80),
	@orga_hierarquia INT
)
AS
BEGIN
	SET NOCOUNT ON

	BEGIN TRANSACTION

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
GO

/****** Object:  StoredProcedure [dbo].[sp_CadPesquisa]    Script Date: 07/19/2018 18:45:13 ******/
IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[dbo].[sp_CadPesquisa]') AND OBJECTPROPERTY(id,N'IsProcedure') = 1)
	DROP PROCEDURE [dbo].[sp_CadPesquisa]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE  PROCEDURE [dbo].[sp_CadPesquisa]
	@pPSQ_ID INT OUTPUT,
	@pUSERNAMECADASTRO VARCHAR(80),
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
GO


/****** Object:  StoredProcedure [dbo].[sp_CadPlataformaEquipamento]    Script Date: 07/19/2018 18:45:13 ******/
IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[dbo].[sp_CadPlataformaEquipamento]') AND OBJECTPROPERTY(id,N'IsProcedure') = 1)
	DROP PROCEDURE [dbo].[sp_CadPlataformaEquipamento]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[sp_CadPlataformaEquipamento]
(
	@pS_ID INT,
	@pEQ_ID_LISTA VARCHAR(8000)
)
AS
BEGIN
	SET NOCOUNT ON 

	BEGIN TRANSACTION

	DECLARE @msg VARCHAR(8000)
	DECLARE @Hoje DATETIME
	DECLARE @Dados VARCHAR(8000)
	DECLARE @reg VARCHAR(8000)
	DECLARE @separa_registro VARCHAR(1)
	DECLARE @fim INT
	DECLARE @ifim INT
	DECLARE @iini INT
	DECLARE @qtd_Lista INT

	SET @Hoje = GETDATE()

	IF (@pS_ID IS NULL) OR (@pS_ID = 0) BEGIN
		ROLLBACK TRANSACTION
		SET @msg = 'Nenhuma plataforma informada'
		RAISERROR(@msg, 16, 1)
		SELECT -1 AS SAIDA, @msg AS MENSAGEM
		RETURN -1
	END
	ELSE BEGIN
		-- passo a lista de strings para uma tabela temporaria
		CREATE TABLE #EQ_Lista (
			EQ_ID INT PRIMARY KEY
		)

		IF @pEQ_ID_LISTA IS NOT NULL
		BEGIN
			SET @DADOS = rtrim(ltrim(@pEQ_ID_LISTA))
			SET @separa_registro = ','

			SET @fim = 0
			SET @iini = 1

			WHILE ( @fim = 0 ) BEGIN
				SET @ifim = PATINDEX('%' + @separa_registro + '%', @DADOS )
				IF @ifim = 0 begin
					SET @reg = SUBSTRING( @DADOS, @iini, LEN( @DADOS ) )
				END
				ELSE begin
					SET @reg = SUBSTRING( @DADOS, @iini, @ifim - 1 )
				END

				IF @reg IS NOT NULL OR @reg <> ''
				BEGIN
					INSERT INTO #EQ_Lista (EQ_ID) VALUES (CAST(@reg AS INT))
					IF @@ERROR <> 0 BEGIN
						ROLLBACK TRANSACTION
						SELECT -1 AS SAIDA, 'Não foi possível operar lista de equipamentos da plataforma' AS MENSAGEM
						RETURN -1
					END
				END

				SET @DADOS = LTRIM(SUBSTRING( @DADOS, @ifim + len(@separa_registro), LEN(@DADOS) ))
				IF @ifim = 0 SET @fim = 1
			END

			-- esta na base, mas nao esta na lista - FACO A SAIDA DO EQUIPAMENTO
			INSERT INTO Historico_Plataforma_Equipamentos
				SELECT @Hoje, 'S', EQ_ID, S_ID FROM Plataforma_Equipamentos
				WHERE S_ID = @pS_ID AND EQ_ID NOT IN (SELECT EQ_ID FROM #EQ_Lista)
			IF @@ERROR <> 0 BEGIN
				ROLLBACK TRANSACTION
				SELECT -1 AS SAIDA, 'Não foi possível operar lista de equipamentos da plataforma' AS MENSAGEM
				RETURN -1
			END

			-- esta na lista, e nao esta na base
			INSERT INTO Historico_Plataforma_Equipamentos
				-- lista de equipamentos sendo incluidos
				SELECT @Hoje, 'E', e.EQ_ID, @pS_ID FROM #EQ_Lista e
				WHERE NOT EXISTS (
					SELECT pe1.EQ_ID FROM Plataforma_Equipamentos pe1
					WHERE pe1.S_ID = @pS_ID AND e.EQ_ID = pe1.EQ_ID
				)
			IF @@ERROR <> 0 BEGIN
				ROLLBACK TRANSACTION
				SELECT -1 AS SAIDA, 'Não foi possível operar lista de equipamentos da plataforma' AS MENSAGEM
				RETURN -1
			END
		END
		ELSE BEGIN
			-- esta na base, mas nao esta na lista - FACO A SAIDA DO EQUIPAMENTO
			INSERT INTO Historico_Plataforma_Equipamentos
				SELECT @Hoje, 'S', EQ_ID, S_ID FROM Plataforma_Equipamentos
				WHERE S_ID = @pS_ID
			IF @@ERROR <> 0 BEGIN
				ROLLBACK TRANSACTION
				SELECT -1 AS SAIDA, 'Não foi possível operar lista de equipamentos da plataforma' AS MENSAGEM
				RETURN -1
			END
		END


		-- apago os equipamentos da plataforma
		DELETE FROM PLATAFORMA_EQUIPAMENTOS WHERE S_ID = @pS_ID
		IF @@ERROR <> 0 BEGIN
			ROLLBACK TRANSACTION
			SET @msg = 'Não foi possível excluir os equipamentos desta plataforma'
			RAISERROR(@msg, 16, 1)
			SELECT -1 AS SAIDA, @msg AS MENSAGEM
			RETURN -1
		END

		-- se lista vazia entao estou removendo os equipamentos
		IF @pEQ_ID_LISTA IS NOT NULL
		BEGIN
			INSERT INTO PLATAFORMA_EQUIPAMENTOS
				SELECT @pS_ID, EQ_ID FROM #EQ_Lista
			IF @@ERROR <> 0 BEGIN
				ROLLBACK TRANSACTION
				SELECT -1 AS SAIDA, 'Não foi possível cadastrar os equipamentos da plataforma' AS MENSAGEM
				RETURN -1
			END
		END

		DROP TABLE #EQ_Lista

		COMMIT TRANSACTION
		SELECT 1 AS SAIDA, 'OK' AS MENSAGEM
		RETURN 1
	END
END
GO


/****** Object:  StoredProcedure [dbo].[sp_CadServPlataforma]    Script Date: 07/19/2018 18:45:13 ******/
IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[dbo].[sp_CadServPlataforma]') AND OBJECTPROPERTY(id,N'IsProcedure') = 1)
	DROP PROCEDURE [dbo].[sp_CadServPlataforma]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[sp_CadServPlataforma]
(
	@pId INT,
	@pDescricao VARCHAR(510),
	@pTipo BIT,
	@pId_Pai INT
)
AS
BEGIN
	SET NOCOUNT ON 

	BEGIN TRANSACTION

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
GO


/****** Object:  StoredProcedure [dbo].[sp_CadTecnologia]    Script Date: 07/19/2018 18:45:13 ******/
IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[dbo].[sp_CadTecnologia]') AND OBJECTPROPERTY(id,N'IsProcedure') = 1)
	DROP PROCEDURE [dbo].[sp_CadTecnologia]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[sp_CadTecnologia]
(
	@pId INT,
	@pDescricao VARCHAR(510),
	@pAreaTecnologica INT
)
AS
BEGIN
	SET NOCOUNT ON 

	BEGIN TRANSACTION

	DECLARE @msg VARCHAR(8000)

	IF (@pID IS NULL) OR (@pID = 0) BEGIN
		INSERT INTO tecnologia (tec_nome, at_id) VALUES (UPPER(@pDescricao), @pAreaTecnologica)
		IF @@ERROR <> 0 BEGIN
			ROLLBACK TRANSACTION
			SET @msg = 'Não foi possível inserir a tecnologia ' + @pDescricao
			RAISERROR(@msg, 16, 1)
			SELECT -1 AS SAIDA, @msg AS MENSAGEM
			RETURN -1
		END
		SET @pID = @@IDENTITY
	END
	ELSE BEGIN
		UPDATE	tecnologia SET tec_nome = UPPER(@pDescricao), at_id = @pAreaTecnologica
		WHERE	tec_id = @pId
		IF @@ERROR <> 0 BEGIN
			ROLLBACK TRANSACTION
			SET @msg = 'Não foi possível atualizar a tecnologia ' + @pDescricao
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

/****** Object:  StoredProcedure [dbo].[sp_CadTeste]    Script Date: 07/19/2018 18:45:13 ******/
IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[dbo].[sp_CadTeste]') AND OBJECTPROPERTY(id,N'IsProcedure') = 1)
	DROP PROCEDURE [dbo].[sp_CadTeste]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[sp_CadTeste]
(
	@pT_ID INT,
	@pT_TITULO VARCHAR(200),
	@pT_DISPONIVEL BIT,
	@pT_DESCRICAO VARCHAR(200),
	@pT_OBSERVACAO VARCHAR(200),
	@pTIT_ID INT,
	@pT_PERIODOREPETICAO INT
)
AS
BEGIN
	SET NOCOUNT ON
	DECLARE @msg VARCHAR(8000)
	BEGIN TRANSACTION

	IF @pT_ID IS NULL OR @pT_ID = 0
	BEGIN
		INSERT INTO Testes(T_TITULO, T_DISPONIVEL, T_OBSERVACAO, T_DESCRICAO, TIT_ID, T_PERIODOREPETICAO)
		VALUES (@pT_TITULO, @pT_DISPONIVEL, @pT_OBSERVACAO, @pT_DESCRICAO, @pTIT_ID, @pT_PERIODOREPETICAO)
		IF @@ERROR <> 0 BEGIN
			ROLLBACK TRANSACTION
			SET @msg = 'Não foi possível inserir o teste ' + @pT_TITULO
			RAISERROR(@msg, 16, 1)
			SELECT -1 AS SAIDA, @msg AS MENSAGEM
			RETURN -1
		END
		SET @pT_ID = @@IDENTITY
	END
	ELSE BEGIN
		UPDATE Testes SET
			T_TITULO = @pT_TITULO,
			T_DISPONIVEL = @pT_DISPONIVEL,
			TIT_ID = @pTIT_ID,
			T_OBSERVACAO = @pT_OBSERVACAO,
			T_DESCRICAO = @pT_DESCRICAO,
			T_PERIODOREPETICAO = @pT_PERIODOREPETICAO
			WHERE T_ID = @pT_ID
		IF @@ERROR <> 0 BEGIN
			ROLLBACK TRANSACTION
			SET @msg = 'Não foi possível atualizar o teste ' + @pT_TITULO
			RAISERROR(@msg, 16, 1)
			SELECT -1 AS SAIDA, @msg AS MENSAGEM
			RETURN -1
		END
	END

	COMMIT TRANSACTION
	SELECT @pT_ID AS SAIDA, 'OK' AS MENSAGEM
	RETURN @pT_ID
END
GO


/****** Object:  StoredProcedure [dbo].[sp_CadTipoArquivo]    Script Date: 07/19/2018 18:45:13 ******/
IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[dbo].[sp_CadTipoArquivo]') AND OBJECTPROPERTY(id,N'IsProcedure') = 1)
	DROP PROCEDURE [dbo].[sp_CadTipoArquivo]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[sp_CadTipoArquivo]
(
	@pId INT,
	@pDescricao VARCHAR(480),
	@pConfidencial BIT,
	@pDocQuali BIT
)
AS
BEGIN
	SET NOCOUNT ON 

	BEGIN TRANSACTION

	IF @pID IS NULL OR @pID = 0 
	BEGIN
		INSERT INTO TipoArquivo (TAR_TIPOARQUIVO, TAR_CONFIDENCIAL, TAR_DocQual) 
			VALUES (@pDescricao, @pConfidencial, @pDocQuali)
		IF @@ERROR <> 0 BEGIN
			ROLLBACK TRANSACTION
			RAISERROR( 'Não foi possível inserir tipo de arquivo', 16, 1)
			SELECT -1 AS SAIDA, 'Não foi possível inserir tipo de arquivo' AS MENSAGEM
			RETURN -1
		END
		SET @pID = @@IDENTITY
	END
	ELSE 
	BEGIN
		UPDATE TipoArquivo 
		SET 	TAR_TIPOARQUIVO = @pDescricao,
			TAR_CONFIDENCIAL = @pConfidencial, 
			TAR_DocQual = @pDocQuali
		WHERE TAR_CODTIPOARQUIVO = @pId
		IF @@ERROR <> 0 BEGIN
			ROLLBACK TRANSACTION
			RAISERROR( 'Não foi possível atualizar tipo de arquivo', 16, 1)
			SELECT -1 AS SAIDA, 'Não foi possível atualizar tipo de arquivo' AS MENSAGEM
			RETURN -1
		END
	END

	COMMIT TRANSACTION
	SELECT @pID AS SAIDA, 'OK' AS MENSAGEM
	RETURN @pID
END
GO


/****** Object:  StoredProcedure [dbo].[sp_CadTipoAtividade]    Script Date: 07/19/2018 18:45:13 ******/
IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[dbo].[sp_CadTipoAtividade]') AND OBJECTPROPERTY(id,N'IsProcedure') = 1)
	DROP PROCEDURE [dbo].[sp_CadTipoAtividade]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[sp_CadTipoAtividade]
(
	@pId INT,
	@pDescricao VARCHAR(510)
)
AS
BEGIN
	SET NOCOUNT ON 

	BEGIN TRANSACTION

	DECLARE @msg VARCHAR(8000)

	IF (@pID IS NULL) OR (@pID = 0) BEGIN
		INSERT INTO tipo_atividade (ta_descricao) VALUES (UPPER(@pDescricao))
		IF @@ERROR <> 0 BEGIN
			ROLLBACK TRANSACTION
			SET @msg = 'Não foi possível inserir a tipo de atividade ' + @pDescricao
			RAISERROR(@msg, 16, 1)
			SELECT -1 AS SAIDA, @msg AS MENSAGEM
			RETURN -1
		END
		SET @pID = @@IDENTITY
	END
	ELSE BEGIN
		UPDATE tipo_atividade 
		SET ta_descricao = UPPER(@pDescricao)
		WHERE ta_id = @pId
		IF @@ERROR <> 0 BEGIN
			ROLLBACK TRANSACTION
			SET @msg = 'Não foi possível atualizar o tipo de atividade ' + @pDescricao
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


/****** Object:  StoredProcedure [dbo].[sp_CadTipoTeste]    Script Date: 07/19/2018 18:45:13 ******/
IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[dbo].[sp_CadTipoTeste]') AND OBJECTPROPERTY(id,N'IsProcedure') = 1)
	DROP PROCEDURE [dbo].[sp_CadTipoTeste]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[sp_CadTipoTeste]
(
	@pId INT,
	@pDescricao VARCHAR(510)
)
AS
BEGIN
	SET NOCOUNT ON 

	BEGIN TRANSACTION

	DECLARE @msg VARCHAR(8000)

	IF (@pID IS NULL) OR (@pID = 0) BEGIN
		INSERT INTO tipo_teste (tit_descricao) VALUES (@pDescricao)
		IF @@ERROR <> 0 BEGIN
			ROLLBACK TRANSACTION
			SET @msg = 'Não foi possível inserir o tipo de teste ' + @pDescricao
			RAISERROR(@msg, 16, 1)
			SELECT -1 AS SAIDA, @msg AS MENSAGEM
			RETURN -1
		END
		SET @pID = @@IDENTITY
	END
	ELSE BEGIN
		UPDATE tipo_teste
		SET tit_descricao = @pDescricao
		WHERE tit_id = @pId
		IF @@ERROR <> 0 BEGIN
			ROLLBACK TRANSACTION
			SET @msg = 'Não foi possível atualizar o tipo de teste ' + @pDescricao
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


/****** Object:  StoredProcedure [dbo].[sp_CadUserCRT]    Script Date: 07/19/2018 18:45:13 ******/
IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[dbo].[sp_CadUserCRT]') AND OBJECTPROPERTY(id,N'IsProcedure') = 1)
	DROP PROCEDURE [dbo].[sp_CadUserCRT]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[sp_CadUserCRT]
(
	@pEhNovoUsuario BIT,
	@pUsername VARCHAR(80),
	@pMatricula FLOAT,
	@pNome VARCHAR(510),
	@pCelular VARCHAR(510),
	@pRamal FLOAT,
	@pOrgao INT,
	@pRAT BIT,
	@pRT BIT,
	@pQG BIT,
	@pEXIBIR BIT,
	@pPerfilSce TINYINT
)
AS
BEGIN
	SET NOCOUNT ON 

	BEGIN TRANSACTION

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
GO


/****** Object:  StoredProcedure [dbo].[sp_CancelaTeste]    Script Date: 07/19/2018 18:45:13 ******/
IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[dbo].[sp_CancelaTeste]') AND OBJECTPROPERTY(id,N'IsProcedure') = 1)
	DROP PROCEDURE [dbo].[sp_CancelaTeste]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE  PROCEDURE [dbo].[sp_CancelaTeste]
(
	@pAG_NUMERO SMALLINT,
	@pAG_MOTIVO VARCHAR(7000)
)
AS
BEGIN
	/*** Solicita o cancelamento de um agendamento */
	SET NOCOUNT ON

	BEGIN TRANSACTION

	-- marca para cancelamento e desmarca para Remarcacao de datas
	UPDATE Agendamento
		SET AG_SOLICITOUCANCELAMENTO = 1, AG_FLAGREMARCACAO = 0
		WHERE AG_NUMERO = @pAG_NUMERO
	IF @@ERROR <> 0 BEGIN
		RAISERROR('Não foi possível marcar o agendamento para ser cancelado.', 16, 1)
		ROLLBACK TRANSACTION
		RETURN -1
	END

	-- crio uma entrada no histórico de datas para guardar o motivo do cancelamento
	SELECT AG_NUMERO FROM Historico_datas WHERE AG_NUMERO = @pAG_NUMERO
	IF @@ROWCOUNT > 0 BEGIN
		INSERT INTO Historico_datas 
			(AG_NUMERO, HD_MARCACAO, HD_DATAINICIO, HD_DATATERMINO, HD_FLAGREMARCADO, HD_MOTIVO)
			SELECT AG_NUMERO, HD_MARCACAO + 1, HD_DATAINICIO, HD_DATATERMINO, 0, 'SOLICITAÇÃO DE CANCELAMENTO' + CHAR(13) + CHAR(10) + @pAG_MOTIVO
			from historico_datas
  			where AG_NUMERO = @pAG_NUMERO and HD_MARCACAO = (SELECT max(HD_MARCACAO) FROM historico_datas WHERE AG_NUMERO = @pAG_NUMERO)
		IF @@ERROR <> 0 BEGIN
			RAISERROR('Não foi possível inserir no histórico de datas.', 16, 1)
			ROLLBACK TRANSACTION
			RETURN -1
		END
	END
	ELSE BEGIN	-- nao existem registros em Historico_Datas
		INSERT INTO Historico_datas 
			(AG_NUMERO, HD_MARCACAO, HD_DATAINICIO, HD_DATATERMINO, HD_FLAGREMARCADO, HD_MOTIVO)
			VALUES (@pAG_NUMERO , 1, GETDATE(), GETDATE(), 0, 'SOLICITAÇÃO DE CANCELAMENTO' + CHAR(13) + CHAR(10) + @pAG_MOTIVO)
		IF @@ERROR <> 0 BEGIN
			RAISERROR('Não foi possível inserir no histórico de datas.', 16, 1)
			ROLLBACK TRANSACTION
			RETURN -1
		END
	END

	COMMIT TRANSACTION
	RETURN 1
END
GO


/****** Object:  StoredProcedure [dbo].[SP_CONSULTA_TAREFA]    Script Date: 07/19/2018 18:45:13 ******/
IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[dbo].[SP_CONSULTA_TAREFA]') AND OBJECTPROPERTY(id,N'IsProcedure') = 1)
	DROP PROCEDURE [dbo].[sp_Consulta_Tarefa]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[sp_Consulta_Tarefa]
(
	@tpid  INT
)
AS
BEGIN
	SET NOCOUNT ON

	SELECT TP.TAREFA_ID, AG_TITULO AS DESCRICAO_TAREFA, TP.TP_DATAINICIAL, TP.TP_DATAFINAL, TP.PES_USERNAME, TP.TP_OBSERVACAO, TP.TAREFA_TIPO
	FROM TAREFAS_PREVISTAS AS TP
	LEFT JOIN AGENDAMENTO AS A ON A.AG_NUMERO = TP.TAREFA_ID
	WHERE TP.TP_ID = @tpid
	AND TAREFA_TIPO = 0
	UNION
	SELECT TP.TAREFA_ID, T.TAR_DESCRICAO AS DESCRICAO_TAREFA, TP.TP_DATAINICIAL, TP.TP_DATAFINAL, TP.PES_USERNAME, TP.TP_OBSERVACAO, TP.TAREFA_TIPO
	FROM TAREFAS_PREVISTAS AS TP
	LEFT JOIN TAREFAS AS T ON T.TAR_ID = TP.TAREFA_ID
	WHERE TP.TP_ID = @tpid
	AND TAREFA_TIPO = 1
END
GO


/****** Object:  StoredProcedure [dbo].[SP_FAC_ATUALIZA_CARACTERISTICA]    Script Date: 07/19/2018 18:45:13 ******/
IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[dbo].[SP_FAC_ATUALIZA_CARACTERISTICA]') AND OBJECTPROPERTY(id,N'IsProcedure') = 1)
	DROP PROCEDURE [dbo].[SP_FAC_ATUALIZA_CARACTERISTICA]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[SP_FAC_ATUALIZA_CARACTERISTICA]
(
	@carID		INT,
	@carNome	VARCHAR(50),
	@carDefinicao	VARCHAR(5000)
)
AS
BEGIN
	SET NOCOUNT ON

	UPDATE FAC_CARACTERISTICAS SET CAR_NOME = UPPER( @carNome ), CAR_DEFINICAO = UPPER( @carDefinicao ) WHERE CAR_ID = @carID

	IF @@ERROR > 0
		RETURN -1
	ELSE
		RETURN 1
END
GO

/****** Object:  StoredProcedure [dbo].[SP_FAC_ATUALIZA_CIRCUITO]    Script Date: 07/19/2018 18:45:13 ******/
IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[dbo].[SP_FAC_ATUALIZA_CIRCUITO]') AND OBJECTPROPERTY(id,N'IsProcedure') = 1)
	DROP PROCEDURE [dbo].[SP_FAC_ATUALIZA_CIRCUITO]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[SP_FAC_ATUALIZA_CIRCUITO]
(
	@ctoID			INT,
	@ctoNome		VARCHAR(200),
	@tpcID			INT,
	@ASID			INT,
	@ctoPermanente	BIT,
	@ctoAtivado		BIT
)
AS
BEGIN
	SET NOCOUNT ON

	UPDATE FAC_CIRCUITO SET CTO_NOME = UPPER( @ctoNome ), AG_Numero = @ASID,  TPC_ID = @tpcID, CTO_PERMANENTE = @ctoPermanente, CTO_ATIVADO = @ctoAtivado WHERE CTO_ID = @ctoID

	IF @@ERROR > 0
		RETURN -1 --erro na atualização
	ELSE
		RETURN 1
END
GO


/****** Object:  StoredProcedure [dbo].[SP_FAC_ATUALIZA_COMPONENTE]    Script Date: 07/19/2018 18:45:13 ******/
IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[dbo].[SP_FAC_ATUALIZA_COMPONENTE]') AND OBJECTPROPERTY(id,N'IsProcedure') = 1)
	DROP PROCEDURE [dbo].[SP_FAC_ATUALIZA_COMPONENTE]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[SP_FAC_ATUALIZA_COMPONENTE]
(
	@cptID			INT,
	@cptNome		VARCHAR(200),
	@vsw_atu		VARCHAR(100),
	@vsw_std		VARCHAR(100),
	@obs			VARCHAR(255),
	@tpcID			INT,
	@intIDs			VARCHAR(8000),
	@intQuants		VARCHAR(8000),
	@leeID			INT,
	@cptCodSGPSCE	VARCHAR(50)
)
AS
BEGIN
	SET NOCOUNT ON

	BEGIN TRAN

	UPDATE FAC_COMPONENTES SET CPT_NOME =  UPPER( @cptNome ), TPC_ID = @tpcID, LEE_ID = @leeID, CPT_COD_SGP_SCE = @cptCodSGPSCE, vsw_atu = @vsw_atu, vsw_std = @vsw_std, obs = @obs  WHERE CPT_ID = @cptID


	DECLARE @intID INT, @intQuant INT, @ifim INT, @ifim2 INT


	/* Parte das Interfaces */
	DELETE FROM FAC_COMPONENTES_INTERFACE WHERE CPT_ID = @cptID
	IF @@ERROR > 0 BEGIN
		ROLLBACK TRAN
		RETURN -1 --ocorreu um erro durante a exclusão
	END

	IF @intIDs <> '' AND @intIDs IS NOT NULL BEGIN
	
		SET @ifim = 1	
		WHILE ( @ifim != 0 ) BEGIN
			SET @ifim = PATINDEX('%,%', @intIDs )
			SET @ifim2 = PATINDEX('%,%', @intQuants )
			IF @ifim = 0 BEGIN
				SET @intID = SUBSTRING( @intIDs, 1, len(@intIDs) )
				SET @intQuant = SUBSTRING( @intQuants, 1, len(@intQuants) )
			END
			ELSE BEGIN
				SET @intID = SUBSTRING( @intIDs, 1, @ifim -1 )
				SET @intQuant = SUBSTRING( @intQuants, 1, @ifim2 -1 )
			END

			INSERT INTO FAC_COMPONENTES_INTERFACE (TIPO_INTERFACE_ID, CPT_ID, Qtd_Int) VALUES (@intID, @cptID, @intQuant)
			IF @@ERROR > 0 BEGIN
				ROLLBACK TRAN
				RETURN -2 --erro na inserção
			END

			SET @intIDs = LTRIM(SUBSTRING( @intIDs, @ifim + 1, LEN(@intIDs) ))
			SET @intQuants = LTRIM(SUBSTRING( @intQuants, @ifim2 + 1, LEN(@intQuants) ))
		END
	END


	/* Fim Parte das Interfaces */

	COMMIT TRAN

	IF @@ERROR > 0
		RETURN -1
	ELSE
		RETURN 1
END
GO

/****** Object:  StoredProcedure [dbo].[SP_FAC_ATUALIZA_FABRICANTE]    Script Date: 07/19/2018 18:45:13 ******/
IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[dbo].[SP_FAC_ATUALIZA_FABRICANTE]') AND OBJECTPROPERTY(id,N'IsProcedure') = 1)
	DROP PROCEDURE [dbo].[SP_FAC_ATUALIZA_FABRICANTE]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[SP_FAC_ATUALIZA_FABRICANTE]
(
	@fabID		INT,
	@fabNome	VARCHAR(200)
)
AS
BEGIN
	SET NOCOUNT ON

	UPDATE FAC_FABRICANTE_TIPO_COMPONENTE SET FAB_NOME = UPPER ( @fabNome ) WHERE FAB_ID = @fabID

	IF @@ERROR > 0
		RETURN -1 --erro ao atualizar
	ELSE
		RETURN 1
END
GO


/****** Object:  StoredProcedure [dbo].[SP_FAC_ATUALIZA_FAMILIA_TIPO_COMPONENTE]    Script Date: 07/19/2018 18:45:13 ******/
IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[dbo].[SP_FAC_ATUALIZA_FAMILIA_TIPO_COMPONENTE]') AND OBJECTPROPERTY(id,N'IsProcedure') = 1)
	DROP PROCEDURE [dbo].[SP_FAC_ATUALIZA_FAMILIA_TIPO_COMPONENTE]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[SP_FAC_ATUALIZA_FAMILIA_TIPO_COMPONENTE]
(
	@ftcID		INT,
	@ftcNome	VARCHAR(200)
)
AS
BEGIN
	SET NOCOUNT ON

	UPDATE FAC_FAMILIA_TIPO_COMPONENTE SET FTC_NOME = UPPER( @ftcNome ) WHERE FTC_ID = @ftcID

	IF @@ERROR > 0
		RETURN -1--erro na inserção
	ELSE
		RETURN 1
END
GO

/****** Object:  StoredProcedure [dbo].[SP_FAC_ATUALIZA_LOCAL_ESPECIFICO]    Script Date: 07/19/2018 18:45:13 ******/
IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[dbo].[SP_FAC_ATUALIZA_LOCAL_ESPECIFICO]') AND OBJECTPROPERTY(id,N'IsProcedure') = 1)
	DROP PROCEDURE [dbo].[SP_FAC_ATUALIZA_LOCAL_ESPECIFICO]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[SP_FAC_ATUALIZA_LOCAL_ESPECIFICO]
(
	@leeID		INT,
	@leeNome	VARCHAR(50),
	@lgeID		INT
)
AS
BEGIN
	SET NOCOUNT ON

	UPDATE FAC_LOCAIS_ESPECIFICOS_EQUIP SET LGE_ID = @lgeID, LEE_NOME = UPPER( @leeNome) WHERE LEE_ID = @leeID

	IF @@ERROR > 0
		RETURN -1
	ELSE
		RETURN 1
END
GO

/****** Object:  StoredProcedure [dbo].[SP_FAC_ATUALIZA_LOCAL_GENERICO]    Script Date: 07/19/2018 18:45:13 ******/
IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[dbo].[SP_FAC_ATUALIZA_LOCAL_GENERICO]') AND OBJECTPROPERTY(id,N'IsProcedure') = 1)
	DROP PROCEDURE [dbo].[SP_FAC_ATUALIZA_LOCAL_GENERICO]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[SP_FAC_ATUALIZA_LOCAL_GENERICO]
(
	@lgeID		INT,
	@lgeNome	VARCHAR(50),
	@lgeTipo	CHAR
)
AS
BEGIN
	SET NOCOUNT ON

	UPDATE FAC_LOCAIS_GENERICOS_EQUIP SET LGE_NOME = UPPER( @lgeNome), LGE_TIPO = @lgeTipo WHERE LGE_ID = @lgeID

	IF @@ERROR > 0
		RETURN -1
	ELSE
		RETURN 1
END
GO


/****** Object:  StoredProcedure [dbo].[SP_FAC_ATUALIZA_REL_CARACTERISTICAS_TIPO]    Script Date: 07/19/2018 18:45:13 ******/
IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[dbo].[SP_FAC_ATUALIZA_REL_CARACTERISTICAS_TIPO]') AND OBJECTPROPERTY(id,N'IsProcedure') = 1)
	DROP PROCEDURE [dbo].[SP_FAC_ATUALIZA_REL_CARACTERISTICAS_TIPO]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[SP_FAC_ATUALIZA_REL_CARACTERISTICAS_TIPO]
(
	@carIDs	VARCHAR(8000),
	@rctQuants	VARCHAR(8000),
	@tpcID		INT
)
AS
BEGIN
	SET NOCOUNT ON

	DECLARE @carID INT, @rctQuant INT, @ifim INT, @ifim2 INT

	BEGIN TRAN

		DELETE FROM FAC_REL_CARACTERISTICAS_TIPO WHERE @tpcID = TPC_ID
		IF @@ERROR > 0 BEGIN
			ROLLBACK TRAN
			RETURN -1 --ocorreu um erro durante a exclusão
		END

		IF @carIDs <> '' AND @carIDs IS NOT NULL BEGIN
	
			SET @ifim = 1	
			WHILE ( @ifim != 0 ) BEGIN
				SET @ifim = PATINDEX('%,%', @carIDs )
				SET @ifim2 = PATINDEX('%,%', @rctQuants )
				IF @ifim = 0 BEGIN
					SET @carID = SUBSTRING( @carIDs, 1, len(@carIDs) )
					SET @rctQuant = SUBSTRING( @rctQuants, 1, len(@rctQuants) )
				END
				ELSE BEGIN
					SET @carID = SUBSTRING( @carIDs, 1, @ifim -1 )
					SET @rctQuant = SUBSTRING( @rctQuants, 1, @ifim2 -1 )
				END

				INSERT INTO FAC_REL_CARACTERISTICAS_TIPO (CAR_ID, TPC_ID, RCT_QUANTIDADE) VALUES (@carID, @tpcID, @rctQuant)
				IF @@ERROR > 0 BEGIN
					ROLLBACK TRAN
					RETURN -2 --erro na inserção
				END

				SET @carIDs = LTRIM(SUBSTRING( @carIDs, @ifim + 1, LEN(@carIDs) ))
				SET @rctQuants = LTRIM(SUBSTRING( @rctQuants, @ifim2 + 1, LEN(@rctQuants) ))
			END
		END

	COMMIT TRAN
	RETURN 1
END
GO

/****** Object:  StoredProcedure [dbo].[SP_FAC_ATUALIZA_REL_CIRCUITO_AGENDAMENTO]    Script Date: 07/19/2018 18:45:13 ******/
IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[dbo].[SP_FAC_ATUALIZA_REL_CIRCUITO_AGENDAMENTO]') AND OBJECTPROPERTY(id,N'IsProcedure') = 1)
	DROP PROCEDURE [dbo].[SP_FAC_ATUALIZA_REL_CIRCUITO_AGENDAMENTO]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[SP_FAC_ATUALIZA_REL_CIRCUITO_AGENDAMENTO]
(
	@agNumeros	VARCHAR(8000),
	@ctoID		INT
)
AS
BEGIN
	SET NOCOUNT ON

	DECLARE @agNumero INTEGER, @ifim INTEGER

	BEGIN TRAN

		DELETE FROM FAC_REL_CIRCUITO_AGENDAMENTO WHERE @ctoID = CTO_ID

		IF @@ERROR > 0 BEGIN
			ROLLBACK TRAN
			RETURN -1 --ocorreu um erro durante a exclusão
		END

		IF @agNumeros <> '' AND @agNumeros IS NOT NULL BEGIN
	
			SET @ifim = 1	
			WHILE ( @ifim != 0 ) BEGIN
				SET @ifim = PATINDEX('%,%', @agNumeros )

				IF @ifim = 0
					SET @agNumero = SUBSTRING( @agNumeros, 1, len(@agNumeros) )
				ELSE
					SET @agNumero = SUBSTRING( @agNumeros, 1, @ifim -1 )

				INSERT INTO FAC_REL_CIRCUITO_AGENDAMENTO ( AG_NUMERO, CTO_ID ) VALUES ( @agNumero, @ctoID )
				IF @@ERROR > 0 BEGIN
					ROLLBACK TRAN
					RETURN -2 --erro na inserção
				END

				SET @agNumeros = LTRIM(SUBSTRING( @agNumeros, @ifim + 1, LEN(@agNumeros) ))
			END
		END

	COMMIT TRAN
	RETURN 1
END
GO

/****** Object:  StoredProcedure [dbo].[SP_FAC_CADASTRA_CARACTERISTICA]    Script Date: 07/19/2018 18:45:13 ******/
IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[dbo].[SP_FAC_CADASTRA_CARACTERISTICA]') AND OBJECTPROPERTY(id,N'IsProcedure') = 1)
	DROP PROCEDURE [dbo].[SP_FAC_CADASTRA_CARACTERISTICA]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[SP_FAC_CADASTRA_CARACTERISTICA]
(
	@carNome	VARCHAR(50),
	@carDefinicao	VARCHAR(5000)
)
AS
BEGIN
	SET NOCOUNT ON

	DECLARE @tmp INT

	SELECT @tmp = CAR_ID FROM FAC_CARACTERISTICAS WHERE UPPER( @carNome ) = CAR_NOME

	IF @@ROWCOUNT > 0
		RETURN @tmp
	ELSE BEGIN

		INSERT INTO FAC_CARACTERISTICAS (CAR_NOME, CAR_DEFINICAO) VALUES ( UPPER( @carNome ), UPPER( @carDefinicao ) )

		IF @@ERROR > 0
			RETURN -1
		ELSE
			RETURN @@IDENTITY
	END
END
GO

/****** Object:  StoredProcedure [dbo].[SP_FAC_CADASTRA_CIRCUITO]    Script Date: 07/19/2018 18:45:13 ******/
IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[dbo].[SP_FAC_CADASTRA_CIRCUITO]') AND OBJECTPROPERTY(id,N'IsProcedure') = 1)
DROP PROCEDURE [dbo].[SP_FAC_CADASTRA_CIRCUITO]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[SP_FAC_CADASTRA_CIRCUITO]
(
	@ctoNome		VARCHAR(200),
	@tpcID			INT, --tipo de circuito
	@ASID			INT, --tipo de circuito
	@ctoPermanente	BIT,
	@ctoAtivado		BIT
)
AS
BEGIN
	SET NOCOUNT ON

	INSERT INTO FAC_CIRCUITO (CTO_NOME, TPC_ID, CTO_PERMANENTE, CTO_ATIVADO, AG_NUMERO) VALUES ( UPPER( @ctoNome ), @tpcID, @ctoPermanente, @ctoAtivado, @ASID)

	IF @@ERROR > 0
		RETURN -1
	ELSE
		RETURN @@IDENTITY
END
GO

/****** Object:  StoredProcedure [dbo].[SP_FAC_CADASTRA_COMPONENTE]    Script Date: 07/19/2018 18:45:13 ******/
IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[dbo].[SP_FAC_CADASTRA_COMPONENTE]') AND OBJECTPROPERTY(id,N'IsProcedure') = 1)
	DROP PROCEDURE [dbo].[SP_FAC_CADASTRA_COMPONENTE]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[SP_FAC_CADASTRA_COMPONENTE]
(
	@cptNome		VARCHAR(200),
	@vsw_atu		VARCHAR(100),
	@vsw_std		VARCHAR(100),
	@obs			VARCHAR(255),
	@tpcID			INT,
	@intIDs			VARCHAR(8000),
	@intQuants		VARCHAR(8000),
	@leeID			INT,
	@cptCodSGPSCE	VARCHAR(50)
)
AS
BEGIN
	SET NOCOUNT ON

	DECLARE @tmp INT

	DECLARE @intID INT, @intQuant INT, @ifim INT, @ifim2 INT

	SELECT @tmp = CPT_ID FROM FAC_COMPONENTES WHERE UPPER( @cptNome ) = CPT_NOME AND @tpcID = TPC_ID AND @leeID = LEE_ID

	IF @@ROWCOUNT > 0
		RETURN @tmp
	ELSE BEGIN

		INSERT INTO FAC_COMPONENTES (CPT_NOME, TPC_ID, LEE_ID, CPT_COD_SGP_SCE,vsw_atu,vsw_std,obs) VALUES ( UPPER( @cptNome ), @tpcID, @leeID, @cptCodSGPSCE,@vsw_atu, @vsw_std,@obs)


	/* Parte das Interfaces */

		SELECT @tmp = CPT_ID FROM FAC_COMPONENTES WHERE UPPER( @cptNome ) = CPT_NOME AND @tpcID = TPC_ID AND @leeID = LEE_ID


		DELETE FROM FAC_COMPONENTES_INTERFACE WHERE @tmp = CPT_ID
		IF @@ERROR > 0 BEGIN
			ROLLBACK TRAN
			RETURN -1 --ocorreu um erro durante a exclusão
		END

		IF @intIDs <> '' AND @intIDs IS NOT NULL BEGIN
	
			SET @ifim = 1	
			WHILE ( @ifim != 0 ) BEGIN
				SET @ifim = PATINDEX('%,%', @intIDs )
				SET @ifim2 = PATINDEX('%,%', @intQuants )
				IF @ifim = 0 BEGIN
					SET @intID = SUBSTRING( @intIDs, 1, len(@intIDs) )
					SET @intQuant = SUBSTRING( @intQuants, 1, len(@intQuants) )
				END
				ELSE BEGIN
					SET @intID = SUBSTRING( @intIDs, 1, @ifim -1 )
					SET @intQuant = SUBSTRING( @intQuants, 1, @ifim2 -1 )
				END

				INSERT INTO FAC_COMPONENTES_INTERFACE (TIPO_INTERFACE_ID, CPT_ID, Qtd_Int) VALUES (@intID, @tmp, @intQuant)
				IF @@ERROR > 0 BEGIN
					ROLLBACK TRAN
					RETURN -2 --erro na inserção
				END

				SET @intIDs = LTRIM(SUBSTRING( @intIDs, @ifim + 1, LEN(@intIDs) ))
				SET @intQuants = LTRIM(SUBSTRING( @intQuants, @ifim2 + 1, LEN(@intQuants) ))
			END
		END


	/* Fim Parte das Interfaces */


		IF @@ERROR > 0
			RETURN -1
		ELSE
			RETURN @@IDENTITY
	END 
END
GO


/****** Object:  StoredProcedure [dbo].[SP_FAC_CADASTRA_FABRICANTE]    Script Date: 07/19/2018 18:45:13 ******/
IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[dbo].[SP_FAC_CADASTRA_FABRICANTE]') AND OBJECTPROPERTY(id,N'IsProcedure') = 1)
	DROP PROCEDURE [dbo].[SP_FAC_CADASTRA_FABRICANTE]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[SP_FAC_CADASTRA_FABRICANTE]
(
	@fabNome	VARCHAR(200)
)
AS
BEGIN
	SET NOCOUNT ON

	DECLARE @tmp INT

	SELECT @tmp = FAB_ID FROM FAC_FABRICANTE_TIPO_COMPONENTE WHERE FAB_NOME = UPPER( @fabNome )

	IF @@ROWCOUNT > 0
		RETURN @tmp

	INSERT INTO FAC_FABRICANTE_TIPO_COMPONENTE (FAB_NOME) VALUES ( UPPER ( @fabNome ) )

	IF @@ERROR > 0
		RETURN -1 --erro ao inserir
	ELSE
		RETURN @@IDENTITY
END
GO

/****** Object:  StoredProcedure [dbo].[SP_FAC_CADASTRA_FACILIDADE]    Script Date: 07/19/2018 18:45:13 ******/
IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[dbo].[SP_FAC_CADASTRA_FACILIDADE]') AND OBJECTPROPERTY(id,N'IsProcedure') = 1)
	DROP PROCEDURE [dbo].[SP_FAC_CADASTRA_FACILIDADE]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_FAC_CADASTRA_FACILIDADE]
(
	@ctoID		INT,
	@cptID		INT,
	@intID		INT,
	@facOrdem	TINYINT
)
AS
BEGIN
	SET NOCOUNT ON

	IF @facOrdem IS NULL

		SELECT @facOrdem =
					CASE
						WHEN MAX(FAC_ORDEM) IS NULL THEN 0
						ELSE MAX(FAC_ORDEM) + 1
					END
		FROM FAC_FACILIDADES WHERE CPT_ID = @cptID AND CTO_ID = @ctoID
	
	BEGIN TRAN

	SELECT FAC_ID FROM FAC_FACILIDADES WHERE FAC_ORDEM = @facOrdem AND CTO_ID = @ctoID

	IF @@ROWCOUNT > 0 BEGIN

		UPDATE FAC_FACILIDADES SET FAC_ORDEM = FAC_ORDEM + 1 WHERE FAC_ORDEM >= @facOrdem AND CTO_ID = @ctoID

		IF @@ERROR > 0 BEGIN
			ROLLBACK TRAN
			RETURN -1 --erro de atualização
		END
	END

	INSERT INTO FAC_FACILIDADES (CPT_ID, CTO_ID, FAC_ORDEM,Tipo_Interface_Id) VALUES (@cptID, @ctoID, @facOrdem,@intID)

	IF @@ERROR > 0 BEGIN
		ROLLBACK TRAN
		RETURN -2 --erro na inserção
	END
	ELSE BEGIN
		COMMIT TRAN
		RETURN @@IDENTITY
	END
END
GO


/****** Object:  StoredProcedure [dbo].[SP_FAC_CADASTRA_FAMILIA_TIPO_COMPONENTE]    Script Date: 07/19/2018 18:45:13 ******/
IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[dbo].[SP_FAC_CADASTRA_FAMILIA_TIPO_COMPONENTE]') AND OBJECTPROPERTY(id,N'IsProcedure') = 1)
	DROP PROCEDURE [dbo].[SP_FAC_CADASTRA_FAMILIA_TIPO_COMPONENTE]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[SP_FAC_CADASTRA_FAMILIA_TIPO_COMPONENTE]
(
	@ftcNome	VARCHAR(200)
)
AS
BEGIN
	SET NOCOUNT ON

	DECLARE @tmp INT

	SELECT @tmp = FTC_ID FROM FAC_FAMILIA_TIPO_COMPONENTE WHERE FTC_NOME = UPPER( @ftcNome )

	IF @@ROWCOUNT > 0
		RETURN @tmp

	INSERT INTO FAC_FAMILIA_TIPO_COMPONENTE ( FTC_NOME ) VALUES ( UPPER( @ftcNome ) )

	IF @@ERROR > 0
		RETURN -1--erro na inserção
	ELSE
		RETURN @@IDENTITY
END
GO


/****** Object:  StoredProcedure [dbo].[SP_FAC_CADASTRA_LOCAL_ESPECIFICO]    Script Date: 07/19/2018 18:45:13 ******/
IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[dbo].[SP_FAC_CADASTRA_LOCAL_ESPECIFICO]') AND OBJECTPROPERTY(id,N'IsProcedure') = 1)
	DROP PROCEDURE [dbo].[SP_FAC_CADASTRA_LOCAL_ESPECIFICO]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[SP_FAC_CADASTRA_LOCAL_ESPECIFICO]
(
	@lgeID		INT,
	@leeNome	VARCHAR(50)
)
AS
BEGIN
	SET NOCOUNT ON

	DECLARE @tmp INT

	SELECT @tmp = LEE_ID FROM FAC_LOCAIS_ESPECIFICOS_EQUIP WHERE LGE_ID = @lgeID AND LEE_NOME = UPPER(@leeNome)

	IF @@ROWCOUNT > 0
		RETURN @tmp
	ELSE BEGIN
		INSERT INTO FAC_LOCAIS_ESPECIFICOS_EQUIP (LGE_ID, LEE_NOME) VALUES ( @lgeID, UPPER(@leeNome) )

		IF @@ERROR > 0
			RETURN -1
		ELSE
			RETURN @@IDENTITY
	END
END
GO

/****** Object:  StoredProcedure [dbo].[SP_FAC_CADASTRA_LOCAL_GENERICO]    Script Date: 07/19/2018 18:45:13 ******/
IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[dbo].[SP_FAC_CADASTRA_LOCAL_GENERICO]') AND OBJECTPROPERTY(id,N'IsProcedure') = 1)
	DROP PROCEDURE [dbo].[SP_FAC_CADASTRA_LOCAL_GENERICO]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[SP_FAC_CADASTRA_LOCAL_GENERICO]
(
	@lgeNome	VARCHAR(50),
	@lgeTipo	CHAR
)
AS
BEGIN
	SET NOCOUNT ON

	DECLARE @tmp INT

	SELECT @tmp = LGE_ID FROM FAC_LOCAIS_GENERICOS_EQUIP WHERE UPPER(@lgeNome) = LGE_NOME AND UPPER(@lgeTipo) = LGE_TIPO

	IF @@ROWCOUNT > 0
		RETURN @tmp
	ELSE BEGIN
		INSERT INTO FAC_LOCAIS_GENERICOS_EQUIP (LGE_NOME, LGE_TIPO) VALUES ( UPPER(@lgeNome), UPPER(@lgeTipo) )

		IF @@ERROR > 0
			RETURN -1 --erro na inserção
		ELSE
			RETURN @@IDENTITY
	END
END
GO

/****** Object:  StoredProcedure [dbo].[SP_FAC_CADASTRA_REL_CARACTERISTICAS_FACILIDADES]    Script Date: 07/19/2018 18:45:13 ******/
IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[dbo].[SP_FAC_CADASTRA_REL_CARACTERISTICAS_FACILIDADES]') AND OBJECTPROPERTY(id,N'IsProcedure') = 1)
	DROP PROCEDURE [dbo].[SP_FAC_CADASTRA_REL_CARACTERISTICAS_FACILIDADES]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_FAC_CADASTRA_REL_CARACTERISTICAS_FACILIDADES]
(
	@carID		INT,
	@tpcID		INT,
	@facID		INT,
	@rcfIdentCaract	VARCHAR(255)
)
AS
BEGIN
	SET NOCOUNT ON

	SELECT FAC_ID FROM	FAC_FACILIDADES
		INNER JOIN FAC_COMPONENTES ON FAC_FACILIDADES.CPT_ID = FAC_COMPONENTES.CPT_ID
		INNER JOIN FAC_TIPO_COMPONENTE ON FAC_COMPONENTES.TPC_ID = FAC_TIPO_COMPONENTE.TPC_ID
		INNER JOIN FAC_REL_CARACTERISTICAS_TIPO ON FAC_TIPO_COMPONENTE. TPC_ID = FAC_REL_CARACTERISTICAS_TIPO.TPC_ID
	WHERE FAC_REL_CARACTERISTICAS_TIPO.CAR_ID = @carID AND FAC_REL_CARACTERISTICAS_TIPO.TPC_ID = @tpcID AND FAC_FACILIDADES.FAC_ID = @facID

	IF @@ROWCOUNT = 0
		RETURN -1 --o relacionamento não existe, logo esta característica não pertence a este tipo de equipamento
	ELSE BEGIN
		INSERT INTO FAC_REL_CARACTERISTICAS_FACILIDADES (CAR_ID, TPC_ID, FAC_ID, RCF_IDENTIFICADOR_CARACTERISTICA) VALUES (@carID, @tpcID, @facID, @rcfIdentCaract)
		IF @@ERROR > 0
			RETURN -2 --erro de inserção
		ELSE
			RETURN 1 --OK
	END
END
GO


/****** Object:  StoredProcedure [dbo].[SP_FAC_CADASTRA_TIPO_COMPONENTE]    Script Date: 07/19/2018 18:45:13 ******/
IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[dbo].[SP_FAC_CADASTRA_TIPO_COMPONENTE]') AND OBJECTPROPERTY(id,N'IsProcedure') = 1)
	DROP PROCEDURE [dbo].[SP_FAC_CADASTRA_TIPO_COMPONENTE]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[SP_FAC_CADASTRA_TIPO_COMPONENTE]
(
	@tpcNome	VARCHAR(50),
	@ftcID		INT,
	@fabID		INT
)
AS
BEGIN
	SET NOCOUNT ON

	DECLARE @tmp INT

	SELECT @tmp = TPC_ID FROM FAC_TIPO_COMPONENTE WHERE UPPER( @tpcNome ) = TPC_NOME AND FTC_ID = @ftcID AND FAB_ID = @fabID

	IF @@ROWCOUNT > 0
		RETURN @tmp
	ELSE BEGIN

		INSERT INTO FAC_TIPO_COMPONENTE (TPC_NOME, FTC_ID, FAB_ID) VALUES ( UPPER( @tpcNome ), @ftcID, @fabID )

		IF @@ERROR > 0
			RETURN -1
		ELSE
			RETURN @@IDENTITY
	END
END
GO


/****** Object:  StoredProcedure [dbo].[SP_FAC_EXCLUI_FACILIDADE]    Script Date: 07/19/2018 18:45:13 ******/
IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[dbo].[SP_FAC_EXCLUI_FACILIDADE]') AND OBJECTPROPERTY(id,N'IsProcedure') = 1)
	DROP PROCEDURE [dbo].[SP_FAC_EXCLUI_FACILIDADE]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[SP_FAC_EXCLUI_FACILIDADE]
(
	@facID	INT
)
AS
BEGIN
	SET NOCOUNT ON

	DECLARE @tmp1 TINYINT, @tmp2 INT

	SELECT @tmp1 = FAC_ORDEM, @tmp2 = CTO_ID FROM FAC_FACILIDADES WHERE FAC_ID = @facID

	IF @@ROWCOUNT = 0
		RETURN -1 --erro: FAC_ID não existia
	ELSE BEGIN

		BEGIN TRAN

			DELETE FROM FAC_FACILIDADES WHERE FAC_ID = @facID
			IF @@ERROR > 0 BEGIN
				ROLLBACK TRAN
				RETURN - 2 --erro na exclusão
			END
			ELSE BEGIN
				IF @@ROWCOUNT > 0 BEGIN
					UPDATE FAC_FACILIDADES SET FAC_ORDEM = FAC_ORDEM - 1 WHERE FAC_ORDEM > @tmp1 AND CTO_ID = @tmp2
					IF @@ERROR > 0 BEGIN
						ROLLBACK TRAN
						RETURN -3 --erro na atualização
					END
				END
				ELSE BEGIN
					COMMIT TRAN
					RETURN 1 --OK
				END
			END
	END
END
GO


/****** Object:  StoredProcedure [dbo].[SP_FAC_EXCLUI_LOCAL_ESPECIFICO]    Script Date: 07/19/2018 18:45:13 ******/
IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[dbo].[SP_FAC_EXCLUI_LOCAL_ESPECIFICO]') AND OBJECTPROPERTY(id,N'IsProcedure') = 1)
	DROP PROCEDURE [dbo].[SP_FAC_EXCLUI_LOCAL_ESPECIFICO]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[SP_FAC_EXCLUI_LOCAL_ESPECIFICO]
(
	@leeID	INT
)
AS
BEGIN
	SET NOCOUNT ON

	DELETE FROM FAC_LOCAIS_ESPECIFICOS_EQUIP WHERE LEE_ID = @leeID
	IF @@ERROR > 0
		RETURN - 1 --erro na exclusão
	ELSE
		RETURN 1
END
GO


/****** Object:  StoredProcedure [dbo].[SP_Indicador_Eficiencia_Geral]    Script Date: 07/19/2018 18:45:13 ******/
IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[dbo].[SP_Indicador_Eficiencia_Geral]') AND OBJECTPROPERTY(id,N'IsProcedure') = 1)
	DROP PROCEDURE [dbo].[sp_Indicador_Eficiencia_Geral]
GO


/****** Object:  StoredProcedure [dbo].[sp_Indicador_Eventos_Atividade]    Script Date: 07/19/2018 18:45:13 ******/
IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[dbo].[sp_Indicador_Eventos_Atividade]') AND OBJECTPROPERTY(id,N'IsProcedure') = 1)
	DROP PROCEDURE [dbo].[sp_Indicador_Eventos_Atividade]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[sp_Indicador_Eventos_Atividade]
(
	@dataIni AS DATETIME,
	@dataFim AS DATETIME,
	@Retorno AS VARCHAR(50)
)
AS
BEGIN
	/***
		Calcula os indicadores de Atidade dentro de uma faixa de datas.
		O calculo pode ser feito por tipo de atividade ou por responsável ou ambos

		Obs: A primeira linha do recordset é sempre o somatório dos índices

		Gilberto - COPPETEC
		Criado em: 13/04/2004
	***/
	SET NOCOUNT ON

	-- crio uma tabela temporária para calculo dos indicadores
	CREATE TABLE #Indicadores (
		Nome VARCHAR(80),
		Inicio DATETIME,
		Fim DATETIME,
		Agendamento INT,
		Responsavel VARCHAR(80),
		Dias INT
	)

	INSERT INTO #Indicadores (nome, inicio, fim, Agendamento, Responsavel, dias)
		SELECT ta.TA_DESCRICAO, AG_DATAINICIO, a.AG_DATATERMINO, a.AG_NUMERO, a.AG_RESPONSAVEL,
		CASE	-- calculo a média do mês
			WHEN (CONVERT(DATETIME, AG_DATAINICIO, 103) <= @dataIni) and (CONVERT(DATETIME, AG_DATATERMINO, 103) <= @dataFim)
			THEN CAST(datediff(day, @dataIni, CONVERT(DATETIME, AG_DATATERMINO, 103)) AS DECIMAL) + 1

			WHEN (CONVERT(DATETIME, AG_DATAINICIO, 103) <= @dataIni) and (CONVERT(DATETIME, AG_DATATERMINO, 103) > @dataFim)
			THEN CAST(datediff(day, @dataIni, @dataFim) AS DECIMAL) + 1

			WHEN  (CONVERT(DATETIME, AG_DATAINICIO, 103) > @dataIni) and (CONVERT(DATETIME, AG_DATATERMINO, 103) <= @dataFim)
			THEN CAST(datediff(day, CONVERT(DATETIME, AG_DATAINICIO, 103), CONVERT(DATETIME, AG_DATATERMINO, 103)) AS DECIMAL) + 1

			WHEN  (CONVERT(DATETIME, AG_DATAINICIO, 103) > @dataIni) and (CONVERT(DATETIME, AG_DATATERMINO, 103) > @dataFim)
			THEN CAST(datediff(day, CONVERT(DATETIME, AG_DATAINICIO, 103), @dataFim) AS DECIMAL) + 1
		END
		FROM Agendamento a LEFT JOIN Tipo_Atividade ta on ta.TA_ID = a.TA_ID
		WHERE (CONVERT(DATETIME, AG_DATATERMINO, 103) BETWEEN @dataIni and @dataFim) OR 
			(CONVERT(DATETIME, AG_DATAINICIO, 103) BETWEEN @dataIni and @dataFim) OR
			((CONVERT(DATETIME, AG_DATAINICIO, 103) < @dataIni) AND (CONVERT(DATETIME, AG_DATATERMINO, 103) > @dataFim))
		--GROUP BY ta.TA_DESCRICAO, AG_DATAINICIO, AG_DATATERMINO
	IF @@ERROR <> 0
	BEGIN
		RAISERROR('Erro ao criar tabela temporária #Indicadores', 16, 1)
		RETURN -1
	END

	SET @Retorno = UPPER(@Retorno)

	IF @Retorno IS NULL OR @Retorno = 'ATIVIDADE'
	BEGIN
		SELECT	nome AS 'Atividade', CAST(CAST(SUM(dias) AS DECIMAL) / (DATEDIFF(DAY, @dataIni, @dataFim) + 1) AS DECIMAL(10,2)) AS 'Média'
		FROM #Indicadores
		GROUP BY Nome WITH CUBE
		ORDER BY 'Média' DESC;
	END

	IF @Retorno IS NULL OR @Retorno = 'RESPONSAVEL'
	BEGIN
		SELECT	Responsavel AS 'Responsável', CAST(CAST(SUM(dias) AS DECIMAL) / (DATEDIFF(DAY, @dataIni, @dataFim) + 1) AS DECIMAL(10,2)) AS 'Média'
		FROM #Indicadores
		GROUP BY Responsavel WITH CUBE
		ORDER BY 'Média' DESC;
	END

	DROP TABLE #Indicadores

	RETURN 1
END
GO

/****** Object:  StoredProcedure [dbo].[sp_Indicador_Nao_Conformidade]    Script Date: 07/19/2018 18:45:13 ******/
IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[dbo].[sp_Indicador_Nao_Conformidade]') AND OBJECTPROPERTY(id,N'IsProcedure') = 1)
	DROP PROCEDURE [dbo].[sp_Indicador_Nao_Conformidade]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[sp_Indicador_Nao_Conformidade]
(
        @datainicio as smalldatetime,
        @datafim as smalldatetime
)
AS
BEGIN
	SET NOCOUNT ON

	DECLARE @numerador FLOAT, @denominador FLOAT

	-- não conformidades
	SELECT @numerador = count(L.LB_ID)
	FROM lb_acoestomadas R INNER JOIN LB_LogBook L on L.LB_ID = R.act_lb 
	WHERE (act_tipoacao = 2) AND (LB_DATAHORAOCO BETWEEN @datainicio AND @datafim)

	-- total de ocorrencias
	SELECT @denominador = count(*)
	FROM LB_LOGBOOK
	WHERE LB_DATAHORAOCO BETWEEN @datainicio AND @datafim

	IF @denominador = 0
		SELECT @numerador AS 'numerador', @denominador AS 'denominador', 0 AS 'porcentagem'
	ELSE
		SELECT @numerador AS 'numerador', @denominador AS 'denominador', (@numerador/@denominador)*100 AS 'porcentagem'
END
GO


/****** Object:  StoredProcedure [dbo].[sp_IndiceRetornoSatisfacao]    Script Date: 07/19/2018 18:45:13 ******/
IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[dbo].[sp_IndiceRetornoSatisfacao]') AND OBJECTPROPERTY(id,N'IsProcedure') = 1)
	DROP PROCEDURE [dbo].[sp_IndiceRetornoSatisfacao]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[sp_IndiceRetornoSatisfacao]
(
	@ta_id INT,
	@tec_id INT,
	@chr_Rat VARCHAR(80),
	@chr_Rt VARCHAR(80),
	@dtt_Inicio DATETIME,
	@dtt_Final DATETIME
)
AS
BEGIN
	SET NOCOUNT ON

	CREATE TABLE #TabFinalizado (
		ag_numero INT PRIMARY KEY
	)

	DECLARE @int_Finalizado NUMERIC(15,2),
		@id_Finalizado INT,
		@int_Pesquisa NUMERIC(15,2),
		@int_IndiceRetorno NUMERIC(15,2),
		@int_ERRO INT

	SELECT @id_Finalizado = id_Situacao FROM Situacoes WHERE s_descricao = 'Finalizado' AND s_os = 0

	-- seleciona os agendamentos finalizados
	INSERT INTO #TabFinalizado
		SELECT
			ag_numero
		FROM
			vw_Agendamento A
		WHERE
			A.id_Situacao = @id_Finalizado
			AND
			(@ta_id IS NULL OR @ta_id = A.ta_id)
			AND
			(@chr_Rt IS NULL OR @chr_Rt = A.ag_responsavel)
			AND
			(@chr_Rat IS NULL OR @chr_Rat = A.ag_rat)
			AND
			(@tec_id IS NULL OR @tec_id = A.tec_id)
			AND
			(A.ag_datatermino BETWEEN @dtt_Inicio AND @dtt_Final)

	SELECT @int_Finalizado = @@ROWCOUNT, @int_ERRO = @@ERROR

	IF @int_ERRO <> 0
	BEGIN
		SELECT 1 AS ERRO, NULL AS INDICE, @int_Finalizado AS TOTALAGENDAMENTO, NULL AS TOTALPESQUISA
		RETURN 1
	END

	IF @int_Finalizado = 0
	BEGIN
		SELECT 0 AS ERRO, NULL AS INDICE, @int_Finalizado AS TOTALAGENDAMENTO, NULL AS TOTALPESQUISA
		RETURN 0
	END


	IF @dtt_Inicio IS NULL SET @dtt_Inicio = '1980-01-01 00:00'
	IF @dtt_Final IS NULL SET @dtt_Final = GETDATE()


	SELECT
		@int_Pesquisa = COUNT(DISTINCT psq_nag)
	FROM
		PesquisaSatisfacao P
	WHERE
		EXISTS (SELECT ag_numero FROM #TabFinalizado WHERE ag_numero = P.psq_nag)
		--AND
		--P.psq_datahoracadastro BETWEEN @dtt_Inicio AND @dtt_Final


	SET @int_IndiceRetorno = (@int_Pesquisa * 100) / @int_Finalizado

	DROP TABLE #TabFinalizado

	SELECT 0 AS ERRO, CAST(@int_IndiceRetorno AS VARCHAR) + '%' AS INDICE, @int_Finalizado AS TOTALAGENDAMENTO, @int_Pesquisa AS TOTALPESQUISA
	RETURN 0
END
GO


/****** Object:  StoredProcedure [dbo].[sp_LogEvento]    Script Date: 07/19/2018 18:45:13 ******/
IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[dbo].[sp_LogEvento]') AND OBJECTPROPERTY(id,N'IsProcedure') = 1)
	DROP PROCEDURE [dbo].[sp_LogEvento]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[sp_LogEvento]
(
	@USER_ID VARCHAR(80)
	,@MODULO VARCHAR(10)
	,@MSG VARCHAR(8000)
)
AS
BEGIN
	DECLARE @msg_erro VARCHAR(8000), @user_nome VARCHAR(100)

	SET NOCOUNT ON

	--LOG
	INSERT INTO SCE_Historico(ID_USUARIO, ACAO, DATA, MODULO)
		VALUES (@USER_ID, @MSG, CONVERT(VARCHAR, GETDATE(), 120), @MODULO)
	IF @@ERROR <> 0 BEGIN
		ROLLBACK TRANSACTION
		RAISERROR( 'Não foi possível inserir no histórico', 16, 1)
		RETURN -1
	END

	RETURN 0
END
GO


/****** Object:  StoredProcedure [dbo].[sp_RemarcaTeste]    Script Date: 07/19/2018 18:45:13 ******/
IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[dbo].[sp_RemarcaTeste]') AND OBJECTPROPERTY(id,N'IsProcedure') = 1)
	DROP PROCEDURE [dbo].[sp_RemarcaTeste]
GO
SET ANSI_NULLS ON
GO

CREATE  PROCEDURE [dbo].[sp_RemarcaTeste]
(
	@pAG_NUMERO INT,
	@pAG_DATAINICIO varchar(10),
	@pAG_DATATERMINO varchar(10),
	@pAG_MOTIVO varchar(7000)
)
AS
BEGIN
	/*** Solicita um agendamento para Remarcacao de datas ***/
	DECLARE @vID_SITUACAO SMALLINT, @vHD_MARCACAO SMALLINT

	BEGIN TRANSACTION

	UPDATE AGENDAMENTO SET AG_FLAGREMARCACAO = 1 WHERE AG_NUMERO = @pAG_NUMERO
	IF @@ERROR <> 0 BEGIN
		ROLLBACK TRANSACTION
		RETURN @@error
	END
 
	SELECT @vHD_MARCACAO = max(HD_MARCACAO) FROM historico_datas WHERE AG_NUMERO = @pAG_NUMERO

	IF @vHD_MARCACAO IS NULL
  		SET @vHD_MARCACAO = 1
 	ELSE
  		SET @vHD_MARCACAO = @vHD_MARCACAO + 1

	INSERT INTO Historico_datas 
		(AG_NUMERO, HD_MARCACAO, HD_DATAINICIO, HD_DATATERMINO, HD_FLAGREMARCADO, 
		HD_MOTIVO)
 		VALUES (@pAG_NUMERO, @vHD_MARCACAO, 
		convert(smalldatetime, @pAG_DATAINICIO, 103), convert(smalldatetime, @pAG_DATATERMINO, 103),
		0, 'SOLICITAÇÃO DE REMARCAÇÃO' + CHAR(13) + CHAR(10) + @pAG_MOTIVO)
	IF @@ERROR <> 0 BEGIN
  		ROLLBACK TRANSACTION
  		RETURN @@error
 	END

	SELECT @vID_SITUACAO = ID_SITUACAO FROM HISTORICO_EVENTOS
 	WHERE AG_NUMERO = @pAG_NUMERO and HE_DATATERMINO IS NULL

 	if @vID_SITUACAO = 3 BEGIN  -- agendado
 		UPDATE HISTORICO_EVENTOS 
			SET HE_DATATERMINO = getDate()
			WHERE AG_NUMERO = @pAG_NUMERO and HE_DATATERMINO IS NULL
  		IF @@ERROR <> 0 BEGIN
   			ROLLBACK TRANSACTION
   			RETURN(@@error)
  		END

  		INSERT into HISTORICO_EVENTOS(AG_NUMERO, ID_SITUACAO, HE_DATAINICIO)
  		VALUES (@pAG_NUMERO, 1, getDate())
  		IF @@ERROR <> 0 BEGIN
   			ROLLBACK TRANSACTION
   			RETURN(@@error)
  		END
 	END

 	COMMIT TRANSACTION
	RETURN 1
END
GO


/****** Object:  StoredProcedure [dbo].[SP_TAREFAS_POR_PERIODO]    Script Date: 07/19/2018 18:45:13 ******/
IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[dbo].[SP_TAREFAS_POR_PERIODO]') AND OBJECTPROPERTY(id,N'IsProcedure') = 1)
	DROP PROCEDURE [dbo].[SP_TAREFAS_POR_PERIODO]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[sp_Tarefas_Por_Periodo]
(
	@data  VARCHAR(10),
	@username VARCHAR(80)
)
AS
BEGIN
	SELECT TP.TP_ID, TP.TAREFA_ID, A.AG_NUMERO AS ORDEM, 'Nº AS:'+CAST(A.AG_NUMERO AS VARCHAR) AS TIPO, CAST(A.AG_OBJETIVO AS VARCHAR(8000)) AS DESCRICAO_TAREFA,
		CONVERT(SMALLDATETIME, CAST(DAY(TP.TP_DATAINICIAL) AS VARCHAR)+'/'+CAST(MONTH(TP.TP_DATAINICIAL) AS VARCHAR)+'/'+CAST(YEAR(TP.TP_DATAINICIAL) AS VARCHAR), 103) AS TP_DATAINICIAL,
		CONVERT(SMALLDATETIME, CAST(DAY(TP.TP_DATAFINAL) AS VARCHAR)+'/'+CAST(MONTH(TP.TP_DATAFINAL) AS VARCHAR)+'/'+CAST(YEAR(TP.TP_DATAFINAL) AS VARCHAR), 103) AS TP_DATAFINAL,
		TP.PES_USERNAME, TP.TP_OBSERVACAO, TP.TAREFA_TIPO
	FROM TAREFAS_PREVISTAS AS TP
	LEFT JOIN AGENDAMENTO AS A ON A.AG_NUMERO = TP.TAREFA_ID
	WHERE TP_DATAINICIAL <= DATEADD(DD, 13, CONVERT(DATETIME, @data, 103))
	AND TP_DATAFINAL >= CONVERT(DATETIME, @data, 103)
	AND TP.PES_USERNAME = @username
	AND TAREFA_TIPO = 0
	UNION
	SELECT TP.TP_ID, TP.TAREFA_ID, 999999 AS ORDEM,  'TAR' AS TIPO, T.TAR_DESCRICAO AS DESCRICAO_TAREFA,
		CONVERT(SMALLDATETIME, CAST(DAY(TP.TP_DATAINICIAL) AS VARCHAR)+'/'+CAST(MONTH(TP.TP_DATAINICIAL) AS VARCHAR)+'/'+CAST(YEAR(TP.TP_DATAINICIAL) AS VARCHAR), 103) AS TP_DATAINICIAL,
		CONVERT(SMALLDATETIME, CAST(DAY(TP.TP_DATAFINAL) AS VARCHAR)+'/'+CAST(MONTH(TP.TP_DATAFINAL) AS VARCHAR)+'/'+CAST(YEAR(TP.TP_DATAFINAL) AS VARCHAR), 103) AS TP_DATAFINAL,
		TP.PES_USERNAME, TP.TP_OBSERVACAO, TP.TAREFA_TIPO
	FROM TAREFAS_PREVISTAS AS TP
	LEFT JOIN TAREFAS AS T ON T.TAR_ID = TP.TAREFA_ID
	WHERE TP_DATAINICIAL <= DATEADD(DD, 13, CONVERT(DATETIME, @data, 103))
	AND TP_DATAFINAL >= CONVERT(DATETIME, @data, 103)
	AND TP.PES_USERNAME = @username
	AND TAREFA_TIPO = 1
	ORDER BY ORDEM, TP_DATAINICIAL
END
GO


/****** Object:  StoredProcedure [dbo].[sp_ValidaCancelamento]    Script Date: 07/19/2018 18:45:13 ******/
IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[dbo].[sp_ValidaCancelamento]') AND OBJECTPROPERTY(id,N'IsProcedure') = 1)
	DROP PROCEDURE [dbo].[sp_ValidaCancelamento]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE  PROCEDURE [dbo].[sp_ValidaCancelamento]
(
	@pAG_NUMERO INT,
	@pRESPONSAVEL VARCHAR(80),
	@pCANCELAMENTOACEITOPELORAT BIT
)
AS
BEGIN
	DECLARE	@Data SMALLDATETIME, 
		@Motivo VARCHAR(8000), 
		@os_id INT,
		@hd_marcacao INT

	SET NOCOUNT ON

	SET @Data = GETDATE()

	/*** Valida e cancela um agendamento */

	BEGIN TRANSACTION

	SELECT
		@Motivo = HD_MOTIVO, @hd_marcacao = HD_MARCACAO
	FROM
		Historico_Datas 
	WHERE
		AG_NUMERO = @pAG_NUMERO 
		AND HD_MARCACAO = (SELECT MAX(HD_MARCACAO) FROM Historico_Datas WHERE AG_NUMERO = @pAG_NUMERO)


	-- Indica se o RAT fez o cancelamento do pedido do usuário p/ que o agendamento
	-- fosse cancelado
	IF @pCANCELAMENTOACEITOPELORAT = 0
	BEGIN
		UPDATE Historico_Datas
		SET 
			HD_MOTIVO = 'SOLICITAÇÃO CANCELADA PELO RAT.' + CHAR(13) + CHAR(10) + @Motivo,
			HD_FLAGREMARCADO = @pCANCELAMENTOACEITOPELORAT
		WHERE AG_NUMERO = @pAG_NUMERO AND HD_MARCACAO = @hd_marcacao

		IF @@ERROR <> 0 BEGIN
			ROLLBACK TRANSACTION
			RAISERROR('Não foi possível atualizar o histórico de datas', 16, 1)
			RETURN (@@error)
		END
	END
	ELSE BEGIN

		UPDATE Historico_Datas
		SET 
			HD_FLAGREMARCADO = @pCANCELAMENTOACEITOPELORAT
		WHERE AG_NUMERO = @pAG_NUMERO AND HD_MARCACAO = @hd_marcacao

		IF @@ERROR <> 0 BEGIN
			ROLLBACK TRANSACTION
			RAISERROR('Não foi possível atualizar o histórico de datas', 16, 1)
			RETURN (@@error)
		END


		-- gravo a data no registro em aberto
		UPDATE HISTORICO_EVENTOS 
			SET HE_DATATERMINO = @Data
			WHERE AG_NUMERO = @pAG_NUMERO and HE_DATATERMINO IS NULL
		IF @@ERROR <> 0 BEGIN
			ROLLBACK TRANSACTION
			RAISERROR('Não foi possível atualizar o histórico de eventos', 16, 1)
			RETURN (@@error)
		END

		-- crio um novo evento para a situacao de cancelado
		INSERT INTO HISTORICO_EVENTOS
			(HE_RESPONSAVEL, ID_SITUACAO, AG_NUMERO, HE_DATAINICIO, HE_DATATERMINO, HE_MOTIVO)
		VALUES (@pRESPONSAVEL, 5, @pAG_NUMERO, @Data, @Data, 'CANCELADO PELO USUÁRIO')
		IF @@ERROR <> 0 BEGIN
			ROLLBACK TRANSACTION
			RAISERROR('Não foi possível inserir no histórico de eventos', 16, 1)
			RETURN (@@error)
		END


		-- cancelo as ordens de servico do agendamento que ainda nao estao em estado final
		DECLARE OS_Cursor CURSOR FOR 
			SELECT DISTINCT OS_ID FROM HISTORICO_EVENTOSOS
			WHERE AG_NUMERO = @pAG_NUMERO AND HEOS_DATATERMINO IS NULL

		OPEN OS_Cursor

		FETCH NEXT FROM OS_Cursor INTO @os_id

		WHILE @@FETCH_STATUS = 0
		BEGIN
			-- gravo a data no registro em aberto
			UPDATE HISTORICO_EVENTOSOS
				SET HEOS_DATATERMINO = @Data
				WHERE AG_NUMERO = @pAG_NUMERO and OS_ID = @os_id AND HEOS_DATATERMINO IS NULL
			IF @@ERROR <> 0 BEGIN
				ROLLBACK TRANSACTION
				RAISERROR('Não foi possível atualizar o histórico de eventos da OS', 16, 1)
				RETURN (@@error)
			END

			-- crio um novo evento para a situacao de OS cancelada
			INSERT INTO HISTORICO_EVENTOSOS (HEOS_RESPONSAVEL, AG_NUMERO, ID_SITUACAO, OS_ID, HEOS_DATAINICIO, HEOS_DATATERMINO, HEOS_MOTIVO)
			VALUES (@pRESPONSAVEL, @pAG_NUMERO, 14, @os_id, @Data, @Data, 'CANCELADO PELO USUÁRIO')
			IF @@ERROR <> 0 BEGIN
				ROLLBACK TRANSACTION
				RAISERROR('Não foi possível inserir o histórico de eventos da OS', 16, 1)
				RETURN (@@error)
			END

			FETCH NEXT FROM OS_Cursor INTO @os_id
		END

		CLOSE OS_Cursor
		DEALLOCATE OS_Cursor
	END

	-- desmarco o flag do agendamento para solicitacao de cancelamento
	UPDATE Agendamento SET AG_SOLICITOUCANCELAMENTO = 0 WHERE AG_NUMERO = @pAG_NUMERO
	IF @@ERROR <> 0 BEGIN
		ROLLBACK TRANSACTION
		RAISERROR('Não foi possível atualizar o agendamento', 16, 1)
		RETURN (@@error)
	END

	COMMIT TRANSACTION
 	RETURN 1
END
GO


/****** Object:  StoredProcedure [dbo].[sp_ValidaRemarcacao]    Script Date: 07/19/2018 18:45:13 ******/
IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[dbo].[sp_ValidaRemarcacao]') AND OBJECTPROPERTY(id,N'IsProcedure') = 1)
	DROP PROCEDURE [dbo].[sp_ValidaRemarcacao]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE  PROCEDURE [dbo].[sp_ValidaRemarcacao]
(
	@pAG_NUMERO INT,
	@pAG_FLAGREMARCADO BIT
)
AS
BEGIN
	/*** Remarco um agendamento selecionado ***/
	declare @vAG_DATAINICIO smalldatetime, @vAG_DATATERMINO smalldatetime
	declare @vHD_DATAINICIO smalldatetime, @vHD_DATATERMINO smalldatetime
	declare @vHD_MARCACAO INT
	declare @vPRIMEIRAMARCACAO BIT

	SET NOCOUNT ON

	BEGIN TRANSACTION

	select @vPRIMEIRAMARCACAO = count(*) from historico_datas
 	where AG_NUMERO = @pAG_NUMERO and HD_MARCACAO = 0

	select @vHD_MARCACAO = max(HD_MARCACAO) from historico_datas
 	where AG_NUMERO = @pAG_NUMERO

	if (@vPRIMEIRAMARCACAO = 0) and (@pAG_FLAGREMARCADO=1)begin
		select @vAG_DATAINICIO = AG_DATAINICIO, @vAG_DATATERMINO = AG_DATATERMINO
		from agendamento
	 	where AG_NUMERO = @pAG_NUMERO

		insert into historico_datas(AG_NUMERO, HD_MARCACAO, HD_DATAINICIO, HD_DATATERMINO, HD_FLAGREMARCADO, HD_MOTIVO)
 		values(@pAG_NUMERO, 0, @vAG_DATAINICIO, @vAG_DATATERMINO, 0, 'Primeira Marcação (datas originais do agendamento)')

		if @@error <> 0 begin
   			rollback transaction
   			return(@@error)
  		end
	end

	if (@pAG_FLAGREMARCADO=1) begin  -- remarca o agendamento
		select @vHD_DATAINICIO = HD_DATAINICIO, 
        	       @vHD_DATATERMINO = HD_DATATERMINO
  		from historico_datas
  		where AG_NUMERO = @pAG_NUMERO and HD_MARCACAO = @vHD_MARCACAO

	  	UPDATE AGENDAMENTO
	  		SET  AG_DATAINICIO = @vHD_DATAINICIO,
		  		AG_DATATERMINO = @vHD_DATATERMINO,
  				AG_FLAGREMARCACAO = 0
	  		where AG_NUMERO = @pAG_NUMERO
	  	if @@error <> 0 begin
   			rollback transaction
   			return(@@error)
  		end
 	end
	else begin  -- volta o agendamento como não remarcado
		UPDATE AGENDAMENTO
  		SET  AG_FLAGREMARCACAO = 0
  		where AG_NUMERO = @pAG_NUMERO
  		if @@error <> 0 begin
   			rollback transaction
   			return(@@error)
  		end
 	end

	-- indica se foi aceito ou nao a remarcação
  	UPDATE historico_datas
		SET HD_FLAGREMARCADO = @pAG_FLAGREMARCADO
		where AG_NUMERO = @pAG_NUMERO and HD_MARCACAO = @vHD_MARCACAO
  	if @@error <> 0 begin
		rollback transaction
		return(@@error)
	end

	COMMIT TRANSACTION
END
GO


/****** Object:  StoredProcedure [dbo].[sp_SCE_CADASTRA_ACEITE_RESERVA]    Script Date: 07/19/2018 18:45:13 ******/
IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[dbo].[sp_SCE_CADASTRA_ACEITE_RESERVA]') AND OBJECTPROPERTY(id,N'IsProcedure') = 1)
	DROP PROCEDURE [dbo].[sp_SCE_CADASTRA_ACEITE_RESERVA]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[sp_SCE_CADASTRA_ACEITE_RESERVA]
(
	@lista_itens VARCHAR(8000),
	@ag_numero INT,
	@user_id VARCHAR(80)
)
AS
/*** Cadastra uma nova movimentacao ***/
BEGIN
	DECLARE @msg_erro VARCHAR(8000), @mensagem VARCHAR(8000), @eq_codigobarras VARCHAR(20)

	SET NOCOUNT ON

	BEGIN TRANSACTION

	-- loop para inserir itens movimentados
	IF @lista_itens IS NOT NULL  BEGIN

		-- a lista de campos está definida da seguinte forma: ","
		DECLARE @separa_campo VARCHAR(1)
		SET @separa_campo = ','
	
		DECLARE @reg VARCHAR(8000), @fim BIT, @iini INT, @ifim INT
		DECLARE @aceite VARCHAR(1), @eq_id VARCHAR(10)

		SET @lista_itens = RTRIM( LTRIM( @lista_itens ) )
		SET @fim = 0
		SET @iini = 1
		WHILE ( @fim = 0 ) BEGIN
			SET @ifim = PATINDEX('%' + @separa_campo + '%', @lista_itens )
			IF @ifim = 0 
				SET @reg = SUBSTRING( @lista_itens, @iini, LEN( @lista_itens ) )
			ELSE
				SET @reg = SUBSTRING( @lista_itens, @iini, @ifim - 1 )

			SET @reg = LTRIM( RTRIM( @reg ) )

			SET @aceite = LEFT( @reg, 1 )

			IF  @aceite <> '1' AND @aceite <> '0'
				SET @aceite = NULL

			SET @eq_id = SUBSTRING( @reg, 3, LEN( @reg ) )

			UPDATE SCE_Reserva_Equipamentos SET REQ_ACEITO = @aceite
				WHERE AG_NUMERO = @ag_numero AND EQ_ID = @eq_id

			IF @@ERROR <> 0 BEGIN
				ROLLBACK TRANSACTION
				SET @msg_erro = 'Não foi possível aceitar os itens da reserva do agendamento ' + CAST(@ag_numero AS VARCHAR) + '.' 
				RAISERROR( @msg_erro , 16, 1)
				RETURN -1
			END

			-- pega o nome do usuario e o codigo de barras
			SELECT @eq_codigobarras = EQ_CODIGOBARRAS FROM SCE_Equipamentos WHERE EQ_ID = @eq_id

			SET @mensagem = 'O usuário ' + @user_id + ' aceitou a reserva do equipamento ' + @eq_codigobarras + ' para o agendamento ' + CAST(@ag_numero AS VARCHAR)
			EXEC sp_LogEvento @user_id, 'SCE', @mensagem
	
			IF @@ERROR <> 0 BEGIN
				ROLLBACK TRANSACTION
				RAISERROR( 'Não foi possível inserir no histórico', 16, 1)
				RETURN -1
			END

			SET @lista_itens = LTRIM(SUBSTRING( @lista_itens, @ifim + 1, LEN( @lista_itens ) ))
			IF @ifim = 0 SET @fim = 1
		END
	END

	COMMIT TRANSACTION
	RETURN 1
END
GO


/****** Object:  StoredProcedure [dbo].[sp_SCE_CADASTRA_EQUIPAMENTO]    Script Date: 07/19/2018 18:45:13 ******/
IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[dbo].[sp_SCE_CADASTRA_EQUIPAMENTO]') AND OBJECTPROPERTY(id,N'IsProcedure') = 1)
	DROP PROCEDURE [dbo].[sp_SCE_CADASTRA_EQUIPAMENTO]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE  PROCEDURE [dbo].[sp_SCE_CADASTRA_EQUIPAMENTO]
(
	@eq_id INT OUTPUT,
	@eq_codigobarras VARCHAR(20),
	@eq_codigobarrasanterior VARCHAR(20),
	@eq_numeroserie VARCHAR(255),
	@eq_localizacao VARCHAR(255),
	@mod_id INT,
	@eq_obs TEXT,
	@status INT,
	@eq_oper_delta VARCHAR(50),
	@eq_oper_umidade VARCHAR(50),
	@eq_oper_warmup VARCHAR(50),
	@eq_arma_delta VARCHAR(50),
	@eq_arma_umidade VARCHAR(50),
	@eq_manut_preventiva TEXT,
	@eq_instrumental BIT,
	@eq_propriedade CHAR(1),
	@eq_conforme BIT,
	@eq_lista_acessorios VARCHAR(8000),
	@eq_lista_controle VARCHAR(8000),
	@eq_freq_calibracao INT
)
AS
/*** Cadastra um novo equipamento ***/
BEGIN
	DECLARE @conta_codbarras INT
	DECLARE @conta_numeroserie INT
	DECLARE @msg_erro VARCHAR(8000)

	SET NOCOUNT ON

	-- verifico se ja existe algum equipamento com este código de barras
	-- OBS:	como existem códigos errados na base, não é possível criar um indice único na tabela, portanto
	--	tenho que criticar via código
	SET @conta_codbarras = 0
	SET @conta_numeroserie = 0

	-- insert
	IF @eq_id IS NULL
	BEGIN
		select @conta_codbarras = count(EQ_CODIGOBARRAS) from SCE_Equipamentos
			where EQ_CODIGOBARRAS = LTRIM(RTRIM(@eq_codigobarras))

		select @conta_numeroserie = count(EQ_NUMEROSERIE) from SCE_Equipamentos
			where EQ_NUMEROSERIE = LTRIM(RTRIM(@eq_numeroserie))
	END
	ELSE
	BEGIN
		select @conta_codbarras = count(EQ_CODIGOBARRAS) from SCE_Equipamentos
			where EQ_CODIGOBARRAS = LTRIM(RTRIM(@eq_codigobarras)) AND EQ_ID <> @eq_id

		select @conta_numeroserie = count(EQ_NUMEROSERIE) from SCE_Equipamentos
			where EQ_NUMEROSERIE = LTRIM(RTRIM(@eq_numeroserie)) AND EQ_ID <> @eq_id
	END

	IF @conta_codbarras > 0
	BEGIN
		SET @msg_erro = 'Este código de barras (' + @eq_codigobarras + ') já está cadastrado para um equipamento'
		RAISERROR( @msg_erro, 16, 1)
		RETURN -1
	END

	IF @conta_numeroserie > 0
	BEGIN
		SET @msg_erro = 'Este número de série (' + @eq_numeroserie + ') já está cadastrado para um equipamento'
		RAISERROR( @msg_erro, 16, 1)
		RETURN -1
	END

	BEGIN TRANSACTION

	-- insere equipamento
	IF @eq_id IS NULL BEGIN
		INSERT INTO SCE_Equipamentos (EQ_CODIGOBARRAS, EQ_CODIGOBARRASANTERIOR, EQ_NUMEROSERIE, EQ_LOCALIZACAO,
				MOD_ID, EQ_OBS, STATUS,
				EQ_OPER_DELTA, EQ_OPER_UMIDADE, EQ_OPER_WARMUP, EQ_ARMA_DELTA, EQ_ARMA_UMIDADE,
				EQ_MANUT_PREVENTIVA, EQ_INSTRUMENTAL, EQ_PROPRIEDADE, EQ_CONFORME, EQ_FREQ_CALIBRACAO)
			VALUES (@eq_codigobarras, @eq_codigobarrasanterior, @eq_numeroserie, @eq_localizacao, @mod_id, @eq_obs, @status,
				@eq_oper_delta, @eq_oper_umidade, @eq_oper_warmup, @eq_arma_delta, @eq_arma_umidade,
				@eq_manut_preventiva, @eq_instrumental, @eq_propriedade, @eq_conforme, @eq_freq_calibracao)
		IF @@error <> 0
		BEGIN
			ROLLBACK TRANSACTION
			RAISERROR( 'Não foi possível cadastrar este equipamento', 16, 1)
			RETURN -1
		END

		SET @eq_id = @@identity
	END
	-- altera equipamento
	ELSE BEGIN

		UPDATE SCE_Equipamentos SET EQ_CODIGOBARRAS = @eq_codigobarras, 
				EQ_CODIGOBARRASANTERIOR = @eq_codigobarrasanterior, EQ_NUMEROSERIE = @eq_numeroserie,
				EQ_LOCALIZACAO = @eq_localizacao,
				MOD_ID = @mod_id, EQ_OBS = @eq_obs, STATUS = @status, EQ_OPER_DELTA = @eq_oper_delta, EQ_OPER_UMIDADE = @eq_oper_umidade,
				EQ_OPER_WARMUP = @eq_oper_warmup, EQ_ARMA_DELTA = @eq_arma_delta, EQ_ARMA_UMIDADE = @eq_arma_umidade,
				EQ_MANUT_PREVENTIVA = @eq_manut_preventiva, EQ_INSTRUMENTAL = @eq_instrumental, EQ_PROPRIEDADE = @eq_propriedade,
				EQ_CONFORME = @eq_conforme, EQ_FREQ_CALIBRACAO = @eq_freq_calibracao
			WHERE EQ_ID = @eq_id

		IF @@error <> 0
		BEGIN
			ROLLBACK TRANSACTION
			RAISERROR( 'Não foi possível alterar este equipamento', 16, 1)
			RETURN -1
		END
	END

	-- acessorios
	DELETE FROM SCE_Acessorios WHERE EQ_ID = @eq_id
	IF @@error <> 0
	BEGIN
		ROLLBACK TRANSACTION
		RAISERROR( 'Não foi possível excluir os acessórios do equipamento', 16, 1)
		RETURN -1
	END

	-- a lista de campos está definida da seguinte forma: "»!«" separador de registro e "¿!¿" como separador de campo (ALT + 175 / 174 e ALT 168 respectivamente)
	DECLARE @separa_registro VARCHAR(3), @separa_campo VARCHAR(3)
	SET @separa_registro = '»?«'
	SET @separa_campo = '¿?¿'

	DECLARE @reg VARCHAR(8000), @fim BIT, @iini INT, @ifim INT

	-- loop para inserir acessorios
	IF @eq_lista_acessorios IS NOT NULL BEGIN
		DECLARE @d VARCHAR(255), @s VARCHAR(255), @stat VARCHAR(255)

		SET @eq_lista_acessorios = rtrim(ltrim(@eq_lista_acessorios))
		SET @fim = 0
		SET @iini = 1
		WHILE ( @fim = 0 ) BEGIN
			SET @ifim = PATINDEX('%' + @separa_registro + '%', @eq_lista_acessorios )
			IF @ifim = 0 
				SET @reg = SUBSTRING( @eq_lista_acessorios, @iini, LEN( @eq_lista_acessorios ) )
			ELSE
				SET @reg = SUBSTRING( @eq_lista_acessorios, @iini, @ifim - 1 )

			-- retira os 3 campos da string de registro
			SET @s = SUBSTRING( @reg, 1, PATINDEX( '%' + @separa_campo + '%', @reg ) -1 )    -- sequencial
			SET @reg = SUBSTRING( @reg, PATINDEX( '%' + @separa_campo + '%', @reg )+3, LEN( @reg ) )
			SET @d = LTRIM( RTRIM ( SUBSTRING( @reg, 1, PATINDEX( '%' + @separa_campo + '%', @reg ) -1 ) ) )    -- descricao
			SET @reg = SUBSTRING( @reg, PATINDEX( '%' + @separa_campo + '%', @reg )+3, LEN( @reg ) )
			SET @stat = SUBSTRING( @reg, 1, PATINDEX( '%' + @separa_campo + '%', @reg ) -1 )    -- status
			SET @reg = SUBSTRING( @reg, PATINDEX( '%' + @separa_campo + '%', @reg )+3, LEN( @reg ) )  -- conforme

			INSERT INTO SCE_Acessorios ( SEQUENCIAL, DESCRICAO, STATUS, CONFORME, EQ_ID ) VALUES ( @s ,@d, @stat, @reg, @eq_id )
			IF @@ERROR <> 0 BEGIN
				ROLLBACK TRANSACTION
				RAISERROR( 'Não foi possível atualizar os acessórios do equipamento', 16, 1)
				RETURN -1
			END

			SET @eq_lista_acessorios = LTRIM(SUBSTRING( @eq_lista_acessorios, @ifim + 3, LEN(@eq_lista_acessorios) ))
			IF @ifim = 0 SET @fim = 1
		END
	END

	-- controle
	DELETE FROM SCE_Equipamentos_Controle WHERE EQ_ID = @eq_id
	IF @@error <> 0
	BEGIN
		ROLLBACK TRANSACTION
		RAISERROR( 'Não foi possível excluir os controles de calibração/manutenção/qualificação do equipamento', 16, 1)
		RETURN -1
	END

	-- loop para inserir controles
	IF @eq_lista_controle IS NOT NULL BEGIN
		DECLARE @id_controle VARCHAR(255), @controle CHAR(1), @dias VARCHAR(255)
		DECLARE @data_controle VARCHAR(255), @registro VARCHAR(255)

		SET @eq_lista_controle = rtrim(ltrim( @eq_lista_controle ))
		SET @fim = 0
		SET @iini = 1
		WHILE ( @fim = 0 ) BEGIN
			SET @ifim = PATINDEX('%' + @separa_registro + '%', @eq_lista_controle )
			IF @ifim = 0 
				SET @reg = SUBSTRING( @eq_lista_controle, @iini, LEN( @eq_lista_controle ) )
			ELSE
				SET @reg = SUBSTRING( @eq_lista_controle, @iini, @ifim - 1 )

			-- retira os 5 campos da string de registro
			SET @id_controle = SUBSTRING( @reg, 1, PATINDEX( '%' + @separa_campo + '%', @reg ) -1 )  -- ID do controle
			SET @reg = SUBSTRING( @reg, PATINDEX( '%' + @separa_campo + '%', @reg )+3, LEN( @reg ) )
			SET @controle = SUBSTRING( @reg, 1, PATINDEX( '%' + @separa_campo + '%', @reg ) -1 )  -- Tipo do controle (C / M / Q)
			SET @reg = SUBSTRING( @reg, PATINDEX( '%' + @separa_campo + '%', @reg )+3, LEN( @reg ) )
			SET @dias = LTRIM( RTRIM ( SUBSTRING( @reg, 1, PATINDEX( '%' + @separa_campo + '%', @reg ) -1 ) ) )
			SET @reg = SUBSTRING( @reg, PATINDEX( '%' + @separa_campo + '%', @reg )+3, LEN( @reg ) )
			SET @data_controle = SUBSTRING( @reg, 1, PATINDEX( '%' + @separa_campo + '%', @reg ) -1 )
			SET @reg = SUBSTRING( @reg, PATINDEX( '%' + @separa_campo + '%', @reg )+3, LEN( @reg ) )
			SET @registro = SUBSTRING( @reg, 1, PATINDEX( '%' + @separa_campo + '%', @reg ) -1 )
			SET @reg = SUBSTRING( @reg, PATINDEX( '%' + @separa_campo + '%', @reg )+3, LEN( @reg ) )

			IF @dias = '' OR @dias = ' '
				SET @dias = NULL

			INSERT INTO SCE_Equipamentos_Controle ( EQ_ID, EQC_DIAS, EQC_DATA, EQC_REGISTRO, EQC_RESPONSAVEL, EQC_TIPO ) 
				VALUES ( @eq_id, @dias, CONVERT(DATETIME, @data_controle, 103), @registro, @reg, @controle )
			IF @@ERROR <> 0 BEGIN
				ROLLBACK TRANSACTION
				RAISERROR( 'Não foi possível atualizar os dados de controle (calibração/manutenção/qualificação) do equipamento', 16, 1)
				RETURN -1
			END

			SET @eq_lista_controle = LTRIM(SUBSTRING( @eq_lista_controle, @ifim + 3, LEN( @eq_lista_controle ) ))
			IF @ifim = 0 SET @fim = 1
		END
	END

	COMMIT TRANSACTION
	RETURN @EQ_ID
END
GO


/****** Object:  StoredProcedure [dbo].[sp_SCE_CADASTRA_MOVIMENTACAO]    Script Date: 07/19/2018 18:45:13 ******/
IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[dbo].[sp_SCE_CADASTRA_MOVIMENTACAO]') AND OBJECTPROPERTY(id,N'IsProcedure') = 1)
	DROP PROCEDURE [dbo].[sp_SCE_CADASTRA_MOVIMENTACAO]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE  PROCEDURE [dbo].[sp_SCE_CADASTRA_MOVIMENTACAO]
(
	@mov_id INT,
	@eq_id INT,
	@mov_data DATETIME,
	@no_id INT,
	@mov_despachante VARCHAR(80),
	@mov_solicitante VARCHAR(80),
	@tipo INT,	-- OBS 1
	@cde VARCHAR(50),
	@ag_numero INT,
	@reserva INT,
	@nf_id INT,
	@doc_id INT,
	@mov_passagem BIT,
	@eq_localizacao VARCHAR(255),
	@fl_calibracao TINYINT = NULL,
	@eq_codigobarrasanterior VARCHAR(20) = NULL,
	@usuario_log VARCHAR(80)
)
AS
	/*** Cadastra uma nova movimentacao ***/

	-- OBS 1: Guardo o campo Tipo de NO para manter a compatibilidade com alguma
	--        tela do sistema que possa utilizar esta informacao vinda da tabela
	--        de movimentacao. O correto é pegar o valor da tabela SCE_Natureza_Operacao
	--        já que a tabela de movimento já possui uma FK para a tabela mencionada.
BEGIN
	DECLARE @msg_erro VARCHAR(8000), @eq_codigobarras VARCHAR(20)
	DECLARE @no_tipo INT, @ultima_mov DATETIME, @novo BIT

	SET NOCOUNT ON
	SET @novo = 0

	SELECT @no_tipo = NO_TIPO FROM SCE_Natureza_Operacao WHERE NO_ID = @no_id
	IF @@ROWCOUNT = 0 BEGIN
		RAISERROR( 'O tipo da natureza de operação não existe.', 16, 1)
		RETURN -1
	END

	IF @mov_data IS NULL SET @mov_data = GETDATE() 

	-- pega o nome do usuario e o codigo de barras
	SELECT @eq_codigobarras = EQ_CODIGOBARRAS FROM SCE_Equipamentos WHERE EQ_ID = @eq_id

	-- verifica se é inclusao de uma movimentacao ou alteracao
	IF @mov_id IS NULL BEGIN
		SET @novo = 1

		INSERT INTO SCE_Movimentacao( EQ_ID, NO_ID, MOV_DESPACHANTE, MOV_SOLICITANTE, TIPO, 
 				CDE, ASA, RESERVA, NF_ID, DOC_ID, MOV_DATA, MOV_PASSAGEM, FL_CALIBRACAO)
		VALUES ( @eq_id, @no_id, @mov_despachante, UPPER( @mov_solicitante ), @no_tipo, @cde,
				@ag_numero, @reserva, @nf_id, @doc_id, @mov_data, @mov_passagem, @fl_calibracao)
		IF @@ERROR <> 0 BEGIN
			RAISERROR( 'Não foi possível inserir esta movimentação', 16, 1)
			RETURN -1
		END
	END
	ELSE BEGIN
		UPDATE	SCE_Movimentacao
		SET		EQ_ID = @eq_id, NO_ID = @no_id, 
				MOV_DESPACHANTE = @mov_despachante, MOV_SOLICITANTE = UPPER( @mov_solicitante ), 
				TIPO = @no_tipo, CDE = @cde, ASA = @ag_numero, NF_ID = @nf_id, 
				DOC_ID = @doc_id, MOV_DATA = @mov_data, FL_CALIBRACAO = @fl_calibracao
		WHERE MOV_ID = @mov_id

		IF @@ERROR <> 0 BEGIN
			RAISERROR( 'Não foi possível alterar esta movimentação', 16, 1)
			RETURN -1
		END
	END

	-- Atualizo automaticamente a localizacao do equipamento
	IF (@eq_localizacao IS NOT NULL) OR (@eq_localizacao <> '')
	BEGIN
		UPDATE	SCE_Equipamentos
		SET		eq_localizacao = @eq_localizacao
		WHERE	eq_id = @eq_id

		IF @@ERROR <> 0 BEGIN
			RAISERROR( 'Não foi possível atualizar localização do equipamento', 16, 1)
			RETURN -1
		END
	END

	-- pego a data da ultima movimentacao do item
	SELECT	@ultima_mov = MAX(m.MOV_DATA)
	FROM	SCE_Movimentacao m 
	WHERE	m.EQ_ID = @eq_id AND (m.MOV_ID <> @mov_id OR @mov_id IS NULL)

	-- se for a ultima movimentacao e for de expedicao, entao atualizo os acessorios do item
	IF (@mov_data > @ultima_mov) OR (@ultima_mov IS NULL)
	BEGIN

		-- movimentacao de expedicao ou expedição c/ substituição, atualizo os acessorios do equipamento
		IF @no_tipo = 3 OR @no_tipo = 5
		BEGIN
			-- Atualiza o status dos acessórios
			UPDATE SCE_Acessorios SET STATUS = 3 WHERE EQ_ID = @eq_id
			IF @@ERROR <> 0 BEGIN
				SET @msg_erro = 'Não foi possível alterar o status do acessório do equipamento movimentado (' + @eq_codigobarras + ').'
				RAISERROR( @msg_erro , 16, 1)
				RETURN -1
			END

			-- Atualiza o status do item para o novo tipo
			UPDATE	SCE_Equipamentos 
			SET		STATUS = @no_tipo, EQ_CODIGOBARRASANTERIOR = @eq_codigobarrasanterior
			WHERE	EQ_ID = @eq_id
			IF @@ERROR <> 0 BEGIN
				SET @msg_erro = 'Não foi possível alterar o equipamento movimentado (' + @eq_codigobarras + ').'
				RAISERROR( @msg_erro , 16, 1)
				RETURN -1
			END
		END
	END

	-- Atualizo a reserva de equipamento
	IF @reserva = 1 BEGIN
		UPDATE	SCE_Reserva_Equipamentos
		SET		REQ_MOVIMENTOU = 1
		WHERE	AG_NUMERO = @ag_numero AND EQ_ID = @eq_id

		IF @@ERROR <> 0 BEGIN
			ROLLBACK TRANSACTION
			RAISERROR( 'Não foi possível alterar reserva do equipamento', 16, 1)
			RETURN -1
		END
	END

	IF @novo = 1
		SET @msg_erro = 'O usuário ' + @usuario_log + ' movimentou o equipamento ' + @eq_codigobarras + '.'
	ELSE 
		SET @msg_erro = 'O usuário ' + @usuario_log + ' alterou movimento #' + CAST(@mov_id AS VARCHAR) + ' do equipamento ' + @eq_codigobarras + '.'

	EXEC sp_LogEvento @usuario_log, 'SCE', @msg_erro

	IF @@ERROR <> 0 BEGIN
		RAISERROR( 'Não foi possível inserir no histórico', 16, 1)
		RETURN -1
	END

	RETURN 1
END
GO


/****** Object:  StoredProcedure [dbo].[sp_SCE_CADASTRA_NOTAFISCAL]    Script Date: 07/19/2018 18:45:13 ******/
IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[dbo].[sp_SCE_CADASTRA_NOTAFISCAL]') AND OBJECTPROPERTY(id,N'IsProcedure') = 1)
	DROP PROCEDURE [dbo].[sp_SCE_CADASTRA_NOTAFISCAL]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[sp_SCE_CADASTRA_NOTAFISCAL]
(
	@nf_id INT OUTPUT,
	@nf_numeronota INT,
	@nf_qtdevolumes INT,
	@nf_valortotal DECIMAL(15,2),
	@nf_dataemissao DATETIME,
	@nf_nconhecimento VARCHAR(10),
	@nf_tipo INT,
	@trans_id INT,
	@enf_id INT,
	@nf_descriminacao TEXT,
	@nf_aceite INT,
	@nf_integridade INT,
	@nf_carta VARCHAR(1),
	@nf_volume INT,
	@nf_devolucaocompleta BIT,
	@nf_cfop VARCHAR(20),
	@no_id INT,
	@nf_id_pai INT,
	@nf_validade VARCHAR(50),
	@nf_data DATETIME,
	@nf_recebimento DATETIME,
	@user_id VARCHAR(80)
)
AS
/*** Cadastra uma nova nota fiscal ***/

BEGIN
	DECLARE @msg_erro VARCHAR(8000), @user_nome VARCHAR(100)

	SET NOCOUNT ON

	BEGIN TRANSACTION

	IF @nf_id IS NULL BEGIN
		SELECT NF_ID FROM SCE_Nota_Fiscal WHERE ENF_ID = @enf_id AND NF_NUMERONOTA = @nf_numeronota
		IF @@ROWCOUNT > 0 BEGIN
			ROLLBACK TRANSACTION
			SET @msg_erro = 'Nota ' + CAST(@nf_numeronota AS VARCHAR) + ' já existente para este Fornecedor'
			RAISERROR( @msg_erro, 16, 1)
			RETURN -1
		END

		--insere--
		INSERT INTO SCE_Nota_Fiscal (NF_NUMERONOTA, NF_QTDEVOLUMES, NF_VALORTOTAL,
			NF_DATAEMISSAO, NF_NCONHECIMENTO, NF_TIPO, TRANS_ID, ENF_ID, NF_DESCRIMINACAO,
			NF_ACEITE, NF_INTEGRIDADE, NF_CARTA, NF_VOLUME, NF_DEVOLUCAOCOMPLETA, NF_CFOP,
			NO_ID, NF_ID_PAI, NF_VALIDADE, NF_DATA, NF_RECEBIMENTO)
			VALUES
			(@nf_numeronota, @nf_qtdevolumes, @nf_valortotal, @nf_dataemissao, @nf_nconhecimento, 
			@nf_tipo, @trans_id, @enf_id, @nf_descriminacao, @nf_aceite, @nf_integridade, @nf_carta,
			@nf_volume, @nf_devolucaocompleta, @nf_cfop, @no_id, @nf_id_pai, 
			@nf_validade, @nf_data, @nf_recebimento)

		IF @@ERROR <> 0 BEGIN
			ROLLBACK TRANSACTION
			SET @msg_erro = 'Não foi possível inserir a nota fiscal ' + @nf_numeronota
			RAISERROR( @msg_erro, 16, 1)
			RETURN -1
		END

		SET @nf_id = @@IDENTITY
	END
	ELSE BEGIN
		--altera--
		UPDATE SCE_Nota_Fiscal SET
			NF_NUMERONOTA = @nf_numeronota, NF_QTDEVOLUMES = @nf_qtdevolumes,
			NF_VALORTOTAL = @nf_valortotal, NF_DATAEMISSAO = @nf_dataemissao, 
			NF_NCONHECIMENTO = @nf_nconhecimento, NF_TIPO = @nf_tipo, TRANS_ID = @trans_id,
			ENF_ID = @enf_id, NF_DESCRIMINACAO = @nf_descriminacao, NF_ACEITE = @nf_aceite,
			NF_INTEGRIDADE = @nf_integridade, NF_CARTA = @nf_carta, NF_VOLUME = @nf_volume,
			NF_DEVOLUCAOCOMPLETA = @nf_devolucaocompleta, NF_CFOP = @nf_cfop,
			NO_ID = @no_id, NF_ID_PAI = @nf_id_pai, 
			NF_VALIDADE = @nf_validade, NF_DATA = @nf_data, NF_RECEBIMENTO = @nf_recebimento
			WHERE NF_ID = @nf_id

		IF @@ERROR <> 0 BEGIN
			ROLLBACK TRANSACTION
			SET @msg_erro = 'Não foi possível atualizar a nota fiscal ' + @nf_numeronota
			RAISERROR( @msg_erro, 16, 1)
			RETURN -1
		END

		SET @nf_id = @nf_id
	END

	--LOG
	SET @msg_erro = 'O usuário ' + @user_id + ' cadastrou a nota fiscal ' + CAST(@nf_numeronota AS VARCHAR) + '.'

	INSERT INTO SCE_Historico (ID_USUARIO, ACAO, DATA)
		VALUES (@user_id, @msg_erro, CONVERT( VARCHAR, GETDATE(), 103))
	IF @@ERROR <> 0 BEGIN
		ROLLBACK TRANSACTION
		RAISERROR( 'Não foi possível inserir no histórico', 16, 1)
		RETURN -1
	END

	COMMIT TRANSACTION
	RETURN @nf_id
END
GO


/****** Object:  StoredProcedure [dbo].[sp_SCE_CADASTRA_RESERVA]    Script Date: 07/19/2018 18:45:13 ******/
IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[dbo].[sp_SCE_CADASTRA_RESERVA]') AND OBJECTPROPERTY(id,N'IsProcedure') = 1)
	DROP PROCEDURE [dbo].[sp_SCE_CADASTRA_RESERVA]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE  PROCEDURE [dbo].[sp_SCE_CADASTRA_RESERVA]
(
	@ag_numero INT,
	@res_responsavel VARCHAR(80),
	@amb_id INT,
	@lista_itens VARCHAR(8000),
	@observacao TEXT
)
AS
/*** Cadastra uma nova reserva ***/
BEGIN
	DECLARE @msg_erro VARCHAR(8000)

	SET NOCOUNT ON

	BEGIN TRANSACTION

	SELECT AG_NUMERO FROM SCE_Reserva WHERE AG_NUMERO = @ag_numero

	-- altera reserva
	IF @@ROWCOUNT > 0 BEGIN
		UPDATE SCE_Reserva SET RES_RESPONSAVEL = UPPER(@res_responsavel), AMB_ID = @amb_id, 
			RES_OBSERVACAO = @observacao
			WHERE AG_NUMERO = @ag_numero

		IF @@error <> 0
		BEGIN
			ROLLBACK TRANSACTION
			RAISERROR( 'Não foi possível alterar esta reserva de equipamento', 16, 1)
			RETURN -1
		END
	END
	-- insere reserva
	ELSE BEGIN  -- a principio o responsavel é o mesmo do agendamento !
		INSERT INTO SCE_Reserva (AG_NUMERO, RES_RESPONSAVEL, AMB_ID, RES_OBSERVACAO)
			VALUES (@ag_numero, UPPER(@res_responsavel), @amb_id, @observacao)

		IF @@error <> 0
		BEGIN
			ROLLBACK TRANSACTION
			RAISERROR( 'Não foi possível cadastrar esta reserva de equipamento', 16, 1)
			RETURN -1
		END
	END

	-- itens da reserva
	DELETE FROM SCE_Reserva_Equipamentos 
		WHERE AG_NUMERO = @ag_numero AND REQ_MOVIMENTOU <> 1
	IF @@error <> 0
	BEGIN
		ROLLBACK TRANSACTION
		RAISERROR( 'Não foi possível excluir os itens desta reserva', 16, 1)
		RETURN -1
	END

	-- loop para inserir itens reservados
	IF @lista_itens IS NOT NULL BEGIN

		-- a lista de campos está definida da seguinte forma: "»!«" separador de registro e "¿!¿" como separador de campo (ALT + 175 / 174 e ALT 168 respectivamente)
		DECLARE @separa_registro VARCHAR(3), @separa_campo VARCHAR(3)
		SET @separa_registro = '»?«'
		SET @separa_campo = '¿?¿'
	
		DECLARE @reg VARCHAR(8000), @fim BIT, @iini INT, @ifim INT

		DECLARE @eq_id VARCHAR(255), @cod_barras VARCHAR(255), @liberado VARCHAR(255)
		DECLARE @data_inicio VARCHAR(255), @data_termino VARCHAR(255)
		DECLARE @aceito TINYINT, @setup VARCHAR(10)

		SET @lista_itens = rtrim(ltrim( @lista_itens ))
		SET @fim = 0
		SET @iini = 1
		WHILE ( @fim = 0 ) BEGIN
			SET @ifim = PATINDEX('%' + @separa_registro + '%', @lista_itens )
			IF @ifim = 0 
				SET @reg = SUBSTRING( @lista_itens, @iini, LEN( @lista_itens ) )
			ELSE
				SET @reg = SUBSTRING( @lista_itens, @iini, @ifim - 1 )

			-- retira os campos da string
			SET @eq_id = SUBSTRING( @reg, 1, PATINDEX( '%' + @separa_campo + '%', @reg ) -1 )
			SET @reg = SUBSTRING( @reg, PATINDEX( '%' + @separa_campo + '%', @reg )+3, LEN( @reg ) )

			/*** nao estou passando o codigo de barras como parametro, apenas do EQ_ID
			-- SET @cod_barras = SUBSTRING( @reg, 1, PATINDEX( '%' + @separa_campo + '%', @reg ) -1 ) 
			-- SET @reg = SUBSTRING( @reg, PATINDEX( '%' + @separa_campo + '%', @reg )+3, LEN( @reg ) )
			***/
			SET @data_inicio = SUBSTRING( @reg, 1, PATINDEX( '%' + @separa_campo + '%', @reg ) -1 )
			SET @reg = SUBSTRING( @reg, PATINDEX( '%' + @separa_campo + '%', @reg )+3, LEN( @reg ) )
			SET @data_termino = SUBSTRING( @reg, 1, PATINDEX( '%' + @separa_campo + '%', @reg ) -1 )
			SET @reg = SUBSTRING( @reg, PATINDEX( '%' + @separa_campo + '%', @reg )+3, LEN( @reg ) )
			SET @setup = SUBSTRING( @reg, 1, PATINDEX( '%' + @separa_campo + '%', @reg ) -1 )
			SET @reg = SUBSTRING( @reg, PATINDEX( '%' + @separa_campo + '%', @reg )+3, LEN( @reg ) )

			IF LTRIM( RTRIM( @reg ) ) = '1'
				SET @aceito = 1
			ELSE IF LTRIM( RTRIM( @reg ) ) = '0'
				SET @aceito = 0
			ELSE 
				SET @aceito = NULL

			SELECT EQ_ID FROM SCE_Reserva_Equipamentos WHERE AG_NUMERO = @ag_numero AND EQ_ID = @eq_id
			IF @@ROWCOUNT > 0 BEGIN -- item ja existe na lista
				UPDATE SCE_Reserva_Equipamentos 
					SET REQ_DATAINICIO = CONVERT(DATETIME, @data_inicio, 103), 
						REQ_DATATERMINO = CONVERT(DATETIME, @data_termino, 103),
						REQ_EQSETUP = @setup,
						REQ_ACEITO = @aceito
					WHERE AG_NUMERO = @ag_numero AND EQ_ID = @eq_id
				IF @@ERROR <> 0 BEGIN
					ROLLBACK TRANSACTION
					RAISERROR( 'Não foi possível atualizar os dados da reserva', 16, 1)
					RETURN -1
				END
			END
			ELSE BEGIN
				INSERT INTO SCE_Reserva_Equipamentos ( AG_NUMERO, EQ_ID, REQ_DATAINICIO, REQ_DATATERMINO, REQ_EQSETUP, REQ_ACEITO )
					VALUES ( @ag_numero, @eq_id, CONVERT(DATETIME, @data_inicio, 103), CONVERT(DATETIME, @data_termino, 103), @setup, @aceito )
				IF @@ERROR <> 0 BEGIN
					ROLLBACK TRANSACTION
					RAISERROR( 'Não foi possível inserir dados da reserva', 16, 1)
					RETURN -1
				END
			END

			SET @lista_itens = LTRIM(SUBSTRING( @lista_itens, @ifim + 3, LEN( @lista_itens ) ))
			IF @ifim = 0 SET @fim = 1
		END
	END

	COMMIT TRANSACTION
	RETURN @ag_numero
END
GO


/****** Object:  StoredProcedure [dbo].[sp_SCE_DEPARA_MODELOS]    Script Date: 07/19/2018 18:45:13 ******/
IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[dbo].[sp_SCE_DEPARA_MODELOS]') AND OBJECTPROPERTY(id,N'IsProcedure') = 1)
	DROP PROCEDURE [dbo].[sp_SCE_DEPARA_MODELOS]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[sp_SCE_DEPARA_MODELOS]
(
	@mod_id_old INT,
	@mod_id_new INT
)
AS
BEGIN
	/* DE - PARA de modelos */
	SET NOCOUNT ON
	BEGIN TRANSACTION

	UPDATE SCE_Equipamentos SET MOD_ID = @mod_id_new WHERE MOD_ID = @mod_id_old
	IF @@ERROR <> 0 BEGIN
		ROLLBACK TRANSACTION
		RAISERROR('Não foi possível atualizar os equipamentos', 16, 1)
		RETURN -1
	END

	DELETE FROM SCE_Modelos WHERE MOD_ID = @mod_id_old
	IF @@ERROR <> 0 BEGIN
		ROLLBACK TRANSACTION
		RAISERROR('Não foi possível excluir o modelo antigo', 16, 1)
		RETURN -1
	END

	COMMIT TRANSACTION
	RETURN 1
END
GO

/****** Object:  StoredProcedure [dbo].[sp_SCE_EXCLUI_EQUIPAMENTO]    Script Date: 07/19/2018 18:45:13 ******/
IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[dbo].[sp_SCE_EXCLUI_EQUIPAMENTO]') AND OBJECTPROPERTY(id,N'IsProcedure') = 1)
	DROP PROCEDURE [dbo].[sp_SCE_EXCLUI_EQUIPAMENTO]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[sp_SCE_EXCLUI_EQUIPAMENTO]
(
	@eq_id INT,
	@user_id VARCHAR(80)
)
AS
/*** Remove um equipamento consumivel bem como suas movimentações ***/
BEGIN
	SET NOCOUNT ON
	BEGIN TRANSACTION

	DECLARE @cod_barras VARCHAR(255), @user_nome VARCHAR(255)

	IF @eq_id IS NOT NULL BEGIN
		DELETE FROM SCE_Historico_Movimentacao WHERE EQ_ID = @eq_id
		IF @@error <> 0
		BEGIN
			ROLLBACK TRANSACTION
			RAISERROR( 'Não foi possível excluir o histórico de movimentações deste equipamento', 16, 1)
			RETURN -1
		END

		DELETE FROM SCE_Movimentacao WHERE EQ_ID = @eq_id
		IF @@error <> 0
		BEGIN
			ROLLBACK TRANSACTION
			RAISERROR( 'Não foi possível excluir as movimentações deste equipamento', 16, 1)
			RETURN -1
		END

		DELETE FROM SCE_Equipamentos_Controle WHERE EQ_ID = @eq_id
		IF @@error <> 0
		BEGIN
			ROLLBACK TRANSACTION
			RAISERROR( 'Não foi possível excluir os controles de calibração/manutenção/qualificação do equipamento', 16, 1)
			RETURN -1
		END

		DELETE FROM SCE_Acessorios WHERE EQ_ID = @eq_id
		IF @@error <> 0
		BEGIN
			ROLLBACK TRANSACTION
			RAISERROR( 'Não foi possível excluir os acessórios do equipamento', 16, 1)
			RETURN -1
		END

		SELECT @cod_barras = EQ_CODIGOBARRAS FROM SCE_Equipamentos WHERE EQ_ID = @eq_id

		DELETE FROM SCE_Equipamentos WHERE EQ_ID = @eq_id
		IF @@error <> 0
		BEGIN
			ROLLBACK TRANSACTION
			RAISERROR( 'Não foi possível excluir este equipamento', 16, 1)
			RETURN -1
		END

		-- histórico da operação
		SELECT @user_nome = USER_NOME FROM SCE_Usuarios WHERE USER_ID = @user_id

		INSERT INTO SCE_Historico (ID_USUARIO, ACAO, DATA)
			VALUES (@user_id, 'O usuário ' + @user_nome + ' excluiu o equipamento ' + @cod_barras + '.', GETDATE())
		IF @@error <> 0
		BEGIN
			ROLLBACK TRANSACTION
			RAISERROR( 'Não foi registrar o histórico de exclusão do equipamento', 16, 1)
			RETURN -1
		END
	END
	ELSE BEGIN
		ROLLBACK TRANSACTION
		RAISERROR( 'O código do equipamento consumível é inválido', 16, 1)
		RETURN -1
	END

	COMMIT TRANSACTION
	RETURN 1
END
GO

/****** Object:  StoredProcedure [dbo].[sp_SCE_EXCLUI_MOVIMENTACAO]    Script Date: 07/19/2018 18:45:13 ******/
IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[dbo].[sp_SCE_EXCLUI_MOVIMENTACAO]') AND OBJECTPROPERTY(id,N'IsProcedure') = 1)
	DROP PROCEDURE [dbo].[sp_SCE_EXCLUI_MOVIMENTACAO]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[sp_SCE_EXCLUI_MOVIMENTACAO]
(
	@mov_id INT,
	@user_id INT
)
AS
	/*** Apago uma nova movimentacao existente ***/
BEGIN
	DECLARE @msg_erro VARCHAR(8000), @user_nome VARCHAR(100), @eq_codigobarras VARCHAR(20)

	SET NOCOUNT ON

	BEGIN TRANSACTION

	-- pega o nome do usuario e o codigo de barras
	SELECT @user_nome = USER_NOME FROM SCE_Usuarios WHERE USER_ID = @user_id
	SELECT @eq_codigobarras = EQ_CODIGOBARRAS FROM SCE_Equipamentos 
		WHERE EQ_ID = (SELECT EQ_ID FROM SCE_Movimentacao WHERE MOV_ID = @mov_id)

	IF @mov_id IS NOT NULL BEGIN
		DELETE FROM SCE_Movimentacao WHERE MOV_ID = @mov_id
		IF @@ERROR <> 0 BEGIN
			ROLLBACK TRANSACTION
			RAISERROR( 'Não foi possível apagar esta movimentação', 16, 1)
			RETURN -1
		END
	END


	SET @msg_erro = 'O usuário ' + @user_nome + ' apagou o movimento #' + CAST(@mov_id AS VARCHAR) + ' do equipamento ' + @eq_codigobarras + '.'

	INSERT INTO SCE_Historico ( ID_USUARIO, ACAO, DATA ) 
		VALUES ( @user_id, @msg_erro, CONVERT( VARCHAR, GETDATE(), 103) )
	IF @@ERROR <> 0 BEGIN
		ROLLBACK TRANSACTION
		RAISERROR( 'Não foi possível inserir no histórico', 16, 1)
		RETURN -1
	END

	COMMIT TRANSACTION
	RETURN 1
END
GO


/****** Object:  StoredProcedure [dbo].[sp_SCE_INDICADOR_MENSAL_MOV_ITEM]    Script Date: 07/19/2018 18:45:13 ******/
IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[dbo].[sp_SCE_INDICADOR_MENSAL_MOV_ITEM]') AND OBJECTPROPERTY(id,N'IsProcedure') = 1)
	DROP PROCEDURE [dbo].[sp_SCE_INDICADOR_MENSAL_MOV_ITEM]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[sp_SCE_INDICADOR_MENSAL_MOV_ITEM]
(
	@ano_base INT
)
AS
BEGIN
	/*
	Retorna um SELECT com os totais de itens movimentados.

	Criado em: 16/02/2004 - Gilberto F. Almeida - COPPETEC
	*/
	SELECT
		mes.MES, 
		CASE WHEN qtde_entrada.TOTAL IS NULL THEN 0 ELSE qtde_entrada.TOTAL END AS ENTRADA, 
		CASE WHEN qtde_logentrada.TOTAL IS NULL THEN 0 ELSE qtde_logentrada.TOTAL END AS ENTRADA_LOG, 
		CASE WHEN qtde_logsaida.TOTAL IS NULL THEN 0 ELSE qtde_logsaida.TOTAL END AS SAIDA_LOG,
		CASE WHEN qtde_saida.TOTAL IS NULL THEN 0 ELSE qtde_saida.TOTAL END AS SAIDA
	FROM
		(
		SELECT 1 AS MES UNION SELECT 2 UNION SELECT 3 UNION SELECT 4 UNION SELECT 5 
		UNION SELECT 6 UNION SELECT 7 UNION SELECT 8 UNION SELECT 9 UNION SELECT 10
		UNION SELECT 11 UNION SELECT 12
		) mes
	 	LEFT JOIN 
		(
			SELECT MONTH(m.MOV_DATA) AS MES, COUNT(*) AS 'TOTAL'
			FROM SCE_Movimentacao m INNER JOIN SCE_Natureza_Operacao n ON m.NO_ID = n.NO_ID
			WHERE n.NO_TIPO = 1 /* 1 = entrada */
				AND YEAR(m.MOV_DATA) = @ano_base
			GROUP BY MONTH(m.MOV_DATA)
		) qtde_entrada
		ON mes.MES= qtde_entrada.MES
 		LEFT JOIN 
		(
			SELECT MONTH(m.MOV_DATA) AS MES, COUNT(*) AS 'TOTAL'
			FROM SCE_Movimentacao m INNER JOIN SCE_Natureza_Operacao n ON m.NO_ID = n.NO_ID
			WHERE n.NO_TIPO = 2 /* 2 = log entrada */
				AND YEAR(m.MOV_DATA) = @ano_base
			GROUP BY MONTH(m.MOV_DATA)
		) qtde_logentrada
		ON mes.MES= qtde_logentrada.MES
 		LEFT JOIN 
		(
			SELECT MONTH(m.MOV_DATA) AS MES, COUNT(*) AS 'TOTAL'
			FROM SCE_Movimentacao m INNER JOIN SCE_Natureza_Operacao n ON m.NO_ID = n.NO_ID
			WHERE n.NO_TIPO = 3 /* 3 = saida/expedicao */
				AND YEAR(m.MOV_DATA) = @ano_base
			GROUP BY MONTH(m.MOV_DATA)
		) qtde_saida
		ON mes.MES= qtde_saida.MES
 		LEFT JOIN 
		(
			SELECT MONTH(m.MOV_DATA) AS MES, COUNT(*) AS 'TOTAL'
			FROM SCE_Movimentacao m INNER JOIN SCE_Natureza_Operacao n ON m.NO_ID = n.NO_ID
			WHERE n.NO_TIPO = 4 /* 4 = log saida */
				AND YEAR(m.MOV_DATA) = @ano_base
			GROUP BY MONTH(m.MOV_DATA)
		) qtde_logsaida
		ON mes.MES= qtde_logsaida.MES
	ORDER BY mes.MES
END
GO


/****** Object:  StoredProcedure [dbo].[sp_SCE_INDICADOR_MENSAL_QTDE_NOTAFISCAL]    Script Date: 07/19/2018 18:45:13 ******/
IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[dbo].[sp_SCE_INDICADOR_MENSAL_QTDE_NOTAFISCAL]') AND OBJECTPROPERTY(id,N'IsProcedure') = 1)
	DROP PROCEDURE [dbo].[sp_SCE_INDICADOR_MENSAL_QTDE_NOTAFISCAL]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[sp_SCE_INDICADOR_MENSAL_QTDE_NOTAFISCAL]
(
	@ano_base INT
)
AS
BEGIN
	/*
	Retorna um SELECT com a quantidade de notas fiscais de entrada e de
	saída em um dado ano.

	Criado em: 16/02/2004 - Gilberto F. Almeida - COPPETEC
	*/
	SELECT
		mes.MES, 
		CASE WHEN qtde_entrada.QUANTIDADE IS NULL THEN 0 ELSE qtde_entrada.QUANTIDADE END AS ENTRADA, 
		CASE WHEN qtde_saida.QUANTIDADE IS NULL THEN 0 ELSE qtde_saida.QUANTIDADE END AS SAIDA
	FROM
		(
		SELECT 1 AS MES UNION SELECT 2 UNION SELECT 3 UNION SELECT 4 UNION SELECT 5 
		UNION SELECT 6 UNION SELECT 7 UNION SELECT 8 UNION SELECT 9 UNION SELECT 10
		UNION SELECT 11 UNION SELECT 12
		) mes
	 	LEFT JOIN 
		(
			SELECT MONTH(NF_RECEBIMENTO) AS MES, COUNT(*) AS 'QUANTIDADE'
			FROM SCE_Nota_Fiscal nf
			WHERE nf.NF_TIPO = 1 /* 1 = entrada / 2 = saida */
				AND YEAR(nf.NF_RECEBIMENTO) = @ano_base
			GROUP BY MONTH(nf.NF_RECEBIMENTO)
		) qtde_entrada
		ON mes.MES= qtde_entrada.MES
 		LEFT JOIN 
		(
			SELECT MONTH(NF_RECEBIMENTO) AS MES, COUNT(*) AS 'QUANTIDADE'
			FROM SCE_Nota_Fiscal nf 
			WHERE nf.NF_TIPO = 2 /* 1 = entrada / 2 = saida */
				AND YEAR(nf.NF_RECEBIMENTO) = @ano_base
			GROUP BY MONTH(nf.NF_RECEBIMENTO)
		) qtde_saida
		ON mes.MES= qtde_saida.MES
	ORDER BY mes.MES
END
GO


/****** Object:  StoredProcedure [dbo].[sp_SCE_INDICADOR_MENSAL_VALOR_NOTAFISCAL]    Script Date: 07/19/2018 18:45:13 ******/
IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[dbo].[sp_SCE_INDICADOR_MENSAL_VALOR_NOTAFISCAL]') AND OBJECTPROPERTY(id,N'IsProcedure') = 1)
	DROP PROCEDURE [dbo].[sp_SCE_INDICADOR_MENSAL_VALOR_NOTAFISCAL]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[sp_SCE_INDICADOR_MENSAL_VALOR_NOTAFISCAL]
(
	@ano_base INT
)
AS
BEGIN
	/*
	Retorna um SELECT com os totais de notas fiscais de entrada e de
	saída em um dado ano.

	Criado em: 16/02/2004 - Gilberto F. Almeida - COPPETEC
	*/
	SELECT
		mes.MES, 
		CASE WHEN qtde_entrada.TOTAL IS NULL THEN 0 ELSE qtde_entrada.TOTAL END AS ENTRADA, 
		CASE WHEN qtde_saida.TOTAL IS NULL THEN 0 ELSE qtde_saida.TOTAL END AS SAIDA
	FROM
		(
		SELECT 1 AS MES UNION SELECT 2 UNION SELECT 3 UNION SELECT 4 UNION SELECT 5 
		UNION SELECT 6 UNION SELECT 7 UNION SELECT 8 UNION SELECT 9 UNION SELECT 10
		UNION SELECT 11 UNION SELECT 12
		) mes
	 	LEFT JOIN 
		(
			SELECT MONTH(NF_RECEBIMENTO) AS MES, SUM(NF_VALORTOTAL) AS 'TOTAL'
			FROM SCE_Nota_Fiscal nf
			WHERE nf.NF_TIPO = 1 /* 1 = entrada / 2 = saida */
				AND YEAR(nf.NF_RECEBIMENTO) = @ano_base
			GROUP BY MONTH(nf.NF_RECEBIMENTO)
		) qtde_entrada
		ON mes.MES= qtde_entrada.MES
 		LEFT JOIN 
		(
			SELECT MONTH(NF_RECEBIMENTO) AS MES, SUM(NF_VALORTOTAL) AS 'TOTAL'
			FROM SCE_Nota_Fiscal nf 
			WHERE nf.NF_TIPO = 2 /* 1 = entrada / 2 = saida */
				AND YEAR(nf.NF_RECEBIMENTO) = @ano_base
			GROUP BY MONTH(nf.NF_RECEBIMENTO)
		) qtde_saida
		ON mes.MES= qtde_saida.MES
	ORDER BY mes.MES
END
GO


/****** Object:  StoredProcedure [dbo].[sp_SCE_PASSA_CARGA]    Script Date: 07/19/2018 18:45:13 ******/
IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[dbo].[sp_SCE_PASSA_CARGA]') AND OBJECTPROPERTY(id,N'IsProcedure') = 1)
	DROP PROCEDURE [dbo].[sp_SCE_PASSA_CARGA]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[sp_SCE_PASSA_CARGA]
(
	@eq_id VARCHAR(8000),
	@ag_numero_orig INT,
	@ag_numero_dest INT,
	@user_id VARCHAR(80)
)
AS
BEGIN
	/***
		Cadastra uma passagem de carga (equipamentos) de uma AS para outra.
		Posteriormente quando o RT da AS destino receber a carga, sera gerada
		uma movimentacao de entrada no LOG e outra de saida para o novo RT

		COPPETEC: Gilberto Almeida
		Criado: 11/11/2003	Ultima alteracao: 18/04/2012
	***/
	SET NOCOUNT ON

	DECLARE @MSG VARCHAR(8000)

	BEGIN TRANSACTION

	-- Apago a passagem de carga que ainda nao foi aprovada pelo usuario
	DELETE FROM SCE_Passagem_Carga WHERE AG_NUMERO_ORIG = @ag_numero_orig AND PAS_APROVADO = 0
	IF @@ERROR <> 0 BEGIN
		ROLLBACK TRANSACTION
		RAISERROR( 'Não foi possível remover passagem de carga.', 16, 1)
		RETURN -1
	END

	IF (@eq_id IS NOT NULL) OR (@eq_id <> '') BEGIN
		DECLARE @iini INT, @fim INT, @ifim INT
		DECLARE @separa_registro VARCHAR(1), @reg VARCHAR(255)
		DECLARE @eq_codigobarras VARCHAR(20)

		SET @separa_registro = ','

		SET @eq_id = rtrim(ltrim( @eq_id ))
		SET @fim = 0
		SET @iini = 1
		WHILE ( @fim = 0 ) BEGIN
			SET @ifim = PATINDEX('%' + @separa_registro + '%', @eq_id )
			IF @ifim = 0 
				SET @reg = SUBSTRING( @eq_id, @iini, LEN( @eq_id ) )
			ELSE
				SET @reg = SUBSTRING( @eq_id, @iini, @ifim - 1 )

			INSERT INTO SCE_Passagem_Carga ( AG_NUMERO_ORIG, AG_NUMERO_DEST, EQ_ID, PAS_APROVADO )
				VALUES ( @ag_numero_orig, @ag_numero_dest, @reg, 0 )
			IF @@ERROR <> 0 BEGIN
				ROLLBACK TRANSACTION
				RAISERROR( 'Não foi possível solicitar a passagem de carga.', 16, 1)
				RETURN -1
			END

			-- pega o nome do usuario e o codigo de barras
			SELECT @eq_codigobarras = EQ_CODIGOBARRAS FROM SCE_Equipamentos WHERE EQ_ID = @reg

			SET @MSG = 'O usuário ' + @user_id + ' passou a carga do equipamento ' + @eq_codigobarras

			EXEC sp_LogEvento @USER_ID, 'SCE', @MSG

			IF @@ERROR <> 0 BEGIN
				ROLLBACK TRANSACTION
				RAISERROR( 'Não foi possível inserir no histórico', 16, 1)
				RETURN -1
			END
			--

			SET @eq_id = LTRIM(SUBSTRING( @eq_id, @ifim + 1, LEN( @eq_id ) ))
			IF @ifim = 0 SET @fim = 1
		END
	END
	ELSE BEGIN

		SET @MSG = 'O usuário ' + @user_id + ' removeu a carga do agendamento ' + CAST(@ag_numero_orig as VARCHAR)

		EXEC sp_LogEvento @USER_ID, 'SCE', @MSG

		IF @@ERROR <> 0 BEGIN
			ROLLBACK TRANSACTION
			RAISERROR( 'Não foi possível inserir no histórico', 16, 1)
			RETURN -1
		END
	END

	COMMIT TRANSACTION
	RETURN 1
END
GO


/****** Object:  StoredProcedure [dbo].[sp_SCE_RECEBE_CARGA]    Script Date: 07/19/2018 18:45:13 ******/
IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[dbo].[sp_SCE_RECEBE_CARGA]') AND OBJECTPROPERTY(id,N'IsProcedure') = 1)
	DROP PROCEDURE [dbo].[sp_SCE_RECEBE_CARGA]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE  PROCEDURE [dbo].[sp_SCE_RECEBE_CARGA]
(
	@eq_id VARCHAR(8000),
	@ag_numero_dest INT,
	@user_id VARCHAR(80)
)
AS
BEGIN
	/***
		Recebe a carga passada por um RT à outro. Gera 2 movimentacoes, uma
		de entrada na logistica, outra de saida em nome do outro usuario

		COPPETEC: Gilberto Almeida
		- Criado: 12/11/2003
		- Ultima alteracao: 22/04/2019
				Troquei o código para criar uma tabela temporária e "evitar" duplicação dos itens na lista de equipamentos pois
				estava duplicando nos testes.
	***/
	SET NOCOUNT ON

	BEGIN TRANSACTION

	DECLARE @equip TABLE (
		EQ_ID INT PRIMARY KEY
	)

	-- pega o nome do usuario e o codigo de barras
	DECLARE @MSG VARCHAR(8000)

	IF (@eq_id IS NOT NULL) OR (@eq_id <> '') BEGIN
		DECLARE @iini INT, @fim INT, @ifim INT
		DECLARE @separa_registro VARCHAR(1), @reg VARCHAR(255)
		DECLARE @eq_codigobarras VARCHAR(20)
		DECLARE @resp_origem VARCHAR(20), @resp_destino VARCHAR(20)
		DECLARE @ag_numero_orig INT, @hoje DATETIME

		SET @hoje = GETDATE()
		SET @separa_registro = ','

		SET @eq_id = rtrim(ltrim( @eq_id ))
		SET @fim = 0
		SET @iini = 1
		WHILE ( @fim = 0 )
		BEGIN
			SET @ifim = PATINDEX('%' + @separa_registro + '%', @eq_id )
			IF @ifim = 0 
				SET @reg = SUBSTRING( @eq_id, @iini, LEN( @eq_id ) )
			ELSE
				SET @reg = SUBSTRING( @eq_id, @iini, @ifim - 1 )

			IF NOT EXISTS(SELECT EQ_ID FROM @equip WHERE EQ_ID = CAST(@reg AS INT))
			BEGIN
				INSERT INTO @equip (EQ_ID) VALUES(CAST(@reg AS INT))
			END

			SET @eq_id = LTRIM(SUBSTRING( @eq_id, @ifim + 1, LEN( @eq_id ) ))
			IF @ifim = 0 SET @fim = 1
		END

		DECLARE @eq INT
		DECLARE curEQUIP CURSOR LOCAL FORWARD_ONLY
			 FOR
				SELECT EQ_ID FROM @equip
		OPEN curEQUIP
		FETCH NEXT FROM curEQUIP INTO @eq
		WHILE @@FETCH_STATUS = 0
		BEGIN

			UPDATE SCE_Passagem_Carga 
				SET PAS_APROVADO = 1, PAS_DATARECEBIMENTO = @hoje
				WHERE AG_NUMERO_DEST = @ag_numero_dest AND EQ_ID = @eq
			IF @@ERROR <> 0 BEGIN
				ROLLBACK TRANSACTION
				RAISERROR( 'Não foi possível realizar o recebimento de carga.', 16, 1)
				RETURN -1
			END

			-- responsavel do ag de origem
			SELECT @resp_origem = a.AG_RESPONSAVEL, @ag_numero_orig = a.AG_NUMERO
				FROM Agendamento a 
				INNER JOIN SCE_Passagem_Carga p ON a.AG_NUMERO = p.AG_NUMERO_ORIG
				WHERE 
					AG_NUMERO_DEST = @ag_numero_dest AND p.EQ_ID = @eq

			-- responsavel do ag de destino
			SELECT @resp_destino = a.AG_RESPONSAVEL 
				FROM Agendamento a 
				INNER JOIN SCE_Passagem_Carga p ON a.AG_NUMERO = p.AG_NUMERO_DEST
				WHERE 
					AG_NUMERO_DEST = @ag_numero_dest AND p.EQ_ID = @eq

			-- entrada log
			EXEC sp_SCE_CADASTRA_MOVIMENTACAO NULL, @eq, @hoje, 525 /*LAB - Devolução de teste no laboratório*/, @user_id, @resp_origem, 2 /*Entrada Log*/, NULL, @ag_numero_orig, 0, NULL, NULL, 1, NULL /* Localizacao do item */, NULL, NULL, @user_id
			IF @@ERROR <> 0 BEGIN
				ROLLBACK TRANSACTION
				RAISERROR( 'Não foi possível movimentar a entrada dos itens.', 16, 1)
				RETURN -1
			END

			-- saida log
			EXEC sp_SCE_CADASTRA_MOVIMENTACAO NULL, @eq, @hoje, 524 /*LAB - Saída para teste c/ AS no laboratório*/, @user_id, @resp_destino, 4 /*Saida Log*/, NULL, @ag_numero_dest, 0, NULL, NULL, 1, NULL /* Localizacao do item */, NULL, NULL, @user_id
			IF @@ERROR <> 0 BEGIN
				ROLLBACK TRANSACTION
				RAISERROR( 'Não foi possível movimentar a saída dos itens.', 16, 1)
				RETURN -1
			END

			-- pega o nome do usuario e o codigo de barras
			SELECT @eq_codigobarras = EQ_CODIGOBARRAS FROM SCE_Equipamentos WHERE EQ_ID = @eq

			SET @MSG = 'O usuário ' + @user_id + ' recebeu a carga do equipamento ' + @eq_codigobarras

			EXEC sp_LogEvento @user_id, 'SCE', @MSG

			IF @@ERROR <> 0 BEGIN
				ROLLBACK TRANSACTION
				RAISERROR( 'Não foi possível inserir no histórico', 16, 1)
				RETURN -1
			END

			FETCH NEXT FROM curEQUIP INTO @eq
		END -- FETCH

		CLOSE curEQUIP
		DEALLOCATE curEQUIP
    END

	COMMIT TRANSACTION
	RETURN 1
END
GO


/****** Object:  View [dbo].[vw_Agendamento]    Script Date: 07/19/2018 18:45:13 ******/
IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[dbo].[vw_Agendamento]') AND OBJECTPROPERTY(id, N'IsView') = 1)
	DROP VIEW [dbo].[vw_Agendamento]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE VIEW [dbo].[vw_Agendamento]
AS
	/* Exibe os dados do agendamento e a sua situacao atual */
	SELECT 
		a.*, h.HE_RESPONSAVEL, h.HE_DATAINICIO, h.HE_DATATERMINO, h.HE_MOTIVO, 
		s.ID_SITUACAO, s.S_DESCRICAO, ta.TA_DESCRICAO, t.TEC_NOME, ts.TS_DESCRICAO
	FROM 
		Agendamento a 
		/*** Pega o status pela maior Data ***/
		INNER JOIN Historico_Eventos h ON a.AG_NUMERO = h.AG_NUMERO
		INNER JOIN (
			SELECT h1.AG_NUMERO, MAX(h1.HE_ID) AS HE_ID
			FROM Historico_Eventos h1
				INNER JOIN (
					SELECT AG_NUMERO, MAX(HE_DATAINICIO) AS HE_DATAINICIO 
					FROM Historico_Eventos hh1
					--WHERE hh1.AG_NUMERO = h.AG_NUMERO
					GROUP BY hh1.AG_NUMERO
				) h2 ON h1.AG_NUMERO = h2.AG_NUMERO AND h1.HE_DATAINICIO = h2.HE_DATAINICIO
			GROUP BY h1.AG_NUMERO
		) h3 ON h3.HE_ID = h.HE_ID
		INNER JOIN Situacoes s ON h.ID_SITUACAO = s.ID_SITUACAO
		LEFT JOIN Tipo_Atividade ta ON ta.TA_ID = a.TA_ID
		LEFT JOIN Tecnologia t ON t.TEC_ID = a.TEC_ID
		LEFT JOIN Tipo_Sigilo ts on ts.TS_ID = a.AG_SIGILO
GO



/****** Object:  StoredProcedure [dbo].[sp_CadAgendamento]    Script Date: 07/19/2018 18:45:13 ******/
IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[dbo].[sp_CadAgendamento]') AND OBJECTPROPERTY(id,N'IsProcedure') = 1)
	DROP PROCEDURE [dbo].[sp_CadAgendamento]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE   PROCEDURE [dbo].[sp_CadAgendamento]
	@separa_campo varchar(4),
	@separa_registro varchar(4),
	@pAG_NUMEROIn INT OUTPUT,
	@pAG_TITULO varchar(50),
	@pRecebeMail bit,
	@pAG_TECNOLOGIA INT,
	@pAG_DATAINICIO char(20), -- smalldatetime
	@pAG_DATATERMINO char(20), -- smalldatetime
	@pAG_SIGILO bit,
	@pAG_OBJETIVO varchar(8000),
	@pAG_AMBIENTE varchar(8000),
	@pAG_RECURSOS varchar(8000),
	@pAG_OBSERVACAO varchar(8000),
	@pAG_USERNAME varchar(80),
	@pAG_ORGAO varchar(200),
	@pAG_CLIENTEEXTERNO varchar(200),
	@pAG_RETORNOCLIENTE money,
	@pAG_VALORCONTRATOCLIENTE money,
	@pAG_PLANODEMETAS INT,
	@pSTR_PARTICIPANTES_EBT VARCHAR(8000),
	@pSTR_PARTICIPANTES_NEBT VARCHAR(8000),
	@pAG_USERNAME_MATRICULA VARCHAR(30),
	@pAG_USERNAME_NOME VARCHAR(100),
	@pAG_USERNAME_TELEFONE VARCHAR(30)
AS
BEGIN
	/**
		Cadastra um novo agendamento com dados preenchidos em um primeiro
		momento apenas ao cliente. Posteriormente estes dados são complementados
		pelos RAT´s e RT´s
	**/

	DECLARE @pAG_USERNAMEint VARCHAR(80)
	DECLARE @pAG_ORGAOint VARCHAR(200)


	SET NOCOUNT ON 
	BEGIN TRANSACTION

	IF  @pAG_NUMEROIn IS NULL  BEGIN
		--////////////////// INSERE AGENDAMENTO
		INSERT INTO AGENDAMENTO
			(AG_TITULO, TEC_ID,AG_DATASOLICITACAO, AG_DATAINICIO, AG_DATATERMINO, AG_SIGILO, 
			 AG_OBJETIVO, AG_FLAGREMARCACAO, AG_MOTIVO,   AG_USERNAME, AG_ORGAO, AG_RECEBEMAIL,AG_AMBIENTE,
			 AG_RECURSOS, AG_OBSERVACAO, AG_CLIENTEEXTERNO, AG_RETORNOCLIENTE, AG_VALORCONTRATOCLIENTE, 
			 AG_PLANODEMETAS, AG_USERNAME_MATRICULA, AG_USERNAME_NOME, AG_USERNAME_TELEFONE)
		VALUES
			(UPPER(@pAG_TITULO), @pAG_TECNOLOGIA, getDate(), Convert(smalldatetime, @pAG_DATAINICIO, 103), 
			 Convert(smalldatetime, @pAG_DATATERMINO, 103), @pAG_SIGILO,  @pAG_OBJETIVO, 0, null,  @pAG_USERNAME, 
			 @pAG_ORGAO, @pRecebeMail,@pAG_AMBIENTE,@pAG_RECURSOS,@pAG_OBSERVACAO, @pAG_CLIENTEEXTERNO, 
			 @pAG_RETORNOCLIENTE, @pAG_VALORCONTRATOCLIENTE, @pAG_PLANODEMETAS, 
			 @pAG_USERNAME_MATRICULA, @pAG_USERNAME_NOME, @pAG_USERNAME_TELEFONE)
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
		SELECT
			@pAG_USERNAMEint = AG_USERNAME,
			@pAG_ORGAOint = AG_ORGAO
		FROM
			AGENDAMENTO
		WHERE
			AG_NUMERO = @pAG_NUMEROIn

		IF (@pAG_ORGAO = ' ') OR (@pAG_ORGAO = '') OR (@pAG_ORGAO = '--')
			SET @pAG_ORGAO = NULL

		IF (@pAG_ORGAOint = ' ') OR (@pAG_ORGAOint = '') OR (@pAG_ORGAOint = '--')
			SET @pAG_ORGAOint = NULL

		-- se for o mesmo solicitante
		IF @pAG_USERNAMEint = @pAG_USERNAME
		BEGIN
			-- entao vejo o parametro orgao, se for nulo mantenho o original
			IF (@pAG_ORGAO IS NOT NULL) OR (@pAG_ORGAOint IS NOT NULL)
			BEGIN
				IF @pAG_ORGAOint IS NULL
					SET @pAG_ORGAOint = @pAG_ORGAO
			END
		END
		ELSE
		BEGIN
			IF @pAG_ORGAO IS NULL
				SET @pAG_ORGAOint = NULL
			ELSE
				SET @pAG_ORGAOint = @pAG_ORGAO
		END


		UPDATE AGENDAMENTO SET
			AG_TITULO = UPPER(@pAG_TITULO),
			TEC_ID = @pAG_TECNOLOGIA,
			/*AG_DATASOLICITACAO = getDate(),*/
			AG_DATAINICIO = Convert(smalldatetime, @pAG_DATAINICIO, 103),
			AG_DATATERMINO = Convert(smalldatetime, @pAG_DATATERMINO, 103),
			AG_SIGILO = @pAG_SIGILO,
			AG_OBJETIVO = @pAG_OBJETIVO,
			AG_USERNAME = @pAG_USERNAME,
			AG_ORGAO = @pAG_ORGAOint,
			AG_AMBIENTE = @pAG_AMBIENTE,
			AG_RECURSOS = @pAG_RECURSOS,
			AG_OBSERVACAO = @pAG_OBSERVACAO,
			AG_RECEBEMAIL = @pRecebeMail,
			AG_CLIENTEEXTERNO = @pAG_CLIENTEEXTERNO,
			AG_RETORNOCLIENTE = @pAG_RETORNOCLIENTE,
			AG_VALORCONTRATOCLIENTE = @pAG_VALORCONTRATOCLIENTE,
			AG_PLANODEMETAS = @pAG_PLANODEMETAS,
			AG_USERNAME_MATRICULA = @pAG_USERNAME_MATRICULA, 
			AG_USERNAME_NOME = @pAG_USERNAME_NOME, 
			AG_USERNAME_TELEFONE = @pAG_USERNAME_TELEFONE
		WHERE
			AG_NUMERO = @pAG_NUMEROIn

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

