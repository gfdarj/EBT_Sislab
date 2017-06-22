CREATE TABLE [dbo].[SCE_Historico] (
    [id]         INT          IDENTITY (1, 1) NOT NULL,
    [id_usuario] VARCHAR (20) NULL,
    [acao]       TEXT         NULL,
    [data]       VARCHAR (50) NULL,
    [MODULO]     VARCHAR (20) NULL,
    CONSTRAINT [PK_SCE_Historico] PRIMARY KEY NONCLUSTERED ([id] ASC) WITH (FILLFACTOR = 90)
);

