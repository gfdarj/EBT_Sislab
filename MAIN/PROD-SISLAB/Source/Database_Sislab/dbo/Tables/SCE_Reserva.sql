CREATE TABLE [dbo].[SCE_Reserva] (
    [AG_NUMERO]        SMALLINT     NOT NULL,
    [RES_DATACADASTRO] DATETIME     CONSTRAINT [DF_SCE_Reserva_RES_DATACADASTRO] DEFAULT (getdate()) NOT NULL,
    [RES_RESPONSAVEL]  VARCHAR (20) NOT NULL,
    [AMB_ID]           INT          NULL,
    [RES_OBSERVACAO]   TEXT         NULL,
    CONSTRAINT [PK_SCE_Reserva] PRIMARY KEY NONCLUSTERED ([AG_NUMERO] ASC) WITH (FILLFACTOR = 90),
    CONSTRAINT [FK_SCE_Reserva_Agendamento] FOREIGN KEY ([AG_NUMERO]) REFERENCES [dbo].[Agendamento] ([AG_NUMERO]),
    CONSTRAINT [FK_SCE_Reserva_Ambientes] FOREIGN KEY ([AMB_ID]) REFERENCES [dbo].[Ambientes] ([AMB_ID]),
    CONSTRAINT [FK_SCE_Reserva_UserCRT] FOREIGN KEY ([RES_RESPONSAVEL]) REFERENCES [dbo].[UserCRT] ([USERID])
);


GO
ALTER TABLE [dbo].[SCE_Reserva] NOCHECK CONSTRAINT [FK_SCE_Reserva_Agendamento];


GO
ALTER TABLE [dbo].[SCE_Reserva] NOCHECK CONSTRAINT [FK_SCE_Reserva_Ambientes];


GO
ALTER TABLE [dbo].[SCE_Reserva] NOCHECK CONSTRAINT [FK_SCE_Reserva_UserCRT];


GO
CREATE TRIGGER [dbo].[tr_SCE_Reserva_Responsavel]
   ON  [dbo].[SCE_Reserva] AFTER INSERT, UPDATE
AS 
BEGIN
	SET NOCOUNT ON

	/* Atualiza o responsável se houver mudança no agendamento */
	UPDATE SCE_Reserva
	SET RES_RESPONSAVEL = a.AG_RESPONSAVEL
	FROM SCE_Reserva R INNER JOIN 
		Agendamento A ON R.AG_NUMERO = A.AG_NUMERO INNER JOIN
		Inserted I ON I.AG_NUMERO = A.AG_NUMERO
	WHERE r.RES_RESPONSAVEL <> a.AG_RESPONSAVEL
END

GO
DISABLE TRIGGER [dbo].[tr_SCE_Reserva_Responsavel]
    ON [dbo].[SCE_Reserva];

