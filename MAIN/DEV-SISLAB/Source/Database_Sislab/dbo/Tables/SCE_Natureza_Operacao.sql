CREATE TABLE [dbo].[SCE_Natureza_Operacao] (
    [NO_DESCRICAO] VARCHAR (100) NOT NULL,
    [NO_ID]        INT           IDENTITY (1, 1) NOT NULL,
    [NO_TIPO]      TINYINT       NULL,
    [CDE]          BIT           CONSTRAINT [DF_SCE_Natureza_Operacao_CDE] DEFAULT ((0)) NOT NULL,
    [DEFEITO]      BIT           CONSTRAINT [DF_SCE_Natureza_Operacao_DEFEITO] DEFAULT ((0)) NOT NULL,
    [PRAZO]        BIT           CONSTRAINT [DF_SCE_Natureza_Operacao_PRAZO] DEFAULT ((0)) NOT NULL,
    [ASA]          BIT           CONSTRAINT [DF_SCE_Natureza_Operacao_ASA] DEFAULT ((0)) NOT NULL,
    CONSTRAINT [PK_SCE_Natureza_Operacao] PRIMARY KEY NONCLUSTERED ([NO_ID] ASC) WITH (FILLFACTOR = 90)
);

