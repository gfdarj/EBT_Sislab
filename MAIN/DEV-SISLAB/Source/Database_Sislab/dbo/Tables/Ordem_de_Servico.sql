CREATE TABLE [dbo].[Ordem_de_Servico] (
    [OS_ID]             SMALLINT      NOT NULL,
    [OS_RESPONSAVEL]    VARCHAR (20)  NULL,
    [AG_NUMERO]         SMALLINT      NOT NULL,
    [OS_FLAGREPETICAO]  TINYINT       NULL,
    [OS_TECNICOEXTERNO] VARCHAR (255) NULL,
    [OS_OBSERVACOES]    VARCHAR (510) NULL,
    [T_ID]              SMALLINT      NULL,
    [S_ID_SERVICO]      SMALLINT      NULL,
    [S_ID_PLATAFORMA]   SMALLINT      NULL,
    [EQ_ID_AMOSTRA]     INT           NULL,
    PRIMARY KEY CLUSTERED ([OS_ID] ASC, [AG_NUMERO] ASC) WITH (FILLFACTOR = 90),
    CONSTRAINT [FK_Ordem_de_Servico_Agendamento] FOREIGN KEY ([AG_NUMERO]) REFERENCES [dbo].[Agendamento] ([AG_NUMERO]),
    CONSTRAINT [FK_Ordem_de_Servico_SCE_Equipamentos] FOREIGN KEY ([EQ_ID_AMOSTRA]) REFERENCES [dbo].[SCE_Equipamentos] ([EQ_ID]) NOT FOR REPLICATION,
    CONSTRAINT [FK_Ordem_de_Servico_Servicos_Plataformas_Plataforma] FOREIGN KEY ([S_ID_PLATAFORMA]) REFERENCES [dbo].[Servicos_Plataformas] ([S_ID]) NOT FOR REPLICATION,
    CONSTRAINT [FK_Ordem_de_Servico_Servicos_Plataformas_Servico] FOREIGN KEY ([S_ID_SERVICO]) REFERENCES [dbo].[Servicos_Plataformas] ([S_ID]) NOT FOR REPLICATION,
    CONSTRAINT [FK_Ordem_de_Servico_Testes] FOREIGN KEY ([T_ID]) REFERENCES [dbo].[TESTES] ([T_ID]) NOT FOR REPLICATION,
    CONSTRAINT [FK_Ordem_de_Servico_UserCRT] FOREIGN KEY ([OS_RESPONSAVEL]) REFERENCES [dbo].[UserCRT] ([USERID])
);


GO
ALTER TABLE [dbo].[Ordem_de_Servico] NOCHECK CONSTRAINT [FK_Ordem_de_Servico_Agendamento];


GO
ALTER TABLE [dbo].[Ordem_de_Servico] NOCHECK CONSTRAINT [FK_Ordem_de_Servico_SCE_Equipamentos];


GO
ALTER TABLE [dbo].[Ordem_de_Servico] NOCHECK CONSTRAINT [FK_Ordem_de_Servico_Servicos_Plataformas_Plataforma];


GO
ALTER TABLE [dbo].[Ordem_de_Servico] NOCHECK CONSTRAINT [FK_Ordem_de_Servico_Servicos_Plataformas_Servico];


GO
ALTER TABLE [dbo].[Ordem_de_Servico] NOCHECK CONSTRAINT [FK_Ordem_de_Servico_Testes];


GO
ALTER TABLE [dbo].[Ordem_de_Servico] NOCHECK CONSTRAINT [FK_Ordem_de_Servico_UserCRT];

