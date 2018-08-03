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

