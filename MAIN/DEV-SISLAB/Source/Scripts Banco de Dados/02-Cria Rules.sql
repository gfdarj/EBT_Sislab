USE [SISLAB2000]
GO
/****** Object:  Rule [dbo].[ru_SCE_PROPRIEDADE_EQUIPAMENTO]    Script Date: 07/27/2018 09:33:30 ******/
DROP RULE [dbo].[ru_SCE_PROPRIEDADE_EQUIPAMENTO]
GO
/****** Object:  Rule [dbo].[TIPO_LOCAL_EQUP]    Script Date: 07/27/2018 09:33:30 ******/
DROP RULE [dbo].[TIPO_LOCAL_EQUP]
GO
/****** Object:  Rule [dbo].[VERIFICA_ANO]    Script Date: 07/27/2018 09:33:30 ******/
DROP RULE [dbo].[VERIFICA_ANO]
GO
/****** Object:  Rule [dbo].[ru_SCE_RESERVA_EQ_SETUP]    Script Date: 07/27/2018 09:33:30 ******/
DROP RULE [dbo].[ru_SCE_RESERVA_EQ_SETUP]
GO
/****** Object:  Rule [dbo].[ru_SCE_RESERVA_EQ_ACEITO]    Script Date: 07/27/2018 09:33:30 ******/
DROP RULE [dbo].[ru_SCE_RESERVA_EQ_ACEITO]
GO
/****** Object:  Rule [dbo].[ru_SCE_EMPRESA_TIPO]    Script Date: 07/27/2018 09:33:30 ******/
DROP RULE [dbo].[ru_SCE_EMPRESA_TIPO]
GO
/****** Object:  Rule [dbo].[ru_SCE_NOTA_FISCAL_CARTA]    Script Date: 07/27/2018 09:33:30 ******/
DROP RULE [dbo].[ru_SCE_NOTA_FISCAL_CARTA]
GO
/****** Object:  Rule [dbo].[ru_SCE_NOTA_FISCAL_CONFORMIDADE]    Script Date: 07/27/2018 09:33:30 ******/
DROP RULE [dbo].[ru_SCE_NOTA_FISCAL_CONFORMIDADE]
GO
/****** Object:  Rule [dbo].[ru_SCE_NOTA_FISCAL_CONFORMIDADE]    Script Date: 07/27/2018 09:33:30 ******/
create rule [dbo].[ru_SCE_NOTA_FISCAL_CONFORMIDADE] as /* NULL - Nada / 1 - OK / 0 - NAO OK */
@col IN (NULL, 0, 1)
GO
/****** Object:  Rule [dbo].[ru_SCE_NOTA_FISCAL_CARTA]    Script Date: 07/27/2018 09:33:30 ******/
create rule [dbo].[ru_SCE_NOTA_FISCAL_CARTA] as /* NULL - Nada / 'P' - Pendente / 'R' - Recebida */
@col IN (NULL, 'P', 'R')
GO
/****** Object:  Rule [dbo].[ru_SCE_EMPRESA_TIPO]    Script Date: 07/27/2018 09:33:30 ******/
create rule [dbo].[ru_SCE_EMPRESA_TIPO] as /* F - Fornecedor / T - Transportador */
@col IN ('F', 'T')
GO
/****** Object:  Rule [dbo].[ru_SCE_RESERVA_EQ_ACEITO]    Script Date: 07/27/2018 09:33:30 ******/
create rule [dbo].[ru_SCE_RESERVA_EQ_ACEITO] as /* null - não verificado / 0 - Não aceito / 1 - Aceito */
@col IN (NULL, 0, 1)
GO
/****** Object:  Rule [dbo].[ru_SCE_RESERVA_EQ_SETUP]    Script Date: 07/27/2018 09:33:30 ******/
create rule [dbo].[ru_SCE_RESERVA_EQ_SETUP] as /* A - Amostra / E - Equipamento */
@col IN ('A', 'E')
GO
/****** Object:  Rule [dbo].[VERIFICA_ANO]    Script Date: 07/27/2018 09:33:30 ******/
CREATE RULE [dbo].[VERIFICA_ANO]
	AS @col BETWEEN 1900 AND 3000
GO
/****** Object:  Rule [dbo].[TIPO_LOCAL_EQUP]    Script Date: 07/27/2018 09:33:30 ******/
CREATE RULE [dbo].[TIPO_LOCAL_EQUP]
	AS @col IN ('I', 'E')
GO
/****** Object:  Rule [dbo].[ru_SCE_PROPRIEDADE_EQUIPAMENTO]    Script Date: 07/27/2018 09:33:30 ******/
create rule [dbo].[ru_SCE_PROPRIEDADE_EQUIPAMENTO] as /* C - Embratel CRT / O - Embratel Outros / T - Terceiros / M - Comodato */
@col IN ('C', 'O', 'T', 'M')
GO
