CREATE TABLE [dbo].[SCE_Fabricantes] (
    [fab_id]   INT          IDENTITY (1, 1) NOT NULL,
    [fab_nome] VARCHAR (50) NULL,
    CONSTRAINT [PK_SCE_Fabricantes] PRIMARY KEY NONCLUSTERED ([fab_id] ASC) WITH (FILLFACTOR = 90)
);

