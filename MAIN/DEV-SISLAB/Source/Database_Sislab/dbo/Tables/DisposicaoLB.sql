CREATE TABLE [dbo].[DisposicaoLB] (
    [D_ID]            SMALLINT      IDENTITY (1, 1) NOT NULL,
    [LB_ID]           SMALLINT      NULL,
    [D_DISPOSICAO]    VARCHAR (200) NULL,
    [D_EXECUTANTE]    VARCHAR (200) NULL,
    [D_PRAZO]         SMALLDATETIME NULL,
    [D_DATACONCLUSAO] SMALLDATETIME NULL,
    [D_EFICACIA]      TINYINT       NULL,
    CONSTRAINT [FK_DisposicaoLB_LB_LogBook] FOREIGN KEY ([LB_ID]) REFERENCES [dbo].[LB_LogBook] ([LB_ID])
);


GO
ALTER TABLE [dbo].[DisposicaoLB] NOCHECK CONSTRAINT [FK_DisposicaoLB_LB_LogBook];

