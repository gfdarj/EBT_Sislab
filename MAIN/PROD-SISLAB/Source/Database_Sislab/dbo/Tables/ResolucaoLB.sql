CREATE TABLE [dbo].[ResolucaoLB] (
    [R_ID]     SMALLINT      IDENTITY (1, 1) NOT NULL,
    [LB_ID]    SMALLINT      NOT NULL,
    [R_NOME]   VARCHAR (200) NULL,
    [R_NUMERO] SMALLINT      NULL,
    CONSTRAINT [FK_ResolucaoLB_LB_LogBook] FOREIGN KEY ([LB_ID]) REFERENCES [dbo].[LB_LogBook] ([LB_ID])
);


GO
ALTER TABLE [dbo].[ResolucaoLB] NOCHECK CONSTRAINT [FK_ResolucaoLB_LB_LogBook];

