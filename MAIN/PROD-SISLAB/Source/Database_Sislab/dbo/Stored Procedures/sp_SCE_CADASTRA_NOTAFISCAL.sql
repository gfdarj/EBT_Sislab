CREATE PROCEDURE [dbo].[sp_SCE_CADASTRA_NOTAFISCAL]
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
	@user_id VARCHAR(20)
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
