/*
--- TESTE
declare @eq_id INT 
exec [sp_SCE_CADASTRA_EQUIPAMENTO] @eq_id, 'XXXX1', 'YYYY', 'SN1',
	'AQUI',null, null, 0, null, null, null, null, null, null, 1, 'T', 1, null, null, null

select * from SCE_Equipamentos
*/

ALTER TABLE SCE_Equipamentos ADD EQ_DT_CADASTRO DATETIME NULL
GO


/***
 ***	PROCEDURE DO BANCO DE DADOS ATUAL DO SISLAB
 ***/

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
				EQ_MANUT_PREVENTIVA, EQ_INSTRUMENTAL, EQ_PROPRIEDADE, EQ_CONFORME, EQ_FREQ_CALIBRACAO, EQ_DT_CADASTRO)
			VALUES (@eq_codigobarras, @eq_codigobarrasanterior, @eq_numeroserie, @eq_localizacao, @mod_id, @eq_obs, @status,
				@eq_oper_delta, @eq_oper_umidade, @eq_oper_warmup, @eq_arma_delta, @eq_arma_umidade,
				@eq_manut_preventiva, @eq_instrumental, @eq_propriedade, @eq_conforme, @eq_freq_calibracao, GETDATE())
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



/***
 ***	PROCEDURE DO NOVO BANCO DE DADOS
 ***/

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
	@amb_id INT,
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
		INSERT INTO SCE_Equipamentos (EQ_CODIGOBARRAS, EQ_CODIGOBARRASANTERIOR, EQ_NUMEROSERIE, AMB_ID,
				MOD_ID, EQ_OBS, STATUS,
				EQ_OPER_DELTA, EQ_OPER_UMIDADE, EQ_OPER_WARMUP, EQ_ARMA_DELTA, EQ_ARMA_UMIDADE,
				EQ_MANUT_PREVENTIVA, EQ_INSTRUMENTAL, EQ_PROPRIEDADE, EQ_CONFORME, EQ_FREQ_CALIBRACAO, EQ_DT_CADASTRO)
			VALUES (@eq_codigobarras, @eq_codigobarrasanterior, @eq_numeroserie, @amb_id, @mod_id, @eq_obs, @status,
				@eq_oper_delta, @eq_oper_umidade, @eq_oper_warmup, @eq_arma_delta, @eq_arma_umidade,
				@eq_manut_preventiva, @eq_instrumental, @eq_propriedade, @eq_conforme, @eq_freq_calibracao, GETDATE())
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
				AMB_ID = @amb_id,
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
