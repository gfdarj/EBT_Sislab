CREATE PROCEDURE [dbo].[sp_CadAgendamentoRT]
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