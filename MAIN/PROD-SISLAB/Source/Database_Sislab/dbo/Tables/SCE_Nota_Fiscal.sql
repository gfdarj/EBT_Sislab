CREATE TABLE [dbo].[SCE_Nota_Fiscal] (
    [NF_NUMERONOTA]        INT             NULL,
    [NF_QTDEVOLUMES]       INT             NULL,
    [NF_CFOP]              VARCHAR (20)    NULL,
    [NF_VALORTOTAL]        DECIMAL (15, 2) NULL,
    [NF_DATAEMISSAO]       DATETIME        CONSTRAINT [DF_SCE_Nota_Fiscal_NF_DATAEMISSAO] DEFAULT (getdate()) NULL,
    [NF_NCONHECIMENTO]     CHAR (10)       NULL,
    [NF_TIPO]              INT             NULL,
    [TRANS_ID]             INT             NULL,
    [ENF_ID]               INT             NULL,
    [NF_ID]                INT             IDENTITY (1, 1) NOT NULL,
    [nf_descriminacao]     TEXT            NULL,
    [no_id]                INT             NULL,
    [nf_id_pai]            INT             NULL,
    [nf_validade]          VARCHAR (50)    NULL,
    [nf_data]              DATETIME        CONSTRAINT [DF_SCE_Nota_Fiscal_nf_data] DEFAULT (getdate()) NULL,
    [nf_recebimento]       DATETIME        CONSTRAINT [DF_SCE_Nota_Fiscal_nf_recebimento] DEFAULT (getdate()) NULL,
    [nf_obs]               TEXT            NULL,
    [NF_ACEITE]            TINYINT         NULL,
    [NF_VOLUME]            TINYINT         NULL,
    [NF_CARTA]             VARCHAR (1)     NULL,
    [NF_INTEGRIDADE]       TINYINT         NULL,
    [NF_DEVOLUCAOCOMPLETA] BIT             CONSTRAINT [DF__SCE_Nota___NF_DE__126A6B83] DEFAULT ((0)) NOT NULL,
    [NF_VALORTOTAL_CHAR]   VARCHAR (30)    NULL,
    CONSTRAINT [PK_SCE_Nota_Fiscal] PRIMARY KEY NONCLUSTERED ([NF_ID] ASC) WITH (FILLFACTOR = 90),
    CONSTRAINT [FK_SCE_Nota_Fiscal_SCE_Empresa_Nota_Fiscal] FOREIGN KEY ([ENF_ID]) REFERENCES [dbo].[SCE_Empresa_Nota_Fiscal] ([ENF_ID]),
    CONSTRAINT [FK_SCE_Nota_Fiscal_SCE_Empresa_Nota_Fiscal_Transportadora] FOREIGN KEY ([TRANS_ID]) REFERENCES [dbo].[SCE_Empresa_Nota_Fiscal] ([ENF_ID]),
    CONSTRAINT [FK_SCE_Nota_Fiscal_SCE_Nota_Fiscal] FOREIGN KEY ([nf_id_pai]) REFERENCES [dbo].[SCE_Nota_Fiscal] ([NF_ID])
);


GO
ALTER TABLE [dbo].[SCE_Nota_Fiscal] NOCHECK CONSTRAINT [FK_SCE_Nota_Fiscal_SCE_Empresa_Nota_Fiscal];


GO
ALTER TABLE [dbo].[SCE_Nota_Fiscal] NOCHECK CONSTRAINT [FK_SCE_Nota_Fiscal_SCE_Empresa_Nota_Fiscal_Transportadora];


GO
ALTER TABLE [dbo].[SCE_Nota_Fiscal] NOCHECK CONSTRAINT [FK_SCE_Nota_Fiscal_SCE_Nota_Fiscal];

