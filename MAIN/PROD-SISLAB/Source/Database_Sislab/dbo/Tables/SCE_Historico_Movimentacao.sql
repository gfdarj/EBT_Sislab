CREATE TABLE [dbo].[SCE_Historico_Movimentacao] (
    [ID]             INT          IDENTITY (1, 1) NOT NULL,
    [MOV_ID]         INT          NULL,
    [DATA_OLD]       VARCHAR (50) NULL,
    [USUARIO]        VARCHAR (50) NULL,
    [TEXTO]          VARCHAR (50) NULL,
    [no_id]          INT          NULL,
    [tipo_id]        INT          NULL,
    [eq_id]          INT          NULL,
    [DATA_OLD_COPIA] VARCHAR (50) NULL,
    [DATA]           DATETIME     CONSTRAINT [DF_SCE_Historico_Movimentacao_DATA] DEFAULT (getdate()) NULL,
    CONSTRAINT [PK_SCE_Historico_Movimentacao] PRIMARY KEY NONCLUSTERED ([ID] ASC) WITH (FILLFACTOR = 90)
);

