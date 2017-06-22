CREATE TABLE [dbo].[Participantes_Externos] (
    [PE_ID]          SMALLINT      IDENTITY (1, 1) NOT NULL,
    [PE_NOME]        VARCHAR (50)  NULL,
    [AG_NUMERO]      SMALLINT      NULL,
    [PE_EMPRESA]     VARCHAR (50)  NULL,
    [PE_MOTIVO]      VARCHAR (200) NULL,
    [PE_USERNAME]    VARCHAR (20)  NULL,
    [PE_QUEMINCLUIU] CHAR (3)      DEFAULT ('CLI') NULL,
    CONSTRAINT [PK__Participantes_Ex__5070F446] PRIMARY KEY CLUSTERED ([PE_ID] ASC) WITH (FILLFACTOR = 90),
    CONSTRAINT [FK__Participa__AG_NU__1DB06A4F] FOREIGN KEY ([AG_NUMERO]) REFERENCES [dbo].[Agendamento] ([AG_NUMERO])
);


GO
ALTER TABLE [dbo].[Participantes_Externos] NOCHECK CONSTRAINT [FK__Participa__AG_NU__1DB06A4F];

