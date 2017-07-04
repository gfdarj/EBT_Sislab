CREATE TABLE [dbo].[Mensagem] (
    [CodMensagem]   INT           IDENTITY (1, 1) NOT NULL,
    [DeMensagem]    VARCHAR (100) NOT NULL,
    [TextoMensagem] TEXT          NULL,
    PRIMARY KEY CLUSTERED ([CodMensagem] ASC) WITH (FILLFACTOR = 90)
);

