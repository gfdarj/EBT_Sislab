CREATE TABLE [dbo].[Transporte] (
    [CodHorario]  INT         IDENTITY (1, 1) NOT NULL,
    [DeHoraIda]   VARCHAR (5) NULL,
    [DeHoraVolta] VARCHAR (5) NULL,
    PRIMARY KEY CLUSTERED ([CodHorario] ASC) WITH (FILLFACTOR = 90)
);

