CREATE TABLE [dbo].[SCE_Movimentacao] (
    [MOV_ID]          INT          IDENTITY (1, 1) NOT NULL,
    [EQ_ID]           INT          NOT NULL,
    [NO_ID]           INT          NOT NULL,
    [MOV_DESPACHANTE] VARCHAR (50) NULL,
    [MOV_SOLICITANTE] VARCHAR (50) NULL,
    [TIPO]            INT          NULL,
    [CDE]             VARCHAR (50) NULL,
    [ASA]             VARCHAR (50) NULL,
    [RESERVA]         INT          NULL,
    [SAIDA]           INT          NULL,
    [NF_ID]           INT          NULL,
    [EXCLUIDA]        CHAR (1)     NULL,
    [DOC_ID]          INT          NULL,
    [MOV_DATA]        DATETIME     CONSTRAINT [DF_SCE_Movimentacao_MOV_DATA] DEFAULT (getdate()) NOT NULL,
    [MOV_PASSAGEM]    BIT          DEFAULT ((0)) NOT NULL,
    [FL_CALIBRACAO]   TINYINT      NULL,
    CONSTRAINT [PK_SCE_Movimentacao] PRIMARY KEY NONCLUSTERED ([MOV_ID] ASC) WITH (FILLFACTOR = 90),
    CONSTRAINT [FK_SCE_Movimentacao_SCE_Documentacao] FOREIGN KEY ([DOC_ID]) REFERENCES [dbo].[SCE_Documentacao] ([DOC_ID]),
    CONSTRAINT [FK_SCE_Movimentacao_SCE_Equipamentos] FOREIGN KEY ([EQ_ID]) REFERENCES [dbo].[SCE_Equipamentos] ([EQ_ID]),
    CONSTRAINT [FK_SCE_Movimentacao_SCE_Natureza_Operacao] FOREIGN KEY ([NO_ID]) REFERENCES [dbo].[SCE_Natureza_Operacao] ([NO_ID]),
    CONSTRAINT [FK_SCE_Movimentacao_SCE_Nota_Fiscal] FOREIGN KEY ([NF_ID]) REFERENCES [dbo].[SCE_Nota_Fiscal] ([NF_ID])
);


GO
ALTER TABLE [dbo].[SCE_Movimentacao] NOCHECK CONSTRAINT [FK_SCE_Movimentacao_SCE_Documentacao];


GO
ALTER TABLE [dbo].[SCE_Movimentacao] NOCHECK CONSTRAINT [FK_SCE_Movimentacao_SCE_Equipamentos];


GO
ALTER TABLE [dbo].[SCE_Movimentacao] NOCHECK CONSTRAINT [FK_SCE_Movimentacao_SCE_Natureza_Operacao];


GO
ALTER TABLE [dbo].[SCE_Movimentacao] NOCHECK CONSTRAINT [FK_SCE_Movimentacao_SCE_Nota_Fiscal];


GO
CREATE NONCLUSTERED INDEX [IX_FK_SCE_Movimentacao_EQ_ID]
    ON [dbo].[SCE_Movimentacao]([EQ_ID] ASC) WITH (FILLFACTOR = 90);


GO
CREATE NONCLUSTERED INDEX [IX_FK_SCE_Movimentacao_NF_ID]
    ON [dbo].[SCE_Movimentacao]([NF_ID] ASC) WITH (FILLFACTOR = 90);


GO
CREATE NONCLUSTERED INDEX [IX_FK_SCE_Movimentacao_NO_ID]
    ON [dbo].[SCE_Movimentacao]([NO_ID] ASC) WITH (FILLFACTOR = 90);


