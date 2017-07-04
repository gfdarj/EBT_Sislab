CREATE TABLE [dbo].[SCE_Documentacao] (
    [DOC_ID]            INT            NOT NULL,
    [DOC_RESPONSAVEL]   VARCHAR (50)   NULL,
    [DOC_DATADOCUMENTO] VARCHAR (50)   NULL,
    [DOC_OBSERVACAO]    VARCHAR (1000) NULL,
    [DOC_NOME]          VARCHAR (50)   NULL,
    [DOC_IDE]           VARCHAR (50)   NULL,
    [DOC_EMPRESA]       VARCHAR (50)   NULL,
    [DOC_FONE]          VARCHAR (50)   NULL,
    [DOC_MAIL]          VARCHAR (50)   NULL,
    [ENF_ID]            INT            NULL,
    CONSTRAINT [PK_SCE_Documentacao] PRIMARY KEY NONCLUSTERED ([DOC_ID] ASC) WITH (FILLFACTOR = 90),
    CONSTRAINT [FK_SCE_Documentacao_ENF_ID] FOREIGN KEY ([ENF_ID]) REFERENCES [dbo].[SCE_Empresa_Nota_Fiscal] ([ENF_ID])
);


GO
ALTER TABLE [dbo].[SCE_Documentacao] NOCHECK CONSTRAINT [FK_SCE_Documentacao_ENF_ID];

