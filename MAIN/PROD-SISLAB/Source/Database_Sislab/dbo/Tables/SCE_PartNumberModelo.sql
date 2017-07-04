CREATE TABLE [dbo].[SCE_PartNumberModelo] (
    [MOD_ID]        INT          NOT NULL,
    [PN_PARTNUMBER] VARCHAR (50) NOT NULL,
    [id]            INT          IDENTITY (1, 1) NOT NULL,
    CONSTRAINT [PK_SCE_PartNumberModelo] PRIMARY KEY NONCLUSTERED ([id] ASC) WITH (FILLFACTOR = 90),
    CONSTRAINT [FK_SCE_PartNumberModelo_SCE_Modelos] FOREIGN KEY ([MOD_ID]) REFERENCES [dbo].[SCE_Modelos] ([MOD_ID])
);


GO
ALTER TABLE [dbo].[SCE_PartNumberModelo] NOCHECK CONSTRAINT [FK_SCE_PartNumberModelo_SCE_Modelos];

