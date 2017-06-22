CREATE TABLE [dbo].[SCE_Empresa_Nota_Fiscal] (
    [ENF_OBSERVACAO]  VARCHAR (1000) NULL,
    [ENF_CONTATO]     VARCHAR (50)   NULL,
    [ENF_FAX]         VARCHAR (20)   NULL,
    [ENF_TEL]         VARCHAR (20)   NULL,
    [ENF_CEP]         VARCHAR (9)    NULL,
    [ENF_UF]          INT            NULL,
    [ENF_CIDADE]      VARCHAR (50)   NULL,
    [ENF_ENDERECO]    VARCHAR (150)  NULL,
    [ENF_CNPJ]        VARCHAR (20)   NULL,
    [ENF_IE]          VARCHAR (20)   NULL,
    [ENF_NOME]        VARCHAR (100)  NULL,
    [ENF_ID]          INT            IDENTITY (1, 1) NOT NULL,
    [enf_ddd]         CHAR (30)      NULL,
    [enf_ddd_fax]     CHAR (30)      NULL,
    [enf_email]       VARCHAR (50)   NULL,
    [enf_cpf]         CHAR (20)      NULL,
    [ENF_TIPOEMPRESA] CHAR (1)       CONSTRAINT [DF_SCE_Empresa_Nota_Fiscal_ENF_TIPOEMPRESA] DEFAULT ('F') NOT NULL,
    CONSTRAINT [PK_SCE_Empresa_Nota_Fiscal] PRIMARY KEY NONCLUSTERED ([ENF_ID] ASC) WITH (FILLFACTOR = 90)
);


GO
CREATE NONCLUSTERED INDEX [IX_SCE_EMF_NOME]
    ON [dbo].[SCE_Empresa_Nota_Fiscal]([ENF_NOME] ASC) WITH (FILLFACTOR = 90);

