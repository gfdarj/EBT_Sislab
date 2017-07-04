CREATE TABLE [dbo].[SCE_AreaUtilizacao] (
    [COD_SGP]        INT          NULL,
    [AU_ID]          INT          IDENTITY (1, 1) NOT NULL,
    [AU_DESCRICAO]   VARCHAR (50) NULL,
    [AU_CODAREAUTIL] VARCHAR (5)  NULL,
    CONSTRAINT [PK_SCE_AreaUtilizacao] PRIMARY KEY NONCLUSTERED ([AU_ID] ASC) WITH (FILLFACTOR = 90)
);

