CREATE TABLE [dbo].[Ambientes] (
    [AMB_ID]         INT          IDENTITY (1, 1) NOT NULL,
    [AMB_NOME]       VARCHAR (50) NULL,
    [AMB_USADOPORAG] BIT          DEFAULT ((0)) NOT NULL,
    CONSTRAINT [PK_Ambientes] PRIMARY KEY NONCLUSTERED ([AMB_ID] ASC) WITH (FILLFACTOR = 90)
);

