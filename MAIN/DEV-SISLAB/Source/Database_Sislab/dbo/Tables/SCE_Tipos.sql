CREATE TABLE [dbo].[SCE_Tipos] (
    [TIPO_ID]        INT           IDENTITY (1, 1) NOT NULL,
    [TIPO_APELIDO]   VARCHAR (50)  NULL,
    [TIPO_SUPERTIPO] INT           NULL,
    [TIPO_DESCRICAO] VARCHAR (100) NULL,
    [COD_SGP]        CHAR (10)     NULL,
    [SGP]            INT           NULL,
    CONSTRAINT [PK_SCE_Tipos] PRIMARY KEY NONCLUSTERED ([TIPO_ID] ASC) WITH (FILLFACTOR = 90)
);

