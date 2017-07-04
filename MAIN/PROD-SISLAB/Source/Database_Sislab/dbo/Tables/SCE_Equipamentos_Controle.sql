CREATE TABLE [dbo].[SCE_Equipamentos_Controle] (
    [EQC_ID]          INT          IDENTITY (1, 1) NOT NULL,
    [EQ_ID]           INT          NOT NULL,
    [EQC_DIAS]        INT          NULL,
    [EQC_DATA]        DATETIME     CONSTRAINT [DF_SCE_Equipamentos_Controle_EQC_DATA] DEFAULT (getdate()) NOT NULL,
    [EQC_REGISTRO]    VARCHAR (50) NULL,
    [EQC_RESPONSAVEL] VARCHAR (50) NULL,
    [EQC_TIPO]        CHAR (1)     CONSTRAINT [DF_SCE_Equipamentos_Controle_EQC_TIPO] DEFAULT ('C') NOT NULL,
    CONSTRAINT [PK_SCE_Equipamentos_Controle] PRIMARY KEY CLUSTERED ([EQC_ID] ASC) WITH (FILLFACTOR = 90),
    CONSTRAINT [FK_SCE_Equipamentos_Controle_EQ_ID] FOREIGN KEY ([EQ_ID]) REFERENCES [dbo].[SCE_Equipamentos] ([EQ_ID])
);


GO
ALTER TABLE [dbo].[SCE_Equipamentos_Controle] NOCHECK CONSTRAINT [FK_SCE_Equipamentos_Controle_EQ_ID];

