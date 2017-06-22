CREATE TABLE [dbo].[EquipeEmbratel] (
    [UserId_Gerente] VARCHAR (20) NOT NULL,
    [UserId_Membro]  VARCHAR (20) NOT NULL,
    CONSTRAINT [EquipeEmbratel_PK] PRIMARY KEY CLUSTERED ([UserId_Gerente] ASC, [UserId_Membro] ASC) WITH (FILLFACTOR = 90)
);

