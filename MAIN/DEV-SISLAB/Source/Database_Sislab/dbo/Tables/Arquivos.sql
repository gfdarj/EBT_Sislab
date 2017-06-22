CREATE TABLE [dbo].[Arquivos] (
    [ARQ_CODARQ]               INT            IDENTITY (1, 1) NOT NULL,
    [ARQ_CODARQTIPO]           INT            NULL,
    [ARQ_LINK]                 NVARCHAR (400) NULL,
    [ARQ_NOMEARQ]              NVARCHAR (200) NULL,
    [ARQ_RESPONSAVEL]          NVARCHAR (20)  NULL,
    [ARQ_IDORGAO]              SMALLINT       NULL,
    [ARQ_OBSERVACAO]           NVARCHAR (510) NULL,
    [ARQ_VINCULACAO]           INT            NULL,
    [ARQ_VERSAO]               NVARCHAR (100) NULL,
    [ARQ_OCULTAR]              BIT            CONSTRAINT [DF_Arquivos_ARQ_OCULTAR] DEFAULT ((0)) NOT NULL,
    [ARQ_DATAATUALIZACAO]      SMALLDATETIME  NULL,
    [IPCADASTRO]               NVARCHAR (40)  NULL,
    [ARQ_DATAAPROVACAO]        SMALLDATETIME  NULL,
    [USERIDCADASTRO]           NVARCHAR (16)  NULL,
    [ARQ_DESCRICAO]            NVARCHAR (510) NULL,
    [ARQ_IDSITUACAO]           INT            NULL,
    [ARQ_OS]                   INT            CONSTRAINT [DF_Arquivos_ARQ_OS] DEFAULT (NULL) NULL,
    [ARQ_O1]                   INT            NULL,
    [ARQ_O2]                   INT            NULL,
    [ARQ_O3]                   INT            NULL,
    [ARQ_VALIDACAO]            SMALLINT       CONSTRAINT [DF_Arquivos_ARQ_VALIDACAO] DEFAULT ((0)) NULL,
    [ARQ_NOTIFICACAOEXPIRACAO] SMALLINT       CONSTRAINT [DF_Arquivos_ARQ_NOTIFICACAOEXPIRACAO] DEFAULT ((0)) NULL,
    CONSTRAINT [PK__Arquivos__3D5E1FD2] PRIMARY KEY CLUSTERED ([ARQ_CODARQ] ASC) WITH (FILLFACTOR = 90),
    CONSTRAINT [FK__Arquivos__ARQ_CO__0A9D95DB] FOREIGN KEY ([ARQ_CODARQTIPO]) REFERENCES [dbo].[TipoArquivo] ([TAR_CODTIPOARQUIVO]),
    CONSTRAINT [FK__Arquivos__ARQ_ID__0B91BA14] FOREIGN KEY ([ARQ_IDSITUACAO]) REFERENCES [dbo].[SituacaoArquivo] ([SAR_CODSITARQUIVO]),
    CONSTRAINT [FK__Arquivos__ARQ_ID__0C85DE4D] FOREIGN KEY ([ARQ_IDORGAO]) REFERENCES [dbo].[Orgao] ([ORGA_ID])
);


GO
ALTER TABLE [dbo].[Arquivos] NOCHECK CONSTRAINT [FK__Arquivos__ARQ_CO__0A9D95DB];


GO
ALTER TABLE [dbo].[Arquivos] NOCHECK CONSTRAINT [FK__Arquivos__ARQ_ID__0B91BA14];


GO
ALTER TABLE [dbo].[Arquivos] NOCHECK CONSTRAINT [FK__Arquivos__ARQ_ID__0C85DE4D];

