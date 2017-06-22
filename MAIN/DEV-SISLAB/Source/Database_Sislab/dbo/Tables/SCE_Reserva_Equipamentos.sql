CREATE TABLE [dbo].[SCE_Reserva_Equipamentos] (
    [AG_NUMERO]        SMALLINT NOT NULL,
    [EQ_ID]            INT      NOT NULL,
    [REQ_DATAINICIO]   DATETIME CONSTRAINT [DF_SCE_Reserva_Equipamentos_REQ_DATAINICIO] DEFAULT (getdate()) NOT NULL,
    [REQ_DATATERMINO]  DATETIME CONSTRAINT [DF_SCE_Reserva_Equipamentos_REQ_DATAFIM] DEFAULT (getdate()) NOT NULL,
    [REQ_DEVOLVIDOLOG] BIT      CONSTRAINT [DF_SCE_Reserva_Equipamentos_REQ_LIBERADOTESTE] DEFAULT ((0)) NOT NULL,
    [REQ_EQSETUP]      CHAR (1) CONSTRAINT [DF__SCE_Reser__REQ_E__25B24A21] DEFAULT ('E') NOT NULL,
    [REQ_ACEITO]       TINYINT  NULL,
    [REQ_MOVIMENTOU]   BIT      CONSTRAINT [DF_SCE_Reserva_Equipamentos_REQ_MOVIMENTOU] DEFAULT ((0)) NOT NULL,
    [AMB_ID]           INT      NULL,
    CONSTRAINT [PK_SCE_Reserva_Equipamentos] PRIMARY KEY CLUSTERED ([AG_NUMERO] ASC, [EQ_ID] ASC, [REQ_DATAINICIO] ASC, [REQ_DATATERMINO] ASC) WITH (FILLFACTOR = 90),
    CONSTRAINT [FK__SCE_Reser__AMB_I__52AF0DCA] FOREIGN KEY ([AMB_ID]) REFERENCES [dbo].[Ambientes] ([AMB_ID]),
    CONSTRAINT [FK_SCE_Reserva_Equipamentos_AG_NUMERO] FOREIGN KEY ([AG_NUMERO]) REFERENCES [dbo].[Agendamento] ([AG_NUMERO]),
    CONSTRAINT [FK_SCE_Reserva_Equipamentos_EQ_ID] FOREIGN KEY ([EQ_ID]) REFERENCES [dbo].[SCE_Equipamentos] ([EQ_ID]),
    CONSTRAINT [FK_SCE_Reserva_Equipamentos_Reserva_AG_NUMERO] FOREIGN KEY ([AG_NUMERO]) REFERENCES [dbo].[SCE_Reserva] ([AG_NUMERO])
);


GO
ALTER TABLE [dbo].[SCE_Reserva_Equipamentos] NOCHECK CONSTRAINT [FK__SCE_Reser__AMB_I__52AF0DCA];


GO
ALTER TABLE [dbo].[SCE_Reserva_Equipamentos] NOCHECK CONSTRAINT [FK_SCE_Reserva_Equipamentos_AG_NUMERO];


GO
ALTER TABLE [dbo].[SCE_Reserva_Equipamentos] NOCHECK CONSTRAINT [FK_SCE_Reserva_Equipamentos_EQ_ID];


GO
ALTER TABLE [dbo].[SCE_Reserva_Equipamentos] NOCHECK CONSTRAINT [FK_SCE_Reserva_Equipamentos_Reserva_AG_NUMERO];

