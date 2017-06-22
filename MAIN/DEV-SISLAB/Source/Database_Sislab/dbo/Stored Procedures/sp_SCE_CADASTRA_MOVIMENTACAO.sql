
CREATE  PROCEDURE [dbo].[sp_SCE_CADASTRA_MOVIMENTACAO]
	@mov_id INT,
	@eq_id INT,
	@mov_data DATETIME,
	@no_id INT,
	@mov_despachante VARCHAR(20),
	@mov_solicitante VARCHAR(20),
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
	@usuario_log VARCHAR(20)
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
