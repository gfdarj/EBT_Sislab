CREATE TABLE [dbo].[Agenda_Servicos_Plataforma] (
    [S_ID]      SMALLINT NOT NULL,
    [AG_NUMERO] SMALLINT NOT NULL,
    CONSTRAINT [PK_Agenda_Servicos_Plataforma] PRIMARY KEY CLUSTERED ([S_ID] ASC, [AG_NUMERO] ASC) WITH (FILLFACTOR = 90),
    CONSTRAINT [FK_Agenda_Servicos_Plataforma_Agendamento] FOREIGN KEY ([AG_NUMERO]) REFERENCES [dbo].[Agendamento] ([AG_NUMERO]),
    CONSTRAINT [FK_Agenda_Servicos_Plataforma_Servicos_Plataformas] FOREIGN KEY ([S_ID]) REFERENCES [dbo].[Servicos_Plataformas] ([S_ID])
);


GO
ALTER TABLE [dbo].[Agenda_Servicos_Plataforma] NOCHECK CONSTRAINT [FK_Agenda_Servicos_Plataforma_Agendamento];


GO
ALTER TABLE [dbo].[Agenda_Servicos_Plataforma] NOCHECK CONSTRAINT [FK_Agenda_Servicos_Plataforma_Servicos_Plataformas];

