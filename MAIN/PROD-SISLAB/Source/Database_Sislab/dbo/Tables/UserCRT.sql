CREATE TABLE [dbo].[UserCRT] (
    [USERID]        VARCHAR (20)   NOT NULL,
    [NOME]          NVARCHAR (510) NULL,
    [CELULAR]       NVARCHAR (510) NULL,
    [RAMAL]         FLOAT (53)     NULL,
    [MATRICULA]     FLOAT (53)     NULL,
    [ORGA_ID]       SMALLINT       NULL,
    [RT]            BIT            CONSTRAINT [DF_UserCRT_RT] DEFAULT ((0)) NOT NULL,
    [RAT]           BIT            CONSTRAINT [DF_UserCRT_RAT] DEFAULT ((0)) NOT NULL,
    [Exibir]        BIT            CONSTRAINT [DF_UserCRT_Exibir] DEFAULT ((1)) NOT NULL,
    [GQ]            BIT            CONSTRAINT [DF_UserCRT_GQ] DEFAULT ((0)) NOT NULL,
    [ID_PERFIL_SCE] TINYINT        NULL,
    CONSTRAINT [PK__UserCRT__0DAF0CB0] PRIMARY KEY CLUSTERED ([USERID] ASC) WITH (FILLFACTOR = 90),
    CONSTRAINT [FK_UserCRT_Orgao] FOREIGN KEY ([ORGA_ID]) REFERENCES [dbo].[Orgao] ([ORGA_ID])
);


GO
ALTER TABLE [dbo].[UserCRT] NOCHECK CONSTRAINT [FK_UserCRT_Orgao];

