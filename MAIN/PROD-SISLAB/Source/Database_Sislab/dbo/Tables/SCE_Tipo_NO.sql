CREATE TABLE [dbo].[SCE_Tipo_NO] (
    [id]      INT IDENTITY (1, 1) NOT NULL,
    [no_id]   INT NULL,
    [tipo_id] INT NULL,
    CONSTRAINT [PK_SCE_Tipo_NO] PRIMARY KEY NONCLUSTERED ([id] ASC) WITH (FILLFACTOR = 90)
);

