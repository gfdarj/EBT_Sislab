CREATE TABLE [dbo].[TESTES] (
    [T_ID]               SMALLINT       IDENTITY (1, 1) NOT NULL,
    [T_TITULO]           VARCHAR (200)  NULL,
    [T_DESCRICAO]        VARCHAR (7000) NULL,
    [T_DISPONIVEL]       BIT            NULL,
    [T_TIPO]             SMALLINT       NULL,
    [T_OBSERVACAO]       VARCHAR (200)  NULL,
    [TIT_ID]             INT            DEFAULT ((1)) NOT NULL,
    [T_PERIODOREPETICAO] SMALLINT       DEFAULT ((0)) NOT NULL,
    CONSTRAINT [PK_TESTES] PRIMARY KEY CLUSTERED ([T_ID] ASC) WITH (FILLFACTOR = 90),
    CONSTRAINT [FK_Testes_Tipo_Teste] FOREIGN KEY ([TIT_ID]) REFERENCES [dbo].[Tipo_Teste] ([TIT_ID])
);


GO
ALTER TABLE [dbo].[TESTES] NOCHECK CONSTRAINT [FK_Testes_Tipo_Teste];