GO
CREATE TRIGGER [dbo].[TRG_IU_SCE_MOVIMENTACAO_TIPO] ON [dbo].[SCE_Movimentacao]
FOR INSERT,UPDATE
AS
BEGIN
	--
	-- Ao se atualizar o "TIPO" de movimentação (1 - entrada, 2 - Saída do LOG,
	-- equipamentos devem ser atualizados para status correspondentes
	--
	IF UPDATE( NO_ID )
	BEGIN
		DECLARE @tipo INT, @status_eq INT, @mov_id INT, @eq_id INT
		DECLARE @mov_data DATETIME, @ultima_mov DATETIME

		-- data da movimentacao
		SELECT @mov_data = MOV_DATA, @mov_id = MOV_ID, @eq_id = EQ_ID FROM Inserted

		-- pego a data da ultima movimentacao do item
		SELECT @ultima_mov = MAX( m.MOV_DATA ) FROM SCE_Movimentacao m 
			WHERE m.EQ_ID = @eq_id AND m.MOV_ID <> @mov_id

		-- Se esta movimentacao for a de maior data (ultima) entao atualizo
		-- o STATUS do equipamento movimentado, caso contrário o equipamento continua
		-- com o STATUS da ultima movimentacao no banco.
		IF (@mov_data >= @ultima_mov) OR (@ultima_mov IS NULL) BEGIN
			-- pego o tipo de movimento desta ultima movimentacao
			SELECT @tipo = n.NO_TIPO FROM Inserted m 
				INNER JOIN SCE_Natureza_Operacao n ON m.NO_ID = n.NO_ID

			-- maquina de estados - tipo de movimentacao / estado do equipamento
			IF @tipo = 1 OR @tipo = 2
				SET @status_eq = 1 -- em estoque
			ELSE IF @tipo = 3
				SET @status_eq = 3 -- expedicao
			ELSE
				SET @status_eq = 2 -- em uso

			IF (@status_eq = 2) OR (@status_eq = 3)  -- se for expedicao e saída p/ uso no Lab. entao limpo o campo de LOCALIZACAO do equipamento
			BEGIN
				UPDATE SCE_Equipamentos SET STATUS = @status_eq, EQ_LOCALIZACAO = NULL
					FROM SCE_EQUIPAMENTOS, INSERTED
					WHERE SCE_EQUIPAMENTOS.EQ_ID = INSERTED.EQ_ID
				IF @@ERROR <> 0 BEGIN
					ROLLBACK TRANSACTION
					RAISERROR( 'Não foi possível atualizar o status do equipamento.', 16, 1 )
				END
			END
			ELSE BEGIN
				UPDATE SCE_Equipamentos SET STATUS = @status_eq
					FROM SCE_EQUIPAMENTOS, INSERTED
					WHERE SCE_EQUIPAMENTOS.EQ_ID = INSERTED.EQ_ID
				IF @@ERROR <> 0 BEGIN
					ROLLBACK TRANSACTION
					RAISERROR( 'Não foi possível atualizar o status do equipamento.', 16, 1 )
				END
			END	
		END
	END
END

GO
DISABLE TRIGGER [dbo].[TRG_IU_SCE_MOVIMENTACAO_TIPO]
    ON [dbo].[SCE_Movimentacao];


GO
CREATE TRIGGER [dbo].[tr_D_SCE_Movimentacao] ON [dbo].[SCE_Movimentacao] 
FOR DELETE 
AS
BEGIN
	/***
		Verifica o status do equipamento cuja movimentacao esta sendo excluida.
		Caso seja a ultima movimentacao, o status do equipamento passa a ser o da
		movimentacao anterior

		Gilberto Almeida - COPPETEC
		Data da Criacao: 12/12/2003	Ultima Alteracao:
	***/
	DECLARE @mov_id INT, @eq_id INT, @no_id INT
	DECLARE @tipo INT, @status_eq INT, @mov_data DATETIME, @ultima_mov DATETIME

	SELECT @mov_id = MOV_ID, @eq_id = EQ_ID, @mov_data = MOV_DATA FROM Deleted

	SELECT TOP 1 @ultima_mov = MOV_DATA FROM SCE_Movimentacao m 
		WHERE m.EQ_ID = @eq_id
		ORDER BY m.MOV_DATA DESC

	-- é a ultima movimentacao, entao tenho que atualizar o equipamento para o status
	-- da movimentacao anterior
	IF @mov_data >= @ultima_mov BEGIN
		-- pego a natureza da movimentacao anterior
		SELECT TOP 1 @no_id = NO_ID FROM SCE_Movimentacao
			WHERE EQ_ID = @eq_id AND MOV_ID <> @mov_id
			ORDER BY MOV_DATA DESC

		-- nao tem mais movimento do item, entao passo para cadastrado
		IF @no_id IS NULL BEGIN
			SET @status_eq = 0
		END
		ELSE BEGIN
			-- pego o tipo da natureza de operacao
			SELECT @tipo = NO_TIPO FROM SCE_Natureza_Operacao WHERE NO_ID = @no_id

			-- maquina de estados - tipo de movimentacao / estado do equipamento
			IF @tipo = 1 OR @tipo = 2
				SET @status_eq = 1 -- em estoque
			ELSE IF @tipo = 3
				SET @status_eq = 3 -- expedicao
			ELSE
				SET @status_eq = 2 -- em uso
		END

		IF @status_eq = 3  BEGIN -- se for expedicao entao limpo o campo de LOCALIZACAO do equipamento
			UPDATE SCE_Equipamentos SET STATUS = @status_eq, EQ_LOCALIZACAO = NULL WHERE EQ_ID = @eq_id
			IF @@ERROR <> 0 BEGIN
				ROLLBACK TRANSACTION
				RAISERROR( 'Não foi possível atualizar o status do equipamento.', 16, 1 )
			END
		END
		ELSE BEGIN
			UPDATE SCE_Equipamentos SET STATUS = @status_eq WHERE EQ_ID = @eq_id
			IF @@ERROR <> 0 BEGIN
				ROLLBACK TRANSACTION
				RAISERROR( 'Não foi possível atualizar o status do equipamento.', 16, 1 )
			END
		END
	END
END

GO
DISABLE TRIGGER [dbo].[tr_D_SCE_Movimentacao]
    ON [dbo].[SCE_Movimentacao];

