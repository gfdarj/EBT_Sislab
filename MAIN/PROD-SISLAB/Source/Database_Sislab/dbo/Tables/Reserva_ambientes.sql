CREATE TABLE [dbo].[Reserva_ambientes] (
    [RAM_ID]          INT            IDENTITY (1, 1) NOT NULL,
    [RAM_DataInicio]  SMALLDATETIME  NULL,
    [RAM_DataFim]     SMALLDATETIME  NULL,
    [RAM_Horario]     VARCHAR (90)   NULL,
    [RAM_Titulo]      VARCHAR (2000) NULL,
    [RAM_Descricao]   VARCHAR (3000) NULL,
    [AMB_ID]          INT            NULL,
    [RAM_Contato]     TEXT           NULL,
    [RAM_Responsavel] VARCHAR (20)   NULL,
    [RAM_AS]          SMALLINT       NULL,
    CONSTRAINT [PK_Reserva_ambientes] PRIMARY KEY NONCLUSTERED ([RAM_ID] ASC) WITH (FILLFACTOR = 90),
    CONSTRAINT [FK_Reserva_Ambientes_Agendamento] FOREIGN KEY ([RAM_AS]) REFERENCES [dbo].[Agendamento] ([AG_NUMERO]),
    CONSTRAINT [FK_Reserva_Ambientes_Ambientes] FOREIGN KEY ([AMB_ID]) REFERENCES [dbo].[Ambientes] ([AMB_ID])
);


GO
ALTER TABLE [dbo].[Reserva_ambientes] NOCHECK CONSTRAINT [FK_Reserva_Ambientes_Agendamento];


GO
ALTER TABLE [dbo].[Reserva_ambientes] NOCHECK CONSTRAINT [FK_Reserva_Ambientes_Ambientes];


GO
CREATE TRIGGER [dbo].[tr_Reserva_ambientes_Reserva_Equipamentos]
   ON [dbo].[Reserva_ambientes] AFTER INSERT, UPDATE
AS 
BEGIN
	SET NOCOUNT ON

	DECLARE @AMB_RES INT, @AMB_AS INT

	/* Verifica se existe apenas 1 ambiente tanto na reserva de itens quanto pelo agendamento se for apenas 1 ambiente entao muda automaticamente */
	SELECT @AMB_RES = COUNT(*)
	FROM SCE_reserva_equipamentos R INNER JOIN Inserted I ON R.AG_NUMERO = I.RAM_AS
	GROUP BY R.AMB_ID
	
	SELECT @AMB_AS = COUNT(*)
	FROM Reserva_ambientes R INNER JOIN Inserted I ON R.RAM_AS = I.RAM_AS
	GROUP BY R.AMB_ID

	IF (@AMB_RES = @AMB_AS) AND (@AMB_AS = 1)
	BEGIN
		UPDATE SCE_reserva_equipamentos
		SET AMB_ID = I.AMB_ID
		FROM SCE_reserva_equipamentos R 
			INNER JOIN Inserted I ON R.AG_NUMERO = I.RAM_AS
		WHERE R.AMB_ID <> I.AMB_ID
	END
END

GO
DISABLE TRIGGER [dbo].[tr_Reserva_ambientes_Reserva_Equipamentos]
    ON [dbo].[Reserva_ambientes];

