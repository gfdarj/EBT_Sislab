CREATE TABLE [dbo].[SCE_AreasUtil_Modelo] (
    [AU_ID]  INT NOT NULL,
    [MOD_ID] INT NOT NULL,
    [id]     INT IDENTITY (1, 1) NOT NULL,
    CONSTRAINT [PK_SCE_AreasUtil_Modelo] PRIMARY KEY NONCLUSTERED ([id] ASC) WITH (FILLFACTOR = 90),
    CONSTRAINT [FK_SCE_AreasUtil_Modelo_SCE_AreaUtilizacao] FOREIGN KEY ([AU_ID]) REFERENCES [dbo].[SCE_AreaUtilizacao] ([AU_ID]),
    CONSTRAINT [FK_SCE_AreasUtil_Modelo_SCE_Modelos] FOREIGN KEY ([MOD_ID]) REFERENCES [dbo].[SCE_Modelos] ([MOD_ID])
);


GO
ALTER TABLE [dbo].[SCE_AreasUtil_Modelo] NOCHECK CONSTRAINT [FK_SCE_AreasUtil_Modelo_SCE_AreaUtilizacao];


GO
ALTER TABLE [dbo].[SCE_AreasUtil_Modelo] NOCHECK CONSTRAINT [FK_SCE_AreasUtil_Modelo_SCE_Modelos];

