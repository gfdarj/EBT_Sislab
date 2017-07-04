CREATE TABLE [dbo].[SCE_Modelos] (
    [COD_SGP]       CHAR (50)     NULL,
    [MOD_ID]        INT           IDENTITY (1, 1) NOT NULL,
    [MOD_CODNOME]   VARCHAR (255) NULL,
    [MOD_NET]       VARCHAR (255) NULL,
    [MOD_OBS]       TEXT          NULL,
    [TIPO_ID]       INT           NULL,
    [FAB_ID]        INT           NULL,
    [sgp]           INT           NULL,
    [mod_descricao] VARCHAR (255) NULL,
    CONSTRAINT [PK_SCE_Modelos] PRIMARY KEY NONCLUSTERED ([MOD_ID] ASC) WITH (FILLFACTOR = 90),
    CONSTRAINT [FK_SCE_MODELOS_FAB_ID] FOREIGN KEY ([FAB_ID]) REFERENCES [dbo].[SCE_Fabricantes] ([fab_id])
);


GO
ALTER TABLE [dbo].[SCE_Modelos] NOCHECK CONSTRAINT [FK_SCE_MODELOS_FAB_ID];


GO
CREATE NONCLUSTERED INDEX [IX_FK_SCE_Modelos_FAB_ID]
    ON [dbo].[SCE_Modelos]([FAB_ID] ASC) WITH (FILLFACTOR = 90);


GO
CREATE NONCLUSTERED INDEX [IX_MOD_CODNOME]
    ON [dbo].[SCE_Modelos]([MOD_CODNOME] ASC) WITH (FILLFACTOR = 90);


GO
CREATE NONCLUSTERED INDEX [IX_MOD_DESCRICAO]
    ON [dbo].[SCE_Modelos]([mod_descricao] ASC) WITH (FILLFACTOR = 90);

