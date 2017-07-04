CREATE TABLE [dbo].[SCE_Acessorios] (
    [eq_id]      INT           NOT NULL,
    [sequencial] INT           CONSTRAINT [DF_SCE_Acessorios_sequencial] DEFAULT ((1)) NOT NULL,
    [descricao]  VARCHAR (255) NULL,
    [status]     INT           NULL,
    [conforme]   BIT           CONSTRAINT [DF_SCE_Acessorios_conforme] DEFAULT ((1)) NOT NULL,
    CONSTRAINT [PK_SCE_Acessorios] PRIMARY KEY NONCLUSTERED ([eq_id] ASC, [sequencial] ASC) WITH (FILLFACTOR = 90),
    CONSTRAINT [FK_SCE_Acessorios_SCE_Equipamentos] FOREIGN KEY ([eq_id]) REFERENCES [dbo].[SCE_Equipamentos] ([EQ_ID])
);


GO
ALTER TABLE [dbo].[SCE_Acessorios] NOCHECK CONSTRAINT [FK_SCE_Acessorios_SCE_Equipamentos];

