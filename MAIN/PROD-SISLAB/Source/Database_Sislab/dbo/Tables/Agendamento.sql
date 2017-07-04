CREATE TABLE [dbo].[Agendamento] (
    [AG_NUMERO]                SMALLINT       IDENTITY (1, 1) NOT NULL,
    [TA_ID]                    SMALLINT       NULL,
    [AT_ID]                    SMALLINT       NULL,
    [AG_DATASOLICITACAO]       SMALLDATETIME  NULL,
    [AG_DATAINICIO]            SMALLDATETIME  NULL,
    [AG_DATATERMINO]           SMALLDATETIME  NULL,
    [AG_RESPONSAVEL]           VARCHAR (20)   NULL,
    [AG_RAT]                   VARCHAR (20)   NULL,
    [AG_SIGILO]                TINYINT        CONSTRAINT [DF_Agendamento_AG_SIGILO] DEFAULT ((0)) NOT NULL,
    [AG_FLAGREMARCACAO]        BIT            CONSTRAINT [DF_Agendamento_AG_FLAGREMARCACAO] DEFAULT ((0)) NOT NULL,
    [AG_OBJETIVO]              TEXT           NULL,
    [AG_MOTIVO]                VARCHAR (7000) NULL,
    [AG_USERNAME]              VARCHAR (200)  NULL,
    [AG_RECEBEMAIL]            BIT            CONSTRAINT [DF_Agendamento_AG_RECEBEMAIL] DEFAULT ((0)) NOT NULL,
    [AG_ORGAO]                 VARCHAR (200)  NULL,
    [AG_CLIENTEEXTERNO]        VARCHAR (2000) NULL,
    [AG_RETIFICACAO]           TEXT           NULL,
    [AG_RELAT_RAT]             TEXT           NULL,
    [AG_RELAT_RT]              TEXT           NULL,
    [AG_REPETIDO]              BIT            CONSTRAINT [DF_Agendamento_AG_REPETIDO] DEFAULT ((0)) NOT NULL,
    [AG_AMBIENTE]              TEXT           NULL,
    [AG_RECURSOS]              TEXT           NULL,
    [AG_OBSERVACAO]            TEXT           NULL,
    [AG_NECESSITA_OS]          BIT            NULL,
    [AG_EXECUTANTE]            BIT            DEFAULT ((0)) NOT NULL,
    [AG_RETORNOCLIENTE]        MONEY          NULL,
    [AG_PLANODEMETAS]          INT            NULL,
    [TEC_ID]                   INT            NULL,
    [AG_SOLICITOUCANCELAMENTO] BIT            DEFAULT ((0)) NOT NULL,
    [AG_TITULO]                VARCHAR (50)   NULL,
    [AG_VALORCONTRATOCLIENTE]  MONEY          NULL,
    [AG_PRIORIDADE]            TINYINT        NULL,
    CONSTRAINT [PK__Agendamento__1367E606] PRIMARY KEY CLUSTERED ([AG_NUMERO] ASC) WITH (FILLFACTOR = 90),
    CONSTRAINT [FK_Agendamento_Tecnologia] FOREIGN KEY ([TEC_ID]) REFERENCES [dbo].[TECNOLOGIA] ([TEC_ID])
);


GO
ALTER TABLE [dbo].[Agendamento] NOCHECK CONSTRAINT [FK_Agendamento_Tecnologia];


GO
CREATE TRIGGER [dbo].[tr_U_AGENDAMENTO] ON [dbo].[Agendamento]
FOR UPDATE
AS
BEGIN
	/*** Criado em 298/03/2004 ***/

	/***
		altero as datas da reserva de ambientes de acordo com as datas 
		de início e término da AS
	***/
	IF UPDATE(AG_DATAINICIO) BEGIN
		UPDATE Reserva_Ambientes SET RAM_DataInicio = Inserted.AG_DATAINICIO
		FROM Reserva_Ambientes INNER JOIN Inserted ON Reserva_Ambientes.RAM_AS = Inserted.AG_NUMERO
	END

	IF UPDATE(AG_DATATERMINO) BEGIN
		UPDATE Reserva_Ambientes SET RAM_DataFim = Inserted.AG_DATATERMINO
		FROM Reserva_Ambientes INNER JOIN Inserted ON Reserva_Ambientes.RAM_AS = Inserted.AG_NUMERO
	END
	/***/
END

GO
DISABLE TRIGGER [dbo].[tr_U_AGENDAMENTO]
    ON [dbo].[Agendamento];


GO
CREATE TRIGGER [dbo].[tr_Agendamento_Responsavel_Reserva]
   ON [dbo].[Agendamento] AFTER UPDATE
AS 
BEGIN
	SET NOCOUNT ON

	/* Atualiza o responsável se houver mudança no agendamento */
	UPDATE SCE_Reserva
	SET RES_RESPONSAVEL = a.AG_RESPONSAVEL
	FROM SCE_Reserva R INNER JOIN 
		Agendamento A ON R.AG_NUMERO = A.AG_NUMERO INNER JOIN
		Inserted I ON I.AG_NUMERO = A.AG_NUMERO

	/* Atualiza o responsável na reserva de ambiente */
	UPDATE Reserva_ambientes
	SET RAM_RESPONSAVEL = a.AG_RESPONSAVEL
	FROM Reserva_ambientes R INNER JOIN 
		Agendamento A ON R.RAM_AS = A.AG_NUMERO INNER JOIN
		Inserted I ON I.AG_NUMERO = A.AG_NUMERO
	WHERE r.RAM_RESPONSAVEL <> a.AG_RESPONSAVEL
END

GO
DISABLE TRIGGER [dbo].[tr_Agendamento_Responsavel_Reserva]
    ON [dbo].[Agendamento];

