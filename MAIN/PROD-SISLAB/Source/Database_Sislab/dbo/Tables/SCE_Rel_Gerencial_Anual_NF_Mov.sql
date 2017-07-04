CREATE TABLE [dbo].[SCE_Rel_Gerencial_Anual_NF_Mov] (
    [CHAVE]       SMALLINT      NOT NULL,
    [ANO]         SMALLINT      NOT NULL,
    [RELATORIO]   VARCHAR (200) NULL,
    [MES1]        SMALLINT      NULL,
    [MES2]        SMALLINT      NULL,
    [MES3]        SMALLINT      NULL,
    [MES4]        SMALLINT      NULL,
    [MES5]        SMALLINT      NULL,
    [MES6]        SMALLINT      NULL,
    [MES7]        SMALLINT      NULL,
    [MES8]        SMALLINT      NULL,
    [MES9]        SMALLINT      NULL,
    [MES10]       SMALLINT      NULL,
    [MES11]       SMALLINT      NULL,
    [MES12]       SMALLINT      NULL,
    [DATACRIACAO] DATETIME      DEFAULT (getdate()) NULL,
    PRIMARY KEY CLUSTERED ([CHAVE] ASC, [ANO] ASC) WITH (FILLFACTOR = 90)
);

