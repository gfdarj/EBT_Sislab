CREATE  PROCEDURE [dbo].[sp_SCE_CADASTRA_RESERVA]
	@ag_numero INT,
	@res_responsavel VARCHAR(20),
	@amb_id INT,
	@lista_itens VARCHAR(8000),
	@observacao TEXT
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
