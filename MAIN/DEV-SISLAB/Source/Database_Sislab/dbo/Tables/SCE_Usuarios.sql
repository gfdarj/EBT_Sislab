CREATE TABLE [dbo].[SCE_Usuarios] (
    [USER_ID]     INT            NOT NULL,
    [USER_LOGIN]  VARCHAR (20)   NULL,
    [USER_STATUS] INT            NULL,
    [user_senha]  VARBINARY (20) NULL,
    [user_nome]   VARCHAR (150)  NULL,
    [user_email]  VARCHAR (50)   NULL
);

