USE [SISLAB2000]
GO
/****** Object:  ForeignKey [FK_Agenda_Servicos_Plataforma_Agendamento]    Script Date: 07/27/2018 09:30:12 ******/
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_Agenda_Servicos_Plataforma_Agendamento]') AND parent_object_id = OBJECT_ID(N'[dbo].[Agenda_Servicos_Plataforma]'))
ALTER TABLE [dbo].[Agenda_Servicos_Plataforma] DROP CONSTRAINT [FK_Agenda_Servicos_Plataforma_Agendamento]
GO
/****** Object:  ForeignKey [FK_Agenda_Servicos_Plataforma_Servicos_Plataformas]    Script Date: 07/27/2018 09:30:12 ******/
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_Agenda_Servicos_Plataforma_Servicos_Plataformas]') AND parent_object_id = OBJECT_ID(N'[dbo].[Agenda_Servicos_Plataforma]'))
ALTER TABLE [dbo].[Agenda_Servicos_Plataforma] DROP CONSTRAINT [FK_Agenda_Servicos_Plataforma_Servicos_Plataformas]
GO
/****** Object:  ForeignKey [FK_Agendamento_Tecnologia]    Script Date: 07/27/2018 09:30:12 ******/
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_Agendamento_Tecnologia]') AND parent_object_id = OBJECT_ID(N'[dbo].[Agendamento]'))
ALTER TABLE [dbo].[Agendamento] DROP CONSTRAINT [FK_Agendamento_Tecnologia]
GO
/****** Object:  ForeignKey [FK__Arquivos__ARQ_CO__0A9D95DB]    Script Date: 07/27/2018 09:30:13 ******/
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__Arquivos__ARQ_CO__0A9D95DB]') AND parent_object_id = OBJECT_ID(N'[dbo].[Arquivos]'))
ALTER TABLE [dbo].[Arquivos] DROP CONSTRAINT [FK__Arquivos__ARQ_CO__0A9D95DB]
GO
/****** Object:  ForeignKey [FK__Arquivos__ARQ_ID__0B91BA14]    Script Date: 07/27/2018 09:30:13 ******/
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__Arquivos__ARQ_ID__0B91BA14]') AND parent_object_id = OBJECT_ID(N'[dbo].[Arquivos]'))
ALTER TABLE [dbo].[Arquivos] DROP CONSTRAINT [FK__Arquivos__ARQ_ID__0B91BA14]
GO
/****** Object:  ForeignKey [FK__Arquivos__ARQ_ID__0C85DE4D]    Script Date: 07/27/2018 09:30:13 ******/
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__Arquivos__ARQ_ID__0C85DE4D]') AND parent_object_id = OBJECT_ID(N'[dbo].[Arquivos]'))
ALTER TABLE [dbo].[Arquivos] DROP CONSTRAINT [FK__Arquivos__ARQ_ID__0C85DE4D]
GO
/****** Object:  ForeignKey [FK__Diagramas__AG_NU__0E6E26BF]    Script Date: 07/27/2018 09:30:14 ******/
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__Diagramas__AG_NU__0E6E26BF]') AND parent_object_id = OBJECT_ID(N'[dbo].[Diagramas]'))
ALTER TABLE [dbo].[Diagramas] DROP CONSTRAINT [FK__Diagramas__AG_NU__0E6E26BF]
GO
/****** Object:  ForeignKey [FK__Diagramas__ARQ_C__0D7A0286]    Script Date: 07/27/2018 09:30:14 ******/
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__Diagramas__ARQ_C__0D7A0286]') AND parent_object_id = OBJECT_ID(N'[dbo].[Diagramas]'))
ALTER TABLE [dbo].[Diagramas] DROP CONSTRAINT [FK__Diagramas__ARQ_C__0D7A0286]
GO
/****** Object:  ForeignKey [FK_DisposicaoLB_LB_LogBook]    Script Date: 07/27/2018 09:30:14 ******/
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_DisposicaoLB_LB_LogBook]') AND parent_object_id = OBJECT_ID(N'[dbo].[DisposicaoLB]'))
ALTER TABLE [dbo].[DisposicaoLB] DROP CONSTRAINT [FK_DisposicaoLB_LB_LogBook]
GO
/****** Object:  ForeignKey [FK__FAC_CIRCU__TPC_I__6BA4D8C6]    Script Date: 07/27/2018 09:30:16 ******/
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__FAC_CIRCU__TPC_I__6BA4D8C6]') AND parent_object_id = OBJECT_ID(N'[dbo].[FAC_CIRCUITO]'))
ALTER TABLE [dbo].[FAC_CIRCUITO] DROP CONSTRAINT [FK__FAC_CIRCU__TPC_I__6BA4D8C6]
GO
/****** Object:  ForeignKey [FK__FAC_COMPO__LEE_I__6C98FCFF]    Script Date: 07/27/2018 09:30:16 ******/
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__FAC_COMPO__LEE_I__6C98FCFF]') AND parent_object_id = OBJECT_ID(N'[dbo].[FAC_COMPONENTES]'))
ALTER TABLE [dbo].[FAC_COMPONENTES] DROP CONSTRAINT [FK__FAC_COMPO__LEE_I__6C98FCFF]
GO
/****** Object:  ForeignKey [FK__FAC_COMPO__TPC_I__6D8D2138]    Script Date: 07/27/2018 09:30:16 ******/
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__FAC_COMPO__TPC_I__6D8D2138]') AND parent_object_id = OBJECT_ID(N'[dbo].[FAC_COMPONENTES]'))
ALTER TABLE [dbo].[FAC_COMPONENTES] DROP CONSTRAINT [FK__FAC_COMPO__TPC_I__6D8D2138]
GO
/****** Object:  ForeignKey [FK__FAC_FACIL__CPT_I__6F7569AA]    Script Date: 07/27/2018 09:30:17 ******/
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__FAC_FACIL__CPT_I__6F7569AA]') AND parent_object_id = OBJECT_ID(N'[dbo].[FAC_FACILIDADES]'))
ALTER TABLE [dbo].[FAC_FACILIDADES] DROP CONSTRAINT [FK__FAC_FACIL__CPT_I__6F7569AA]
GO
/****** Object:  ForeignKey [FK__FAC_FACIL__CTO_I__6E814571]    Script Date: 07/27/2018 09:30:17 ******/
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__FAC_FACIL__CTO_I__6E814571]') AND parent_object_id = OBJECT_ID(N'[dbo].[FAC_FACILIDADES]'))
ALTER TABLE [dbo].[FAC_FACILIDADES] DROP CONSTRAINT [FK__FAC_FACIL__CTO_I__6E814571]
GO
/****** Object:  ForeignKey [FK__FAC_LOCAI__LGE_I__70698DE3]    Script Date: 07/27/2018 09:30:18 ******/
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__FAC_LOCAI__LGE_I__70698DE3]') AND parent_object_id = OBJECT_ID(N'[dbo].[FAC_LOCAIS_ESPECIFICOS_EQUIP]'))
ALTER TABLE [dbo].[FAC_LOCAIS_ESPECIFICOS_EQUIP] DROP CONSTRAINT [FK__FAC_LOCAI__LGE_I__70698DE3]
GO
/****** Object:  ForeignKey [FK__FAC_REL_C__FAC_I__7251D655]    Script Date: 07/27/2018 09:30:19 ******/
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__FAC_REL_C__FAC_I__7251D655]') AND parent_object_id = OBJECT_ID(N'[dbo].[FAC_REL_CARACTERISTICAS_FACILIDADES]'))
ALTER TABLE [dbo].[FAC_REL_CARACTERISTICAS_FACILIDADES] DROP CONSTRAINT [FK__FAC_REL_C__FAC_I__7251D655]
GO
/****** Object:  ForeignKey [FK__FAC_REL_CARACTER__715DB21C]    Script Date: 07/27/2018 09:30:19 ******/
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__FAC_REL_CARACTER__715DB21C]') AND parent_object_id = OBJECT_ID(N'[dbo].[FAC_REL_CARACTERISTICAS_FACILIDADES]'))
ALTER TABLE [dbo].[FAC_REL_CARACTERISTICAS_FACILIDADES] DROP CONSTRAINT [FK__FAC_REL_CARACTER__715DB21C]
GO
/****** Object:  ForeignKey [FK__FAC_REL_C__CAR_I__743A1EC7]    Script Date: 07/27/2018 09:30:19 ******/
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__FAC_REL_C__CAR_I__743A1EC7]') AND parent_object_id = OBJECT_ID(N'[dbo].[FAC_REL_CARACTERISTICAS_TIPO]'))
ALTER TABLE [dbo].[FAC_REL_CARACTERISTICAS_TIPO] DROP CONSTRAINT [FK__FAC_REL_C__CAR_I__743A1EC7]
GO
/****** Object:  ForeignKey [FK__FAC_REL_C__TPC_I__7345FA8E]    Script Date: 07/27/2018 09:30:19 ******/
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__FAC_REL_C__TPC_I__7345FA8E]') AND parent_object_id = OBJECT_ID(N'[dbo].[FAC_REL_CARACTERISTICAS_TIPO]'))
ALTER TABLE [dbo].[FAC_REL_CARACTERISTICAS_TIPO] DROP CONSTRAINT [FK__FAC_REL_C__TPC_I__7345FA8E]
GO
/****** Object:  ForeignKey [FK__FAC_REL_C__AG_NU__76226739]    Script Date: 07/27/2018 09:30:20 ******/
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__FAC_REL_C__AG_NU__76226739]') AND parent_object_id = OBJECT_ID(N'[dbo].[FAC_REL_CIRCUITO_AGENDAMENTO]'))
ALTER TABLE [dbo].[FAC_REL_CIRCUITO_AGENDAMENTO] DROP CONSTRAINT [FK__FAC_REL_C__AG_NU__76226739]
GO
/****** Object:  ForeignKey [FK__FAC_REL_C__CTO_I__752E4300]    Script Date: 07/27/2018 09:30:20 ******/
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__FAC_REL_C__CTO_I__752E4300]') AND parent_object_id = OBJECT_ID(N'[dbo].[FAC_REL_CIRCUITO_AGENDAMENTO]'))
ALTER TABLE [dbo].[FAC_REL_CIRCUITO_AGENDAMENTO] DROP CONSTRAINT [FK__FAC_REL_C__CTO_I__752E4300]
GO
/****** Object:  ForeignKey [FK__FAC_TIPO___FAB_I__77168B72]    Script Date: 07/27/2018 09:30:21 ******/
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__FAC_TIPO___FAB_I__77168B72]') AND parent_object_id = OBJECT_ID(N'[dbo].[FAC_TIPO_COMPONENTE]'))
ALTER TABLE [dbo].[FAC_TIPO_COMPONENTE] DROP CONSTRAINT [FK__FAC_TIPO___FAB_I__77168B72]
GO
/****** Object:  ForeignKey [FK__FAC_TIPO___FTC_I__780AAFAB]    Script Date: 07/27/2018 09:30:21 ******/
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__FAC_TIPO___FTC_I__780AAFAB]') AND parent_object_id = OBJECT_ID(N'[dbo].[FAC_TIPO_COMPONENTE]'))
ALTER TABLE [dbo].[FAC_TIPO_COMPONENTE] DROP CONSTRAINT [FK__FAC_TIPO___FTC_I__780AAFAB]
GO
/****** Object:  ForeignKey [FK_HISTORICO_ARQUIVOS_Arquivos]    Script Date: 07/27/2018 09:30:22 ******/
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_HISTORICO_ARQUIVOS_Arquivos]') AND parent_object_id = OBJECT_ID(N'[dbo].[HISTORICO_ARQUIVOS]'))
ALTER TABLE [dbo].[HISTORICO_ARQUIVOS] DROP CONSTRAINT [FK_HISTORICO_ARQUIVOS_Arquivos]
GO
/****** Object:  ForeignKey [FK_Historico_Arquivos_UserCRT]    Script Date: 07/27/2018 09:30:22 ******/
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_Historico_Arquivos_UserCRT]') AND parent_object_id = OBJECT_ID(N'[dbo].[HISTORICO_ARQUIVOS]'))
ALTER TABLE [dbo].[HISTORICO_ARQUIVOS] DROP CONSTRAINT [FK_Historico_Arquivos_UserCRT]
GO
/****** Object:  ForeignKey [FK__Historico__AG_NU__04E4BC85]    Script Date: 07/27/2018 09:30:22 ******/
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__Historico__AG_NU__04E4BC85]') AND parent_object_id = OBJECT_ID(N'[dbo].[Historico_datas]'))
ALTER TABLE [dbo].[Historico_datas] DROP CONSTRAINT [FK__Historico__AG_NU__04E4BC85]
GO
/****** Object:  ForeignKey [FK__Historico__HD_RE__03F0984C]    Script Date: 07/27/2018 09:30:22 ******/
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__Historico__HD_RE__03F0984C]') AND parent_object_id = OBJECT_ID(N'[dbo].[Historico_datas]'))
ALTER TABLE [dbo].[Historico_datas] DROP CONSTRAINT [FK__Historico__HD_RE__03F0984C]
GO
/****** Object:  ForeignKey [FK__Historico__AG_NU__787EE5A0]    Script Date: 07/27/2018 09:30:23 ******/
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__Historico__AG_NU__787EE5A0]') AND parent_object_id = OBJECT_ID(N'[dbo].[Historico_Eventos]'))
ALTER TABLE [dbo].[Historico_Eventos] DROP CONSTRAINT [FK__Historico__AG_NU__787EE5A0]
GO
/****** Object:  ForeignKey [FK__Historico__HE_RE__778AC167]    Script Date: 07/27/2018 09:30:23 ******/
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__Historico__HE_RE__778AC167]') AND parent_object_id = OBJECT_ID(N'[dbo].[Historico_Eventos]'))
ALTER TABLE [dbo].[Historico_Eventos] DROP CONSTRAINT [FK__Historico__HE_RE__778AC167]
GO
/****** Object:  ForeignKey [FK__Historico__ID_SI__76969D2E]    Script Date: 07/27/2018 09:30:23 ******/
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__Historico__ID_SI__76969D2E]') AND parent_object_id = OBJECT_ID(N'[dbo].[Historico_Eventos]'))
ALTER TABLE [dbo].[Historico_Eventos] DROP CONSTRAINT [FK__Historico__ID_SI__76969D2E]
GO
/****** Object:  ForeignKey [FK__Historico__HEOS___2180FB33]    Script Date: 07/27/2018 09:30:23 ******/
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__Historico__HEOS___2180FB33]') AND parent_object_id = OBJECT_ID(N'[dbo].[Historico_EventosOS]'))
ALTER TABLE [dbo].[Historico_EventosOS] DROP CONSTRAINT [FK__Historico__HEOS___2180FB33]
GO
/****** Object:  ForeignKey [FK__Historico__ID_SI__208CD6FA]    Script Date: 07/27/2018 09:30:23 ******/
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__Historico__ID_SI__208CD6FA]') AND parent_object_id = OBJECT_ID(N'[dbo].[Historico_EventosOS]'))
ALTER TABLE [dbo].[Historico_EventosOS] DROP CONSTRAINT [FK__Historico__ID_SI__208CD6FA]
GO
/****** Object:  ForeignKey [FK__Historico_Evento__22751F6C]    Script Date: 07/27/2018 09:30:23 ******/
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__Historico_Evento__22751F6C]') AND parent_object_id = OBJECT_ID(N'[dbo].[Historico_EventosOS]'))
ALTER TABLE [dbo].[Historico_EventosOS] DROP CONSTRAINT [FK__Historico_Evento__22751F6C]
GO
/****** Object:  ForeignKey [FK_HISTORICO_PLATAFORMA_EQUIPAMENTOS_SCE_EQUIPAMENTOS]    Script Date: 07/27/2018 09:30:23 ******/
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_HISTORICO_PLATAFORMA_EQUIPAMENTOS_SCE_EQUIPAMENTOS]') AND parent_object_id = OBJECT_ID(N'[dbo].[HISTORICO_PLATAFORMA_EQUIPAMENTOS]'))
ALTER TABLE [dbo].[HISTORICO_PLATAFORMA_EQUIPAMENTOS] DROP CONSTRAINT [FK_HISTORICO_PLATAFORMA_EQUIPAMENTOS_SCE_EQUIPAMENTOS]
GO
/****** Object:  ForeignKey [FK_HISTORICO_PLATAFORMA_EQUIPAMENTOS_SERVICOS_PLATAFORMAS]    Script Date: 07/27/2018 09:30:23 ******/
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_HISTORICO_PLATAFORMA_EQUIPAMENTOS_SERVICOS_PLATAFORMAS]') AND parent_object_id = OBJECT_ID(N'[dbo].[HISTORICO_PLATAFORMA_EQUIPAMENTOS]'))
ALTER TABLE [dbo].[HISTORICO_PLATAFORMA_EQUIPAMENTOS] DROP CONSTRAINT [FK_HISTORICO_PLATAFORMA_EQUIPAMENTOS_SERVICOS_PLATAFORMAS]
GO
/****** Object:  ForeignKey [FK_LB_ACOESTOMADAS_LB_LogBook]    Script Date: 07/27/2018 09:30:24 ******/
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_LB_ACOESTOMADAS_LB_LogBook]') AND parent_object_id = OBJECT_ID(N'[dbo].[LB_ACOESTOMADAS]'))
ALTER TABLE [dbo].[LB_ACOESTOMADAS] DROP CONSTRAINT [FK_LB_ACOESTOMADAS_LB_LogBook]
GO
/****** Object:  ForeignKey [FK_LB_ACOESTOMADAS_LB_TIPOACAOTOMADA]    Script Date: 07/27/2018 09:30:24 ******/
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_LB_ACOESTOMADAS_LB_TIPOACAOTOMADA]') AND parent_object_id = OBJECT_ID(N'[dbo].[LB_ACOESTOMADAS]'))
ALTER TABLE [dbo].[LB_ACOESTOMADAS] DROP CONSTRAINT [FK_LB_ACOESTOMADAS_LB_TIPOACAOTOMADA]
GO
/****** Object:  ForeignKey [FK_LB_ACOESTOMADAS_USERCRT]    Script Date: 07/27/2018 09:30:24 ******/
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_LB_ACOESTOMADAS_USERCRT]') AND parent_object_id = OBJECT_ID(N'[dbo].[LB_ACOESTOMADAS]'))
ALTER TABLE [dbo].[LB_ACOESTOMADAS] DROP CONSTRAINT [FK_LB_ACOESTOMADAS_USERCRT]
GO
/****** Object:  ForeignKey [FK_LB_ACOESTOMADAS_LB_ACOESTOMADAS_ARQUIVOS]    Script Date: 07/27/2018 09:30:24 ******/
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_LB_ACOESTOMADAS_LB_ACOESTOMADAS_ARQUIVOS]') AND parent_object_id = OBJECT_ID(N'[dbo].[LB_ACOESTOMADAS_ARQUIVOS]'))
ALTER TABLE [dbo].[LB_ACOESTOMADAS_ARQUIVOS] DROP CONSTRAINT [FK_LB_ACOESTOMADAS_LB_ACOESTOMADAS_ARQUIVOS]
GO
/****** Object:  ForeignKey [FK_LB_LOGBOOK_LB_ACOESTOMADAS_ARQUIVOS]    Script Date: 07/27/2018 09:30:24 ******/
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_LB_LOGBOOK_LB_ACOESTOMADAS_ARQUIVOS]') AND parent_object_id = OBJECT_ID(N'[dbo].[LB_ACOESTOMADAS_ARQUIVOS]'))
ALTER TABLE [dbo].[LB_ACOESTOMADAS_ARQUIVOS] DROP CONSTRAINT [FK_LB_LOGBOOK_LB_ACOESTOMADAS_ARQUIVOS]
GO
/****** Object:  ForeignKey [FK__LB_LogBoo__LBTO___73BA3083]    Script Date: 07/27/2018 09:30:25 ******/
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__LB_LogBoo__LBTO___73BA3083]') AND parent_object_id = OBJECT_ID(N'[dbo].[LB_LogBook]'))
ALTER TABLE [dbo].[LB_LogBook] DROP CONSTRAINT [FK__LB_LogBoo__LBTO___73BA3083]
GO
/****** Object:  ForeignKey [FK_LB_LogBook_UserCRT]    Script Date: 07/27/2018 09:30:25 ******/
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_LB_LogBook_UserCRT]') AND parent_object_id = OBJECT_ID(N'[dbo].[LB_LogBook]'))
ALTER TABLE [dbo].[LB_LogBook] DROP CONSTRAINT [FK_LB_LogBook_UserCRT]
GO
/****** Object:  ForeignKey [FK__LogBook_A__AG_NU__74AE54BC]    Script Date: 07/27/2018 09:30:26 ******/
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__LogBook_A__AG_NU__74AE54BC]') AND parent_object_id = OBJECT_ID(N'[dbo].[LogBook_Agendamento]'))
ALTER TABLE [dbo].[LogBook_Agendamento] DROP CONSTRAINT [FK__LogBook_A__AG_NU__74AE54BC]
GO
/****** Object:  ForeignKey [FK__LogBook_A__LB_ID__75A278F5]    Script Date: 07/27/2018 09:30:26 ******/
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__LogBook_A__LB_ID__75A278F5]') AND parent_object_id = OBJECT_ID(N'[dbo].[LogBook_Agendamento]'))
ALTER TABLE [dbo].[LogBook_Agendamento] DROP CONSTRAINT [FK__LogBook_A__LB_ID__75A278F5]
GO
/****** Object:  ForeignKey [FK_Ordem_de_Servico_Agendamento]    Script Date: 07/27/2018 09:30:27 ******/
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_Ordem_de_Servico_Agendamento]') AND parent_object_id = OBJECT_ID(N'[dbo].[Ordem_de_Servico]'))
ALTER TABLE [dbo].[Ordem_de_Servico] DROP CONSTRAINT [FK_Ordem_de_Servico_Agendamento]
GO
/****** Object:  ForeignKey [FK_Ordem_de_Servico_SCE_Equipamentos]    Script Date: 07/27/2018 09:30:27 ******/
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_Ordem_de_Servico_SCE_Equipamentos]') AND parent_object_id = OBJECT_ID(N'[dbo].[Ordem_de_Servico]'))
ALTER TABLE [dbo].[Ordem_de_Servico] DROP CONSTRAINT [FK_Ordem_de_Servico_SCE_Equipamentos]
GO
/****** Object:  ForeignKey [FK_Ordem_de_Servico_Servicos_Plataformas_Plataforma]    Script Date: 07/27/2018 09:30:27 ******/
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_Ordem_de_Servico_Servicos_Plataformas_Plataforma]') AND parent_object_id = OBJECT_ID(N'[dbo].[Ordem_de_Servico]'))
ALTER TABLE [dbo].[Ordem_de_Servico] DROP CONSTRAINT [FK_Ordem_de_Servico_Servicos_Plataformas_Plataforma]
GO
/****** Object:  ForeignKey [FK_Ordem_de_Servico_Servicos_Plataformas_Servico]    Script Date: 07/27/2018 09:30:27 ******/
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_Ordem_de_Servico_Servicos_Plataformas_Servico]') AND parent_object_id = OBJECT_ID(N'[dbo].[Ordem_de_Servico]'))
ALTER TABLE [dbo].[Ordem_de_Servico] DROP CONSTRAINT [FK_Ordem_de_Servico_Servicos_Plataformas_Servico]
GO
/****** Object:  ForeignKey [FK_Ordem_de_Servico_Testes]    Script Date: 07/27/2018 09:30:27 ******/
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_Ordem_de_Servico_Testes]') AND parent_object_id = OBJECT_ID(N'[dbo].[Ordem_de_Servico]'))
ALTER TABLE [dbo].[Ordem_de_Servico] DROP CONSTRAINT [FK_Ordem_de_Servico_Testes]
GO
/****** Object:  ForeignKey [FK_Ordem_de_Servico_UserCRT]    Script Date: 07/27/2018 09:30:27 ******/
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_Ordem_de_Servico_UserCRT]') AND parent_object_id = OBJECT_ID(N'[dbo].[Ordem_de_Servico]'))
ALTER TABLE [dbo].[Ordem_de_Servico] DROP CONSTRAINT [FK_Ordem_de_Servico_UserCRT]
GO
/****** Object:  ForeignKey [FK__Participa__AG_NU__1DB06A4F]    Script Date: 07/27/2018 09:30:28 ******/
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__Participa__AG_NU__1DB06A4F]') AND parent_object_id = OBJECT_ID(N'[dbo].[Participantes_Externos]'))
ALTER TABLE [dbo].[Participantes_Externos] DROP CONSTRAINT [FK__Participa__AG_NU__1DB06A4F]
GO
/****** Object:  ForeignKey [FK__Plantao__PLA_USE__0F624AF8]    Script Date: 07/27/2018 09:30:29 ******/
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__Plantao__PLA_USE__0F624AF8]') AND parent_object_id = OBJECT_ID(N'[dbo].[Plantao]'))
ALTER TABLE [dbo].[Plantao] DROP CONSTRAINT [FK__Plantao__PLA_USE__0F624AF8]
GO
/****** Object:  ForeignKey [FK_Reserva_Ambientes_Agendamento]    Script Date: 07/27/2018 09:30:30 ******/
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_Reserva_Ambientes_Agendamento]') AND parent_object_id = OBJECT_ID(N'[dbo].[Reserva_ambientes]'))
ALTER TABLE [dbo].[Reserva_ambientes] DROP CONSTRAINT [FK_Reserva_Ambientes_Agendamento]
GO
/****** Object:  ForeignKey [FK_Reserva_Ambientes_Ambientes]    Script Date: 07/27/2018 09:30:30 ******/
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_Reserva_Ambientes_Ambientes]') AND parent_object_id = OBJECT_ID(N'[dbo].[Reserva_ambientes]'))
ALTER TABLE [dbo].[Reserva_ambientes] DROP CONSTRAINT [FK_Reserva_Ambientes_Ambientes]
GO
/****** Object:  ForeignKey [FK_ResolucaoLB_LB_LogBook]    Script Date: 07/27/2018 09:30:30 ******/
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_ResolucaoLB_LB_LogBook]') AND parent_object_id = OBJECT_ID(N'[dbo].[ResolucaoLB]'))
ALTER TABLE [dbo].[ResolucaoLB] DROP CONSTRAINT [FK_ResolucaoLB_LB_LogBook]
GO
/****** Object:  ForeignKey [FK_SCE_Acessorios_SCE_Equipamentos]    Script Date: 07/27/2018 09:30:30 ******/
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_SCE_Acessorios_SCE_Equipamentos]') AND parent_object_id = OBJECT_ID(N'[dbo].[SCE_Acessorios]'))
ALTER TABLE [dbo].[SCE_Acessorios] DROP CONSTRAINT [FK_SCE_Acessorios_SCE_Equipamentos]
GO
/****** Object:  ForeignKey [FK_SCE_AreasUtil_Modelo_SCE_AreaUtilizacao]    Script Date: 07/27/2018 09:30:31 ******/
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_SCE_AreasUtil_Modelo_SCE_AreaUtilizacao]') AND parent_object_id = OBJECT_ID(N'[dbo].[SCE_AreasUtil_Modelo]'))
ALTER TABLE [dbo].[SCE_AreasUtil_Modelo] DROP CONSTRAINT [FK_SCE_AreasUtil_Modelo_SCE_AreaUtilizacao]
GO
/****** Object:  ForeignKey [FK_SCE_AreasUtil_Modelo_SCE_Modelos]    Script Date: 07/27/2018 09:30:31 ******/
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_SCE_AreasUtil_Modelo_SCE_Modelos]') AND parent_object_id = OBJECT_ID(N'[dbo].[SCE_AreasUtil_Modelo]'))
ALTER TABLE [dbo].[SCE_AreasUtil_Modelo] DROP CONSTRAINT [FK_SCE_AreasUtil_Modelo_SCE_Modelos]
GO
/****** Object:  ForeignKey [FK_SCE_Documentacao_ENF_ID]    Script Date: 07/27/2018 09:30:32 ******/
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_SCE_Documentacao_ENF_ID]') AND parent_object_id = OBJECT_ID(N'[dbo].[SCE_Documentacao]'))
ALTER TABLE [dbo].[SCE_Documentacao] DROP CONSTRAINT [FK_SCE_Documentacao_ENF_ID]
GO
/****** Object:  ForeignKey [FK_SCE_Equipamentos_SCE_Modelos]    Script Date: 07/27/2018 09:30:32 ******/
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_SCE_Equipamentos_SCE_Modelos]') AND parent_object_id = OBJECT_ID(N'[dbo].[SCE_Equipamentos]'))
ALTER TABLE [dbo].[SCE_Equipamentos] DROP CONSTRAINT [FK_SCE_Equipamentos_SCE_Modelos]
GO
/****** Object:  ForeignKey [FK_SCE_Equipamentos_Controle_EQ_ID]    Script Date: 07/27/2018 09:30:33 ******/
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_SCE_Equipamentos_Controle_EQ_ID]') AND parent_object_id = OBJECT_ID(N'[dbo].[SCE_Equipamentos_Controle]'))
ALTER TABLE [dbo].[SCE_Equipamentos_Controle] DROP CONSTRAINT [FK_SCE_Equipamentos_Controle_EQ_ID]
GO
/****** Object:  ForeignKey [FK_SCE_MODELOS_FAB_ID]    Script Date: 07/27/2018 09:30:34 ******/
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_SCE_MODELOS_FAB_ID]') AND parent_object_id = OBJECT_ID(N'[dbo].[SCE_Modelos]'))
ALTER TABLE [dbo].[SCE_Modelos] DROP CONSTRAINT [FK_SCE_MODELOS_FAB_ID]
GO
/****** Object:  ForeignKey [FK_SCE_Movimentacao_SCE_Documentacao]    Script Date: 07/27/2018 09:30:35 ******/
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_SCE_Movimentacao_SCE_Documentacao]') AND parent_object_id = OBJECT_ID(N'[dbo].[SCE_Movimentacao]'))
ALTER TABLE [dbo].[SCE_Movimentacao] DROP CONSTRAINT [FK_SCE_Movimentacao_SCE_Documentacao]
GO
/****** Object:  ForeignKey [FK_SCE_Movimentacao_SCE_Equipamentos]    Script Date: 07/27/2018 09:30:35 ******/
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_SCE_Movimentacao_SCE_Equipamentos]') AND parent_object_id = OBJECT_ID(N'[dbo].[SCE_Movimentacao]'))
ALTER TABLE [dbo].[SCE_Movimentacao] DROP CONSTRAINT [FK_SCE_Movimentacao_SCE_Equipamentos]
GO
/****** Object:  ForeignKey [FK_SCE_Movimentacao_SCE_Natureza_Operacao]    Script Date: 07/27/2018 09:30:35 ******/
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_SCE_Movimentacao_SCE_Natureza_Operacao]') AND parent_object_id = OBJECT_ID(N'[dbo].[SCE_Movimentacao]'))
ALTER TABLE [dbo].[SCE_Movimentacao] DROP CONSTRAINT [FK_SCE_Movimentacao_SCE_Natureza_Operacao]
GO
/****** Object:  ForeignKey [FK_SCE_Movimentacao_SCE_Nota_Fiscal]    Script Date: 07/27/2018 09:30:35 ******/
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_SCE_Movimentacao_SCE_Nota_Fiscal]') AND parent_object_id = OBJECT_ID(N'[dbo].[SCE_Movimentacao]'))
ALTER TABLE [dbo].[SCE_Movimentacao] DROP CONSTRAINT [FK_SCE_Movimentacao_SCE_Nota_Fiscal]
GO
/****** Object:  ForeignKey [FK_SCE_Nota_Fiscal_SCE_Empresa_Nota_Fiscal]    Script Date: 07/27/2018 09:30:36 ******/
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_SCE_Nota_Fiscal_SCE_Empresa_Nota_Fiscal]') AND parent_object_id = OBJECT_ID(N'[dbo].[SCE_Nota_Fiscal]'))
ALTER TABLE [dbo].[SCE_Nota_Fiscal] DROP CONSTRAINT [FK_SCE_Nota_Fiscal_SCE_Empresa_Nota_Fiscal]
GO
/****** Object:  ForeignKey [FK_SCE_Nota_Fiscal_SCE_Empresa_Nota_Fiscal_Transportadora]    Script Date: 07/27/2018 09:30:36 ******/
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_SCE_Nota_Fiscal_SCE_Empresa_Nota_Fiscal_Transportadora]') AND parent_object_id = OBJECT_ID(N'[dbo].[SCE_Nota_Fiscal]'))
ALTER TABLE [dbo].[SCE_Nota_Fiscal] DROP CONSTRAINT [FK_SCE_Nota_Fiscal_SCE_Empresa_Nota_Fiscal_Transportadora]
GO
/****** Object:  ForeignKey [FK_SCE_Nota_Fiscal_SCE_Nota_Fiscal]    Script Date: 07/27/2018 09:30:36 ******/
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_SCE_Nota_Fiscal_SCE_Nota_Fiscal]') AND parent_object_id = OBJECT_ID(N'[dbo].[SCE_Nota_Fiscal]'))
ALTER TABLE [dbo].[SCE_Nota_Fiscal] DROP CONSTRAINT [FK_SCE_Nota_Fiscal_SCE_Nota_Fiscal]
GO
/****** Object:  ForeignKey [FK_SCE_PartNumberModelo_SCE_Modelos]    Script Date: 07/27/2018 09:30:36 ******/
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_SCE_PartNumberModelo_SCE_Modelos]') AND parent_object_id = OBJECT_ID(N'[dbo].[SCE_PartNumberModelo]'))
ALTER TABLE [dbo].[SCE_PartNumberModelo] DROP CONSTRAINT [FK_SCE_PartNumberModelo_SCE_Modelos]
GO
/****** Object:  ForeignKey [FK_SCE_Passagem_Carga_AG_NUMERO_DEST]    Script Date: 07/27/2018 09:30:37 ******/
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_SCE_Passagem_Carga_AG_NUMERO_DEST]') AND parent_object_id = OBJECT_ID(N'[dbo].[SCE_Passagem_Carga]'))
ALTER TABLE [dbo].[SCE_Passagem_Carga] DROP CONSTRAINT [FK_SCE_Passagem_Carga_AG_NUMERO_DEST]
GO
/****** Object:  ForeignKey [FK_SCE_Passagem_Carga_AG_NUMERO_ORIG]    Script Date: 07/27/2018 09:30:37 ******/
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_SCE_Passagem_Carga_AG_NUMERO_ORIG]') AND parent_object_id = OBJECT_ID(N'[dbo].[SCE_Passagem_Carga]'))
ALTER TABLE [dbo].[SCE_Passagem_Carga] DROP CONSTRAINT [FK_SCE_Passagem_Carga_AG_NUMERO_ORIG]
GO
/****** Object:  ForeignKey [FK_SCE_Passagem_Carga_EQ_ID]    Script Date: 07/27/2018 09:30:37 ******/
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_SCE_Passagem_Carga_EQ_ID]') AND parent_object_id = OBJECT_ID(N'[dbo].[SCE_Passagem_Carga]'))
ALTER TABLE [dbo].[SCE_Passagem_Carga] DROP CONSTRAINT [FK_SCE_Passagem_Carga_EQ_ID]
GO
/****** Object:  ForeignKey [FK_SCE_Reserva_Agendamento]    Script Date: 07/27/2018 09:30:37 ******/
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_SCE_Reserva_Agendamento]') AND parent_object_id = OBJECT_ID(N'[dbo].[SCE_Reserva]'))
ALTER TABLE [dbo].[SCE_Reserva] DROP CONSTRAINT [FK_SCE_Reserva_Agendamento]
GO
/****** Object:  ForeignKey [FK_SCE_Reserva_Ambientes]    Script Date: 07/27/2018 09:30:37 ******/
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_SCE_Reserva_Ambientes]') AND parent_object_id = OBJECT_ID(N'[dbo].[SCE_Reserva]'))
ALTER TABLE [dbo].[SCE_Reserva] DROP CONSTRAINT [FK_SCE_Reserva_Ambientes]
GO
/****** Object:  ForeignKey [FK_SCE_Reserva_UserCRT]    Script Date: 07/27/2018 09:30:37 ******/
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_SCE_Reserva_UserCRT]') AND parent_object_id = OBJECT_ID(N'[dbo].[SCE_Reserva]'))
ALTER TABLE [dbo].[SCE_Reserva] DROP CONSTRAINT [FK_SCE_Reserva_UserCRT]
GO
/****** Object:  ForeignKey [FK__SCE_Reser__AMB_I__40A6377F]    Script Date: 07/27/2018 09:30:38 ******/
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__SCE_Reser__AMB_I__40A6377F]') AND parent_object_id = OBJECT_ID(N'[dbo].[SCE_Reserva_Equipamentos]'))
ALTER TABLE [dbo].[SCE_Reserva_Equipamentos] DROP CONSTRAINT [FK__SCE_Reser__AMB_I__40A6377F]
GO
/****** Object:  ForeignKey [FK_SCE_Reserva_Equipamentos_AG_NUMERO]    Script Date: 07/27/2018 09:30:38 ******/
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_SCE_Reserva_Equipamentos_AG_NUMERO]') AND parent_object_id = OBJECT_ID(N'[dbo].[SCE_Reserva_Equipamentos]'))
ALTER TABLE [dbo].[SCE_Reserva_Equipamentos] DROP CONSTRAINT [FK_SCE_Reserva_Equipamentos_AG_NUMERO]
GO
/****** Object:  ForeignKey [FK_SCE_Reserva_Equipamentos_EQ_ID]    Script Date: 07/27/2018 09:30:38 ******/
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_SCE_Reserva_Equipamentos_EQ_ID]') AND parent_object_id = OBJECT_ID(N'[dbo].[SCE_Reserva_Equipamentos]'))
ALTER TABLE [dbo].[SCE_Reserva_Equipamentos] DROP CONSTRAINT [FK_SCE_Reserva_Equipamentos_EQ_ID]
GO
/****** Object:  ForeignKey [FK_SCE_Reserva_Equipamentos_Reserva_AG_NUMERO]    Script Date: 07/27/2018 09:30:38 ******/
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_SCE_Reserva_Equipamentos_Reserva_AG_NUMERO]') AND parent_object_id = OBJECT_ID(N'[dbo].[SCE_Reserva_Equipamentos]'))
ALTER TABLE [dbo].[SCE_Reserva_Equipamentos] DROP CONSTRAINT [FK_SCE_Reserva_Equipamentos_Reserva_AG_NUMERO]
GO
/****** Object:  ForeignKey [FK_SERVICOS_PLATAFORMAS_SERVICOS_PLATAFORMAS_PAI]    Script Date: 07/27/2018 09:30:40 ******/
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_SERVICOS_PLATAFORMAS_SERVICOS_PLATAFORMAS_PAI]') AND parent_object_id = OBJECT_ID(N'[dbo].[Servicos_Plataformas]'))
ALTER TABLE [dbo].[Servicos_Plataformas] DROP CONSTRAINT [FK_SERVICOS_PLATAFORMAS_SERVICOS_PLATAFORMAS_PAI]
GO
/****** Object:  ForeignKey [FK__Situacoes__SITUA__6E01572D]    Script Date: 07/27/2018 09:30:41 ******/
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__Situacoes__SITUA__6E01572D]') AND parent_object_id = OBJECT_ID(N'[dbo].[Situacoes_Situacoes]'))
ALTER TABLE [dbo].[Situacoes_Situacoes] DROP CONSTRAINT [FK__Situacoes__SITUA__6E01572D]
GO
/****** Object:  ForeignKey [FK__Situacoes__SITUA__6EF57B66]    Script Date: 07/27/2018 09:30:41 ******/
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__Situacoes__SITUA__6EF57B66]') AND parent_object_id = OBJECT_ID(N'[dbo].[Situacoes_Situacoes]'))
ALTER TABLE [dbo].[Situacoes_Situacoes] DROP CONSTRAINT [FK__Situacoes__SITUA__6EF57B66]
GO
/****** Object:  ForeignKey [FK_TAREFAS_PREVISTAS_TAREFAS]    Script Date: 07/27/2018 09:30:42 ******/
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_TAREFAS_PREVISTAS_TAREFAS]') AND parent_object_id = OBJECT_ID(N'[dbo].[TAREFAS_PREVISTAS]'))
ALTER TABLE [dbo].[TAREFAS_PREVISTAS] DROP CONSTRAINT [FK_TAREFAS_PREVISTAS_TAREFAS]
GO
/****** Object:  ForeignKey [FK_TAREFAS_PREVISTAS_UserCRT]    Script Date: 07/27/2018 09:30:42 ******/
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_TAREFAS_PREVISTAS_UserCRT]') AND parent_object_id = OBJECT_ID(N'[dbo].[TAREFAS_PREVISTAS]'))
ALTER TABLE [dbo].[TAREFAS_PREVISTAS] DROP CONSTRAINT [FK_TAREFAS_PREVISTAS_UserCRT]
GO
/****** Object:  ForeignKey [FK_Tecnologia_Area_Tecnologica]    Script Date: 07/27/2018 09:30:42 ******/
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_Tecnologia_Area_Tecnologica]') AND parent_object_id = OBJECT_ID(N'[dbo].[TECNOLOGIA]'))
ALTER TABLE [dbo].[TECNOLOGIA] DROP CONSTRAINT [FK_Tecnologia_Area_Tecnologica]
GO
/****** Object:  ForeignKey [FK_Testes_Tipo_Teste]    Script Date: 07/27/2018 09:30:43 ******/
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_Testes_Tipo_Teste]') AND parent_object_id = OBJECT_ID(N'[dbo].[TESTES]'))
ALTER TABLE [dbo].[TESTES] DROP CONSTRAINT [FK_Testes_Tipo_Teste]
GO
/****** Object:  ForeignKey [FK_UserCRT_Orgao]    Script Date: 07/27/2018 09:30:45 ******/
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_UserCRT_Orgao]') AND parent_object_id = OBJECT_ID(N'[dbo].[UserCRT]'))
ALTER TABLE [dbo].[UserCRT] DROP CONSTRAINT [FK_UserCRT_Orgao]
GO
/****** Object:  Table [dbo].[FERIADO]    Script Date: 07/27/2018 09:30:21 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[FERIADO]') AND type in (N'U'))
DROP TABLE [dbo].[FERIADO]
GO
/****** Object:  Table [dbo].[SCE_Reserva_Equipamentos]    Script Date: 07/27/2018 09:30:38 ******/
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__SCE_Reser__AMB_I__40A6377F]') AND parent_object_id = OBJECT_ID(N'[dbo].[SCE_Reserva_Equipamentos]'))
ALTER TABLE [dbo].[SCE_Reserva_Equipamentos] DROP CONSTRAINT [FK__SCE_Reser__AMB_I__40A6377F]
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_SCE_Reserva_Equipamentos_AG_NUMERO]') AND parent_object_id = OBJECT_ID(N'[dbo].[SCE_Reserva_Equipamentos]'))
ALTER TABLE [dbo].[SCE_Reserva_Equipamentos] DROP CONSTRAINT [FK_SCE_Reserva_Equipamentos_AG_NUMERO]
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_SCE_Reserva_Equipamentos_EQ_ID]') AND parent_object_id = OBJECT_ID(N'[dbo].[SCE_Reserva_Equipamentos]'))
ALTER TABLE [dbo].[SCE_Reserva_Equipamentos] DROP CONSTRAINT [FK_SCE_Reserva_Equipamentos_EQ_ID]
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_SCE_Reserva_Equipamentos_Reserva_AG_NUMERO]') AND parent_object_id = OBJECT_ID(N'[dbo].[SCE_Reserva_Equipamentos]'))
ALTER TABLE [dbo].[SCE_Reserva_Equipamentos] DROP CONSTRAINT [FK_SCE_Reserva_Equipamentos_Reserva_AG_NUMERO]
GO
IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_SCE_Reserva_Equipamentos_REQ_DATAINICIO]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[SCE_Reserva_Equipamentos] DROP CONSTRAINT [DF_SCE_Reserva_Equipamentos_REQ_DATAINICIO]
END
GO
IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_SCE_Reserva_Equipamentos_REQ_DATAFIM]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[SCE_Reserva_Equipamentos] DROP CONSTRAINT [DF_SCE_Reserva_Equipamentos_REQ_DATAFIM]
END
GO
IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_SCE_Reserva_Equipamentos_REQ_LIBERADOTESTE]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[SCE_Reserva_Equipamentos] DROP CONSTRAINT [DF_SCE_Reserva_Equipamentos_REQ_LIBERADOTESTE]
END
GO
IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF__SCE_Reser__REQ_E__25B24A21]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[SCE_Reserva_Equipamentos] DROP CONSTRAINT [DF__SCE_Reser__REQ_E__25B24A21]
END
GO
IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_SCE_Reserva_Equipamentos_REQ_MOVIMENTOU]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[SCE_Reserva_Equipamentos] DROP CONSTRAINT [DF_SCE_Reserva_Equipamentos_REQ_MOVIMENTOU]
END
GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[SCE_Reserva_Equipamentos]') AND type in (N'U'))
DROP TABLE [dbo].[SCE_Reserva_Equipamentos]
GO
/****** Object:  Table [dbo].[Plantao]    Script Date: 07/27/2018 09:30:29 ******/
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__Plantao__PLA_USE__0F624AF8]') AND parent_object_id = OBJECT_ID(N'[dbo].[Plantao]'))
ALTER TABLE [dbo].[Plantao] DROP CONSTRAINT [FK__Plantao__PLA_USE__0F624AF8]
GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Plantao]') AND type in (N'U'))
DROP TABLE [dbo].[Plantao]
GO
/****** Object:  Table [dbo].[TAREFAS_PREVISTAS]    Script Date: 07/27/2018 09:30:42 ******/
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_TAREFAS_PREVISTAS_TAREFAS]') AND parent_object_id = OBJECT_ID(N'[dbo].[TAREFAS_PREVISTAS]'))
ALTER TABLE [dbo].[TAREFAS_PREVISTAS] DROP CONSTRAINT [FK_TAREFAS_PREVISTAS_TAREFAS]
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_TAREFAS_PREVISTAS_UserCRT]') AND parent_object_id = OBJECT_ID(N'[dbo].[TAREFAS_PREVISTAS]'))
ALTER TABLE [dbo].[TAREFAS_PREVISTAS] DROP CONSTRAINT [FK_TAREFAS_PREVISTAS_UserCRT]
GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[TAREFAS_PREVISTAS]') AND type in (N'U'))
DROP TABLE [dbo].[TAREFAS_PREVISTAS]
GO
/****** Object:  Table [dbo].[FAC_REL_CARACTERISTICAS_FACILIDADES]    Script Date: 07/27/2018 09:30:19 ******/
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__FAC_REL_C__FAC_I__7251D655]') AND parent_object_id = OBJECT_ID(N'[dbo].[FAC_REL_CARACTERISTICAS_FACILIDADES]'))
ALTER TABLE [dbo].[FAC_REL_CARACTERISTICAS_FACILIDADES] DROP CONSTRAINT [FK__FAC_REL_C__FAC_I__7251D655]
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__FAC_REL_CARACTER__715DB21C]') AND parent_object_id = OBJECT_ID(N'[dbo].[FAC_REL_CARACTERISTICAS_FACILIDADES]'))
ALTER TABLE [dbo].[FAC_REL_CARACTERISTICAS_FACILIDADES] DROP CONSTRAINT [FK__FAC_REL_CARACTER__715DB21C]
GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[FAC_REL_CARACTERISTICAS_FACILIDADES]') AND type in (N'U'))
DROP TABLE [dbo].[FAC_REL_CARACTERISTICAS_FACILIDADES]
GO
/****** Object:  Table [dbo].[FAC_FACILIDADES]    Script Date: 07/27/2018 09:30:17 ******/
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__FAC_FACIL__CPT_I__6F7569AA]') AND parent_object_id = OBJECT_ID(N'[dbo].[FAC_FACILIDADES]'))
ALTER TABLE [dbo].[FAC_FACILIDADES] DROP CONSTRAINT [FK__FAC_FACIL__CPT_I__6F7569AA]
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__FAC_FACIL__CTO_I__6E814571]') AND parent_object_id = OBJECT_ID(N'[dbo].[FAC_FACILIDADES]'))
ALTER TABLE [dbo].[FAC_FACILIDADES] DROP CONSTRAINT [FK__FAC_FACIL__CTO_I__6E814571]
GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[FAC_FACILIDADES]') AND type in (N'U'))
DROP TABLE [dbo].[FAC_FACILIDADES]
GO
/****** Object:  Table [dbo].[FAC_COMPONENTES]    Script Date: 07/27/2018 09:30:16 ******/
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__FAC_COMPO__LEE_I__6C98FCFF]') AND parent_object_id = OBJECT_ID(N'[dbo].[FAC_COMPONENTES]'))
ALTER TABLE [dbo].[FAC_COMPONENTES] DROP CONSTRAINT [FK__FAC_COMPO__LEE_I__6C98FCFF]
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__FAC_COMPO__TPC_I__6D8D2138]') AND parent_object_id = OBJECT_ID(N'[dbo].[FAC_COMPONENTES]'))
ALTER TABLE [dbo].[FAC_COMPONENTES] DROP CONSTRAINT [FK__FAC_COMPO__TPC_I__6D8D2138]
GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[FAC_COMPONENTES]') AND type in (N'U'))
DROP TABLE [dbo].[FAC_COMPONENTES]
GO
/****** Object:  Table [dbo].[FAC_LOCAIS_ESPECIFICOS_EQUIP]    Script Date: 07/27/2018 09:30:18 ******/
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__FAC_LOCAI__LGE_I__70698DE3]') AND parent_object_id = OBJECT_ID(N'[dbo].[FAC_LOCAIS_ESPECIFICOS_EQUIP]'))
ALTER TABLE [dbo].[FAC_LOCAIS_ESPECIFICOS_EQUIP] DROP CONSTRAINT [FK__FAC_LOCAI__LGE_I__70698DE3]
GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[FAC_LOCAIS_ESPECIFICOS_EQUIP]') AND type in (N'U'))
DROP TABLE [dbo].[FAC_LOCAIS_ESPECIFICOS_EQUIP]
GO
/****** Object:  Table [dbo].[FAC_LOCAIS_GENERICOS_EQUIP]    Script Date: 07/27/2018 09:30:19 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[FAC_LOCAIS_GENERICOS_EQUIP]') AND type in (N'U'))
DROP TABLE [dbo].[FAC_LOCAIS_GENERICOS_EQUIP]
GO
/****** Object:  Table [dbo].[Situacoes_Situacoes]    Script Date: 07/27/2018 09:30:41 ******/
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__Situacoes__SITUA__6E01572D]') AND parent_object_id = OBJECT_ID(N'[dbo].[Situacoes_Situacoes]'))
ALTER TABLE [dbo].[Situacoes_Situacoes] DROP CONSTRAINT [FK__Situacoes__SITUA__6E01572D]
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__Situacoes__SITUA__6EF57B66]') AND parent_object_id = OBJECT_ID(N'[dbo].[Situacoes_Situacoes]'))
ALTER TABLE [dbo].[Situacoes_Situacoes] DROP CONSTRAINT [FK__Situacoes__SITUA__6EF57B66]
GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Situacoes_Situacoes]') AND type in (N'U'))
DROP TABLE [dbo].[Situacoes_Situacoes]
GO
/****** Object:  Table [dbo].[Participantes_Externos]    Script Date: 07/27/2018 09:30:28 ******/
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__Participa__AG_NU__1DB06A4F]') AND parent_object_id = OBJECT_ID(N'[dbo].[Participantes_Externos]'))
ALTER TABLE [dbo].[Participantes_Externos] DROP CONSTRAINT [FK__Participa__AG_NU__1DB06A4F]
GO
IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF__PARTICIPA__PE_QU__44ABD28D]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[Participantes_Externos] DROP CONSTRAINT [DF__PARTICIPA__PE_QU__44ABD28D]
END
GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Participantes_Externos]') AND type in (N'U'))
DROP TABLE [dbo].[Participantes_Externos]
GO
/****** Object:  Table [dbo].[Reserva_ambientes]    Script Date: 07/27/2018 09:30:30 ******/
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_Reserva_Ambientes_Agendamento]') AND parent_object_id = OBJECT_ID(N'[dbo].[Reserva_ambientes]'))
ALTER TABLE [dbo].[Reserva_ambientes] DROP CONSTRAINT [FK_Reserva_Ambientes_Agendamento]
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_Reserva_Ambientes_Ambientes]') AND parent_object_id = OBJECT_ID(N'[dbo].[Reserva_ambientes]'))
ALTER TABLE [dbo].[Reserva_ambientes] DROP CONSTRAINT [FK_Reserva_Ambientes_Ambientes]
GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Reserva_ambientes]') AND type in (N'U'))
DROP TABLE [dbo].[Reserva_ambientes]
GO
/****** Object:  Table [dbo].[SCE_Reserva]    Script Date: 07/27/2018 09:30:37 ******/
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_SCE_Reserva_Agendamento]') AND parent_object_id = OBJECT_ID(N'[dbo].[SCE_Reserva]'))
ALTER TABLE [dbo].[SCE_Reserva] DROP CONSTRAINT [FK_SCE_Reserva_Agendamento]
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_SCE_Reserva_Ambientes]') AND parent_object_id = OBJECT_ID(N'[dbo].[SCE_Reserva]'))
ALTER TABLE [dbo].[SCE_Reserva] DROP CONSTRAINT [FK_SCE_Reserva_Ambientes]
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_SCE_Reserva_UserCRT]') AND parent_object_id = OBJECT_ID(N'[dbo].[SCE_Reserva]'))
ALTER TABLE [dbo].[SCE_Reserva] DROP CONSTRAINT [FK_SCE_Reserva_UserCRT]
GO
IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_SCE_Reserva_RES_DATACADASTRO]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[SCE_Reserva] DROP CONSTRAINT [DF_SCE_Reserva_RES_DATACADASTRO]
END
GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[SCE_Reserva]') AND type in (N'U'))
DROP TABLE [dbo].[SCE_Reserva]
GO
/****** Object:  Table [dbo].[Historico_datas]    Script Date: 07/27/2018 09:30:22 ******/
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__Historico__AG_NU__04E4BC85]') AND parent_object_id = OBJECT_ID(N'[dbo].[Historico_datas]'))
ALTER TABLE [dbo].[Historico_datas] DROP CONSTRAINT [FK__Historico__AG_NU__04E4BC85]
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__Historico__HD_RE__03F0984C]') AND parent_object_id = OBJECT_ID(N'[dbo].[Historico_datas]'))
ALTER TABLE [dbo].[Historico_datas] DROP CONSTRAINT [FK__Historico__HD_RE__03F0984C]
GO
IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_Historico_datas_HD_FLAGREMARCADO]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[Historico_datas] DROP CONSTRAINT [DF_Historico_datas_HD_FLAGREMARCADO]
END
GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Historico_datas]') AND type in (N'U'))
DROP TABLE [dbo].[Historico_datas]
GO
/****** Object:  Table [dbo].[Historico_Eventos]    Script Date: 07/27/2018 09:30:23 ******/
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__Historico__AG_NU__787EE5A0]') AND parent_object_id = OBJECT_ID(N'[dbo].[Historico_Eventos]'))
ALTER TABLE [dbo].[Historico_Eventos] DROP CONSTRAINT [FK__Historico__AG_NU__787EE5A0]
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__Historico__HE_RE__778AC167]') AND parent_object_id = OBJECT_ID(N'[dbo].[Historico_Eventos]'))
ALTER TABLE [dbo].[Historico_Eventos] DROP CONSTRAINT [FK__Historico__HE_RE__778AC167]
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__Historico__ID_SI__76969D2E]') AND parent_object_id = OBJECT_ID(N'[dbo].[Historico_Eventos]'))
ALTER TABLE [dbo].[Historico_Eventos] DROP CONSTRAINT [FK__Historico__ID_SI__76969D2E]
GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Historico_Eventos]') AND type in (N'U'))
DROP TABLE [dbo].[Historico_Eventos]
GO
/****** Object:  Table [dbo].[FAC_REL_CIRCUITO_AGENDAMENTO]    Script Date: 07/27/2018 09:30:20 ******/
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__FAC_REL_C__AG_NU__76226739]') AND parent_object_id = OBJECT_ID(N'[dbo].[FAC_REL_CIRCUITO_AGENDAMENTO]'))
ALTER TABLE [dbo].[FAC_REL_CIRCUITO_AGENDAMENTO] DROP CONSTRAINT [FK__FAC_REL_C__AG_NU__76226739]
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__FAC_REL_C__CTO_I__752E4300]') AND parent_object_id = OBJECT_ID(N'[dbo].[FAC_REL_CIRCUITO_AGENDAMENTO]'))
ALTER TABLE [dbo].[FAC_REL_CIRCUITO_AGENDAMENTO] DROP CONSTRAINT [FK__FAC_REL_C__CTO_I__752E4300]
GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[FAC_REL_CIRCUITO_AGENDAMENTO]') AND type in (N'U'))
DROP TABLE [dbo].[FAC_REL_CIRCUITO_AGENDAMENTO]
GO
/****** Object:  Table [dbo].[FAC_CIRCUITO]    Script Date: 07/27/2018 09:30:16 ******/
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__FAC_CIRCU__TPC_I__6BA4D8C6]') AND parent_object_id = OBJECT_ID(N'[dbo].[FAC_CIRCUITO]'))
ALTER TABLE [dbo].[FAC_CIRCUITO] DROP CONSTRAINT [FK__FAC_CIRCU__TPC_I__6BA4D8C6]
GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[FAC_CIRCUITO]') AND type in (N'U'))
DROP TABLE [dbo].[FAC_CIRCUITO]
GO
/****** Object:  Table [dbo].[FAC_REL_CARACTERISTICAS_TIPO]    Script Date: 07/27/2018 09:30:19 ******/
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__FAC_REL_C__CAR_I__743A1EC7]') AND parent_object_id = OBJECT_ID(N'[dbo].[FAC_REL_CARACTERISTICAS_TIPO]'))
ALTER TABLE [dbo].[FAC_REL_CARACTERISTICAS_TIPO] DROP CONSTRAINT [FK__FAC_REL_C__CAR_I__743A1EC7]
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__FAC_REL_C__TPC_I__7345FA8E]') AND parent_object_id = OBJECT_ID(N'[dbo].[FAC_REL_CARACTERISTICAS_TIPO]'))
ALTER TABLE [dbo].[FAC_REL_CARACTERISTICAS_TIPO] DROP CONSTRAINT [FK__FAC_REL_C__TPC_I__7345FA8E]
GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[FAC_REL_CARACTERISTICAS_TIPO]') AND type in (N'U'))
DROP TABLE [dbo].[FAC_REL_CARACTERISTICAS_TIPO]
GO
/****** Object:  Table [dbo].[FAC_TIPO_COMPONENTE]    Script Date: 07/27/2018 09:30:21 ******/
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__FAC_TIPO___FAB_I__77168B72]') AND parent_object_id = OBJECT_ID(N'[dbo].[FAC_TIPO_COMPONENTE]'))
ALTER TABLE [dbo].[FAC_TIPO_COMPONENTE] DROP CONSTRAINT [FK__FAC_TIPO___FAB_I__77168B72]
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__FAC_TIPO___FTC_I__780AAFAB]') AND parent_object_id = OBJECT_ID(N'[dbo].[FAC_TIPO_COMPONENTE]'))
ALTER TABLE [dbo].[FAC_TIPO_COMPONENTE] DROP CONSTRAINT [FK__FAC_TIPO___FTC_I__780AAFAB]
GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[FAC_TIPO_COMPONENTE]') AND type in (N'U'))
DROP TABLE [dbo].[FAC_TIPO_COMPONENTE]
GO
/****** Object:  Table [dbo].[Historico_EventosOS]    Script Date: 07/27/2018 09:30:23 ******/
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__Historico__HEOS___2180FB33]') AND parent_object_id = OBJECT_ID(N'[dbo].[Historico_EventosOS]'))
ALTER TABLE [dbo].[Historico_EventosOS] DROP CONSTRAINT [FK__Historico__HEOS___2180FB33]
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__Historico__ID_SI__208CD6FA]') AND parent_object_id = OBJECT_ID(N'[dbo].[Historico_EventosOS]'))
ALTER TABLE [dbo].[Historico_EventosOS] DROP CONSTRAINT [FK__Historico__ID_SI__208CD6FA]
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__Historico_Evento__22751F6C]') AND parent_object_id = OBJECT_ID(N'[dbo].[Historico_EventosOS]'))
ALTER TABLE [dbo].[Historico_EventosOS] DROP CONSTRAINT [FK__Historico_Evento__22751F6C]
GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Historico_EventosOS]') AND type in (N'U'))
DROP TABLE [dbo].[Historico_EventosOS]
GO
/****** Object:  Table [dbo].[Agenda_Servicos_Plataforma]    Script Date: 07/27/2018 09:30:12 ******/
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_Agenda_Servicos_Plataforma_Agendamento]') AND parent_object_id = OBJECT_ID(N'[dbo].[Agenda_Servicos_Plataforma]'))
ALTER TABLE [dbo].[Agenda_Servicos_Plataforma] DROP CONSTRAINT [FK_Agenda_Servicos_Plataforma_Agendamento]
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_Agenda_Servicos_Plataforma_Servicos_Plataformas]') AND parent_object_id = OBJECT_ID(N'[dbo].[Agenda_Servicos_Plataforma]'))
ALTER TABLE [dbo].[Agenda_Servicos_Plataforma] DROP CONSTRAINT [FK_Agenda_Servicos_Plataforma_Servicos_Plataformas]
GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Agenda_Servicos_Plataforma]') AND type in (N'U'))
DROP TABLE [dbo].[Agenda_Servicos_Plataforma]
GO
/****** Object:  Table [dbo].[SCE_PartNumberModelo]    Script Date: 07/27/2018 09:30:36 ******/
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_SCE_PartNumberModelo_SCE_Modelos]') AND parent_object_id = OBJECT_ID(N'[dbo].[SCE_PartNumberModelo]'))
ALTER TABLE [dbo].[SCE_PartNumberModelo] DROP CONSTRAINT [FK_SCE_PartNumberModelo_SCE_Modelos]
GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[SCE_PartNumberModelo]') AND type in (N'U'))
DROP TABLE [dbo].[SCE_PartNumberModelo]
GO
/****** Object:  Table [dbo].[LogBook_Agendamento]    Script Date: 07/27/2018 09:30:26 ******/
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__LogBook_A__AG_NU__74AE54BC]') AND parent_object_id = OBJECT_ID(N'[dbo].[LogBook_Agendamento]'))
ALTER TABLE [dbo].[LogBook_Agendamento] DROP CONSTRAINT [FK__LogBook_A__AG_NU__74AE54BC]
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__LogBook_A__LB_ID__75A278F5]') AND parent_object_id = OBJECT_ID(N'[dbo].[LogBook_Agendamento]'))
ALTER TABLE [dbo].[LogBook_Agendamento] DROP CONSTRAINT [FK__LogBook_A__LB_ID__75A278F5]
GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[LogBook_Agendamento]') AND type in (N'U'))
DROP TABLE [dbo].[LogBook_Agendamento]
GO
/****** Object:  Table [dbo].[DisposicaoLB]    Script Date: 07/27/2018 09:30:14 ******/
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_DisposicaoLB_LB_LogBook]') AND parent_object_id = OBJECT_ID(N'[dbo].[DisposicaoLB]'))
ALTER TABLE [dbo].[DisposicaoLB] DROP CONSTRAINT [FK_DisposicaoLB_LB_LogBook]
GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DisposicaoLB]') AND type in (N'U'))
DROP TABLE [dbo].[DisposicaoLB]
GO
/****** Object:  Table [dbo].[ResolucaoLB]    Script Date: 07/27/2018 09:30:30 ******/
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_ResolucaoLB_LB_LogBook]') AND parent_object_id = OBJECT_ID(N'[dbo].[ResolucaoLB]'))
ALTER TABLE [dbo].[ResolucaoLB] DROP CONSTRAINT [FK_ResolucaoLB_LB_LogBook]
GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ResolucaoLB]') AND type in (N'U'))
DROP TABLE [dbo].[ResolucaoLB]
GO
/****** Object:  Table [dbo].[LB_ACOESTOMADAS_ARQUIVOS]    Script Date: 07/27/2018 09:30:24 ******/
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_LB_ACOESTOMADAS_LB_ACOESTOMADAS_ARQUIVOS]') AND parent_object_id = OBJECT_ID(N'[dbo].[LB_ACOESTOMADAS_ARQUIVOS]'))
ALTER TABLE [dbo].[LB_ACOESTOMADAS_ARQUIVOS] DROP CONSTRAINT [FK_LB_ACOESTOMADAS_LB_ACOESTOMADAS_ARQUIVOS]
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_LB_LOGBOOK_LB_ACOESTOMADAS_ARQUIVOS]') AND parent_object_id = OBJECT_ID(N'[dbo].[LB_ACOESTOMADAS_ARQUIVOS]'))
ALTER TABLE [dbo].[LB_ACOESTOMADAS_ARQUIVOS] DROP CONSTRAINT [FK_LB_LOGBOOK_LB_ACOESTOMADAS_ARQUIVOS]
GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[LB_ACOESTOMADAS_ARQUIVOS]') AND type in (N'U'))
DROP TABLE [dbo].[LB_ACOESTOMADAS_ARQUIVOS]
GO
/****** Object:  Table [dbo].[SCE_AreasUtil_Modelo]    Script Date: 07/27/2018 09:30:31 ******/
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_SCE_AreasUtil_Modelo_SCE_AreaUtilizacao]') AND parent_object_id = OBJECT_ID(N'[dbo].[SCE_AreasUtil_Modelo]'))
ALTER TABLE [dbo].[SCE_AreasUtil_Modelo] DROP CONSTRAINT [FK_SCE_AreasUtil_Modelo_SCE_AreaUtilizacao]
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_SCE_AreasUtil_Modelo_SCE_Modelos]') AND parent_object_id = OBJECT_ID(N'[dbo].[SCE_AreasUtil_Modelo]'))
ALTER TABLE [dbo].[SCE_AreasUtil_Modelo] DROP CONSTRAINT [FK_SCE_AreasUtil_Modelo_SCE_Modelos]
GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[SCE_AreasUtil_Modelo]') AND type in (N'U'))
DROP TABLE [dbo].[SCE_AreasUtil_Modelo]
GO
/****** Object:  Table [dbo].[SCE_Acessorios]    Script Date: 07/27/2018 09:30:30 ******/
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_SCE_Acessorios_SCE_Equipamentos]') AND parent_object_id = OBJECT_ID(N'[dbo].[SCE_Acessorios]'))
ALTER TABLE [dbo].[SCE_Acessorios] DROP CONSTRAINT [FK_SCE_Acessorios_SCE_Equipamentos]
GO
IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_SCE_Acessorios_sequencial]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[SCE_Acessorios] DROP CONSTRAINT [DF_SCE_Acessorios_sequencial]
END
GO
IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_SCE_Acessorios_conforme]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[SCE_Acessorios] DROP CONSTRAINT [DF_SCE_Acessorios_conforme]
END
GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[SCE_Acessorios]') AND type in (N'U'))
DROP TABLE [dbo].[SCE_Acessorios]
GO
/****** Object:  Table [dbo].[Ordem_de_Servico]    Script Date: 07/27/2018 09:30:27 ******/
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_Ordem_de_Servico_Agendamento]') AND parent_object_id = OBJECT_ID(N'[dbo].[Ordem_de_Servico]'))
ALTER TABLE [dbo].[Ordem_de_Servico] DROP CONSTRAINT [FK_Ordem_de_Servico_Agendamento]
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_Ordem_de_Servico_SCE_Equipamentos]') AND parent_object_id = OBJECT_ID(N'[dbo].[Ordem_de_Servico]'))
ALTER TABLE [dbo].[Ordem_de_Servico] DROP CONSTRAINT [FK_Ordem_de_Servico_SCE_Equipamentos]
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_Ordem_de_Servico_Servicos_Plataformas_Plataforma]') AND parent_object_id = OBJECT_ID(N'[dbo].[Ordem_de_Servico]'))
ALTER TABLE [dbo].[Ordem_de_Servico] DROP CONSTRAINT [FK_Ordem_de_Servico_Servicos_Plataformas_Plataforma]
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_Ordem_de_Servico_Servicos_Plataformas_Servico]') AND parent_object_id = OBJECT_ID(N'[dbo].[Ordem_de_Servico]'))
ALTER TABLE [dbo].[Ordem_de_Servico] DROP CONSTRAINT [FK_Ordem_de_Servico_Servicos_Plataformas_Servico]
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_Ordem_de_Servico_Testes]') AND parent_object_id = OBJECT_ID(N'[dbo].[Ordem_de_Servico]'))
ALTER TABLE [dbo].[Ordem_de_Servico] DROP CONSTRAINT [FK_Ordem_de_Servico_Testes]
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_Ordem_de_Servico_UserCRT]') AND parent_object_id = OBJECT_ID(N'[dbo].[Ordem_de_Servico]'))
ALTER TABLE [dbo].[Ordem_de_Servico] DROP CONSTRAINT [FK_Ordem_de_Servico_UserCRT]
GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Ordem_de_Servico]') AND type in (N'U'))
DROP TABLE [dbo].[Ordem_de_Servico]
GO
/****** Object:  Table [dbo].[TESTES]    Script Date: 07/27/2018 09:30:43 ******/
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_Testes_Tipo_Teste]') AND parent_object_id = OBJECT_ID(N'[dbo].[TESTES]'))
ALTER TABLE [dbo].[TESTES] DROP CONSTRAINT [FK_Testes_Tipo_Teste]
GO
IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF__Testes__TIT_ID__1D5CFB42]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[TESTES] DROP CONSTRAINT [DF__Testes__TIT_ID__1D5CFB42]
END
GO
IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF__Testes__T_PERIOD__212D8C26]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[TESTES] DROP CONSTRAINT [DF__Testes__T_PERIOD__212D8C26]
END
GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[TESTES]') AND type in (N'U'))
DROP TABLE [dbo].[TESTES]
GO
/****** Object:  Table [dbo].[HISTORICO_PLATAFORMA_EQUIPAMENTOS]    Script Date: 07/27/2018 09:30:23 ******/
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_HISTORICO_PLATAFORMA_EQUIPAMENTOS_SCE_EQUIPAMENTOS]') AND parent_object_id = OBJECT_ID(N'[dbo].[HISTORICO_PLATAFORMA_EQUIPAMENTOS]'))
ALTER TABLE [dbo].[HISTORICO_PLATAFORMA_EQUIPAMENTOS] DROP CONSTRAINT [FK_HISTORICO_PLATAFORMA_EQUIPAMENTOS_SCE_EQUIPAMENTOS]
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_HISTORICO_PLATAFORMA_EQUIPAMENTOS_SERVICOS_PLATAFORMAS]') AND parent_object_id = OBJECT_ID(N'[dbo].[HISTORICO_PLATAFORMA_EQUIPAMENTOS]'))
ALTER TABLE [dbo].[HISTORICO_PLATAFORMA_EQUIPAMENTOS] DROP CONSTRAINT [FK_HISTORICO_PLATAFORMA_EQUIPAMENTOS_SERVICOS_PLATAFORMAS]
GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[HISTORICO_PLATAFORMA_EQUIPAMENTOS]') AND type in (N'U'))
DROP TABLE [dbo].[HISTORICO_PLATAFORMA_EQUIPAMENTOS]
GO
/****** Object:  Table [dbo].[SCE_Equipamentos_Controle]    Script Date: 07/27/2018 09:30:33 ******/
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_SCE_Equipamentos_Controle_EQ_ID]') AND parent_object_id = OBJECT_ID(N'[dbo].[SCE_Equipamentos_Controle]'))
ALTER TABLE [dbo].[SCE_Equipamentos_Controle] DROP CONSTRAINT [FK_SCE_Equipamentos_Controle_EQ_ID]
GO
IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_SCE_Equipamentos_Controle_EQC_DATA]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[SCE_Equipamentos_Controle] DROP CONSTRAINT [DF_SCE_Equipamentos_Controle_EQC_DATA]
END
GO
IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_SCE_Equipamentos_Controle_EQC_TIPO]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[SCE_Equipamentos_Controle] DROP CONSTRAINT [DF_SCE_Equipamentos_Controle_EQC_TIPO]
END
GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[SCE_Equipamentos_Controle]') AND type in (N'U'))
DROP TABLE [dbo].[SCE_Equipamentos_Controle]
GO
/****** Object:  Table [dbo].[SCE_Passagem_Carga]    Script Date: 07/27/2018 09:30:37 ******/
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_SCE_Passagem_Carga_AG_NUMERO_DEST]') AND parent_object_id = OBJECT_ID(N'[dbo].[SCE_Passagem_Carga]'))
ALTER TABLE [dbo].[SCE_Passagem_Carga] DROP CONSTRAINT [FK_SCE_Passagem_Carga_AG_NUMERO_DEST]
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_SCE_Passagem_Carga_AG_NUMERO_ORIG]') AND parent_object_id = OBJECT_ID(N'[dbo].[SCE_Passagem_Carga]'))
ALTER TABLE [dbo].[SCE_Passagem_Carga] DROP CONSTRAINT [FK_SCE_Passagem_Carga_AG_NUMERO_ORIG]
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_SCE_Passagem_Carga_EQ_ID]') AND parent_object_id = OBJECT_ID(N'[dbo].[SCE_Passagem_Carga]'))
ALTER TABLE [dbo].[SCE_Passagem_Carga] DROP CONSTRAINT [FK_SCE_Passagem_Carga_EQ_ID]
GO
IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF__SCE_Passa__PAS_D__1AFFB184]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[SCE_Passagem_Carga] DROP CONSTRAINT [DF__SCE_Passa__PAS_D__1AFFB184]
END
GO
IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF__SCE_Passa__PAS_A__1BF3D5BD]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[SCE_Passagem_Carga] DROP CONSTRAINT [DF__SCE_Passa__PAS_A__1BF3D5BD]
END
GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[SCE_Passagem_Carga]') AND type in (N'U'))
DROP TABLE [dbo].[SCE_Passagem_Carga]
GO
/****** Object:  Table [dbo].[HISTORICO_ARQUIVOS]    Script Date: 07/27/2018 09:30:22 ******/
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_HISTORICO_ARQUIVOS_Arquivos]') AND parent_object_id = OBJECT_ID(N'[dbo].[HISTORICO_ARQUIVOS]'))
ALTER TABLE [dbo].[HISTORICO_ARQUIVOS] DROP CONSTRAINT [FK_HISTORICO_ARQUIVOS_Arquivos]
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_Historico_Arquivos_UserCRT]') AND parent_object_id = OBJECT_ID(N'[dbo].[HISTORICO_ARQUIVOS]'))
ALTER TABLE [dbo].[HISTORICO_ARQUIVOS] DROP CONSTRAINT [FK_Historico_Arquivos_UserCRT]
GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[HISTORICO_ARQUIVOS]') AND type in (N'U'))
DROP TABLE [dbo].[HISTORICO_ARQUIVOS]
GO
/****** Object:  Table [dbo].[Diagramas]    Script Date: 07/27/2018 09:30:14 ******/
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__Diagramas__AG_NU__0E6E26BF]') AND parent_object_id = OBJECT_ID(N'[dbo].[Diagramas]'))
ALTER TABLE [dbo].[Diagramas] DROP CONSTRAINT [FK__Diagramas__AG_NU__0E6E26BF]
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__Diagramas__ARQ_C__0D7A0286]') AND parent_object_id = OBJECT_ID(N'[dbo].[Diagramas]'))
ALTER TABLE [dbo].[Diagramas] DROP CONSTRAINT [FK__Diagramas__ARQ_C__0D7A0286]
GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Diagramas]') AND type in (N'U'))
DROP TABLE [dbo].[Diagramas]
GO
/****** Object:  Table [dbo].[Agendamento]    Script Date: 07/27/2018 09:30:12 ******/
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_Agendamento_Tecnologia]') AND parent_object_id = OBJECT_ID(N'[dbo].[Agendamento]'))
ALTER TABLE [dbo].[Agendamento] DROP CONSTRAINT [FK_Agendamento_Tecnologia]
GO
IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_Agendamento_AG_SIGILO]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[Agendamento] DROP CONSTRAINT [DF_Agendamento_AG_SIGILO]
END
GO
IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_Agendamento_AG_FLAGREMARCACAO]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[Agendamento] DROP CONSTRAINT [DF_Agendamento_AG_FLAGREMARCACAO]
END
GO
IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_Agendamento_AG_RECEBEMAIL]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[Agendamento] DROP CONSTRAINT [DF_Agendamento_AG_RECEBEMAIL]
END
GO
IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_Agendamento_AG_REPETIDO]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[Agendamento] DROP CONSTRAINT [DF_Agendamento_AG_REPETIDO]
END
GO
IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF__Agendamen__AG_EX__1E662E14]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[Agendamento] DROP CONSTRAINT [DF__Agendamen__AG_EX__1E662E14]
END
GO
IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF__Agendamen__AG_SO__2B8B1F08]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[Agendamento] DROP CONSTRAINT [DF__Agendamen__AG_SO__2B8B1F08]
END
GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Agendamento]') AND type in (N'U'))
DROP TABLE [dbo].[Agendamento]
GO
/****** Object:  Table [dbo].[TECNOLOGIA]    Script Date: 07/27/2018 09:30:42 ******/
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_Tecnologia_Area_Tecnologica]') AND parent_object_id = OBJECT_ID(N'[dbo].[TECNOLOGIA]'))
ALTER TABLE [dbo].[TECNOLOGIA] DROP CONSTRAINT [FK_Tecnologia_Area_Tecnologica]
GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[TECNOLOGIA]') AND type in (N'U'))
DROP TABLE [dbo].[TECNOLOGIA]
GO
/****** Object:  Table [dbo].[Arquivos]    Script Date: 07/27/2018 09:30:13 ******/
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__Arquivos__ARQ_CO__0A9D95DB]') AND parent_object_id = OBJECT_ID(N'[dbo].[Arquivos]'))
ALTER TABLE [dbo].[Arquivos] DROP CONSTRAINT [FK__Arquivos__ARQ_CO__0A9D95DB]
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__Arquivos__ARQ_ID__0B91BA14]') AND parent_object_id = OBJECT_ID(N'[dbo].[Arquivos]'))
ALTER TABLE [dbo].[Arquivos] DROP CONSTRAINT [FK__Arquivos__ARQ_ID__0B91BA14]
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__Arquivos__ARQ_ID__0C85DE4D]') AND parent_object_id = OBJECT_ID(N'[dbo].[Arquivos]'))
ALTER TABLE [dbo].[Arquivos] DROP CONSTRAINT [FK__Arquivos__ARQ_ID__0C85DE4D]
GO
IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_Arquivos_ARQ_OCULTAR]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[Arquivos] DROP CONSTRAINT [DF_Arquivos_ARQ_OCULTAR]
END
GO
IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_Arquivos_ARQ_OS]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[Arquivos] DROP CONSTRAINT [DF_Arquivos_ARQ_OS]
END
GO
IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_Arquivos_ARQ_VALIDACAO]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[Arquivos] DROP CONSTRAINT [DF_Arquivos_ARQ_VALIDACAO]
END
GO
IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_Arquivos_ARQ_NOTIFICACAOEXPIRACAO]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[Arquivos] DROP CONSTRAINT [DF_Arquivos_ARQ_NOTIFICACAOEXPIRACAO]
END
GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Arquivos]') AND type in (N'U'))
DROP TABLE [dbo].[Arquivos]
GO
/****** Object:  Table [dbo].[LB_ACOESTOMADAS]    Script Date: 07/27/2018 09:30:24 ******/
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_LB_ACOESTOMADAS_LB_LogBook]') AND parent_object_id = OBJECT_ID(N'[dbo].[LB_ACOESTOMADAS]'))
ALTER TABLE [dbo].[LB_ACOESTOMADAS] DROP CONSTRAINT [FK_LB_ACOESTOMADAS_LB_LogBook]
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_LB_ACOESTOMADAS_LB_TIPOACAOTOMADA]') AND parent_object_id = OBJECT_ID(N'[dbo].[LB_ACOESTOMADAS]'))
ALTER TABLE [dbo].[LB_ACOESTOMADAS] DROP CONSTRAINT [FK_LB_ACOESTOMADAS_LB_TIPOACAOTOMADA]
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_LB_ACOESTOMADAS_USERCRT]') AND parent_object_id = OBJECT_ID(N'[dbo].[LB_ACOESTOMADAS]'))
ALTER TABLE [dbo].[LB_ACOESTOMADAS] DROP CONSTRAINT [FK_LB_ACOESTOMADAS_USERCRT]
GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[LB_ACOESTOMADAS]') AND type in (N'U'))
DROP TABLE [dbo].[LB_ACOESTOMADAS]
GO
/****** Object:  Table [dbo].[LB_LogBook]    Script Date: 07/27/2018 09:30:25 ******/
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__LB_LogBoo__LBTO___73BA3083]') AND parent_object_id = OBJECT_ID(N'[dbo].[LB_LogBook]'))
ALTER TABLE [dbo].[LB_LogBook] DROP CONSTRAINT [FK__LB_LogBoo__LBTO___73BA3083]
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_LB_LogBook_UserCRT]') AND parent_object_id = OBJECT_ID(N'[dbo].[LB_LogBook]'))
ALTER TABLE [dbo].[LB_LogBook] DROP CONSTRAINT [FK_LB_LogBook_UserCRT]
GO
IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_LB_LogBook_LB_CONCLUIDO]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[LB_LogBook] DROP CONSTRAINT [DF_LB_LogBook_LB_CONCLUIDO]
END
GO
IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_LB_LogBook_LB_CONCLUIDOGQ]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[LB_LogBook] DROP CONSTRAINT [DF_LB_LogBook_LB_CONCLUIDOGQ]
END
GO
IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_LB_LogBook_LB_CRITICIDADE]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[LB_LogBook] DROP CONSTRAINT [DF_LB_LogBook_LB_CRITICIDADE]
END
GO
IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_LB_LogBook_LB_OPM]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[LB_LogBook] DROP CONSTRAINT [DF_LB_LogBook_LB_OPM]
END
GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[LB_LogBook]') AND type in (N'U'))
DROP TABLE [dbo].[LB_LogBook]
GO
/****** Object:  Table [dbo].[UserCRT]    Script Date: 07/27/2018 09:30:45 ******/
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_UserCRT_Orgao]') AND parent_object_id = OBJECT_ID(N'[dbo].[UserCRT]'))
ALTER TABLE [dbo].[UserCRT] DROP CONSTRAINT [FK_UserCRT_Orgao]
GO
IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_UserCRT_RT]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[UserCRT] DROP CONSTRAINT [DF_UserCRT_RT]
END
GO
IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_UserCRT_RAT]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[UserCRT] DROP CONSTRAINT [DF_UserCRT_RAT]
END
GO
IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_UserCRT_Exibir]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[UserCRT] DROP CONSTRAINT [DF_UserCRT_Exibir]
END
GO
IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_UserCRT_GQ]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[UserCRT] DROP CONSTRAINT [DF_UserCRT_GQ]
END
GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[UserCRT]') AND type in (N'U'))
DROP TABLE [dbo].[UserCRT]
GO
/****** Object:  Table [dbo].[SCE_Movimentacao]    Script Date: 07/27/2018 09:30:35 ******/
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_SCE_Movimentacao_SCE_Documentacao]') AND parent_object_id = OBJECT_ID(N'[dbo].[SCE_Movimentacao]'))
ALTER TABLE [dbo].[SCE_Movimentacao] DROP CONSTRAINT [FK_SCE_Movimentacao_SCE_Documentacao]
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_SCE_Movimentacao_SCE_Equipamentos]') AND parent_object_id = OBJECT_ID(N'[dbo].[SCE_Movimentacao]'))
ALTER TABLE [dbo].[SCE_Movimentacao] DROP CONSTRAINT [FK_SCE_Movimentacao_SCE_Equipamentos]
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_SCE_Movimentacao_SCE_Natureza_Operacao]') AND parent_object_id = OBJECT_ID(N'[dbo].[SCE_Movimentacao]'))
ALTER TABLE [dbo].[SCE_Movimentacao] DROP CONSTRAINT [FK_SCE_Movimentacao_SCE_Natureza_Operacao]
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_SCE_Movimentacao_SCE_Nota_Fiscal]') AND parent_object_id = OBJECT_ID(N'[dbo].[SCE_Movimentacao]'))
ALTER TABLE [dbo].[SCE_Movimentacao] DROP CONSTRAINT [FK_SCE_Movimentacao_SCE_Nota_Fiscal]
GO
IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_SCE_Movimentacao_MOV_DATA]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[SCE_Movimentacao] DROP CONSTRAINT [DF_SCE_Movimentacao_MOV_DATA]
END
GO
IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF__SCE_Movim__MOV_P__22A0D34C]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[SCE_Movimentacao] DROP CONSTRAINT [DF__SCE_Movim__MOV_P__22A0D34C]
END
GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[SCE_Movimentacao]') AND type in (N'U'))
DROP TABLE [dbo].[SCE_Movimentacao]
GO
/****** Object:  Table [dbo].[SCE_Nota_Fiscal]    Script Date: 07/27/2018 09:30:36 ******/
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_SCE_Nota_Fiscal_SCE_Empresa_Nota_Fiscal]') AND parent_object_id = OBJECT_ID(N'[dbo].[SCE_Nota_Fiscal]'))
ALTER TABLE [dbo].[SCE_Nota_Fiscal] DROP CONSTRAINT [FK_SCE_Nota_Fiscal_SCE_Empresa_Nota_Fiscal]
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_SCE_Nota_Fiscal_SCE_Empresa_Nota_Fiscal_Transportadora]') AND parent_object_id = OBJECT_ID(N'[dbo].[SCE_Nota_Fiscal]'))
ALTER TABLE [dbo].[SCE_Nota_Fiscal] DROP CONSTRAINT [FK_SCE_Nota_Fiscal_SCE_Empresa_Nota_Fiscal_Transportadora]
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_SCE_Nota_Fiscal_SCE_Nota_Fiscal]') AND parent_object_id = OBJECT_ID(N'[dbo].[SCE_Nota_Fiscal]'))
ALTER TABLE [dbo].[SCE_Nota_Fiscal] DROP CONSTRAINT [FK_SCE_Nota_Fiscal_SCE_Nota_Fiscal]
GO
IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_SCE_Nota_Fiscal_NF_DATAEMISSAO]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[SCE_Nota_Fiscal] DROP CONSTRAINT [DF_SCE_Nota_Fiscal_NF_DATAEMISSAO]
END
GO
IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_SCE_Nota_Fiscal_nf_data]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[SCE_Nota_Fiscal] DROP CONSTRAINT [DF_SCE_Nota_Fiscal_nf_data]
END
GO
IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_SCE_Nota_Fiscal_nf_recebimento]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[SCE_Nota_Fiscal] DROP CONSTRAINT [DF_SCE_Nota_Fiscal_nf_recebimento]
END
GO
IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF__SCE_Nota___NF_DE__126A6B83]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[SCE_Nota_Fiscal] DROP CONSTRAINT [DF__SCE_Nota___NF_DE__126A6B83]
END
GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[SCE_Nota_Fiscal]') AND type in (N'U'))
DROP TABLE [dbo].[SCE_Nota_Fiscal]
GO
/****** Object:  Table [dbo].[SCE_Documentacao]    Script Date: 07/27/2018 09:30:32 ******/
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_SCE_Documentacao_ENF_ID]') AND parent_object_id = OBJECT_ID(N'[dbo].[SCE_Documentacao]'))
ALTER TABLE [dbo].[SCE_Documentacao] DROP CONSTRAINT [FK_SCE_Documentacao_ENF_ID]
GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[SCE_Documentacao]') AND type in (N'U'))
DROP TABLE [dbo].[SCE_Documentacao]
GO
/****** Object:  Table [dbo].[SCE_Empresa_Nota_Fiscal]    Script Date: 07/27/2018 09:30:32 ******/
IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_SCE_Empresa_Nota_Fiscal_ENF_TIPOEMPRESA]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[SCE_Empresa_Nota_Fiscal] DROP CONSTRAINT [DF_SCE_Empresa_Nota_Fiscal_ENF_TIPOEMPRESA]
END
GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[SCE_Empresa_Nota_Fiscal]') AND type in (N'U'))
DROP TABLE [dbo].[SCE_Empresa_Nota_Fiscal]
GO
/****** Object:  Table [dbo].[SCE_Equipamentos]    Script Date: 07/27/2018 09:30:32 ******/
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_SCE_Equipamentos_SCE_Modelos]') AND parent_object_id = OBJECT_ID(N'[dbo].[SCE_Equipamentos]'))
ALTER TABLE [dbo].[SCE_Equipamentos] DROP CONSTRAINT [FK_SCE_Equipamentos_SCE_Modelos]
GO
IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_SCE_Equipamentos_STATUS]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[SCE_Equipamentos] DROP CONSTRAINT [DF_SCE_Equipamentos_STATUS]
END
GO
IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_SCE_Equipamentos_EQ_OPER_DELTA]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[SCE_Equipamentos] DROP CONSTRAINT [DF_SCE_Equipamentos_EQ_OPER_DELTA]
END
GO
IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_SCE_Equipamentos_EQ_OPER_UMIDADE]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[SCE_Equipamentos] DROP CONSTRAINT [DF_SCE_Equipamentos_EQ_OPER_UMIDADE]
END
GO
IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_SCE_Equipamentos_EQ_OPER_WARMUP]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[SCE_Equipamentos] DROP CONSTRAINT [DF_SCE_Equipamentos_EQ_OPER_WARMUP]
END
GO
IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_SCE_Equipamentos_EQ_ARMA_DELTA]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[SCE_Equipamentos] DROP CONSTRAINT [DF_SCE_Equipamentos_EQ_ARMA_DELTA]
END
GO
IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_SCE_Equipamentos_EQ_ARMA_UMIDADE]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[SCE_Equipamentos] DROP CONSTRAINT [DF_SCE_Equipamentos_EQ_ARMA_UMIDADE]
END
GO
IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_SCE_Equipamentos_EQ_INSTRUMENTAL]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[SCE_Equipamentos] DROP CONSTRAINT [DF_SCE_Equipamentos_EQ_INSTRUMENTAL]
END
GO
IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_SCE_Equipamentos_EQ_PROPRIEDADE]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[SCE_Equipamentos] DROP CONSTRAINT [DF_SCE_Equipamentos_EQ_PROPRIEDADE]
END
GO
IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_SCE_Equipamentos_EQ_CONFORME]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[SCE_Equipamentos] DROP CONSTRAINT [DF_SCE_Equipamentos_EQ_CONFORME]
END
GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[SCE_Equipamentos]') AND type in (N'U'))
DROP TABLE [dbo].[SCE_Equipamentos]
GO
/****** Object:  Table [dbo].[SCE_Modelos]    Script Date: 07/27/2018 09:30:34 ******/
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_SCE_MODELOS_FAB_ID]') AND parent_object_id = OBJECT_ID(N'[dbo].[SCE_Modelos]'))
ALTER TABLE [dbo].[SCE_Modelos] DROP CONSTRAINT [FK_SCE_MODELOS_FAB_ID]
GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[SCE_Modelos]') AND type in (N'U'))
DROP TABLE [dbo].[SCE_Modelos]
GO
/****** Object:  Table [dbo].[FAC_CARACTERISTICAS]    Script Date: 07/27/2018 09:30:15 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[FAC_CARACTERISTICAS]') AND type in (N'U'))
DROP TABLE [dbo].[FAC_CARACTERISTICAS]
GO
/****** Object:  Table [dbo].[Mensagem]    Script Date: 07/27/2018 09:30:26 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Mensagem]') AND type in (N'U'))
DROP TABLE [dbo].[Mensagem]
GO
/****** Object:  Rule [dbo].[TIPO_LOCAL_EQUP]    Script Date: 07/27/2018 09:30:45 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[TIPO_LOCAL_EQUP]') AND OBJECTPROPERTY(object_id, N'IsRule') = 1)
DROP RULE [dbo].[TIPO_LOCAL_EQUP]
GO
/****** Object:  Table [dbo].[EquipeEmbratel]    Script Date: 07/27/2018 09:30:14 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[EquipeEmbratel]') AND type in (N'U'))
DROP TABLE [dbo].[EquipeEmbratel]
GO
/****** Object:  Table [dbo].[Transporte]    Script Date: 07/27/2018 09:30:45 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Transporte]') AND type in (N'U'))
DROP TABLE [dbo].[Transporte]
GO
/****** Object:  Rule [dbo].[VERIFICA_ANO]    Script Date: 07/27/2018 09:30:45 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[VERIFICA_ANO]') AND OBJECTPROPERTY(object_id, N'IsRule') = 1)
DROP RULE [dbo].[VERIFICA_ANO]
GO
/****** Object:  Rule [dbo].[ru_SCE_RESERVA_EQ_SETUP]    Script Date: 07/27/2018 09:30:45 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ru_SCE_RESERVA_EQ_SETUP]') AND OBJECTPROPERTY(object_id, N'IsRule') = 1)
DROP RULE [dbo].[ru_SCE_RESERVA_EQ_SETUP]
GO
/****** Object:  Rule [dbo].[ru_SCE_RESERVA_EQ_ACEITO]    Script Date: 07/27/2018 09:30:45 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ru_SCE_RESERVA_EQ_ACEITO]') AND OBJECTPROPERTY(object_id, N'IsRule') = 1)
DROP RULE [dbo].[ru_SCE_RESERVA_EQ_ACEITO]
GO
/****** Object:  Table [dbo].[Servicos_Plataformas]    Script Date: 07/27/2018 09:30:40 ******/
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_SERVICOS_PLATAFORMAS_SERVICOS_PLATAFORMAS_PAI]') AND parent_object_id = OBJECT_ID(N'[dbo].[Servicos_Plataformas]'))
ALTER TABLE [dbo].[Servicos_Plataformas] DROP CONSTRAINT [FK_SERVICOS_PLATAFORMAS_SERVICOS_PLATAFORMAS_PAI]
GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Servicos_Plataformas]') AND type in (N'U'))
DROP TABLE [dbo].[Servicos_Plataformas]
GO
/****** Object:  Table [dbo].[TipoArquivo]    Script Date: 07/27/2018 09:30:44 ******/
IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_TipoArquivo_TAR_CONFIDENCIAL]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[TipoArquivo] DROP CONSTRAINT [DF_TipoArquivo_TAR_CONFIDENCIAL]
END
GO
IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_TipoArquivo_TAR_DocQual]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[TipoArquivo] DROP CONSTRAINT [DF_TipoArquivo_TAR_DocQual]
END
GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[TipoArquivo]') AND type in (N'U'))
DROP TABLE [dbo].[TipoArquivo]
GO
/****** Object:  Table [dbo].[PesquisaSatisfacao]    Script Date: 07/27/2018 09:30:28 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[PesquisaSatisfacao]') AND type in (N'U'))
DROP TABLE [dbo].[PesquisaSatisfacao]
GO
/****** Object:  Table [dbo].[SituacaoArquivo]    Script Date: 07/27/2018 09:30:40 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[SituacaoArquivo]') AND type in (N'U'))
DROP TABLE [dbo].[SituacaoArquivo]
GO
/****** Object:  Table [dbo].[SCE_Historico_Movimentacao]    Script Date: 07/27/2018 09:30:34 ******/
IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_SCE_Historico_Movimentacao_DATA]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[SCE_Historico_Movimentacao] DROP CONSTRAINT [DF_SCE_Historico_Movimentacao_DATA]
END
GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[SCE_Historico_Movimentacao]') AND type in (N'U'))
DROP TABLE [dbo].[SCE_Historico_Movimentacao]
GO
/****** Object:  Table [dbo].[SCE_Tipos]    Script Date: 07/27/2018 09:30:39 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[SCE_Tipos]') AND type in (N'U'))
DROP TABLE [dbo].[SCE_Tipos]
GO
/****** Object:  Table [dbo].[SCE_Tipo_NO]    Script Date: 07/27/2018 09:30:38 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[SCE_Tipo_NO]') AND type in (N'U'))
DROP TABLE [dbo].[SCE_Tipo_NO]
GO
/****** Object:  Table [dbo].[SCE_Natureza_Operacao]    Script Date: 07/27/2018 09:30:35 ******/
IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_SCE_Natureza_Operacao_CDE]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[SCE_Natureza_Operacao] DROP CONSTRAINT [DF_SCE_Natureza_Operacao_CDE]
END
GO
IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_SCE_Natureza_Operacao_DEFEITO]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[SCE_Natureza_Operacao] DROP CONSTRAINT [DF_SCE_Natureza_Operacao_DEFEITO]
END
GO
IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_SCE_Natureza_Operacao_PRAZO]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[SCE_Natureza_Operacao] DROP CONSTRAINT [DF_SCE_Natureza_Operacao_PRAZO]
END
GO
IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_SCE_Natureza_Operacao_ASA]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[SCE_Natureza_Operacao] DROP CONSTRAINT [DF_SCE_Natureza_Operacao_ASA]
END
GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[SCE_Natureza_Operacao]') AND type in (N'U'))
DROP TABLE [dbo].[SCE_Natureza_Operacao]
GO
/****** Object:  Table [dbo].[Tipo_Sigilo]    Script Date: 07/27/2018 09:30:43 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Tipo_Sigilo]') AND type in (N'U'))
DROP TABLE [dbo].[Tipo_Sigilo]
GO
/****** Object:  Table [dbo].[Tipo_Atividade]    Script Date: 07/27/2018 09:30:43 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Tipo_Atividade]') AND type in (N'U'))
DROP TABLE [dbo].[Tipo_Atividade]
GO
/****** Object:  Table [dbo].[FAC_FAMILIA_TIPO_COMPONENTE]    Script Date: 07/27/2018 09:30:18 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[FAC_FAMILIA_TIPO_COMPONENTE]') AND type in (N'U'))
DROP TABLE [dbo].[FAC_FAMILIA_TIPO_COMPONENTE]
GO
/****** Object:  Table [dbo].[FAC_TIPO_CIRCUITO]    Script Date: 07/27/2018 09:30:20 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[FAC_TIPO_CIRCUITO]') AND type in (N'U'))
DROP TABLE [dbo].[FAC_TIPO_CIRCUITO]
GO
/****** Object:  Table [dbo].[Area_Tecnologica]    Script Date: 07/27/2018 09:30:13 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Area_Tecnologica]') AND type in (N'U'))
DROP TABLE [dbo].[Area_Tecnologica]
GO
/****** Object:  Table [dbo].[FAC_FABRICANTE_TIPO_COMPONENTE]    Script Date: 07/27/2018 09:30:17 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[FAC_FABRICANTE_TIPO_COMPONENTE]') AND type in (N'U'))
DROP TABLE [dbo].[FAC_FABRICANTE_TIPO_COMPONENTE]
GO
/****** Object:  Table [dbo].[Ambientes]    Script Date: 07/27/2018 09:30:12 ******/
IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF__ambientes__AMB_U__1BA9BCFA]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[Ambientes] DROP CONSTRAINT [DF__ambientes__AMB_U__1BA9BCFA]
END
GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Ambientes]') AND type in (N'U'))
DROP TABLE [dbo].[Ambientes]
GO
/****** Object:  Table [dbo].[Perfil_SCE]    Script Date: 07/27/2018 09:30:28 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Perfil_SCE]') AND type in (N'U'))
DROP TABLE [dbo].[Perfil_SCE]
GO
/****** Object:  Table [dbo].[SCE_TipoMovimentacao]    Script Date: 07/27/2018 09:30:39 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[SCE_TipoMovimentacao]') AND type in (N'U'))
DROP TABLE [dbo].[SCE_TipoMovimentacao]
GO
/****** Object:  Rule [dbo].[ru_SCE_PROPRIEDADE_EQUIPAMENTO]    Script Date: 07/27/2018 09:30:45 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ru_SCE_PROPRIEDADE_EQUIPAMENTO]') AND OBJECTPROPERTY(object_id, N'IsRule') = 1)
DROP RULE [dbo].[ru_SCE_PROPRIEDADE_EQUIPAMENTO]
GO
/****** Object:  Table [dbo].[Situacoes]    Script Date: 07/27/2018 09:30:41 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Situacoes]') AND type in (N'U'))
DROP TABLE [dbo].[Situacoes]
GO
/****** Object:  Table [dbo].[FAC_AS_Componente]    Script Date: 07/27/2018 09:30:15 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[FAC_AS_Componente]') AND type in (N'U'))
DROP TABLE [dbo].[FAC_AS_Componente]
GO
/****** Object:  Table [dbo].[FAC_TIPO_INTERFACE]    Script Date: 07/27/2018 09:30:21 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[FAC_TIPO_INTERFACE]') AND type in (N'U'))
DROP TABLE [dbo].[FAC_TIPO_INTERFACE]
GO
/****** Object:  Table [dbo].[PLATAFORMA_EQUIPAMENTOS]    Script Date: 07/27/2018 09:30:29 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[PLATAFORMA_EQUIPAMENTOS]') AND type in (N'U'))
DROP TABLE [dbo].[PLATAFORMA_EQUIPAMENTOS]
GO
/****** Object:  Table [dbo].[FAC_COMPONENTES_INTERFACE]    Script Date: 07/27/2018 09:30:16 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[FAC_COMPONENTES_INTERFACE]') AND type in (N'U'))
DROP TABLE [dbo].[FAC_COMPONENTES_INTERFACE]
GO
/****** Object:  Table [dbo].[TAREFAS]    Script Date: 07/27/2018 09:30:41 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[TAREFAS]') AND type in (N'U'))
DROP TABLE [dbo].[TAREFAS]
GO
/****** Object:  Table [dbo].[Orgao]    Script Date: 07/27/2018 09:30:27 ******/
IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_Orgao_ORGA_EXIBIR]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[Orgao] DROP CONSTRAINT [DF_Orgao_ORGA_EXIBIR]
END
GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Orgao]') AND type in (N'U'))
DROP TABLE [dbo].[Orgao]
GO
/****** Object:  Table [dbo].[SCE_Usuarios]    Script Date: 07/27/2018 09:30:39 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[SCE_Usuarios]') AND type in (N'U'))
DROP TABLE [dbo].[SCE_Usuarios]
GO
/****** Object:  Table [dbo].[SCE_Historico]    Script Date: 07/27/2018 09:30:34 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[SCE_Historico]') AND type in (N'U'))
DROP TABLE [dbo].[SCE_Historico]
GO
/****** Object:  Table [dbo].[SCE_Fabricantes]    Script Date: 07/27/2018 09:30:33 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[SCE_Fabricantes]') AND type in (N'U'))
DROP TABLE [dbo].[SCE_Fabricantes]
GO
/****** Object:  Table [dbo].[SCE_AreaUtilizacao]    Script Date: 07/27/2018 09:30:31 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[SCE_AreaUtilizacao]') AND type in (N'U'))
DROP TABLE [dbo].[SCE_AreaUtilizacao]
GO
/****** Object:  Rule [dbo].[ru_SCE_EMPRESA_TIPO]    Script Date: 07/27/2018 09:30:45 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ru_SCE_EMPRESA_TIPO]') AND OBJECTPROPERTY(object_id, N'IsRule') = 1)
DROP RULE [dbo].[ru_SCE_EMPRESA_TIPO]
GO
/****** Object:  Table [dbo].[Tipo_Teste]    Script Date: 07/27/2018 09:30:44 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Tipo_Teste]') AND type in (N'U'))
DROP TABLE [dbo].[Tipo_Teste]
GO
/****** Object:  Table [dbo].[SCE_Rel_Gerencial_Anual_NF_Mov]    Script Date: 07/27/2018 09:30:37 ******/
IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF__SCE_Rel_G__DATAC__18984625]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[SCE_Rel_Gerencial_Anual_NF_Mov] DROP CONSTRAINT [DF__SCE_Rel_G__DATAC__18984625]
END
GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[SCE_Rel_Gerencial_Anual_NF_Mov]') AND type in (N'U'))
DROP TABLE [dbo].[SCE_Rel_Gerencial_Anual_NF_Mov]
GO
/****** Object:  Table [dbo].[LB_TipoOcorrencia]    Script Date: 07/27/2018 09:30:26 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[LB_TipoOcorrencia]') AND type in (N'U'))
DROP TABLE [dbo].[LB_TipoOcorrencia]
GO
/****** Object:  Table [dbo].[LB_TIPOACAOTOMADA]    Script Date: 07/27/2018 09:30:25 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[LB_TIPOACAOTOMADA]') AND type in (N'U'))
DROP TABLE [dbo].[LB_TIPOACAOTOMADA]
GO
/****** Object:  Rule [dbo].[ru_SCE_NOTA_FISCAL_CARTA]    Script Date: 07/27/2018 09:30:45 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ru_SCE_NOTA_FISCAL_CARTA]') AND OBJECTPROPERTY(object_id, N'IsRule') = 1)
DROP RULE [dbo].[ru_SCE_NOTA_FISCAL_CARTA]
GO
/****** Object:  Rule [dbo].[ru_SCE_NOTA_FISCAL_CONFORMIDADE]    Script Date: 07/27/2018 09:30:45 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ru_SCE_NOTA_FISCAL_CONFORMIDADE]') AND OBJECTPROPERTY(object_id, N'IsRule') = 1)
DROP RULE [dbo].[ru_SCE_NOTA_FISCAL_CONFORMIDADE]
GO
/****** Object:  Rule [dbo].[ru_SCE_NOTA_FISCAL_CONFORMIDADE]    Script Date: 07/27/2018 09:30:45 ******/
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ru_SCE_NOTA_FISCAL_CONFORMIDADE]') AND OBJECTPROPERTY(object_id, N'IsRule') = 1)
EXEC dbo.sp_executesql N'create rule [dbo].[ru_SCE_NOTA_FISCAL_CONFORMIDADE] as /* NULL - Nada / 1 - OK / 0 - NAO OK */
@col IN (NULL, 0, 1)
'
GO
/****** Object:  Rule [dbo].[ru_SCE_NOTA_FISCAL_CARTA]    Script Date: 07/27/2018 09:30:45 ******/
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ru_SCE_NOTA_FISCAL_CARTA]') AND OBJECTPROPERTY(object_id, N'IsRule') = 1)
EXEC dbo.sp_executesql N'create rule [dbo].[ru_SCE_NOTA_FISCAL_CARTA] as /* NULL - Nada / ''P'' - Pendente / ''R'' - Recebida */
@col IN (NULL, ''P'', ''R'')
'
GO
/****** Object:  Table [dbo].[LB_TIPOACAOTOMADA]    Script Date: 07/27/2018 09:30:25 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[LB_TIPOACAOTOMADA]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[LB_TIPOACAOTOMADA](
	[TAT_ID] [int] NOT NULL,
	[TAT_DESCRICAO] [char](50) NOT NULL,
 CONSTRAINT [PK_LB_TIPOACAOTOMADA] PRIMARY KEY CLUSTERED 
(
	[TAT_ID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY]
END
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[LB_TipoOcorrencia]    Script Date: 07/27/2018 09:30:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[LB_TipoOcorrencia]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[LB_TipoOcorrencia](
	[LBTO_ID] [smallint] IDENTITY(1,1) NOT NULL,
	[LBTO_DESCRICAO] [nvarchar](400) NULL,
 CONSTRAINT [PK__LB_TipoOcorrenci__15502E78] PRIMARY KEY CLUSTERED 
(
	[LBTO_ID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[SCE_Rel_Gerencial_Anual_NF_Mov]    Script Date: 07/27/2018 09:30:37 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[SCE_Rel_Gerencial_Anual_NF_Mov]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[SCE_Rel_Gerencial_Anual_NF_Mov](
	[CHAVE] [smallint] NOT NULL,
	[ANO] [smallint] NOT NULL,
	[RELATORIO] [varchar](200) NULL,
	[MES1] [smallint] NULL,
	[MES2] [smallint] NULL,
	[MES3] [smallint] NULL,
	[MES4] [smallint] NULL,
	[MES5] [smallint] NULL,
	[MES6] [smallint] NULL,
	[MES7] [smallint] NULL,
	[MES8] [smallint] NULL,
	[MES9] [smallint] NULL,
	[MES10] [smallint] NULL,
	[MES11] [smallint] NULL,
	[MES12] [smallint] NULL,
	[DATACRIACAO] [datetime] NULL DEFAULT (getdate()),
PRIMARY KEY CLUSTERED 
(
	[CHAVE] ASC,
	[ANO] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY]
END
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Tipo_Teste]    Script Date: 07/27/2018 09:30:44 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Tipo_Teste]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[Tipo_Teste](
	[TIT_ID] [int] IDENTITY(1,1) NOT NULL,
	[TIT_DESCRICAO] [varchar](200) NULL,
PRIMARY KEY CLUSTERED 
(
	[TIT_ID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY]
END
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Rule [dbo].[ru_SCE_EMPRESA_TIPO]    Script Date: 07/27/2018 09:30:45 ******/
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ru_SCE_EMPRESA_TIPO]') AND OBJECTPROPERTY(object_id, N'IsRule') = 1)
EXEC dbo.sp_executesql N'
create rule [dbo].[ru_SCE_EMPRESA_TIPO] as /* F - Fornecedor / T - Transportador */
@col IN (''F'', ''T'')
'
GO
/****** Object:  Table [dbo].[SCE_AreaUtilizacao]    Script Date: 07/27/2018 09:30:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[SCE_AreaUtilizacao]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[SCE_AreaUtilizacao](
	[COD_SGP] [int] NULL,
	[AU_ID] [int] IDENTITY(1,1) NOT NULL,
	[AU_DESCRICAO] [varchar](50) NULL,
	[AU_CODAREAUTIL] [varchar](5) NULL,
 CONSTRAINT [PK_SCE_AreaUtilizacao] PRIMARY KEY NONCLUSTERED 
(
	[AU_ID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY]
END
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[SCE_Fabricantes]    Script Date: 07/27/2018 09:30:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[SCE_Fabricantes]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[SCE_Fabricantes](
	[fab_id] [int] IDENTITY(1,1) NOT NULL,
	[fab_nome] [varchar](50) NULL,
 CONSTRAINT [PK_SCE_Fabricantes] PRIMARY KEY NONCLUSTERED 
(
	[fab_id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY]
END
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[SCE_Historico]    Script Date: 07/27/2018 09:30:34 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[SCE_Historico]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[SCE_Historico](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[id_usuario] [varchar](20) NULL,
	[acao] [text] NULL,
	[data] [varchar](50) NULL,
	[MODULO] [varchar](20) NULL,
 CONSTRAINT [PK_SCE_Historico] PRIMARY KEY NONCLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[SCE_Usuarios]    Script Date: 07/27/2018 09:30:39 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[SCE_Usuarios]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[SCE_Usuarios](
	[USER_ID] [int] NOT NULL,
	[USER_LOGIN] [varchar](20) NULL,
	[USER_STATUS] [int] NULL,
	[user_senha] [varbinary](20) NULL,
	[user_nome] [varchar](150) NULL,
	[user_email] [varchar](50) NULL
) ON [PRIMARY]
END
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Orgao]    Script Date: 07/27/2018 09:30:27 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Orgao]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[Orgao](
	[ORGA_ID] [smallint] IDENTITY(1,1) NOT NULL,
	[ORGA_SIGLA] [varchar](20) NOT NULL,
	[ORGA_DESCRICAO] [varchar](100) NOT NULL,
	[ORGA_FAX] [varchar](50) NULL,
	[ORGA_RAMAL] [varchar](50) NULL,
	[ORGA_EXIBIR] [bit] NOT NULL CONSTRAINT [DF_Orgao_ORGA_EXIBIR]  DEFAULT (0),
	[ORGA_TIPO] [bit] NOT NULL,
	[ORGA_USERIDCHEFE] [nvarchar](20) NOT NULL,
	[ORGA_HIERARQUIA] [smallint] NULL,
 CONSTRAINT [PK__Orgao__0BC6C43E] PRIMARY KEY CLUSTERED 
(
	[ORGA_ID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY]
END
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[TAREFAS]    Script Date: 07/27/2018 09:30:41 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[TAREFAS]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[TAREFAS](
	[TAR_ID] [smallint] IDENTITY(1,1) NOT NULL,
	[TAR_DESCRICAO] [varchar](255) NOT NULL,
 CONSTRAINT [PK__TAREFAS__4F52B2DB] PRIMARY KEY CLUSTERED 
(
	[TAR_ID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY]
END
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[FAC_COMPONENTES_INTERFACE]    Script Date: 07/27/2018 09:30:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[FAC_COMPONENTES_INTERFACE]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[FAC_COMPONENTES_INTERFACE](
	[CPT_ID] [int] NOT NULL,
	[TIPO_INTERFACE_ID] [int] NOT NULL,
	[Qtd_Int] [int] NULL
) ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[PLATAFORMA_EQUIPAMENTOS]    Script Date: 07/27/2018 09:30:29 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[PLATAFORMA_EQUIPAMENTOS]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[PLATAFORMA_EQUIPAMENTOS](
	[S_ID] [smallint] NOT NULL,
	[EQ_ID] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[S_ID] ASC,
	[EQ_ID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[FAC_TIPO_INTERFACE]    Script Date: 07/27/2018 09:30:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[FAC_TIPO_INTERFACE]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[FAC_TIPO_INTERFACE](
	[Tipo_Interface_id] [int] IDENTITY(1,1) NOT NULL,
	[Tipo_Interface] [varchar](255) NULL,
	[Descricao] [varchar](255) NULL
) ON [PRIMARY]
END
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[FAC_AS_Componente]    Script Date: 07/27/2018 09:30:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[FAC_AS_Componente]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[FAC_AS_Componente](
	[Id_Componente] [int] NOT NULL,
	[AG_Numero] [int] NOT NULL,
	[Observacao] [varchar](8000) NULL
) ON [PRIMARY]
END
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Situacoes]    Script Date: 07/27/2018 09:30:41 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Situacoes]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[Situacoes](
	[ID_SITUACAO] [smallint] IDENTITY(1,1) NOT NULL,
	[S_DESCRICAO] [varchar](200) NULL,
	[S_OS] [bit] NOT NULL,
	[S_MENSAGEM] [varchar](8000) NULL,
 CONSTRAINT [PK__Situacoes__07F6335A] PRIMARY KEY CLUSTERED 
(
	[ID_SITUACAO] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY]
END
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Rule [dbo].[ru_SCE_PROPRIEDADE_EQUIPAMENTO]    Script Date: 07/27/2018 09:30:45 ******/
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ru_SCE_PROPRIEDADE_EQUIPAMENTO]') AND OBJECTPROPERTY(object_id, N'IsRule') = 1)
EXEC dbo.sp_executesql N'create rule [dbo].[ru_SCE_PROPRIEDADE_EQUIPAMENTO] as /* C - Embratel CRT / O - Embratel Outros / T - Terceiros / M - Comodato */
@col IN (''C'', ''O'', ''T'', ''M'')
'
GO
/****** Object:  Table [dbo].[SCE_TipoMovimentacao]    Script Date: 07/27/2018 09:30:39 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[SCE_TipoMovimentacao]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[SCE_TipoMovimentacao](
	[ID_TIPOMOV] [tinyint] NOT NULL,
	[NM_TIPOMOV] [varchar](50) NULL,
PRIMARY KEY CLUSTERED 
(
	[ID_TIPOMOV] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY]
END
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Perfil_SCE]    Script Date: 07/27/2018 09:30:28 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Perfil_SCE]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[Perfil_SCE](
	[ID_PERFIL] [tinyint] NOT NULL,
	[NM_PERFIL] [varchar](50) NULL,
PRIMARY KEY CLUSTERED 
(
	[ID_PERFIL] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY]
END
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Ambientes]    Script Date: 07/27/2018 09:30:12 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Ambientes]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[Ambientes](
	[AMB_ID] [int] IDENTITY(1,1) NOT NULL,
	[AMB_NOME] [varchar](50) NULL,
	[AMB_USADOPORAG] [bit] NOT NULL DEFAULT (0),
 CONSTRAINT [PK_Ambientes] PRIMARY KEY NONCLUSTERED 
(
	[AMB_ID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY]
END
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[FAC_FABRICANTE_TIPO_COMPONENTE]    Script Date: 07/27/2018 09:30:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[FAC_FABRICANTE_TIPO_COMPONENTE]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[FAC_FABRICANTE_TIPO_COMPONENTE](
	[FAB_NOME] [varchar](200) NOT NULL,
	[FAB_ID] [int] IDENTITY(1,1) NOT NULL,
PRIMARY KEY NONCLUSTERED 
(
	[FAB_ID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY]
END
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Area_Tecnologica]    Script Date: 07/27/2018 09:30:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Area_Tecnologica]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[Area_Tecnologica](
	[AT_ID] [smallint] IDENTITY(1,1) NOT NULL,
	[AT_NOME] [varchar](200) NULL,
 CONSTRAINT [PK__Area_Tecnologica__117F9D94] PRIMARY KEY CLUSTERED 
(
	[AT_ID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY]
END
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[FAC_TIPO_CIRCUITO]    Script Date: 07/27/2018 09:30:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[FAC_TIPO_CIRCUITO]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[FAC_TIPO_CIRCUITO](
	[TPC_ID] [int] IDENTITY(1,1) NOT NULL,
	[TPC_NOME] [varchar](50) NOT NULL,
 CONSTRAINT [PK__FAC_TIPO_CIRCUIT__68C86C1B] PRIMARY KEY NONCLUSTERED 
(
	[TPC_ID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY]
END
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[FAC_FAMILIA_TIPO_COMPONENTE]    Script Date: 07/27/2018 09:30:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[FAC_FAMILIA_TIPO_COMPONENTE]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[FAC_FAMILIA_TIPO_COMPONENTE](
	[FTC_NOME] [varchar](200) NOT NULL,
	[FTC_ID] [int] IDENTITY(1,1) NOT NULL,
PRIMARY KEY NONCLUSTERED 
(
	[FTC_ID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY]
END
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Tipo_Atividade]    Script Date: 07/27/2018 09:30:43 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Tipo_Atividade]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[Tipo_Atividade](
	[TA_ID] [smallint] IDENTITY(1,1) NOT NULL,
	[TA_DESCRICAO] [varchar](200) NULL,
	[TA_FLAGTABELA] [tinyint] NULL,
 CONSTRAINT [PK__Tipo_Atividade__0F975522] PRIMARY KEY CLUSTERED 
(
	[TA_ID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY]
END
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Tipo_Sigilo]    Script Date: 07/27/2018 09:30:43 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Tipo_Sigilo]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[Tipo_Sigilo](
	[TS_ID] [tinyint] NOT NULL,
	[TS_DESCRICAO] [varchar](40) NULL,
 CONSTRAINT [PK_Tipo_Sigilo] PRIMARY KEY NONCLUSTERED 
(
	[TS_ID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY]
END
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[SCE_Natureza_Operacao]    Script Date: 07/27/2018 09:30:35 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[SCE_Natureza_Operacao]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[SCE_Natureza_Operacao](
	[NO_DESCRICAO] [varchar](100) NOT NULL,
	[NO_ID] [int] IDENTITY(1,1) NOT NULL,
	[NO_TIPO] [tinyint] NULL,
	[CDE] [bit] NOT NULL CONSTRAINT [DF_SCE_Natureza_Operacao_CDE]  DEFAULT (0),
	[DEFEITO] [bit] NOT NULL CONSTRAINT [DF_SCE_Natureza_Operacao_DEFEITO]  DEFAULT (0),
	[PRAZO] [bit] NOT NULL CONSTRAINT [DF_SCE_Natureza_Operacao_PRAZO]  DEFAULT (0),
	[ASA] [bit] NOT NULL CONSTRAINT [DF_SCE_Natureza_Operacao_ASA]  DEFAULT (0),
 CONSTRAINT [PK_SCE_Natureza_Operacao] PRIMARY KEY NONCLUSTERED 
(
	[NO_ID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY]
END
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[SCE_Tipo_NO]    Script Date: 07/27/2018 09:30:38 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[SCE_Tipo_NO]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[SCE_Tipo_NO](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[no_id] [int] NULL,
	[tipo_id] [int] NULL,
 CONSTRAINT [PK_SCE_Tipo_NO] PRIMARY KEY NONCLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[SCE_Tipos]    Script Date: 07/27/2018 09:30:39 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[SCE_Tipos]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[SCE_Tipos](
	[TIPO_ID] [int] IDENTITY(1,1) NOT NULL,
	[TIPO_APELIDO] [varchar](50) NULL,
	[TIPO_SUPERTIPO] [int] NULL,
	[TIPO_DESCRICAO] [varchar](100) NULL,
	[COD_SGP] [char](10) NULL,
	[SGP] [int] NULL,
 CONSTRAINT [PK_SCE_Tipos] PRIMARY KEY NONCLUSTERED 
(
	[TIPO_ID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY]
END
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[SCE_Historico_Movimentacao]    Script Date: 07/27/2018 09:30:34 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[SCE_Historico_Movimentacao]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[SCE_Historico_Movimentacao](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[MOV_ID] [int] NULL,
	[DATA_OLD] [varchar](50) NULL,
	[USUARIO] [varchar](50) NULL,
	[TEXTO] [varchar](50) NULL,
	[no_id] [int] NULL,
	[tipo_id] [int] NULL,
	[eq_id] [int] NULL,
	[DATA_OLD_COPIA] [varchar](50) NULL,
	[DATA] [datetime] NULL CONSTRAINT [DF_SCE_Historico_Movimentacao_DATA]  DEFAULT (getdate()),
 CONSTRAINT [PK_SCE_Historico_Movimentacao] PRIMARY KEY NONCLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY]
END
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[SituacaoArquivo]    Script Date: 07/27/2018 09:30:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[SituacaoArquivo]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[SituacaoArquivo](
	[SAR_CODSITARQUIVO] [int] NOT NULL,
	[SAR_SITARQUIVO] [nvarchar](200) NULL,
PRIMARY KEY CLUSTERED 
(
	[SAR_CODSITARQUIVO] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[PesquisaSatisfacao]    Script Date: 07/27/2018 09:30:28 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[PesquisaSatisfacao]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[PesquisaSatisfacao](
	[PSQ_Id] [int] IDENTITY(1,1) NOT NULL,
	[PSQ_UsernameCadastro] [nvarchar](50) NULL,
	[PSQ_IPCadastro] [nvarchar](50) NULL,
	[PSQ_DataHoraCadastro] [datetime] NULL,
	[PSQ_NAg] [int] NULL,
	[PSQ_Nome] [nvarchar](150) NULL,
	[PSQ_Telefone] [nvarchar](50) NULL,
	[PSQ_Email] [nvarchar](50) NULL,
	[PSQ_OrgaoEmpresa] [nvarchar](50) NULL,
	[PSQ_Origem] [nvarchar](50) NULL,
	[PSQ_R1] [float] NULL,
	[PSQ_R2] [float] NULL,
	[PSQ_R3] [float] NULL,
	[PSQ_R4] [float] NULL,
	[PSQ_R5] [float] NULL,
	[PSQ_R6] [float] NULL,
	[PSQ_R7] [float] NULL,
	[PSQ_R8] [float] NULL,
	[PSQ_R9] [float] NULL,
	[PSQ_R10] [float] NULL,
	[PSQ_R11] [float] NULL,
	[PSQ_C1] [ntext] NULL,
	[PSQ_C2] [ntext] NULL,
	[PSQ_C3] [ntext] NULL,
	[PSQ_C4] [ntext] NULL,
	[PSQ_C5] [ntext] NULL,
	[PSQ_C6] [ntext] NULL,
	[PSQ_C7] [ntext] NULL,
	[PSQ_C8] [ntext] NULL,
	[PSQ_C9] [ntext] NULL,
	[PSQ_C10] [ntext] NULL,
	[PSQ_C11] [ntext] NULL,
	[PSQ_C_3] [ntext] NULL,
	[PSQ_C_4] [ntext] NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[TipoArquivo]    Script Date: 07/27/2018 09:30:44 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[TipoArquivo]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[TipoArquivo](
	[TAR_CODTIPOARQUIVO] [int] IDENTITY(1,1) NOT NULL,
	[TAR_TIPOARQUIVO] [nvarchar](240) NULL,
	[TAR_CONFIDENCIAL] [bit] NOT NULL CONSTRAINT [DF_TipoArquivo_TAR_CONFIDENCIAL]  DEFAULT (0),
	[TAR_SENHA] [nvarchar](15) NULL,
	[TAR_DocQual] [bit] NOT NULL CONSTRAINT [DF_TipoArquivo_TAR_DocQual]  DEFAULT (0),
 CONSTRAINT [PK__TipoArquivo__300424B4] PRIMARY KEY CLUSTERED 
(
	[TAR_CODTIPOARQUIVO] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[Servicos_Plataformas]    Script Date: 07/27/2018 09:30:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Servicos_Plataformas]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[Servicos_Plataformas](
	[S_ID] [smallint] IDENTITY(1,1) NOT NULL,
	[S_TIPO] [varchar](200) NULL,
	[S_DESCRICAO] [varchar](200) NULL,
	[S_SERVICO] [bit] NOT NULL,
	[S_ID_PAI] [smallint] NULL,
 CONSTRAINT [PK__Servicos_Platafo__35BCFE0A] PRIMARY KEY CLUSTERED 
(
	[S_ID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY]
END
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Rule [dbo].[ru_SCE_RESERVA_EQ_ACEITO]    Script Date: 07/27/2018 09:30:45 ******/
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ru_SCE_RESERVA_EQ_ACEITO]') AND OBJECTPROPERTY(object_id, N'IsRule') = 1)
EXEC dbo.sp_executesql N'
create rule [dbo].[ru_SCE_RESERVA_EQ_ACEITO] as /* null - não verificado / 0 - Não aceito / 1 - Aceito */
@col IN (NULL, 0, 1)

'
GO
/****** Object:  Rule [dbo].[ru_SCE_RESERVA_EQ_SETUP]    Script Date: 07/27/2018 09:30:45 ******/
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ru_SCE_RESERVA_EQ_SETUP]') AND OBJECTPROPERTY(object_id, N'IsRule') = 1)
EXEC dbo.sp_executesql N'create rule [dbo].[ru_SCE_RESERVA_EQ_SETUP] as /* A - Amostra / E - Equipamento */
@col IN (''A'', ''E'')

'
GO
/****** Object:  Rule [dbo].[VERIFICA_ANO]    Script Date: 07/27/2018 09:30:45 ******/
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[VERIFICA_ANO]') AND OBJECTPROPERTY(object_id, N'IsRule') = 1)
EXEC dbo.sp_executesql N'CREATE RULE [dbo].[VERIFICA_ANO]
	AS @col BETWEEN 1900 AND 3000'
GO
/****** Object:  Table [dbo].[Transporte]    Script Date: 07/27/2018 09:30:45 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Transporte]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[Transporte](
	[CodHorario] [int] IDENTITY(1,1) NOT NULL,
	[DeHoraIda] [varchar](5) NULL,
	[DeHoraVolta] [varchar](5) NULL,
PRIMARY KEY CLUSTERED 
(
	[CodHorario] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY]
END
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[EquipeEmbratel]    Script Date: 07/27/2018 09:30:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[EquipeEmbratel]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[EquipeEmbratel](
	[UserId_Gerente] [varchar](20) NOT NULL,
	[UserId_Membro] [varchar](20) NOT NULL,
 CONSTRAINT [EquipeEmbratel_PK] PRIMARY KEY CLUSTERED 
(
	[UserId_Gerente] ASC,
	[UserId_Membro] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY]
END
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Rule [dbo].[TIPO_LOCAL_EQUP]    Script Date: 07/27/2018 09:30:45 ******/
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[TIPO_LOCAL_EQUP]') AND OBJECTPROPERTY(object_id, N'IsRule') = 1)
EXEC dbo.sp_executesql N'CREATE RULE [dbo].[TIPO_LOCAL_EQUP]
	AS @col IN (''I'', ''E'')
'
GO
/****** Object:  Table [dbo].[Mensagem]    Script Date: 07/27/2018 09:30:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Mensagem]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[Mensagem](
	[CodMensagem] [int] IDENTITY(1,1) NOT NULL,
	[DeMensagem] [varchar](100) NOT NULL,
	[TextoMensagem] [text] NULL,
PRIMARY KEY CLUSTERED 
(
	[CodMensagem] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[FAC_CARACTERISTICAS]    Script Date: 07/27/2018 09:30:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[FAC_CARACTERISTICAS]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[FAC_CARACTERISTICAS](
	[CAR_ID] [int] IDENTITY(1,1) NOT NULL,
	[CAR_NOME] [varchar](50) NOT NULL,
	[CAR_DEFINICAO] [varchar](5000) NULL,
PRIMARY KEY NONCLUSTERED 
(
	[CAR_ID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY]
END
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[SCE_Modelos]    Script Date: 07/27/2018 09:30:34 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[SCE_Modelos]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[SCE_Modelos](
	[COD_SGP] [char](50) NULL,
	[MOD_ID] [int] IDENTITY(1,1) NOT NULL,
	[MOD_CODNOME] [varchar](255) NULL,
	[MOD_NET] [varchar](255) NULL,
	[MOD_OBS] [text] NULL,
	[TIPO_ID] [int] NULL,
	[FAB_ID] [int] NULL,
	[sgp] [int] NULL,
	[mod_descricao] [varchar](255) NULL,
 CONSTRAINT [PK_SCE_Modelos] PRIMARY KEY NONCLUSTERED 
(
	[MOD_ID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
SET ANSI_PADDING OFF
GO
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[SCE_Modelos]') AND name = N'IX_FK_SCE_Modelos_FAB_ID')
CREATE NONCLUSTERED INDEX [IX_FK_SCE_Modelos_FAB_ID] ON [dbo].[SCE_Modelos] 
(
	[FAB_ID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 90) ON [PRIMARY]
GO
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[SCE_Modelos]') AND name = N'IX_MOD_CODNOME')
CREATE NONCLUSTERED INDEX [IX_MOD_CODNOME] ON [dbo].[SCE_Modelos] 
(
	[MOD_CODNOME] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 90) ON [PRIMARY]
GO
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[SCE_Modelos]') AND name = N'IX_MOD_DESCRICAO')
CREATE NONCLUSTERED INDEX [IX_MOD_DESCRICAO] ON [dbo].[SCE_Modelos] 
(
	[mod_descricao] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 90) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[SCE_Equipamentos]    Script Date: 07/27/2018 09:30:32 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[SCE_Equipamentos]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[SCE_Equipamentos](
	[EQ_ID] [int] IDENTITY(1,1) NOT NULL,
	[EQ_CODIGOBARRAS] [varchar](20) NULL,
	[EQ_NUMEROSERIE] [varchar](255) NULL,
	[EQ_LOCALIZACAO] [varchar](255) NULL,
	[MOD_ID] [int] NULL,
	[EQ_OBS] [text] NULL,
	[STATUS] [tinyint] NOT NULL CONSTRAINT [DF_SCE_Equipamentos_STATUS]  DEFAULT (0),
	[EQ_OPER_DELTA] [varchar](50) NULL CONSTRAINT [DF_SCE_Equipamentos_EQ_OPER_DELTA]  DEFAULT ('24 +/- 6°C'),
	[EQ_OPER_UMIDADE] [varchar](50) NULL CONSTRAINT [DF_SCE_Equipamentos_EQ_OPER_UMIDADE]  DEFAULT ('40 A 70% UR'),
	[EQ_OPER_WARMUP] [varchar](50) NULL CONSTRAINT [DF_SCE_Equipamentos_EQ_OPER_WARMUP]  DEFAULT ('N/A'),
	[EQ_ARMA_DELTA] [varchar](50) NULL CONSTRAINT [DF_SCE_Equipamentos_EQ_ARMA_DELTA]  DEFAULT ('10 A 35°C'),
	[EQ_ARMA_UMIDADE] [varchar](50) NULL CONSTRAINT [DF_SCE_Equipamentos_EQ_ARMA_UMIDADE]  DEFAULT ('20 A 80% UR'),
	[EQ_MANUT_PREVENTIVA] [text] NULL,
	[EQ_INSTRUMENTAL] [bit] NOT NULL CONSTRAINT [DF_SCE_Equipamentos_EQ_INSTRUMENTAL]  DEFAULT (0),
	[EQ_PROPRIEDADE] [char](1) NOT NULL CONSTRAINT [DF_SCE_Equipamentos_EQ_PROPRIEDADE]  DEFAULT ('C'),
	[EQ_CONFORME] [bit] NOT NULL CONSTRAINT [DF_SCE_Equipamentos_EQ_CONFORME]  DEFAULT (1),
	[EQ_DT_ULT_INVENTARIO] [datetime] NULL,
	[EQ_FREQ_CALIBRACAO] [int] NULL,
	[EQ_CODIGOBARRASANTERIOR] [varchar](20) NULL,
 CONSTRAINT [PK_SCE_Equipamentos] PRIMARY KEY NONCLUSTERED 
(
	[EQ_ID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
SET ANSI_PADDING OFF
GO
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[SCE_Equipamentos]') AND name = N'IX_SCE_EQ_CODIGOBARRAS')
CREATE UNIQUE NONCLUSTERED INDEX [IX_SCE_EQ_CODIGOBARRAS] ON [dbo].[SCE_Equipamentos] 
(
	[EQ_CODIGOBARRAS] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 90) ON [PRIMARY]
GO
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[SCE_Equipamentos]') AND name = N'IX_SCE_Equipamentos_MOD_ID')
CREATE NONCLUSTERED INDEX [IX_SCE_Equipamentos_MOD_ID] ON [dbo].[SCE_Equipamentos] 
(
	[MOD_ID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 90) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[SCE_Empresa_Nota_Fiscal]    Script Date: 07/27/2018 09:30:32 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[SCE_Empresa_Nota_Fiscal]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[SCE_Empresa_Nota_Fiscal](
	[ENF_OBSERVACAO] [varchar](1000) NULL,
	[ENF_CONTATO] [varchar](50) NULL,
	[ENF_FAX] [varchar](20) NULL,
	[ENF_TEL] [varchar](20) NULL,
	[ENF_CEP] [varchar](9) NULL,
	[ENF_UF] [int] NULL,
	[ENF_CIDADE] [varchar](50) NULL,
	[ENF_ENDERECO] [varchar](150) NULL,
	[ENF_CNPJ] [varchar](20) NULL,
	[ENF_IE] [varchar](20) NULL,
	[ENF_NOME] [varchar](100) NULL,
	[ENF_ID] [int] IDENTITY(1,1) NOT NULL,
	[enf_ddd] [char](30) NULL,
	[enf_ddd_fax] [char](30) NULL,
	[enf_email] [varchar](50) NULL,
	[enf_cpf] [char](20) NULL,
	[ENF_TIPOEMPRESA] [char](1) NOT NULL CONSTRAINT [DF_SCE_Empresa_Nota_Fiscal_ENF_TIPOEMPRESA]  DEFAULT ('F'),
 CONSTRAINT [PK_SCE_Empresa_Nota_Fiscal] PRIMARY KEY NONCLUSTERED 
(
	[ENF_ID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY]
END
GO
SET ANSI_PADDING OFF
GO
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[SCE_Empresa_Nota_Fiscal]') AND name = N'IX_SCE_EMF_NOME')
CREATE NONCLUSTERED INDEX [IX_SCE_EMF_NOME] ON [dbo].[SCE_Empresa_Nota_Fiscal] 
(
	[ENF_NOME] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 90) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[SCE_Documentacao]    Script Date: 07/27/2018 09:30:32 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[SCE_Documentacao]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[SCE_Documentacao](
	[DOC_ID] [int] NOT NULL,
	[DOC_RESPONSAVEL] [varchar](50) NULL,
	[DOC_DATADOCUMENTO] [varchar](50) NULL,
	[DOC_OBSERVACAO] [varchar](1000) NULL,
	[DOC_NOME] [varchar](50) NULL,
	[DOC_IDE] [varchar](50) NULL,
	[DOC_EMPRESA] [varchar](50) NULL,
	[DOC_FONE] [varchar](50) NULL,
	[DOC_MAIL] [varchar](50) NULL,
	[ENF_ID] [int] NULL,
 CONSTRAINT [PK_SCE_Documentacao] PRIMARY KEY NONCLUSTERED 
(
	[DOC_ID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY]
END
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[SCE_Nota_Fiscal]    Script Date: 07/27/2018 09:30:36 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[SCE_Nota_Fiscal]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[SCE_Nota_Fiscal](
	[NF_NUMERONOTA] [int] NULL,
	[NF_QTDEVOLUMES] [int] NULL,
	[NF_CFOP] [varchar](20) NULL,
	[NF_VALORTOTAL] [decimal](15, 2) NULL,
	[NF_DATAEMISSAO] [datetime] NULL CONSTRAINT [DF_SCE_Nota_Fiscal_NF_DATAEMISSAO]  DEFAULT (getdate()),
	[NF_NCONHECIMENTO] [char](10) NULL,
	[NF_TIPO] [int] NULL,
	[TRANS_ID] [int] NULL,
	[ENF_ID] [int] NULL,
	[NF_ID] [int] IDENTITY(1,1) NOT NULL,
	[nf_descriminacao] [text] NULL,
	[no_id] [int] NULL,
	[nf_id_pai] [int] NULL,
	[nf_validade] [varchar](50) NULL,
	[nf_data] [datetime] NULL CONSTRAINT [DF_SCE_Nota_Fiscal_nf_data]  DEFAULT (getdate()),
	[nf_recebimento] [datetime] NULL CONSTRAINT [DF_SCE_Nota_Fiscal_nf_recebimento]  DEFAULT (getdate()),
	[nf_obs] [text] NULL,
	[NF_ACEITE] [tinyint] NULL,
	[NF_VOLUME] [tinyint] NULL,
	[NF_CARTA] [varchar](1) NULL,
	[NF_INTEGRIDADE] [tinyint] NULL,
	[NF_DEVOLUCAOCOMPLETA] [bit] NOT NULL CONSTRAINT [DF__SCE_Nota___NF_DE__126A6B83]  DEFAULT (0),
	[NF_VALORTOTAL_CHAR] [varchar](30) NULL,
 CONSTRAINT [PK_SCE_Nota_Fiscal] PRIMARY KEY NONCLUSTERED 
(
	[NF_ID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[SCE_Movimentacao]    Script Date: 07/27/2018 09:30:35 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[SCE_Movimentacao]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[SCE_Movimentacao](
	[MOV_ID] [int] IDENTITY(1,1) NOT NULL,
	[EQ_ID] [int] NOT NULL,
	[NO_ID] [int] NOT NULL,
	[MOV_DESPACHANTE] [varchar](50) NULL,
	[MOV_SOLICITANTE] [varchar](50) NULL,
	[TIPO] [int] NULL,
	[CDE] [varchar](50) NULL,
	[ASA] [varchar](50) NULL,
	[RESERVA] [int] NULL,
	[SAIDA] [int] NULL,
	[NF_ID] [int] NULL,
	[EXCLUIDA] [char](1) NULL,
	[DOC_ID] [int] NULL,
	[MOV_DATA] [datetime] NOT NULL CONSTRAINT [DF_SCE_Movimentacao_MOV_DATA]  DEFAULT (getdate()),
	[MOV_PASSAGEM] [bit] NOT NULL DEFAULT (0),
	[FL_CALIBRACAO] [tinyint] NULL,
 CONSTRAINT [PK_SCE_Movimentacao] PRIMARY KEY NONCLUSTERED 
(
	[MOV_ID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY]
END
GO
SET ANSI_PADDING OFF
GO
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[SCE_Movimentacao]') AND name = N'IX_FK_SCE_Movimentacao_EQ_ID')
CREATE NONCLUSTERED INDEX [IX_FK_SCE_Movimentacao_EQ_ID] ON [dbo].[SCE_Movimentacao] 
(
	[EQ_ID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 90) ON [PRIMARY]
GO
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[SCE_Movimentacao]') AND name = N'IX_FK_SCE_Movimentacao_NF_ID')
CREATE NONCLUSTERED INDEX [IX_FK_SCE_Movimentacao_NF_ID] ON [dbo].[SCE_Movimentacao] 
(
	[NF_ID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 90) ON [PRIMARY]
GO
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[SCE_Movimentacao]') AND name = N'IX_FK_SCE_Movimentacao_NO_ID')
CREATE NONCLUSTERED INDEX [IX_FK_SCE_Movimentacao_NO_ID] ON [dbo].[SCE_Movimentacao] 
(
	[NO_ID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 90) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[UserCRT]    Script Date: 07/27/2018 09:30:45 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[UserCRT]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[UserCRT](
	[USERID] [varchar](20) NOT NULL,
	[NOME] [nvarchar](510) NULL,
	[CELULAR] [nvarchar](510) NULL,
	[RAMAL] [float] NULL,
	[MATRICULA] [float] NULL,
	[ORGA_ID] [smallint] NULL,
	[RT] [bit] NOT NULL CONSTRAINT [DF_UserCRT_RT]  DEFAULT (0),
	[RAT] [bit] NOT NULL CONSTRAINT [DF_UserCRT_RAT]  DEFAULT (0),
	[Exibir] [bit] NOT NULL CONSTRAINT [DF_UserCRT_Exibir]  DEFAULT (1),
	[GQ] [bit] NOT NULL CONSTRAINT [DF_UserCRT_GQ]  DEFAULT (0),
	[ID_PERFIL_SCE] [tinyint] NULL,
 CONSTRAINT [PK__UserCRT__0DAF0CB0] PRIMARY KEY CLUSTERED 
(
	[USERID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY]
END
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[LB_LogBook]    Script Date: 07/27/2018 09:30:25 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[LB_LogBook]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[LB_LogBook](
	[LB_ID] [smallint] IDENTITY(1,1) NOT NULL,
	[LBTO_ID] [smallint] NULL,
	[LB_DATAHORACAD] [smalldatetime] NULL,
	[LB_USERNAMECAD] [varchar](10) NULL,
	[LB_IPCAD] [varchar](20) NULL,
	[LB_DESCRICAO] [text] NULL,
	[LB_OBSERVACAO] [text] NULL,
	[LB_PROVIDENCIAS] [text] NULL,
	[LB_CONCLUIDO] [bit] NOT NULL CONSTRAINT [DF_LB_LogBook_LB_CONCLUIDO]  DEFAULT (0),
	[LB_CONCLUIDOGQ] [bit] NOT NULL CONSTRAINT [DF_LB_LogBook_LB_CONCLUIDOGQ]  DEFAULT (0),
	[LB_DATAHORAOCO] [smalldatetime] NULL,
	[LB_PRAZO] [smallint] NULL,
	[LB_RESPEXEC] [varchar](50) NULL,
	[LB_EXECUTOR] [text] NULL,
	[LB_OBSERVACOESGQ] [text] NULL,
	[LB_OBSERVACOESRES] [text] NULL,
	[LB_PENDENCIAS] [text] NULL,
	[LB_ANALISEGQ] [text] NULL,
	[LB_DOCASSOCIADO] [text] NULL,
	[LB_REQUISITONORMA] [text] NULL,
	[LB_CRITICIDADE] [tinyint] NULL CONSTRAINT [DF_LB_LogBook_LB_CRITICIDADE]  DEFAULT (1),
	[LB_OPM] [bit] NOT NULL CONSTRAINT [DF_LB_LogBook_LB_OPM]  DEFAULT (0),
	[LB_RATRESPONSAVEL] [varchar](20) NULL,
	[LB_DATAHORACONCLUSAO] [smalldatetime] NULL,
 CONSTRAINT [PK__LB_LogBook__173876EA] PRIMARY KEY CLUSTERED 
(
	[LB_ID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[LB_ACOESTOMADAS]    Script Date: 07/27/2018 09:30:24 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[LB_ACOESTOMADAS]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[LB_ACOESTOMADAS](
	[ACT_ID] [int] IDENTITY(1,1) NOT NULL,
	[ACT_LB] [smallint] NOT NULL,
	[ACT_DESCRICAO] [varchar](255) NULL,
	[ACT_EXECUTANTE] [varchar](200) NULL,
	[ACT_PRAZO] [smalldatetime] NULL,
	[ACT_DATACONCLUSAO] [smalldatetime] NULL,
	[ACT_EFICACIA] [tinyint] NULL,
	[ACT_OBS] [text] NULL,
	[ACT_TIPOACAO] [int] NOT NULL,
	[ACT_RESPONSAVEL] [varchar](20) NULL,
 CONSTRAINT [PK_LB_ACOESTOMADAS] PRIMARY KEY CLUSTERED 
(
	[ACT_ID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Arquivos]    Script Date: 07/27/2018 09:30:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Arquivos]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[Arquivos](
	[ARQ_CODARQ] [int] IDENTITY(1,1) NOT NULL,
	[ARQ_CODARQTIPO] [int] NULL,
	[ARQ_LINK] [nvarchar](400) NULL,
	[ARQ_NOMEARQ] [nvarchar](200) NULL,
	[ARQ_RESPONSAVEL] [nvarchar](20) NULL,
	[ARQ_IDORGAO] [smallint] NULL,
	[ARQ_OBSERVACAO] [nvarchar](510) NULL,
	[ARQ_VINCULACAO] [int] NULL,
	[ARQ_VERSAO] [nvarchar](100) NULL,
	[ARQ_OCULTAR] [bit] NOT NULL CONSTRAINT [DF_Arquivos_ARQ_OCULTAR]  DEFAULT (0),
	[ARQ_DATAATUALIZACAO] [smalldatetime] NULL,
	[IPCADASTRO] [nvarchar](40) NULL,
	[ARQ_DATAAPROVACAO] [smalldatetime] NULL,
	[USERIDCADASTRO] [nvarchar](16) NULL,
	[ARQ_DESCRICAO] [nvarchar](510) NULL,
	[ARQ_IDSITUACAO] [int] NULL,
	[ARQ_OS] [int] NULL CONSTRAINT [DF_Arquivos_ARQ_OS]  DEFAULT (null),
	[ARQ_O1] [int] NULL,
	[ARQ_O2] [int] NULL,
	[ARQ_O3] [int] NULL,
	[ARQ_VALIDACAO] [smallint] NULL CONSTRAINT [DF_Arquivos_ARQ_VALIDACAO]  DEFAULT (0),
	[ARQ_NOTIFICACAOEXPIRACAO] [smallint] NULL CONSTRAINT [DF_Arquivos_ARQ_NOTIFICACAOEXPIRACAO]  DEFAULT (0),
 CONSTRAINT [PK__Arquivos__3D5E1FD2] PRIMARY KEY CLUSTERED 
(
	[ARQ_CODARQ] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[TECNOLOGIA]    Script Date: 07/27/2018 09:30:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[TECNOLOGIA]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[TECNOLOGIA](
	[TEC_ID] [int] IDENTITY(1,1) NOT NULL,
	[TEC_NOME] [varchar](50) NULL,
	[AT_ID] [smallint] NULL,
 CONSTRAINT [PK_TECNOLOGIA] PRIMARY KEY CLUSTERED 
(
	[TEC_ID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY]
END
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Agendamento]    Script Date: 07/27/2018 09:30:12 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Agendamento]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[Agendamento](
	[AG_NUMERO] [smallint] IDENTITY(1,1) NOT NULL,
	[TA_ID] [smallint] NULL,
	[AT_ID] [smallint] NULL,
	[AG_DATASOLICITACAO] [smalldatetime] NULL,
	[AG_DATAINICIO] [smalldatetime] NULL,
	[AG_DATATERMINO] [smalldatetime] NULL,
	[AG_RESPONSAVEL] [varchar](20) NULL,
	[AG_RAT] [varchar](20) NULL,
	[AG_SIGILO] [tinyint] NOT NULL CONSTRAINT [DF_Agendamento_AG_SIGILO]  DEFAULT (0),
	[AG_FLAGREMARCACAO] [bit] NOT NULL CONSTRAINT [DF_Agendamento_AG_FLAGREMARCACAO]  DEFAULT (0),
	[AG_OBJETIVO] [text] NULL,
	[AG_MOTIVO] [varchar](7000) NULL,
	[AG_USERNAME] [varchar](200) NULL,
	[AG_RECEBEMAIL] [bit] NOT NULL CONSTRAINT [DF_Agendamento_AG_RECEBEMAIL]  DEFAULT (0),
	[AG_ORGAO] [varchar](200) NULL,
	[AG_CLIENTEEXTERNO] [varchar](2000) NULL,
	[AG_RETIFICACAO] [text] NULL,
	[AG_RELAT_RAT] [text] NULL,
	[AG_RELAT_RT] [text] NULL,
	[AG_REPETIDO] [bit] NOT NULL CONSTRAINT [DF_Agendamento_AG_REPETIDO]  DEFAULT (0),
	[AG_AMBIENTE] [text] NULL,
	[AG_RECURSOS] [text] NULL,
	[AG_OBSERVACAO] [text] NULL,
	[AG_NECESSITA_OS] [bit] NULL,
	[AG_EXECUTANTE] [bit] NOT NULL DEFAULT (0),
	[AG_RETORNOCLIENTE] [money] NULL,
	[AG_PLANODEMETAS] [int] NULL,
	[TEC_ID] [int] NULL,
	[AG_SOLICITOUCANCELAMENTO] [bit] NOT NULL DEFAULT (0),
	[AG_TITULO] [varchar](50) NULL,
	[AG_VALORCONTRATOCLIENTE] [money] NULL,
	[AG_PRIORIDADE] [tinyint] NULL,
 CONSTRAINT [PK__Agendamento__1367E606] PRIMARY KEY CLUSTERED 
(
	[AG_NUMERO] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Diagramas]    Script Date: 07/27/2018 09:30:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Diagramas]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[Diagramas](
	[AG_NUMERO] [smallint] NOT NULL,
	[ARQ_CODARQ] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[AG_NUMERO] ASC,
	[ARQ_CODARQ] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[HISTORICO_ARQUIVOS]    Script Date: 07/27/2018 09:30:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[HISTORICO_ARQUIVOS]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[HISTORICO_ARQUIVOS](
	[HA_ID] [int] IDENTITY(1,1) NOT NULL,
	[HA_CODARQ] [int] NOT NULL,
	[HA_USUARIO] [varchar](20) NOT NULL,
	[HA_DATAATUALIZACAO] [smalldatetime] NOT NULL,
	[HA_ACAO] [varchar](20) NOT NULL
) ON [PRIMARY]
END
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[SCE_Passagem_Carga]    Script Date: 07/27/2018 09:30:37 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[SCE_Passagem_Carga]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[SCE_Passagem_Carga](
	[EQ_ID] [int] NOT NULL,
	[AG_NUMERO_ORIG] [smallint] NOT NULL,
	[AG_NUMERO_DEST] [smallint] NOT NULL,
	[PAS_DATAPASSAGEM] [datetime] NULL DEFAULT (getdate()),
	[PAS_DATARECEBIMENTO] [datetime] NULL,
	[PAS_APROVADO] [bit] NOT NULL DEFAULT (0),
 CONSTRAINT [PK_SCE_Passagem_Carga] PRIMARY KEY CLUSTERED 
(
	[EQ_ID] ASC,
	[AG_NUMERO_ORIG] ASC,
	[AG_NUMERO_DEST] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[SCE_Equipamentos_Controle]    Script Date: 07/27/2018 09:30:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[SCE_Equipamentos_Controle]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[SCE_Equipamentos_Controle](
	[EQC_ID] [int] IDENTITY(1,1) NOT NULL,
	[EQ_ID] [int] NOT NULL,
	[EQC_DIAS] [int] NULL,
	[EQC_DATA] [datetime] NOT NULL CONSTRAINT [DF_SCE_Equipamentos_Controle_EQC_DATA]  DEFAULT (getdate()),
	[EQC_REGISTRO] [varchar](50) NULL,
	[EQC_RESPONSAVEL] [varchar](50) NULL,
	[EQC_TIPO] [char](1) NOT NULL CONSTRAINT [DF_SCE_Equipamentos_Controle_EQC_TIPO]  DEFAULT ('C'),
 CONSTRAINT [PK_SCE_Equipamentos_Controle] PRIMARY KEY CLUSTERED 
(
	[EQC_ID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY]
END
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[HISTORICO_PLATAFORMA_EQUIPAMENTOS]    Script Date: 07/27/2018 09:30:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[HISTORICO_PLATAFORMA_EQUIPAMENTOS]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[HISTORICO_PLATAFORMA_EQUIPAMENTOS](
	[HPE_ID] [int] IDENTITY(1,1) NOT NULL,
	[HPE_DATAALTERACAO] [datetime] NOT NULL,
	[HPE_TIPOMOVIMENTO] [char](1) NOT NULL,
	[EQ_ID] [int] NOT NULL,
	[S_ID] [smallint] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[HPE_ID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY]
END
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[TESTES]    Script Date: 07/27/2018 09:30:43 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[TESTES]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[TESTES](
	[T_ID] [smallint] IDENTITY(1,1) NOT NULL,
	[T_TITULO] [varchar](200) NULL,
	[T_DESCRICAO] [varchar](7000) NULL,
	[T_DISPONIVEL] [bit] NULL,
	[T_TIPO] [smallint] NULL,
	[T_OBSERVACAO] [varchar](200) NULL,
	[TIT_ID] [int] NOT NULL DEFAULT (1),
	[T_PERIODOREPETICAO] [smallint] NOT NULL DEFAULT (0),
 CONSTRAINT [PK_TESTES] PRIMARY KEY CLUSTERED 
(
	[T_ID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY]
END
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Ordem_de_Servico]    Script Date: 07/27/2018 09:30:27 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING OFF
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Ordem_de_Servico]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[Ordem_de_Servico](
	[OS_ID] [smallint] NOT NULL,
	[OS_RESPONSAVEL] [varchar](20) NULL,
	[AG_NUMERO] [smallint] NOT NULL,
	[OS_FLAGREPETICAO] [tinyint] NULL
) ON [PRIMARY]
SET ANSI_PADDING ON
ALTER TABLE [dbo].[Ordem_de_Servico] ADD [OS_TECNICOEXTERNO] [varchar](255) NULL
ALTER TABLE [dbo].[Ordem_de_Servico] ADD [OS_OBSERVACOES] [varchar](510) NULL
ALTER TABLE [dbo].[Ordem_de_Servico] ADD [T_ID] [smallint] NULL
ALTER TABLE [dbo].[Ordem_de_Servico] ADD [S_ID_SERVICO] [smallint] NULL
ALTER TABLE [dbo].[Ordem_de_Servico] ADD [S_ID_PLATAFORMA] [smallint] NULL
ALTER TABLE [dbo].[Ordem_de_Servico] ADD [EQ_ID_AMOSTRA] [int] NULL
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[Ordem_de_Servico]') AND name = N'PK__Ordem_de_Servico__48CFD27E')
ALTER TABLE [dbo].[Ordem_de_Servico] ADD PRIMARY KEY CLUSTERED 
(
	[OS_ID] ASC,
	[AG_NUMERO] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 90) ON [PRIMARY]
END
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[SCE_Acessorios]    Script Date: 07/27/2018 09:30:30 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[SCE_Acessorios]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[SCE_Acessorios](
	[eq_id] [int] NOT NULL,
	[sequencial] [int] NOT NULL CONSTRAINT [DF_SCE_Acessorios_sequencial]  DEFAULT (1),
	[descricao] [varchar](255) NULL,
	[status] [int] NULL,
	[conforme] [bit] NOT NULL CONSTRAINT [DF_SCE_Acessorios_conforme]  DEFAULT (1),
 CONSTRAINT [PK_SCE_Acessorios] PRIMARY KEY NONCLUSTERED 
(
	[eq_id] ASC,
	[sequencial] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY]
END
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[SCE_AreasUtil_Modelo]    Script Date: 07/27/2018 09:30:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[SCE_AreasUtil_Modelo]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[SCE_AreasUtil_Modelo](
	[AU_ID] [int] NOT NULL,
	[MOD_ID] [int] NOT NULL,
	[id] [int] IDENTITY(1,1) NOT NULL,
 CONSTRAINT [PK_SCE_AreasUtil_Modelo] PRIMARY KEY NONCLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[LB_ACOESTOMADAS_ARQUIVOS]    Script Date: 07/27/2018 09:30:24 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[LB_ACOESTOMADAS_ARQUIVOS]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[LB_ACOESTOMADAS_ARQUIVOS](
	[ACA_ID] [int] IDENTITY(1,1) NOT NULL,
	[ACT_ID] [int] NOT NULL,
	[LB_ID] [smallint] NOT NULL,
	[ACA_LINK] [varchar](5000) NOT NULL,
	[ACA_USUARIOCADASTROU] [varchar](20) NULL,
	[ACA_DATACADASTRO] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[ACA_ID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY]
END
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[ResolucaoLB]    Script Date: 07/27/2018 09:30:30 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ResolucaoLB]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[ResolucaoLB](
	[R_ID] [smallint] IDENTITY(1,1) NOT NULL,
	[LB_ID] [smallint] NOT NULL,
	[R_NOME] [varchar](200) NULL,
	[R_NUMERO] [smallint] NULL
) ON [PRIMARY]
END
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[DisposicaoLB]    Script Date: 07/27/2018 09:30:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DisposicaoLB]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[DisposicaoLB](
	[D_ID] [smallint] IDENTITY(1,1) NOT NULL,
	[LB_ID] [smallint] NULL,
	[D_DISPOSICAO] [varchar](200) NULL,
	[D_EXECUTANTE] [varchar](200) NULL,
	[D_PRAZO] [smalldatetime] NULL,
	[D_DATACONCLUSAO] [smalldatetime] NULL,
	[D_EFICACIA] [tinyint] NULL
) ON [PRIMARY]
END
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[LogBook_Agendamento]    Script Date: 07/27/2018 09:30:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[LogBook_Agendamento]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[LogBook_Agendamento](
	[LB_ID] [smallint] NOT NULL,
	[AG_NUMERO] [smallint] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[LB_ID] ASC,
	[AG_NUMERO] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[SCE_PartNumberModelo]    Script Date: 07/27/2018 09:30:36 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[SCE_PartNumberModelo]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[SCE_PartNumberModelo](
	[MOD_ID] [int] NOT NULL,
	[PN_PARTNUMBER] [varchar](50) NOT NULL,
	[id] [int] IDENTITY(1,1) NOT NULL,
 CONSTRAINT [PK_SCE_PartNumberModelo] PRIMARY KEY NONCLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY]
END
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Agenda_Servicos_Plataforma]    Script Date: 07/27/2018 09:30:12 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Agenda_Servicos_Plataforma]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[Agenda_Servicos_Plataforma](
	[S_ID] [smallint] NOT NULL,
	[AG_NUMERO] [smallint] NOT NULL,
 CONSTRAINT [PK_Agenda_Servicos_Plataforma] PRIMARY KEY CLUSTERED 
(
	[S_ID] ASC,
	[AG_NUMERO] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[Historico_EventosOS]    Script Date: 07/27/2018 09:30:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Historico_EventosOS]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[Historico_EventosOS](
	[HEOS_ID] [smallint] IDENTITY(1,1) NOT NULL,
	[HEOS_RESPONSAVEL] [varchar](20) NULL,
	[AG_NUMERO] [smallint] NULL,
	[ID_SITUACAO] [smallint] NULL,
	[OS_ID] [smallint] NULL,
	[HEOS_DATAINICIO] [datetime] NULL,
	[HEOS_DATATERMINO] [smalldatetime] NULL,
	[HEOS_MOTIVO] [varchar](255) NULL,
 CONSTRAINT [PK__Historico_Evento__5441852A] PRIMARY KEY CLUSTERED 
(
	[HEOS_ID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY]
END
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[FAC_TIPO_COMPONENTE]    Script Date: 07/27/2018 09:30:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[FAC_TIPO_COMPONENTE]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[FAC_TIPO_COMPONENTE](
	[TPC_ID] [int] IDENTITY(1,1) NOT NULL,
	[TPC_NOME] [varchar](50) NOT NULL,
	[FTC_ID] [int] NOT NULL,
	[FAB_ID] [int] NOT NULL,
PRIMARY KEY NONCLUSTERED 
(
	[TPC_ID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY]
END
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[FAC_REL_CARACTERISTICAS_TIPO]    Script Date: 07/27/2018 09:30:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[FAC_REL_CARACTERISTICAS_TIPO]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[FAC_REL_CARACTERISTICAS_TIPO](
	[CAR_ID] [int] NOT NULL,
	[RCT_QUANTIDADE] [smallint] NULL,
	[TPC_ID] [int] NOT NULL,
PRIMARY KEY NONCLUSTERED 
(
	[CAR_ID] ASC,
	[TPC_ID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[FAC_CIRCUITO]    Script Date: 07/27/2018 09:30:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[FAC_CIRCUITO]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[FAC_CIRCUITO](
	[CTO_ID] [int] IDENTITY(1,1) NOT NULL,
	[CTO_NOME] [varchar](200) NULL,
	[TPC_ID] [int] NOT NULL,
	[CTO_PERMANENTE] [bit] NULL,
	[CTO_ATIVADO] [bit] NOT NULL,
	[AG_Numero] [int] NULL,
PRIMARY KEY NONCLUSTERED 
(
	[CTO_ID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY]
END
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[FAC_REL_CIRCUITO_AGENDAMENTO]    Script Date: 07/27/2018 09:30:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[FAC_REL_CIRCUITO_AGENDAMENTO]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[FAC_REL_CIRCUITO_AGENDAMENTO](
	[AG_NUMERO] [smallint] NOT NULL,
	[CTO_ID] [int] NOT NULL,
PRIMARY KEY NONCLUSTERED 
(
	[AG_NUMERO] ASC,
	[CTO_ID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[Historico_Eventos]    Script Date: 07/27/2018 09:30:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Historico_Eventos]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[Historico_Eventos](
	[HE_ID] [smallint] IDENTITY(1,1) NOT NULL,
	[HE_RESPONSAVEL] [varchar](20) NULL,
	[ID_SITUACAO] [smallint] NULL,
	[AG_NUMERO] [smallint] NOT NULL,
	[HE_DATAINICIO] [smalldatetime] NOT NULL,
	[HE_DATATERMINO] [smalldatetime] NULL,
	[HE_MOTIVO] [varchar](255) NULL,
 CONSTRAINT [PK__Historico_Evento__1B0907CE] PRIMARY KEY CLUSTERED 
(
	[HE_ID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY]
END
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Historico_datas]    Script Date: 07/27/2018 09:30:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Historico_datas]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[Historico_datas](
	[HD_MARCACAO] [smallint] NOT NULL,
	[AG_NUMERO] [smallint] NOT NULL,
	[HD_RESPONSAVEL] [varchar](20) NULL,
	[HD_DATAINICIO] [smalldatetime] NULL,
	[HD_DATATERMINO] [smalldatetime] NULL,
	[HD_FLAGREMARCADO] [bit] NOT NULL CONSTRAINT [DF_Historico_datas_HD_FLAGREMARCADO]  DEFAULT (0),
	[HD_MOTIVO] [varchar](7000) NULL,
 CONSTRAINT [PK__Historico_datas__31EC6D26] PRIMARY KEY CLUSTERED 
(
	[HD_MARCACAO] ASC,
	[AG_NUMERO] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY]
END
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[SCE_Reserva]    Script Date: 07/27/2018 09:30:37 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[SCE_Reserva]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[SCE_Reserva](
	[AG_NUMERO] [smallint] NOT NULL,
	[RES_DATACADASTRO] [datetime] NOT NULL CONSTRAINT [DF_SCE_Reserva_RES_DATACADASTRO]  DEFAULT (getdate()),
	[RES_RESPONSAVEL] [varchar](20) NOT NULL,
	[AMB_ID] [int] NULL,
	[RES_OBSERVACAO] [text] NULL,
 CONSTRAINT [PK_SCE_Reserva] PRIMARY KEY NONCLUSTERED 
(
	[AG_NUMERO] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Reserva_ambientes]    Script Date: 07/27/2018 09:30:30 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Reserva_ambientes]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[Reserva_ambientes](
	[RAM_ID] [int] IDENTITY(1,1) NOT NULL,
	[RAM_DataInicio] [smalldatetime] NULL,
	[RAM_DataFim] [smalldatetime] NULL,
	[RAM_Horario] [varchar](90) NULL,
	[RAM_Titulo] [varchar](2000) NULL,
	[RAM_Descricao] [varchar](3000) NULL,
	[AMB_ID] [int] NULL,
	[RAM_Contato] [text] NULL,
	[RAM_Responsavel] [varchar](20) NULL,
	[RAM_AS] [smallint] NULL,
 CONSTRAINT [PK_Reserva_ambientes] PRIMARY KEY NONCLUSTERED 
(
	[RAM_ID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Participantes_Externos]    Script Date: 07/27/2018 09:30:28 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Participantes_Externos]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[Participantes_Externos](
	[PE_ID] [smallint] IDENTITY(1,1) NOT NULL,
	[PE_NOME] [varchar](50) NULL,
	[AG_NUMERO] [smallint] NULL,
	[PE_EMPRESA] [varchar](50) NULL,
	[PE_MOTIVO] [varchar](200) NULL,
	[PE_USERNAME] [varchar](20) NULL,
	[PE_QUEMINCLUIU] [char](3) NULL DEFAULT ('CLI'),
 CONSTRAINT [PK__Participantes_Ex__5070F446] PRIMARY KEY CLUSTERED 
(
	[PE_ID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY]
END
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Situacoes_Situacoes]    Script Date: 07/27/2018 09:30:41 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Situacoes_Situacoes]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[Situacoes_Situacoes](
	[SITUACAO_ATUAL] [smallint] NOT NULL,
	[SITUACAO_PROXIMA] [smallint] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[SITUACAO_ATUAL] ASC,
	[SITUACAO_PROXIMA] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[FAC_LOCAIS_GENERICOS_EQUIP]    Script Date: 07/27/2018 09:30:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[FAC_LOCAIS_GENERICOS_EQUIP]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[FAC_LOCAIS_GENERICOS_EQUIP](
	[LGE_ID] [int] IDENTITY(1,1) NOT NULL,
	[LGE_NOME] [varchar](50) NOT NULL,
	[LGE_TIPO] [char](1) NOT NULL,
PRIMARY KEY NONCLUSTERED 
(
	[LGE_ID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY]
END
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[FAC_LOCAIS_ESPECIFICOS_EQUIP]    Script Date: 07/27/2018 09:30:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[FAC_LOCAIS_ESPECIFICOS_EQUIP]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[FAC_LOCAIS_ESPECIFICOS_EQUIP](
	[LGE_ID] [int] NOT NULL,
	[LEE_NOME] [varchar](50) NOT NULL,
	[LEE_ID] [int] IDENTITY(1,1) NOT NULL,
PRIMARY KEY NONCLUSTERED 
(
	[LEE_ID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY]
END
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[FAC_COMPONENTES]    Script Date: 07/27/2018 09:30:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[FAC_COMPONENTES]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[FAC_COMPONENTES](
	[TPC_ID] [int] NOT NULL,
	[CPT_ID] [int] IDENTITY(1,1) NOT NULL,
	[CPT_NOME] [varchar](200) NOT NULL,
	[LEE_ID] [int] NOT NULL,
	[CPT_COD_SGP_SCE] [varchar](50) NULL,
	[VSW_STD] [varchar](100) NULL,
	[VSW_ATU] [varchar](100) NULL,
	[Obs] [varchar](255) NULL,
PRIMARY KEY NONCLUSTERED 
(
	[CPT_ID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY]
END
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[FAC_FACILIDADES]    Script Date: 07/27/2018 09:30:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[FAC_FACILIDADES]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[FAC_FACILIDADES](
	[CPT_ID] [int] NOT NULL,
	[CTO_ID] [int] NOT NULL,
	[FAC_ORDEM] [tinyint] NOT NULL,
	[FAC_ID] [int] IDENTITY(1,1) NOT NULL,
	[TIPO_INTERFACE_ID] [int] NULL,
PRIMARY KEY NONCLUSTERED 
(
	[FAC_ID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[FAC_REL_CARACTERISTICAS_FACILIDADES]    Script Date: 07/27/2018 09:30:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[FAC_REL_CARACTERISTICAS_FACILIDADES]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[FAC_REL_CARACTERISTICAS_FACILIDADES](
	[CAR_ID] [int] NOT NULL,
	[TPC_ID] [int] NOT NULL,
	[RCF_IDENTIFICADOR_CARACTERISTICA] [varchar](255) NOT NULL,
	[FAC_ID] [int] NOT NULL,
 CONSTRAINT [PK__FAC_REL_CARACTER__630F92C5] PRIMARY KEY NONCLUSTERED 
(
	[CAR_ID] ASC,
	[TPC_ID] ASC,
	[FAC_ID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY]
END
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[TAREFAS_PREVISTAS]    Script Date: 07/27/2018 09:30:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[TAREFAS_PREVISTAS]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[TAREFAS_PREVISTAS](
	[TAREFA_ID] [smallint] NOT NULL,
	[TP_ID] [int] IDENTITY(1,1) NOT NULL,
	[TP_DATAINICIAL] [smalldatetime] NOT NULL,
	[TP_DATAFINAL] [smalldatetime] NOT NULL,
	[TP_OBSERVACAO] [varchar](8000) NULL,
	[TAREFA_TIPO] [bit] NOT NULL,
	[PES_USERNAME] [varchar](20) NULL,
 CONSTRAINT [PK__TAREFAS_PREVISTA__532343BF] PRIMARY KEY CLUSTERED 
(
	[TP_ID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY]
END
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Plantao]    Script Date: 07/27/2018 09:30:29 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Plantao]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[Plantao](
	[PLA_CODNOTICIA] [int] IDENTITY(1,1) NOT NULL,
	[PLA_TITNOTICIA] [nvarchar](510) NULL,
	[PLA_DATAINICIO] [smalldatetime] NULL,
	[PLA_DATATERMINO] [smalldatetime] NULL,
	[PLA_USERID] [varchar](20) NULL,
	[PLA_DATACADASTRO] [smalldatetime] NULL,
	[PLA_LINK] [varchar](255) NULL,
 CONSTRAINT [PK__Plantao__412EB0B6] PRIMARY KEY CLUSTERED 
(
	[PLA_CODNOTICIA] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY]
END
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[SCE_Reserva_Equipamentos]    Script Date: 07/27/2018 09:30:38 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[SCE_Reserva_Equipamentos]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[SCE_Reserva_Equipamentos](
	[AG_NUMERO] [smallint] NOT NULL,
	[EQ_ID] [int] NOT NULL,
	[REQ_DATAINICIO] [datetime] NOT NULL CONSTRAINT [DF_SCE_Reserva_Equipamentos_REQ_DATAINICIO]  DEFAULT (getdate()),
	[REQ_DATATERMINO] [datetime] NOT NULL CONSTRAINT [DF_SCE_Reserva_Equipamentos_REQ_DATAFIM]  DEFAULT (getdate()),
	[REQ_DEVOLVIDOLOG] [bit] NOT NULL CONSTRAINT [DF_SCE_Reserva_Equipamentos_REQ_LIBERADOTESTE]  DEFAULT (0),
	[REQ_EQSETUP] [char](1) NOT NULL CONSTRAINT [DF__SCE_Reser__REQ_E__25B24A21]  DEFAULT ('E'),
	[REQ_ACEITO] [tinyint] NULL,
	[REQ_MOVIMENTOU] [bit] NOT NULL CONSTRAINT [DF_SCE_Reserva_Equipamentos_REQ_MOVIMENTOU]  DEFAULT (0),
	[AMB_ID] [int] NULL,
 CONSTRAINT [PK_SCE_Reserva_Equipamentos] PRIMARY KEY CLUSTERED 
(
	[AG_NUMERO] ASC,
	[EQ_ID] ASC,
	[REQ_DATAINICIO] ASC,
	[REQ_DATATERMINO] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY]
END
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Trigger [trInsUpdTAREFAS_PREVISTAS]    Script Date: 07/27/2018 09:30:45 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.triggers WHERE object_id = OBJECT_ID(N'[dbo].[trInsUpdTAREFAS_PREVISTAS]'))
EXEC dbo.sp_executesql @statement = N'CREATE TRIGGER [dbo].[trInsUpdTAREFAS_PREVISTAS] ON [dbo].[TAREFAS_PREVISTAS] 
FOR INSERT, UPDATE
AS

DECLARE @tot1 INT, @tot2 INT, @tot3 INT

SELECT @tot1 = COUNT(*) FROM TAREFAS_PREVISTAS
SELECT @tot2 = COUNT(*)
FROM TAREFAS_PREVISTAS AS I 
INNER JOIN TAREFAS AS T ON I.TAREFA_ID=T.TAR_ID
WHERE I.TAREFA_TIPO=1
SELECT @tot3 = COUNT(*)
FROM TAREFAS_PREVISTAS AS I 
INNER JOIN AGENDAMENTO AS A ON I.TAREFA_ID=A.AG_NUMERO
WHERE I.TAREFA_TIPO=0
IF @tot1 - (@tot2+@tot3) > 0
BEGIN
	RAISERROR 30002 ''ERRO''
	ROLLBACK TRANSACTION
END
'
GO
/****** Object:  Table [dbo].[FERIADO]    Script Date: 07/27/2018 09:30:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING OFF
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[FERIADO]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[FERIADO](
	[FER_ID] [int] IDENTITY(1,1) NOT NULL,
	[FER_DESCRICAO] [varchar](255) NOT NULL,
	[FER_DATA] [smalldatetime] NOT NULL,
	[FER_ANOINICIO] [smallint] NULL,
	[FER_ANOFIM] [smallint] NULL,
PRIMARY KEY CLUSTERED 
(
	[FER_ID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY]
END
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Trigger [tU_FAC_REL_CARACTERISTICAS_TIPO]    Script Date: 07/27/2018 09:30:45 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
IF NOT EXISTS (SELECT * FROM sys.triggers WHERE object_id = OBJECT_ID(N'[dbo].[tU_FAC_REL_CARACTERISTICAS_TIPO]'))
EXEC dbo.sp_executesql @statement = N'
create trigger [dbo].[tU_FAC_REL_CARACTERISTICAS_TIPO] on [dbo].[FAC_REL_CARACTERISTICAS_TIPO] for UPDATE as
/* ERwin Builtin Wed Apr 10 09:54:27 2002 */
/* UPDATE trigger on FAC_REL_CARACTERISTICAS_TIPO */
begin
  declare  @numrows int,
           @nullcnt int,
           @validcnt int,
           @insCAR_ID int, 
           @insTPC_ID int,
           @errno   int,
           @errmsg  varchar(255)

  select @numrows = @@rowcount
  /* ERwin Builtin Wed Apr 10 09:54:27 2002 */
  /* FAC_REL_CARACTERISTICAS_TIPO R/14 FAC_REL_CARACTERISTICAS_FACILIDADES ON PARENT UPDATE CASCADE */
  if
    /* update(CAR_ID) or
       update(TPC_ID) */
    update(CAR_ID) or
    update(TPC_ID)
  begin
    if @numrows = 1
    begin
      select @insCAR_ID = inserted.CAR_ID, 
             @insTPC_ID = inserted.TPC_ID
        from inserted
      update FAC_REL_CARACTERISTICAS_FACILIDADES
      set
        /*  FAC_REL_CARACTERISTICAS_FACILIDADES.CAR_ID = @insCAR_ID,
            FAC_REL_CARACTERISTICAS_FACILIDADES.TPC_ID = @insTPC_ID */
        FAC_REL_CARACTERISTICAS_FACILIDADES.CAR_ID = @insCAR_ID,
        FAC_REL_CARACTERISTICAS_FACILIDADES.TPC_ID = @insTPC_ID
      from FAC_REL_CARACTERISTICAS_FACILIDADES,inserted,deleted
      where
        /*  FAC_REL_CARACTERISTICAS_FACILIDADES.CAR_ID = deleted.CAR_ID and
            FAC_REL_CARACTERISTICAS_FACILIDADES.TPC_ID = deleted.TPC_ID */
        FAC_REL_CARACTERISTICAS_FACILIDADES.CAR_ID = deleted.CAR_ID and
        FAC_REL_CARACTERISTICAS_FACILIDADES.TPC_ID = deleted.TPC_ID
    end
    else
    begin
      select @errno = 30006,
             @errmsg = ''Cannot cascade FAC_REL_CARACTERISTICAS_TIPO UPDATE because more than one row has been affected.''
      goto error
    end
  end

  /* ERwin Builtin Wed Apr 10 09:54:27 2002 */
  /* FAC_TIPO_COMPONENTE R/7 FAC_REL_CARACTERISTICAS_TIPO ON CHILD UPDATE RESTRICT */
  if
    /* update(TPC_ID) */
    update(TPC_ID)
  begin
    select @nullcnt = 0
    select @validcnt = count(*)
      from inserted,FAC_TIPO_COMPONENTE
        where
          /* inserted.TPC_ID = FAC_TIPO_COMPONENTE.TPC_ID */
          inserted.TPC_ID = FAC_TIPO_COMPONENTE.TPC_ID
    /*  */
    
    if @validcnt + @nullcnt != @numrows
    begin
      select @errno  = 30007,
             @errmsg = ''Cannot UPDATE FAC_REL_CARACTERISTICAS_TIPO because FAC_TIPO_COMPONENTE does not exist.''
      goto error
    end
  end

  /* ERwin Builtin Wed Apr 10 09:54:27 2002 */
  /* FAC_CARACTERISTICAS R/6 FAC_REL_CARACTERISTICAS_TIPO ON CHILD UPDATE RESTRICT */
  if
    /* update(CAR_ID) */
    update(CAR_ID)
  begin
    select @nullcnt = 0
    select @validcnt = count(*)
      from inserted,FAC_CARACTERISTICAS
        where
          /* inserted.CAR_ID = FAC_CARACTERISTICAS.CAR_ID */
          inserted.CAR_ID = FAC_CARACTERISTICAS.CAR_ID
    /*  */
    
    if @validcnt + @nullcnt != @numrows
    begin
      select @errno  = 30007,
             @errmsg = ''Cannot UPDATE FAC_REL_CARACTERISTICAS_TIPO because FAC_CARACTERISTICAS does not exist.''
      goto error
    end
  end


  /* ERwin Builtin Wed Apr 10 09:54:27 2002 */
  return
error:
    raiserror @errno @errmsg
    rollback transaction
end
'
GO
/****** Object:  Trigger [tI_FAC_REL_CARACTERISTICAS_TIPO]    Script Date: 07/27/2018 09:30:45 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
IF NOT EXISTS (SELECT * FROM sys.triggers WHERE object_id = OBJECT_ID(N'[dbo].[tI_FAC_REL_CARACTERISTICAS_TIPO]'))
EXEC dbo.sp_executesql @statement = N'
create trigger [dbo].[tI_FAC_REL_CARACTERISTICAS_TIPO] on [dbo].[FAC_REL_CARACTERISTICAS_TIPO] for INSERT as
/* ERwin Builtin Wed Apr 10 09:54:27 2002 */
/* INSERT trigger on FAC_REL_CARACTERISTICAS_TIPO */
begin
  declare  @numrows int,
           @nullcnt int,
           @validcnt int,
           @errno   int,
           @errmsg  varchar(255)

  select @numrows = @@rowcount
  /* ERwin Builtin Wed Apr 10 09:54:27 2002 */
  /* FAC_TIPO_COMPONENTE R/7 FAC_REL_CARACTERISTICAS_TIPO ON CHILD INSERT RESTRICT */
  if
    /* update(TPC_ID) */
    update(TPC_ID)
  begin
    select @nullcnt = 0
    select @validcnt = count(*)
      from inserted,FAC_TIPO_COMPONENTE
        where
          /* inserted.TPC_ID = FAC_TIPO_COMPONENTE.TPC_ID */
          inserted.TPC_ID = FAC_TIPO_COMPONENTE.TPC_ID
    /*  */
    
    if @validcnt + @nullcnt != @numrows
    begin
      select @errno  = 30002,
             @errmsg = ''Cannot INSERT FAC_REL_CARACTERISTICAS_TIPO because FAC_TIPO_COMPONENTE does not exist.''
      goto error
    end
  end

  /* ERwin Builtin Wed Apr 10 09:54:27 2002 */
  /* FAC_CARACTERISTICAS R/6 FAC_REL_CARACTERISTICAS_TIPO ON CHILD INSERT RESTRICT */
  if
    /* update(CAR_ID) */
    update(CAR_ID)
  begin
    select @nullcnt = 0
    select @validcnt = count(*)
      from inserted,FAC_CARACTERISTICAS
        where
          /* inserted.CAR_ID = FAC_CARACTERISTICAS.CAR_ID */
          inserted.CAR_ID = FAC_CARACTERISTICAS.CAR_ID
    /*  */
    
    if @validcnt + @nullcnt != @numrows
    begin
      select @errno  = 30002,
             @errmsg = ''Cannot INSERT FAC_REL_CARACTERISTICAS_TIPO because FAC_CARACTERISTICAS does not exist.''
      goto error
    end
  end


  /* ERwin Builtin Wed Apr 10 09:54:27 2002 */
  return
error:
    raiserror @errno @errmsg
    rollback transaction
end
'
GO
/****** Object:  Trigger [tD_FAC_CARACTERISTICAS]    Script Date: 07/27/2018 09:30:45 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
IF NOT EXISTS (SELECT * FROM sys.triggers WHERE object_id = OBJECT_ID(N'[dbo].[tD_FAC_CARACTERISTICAS]'))
EXEC dbo.sp_executesql @statement = N'



create trigger [dbo].[tD_FAC_CARACTERISTICAS] on [dbo].[FAC_CARACTERISTICAS] for DELETE as
/* ERwin Builtin Wed Apr 10 09:54:26 2002 */
/* DELETE trigger on FAC_CARACTERISTICAS */
begin
  declare  @errno   int,
           @errmsg  varchar(255)
    /* ERwin Builtin Wed Apr 10 09:54:26 2002 */
    /* FAC_CARACTERISTICAS R/6 FAC_REL_CARACTERISTICAS_TIPO ON PARENT DELETE RESTRICT */
    if exists (
      select * from deleted,FAC_REL_CARACTERISTICAS_TIPO
      where
        /*  FAC_REL_CARACTERISTICAS_TIPO.CAR_ID = deleted.CAR_ID */
        FAC_REL_CARACTERISTICAS_TIPO.CAR_ID = deleted.CAR_ID
    )
    begin
      select @errno  = 30001,
             @errmsg = ''Cannot DELETE FAC_CARACTERISTICAS because FAC_REL_CARACTERISTICAS_TIPO exists.''
      goto error
    end


    /* ERwin Builtin Wed Apr 10 09:54:26 2002 */
    return
error:
    raiserror @errno @errmsg
    rollback transaction
end
'
GO
/****** Object:  Trigger [tU_FAC_CARACTERISTICAS]    Script Date: 07/27/2018 09:30:45 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
IF NOT EXISTS (SELECT * FROM sys.triggers WHERE object_id = OBJECT_ID(N'[dbo].[tU_FAC_CARACTERISTICAS]'))
EXEC dbo.sp_executesql @statement = N'
create trigger [dbo].[tU_FAC_CARACTERISTICAS] on [dbo].[FAC_CARACTERISTICAS] for UPDATE as
/* ERwin Builtin Wed Apr 10 09:54:26 2002 */
/* UPDATE trigger on FAC_CARACTERISTICAS */
begin
  declare  @numrows int,
           @nullcnt int,
           @validcnt int,
           @insCAR_ID int,
           @errno   int,
           @errmsg  varchar(255)

  select @numrows = @@rowcount
  /* ERwin Builtin Wed Apr 10 09:54:26 2002 */
  /* FAC_CARACTERISTICAS R/6 FAC_REL_CARACTERISTICAS_TIPO ON PARENT UPDATE CASCADE */
  if
    /* update(CAR_ID) */
    update(CAR_ID)
  begin
    if @numrows = 1
    begin
      select @insCAR_ID = inserted.CAR_ID
        from inserted
      update FAC_REL_CARACTERISTICAS_TIPO
      set
        /*  FAC_REL_CARACTERISTICAS_TIPO.CAR_ID = @insCAR_ID */
        FAC_REL_CARACTERISTICAS_TIPO.CAR_ID = @insCAR_ID
      from FAC_REL_CARACTERISTICAS_TIPO,inserted,deleted
      where
        /*  FAC_REL_CARACTERISTICAS_TIPO.CAR_ID = deleted.CAR_ID */
        FAC_REL_CARACTERISTICAS_TIPO.CAR_ID = deleted.CAR_ID
    end
    else
    begin
      select @errno = 30006,
             @errmsg = ''Cannot cascade FAC_CARACTERISTICAS UPDATE because more than one row has been affected.''
      goto error
    end
  end


  /* ERwin Builtin Wed Apr 10 09:54:26 2002 */
  return
error:
    raiserror @errno @errmsg
    rollback transaction
end
'
GO
/****** Object:  Trigger [tr_U_AGENDAMENTO]    Script Date: 07/27/2018 09:30:45 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.triggers WHERE object_id = OBJECT_ID(N'[dbo].[tr_U_AGENDAMENTO]'))
EXEC dbo.sp_executesql @statement = N'CREATE TRIGGER [dbo].[tr_U_AGENDAMENTO] ON [dbo].[Agendamento]
FOR UPDATE
AS
BEGIN
	/*** Criado em 298/03/2004 ***/

	/***
		altero as datas da reserva de ambientes de acordo com as datas 
		de início e término da AS
	***/
	IF UPDATE(AG_DATAINICIO) BEGIN
		UPDATE Reserva_Ambientes SET RAM_DataInicio = Inserted.AG_DATAINICIO
		FROM Reserva_Ambientes INNER JOIN Inserted ON Reserva_Ambientes.RAM_AS = Inserted.AG_NUMERO
	END

	IF UPDATE(AG_DATATERMINO) BEGIN
		UPDATE Reserva_Ambientes SET RAM_DataFim = Inserted.AG_DATATERMINO
		FROM Reserva_Ambientes INNER JOIN Inserted ON Reserva_Ambientes.RAM_AS = Inserted.AG_NUMERO
	END
	/***/
END
'
GO
/****** Object:  Trigger [tr_Agendamento_Responsavel_Reserva]    Script Date: 07/27/2018 09:30:45 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.triggers WHERE object_id = OBJECT_ID(N'[dbo].[tr_Agendamento_Responsavel_Reserva]'))
EXEC dbo.sp_executesql @statement = N'CREATE TRIGGER [dbo].[tr_Agendamento_Responsavel_Reserva]
   ON [dbo].[Agendamento] AFTER UPDATE
AS 
BEGIN
	SET NOCOUNT ON

	/* Atualiza o responsável se houver mudança no agendamento */
	UPDATE SCE_Reserva
	SET RES_RESPONSAVEL = a.AG_RESPONSAVEL
	FROM SCE_Reserva R INNER JOIN 
		Agendamento A ON R.AG_NUMERO = A.AG_NUMERO INNER JOIN
		Inserted I ON I.AG_NUMERO = A.AG_NUMERO

	/* Atualiza o responsável na reserva de ambiente */
	UPDATE Reserva_ambientes
	SET RAM_RESPONSAVEL = a.AG_RESPONSAVEL
	FROM Reserva_ambientes R INNER JOIN 
		Agendamento A ON R.RAM_AS = A.AG_NUMERO INNER JOIN
		Inserted I ON I.AG_NUMERO = A.AG_NUMERO
	WHERE r.RAM_RESPONSAVEL <> a.AG_RESPONSAVEL
END
'
GO
/****** Object:  Trigger [tr_SCE_Reserva_Responsavel]    Script Date: 07/27/2018 09:30:45 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.triggers WHERE object_id = OBJECT_ID(N'[dbo].[tr_SCE_Reserva_Responsavel]'))
EXEC dbo.sp_executesql @statement = N'CREATE TRIGGER [dbo].[tr_SCE_Reserva_Responsavel]
   ON  [dbo].[SCE_Reserva] AFTER INSERT, UPDATE
AS 
BEGIN
	SET NOCOUNT ON

	/* Atualiza o responsável se houver mudança no agendamento */
	UPDATE SCE_Reserva
	SET RES_RESPONSAVEL = a.AG_RESPONSAVEL
	FROM SCE_Reserva R INNER JOIN 
		Agendamento A ON R.AG_NUMERO = A.AG_NUMERO INNER JOIN
		Inserted I ON I.AG_NUMERO = A.AG_NUMERO
	WHERE r.RES_RESPONSAVEL <> a.AG_RESPONSAVEL
END
'
GO
/****** Object:  Trigger [tI_FAC_REL_CIRCUITO_AGENDAMENTO]    Script Date: 07/27/2018 09:30:45 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
IF NOT EXISTS (SELECT * FROM sys.triggers WHERE object_id = OBJECT_ID(N'[dbo].[tI_FAC_REL_CIRCUITO_AGENDAMENTO]'))
EXEC dbo.sp_executesql @statement = N'
create trigger [dbo].[tI_FAC_REL_CIRCUITO_AGENDAMENTO] on [dbo].[FAC_REL_CIRCUITO_AGENDAMENTO] for INSERT as
/* ERwin Builtin Wed Apr 10 09:54:27 2002 */
/* INSERT trigger on FAC_REL_CIRCUITO_AGENDAMENTO */
begin
  declare  @numrows int,
           @nullcnt int,
           @validcnt int,
           @errno   int,
           @errmsg  varchar(255)

  select @numrows = @@rowcount
  /* ERwin Builtin Wed Apr 10 09:54:27 2002 */
  /* FAC_CIRCUITO R/19 FAC_REL_CIRCUITO_AGENDAMENTO ON CHILD INSERT RESTRICT */
  if
    /* update(CTO_ID) */
    update(CTO_ID)
  begin
    select @nullcnt = 0
    select @validcnt = count(*)
      from inserted,FAC_CIRCUITO
        where
          /* inserted.CTO_ID = FAC_CIRCUITO.CTO_ID */
          inserted.CTO_ID = FAC_CIRCUITO.CTO_ID
    /*  */
    
    if @validcnt + @nullcnt != @numrows
    begin
      select @errno  = 30002,
             @errmsg = ''Cannot INSERT FAC_REL_CIRCUITO_AGENDAMENTO because FAC_CIRCUITO does not exist.''
      goto error
    end
  end

  /* ERwin Builtin Wed Apr 10 09:54:27 2002 */
  /* Agendamento R/18 FAC_REL_CIRCUITO_AGENDAMENTO ON CHILD INSERT RESTRICT */
  if
    /* update(AG_NUMERO) */
    update(AG_NUMERO)
  begin
    select @nullcnt = 0
    select @validcnt = count(*)
      from inserted,Agendamento
        where
          /* inserted.AG_NUMERO = Agendamento.AG_NUMERO */
          inserted.AG_NUMERO = Agendamento.AG_NUMERO
    /*  */
    
    if @validcnt + @nullcnt != @numrows
    begin
      select @errno  = 30002,
             @errmsg = ''Cannot INSERT FAC_REL_CIRCUITO_AGENDAMENTO because Agendamento does not exist.''
      goto error
    end
  end


  /* ERwin Builtin Wed Apr 10 09:54:27 2002 */
  return
error:
    raiserror @errno @errmsg
    rollback transaction
end
'
GO
/****** Object:  Trigger [tU_FAC_REL_CIRCUITO_AGENDAMENTO]    Script Date: 07/27/2018 09:30:45 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
IF NOT EXISTS (SELECT * FROM sys.triggers WHERE object_id = OBJECT_ID(N'[dbo].[tU_FAC_REL_CIRCUITO_AGENDAMENTO]'))
EXEC dbo.sp_executesql @statement = N'
create trigger [dbo].[tU_FAC_REL_CIRCUITO_AGENDAMENTO] on [dbo].[FAC_REL_CIRCUITO_AGENDAMENTO] for UPDATE as
/* ERwin Builtin Wed Apr 10 09:54:28 2002 */
/* UPDATE trigger on FAC_REL_CIRCUITO_AGENDAMENTO */
begin
  declare  @numrows int,
           @nullcnt int,
           @validcnt int,
           @insAG_NUMERO smallint, 
           @insCTO_ID int,
           @errno   int,
           @errmsg  varchar(255)

  select @numrows = @@rowcount
  /* ERwin Builtin Wed Apr 10 09:54:27 2002 */
  /* FAC_CIRCUITO R/19 FAC_REL_CIRCUITO_AGENDAMENTO ON CHILD UPDATE RESTRICT */
  if
    /* update(CTO_ID) */
    update(CTO_ID)
  begin
    select @nullcnt = 0
    select @validcnt = count(*)
      from inserted,FAC_CIRCUITO
        where
          /* inserted.CTO_ID = FAC_CIRCUITO.CTO_ID */
          inserted.CTO_ID = FAC_CIRCUITO.CTO_ID
    /*  */
    
    if @validcnt + @nullcnt != @numrows
    begin
      select @errno  = 30007,
             @errmsg = ''Cannot UPDATE FAC_REL_CIRCUITO_AGENDAMENTO because FAC_CIRCUITO does not exist.''
      goto error
    end
  end

  /* ERwin Builtin Wed Apr 10 09:54:28 2002 */
  /* Agendamento R/18 FAC_REL_CIRCUITO_AGENDAMENTO ON CHILD UPDATE RESTRICT */
  if
    /* update(AG_NUMERO) */
    update(AG_NUMERO)
  begin
    select @nullcnt = 0
    select @validcnt = count(*)
      from inserted,Agendamento
        where
          /* inserted.AG_NUMERO = Agendamento.AG_NUMERO */
          inserted.AG_NUMERO = Agendamento.AG_NUMERO
    /*  */
    
    if @validcnt + @nullcnt != @numrows
    begin
      select @errno  = 30007,
             @errmsg = ''Cannot UPDATE FAC_REL_CIRCUITO_AGENDAMENTO because Agendamento does not exist.''
      goto error
    end
  end


  /* ERwin Builtin Wed Apr 10 09:54:28 2002 */
  return
error:
    raiserror @errno @errmsg
    rollback transaction
end
'
GO
/****** Object:  Trigger [tI_FAC_CIRCUITO]    Script Date: 07/27/2018 09:30:45 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
IF NOT EXISTS (SELECT * FROM sys.triggers WHERE object_id = OBJECT_ID(N'[dbo].[tI_FAC_CIRCUITO]'))
EXEC dbo.sp_executesql @statement = N'
create trigger [dbo].[tI_FAC_CIRCUITO] on [dbo].[FAC_CIRCUITO] for INSERT as
/* ERwin Builtin Wed Apr 10 09:54:26 2002 */
/* INSERT trigger on FAC_CIRCUITO */
begin
  declare  @numrows int,
           @nullcnt int,
           @validcnt int,
           @errno   int,
           @errmsg  varchar(255)

  select @numrows = @@rowcount
  /* ERwin Builtin Wed Apr 10 09:54:26 2002 */
  /* FAC_TIPO_CIRCUITO R/5 FAC_CIRCUITO ON CHILD INSERT RESTRICT */
  if
    /* update(TPC_ID) */
    update(TPC_ID)
  begin
    select @nullcnt = 0
    select @validcnt = count(*)
      from inserted,FAC_TIPO_CIRCUITO
        where
          /* inserted.TPC_ID = FAC_TIPO_CIRCUITO.TPC_ID */
          inserted.TPC_ID = FAC_TIPO_CIRCUITO.TPC_ID
    /*  */
    
    if @validcnt + @nullcnt != @numrows
    begin
      select @errno  = 30002,
             @errmsg = ''Cannot INSERT FAC_CIRCUITO because FAC_TIPO_CIRCUITO does not exist.''
      goto error
    end
  end


  /* ERwin Builtin Wed Apr 10 09:54:26 2002 */
  return
error:
    raiserror @errno @errmsg
    rollback transaction
end
'
GO
/****** Object:  Trigger [tU_FAC_CIRCUITO]    Script Date: 07/27/2018 09:30:45 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
IF NOT EXISTS (SELECT * FROM sys.triggers WHERE object_id = OBJECT_ID(N'[dbo].[tU_FAC_CIRCUITO]'))
EXEC dbo.sp_executesql @statement = N'
create trigger [dbo].[tU_FAC_CIRCUITO] on [dbo].[FAC_CIRCUITO] for UPDATE as
/* ERwin Builtin Wed Apr 10 09:54:26 2002 */
/* UPDATE trigger on FAC_CIRCUITO */
begin
  declare  @numrows int,
           @nullcnt int,
           @validcnt int,
           @insCTO_ID int,
           @errno   int,
           @errmsg  varchar(255)

  select @numrows = @@rowcount
  /* ERwin Builtin Wed Apr 10 09:54:26 2002 */
  /* FAC_CIRCUITO R/19 FAC_REL_CIRCUITO_AGENDAMENTO ON PARENT UPDATE CASCADE */
  if
    /* update(CTO_ID) */
    update(CTO_ID)
  begin
    if @numrows = 1
    begin
      select @insCTO_ID = inserted.CTO_ID
        from inserted
      update FAC_REL_CIRCUITO_AGENDAMENTO
      set
        /*  FAC_REL_CIRCUITO_AGENDAMENTO.CTO_ID = @insCTO_ID */
        FAC_REL_CIRCUITO_AGENDAMENTO.CTO_ID = @insCTO_ID
      from FAC_REL_CIRCUITO_AGENDAMENTO,inserted,deleted
      where
        /*  FAC_REL_CIRCUITO_AGENDAMENTO.CTO_ID = deleted.CTO_ID */
        FAC_REL_CIRCUITO_AGENDAMENTO.CTO_ID = deleted.CTO_ID
    end
    else
    begin
      select @errno = 30006,
             @errmsg = ''Cannot cascade FAC_CIRCUITO UPDATE because more than one row has been affected.''
      goto error
    end
  end

  /* ERwin Builtin Wed Apr 10 09:54:26 2002 */
  /* FAC_CIRCUITO R/9 FAC_FACILIDADES ON PARENT UPDATE CASCADE */
  if
    /* update(CTO_ID) */
    update(CTO_ID)
  begin
    if @numrows = 1
    begin
      select @insCTO_ID = inserted.CTO_ID
        from inserted
      update FAC_FACILIDADES
      set
        /*  FAC_FACILIDADES.CTO_ID = @insCTO_ID */
        FAC_FACILIDADES.CTO_ID = @insCTO_ID
      from FAC_FACILIDADES,inserted,deleted
      where
        /*  FAC_FACILIDADES.CTO_ID = deleted.CTO_ID */
        FAC_FACILIDADES.CTO_ID = deleted.CTO_ID
    end
    else
    begin
      select @errno = 30006,
             @errmsg = ''Cannot cascade FAC_CIRCUITO UPDATE because more than one row has been affected.''
      goto error
    end
  end

  /* ERwin Builtin Wed Apr 10 09:54:26 2002 */
  /* FAC_TIPO_CIRCUITO R/5 FAC_CIRCUITO ON CHILD UPDATE RESTRICT */
  if
    /* update(TPC_ID) */
    update(TPC_ID)
  begin
    select @nullcnt = 0
    select @validcnt = count(*)
      from inserted,FAC_TIPO_CIRCUITO
        where
          /* inserted.TPC_ID = FAC_TIPO_CIRCUITO.TPC_ID */
          inserted.TPC_ID = FAC_TIPO_CIRCUITO.TPC_ID
    /*  */
    
    if @validcnt + @nullcnt != @numrows
    begin
      select @errno  = 30007,
             @errmsg = ''Cannot UPDATE FAC_CIRCUITO because FAC_TIPO_CIRCUITO does not exist.''
      goto error
    end
  end


  /* ERwin Builtin Wed Apr 10 09:54:26 2002 */
  return
error:
    raiserror @errno @errmsg
    rollback transaction
end
'
GO
/****** Object:  Trigger [tD_FAC_CIRCUITO]    Script Date: 07/27/2018 09:30:45 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
IF NOT EXISTS (SELECT * FROM sys.triggers WHERE object_id = OBJECT_ID(N'[dbo].[tD_FAC_CIRCUITO]'))
EXEC dbo.sp_executesql @statement = N'
create trigger [dbo].[tD_FAC_CIRCUITO] on [dbo].[FAC_CIRCUITO] for DELETE as
/* ERwin Builtin Wed Apr 10 09:54:26 2002 */
/* DELETE trigger on FAC_CIRCUITO */
begin
  declare  @errno   int,
           @errmsg  varchar(255)
    /* ERwin Builtin Wed Apr 10 09:54:26 2002 */
    /* FAC_CIRCUITO R/19 FAC_REL_CIRCUITO_AGENDAMENTO ON PARENT DELETE CASCADE */
    delete FAC_REL_CIRCUITO_AGENDAMENTO
      from FAC_REL_CIRCUITO_AGENDAMENTO,deleted
      where
        /*  FAC_REL_CIRCUITO_AGENDAMENTO.CTO_ID = deleted.CTO_ID */
        FAC_REL_CIRCUITO_AGENDAMENTO.CTO_ID = deleted.CTO_ID

    /* ERwin Builtin Wed Apr 10 09:54:26 2002 */
    /* FAC_CIRCUITO R/9 FAC_FACILIDADES ON PARENT DELETE CASCADE */
    delete FAC_FACILIDADES
      from FAC_FACILIDADES,deleted
      where
        /*  FAC_FACILIDADES.CTO_ID = deleted.CTO_ID */
        FAC_FACILIDADES.CTO_ID = deleted.CTO_ID


    /* ERwin Builtin Wed Apr 10 09:54:26 2002 */
    return
error:
    raiserror @errno @errmsg
    rollback transaction
end
'
GO
/****** Object:  Trigger [tU_FAC_FACILIDADES]    Script Date: 07/27/2018 09:30:45 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
IF NOT EXISTS (SELECT * FROM sys.triggers WHERE object_id = OBJECT_ID(N'[dbo].[tU_FAC_FACILIDADES]'))
EXEC dbo.sp_executesql @statement = N'
create trigger [dbo].[tU_FAC_FACILIDADES] on [dbo].[FAC_FACILIDADES] for UPDATE as
/* ERwin Builtin Wed Apr 10 09:54:27 2002 */
/* UPDATE trigger on FAC_FACILIDADES */
begin
  declare  @numrows int,
           @nullcnt int,
           @validcnt int,
           @insFAC_ID int,
           @errno   int,
           @errmsg  varchar(255)

  select @numrows = @@rowcount
  /* ERwin Builtin Wed Apr 10 09:54:27 2002 */
  /* FAC_FACILIDADES R/13 FAC_REL_CARACTERISTICAS_FACILIDADES ON PARENT UPDATE CASCADE */
  if
    /* update(FAC_ID) */
    update(FAC_ID)
  begin
    if @numrows = 1
    begin
      select @insFAC_ID = inserted.FAC_ID
        from inserted
      update FAC_REL_CARACTERISTICAS_FACILIDADES
      set
        /*  FAC_REL_CARACTERISTICAS_FACILIDADES.FAC_ID = @insFAC_ID */
        FAC_REL_CARACTERISTICAS_FACILIDADES.FAC_ID = @insFAC_ID
      from FAC_REL_CARACTERISTICAS_FACILIDADES,inserted,deleted
      where
        /*  FAC_REL_CARACTERISTICAS_FACILIDADES.FAC_ID = deleted.FAC_ID */
        FAC_REL_CARACTERISTICAS_FACILIDADES.FAC_ID = deleted.FAC_ID
    end
    else
    begin
      select @errno = 30006,
             @errmsg = ''Cannot cascade FAC_FACILIDADES UPDATE because more than one row has been affected.''
      goto error
    end
  end

  /* ERwin Builtin Wed Apr 10 09:54:27 2002 */
  /* FAC_CIRCUITO R/9 FAC_FACILIDADES ON CHILD UPDATE RESTRICT */
  if
    /* update(CTO_ID) */
    update(CTO_ID)
  begin
    select @nullcnt = 0
    select @validcnt = count(*)
      from inserted,FAC_CIRCUITO
        where
          /* inserted.CTO_ID = FAC_CIRCUITO.CTO_ID */
          inserted.CTO_ID = FAC_CIRCUITO.CTO_ID
    /*  */
    
    if @validcnt + @nullcnt != @numrows
    begin
      select @errno  = 30007,
             @errmsg = ''Cannot UPDATE FAC_FACILIDADES because FAC_CIRCUITO does not exist.''
      goto error
    end
  end

  /* ERwin Builtin Wed Apr 10 09:54:27 2002 */
  /* FAC_COMPONENTES R/8 FAC_FACILIDADES ON CHILD UPDATE RESTRICT */
  if
    /* update(CPT_ID) */
    update(CPT_ID)
  begin
    select @nullcnt = 0
    select @validcnt = count(*)
      from inserted,FAC_COMPONENTES
        where
          /* inserted.CPT_ID = FAC_COMPONENTES.CPT_ID */
          inserted.CPT_ID = FAC_COMPONENTES.CPT_ID
    /*  */
    
    if @validcnt + @nullcnt != @numrows
    begin
      select @errno  = 30007,
             @errmsg = ''Cannot UPDATE FAC_FACILIDADES because FAC_COMPONENTES does not exist.''
      goto error
    end
  end


  /* ERwin Builtin Wed Apr 10 09:54:27 2002 */
  return
error:
    raiserror @errno @errmsg
    rollback transaction
end
'
GO
/****** Object:  Trigger [tI_FAC_FACILIDADES]    Script Date: 07/27/2018 09:30:45 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
IF NOT EXISTS (SELECT * FROM sys.triggers WHERE object_id = OBJECT_ID(N'[dbo].[tI_FAC_FACILIDADES]'))
EXEC dbo.sp_executesql @statement = N'
create trigger [dbo].[tI_FAC_FACILIDADES] on [dbo].[FAC_FACILIDADES] for INSERT as
/* ERwin Builtin Wed Apr 10 09:54:27 2002 */
/* INSERT trigger on FAC_FACILIDADES */
begin
  declare  @numrows int,
           @nullcnt int,
           @validcnt int,
           @errno   int,
           @errmsg  varchar(255)

  select @numrows = @@rowcount
  /* ERwin Builtin Wed Apr 10 09:54:27 2002 */
  /* FAC_CIRCUITO R/9 FAC_FACILIDADES ON CHILD INSERT RESTRICT */
  if
    /* update(CTO_ID) */
    update(CTO_ID)
  begin
    select @nullcnt = 0
    select @validcnt = count(*)
      from inserted,FAC_CIRCUITO
        where
          /* inserted.CTO_ID = FAC_CIRCUITO.CTO_ID */
          inserted.CTO_ID = FAC_CIRCUITO.CTO_ID
    /*  */
    
    if @validcnt + @nullcnt != @numrows
    begin
      select @errno  = 30002,
             @errmsg = ''Cannot INSERT FAC_FACILIDADES because FAC_CIRCUITO does not exist.''
      goto error
    end
  end

  /* ERwin Builtin Wed Apr 10 09:54:27 2002 */
  /* FAC_COMPONENTES R/8 FAC_FACILIDADES ON CHILD INSERT RESTRICT */
  if
    /* update(CPT_ID) */
    update(CPT_ID)
  begin
    select @nullcnt = 0
    select @validcnt = count(*)
      from inserted,FAC_COMPONENTES
        where
          /* inserted.CPT_ID = FAC_COMPONENTES.CPT_ID */
          inserted.CPT_ID = FAC_COMPONENTES.CPT_ID
    /*  */
    
    if @validcnt + @nullcnt != @numrows
    begin
      select @errno  = 30002,
             @errmsg = ''Cannot INSERT FAC_FACILIDADES because FAC_COMPONENTES does not exist.''
      goto error
    end
  end


  /* ERwin Builtin Wed Apr 10 09:54:27 2002 */
  return
error:
    raiserror @errno @errmsg
    rollback transaction
end
'
GO
/****** Object:  Trigger [tU_FAC_TIPO_CIRCUITO]    Script Date: 07/27/2018 09:30:45 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.triggers WHERE object_id = OBJECT_ID(N'[dbo].[tU_FAC_TIPO_CIRCUITO]'))
EXEC dbo.sp_executesql @statement = N'create trigger [dbo].[tU_FAC_TIPO_CIRCUITO] on [dbo].[FAC_TIPO_CIRCUITO] for UPDATE as
/* ERwin Builtin Wed Apr 10 09:54:28 2002 */
/* UPDATE trigger on FAC_TIPO_CIRCUITO */
begin
  declare  @numrows int,
           @nullcnt int,
           @validcnt int,
           @insTPC_ID int,
           @errno   int,
           @errmsg  varchar(255)

  select @numrows = @@rowcount
  /* ERwin Builtin Wed Apr 10 09:54:28 2002 */
  /* FAC_TIPO_CIRCUITO R/5 FAC_CIRCUITO ON PARENT UPDATE CASCADE */
  if
    /* update(TPC_ID) */
    update(TPC_ID)
  begin
    if @numrows = 1
    begin
      select @insTPC_ID = inserted.TPC_ID
        from inserted
      update FAC_CIRCUITO
      set
        /*  FAC_CIRCUITO.TPC_ID = @insTPC_ID */
        FAC_CIRCUITO.TPC_ID = @insTPC_ID
      from FAC_CIRCUITO,inserted,deleted
      where
        /*  FAC_CIRCUITO.TPC_ID = deleted.TPC_ID */
        FAC_CIRCUITO.TPC_ID = deleted.TPC_ID
    end
    else
    begin
      select @errno = 30006,
             @errmsg = ''Cannot cascade FAC_TIPO_CIRCUITO UPDATE because more than one row has been affected.''
      goto error
    end
  end


  /* ERwin Builtin Wed Apr 10 09:54:28 2002 */
  return
error:
    raiserror @errno @errmsg
    rollback transaction
end
'
GO
/****** Object:  Trigger [tD_FAC_TIPO_CIRCUITO]    Script Date: 07/27/2018 09:30:45 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.triggers WHERE object_id = OBJECT_ID(N'[dbo].[tD_FAC_TIPO_CIRCUITO]'))
EXEC dbo.sp_executesql @statement = N'create trigger [dbo].[tD_FAC_TIPO_CIRCUITO] on [dbo].[FAC_TIPO_CIRCUITO] for DELETE as
/* ERwin Builtin Wed Apr 10 09:54:28 2002 */
/* DELETE trigger on FAC_TIPO_CIRCUITO */
begin
  declare  @errno   int,
           @errmsg  varchar(255)
    /* ERwin Builtin Wed Apr 10 09:54:28 2002 */
    /* FAC_TIPO_CIRCUITO R/5 FAC_CIRCUITO ON PARENT DELETE RESTRICT */
    if exists (
      select * from deleted,FAC_CIRCUITO
      where
        /*  FAC_CIRCUITO.TPC_ID = deleted.TPC_ID */
        FAC_CIRCUITO.TPC_ID = deleted.TPC_ID
    )
    begin
      select @errno  = 30001,
             @errmsg = ''Cannot DELETE FAC_TIPO_CIRCUITO because FAC_CIRCUITO exists.''
      goto error
    end


    /* ERwin Builtin Wed Apr 10 09:54:28 2002 */
    return
error:
    raiserror @errno @errmsg
    rollback transaction
end
'
GO
/****** Object:  Trigger [tU_FAC_TIPO_COMPONENTE]    Script Date: 07/27/2018 09:30:45 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
IF NOT EXISTS (SELECT * FROM sys.triggers WHERE object_id = OBJECT_ID(N'[dbo].[tU_FAC_TIPO_COMPONENTE]'))
EXEC dbo.sp_executesql @statement = N'
create trigger [dbo].[tU_FAC_TIPO_COMPONENTE] on [dbo].[FAC_TIPO_COMPONENTE] for UPDATE as
/* ERwin Builtin Wed Apr 10 09:54:28 2002 */
/* UPDATE trigger on FAC_TIPO_COMPONENTE */
begin
  declare  @numrows int,
           @nullcnt int,
           @validcnt int,
           @insTPC_ID int,
           @errno   int,
           @errmsg  varchar(255)

  select @numrows = @@rowcount
  /* ERwin Builtin Wed Apr 10 09:54:28 2002 */
  /* FAC_TIPO_COMPONENTE R/7 FAC_REL_CARACTERISTICAS_TIPO ON PARENT UPDATE CASCADE */
  if
    /* update(TPC_ID) */
    update(TPC_ID)
  begin
    if @numrows = 1
    begin
      select @insTPC_ID = inserted.TPC_ID
        from inserted
      update FAC_REL_CARACTERISTICAS_TIPO
      set
        /*  FAC_REL_CARACTERISTICAS_TIPO.TPC_ID = @insTPC_ID */
        FAC_REL_CARACTERISTICAS_TIPO.TPC_ID = @insTPC_ID
      from FAC_REL_CARACTERISTICAS_TIPO,inserted,deleted
      where
        /*  FAC_REL_CARACTERISTICAS_TIPO.TPC_ID = deleted.TPC_ID */
        FAC_REL_CARACTERISTICAS_TIPO.TPC_ID = deleted.TPC_ID
    end
    else
    begin
      select @errno = 30006,
             @errmsg = ''Cannot cascade FAC_TIPO_COMPONENTE UPDATE because more than one row has been affected.''
      goto error
    end
  end

  /* ERwin Builtin Wed Apr 10 09:54:28 2002 */
  /* FAC_TIPO_COMPONENTE R/3 FAC_COMPONENTES ON PARENT UPDATE CASCADE */
  if
    /* update(TPC_ID) */
    update(TPC_ID)
  begin
    if @numrows = 1
    begin
      select @insTPC_ID = inserted.TPC_ID
        from inserted
      update FAC_COMPONENTES
      set
        /*  FAC_COMPONENTES.TPC_ID = @insTPC_ID */
        FAC_COMPONENTES.TPC_ID = @insTPC_ID
      from FAC_COMPONENTES,inserted,deleted
      where
        /*  FAC_COMPONENTES.TPC_ID = deleted.TPC_ID */
        FAC_COMPONENTES.TPC_ID = deleted.TPC_ID
    end
    else
    begin
      select @errno = 30006,
             @errmsg = ''Cannot cascade FAC_TIPO_COMPONENTE UPDATE because more than one row has been affected.''
      goto error
    end
  end

  /* ERwin Builtin Wed Apr 10 09:54:28 2002 */
  /* FAC_FABRICANTE_TIPO_COMPONENTE R/16 FAC_TIPO_COMPONENTE ON CHILD UPDATE RESTRICT */
  if
    /* update(FAB_ID) */
    update(FAB_ID)
  begin
    select @nullcnt = 0
    select @validcnt = count(*)
      from inserted,FAC_FABRICANTE_TIPO_COMPONENTE
        where
          /* inserted.FAB_ID = FAC_FABRICANTE_TIPO_COMPONENTE.FAB_ID */
          inserted.FAB_ID = FAC_FABRICANTE_TIPO_COMPONENTE.FAB_ID
    /*  */
    
    if @validcnt + @nullcnt != @numrows
    begin
      select @errno  = 30007,
             @errmsg = ''Cannot UPDATE FAC_TIPO_COMPONENTE because FAC_FABRICANTE_TIPO_COMPONENTE does not exist.''
      goto error
    end
  end

  /* ERwin Builtin Wed Apr 10 09:54:28 2002 */
  /* FAC_FAMILIA_TIPO_COMPONENTE R/15 FAC_TIPO_COMPONENTE ON CHILD UPDATE RESTRICT */
  if
    /* update(FTC_ID) */
    update(FTC_ID)
  begin
    select @nullcnt = 0
    select @validcnt = count(*)
      from inserted,FAC_FAMILIA_TIPO_COMPONENTE
        where
          /* inserted.FTC_ID = FAC_FAMILIA_TIPO_COMPONENTE.FTC_ID */
          inserted.FTC_ID = FAC_FAMILIA_TIPO_COMPONENTE.FTC_ID
    /*  */
    
    if @validcnt + @nullcnt != @numrows
    begin
      select @errno  = 30007,
             @errmsg = ''Cannot UPDATE FAC_TIPO_COMPONENTE because FAC_FAMILIA_TIPO_COMPONENTE does not exist.''
      goto error
    end
  end


  /* ERwin Builtin Wed Apr 10 09:54:28 2002 */
  return
error:
    raiserror @errno @errmsg
    rollback transaction
end
'
GO
/****** Object:  Trigger [tD_FAC_TIPO_COMPONENTE]    Script Date: 07/27/2018 09:30:45 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
IF NOT EXISTS (SELECT * FROM sys.triggers WHERE object_id = OBJECT_ID(N'[dbo].[tD_FAC_TIPO_COMPONENTE]'))
EXEC dbo.sp_executesql @statement = N'
create trigger [dbo].[tD_FAC_TIPO_COMPONENTE] on [dbo].[FAC_TIPO_COMPONENTE] for DELETE as
/* ERwin Builtin Wed Apr 10 09:54:28 2002 */
/* DELETE trigger on FAC_TIPO_COMPONENTE */
begin
  declare  @errno   int,
           @errmsg  varchar(255)
    /* ERwin Builtin Wed Apr 10 09:54:28 2002 */
    /* FAC_TIPO_COMPONENTE R/7 FAC_REL_CARACTERISTICAS_TIPO ON PARENT DELETE CASCADE */
    delete FAC_REL_CARACTERISTICAS_TIPO
      from FAC_REL_CARACTERISTICAS_TIPO,deleted
      where
        /*  FAC_REL_CARACTERISTICAS_TIPO.TPC_ID = deleted.TPC_ID */
        FAC_REL_CARACTERISTICAS_TIPO.TPC_ID = deleted.TPC_ID

    /* ERwin Builtin Wed Apr 10 09:54:28 2002 */
    /* FAC_TIPO_COMPONENTE R/3 FAC_COMPONENTES ON PARENT DELETE RESTRICT */
    if exists (
      select * from deleted,FAC_COMPONENTES
      where
        /*  FAC_COMPONENTES.TPC_ID = deleted.TPC_ID */
        FAC_COMPONENTES.TPC_ID = deleted.TPC_ID
    )
    begin
      select @errno  = 30001,
             @errmsg = ''Cannot DELETE FAC_TIPO_COMPONENTE because FAC_COMPONENTES exists.''
      goto error
    end


    /* ERwin Builtin Wed Apr 10 09:54:28 2002 */
    return
error:
    raiserror @errno @errmsg
    rollback transaction
end
'
GO
/****** Object:  Trigger [tD_FAC_LOCAIS_ESPECIFICOS_EQUIP]    Script Date: 07/27/2018 09:30:45 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
IF NOT EXISTS (SELECT * FROM sys.triggers WHERE object_id = OBJECT_ID(N'[dbo].[tD_FAC_LOCAIS_ESPECIFICOS_EQUIP]'))
EXEC dbo.sp_executesql @statement = N'
create trigger [dbo].[tD_FAC_LOCAIS_ESPECIFICOS_EQUIP] on [dbo].[FAC_LOCAIS_ESPECIFICOS_EQUIP] for DELETE as
/* ERwin Builtin Wed Apr 10 09:54:27 2002 */
/* DELETE trigger on FAC_LOCAIS_ESPECIFICOS_EQUIP */
begin
  declare  @errno   int,
           @errmsg  varchar(255)
    /* ERwin Builtin Wed Apr 10 09:54:27 2002 */
    /* FAC_LOCAIS_ESPECIFICOS_EQUIP R/11 FAC_COMPONENTES ON PARENT DELETE RESTRICT */
    if exists (
      select * from deleted,FAC_COMPONENTES
      where
        /*  FAC_COMPONENTES.LEE_ID = deleted.LEE_ID */
        FAC_COMPONENTES.LEE_ID = deleted.LEE_ID
    )
    begin
      select @errno  = 30001,
             @errmsg = ''Cannot DELETE FAC_LOCAIS_ESPECIFICOS_EQUIP because FAC_COMPONENTES exists.''
      goto error
    end


    /* ERwin Builtin Wed Apr 10 09:54:27 2002 */
    return
error:
    raiserror @errno @errmsg
    rollback transaction
end
'
GO
/****** Object:  Trigger [tI_FAC_COMPONENTES]    Script Date: 07/27/2018 09:30:45 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
IF NOT EXISTS (SELECT * FROM sys.triggers WHERE object_id = OBJECT_ID(N'[dbo].[tI_FAC_COMPONENTES]'))
EXEC dbo.sp_executesql @statement = N'
create trigger [dbo].[tI_FAC_COMPONENTES] on [dbo].[FAC_COMPONENTES] for INSERT as
/* ERwin Builtin Wed Apr 10 09:54:26 2002 */
/* INSERT trigger on FAC_COMPONENTES */
begin
  declare  @numrows int,
           @nullcnt int,
           @validcnt int,
           @errno   int,
           @errmsg  varchar(255)

  select @numrows = @@rowcount
  /* ERwin Builtin Wed Apr 10 09:54:26 2002 */
  /* FAC_LOCAIS_ESPECIFICOS_EQUIP R/11 FAC_COMPONENTES ON CHILD INSERT RESTRICT */
  if
    /* update(LEE_ID) */
    update(LEE_ID)
  begin
    select @nullcnt = 0
    select @validcnt = count(*)
      from inserted,FAC_LOCAIS_ESPECIFICOS_EQUIP
        where
          /* inserted.LEE_ID = FAC_LOCAIS_ESPECIFICOS_EQUIP.LEE_ID */
          inserted.LEE_ID = FAC_LOCAIS_ESPECIFICOS_EQUIP.LEE_ID
    /*  */
    
    if @validcnt + @nullcnt != @numrows
    begin
      select @errno  = 30002,
             @errmsg = ''Cannot INSERT FAC_COMPONENTES because FAC_LOCAIS_ESPECIFICOS_EQUIP does not exist.''
      goto error
    end
  end

  /* ERwin Builtin Wed Apr 10 09:54:26 2002 */
  /* FAC_TIPO_COMPONENTE R/3 FAC_COMPONENTES ON CHILD INSERT RESTRICT */
  if
    /* update(TPC_ID) */
    update(TPC_ID)
  begin
    select @nullcnt = 0
    select @validcnt = count(*)
      from inserted,FAC_TIPO_COMPONENTE
        where
          /* inserted.TPC_ID = FAC_TIPO_COMPONENTE.TPC_ID */
          inserted.TPC_ID = FAC_TIPO_COMPONENTE.TPC_ID
    /*  */
    
    if @validcnt + @nullcnt != @numrows
    begin
      select @errno  = 30002,
             @errmsg = ''Cannot INSERT FAC_COMPONENTES because FAC_TIPO_COMPONENTE does not exist.''
      goto error
    end
  end


  /* ERwin Builtin Wed Apr 10 09:54:26 2002 */
  return
error:
    raiserror @errno @errmsg
    rollback transaction
end
'
GO
/****** Object:  Trigger [tD_FAC_COMPONENTES]    Script Date: 07/27/2018 09:30:45 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
IF NOT EXISTS (SELECT * FROM sys.triggers WHERE object_id = OBJECT_ID(N'[dbo].[tD_FAC_COMPONENTES]'))
EXEC dbo.sp_executesql @statement = N'
create trigger [dbo].[tD_FAC_COMPONENTES] on [dbo].[FAC_COMPONENTES] for DELETE as
/* ERwin Builtin Wed Apr 10 09:54:26 2002 */
/* DELETE trigger on FAC_COMPONENTES */
begin
  declare  @errno   int,
           @errmsg  varchar(255)
    /* ERwin Builtin Wed Apr 10 09:54:26 2002 */
    /* FAC_COMPONENTES R/8 FAC_FACILIDADES ON PARENT DELETE RESTRICT */
    if exists (
      select * from deleted,FAC_FACILIDADES
      where
        /*  FAC_FACILIDADES.CPT_ID = deleted.CPT_ID */
        FAC_FACILIDADES.CPT_ID = deleted.CPT_ID
    )
    begin
      select @errno  = 30001,
             @errmsg = ''Cannot DELETE FAC_COMPONENTES because FAC_FACILIDADES exists.''
      goto error
    end


    /* ERwin Builtin Wed Apr 10 09:54:26 2002 */
    return
error:
    raiserror @errno @errmsg
    rollback transaction
end
'
GO
/****** Object:  Trigger [tU_FAC_COMPONENTES]    Script Date: 07/27/2018 09:30:45 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
IF NOT EXISTS (SELECT * FROM sys.triggers WHERE object_id = OBJECT_ID(N'[dbo].[tU_FAC_COMPONENTES]'))
EXEC dbo.sp_executesql @statement = N'
create trigger [dbo].[tU_FAC_COMPONENTES] on [dbo].[FAC_COMPONENTES] for UPDATE as
/* ERwin Builtin Wed Apr 10 09:54:27 2002 */
/* UPDATE trigger on FAC_COMPONENTES */
begin
  declare  @numrows int,
           @nullcnt int,
           @validcnt int,
           @insCPT_ID int,
           @errno   int,
           @errmsg  varchar(255)

  select @numrows = @@rowcount
  /* ERwin Builtin Wed Apr 10 09:54:26 2002 */
  /* FAC_COMPONENTES R/8 FAC_FACILIDADES ON PARENT UPDATE CASCADE */
  if
    /* update(CPT_ID) */
    update(CPT_ID)
  begin
    if @numrows = 1
    begin
      select @insCPT_ID = inserted.CPT_ID
        from inserted
      update FAC_FACILIDADES
      set
        /*  FAC_FACILIDADES.CPT_ID = @insCPT_ID */
        FAC_FACILIDADES.CPT_ID = @insCPT_ID
      from FAC_FACILIDADES,inserted,deleted
      where
        /*  FAC_FACILIDADES.CPT_ID = deleted.CPT_ID */
        FAC_FACILIDADES.CPT_ID = deleted.CPT_ID
    end
    else
    begin
      select @errno = 30006,
             @errmsg = ''Cannot cascade FAC_COMPONENTES UPDATE because more than one row has been affected.''
      goto error
    end
  end

  /* ERwin Builtin Wed Apr 10 09:54:27 2002 */
  /* FAC_LOCAIS_ESPECIFICOS_EQUIP R/11 FAC_COMPONENTES ON CHILD UPDATE RESTRICT */
  if
    /* update(LEE_ID) */
    update(LEE_ID)
  begin
    select @nullcnt = 0
    select @validcnt = count(*)
      from inserted,FAC_LOCAIS_ESPECIFICOS_EQUIP
        where
          /* inserted.LEE_ID = FAC_LOCAIS_ESPECIFICOS_EQUIP.LEE_ID */
          inserted.LEE_ID = FAC_LOCAIS_ESPECIFICOS_EQUIP.LEE_ID
    /*  */
    
    if @validcnt + @nullcnt != @numrows
    begin
      select @errno  = 30007,
             @errmsg = ''Cannot UPDATE FAC_COMPONENTES because FAC_LOCAIS_ESPECIFICOS_EQUIP does not exist.''
      goto error
    end
  end

  /* ERwin Builtin Wed Apr 10 09:54:27 2002 */
  /* FAC_TIPO_COMPONENTE R/3 FAC_COMPONENTES ON CHILD UPDATE RESTRICT */
  if
    /* update(TPC_ID) */
    update(TPC_ID)
  begin
    select @nullcnt = 0
    select @validcnt = count(*)
      from inserted,FAC_TIPO_COMPONENTE
        where
          /* inserted.TPC_ID = FAC_TIPO_COMPONENTE.TPC_ID */
          inserted.TPC_ID = FAC_TIPO_COMPONENTE.TPC_ID
    /*  */
    
    if @validcnt + @nullcnt != @numrows
    begin
      select @errno  = 30007,
             @errmsg = ''Cannot UPDATE FAC_COMPONENTES because FAC_TIPO_COMPONENTE does not exist.''
      goto error
    end
  end


  /* ERwin Builtin Wed Apr 10 09:54:27 2002 */
  return
error:
    raiserror @errno @errmsg
    rollback transaction
end
'
GO
/****** Object:  Trigger [tD_FAC_FABRICANTE_TIPO_COMPONENTE]    Script Date: 07/27/2018 09:30:45 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
IF NOT EXISTS (SELECT * FROM sys.triggers WHERE object_id = OBJECT_ID(N'[dbo].[tD_FAC_FABRICANTE_TIPO_COMPONENTE]'))
EXEC dbo.sp_executesql @statement = N'
create trigger [dbo].[tD_FAC_FABRICANTE_TIPO_COMPONENTE] on [dbo].[FAC_FABRICANTE_TIPO_COMPONENTE] for DELETE as
/* ERwin Builtin Wed Apr 10 09:54:27 2002 */
/* DELETE trigger on FAC_FABRICANTE_TIPO_COMPONENTE */
begin
  declare  @errno   int,
           @errmsg  varchar(255)
    /* ERwin Builtin Wed Apr 10 09:54:27 2002 */
    /* FAC_FABRICANTE_TIPO_COMPONENTE R/16 FAC_TIPO_COMPONENTE ON PARENT DELETE RESTRICT */
    if exists (
      select * from deleted,FAC_TIPO_COMPONENTE
      where
        /*  FAC_TIPO_COMPONENTE.FAB_ID = deleted.FAB_ID */
        FAC_TIPO_COMPONENTE.FAB_ID = deleted.FAB_ID
    )
    begin
      select @errno  = 30001,
             @errmsg = ''Cannot DELETE FAC_FABRICANTE_TIPO_COMPONENTE because FAC_TIPO_COMPONENTE exists.''
      goto error
    end


    /* ERwin Builtin Wed Apr 10 09:54:27 2002 */
    return
error:
    raiserror @errno @errmsg
    rollback transaction
end
'
GO
/****** Object:  Trigger [tU_FAC_FABRICANTE_TIPO_COMPONENTE]    Script Date: 07/27/2018 09:30:45 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
IF NOT EXISTS (SELECT * FROM sys.triggers WHERE object_id = OBJECT_ID(N'[dbo].[tU_FAC_FABRICANTE_TIPO_COMPONENTE]'))
EXEC dbo.sp_executesql @statement = N'
create trigger [dbo].[tU_FAC_FABRICANTE_TIPO_COMPONENTE] on [dbo].[FAC_FABRICANTE_TIPO_COMPONENTE] for UPDATE as
/* ERwin Builtin Wed Apr 10 09:54:27 2002 */
/* UPDATE trigger on FAC_FABRICANTE_TIPO_COMPONENTE */
begin
  declare  @numrows int,
           @nullcnt int,
           @validcnt int,
           @insFAB_ID int,
           @errno   int,
           @errmsg  varchar(255)

  select @numrows = @@rowcount
  /* ERwin Builtin Wed Apr 10 09:54:27 2002 */
  /* FAC_FABRICANTE_TIPO_COMPONENTE R/16 FAC_TIPO_COMPONENTE ON PARENT UPDATE CASCADE */
  if
    /* update(FAB_ID) */
    update(FAB_ID)
  begin
    if @numrows = 1
    begin
      select @insFAB_ID = inserted.FAB_ID
        from inserted
      update FAC_TIPO_COMPONENTE
      set
        /*  FAC_TIPO_COMPONENTE.FAB_ID = @insFAB_ID */
        FAC_TIPO_COMPONENTE.FAB_ID = @insFAB_ID
      from FAC_TIPO_COMPONENTE,inserted,deleted
      where
        /*  FAC_TIPO_COMPONENTE.FAB_ID = deleted.FAB_ID */
        FAC_TIPO_COMPONENTE.FAB_ID = deleted.FAB_ID
    end
    else
    begin
      select @errno = 30006,
             @errmsg = ''Cannot cascade FAC_FABRICANTE_TIPO_COMPONENTE UPDATE because more than one row has been affected.''
      goto error
    end
  end


  /* ERwin Builtin Wed Apr 10 09:54:27 2002 */
  return
error:
    raiserror @errno @errmsg
    rollback transaction
end
'
GO
/****** Object:  Trigger [tI_FAC_TIPO_COMPONENTE]    Script Date: 07/27/2018 09:30:45 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
IF NOT EXISTS (SELECT * FROM sys.triggers WHERE object_id = OBJECT_ID(N'[dbo].[tI_FAC_TIPO_COMPONENTE]'))
EXEC dbo.sp_executesql @statement = N'
create trigger [dbo].[tI_FAC_TIPO_COMPONENTE] on [dbo].[FAC_TIPO_COMPONENTE] for INSERT as
/* ERwin Builtin Wed Apr 10 09:54:28 2002 */
/* INSERT trigger on FAC_TIPO_COMPONENTE */
begin
  declare  @numrows int,
           @nullcnt int,
           @validcnt int,
           @errno   int,
           @errmsg  varchar(255)

  select @numrows = @@rowcount
  /* ERwin Builtin Wed Apr 10 09:54:28 2002 */
  /* FAC_FABRICANTE_TIPO_COMPONENTE R/16 FAC_TIPO_COMPONENTE ON CHILD INSERT RESTRICT */
  if
    /* update(FAB_ID) */
    update(FAB_ID)
  begin
    select @nullcnt = 0
    select @validcnt = count(*)
      from inserted,FAC_FABRICANTE_TIPO_COMPONENTE
        where
          /* inserted.FAB_ID = FAC_FABRICANTE_TIPO_COMPONENTE.FAB_ID */
          inserted.FAB_ID = FAC_FABRICANTE_TIPO_COMPONENTE.FAB_ID
    /*  */
    
    if @validcnt + @nullcnt != @numrows
    begin
      select @errno  = 30002,
             @errmsg = ''Cannot INSERT FAC_TIPO_COMPONENTE because FAC_FABRICANTE_TIPO_COMPONENTE does not exist.''
      goto error
    end
  end

  /* ERwin Builtin Wed Apr 10 09:54:28 2002 */
  /* FAC_FAMILIA_TIPO_COMPONENTE R/15 FAC_TIPO_COMPONENTE ON CHILD INSERT RESTRICT */
  if
    /* update(FTC_ID) */
    update(FTC_ID)
  begin
    select @nullcnt = 0
    select @validcnt = count(*)
      from inserted,FAC_FAMILIA_TIPO_COMPONENTE
        where
          /* inserted.FTC_ID = FAC_FAMILIA_TIPO_COMPONENTE.FTC_ID */
          inserted.FTC_ID = FAC_FAMILIA_TIPO_COMPONENTE.FTC_ID
    /*  */
    
    if @validcnt + @nullcnt != @numrows
    begin
      select @errno  = 30002,
             @errmsg = ''Cannot INSERT FAC_TIPO_COMPONENTE because FAC_FAMILIA_TIPO_COMPONENTE does not exist.''
      goto error
    end
  end


  /* ERwin Builtin Wed Apr 10 09:54:28 2002 */
  return
error:
    raiserror @errno @errmsg
    rollback transaction
end
'
GO
/****** Object:  Trigger [tU_FAC_REL_CARACTERISTICAS_FACILIDADES]    Script Date: 07/27/2018 09:30:45 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.triggers WHERE object_id = OBJECT_ID(N'[dbo].[tU_FAC_REL_CARACTERISTICAS_FACILIDADES]'))
EXEC dbo.sp_executesql @statement = N'create trigger [dbo].[tU_FAC_REL_CARACTERISTICAS_FACILIDADES] on [dbo].[FAC_REL_CARACTERISTICAS_FACILIDADES] for UPDATE as
/* ERwin Builtin Wed Apr 10 09:54:27 2002 */
/* UPDATE trigger on FAC_REL_CARACTERISTICAS_FACILIDADES */
begin
  declare  @numrows int,
           @nullcnt int,
           @validcnt int,
           @insCAR_ID int, 
           @insTPC_ID int, 
           @insFAC_ID int,
           @errno   int,
           @errmsg  varchar(255)

  select @numrows = @@rowcount
  /* ERwin Builtin Wed Apr 10 09:54:27 2002 */
  /* FAC_REL_CARACTERISTICAS_TIPO R/14 FAC_REL_CARACTERISTICAS_FACILIDADES ON CHILD UPDATE RESTRICT */
  if
    /* update(CAR_ID) or
       update(TPC_ID) */
    update(CAR_ID) or
    update(TPC_ID)
  begin
    select @nullcnt = 0
    select @validcnt = count(*)
      from inserted,FAC_REL_CARACTERISTICAS_TIPO
        where
          /* inserted.CAR_ID = FAC_REL_CARACTERISTICAS_TIPO.CAR_ID and
             inserted.TPC_ID = FAC_REL_CARACTERISTICAS_TIPO.TPC_ID */
          inserted.CAR_ID = FAC_REL_CARACTERISTICAS_TIPO.CAR_ID and
          inserted.TPC_ID = FAC_REL_CARACTERISTICAS_TIPO.TPC_ID
    /*  */
    
    if @validcnt + @nullcnt != @numrows
    begin
      select @errno  = 30007,
             @errmsg = ''Cannot UPDATE FAC_REL_CARACTERISTICAS_FACILIDADES because FAC_REL_CARACTERISTICAS_TIPO does not exist.''
      goto error
    end
  end

  /* ERwin Builtin Wed Apr 10 09:54:27 2002 */
  /* FAC_FACILIDADES R/13 FAC_REL_CARACTERISTICAS_FACILIDADES ON CHILD UPDATE RESTRICT */
  if
    /* update(FAC_ID) */
    update(FAC_ID)
  begin
    select @nullcnt = 0
    select @validcnt = count(*)
      from inserted,FAC_FACILIDADES
        where
          /* inserted.FAC_ID = FAC_FACILIDADES.FAC_ID */
          inserted.FAC_ID = FAC_FACILIDADES.FAC_ID
    /*  */
    
    if @validcnt + @nullcnt != @numrows
    begin
      select @errno  = 30007,
             @errmsg = ''Cannot UPDATE FAC_REL_CARACTERISTICAS_FACILIDADES because FAC_FACILIDADES does not exist.''
      goto error
    end
  end


  /* ERwin Builtin Wed Apr 10 09:54:27 2002 */
  return
error:
    raiserror @errno @errmsg
    rollback transaction
end
'
GO
/****** Object:  Trigger [tI_FAC_REL_CARACTERISTICAS_FACILIDADES]    Script Date: 07/27/2018 09:30:45 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.triggers WHERE object_id = OBJECT_ID(N'[dbo].[tI_FAC_REL_CARACTERISTICAS_FACILIDADES]'))
EXEC dbo.sp_executesql @statement = N'create trigger [dbo].[tI_FAC_REL_CARACTERISTICAS_FACILIDADES] on [dbo].[FAC_REL_CARACTERISTICAS_FACILIDADES] for INSERT as
/* ERwin Builtin Wed Apr 10 09:54:27 2002 */
/* INSERT trigger on FAC_REL_CARACTERISTICAS_FACILIDADES */
begin
  declare  @numrows int,
           @nullcnt int,
           @validcnt int,
           @errno   int,
           @errmsg  varchar(255)

  select @numrows = @@rowcount
  /* ERwin Builtin Wed Apr 10 09:54:27 2002 */
  /* FAC_REL_CARACTERISTICAS_TIPO R/14 FAC_REL_CARACTERISTICAS_FACILIDADES ON CHILD INSERT RESTRICT */
  if
    /* update(CAR_ID) or
       update(TPC_ID) */
    update(CAR_ID) or
    update(TPC_ID)
  begin
    select @nullcnt = 0
    select @validcnt = count(*)
      from inserted,FAC_REL_CARACTERISTICAS_TIPO
        where
          /* inserted.CAR_ID = FAC_REL_CARACTERISTICAS_TIPO.CAR_ID and
             inserted.TPC_ID = FAC_REL_CARACTERISTICAS_TIPO.TPC_ID */
          inserted.CAR_ID = FAC_REL_CARACTERISTICAS_TIPO.CAR_ID and
          inserted.TPC_ID = FAC_REL_CARACTERISTICAS_TIPO.TPC_ID
    /*  */
    
    if @validcnt + @nullcnt != @numrows
    begin
      select @errno  = 30002,
             @errmsg = ''Cannot INSERT FAC_REL_CARACTERISTICAS_FACILIDADES because FAC_REL_CARACTERISTICAS_TIPO does not exist.''
      goto error
    end
  end

  /* ERwin Builtin Wed Apr 10 09:54:27 2002 */
  /* FAC_FACILIDADES R/13 FAC_REL_CARACTERISTICAS_FACILIDADES ON CHILD INSERT RESTRICT */
  if
    /* update(FAC_ID) */
    update(FAC_ID)
  begin
    select @nullcnt = 0
    select @validcnt = count(*)
      from inserted,FAC_FACILIDADES
        where
          /* inserted.FAC_ID = FAC_FACILIDADES.FAC_ID */
          inserted.FAC_ID = FAC_FACILIDADES.FAC_ID
    /*  */
    
    if @validcnt + @nullcnt != @numrows
    begin
      select @errno  = 30002,
             @errmsg = ''Cannot INSERT FAC_REL_CARACTERISTICAS_FACILIDADES because FAC_FACILIDADES does not exist.''
      goto error
    end
  end


  /* ERwin Builtin Wed Apr 10 09:54:27 2002 */
  return
error:
    raiserror @errno @errmsg
    rollback transaction
end
'
GO
/****** Object:  Trigger [tD_FAC_FACILIDADES]    Script Date: 07/27/2018 09:30:45 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
IF NOT EXISTS (SELECT * FROM sys.triggers WHERE object_id = OBJECT_ID(N'[dbo].[tD_FAC_FACILIDADES]'))
EXEC dbo.sp_executesql @statement = N'
create trigger [dbo].[tD_FAC_FACILIDADES] on [dbo].[FAC_FACILIDADES] for DELETE as
/* ERwin Builtin Wed Apr 10 09:54:27 2002 */
/* DELETE trigger on FAC_FACILIDADES */
begin
  declare  @errno   int,
           @errmsg  varchar(255)
    /* ERwin Builtin Wed Apr 10 09:54:27 2002 */
    /* FAC_FACILIDADES R/13 FAC_REL_CARACTERISTICAS_FACILIDADES ON PARENT DELETE CASCADE */
    delete FAC_REL_CARACTERISTICAS_FACILIDADES
      from FAC_REL_CARACTERISTICAS_FACILIDADES,deleted
      where
        /*  FAC_REL_CARACTERISTICAS_FACILIDADES.FAC_ID = deleted.FAC_ID */
        FAC_REL_CARACTERISTICAS_FACILIDADES.FAC_ID = deleted.FAC_ID


    /* ERwin Builtin Wed Apr 10 09:54:27 2002 */
    return
error:
    raiserror @errno @errmsg
    rollback transaction
end
'
GO
/****** Object:  Trigger [tD_FAC_FAMILIA_TIPO_COMPONENTE]    Script Date: 07/27/2018 09:30:45 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
IF NOT EXISTS (SELECT * FROM sys.triggers WHERE object_id = OBJECT_ID(N'[dbo].[tD_FAC_FAMILIA_TIPO_COMPONENTE]'))
EXEC dbo.sp_executesql @statement = N'
create trigger [dbo].[tD_FAC_FAMILIA_TIPO_COMPONENTE] on [dbo].[FAC_FAMILIA_TIPO_COMPONENTE] for DELETE as
/* ERwin Builtin Wed Apr 10 09:54:27 2002 */
/* DELETE trigger on FAC_FAMILIA_TIPO_COMPONENTE */
begin
  declare  @errno   int,
           @errmsg  varchar(255)
    /* ERwin Builtin Wed Apr 10 09:54:27 2002 */
    /* FAC_FAMILIA_TIPO_COMPONENTE R/15 FAC_TIPO_COMPONENTE ON PARENT DELETE RESTRICT */
    if exists (
      select * from deleted,FAC_TIPO_COMPONENTE
      where
        /*  FAC_TIPO_COMPONENTE.FTC_ID = deleted.FTC_ID */
        FAC_TIPO_COMPONENTE.FTC_ID = deleted.FTC_ID
    )
    begin
      select @errno  = 30001,
             @errmsg = ''Cannot DELETE FAC_FAMILIA_TIPO_COMPONENTE because FAC_TIPO_COMPONENTE exists.''
      goto error
    end


    /* ERwin Builtin Wed Apr 10 09:54:27 2002 */
    return
error:
    raiserror @errno @errmsg
    rollback transaction
end
'
GO
/****** Object:  Trigger [tU_FAC_FAMILIA_TIPO_COMPONENTE]    Script Date: 07/27/2018 09:30:45 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
IF NOT EXISTS (SELECT * FROM sys.triggers WHERE object_id = OBJECT_ID(N'[dbo].[tU_FAC_FAMILIA_TIPO_COMPONENTE]'))
EXEC dbo.sp_executesql @statement = N'
create trigger [dbo].[tU_FAC_FAMILIA_TIPO_COMPONENTE] on [dbo].[FAC_FAMILIA_TIPO_COMPONENTE] for UPDATE as
/* ERwin Builtin Wed Apr 10 09:54:27 2002 */
/* UPDATE trigger on FAC_FAMILIA_TIPO_COMPONENTE */
begin
  declare  @numrows int,
           @nullcnt int,
           @validcnt int,
           @insFTC_ID int,
           @errno   int,
           @errmsg  varchar(255)

  select @numrows = @@rowcount
  /* ERwin Builtin Wed Apr 10 09:54:27 2002 */
  /* FAC_FAMILIA_TIPO_COMPONENTE R/15 FAC_TIPO_COMPONENTE ON PARENT UPDATE CASCADE */
  if
    /* update(FTC_ID) */
    update(FTC_ID)
  begin
    if @numrows = 1
    begin
      select @insFTC_ID = inserted.FTC_ID
        from inserted
      update FAC_TIPO_COMPONENTE
      set
        /*  FAC_TIPO_COMPONENTE.FTC_ID = @insFTC_ID */
        FAC_TIPO_COMPONENTE.FTC_ID = @insFTC_ID
      from FAC_TIPO_COMPONENTE,inserted,deleted
      where
        /*  FAC_TIPO_COMPONENTE.FTC_ID = deleted.FTC_ID */
        FAC_TIPO_COMPONENTE.FTC_ID = deleted.FTC_ID
    end
    else
    begin
      select @errno = 30006,
             @errmsg = ''Cannot cascade FAC_FAMILIA_TIPO_COMPONENTE UPDATE because more than one row has been affected.''
      goto error
    end
  end


  /* ERwin Builtin Wed Apr 10 09:54:27 2002 */
  return
error:
    raiserror @errno @errmsg
    rollback transaction
end
'
GO
/****** Object:  Trigger [tD_FAC_REL_CARACTERISTICAS_TIPO]    Script Date: 07/27/2018 09:30:45 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
IF NOT EXISTS (SELECT * FROM sys.triggers WHERE object_id = OBJECT_ID(N'[dbo].[tD_FAC_REL_CARACTERISTICAS_TIPO]'))
EXEC dbo.sp_executesql @statement = N'
create trigger [dbo].[tD_FAC_REL_CARACTERISTICAS_TIPO] on [dbo].[FAC_REL_CARACTERISTICAS_TIPO] for DELETE as
/* ERwin Builtin Wed Apr 10 09:54:27 2002 */
/* DELETE trigger on FAC_REL_CARACTERISTICAS_TIPO */
begin
  declare  @errno   int,
           @errmsg  varchar(255)
    /* ERwin Builtin Wed Apr 10 09:54:27 2002 */
    /* FAC_REL_CARACTERISTICAS_TIPO R/14 FAC_REL_CARACTERISTICAS_FACILIDADES ON PARENT DELETE RESTRICT */
    if exists (
      select * from deleted,FAC_REL_CARACTERISTICAS_FACILIDADES
      where
        /*  FAC_REL_CARACTERISTICAS_FACILIDADES.CAR_ID = deleted.CAR_ID and
            FAC_REL_CARACTERISTICAS_FACILIDADES.TPC_ID = deleted.TPC_ID */
        FAC_REL_CARACTERISTICAS_FACILIDADES.CAR_ID = deleted.CAR_ID and
        FAC_REL_CARACTERISTICAS_FACILIDADES.TPC_ID = deleted.TPC_ID
    )
    begin
      select @errno  = 30001,
             @errmsg = ''Cannot DELETE FAC_REL_CARACTERISTICAS_TIPO because FAC_REL_CARACTERISTICAS_FACILIDADES exists.''
      goto error
    end


    /* ERwin Builtin Wed Apr 10 09:54:27 2002 */
    return
error:
    raiserror @errno @errmsg
    rollback transaction
end
'
GO
/****** Object:  Trigger [tr_D_SCE_Movimentacao]    Script Date: 07/27/2018 09:30:45 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
IF NOT EXISTS (SELECT * FROM sys.triggers WHERE object_id = OBJECT_ID(N'[dbo].[tr_D_SCE_Movimentacao]'))
EXEC dbo.sp_executesql @statement = N'CREATE TRIGGER [dbo].[tr_D_SCE_Movimentacao] ON [dbo].[SCE_Movimentacao] 
FOR DELETE 
AS
BEGIN
	/***
		Verifica o status do equipamento cuja movimentacao esta sendo excluida.
		Caso seja a ultima movimentacao, o status do equipamento passa a ser o da
		movimentacao anterior

		Gilberto Almeida - COPPETEC
		Data da Criacao: 12/12/2003	Ultima Alteracao:
	***/
	DECLARE @mov_id INT, @eq_id INT, @no_id INT
	DECLARE @tipo INT, @status_eq INT, @mov_data DATETIME, @ultima_mov DATETIME

	SELECT @mov_id = MOV_ID, @eq_id = EQ_ID, @mov_data = MOV_DATA FROM Deleted

	SELECT TOP 1 @ultima_mov = MOV_DATA FROM SCE_Movimentacao m 
		WHERE m.EQ_ID = @eq_id
		ORDER BY m.MOV_DATA DESC

	-- é a ultima movimentacao, entao tenho que atualizar o equipamento para o status
	-- da movimentacao anterior
	IF @mov_data >= @ultima_mov BEGIN
		-- pego a natureza da movimentacao anterior
		SELECT TOP 1 @no_id = NO_ID FROM SCE_Movimentacao
			WHERE EQ_ID = @eq_id AND MOV_ID <> @mov_id
			ORDER BY MOV_DATA DESC

		-- nao tem mais movimento do item, entao passo para cadastrado
		IF @no_id IS NULL BEGIN
			SET @status_eq = 0
		END
		ELSE BEGIN
			-- pego o tipo da natureza de operacao
			SELECT @tipo = NO_TIPO FROM SCE_Natureza_Operacao WHERE NO_ID = @no_id

			-- maquina de estados - tipo de movimentacao / estado do equipamento
			IF @tipo = 1 OR @tipo = 2
				SET @status_eq = 1 -- em estoque
			ELSE IF @tipo = 3
				SET @status_eq = 3 -- expedicao
			ELSE
				SET @status_eq = 2 -- em uso
		END

		IF @status_eq = 3  BEGIN -- se for expedicao entao limpo o campo de LOCALIZACAO do equipamento
			UPDATE SCE_Equipamentos SET STATUS = @status_eq, EQ_LOCALIZACAO = NULL WHERE EQ_ID = @eq_id
			IF @@ERROR <> 0 BEGIN
				ROLLBACK TRANSACTION
				RAISERROR( ''Não foi possível atualizar o status do equipamento.'', 16, 1 )
			END
		END
		ELSE BEGIN
			UPDATE SCE_Equipamentos SET STATUS = @status_eq WHERE EQ_ID = @eq_id
			IF @@ERROR <> 0 BEGIN
				ROLLBACK TRANSACTION
				RAISERROR( ''Não foi possível atualizar o status do equipamento.'', 16, 1 )
			END
		END
	END
END
'
GO
/****** Object:  Trigger [TRG_IU_SCE_MOVIMENTACAO_TIPO]    Script Date: 07/27/2018 09:30:45 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.triggers WHERE object_id = OBJECT_ID(N'[dbo].[TRG_IU_SCE_MOVIMENTACAO_TIPO]'))
EXEC dbo.sp_executesql @statement = N'CREATE TRIGGER [dbo].[TRG_IU_SCE_MOVIMENTACAO_TIPO] ON [dbo].[SCE_Movimentacao]
FOR INSERT,UPDATE
AS
BEGIN
	--
	-- Ao se atualizar o "TIPO" de movimentação (1 - entrada, 2 - Saída do LOG,
	-- equipamentos devem ser atualizados para status correspondentes
	--
	IF UPDATE( NO_ID )
	BEGIN
		DECLARE @tipo INT, @status_eq INT, @mov_id INT, @eq_id INT
		DECLARE @mov_data DATETIME, @ultima_mov DATETIME

		-- data da movimentacao
		SELECT @mov_data = MOV_DATA, @mov_id = MOV_ID, @eq_id = EQ_ID FROM Inserted

		-- pego a data da ultima movimentacao do item
		SELECT @ultima_mov = MAX( m.MOV_DATA ) FROM SCE_Movimentacao m 
			WHERE m.EQ_ID = @eq_id AND m.MOV_ID <> @mov_id

		-- Se esta movimentacao for a de maior data (ultima) entao atualizo
		-- o STATUS do equipamento movimentado, caso contrário o equipamento continua
		-- com o STATUS da ultima movimentacao no banco.
		IF (@mov_data >= @ultima_mov) OR (@ultima_mov IS NULL) BEGIN
			-- pego o tipo de movimento desta ultima movimentacao
			SELECT @tipo = n.NO_TIPO FROM Inserted m 
				INNER JOIN SCE_Natureza_Operacao n ON m.NO_ID = n.NO_ID

			-- maquina de estados - tipo de movimentacao / estado do equipamento
			IF @tipo = 1 OR @tipo = 2
				SET @status_eq = 1 -- em estoque
			ELSE IF @tipo = 3
				SET @status_eq = 3 -- expedicao
			ELSE
				SET @status_eq = 2 -- em uso

			IF (@status_eq = 2) OR (@status_eq = 3)  -- se for expedicao e saída p/ uso no Lab. entao limpo o campo de LOCALIZACAO do equipamento
			BEGIN
				UPDATE SCE_Equipamentos SET STATUS = @status_eq, EQ_LOCALIZACAO = NULL
					FROM SCE_EQUIPAMENTOS, INSERTED
					WHERE SCE_EQUIPAMENTOS.EQ_ID = INSERTED.EQ_ID
				IF @@ERROR <> 0 BEGIN
					ROLLBACK TRANSACTION
					RAISERROR( ''Não foi possível atualizar o status do equipamento.'', 16, 1 )
				END
			END
			ELSE BEGIN
				UPDATE SCE_Equipamentos SET STATUS = @status_eq
					FROM SCE_EQUIPAMENTOS, INSERTED
					WHERE SCE_EQUIPAMENTOS.EQ_ID = INSERTED.EQ_ID
				IF @@ERROR <> 0 BEGIN
					ROLLBACK TRANSACTION
					RAISERROR( ''Não foi possível atualizar o status do equipamento.'', 16, 1 )
				END
			END	
		END
	END
END
'
GO
/****** Object:  Trigger [tr_Reserva_ambientes_Reserva_Equipamentos]    Script Date: 07/27/2018 09:30:45 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.triggers WHERE object_id = OBJECT_ID(N'[dbo].[tr_Reserva_ambientes_Reserva_Equipamentos]'))
EXEC dbo.sp_executesql @statement = N'CREATE TRIGGER [dbo].[tr_Reserva_ambientes_Reserva_Equipamentos]
   ON [dbo].[Reserva_ambientes] AFTER INSERT, UPDATE
AS 
BEGIN
	SET NOCOUNT ON

	DECLARE @AMB_RES INT, @AMB_AS INT

	/* Verifica se existe apenas 1 ambiente tanto na reserva de itens quanto pelo agendamento se for apenas 1 ambiente entao muda automaticamente */
	SELECT @AMB_RES = COUNT(*)
	FROM SCE_reserva_equipamentos R INNER JOIN Inserted I ON R.AG_NUMERO = I.RAM_AS
	GROUP BY R.AMB_ID
	
	SELECT @AMB_AS = COUNT(*)
	FROM Reserva_ambientes R INNER JOIN Inserted I ON R.RAM_AS = I.RAM_AS
	GROUP BY R.AMB_ID

	IF (@AMB_RES = @AMB_AS) AND (@AMB_AS = 1)
	BEGIN
		UPDATE SCE_reserva_equipamentos
		SET AMB_ID = I.AMB_ID
		FROM SCE_reserva_equipamentos R 
			INNER JOIN Inserted I ON R.AG_NUMERO = I.RAM_AS
		WHERE R.AMB_ID <> I.AMB_ID
	END
END
'
GO
/****** Object:  Trigger [tU_FAC_LOCAIS_ESPECIFICOS_EQUIP]    Script Date: 07/27/2018 09:30:45 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
IF NOT EXISTS (SELECT * FROM sys.triggers WHERE object_id = OBJECT_ID(N'[dbo].[tU_FAC_LOCAIS_ESPECIFICOS_EQUIP]'))
EXEC dbo.sp_executesql @statement = N'
create trigger [dbo].[tU_FAC_LOCAIS_ESPECIFICOS_EQUIP] on [dbo].[FAC_LOCAIS_ESPECIFICOS_EQUIP] for UPDATE as
/* ERwin Builtin Wed Apr 10 09:54:27 2002 */
/* UPDATE trigger on FAC_LOCAIS_ESPECIFICOS_EQUIP */
begin
  declare  @numrows int,
           @nullcnt int,
           @validcnt int,
           @insLEE_ID int,
           @errno   int,
           @errmsg  varchar(255)

  select @numrows = @@rowcount
  /* ERwin Builtin Wed Apr 10 09:54:27 2002 */
  /* FAC_LOCAIS_ESPECIFICOS_EQUIP R/11 FAC_COMPONENTES ON PARENT UPDATE CASCADE */
  if
    /* update(LEE_ID) */
    update(LEE_ID)
  begin
    if @numrows = 1
    begin
      select @insLEE_ID = inserted.LEE_ID
        from inserted
      update FAC_COMPONENTES
      set
        /*  FAC_COMPONENTES.LEE_ID = @insLEE_ID */
        FAC_COMPONENTES.LEE_ID = @insLEE_ID
      from FAC_COMPONENTES,inserted,deleted
      where
        /*  FAC_COMPONENTES.LEE_ID = deleted.LEE_ID */
        FAC_COMPONENTES.LEE_ID = deleted.LEE_ID
    end
    else
    begin
      select @errno = 30006,
             @errmsg = ''Cannot cascade FAC_LOCAIS_ESPECIFICOS_EQUIP UPDATE because more than one row has been affected.''
      goto error
    end
  end

  /* ERwin Builtin Wed Apr 10 09:54:27 2002 */
  /* FAC_LOCAIS_GENERICOS_EQUIP R/10 FAC_LOCAIS_ESPECIFICOS_EQUIP ON CHILD UPDATE RESTRICT */
  if
    /* update(LGE_ID) */
    update(LGE_ID)
  begin
    select @nullcnt = 0
    select @validcnt = count(*)
      from inserted,FAC_LOCAIS_GENERICOS_EQUIP
        where
          /* inserted.LGE_ID = FAC_LOCAIS_GENERICOS_EQUIP.LGE_ID */
          inserted.LGE_ID = FAC_LOCAIS_GENERICOS_EQUIP.LGE_ID
    /*  */
    
    if @validcnt + @nullcnt != @numrows
    begin
      select @errno  = 30007,
             @errmsg = ''Cannot UPDATE FAC_LOCAIS_ESPECIFICOS_EQUIP because FAC_LOCAIS_GENERICOS_EQUIP does not exist.''
      goto error
    end
  end


  /* ERwin Builtin Wed Apr 10 09:54:27 2002 */
  return
error:
    raiserror @errno @errmsg
    rollback transaction
end
'
GO
/****** Object:  Trigger [tD_FAC_LOCAIS_GENERICOS_EQUIP]    Script Date: 07/27/2018 09:30:45 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
IF NOT EXISTS (SELECT * FROM sys.triggers WHERE object_id = OBJECT_ID(N'[dbo].[tD_FAC_LOCAIS_GENERICOS_EQUIP]'))
EXEC dbo.sp_executesql @statement = N'
create trigger [dbo].[tD_FAC_LOCAIS_GENERICOS_EQUIP] on [dbo].[FAC_LOCAIS_GENERICOS_EQUIP] for DELETE as
/* ERwin Builtin Wed Apr 10 09:54:27 2002 */
/* DELETE trigger on FAC_LOCAIS_GENERICOS_EQUIP */
begin
  declare  @errno   int,
           @errmsg  varchar(255)
    /* ERwin Builtin Wed Apr 10 09:54:27 2002 */
    /* FAC_LOCAIS_GENERICOS_EQUIP R/10 FAC_LOCAIS_ESPECIFICOS_EQUIP ON PARENT DELETE CASCADE */
    delete FAC_LOCAIS_ESPECIFICOS_EQUIP
      from FAC_LOCAIS_ESPECIFICOS_EQUIP,deleted
      where
        /*  FAC_LOCAIS_ESPECIFICOS_EQUIP.LGE_ID = deleted.LGE_ID */
        FAC_LOCAIS_ESPECIFICOS_EQUIP.LGE_ID = deleted.LGE_ID


    /* ERwin Builtin Wed Apr 10 09:54:27 2002 */
    return
error:
    raiserror @errno @errmsg
    rollback transaction
end
'
GO
/****** Object:  Trigger [tU_FAC_LOCAIS_GENERICOS_EQUIP]    Script Date: 07/27/2018 09:30:45 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
IF NOT EXISTS (SELECT * FROM sys.triggers WHERE object_id = OBJECT_ID(N'[dbo].[tU_FAC_LOCAIS_GENERICOS_EQUIP]'))
EXEC dbo.sp_executesql @statement = N'
create trigger [dbo].[tU_FAC_LOCAIS_GENERICOS_EQUIP] on [dbo].[FAC_LOCAIS_GENERICOS_EQUIP] for UPDATE as
/* ERwin Builtin Wed Apr 10 09:54:27 2002 */
/* UPDATE trigger on FAC_LOCAIS_GENERICOS_EQUIP */
begin
  declare  @numrows int,
           @nullcnt int,
           @validcnt int,
           @insLGE_ID int,
           @errno   int,
           @errmsg  varchar(255)

  select @numrows = @@rowcount
  /* ERwin Builtin Wed Apr 10 09:54:27 2002 */
  /* FAC_LOCAIS_GENERICOS_EQUIP R/10 FAC_LOCAIS_ESPECIFICOS_EQUIP ON PARENT UPDATE CASCADE */
  if
    /* update(LGE_ID) */
    update(LGE_ID)
  begin
    if @numrows = 1
    begin
      select @insLGE_ID = inserted.LGE_ID
        from inserted
      update FAC_LOCAIS_ESPECIFICOS_EQUIP
      set
        /*  FAC_LOCAIS_ESPECIFICOS_EQUIP.LGE_ID = @insLGE_ID */
        FAC_LOCAIS_ESPECIFICOS_EQUIP.LGE_ID = @insLGE_ID
      from FAC_LOCAIS_ESPECIFICOS_EQUIP,inserted,deleted
      where
        /*  FAC_LOCAIS_ESPECIFICOS_EQUIP.LGE_ID = deleted.LGE_ID */
        FAC_LOCAIS_ESPECIFICOS_EQUIP.LGE_ID = deleted.LGE_ID
    end
    else
    begin
      select @errno = 30006,
             @errmsg = ''Cannot cascade FAC_LOCAIS_GENERICOS_EQUIP UPDATE because more than one row has been affected.''
      goto error
    end
  end


  /* ERwin Builtin Wed Apr 10 09:54:27 2002 */
  return
error:
    raiserror @errno @errmsg
    rollback transaction
end
'
GO
/****** Object:  Trigger [tI_FAC_LOCAIS_ESPECIFICOS_EQUIP]    Script Date: 07/27/2018 09:30:45 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
IF NOT EXISTS (SELECT * FROM sys.triggers WHERE object_id = OBJECT_ID(N'[dbo].[tI_FAC_LOCAIS_ESPECIFICOS_EQUIP]'))
EXEC dbo.sp_executesql @statement = N'
create trigger [dbo].[tI_FAC_LOCAIS_ESPECIFICOS_EQUIP] on [dbo].[FAC_LOCAIS_ESPECIFICOS_EQUIP] for INSERT as
/* ERwin Builtin Wed Apr 10 09:54:27 2002 */
/* INSERT trigger on FAC_LOCAIS_ESPECIFICOS_EQUIP */
begin
  declare  @numrows int,
           @nullcnt int,
           @validcnt int,
           @errno   int,
           @errmsg  varchar(255)

  select @numrows = @@rowcount
  /* ERwin Builtin Wed Apr 10 09:54:27 2002 */
  /* FAC_LOCAIS_GENERICOS_EQUIP R/10 FAC_LOCAIS_ESPECIFICOS_EQUIP ON CHILD INSERT RESTRICT */
  if
    /* update(LGE_ID) */
    update(LGE_ID)
  begin
    select @nullcnt = 0
    select @validcnt = count(*)
      from inserted,FAC_LOCAIS_GENERICOS_EQUIP
        where
          /* inserted.LGE_ID = FAC_LOCAIS_GENERICOS_EQUIP.LGE_ID */
          inserted.LGE_ID = FAC_LOCAIS_GENERICOS_EQUIP.LGE_ID
    /*  */
    
    if @validcnt + @nullcnt != @numrows
    begin
      select @errno  = 30002,
             @errmsg = ''Cannot INSERT FAC_LOCAIS_ESPECIFICOS_EQUIP because FAC_LOCAIS_GENERICOS_EQUIP does not exist.''
      goto error
    end
  end


  /* ERwin Builtin Wed Apr 10 09:54:27 2002 */
  return
error:
    raiserror @errno @errmsg
    rollback transaction
end
'
GO
/****** Object:  ForeignKey [FK_Agenda_Servicos_Plataforma_Agendamento]    Script Date: 07/27/2018 09:30:12 ******/
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_Agenda_Servicos_Plataforma_Agendamento]') AND parent_object_id = OBJECT_ID(N'[dbo].[Agenda_Servicos_Plataforma]'))
ALTER TABLE [dbo].[Agenda_Servicos_Plataforma]  WITH NOCHECK ADD  CONSTRAINT [FK_Agenda_Servicos_Plataforma_Agendamento] FOREIGN KEY([AG_NUMERO])
REFERENCES [dbo].[Agendamento] ([AG_NUMERO])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_Agenda_Servicos_Plataforma_Agendamento]') AND parent_object_id = OBJECT_ID(N'[dbo].[Agenda_Servicos_Plataforma]'))
ALTER TABLE [dbo].[Agenda_Servicos_Plataforma] CHECK CONSTRAINT [FK_Agenda_Servicos_Plataforma_Agendamento]
GO
/****** Object:  ForeignKey [FK_Agenda_Servicos_Plataforma_Servicos_Plataformas]    Script Date: 07/27/2018 09:30:12 ******/
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_Agenda_Servicos_Plataforma_Servicos_Plataformas]') AND parent_object_id = OBJECT_ID(N'[dbo].[Agenda_Servicos_Plataforma]'))
ALTER TABLE [dbo].[Agenda_Servicos_Plataforma]  WITH CHECK ADD  CONSTRAINT [FK_Agenda_Servicos_Plataforma_Servicos_Plataformas] FOREIGN KEY([S_ID])
REFERENCES [dbo].[Servicos_Plataformas] ([S_ID])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_Agenda_Servicos_Plataforma_Servicos_Plataformas]') AND parent_object_id = OBJECT_ID(N'[dbo].[Agenda_Servicos_Plataforma]'))
ALTER TABLE [dbo].[Agenda_Servicos_Plataforma] CHECK CONSTRAINT [FK_Agenda_Servicos_Plataforma_Servicos_Plataformas]
GO
/****** Object:  ForeignKey [FK_Agendamento_Tecnologia]    Script Date: 07/27/2018 09:30:12 ******/
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_Agendamento_Tecnologia]') AND parent_object_id = OBJECT_ID(N'[dbo].[Agendamento]'))
ALTER TABLE [dbo].[Agendamento]  WITH CHECK ADD  CONSTRAINT [FK_Agendamento_Tecnologia] FOREIGN KEY([TEC_ID])
REFERENCES [dbo].[TECNOLOGIA] ([TEC_ID])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_Agendamento_Tecnologia]') AND parent_object_id = OBJECT_ID(N'[dbo].[Agendamento]'))
ALTER TABLE [dbo].[Agendamento] CHECK CONSTRAINT [FK_Agendamento_Tecnologia]
GO
/****** Object:  ForeignKey [FK__Arquivos__ARQ_CO__0A9D95DB]    Script Date: 07/27/2018 09:30:13 ******/
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__Arquivos__ARQ_CO__0A9D95DB]') AND parent_object_id = OBJECT_ID(N'[dbo].[Arquivos]'))
ALTER TABLE [dbo].[Arquivos]  WITH NOCHECK ADD  CONSTRAINT [FK__Arquivos__ARQ_CO__0A9D95DB] FOREIGN KEY([ARQ_CODARQTIPO])
REFERENCES [dbo].[TipoArquivo] ([TAR_CODTIPOARQUIVO])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__Arquivos__ARQ_CO__0A9D95DB]') AND parent_object_id = OBJECT_ID(N'[dbo].[Arquivos]'))
ALTER TABLE [dbo].[Arquivos] CHECK CONSTRAINT [FK__Arquivos__ARQ_CO__0A9D95DB]
GO
/****** Object:  ForeignKey [FK__Arquivos__ARQ_ID__0B91BA14]    Script Date: 07/27/2018 09:30:13 ******/
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__Arquivos__ARQ_ID__0B91BA14]') AND parent_object_id = OBJECT_ID(N'[dbo].[Arquivos]'))
ALTER TABLE [dbo].[Arquivos]  WITH NOCHECK ADD  CONSTRAINT [FK__Arquivos__ARQ_ID__0B91BA14] FOREIGN KEY([ARQ_IDSITUACAO])
REFERENCES [dbo].[SituacaoArquivo] ([SAR_CODSITARQUIVO])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__Arquivos__ARQ_ID__0B91BA14]') AND parent_object_id = OBJECT_ID(N'[dbo].[Arquivos]'))
ALTER TABLE [dbo].[Arquivos] CHECK CONSTRAINT [FK__Arquivos__ARQ_ID__0B91BA14]
GO
/****** Object:  ForeignKey [FK__Arquivos__ARQ_ID__0C85DE4D]    Script Date: 07/27/2018 09:30:13 ******/
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__Arquivos__ARQ_ID__0C85DE4D]') AND parent_object_id = OBJECT_ID(N'[dbo].[Arquivos]'))
ALTER TABLE [dbo].[Arquivos]  WITH NOCHECK ADD  CONSTRAINT [FK__Arquivos__ARQ_ID__0C85DE4D] FOREIGN KEY([ARQ_IDORGAO])
REFERENCES [dbo].[Orgao] ([ORGA_ID])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__Arquivos__ARQ_ID__0C85DE4D]') AND parent_object_id = OBJECT_ID(N'[dbo].[Arquivos]'))
ALTER TABLE [dbo].[Arquivos] CHECK CONSTRAINT [FK__Arquivos__ARQ_ID__0C85DE4D]
GO
/****** Object:  ForeignKey [FK__Diagramas__AG_NU__0E6E26BF]    Script Date: 07/27/2018 09:30:14 ******/
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__Diagramas__AG_NU__0E6E26BF]') AND parent_object_id = OBJECT_ID(N'[dbo].[Diagramas]'))
ALTER TABLE [dbo].[Diagramas]  WITH NOCHECK ADD  CONSTRAINT [FK__Diagramas__AG_NU__0E6E26BF] FOREIGN KEY([AG_NUMERO])
REFERENCES [dbo].[Agendamento] ([AG_NUMERO])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__Diagramas__AG_NU__0E6E26BF]') AND parent_object_id = OBJECT_ID(N'[dbo].[Diagramas]'))
ALTER TABLE [dbo].[Diagramas] CHECK CONSTRAINT [FK__Diagramas__AG_NU__0E6E26BF]
GO
/****** Object:  ForeignKey [FK__Diagramas__ARQ_C__0D7A0286]    Script Date: 07/27/2018 09:30:14 ******/
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__Diagramas__ARQ_C__0D7A0286]') AND parent_object_id = OBJECT_ID(N'[dbo].[Diagramas]'))
ALTER TABLE [dbo].[Diagramas]  WITH NOCHECK ADD  CONSTRAINT [FK__Diagramas__ARQ_C__0D7A0286] FOREIGN KEY([ARQ_CODARQ])
REFERENCES [dbo].[Arquivos] ([ARQ_CODARQ])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__Diagramas__ARQ_C__0D7A0286]') AND parent_object_id = OBJECT_ID(N'[dbo].[Diagramas]'))
ALTER TABLE [dbo].[Diagramas] CHECK CONSTRAINT [FK__Diagramas__ARQ_C__0D7A0286]
GO
/****** Object:  ForeignKey [FK_DisposicaoLB_LB_LogBook]    Script Date: 07/27/2018 09:30:14 ******/
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_DisposicaoLB_LB_LogBook]') AND parent_object_id = OBJECT_ID(N'[dbo].[DisposicaoLB]'))
ALTER TABLE [dbo].[DisposicaoLB]  WITH NOCHECK ADD  CONSTRAINT [FK_DisposicaoLB_LB_LogBook] FOREIGN KEY([LB_ID])
REFERENCES [dbo].[LB_LogBook] ([LB_ID])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_DisposicaoLB_LB_LogBook]') AND parent_object_id = OBJECT_ID(N'[dbo].[DisposicaoLB]'))
ALTER TABLE [dbo].[DisposicaoLB] CHECK CONSTRAINT [FK_DisposicaoLB_LB_LogBook]
GO
/****** Object:  ForeignKey [FK__FAC_CIRCU__TPC_I__6BA4D8C6]    Script Date: 07/27/2018 09:30:16 ******/
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__FAC_CIRCU__TPC_I__6BA4D8C6]') AND parent_object_id = OBJECT_ID(N'[dbo].[FAC_CIRCUITO]'))
ALTER TABLE [dbo].[FAC_CIRCUITO]  WITH NOCHECK ADD  CONSTRAINT [FK__FAC_CIRCU__TPC_I__6BA4D8C6] FOREIGN KEY([TPC_ID])
REFERENCES [dbo].[FAC_TIPO_CIRCUITO] ([TPC_ID])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__FAC_CIRCU__TPC_I__6BA4D8C6]') AND parent_object_id = OBJECT_ID(N'[dbo].[FAC_CIRCUITO]'))
ALTER TABLE [dbo].[FAC_CIRCUITO] NOCHECK CONSTRAINT [FK__FAC_CIRCU__TPC_I__6BA4D8C6]
GO
/****** Object:  ForeignKey [FK__FAC_COMPO__LEE_I__6C98FCFF]    Script Date: 07/27/2018 09:30:16 ******/
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__FAC_COMPO__LEE_I__6C98FCFF]') AND parent_object_id = OBJECT_ID(N'[dbo].[FAC_COMPONENTES]'))
ALTER TABLE [dbo].[FAC_COMPONENTES]  WITH NOCHECK ADD FOREIGN KEY([LEE_ID])
REFERENCES [dbo].[FAC_LOCAIS_ESPECIFICOS_EQUIP] ([LEE_ID])
GO
/****** Object:  ForeignKey [FK__FAC_COMPO__TPC_I__6D8D2138]    Script Date: 07/27/2018 09:30:16 ******/
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__FAC_COMPO__TPC_I__6D8D2138]') AND parent_object_id = OBJECT_ID(N'[dbo].[FAC_COMPONENTES]'))
ALTER TABLE [dbo].[FAC_COMPONENTES]  WITH NOCHECK ADD FOREIGN KEY([TPC_ID])
REFERENCES [dbo].[FAC_TIPO_COMPONENTE] ([TPC_ID])
GO
/****** Object:  ForeignKey [FK__FAC_FACIL__CPT_I__6F7569AA]    Script Date: 07/27/2018 09:30:17 ******/
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__FAC_FACIL__CPT_I__6F7569AA]') AND parent_object_id = OBJECT_ID(N'[dbo].[FAC_FACILIDADES]'))
ALTER TABLE [dbo].[FAC_FACILIDADES]  WITH NOCHECK ADD FOREIGN KEY([CPT_ID])
REFERENCES [dbo].[FAC_COMPONENTES] ([CPT_ID])
GO
/****** Object:  ForeignKey [FK__FAC_FACIL__CTO_I__6E814571]    Script Date: 07/27/2018 09:30:17 ******/
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__FAC_FACIL__CTO_I__6E814571]') AND parent_object_id = OBJECT_ID(N'[dbo].[FAC_FACILIDADES]'))
ALTER TABLE [dbo].[FAC_FACILIDADES]  WITH NOCHECK ADD FOREIGN KEY([CTO_ID])
REFERENCES [dbo].[FAC_CIRCUITO] ([CTO_ID])
GO
/****** Object:  ForeignKey [FK__FAC_LOCAI__LGE_I__70698DE3]    Script Date: 07/27/2018 09:30:18 ******/
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__FAC_LOCAI__LGE_I__70698DE3]') AND parent_object_id = OBJECT_ID(N'[dbo].[FAC_LOCAIS_ESPECIFICOS_EQUIP]'))
ALTER TABLE [dbo].[FAC_LOCAIS_ESPECIFICOS_EQUIP]  WITH NOCHECK ADD FOREIGN KEY([LGE_ID])
REFERENCES [dbo].[FAC_LOCAIS_GENERICOS_EQUIP] ([LGE_ID])
GO
/****** Object:  ForeignKey [FK__FAC_REL_C__FAC_I__7251D655]    Script Date: 07/27/2018 09:30:19 ******/
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__FAC_REL_C__FAC_I__7251D655]') AND parent_object_id = OBJECT_ID(N'[dbo].[FAC_REL_CARACTERISTICAS_FACILIDADES]'))
ALTER TABLE [dbo].[FAC_REL_CARACTERISTICAS_FACILIDADES]  WITH NOCHECK ADD  CONSTRAINT [FK__FAC_REL_C__FAC_I__7251D655] FOREIGN KEY([FAC_ID])
REFERENCES [dbo].[FAC_FACILIDADES] ([FAC_ID])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__FAC_REL_C__FAC_I__7251D655]') AND parent_object_id = OBJECT_ID(N'[dbo].[FAC_REL_CARACTERISTICAS_FACILIDADES]'))
ALTER TABLE [dbo].[FAC_REL_CARACTERISTICAS_FACILIDADES] NOCHECK CONSTRAINT [FK__FAC_REL_C__FAC_I__7251D655]
GO
/****** Object:  ForeignKey [FK__FAC_REL_CARACTER__715DB21C]    Script Date: 07/27/2018 09:30:19 ******/
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__FAC_REL_CARACTER__715DB21C]') AND parent_object_id = OBJECT_ID(N'[dbo].[FAC_REL_CARACTERISTICAS_FACILIDADES]'))
ALTER TABLE [dbo].[FAC_REL_CARACTERISTICAS_FACILIDADES]  WITH NOCHECK ADD  CONSTRAINT [FK__FAC_REL_CARACTER__715DB21C] FOREIGN KEY([CAR_ID], [TPC_ID])
REFERENCES [dbo].[FAC_REL_CARACTERISTICAS_TIPO] ([CAR_ID], [TPC_ID])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__FAC_REL_CARACTER__715DB21C]') AND parent_object_id = OBJECT_ID(N'[dbo].[FAC_REL_CARACTERISTICAS_FACILIDADES]'))
ALTER TABLE [dbo].[FAC_REL_CARACTERISTICAS_FACILIDADES] NOCHECK CONSTRAINT [FK__FAC_REL_CARACTER__715DB21C]
GO
/****** Object:  ForeignKey [FK__FAC_REL_C__CAR_I__743A1EC7]    Script Date: 07/27/2018 09:30:19 ******/
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__FAC_REL_C__CAR_I__743A1EC7]') AND parent_object_id = OBJECT_ID(N'[dbo].[FAC_REL_CARACTERISTICAS_TIPO]'))
ALTER TABLE [dbo].[FAC_REL_CARACTERISTICAS_TIPO]  WITH NOCHECK ADD FOREIGN KEY([CAR_ID])
REFERENCES [dbo].[FAC_CARACTERISTICAS] ([CAR_ID])
GO
/****** Object:  ForeignKey [FK__FAC_REL_C__TPC_I__7345FA8E]    Script Date: 07/27/2018 09:30:19 ******/
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__FAC_REL_C__TPC_I__7345FA8E]') AND parent_object_id = OBJECT_ID(N'[dbo].[FAC_REL_CARACTERISTICAS_TIPO]'))
ALTER TABLE [dbo].[FAC_REL_CARACTERISTICAS_TIPO]  WITH NOCHECK ADD FOREIGN KEY([TPC_ID])
REFERENCES [dbo].[FAC_TIPO_COMPONENTE] ([TPC_ID])
GO
/****** Object:  ForeignKey [FK__FAC_REL_C__AG_NU__76226739]    Script Date: 07/27/2018 09:30:20 ******/
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__FAC_REL_C__AG_NU__76226739]') AND parent_object_id = OBJECT_ID(N'[dbo].[FAC_REL_CIRCUITO_AGENDAMENTO]'))
ALTER TABLE [dbo].[FAC_REL_CIRCUITO_AGENDAMENTO]  WITH NOCHECK ADD  CONSTRAINT [FK__FAC_REL_C__AG_NU__76226739] FOREIGN KEY([AG_NUMERO])
REFERENCES [dbo].[Agendamento] ([AG_NUMERO])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__FAC_REL_C__AG_NU__76226739]') AND parent_object_id = OBJECT_ID(N'[dbo].[FAC_REL_CIRCUITO_AGENDAMENTO]'))
ALTER TABLE [dbo].[FAC_REL_CIRCUITO_AGENDAMENTO] NOCHECK CONSTRAINT [FK__FAC_REL_C__AG_NU__76226739]
GO
/****** Object:  ForeignKey [FK__FAC_REL_C__CTO_I__752E4300]    Script Date: 07/27/2018 09:30:20 ******/
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__FAC_REL_C__CTO_I__752E4300]') AND parent_object_id = OBJECT_ID(N'[dbo].[FAC_REL_CIRCUITO_AGENDAMENTO]'))
ALTER TABLE [dbo].[FAC_REL_CIRCUITO_AGENDAMENTO]  WITH NOCHECK ADD FOREIGN KEY([CTO_ID])
REFERENCES [dbo].[FAC_CIRCUITO] ([CTO_ID])
GO
/****** Object:  ForeignKey [FK__FAC_TIPO___FAB_I__77168B72]    Script Date: 07/27/2018 09:30:21 ******/
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__FAC_TIPO___FAB_I__77168B72]') AND parent_object_id = OBJECT_ID(N'[dbo].[FAC_TIPO_COMPONENTE]'))
ALTER TABLE [dbo].[FAC_TIPO_COMPONENTE]  WITH NOCHECK ADD FOREIGN KEY([FAB_ID])
REFERENCES [dbo].[FAC_FABRICANTE_TIPO_COMPONENTE] ([FAB_ID])
GO
/****** Object:  ForeignKey [FK__FAC_TIPO___FTC_I__780AAFAB]    Script Date: 07/27/2018 09:30:21 ******/
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__FAC_TIPO___FTC_I__780AAFAB]') AND parent_object_id = OBJECT_ID(N'[dbo].[FAC_TIPO_COMPONENTE]'))
ALTER TABLE [dbo].[FAC_TIPO_COMPONENTE]  WITH NOCHECK ADD FOREIGN KEY([FTC_ID])
REFERENCES [dbo].[FAC_FAMILIA_TIPO_COMPONENTE] ([FTC_ID])
GO
/****** Object:  ForeignKey [FK_HISTORICO_ARQUIVOS_Arquivos]    Script Date: 07/27/2018 09:30:22 ******/
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_HISTORICO_ARQUIVOS_Arquivos]') AND parent_object_id = OBJECT_ID(N'[dbo].[HISTORICO_ARQUIVOS]'))
ALTER TABLE [dbo].[HISTORICO_ARQUIVOS]  WITH CHECK ADD  CONSTRAINT [FK_HISTORICO_ARQUIVOS_Arquivos] FOREIGN KEY([HA_CODARQ])
REFERENCES [dbo].[Arquivos] ([ARQ_CODARQ])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_HISTORICO_ARQUIVOS_Arquivos]') AND parent_object_id = OBJECT_ID(N'[dbo].[HISTORICO_ARQUIVOS]'))
ALTER TABLE [dbo].[HISTORICO_ARQUIVOS] CHECK CONSTRAINT [FK_HISTORICO_ARQUIVOS_Arquivos]
GO
/****** Object:  ForeignKey [FK_Historico_Arquivos_UserCRT]    Script Date: 07/27/2018 09:30:22 ******/
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_Historico_Arquivos_UserCRT]') AND parent_object_id = OBJECT_ID(N'[dbo].[HISTORICO_ARQUIVOS]'))
ALTER TABLE [dbo].[HISTORICO_ARQUIVOS]  WITH CHECK ADD  CONSTRAINT [FK_Historico_Arquivos_UserCRT] FOREIGN KEY([HA_USUARIO])
REFERENCES [dbo].[UserCRT] ([USERID])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_Historico_Arquivos_UserCRT]') AND parent_object_id = OBJECT_ID(N'[dbo].[HISTORICO_ARQUIVOS]'))
ALTER TABLE [dbo].[HISTORICO_ARQUIVOS] CHECK CONSTRAINT [FK_Historico_Arquivos_UserCRT]
GO
/****** Object:  ForeignKey [FK__Historico__AG_NU__04E4BC85]    Script Date: 07/27/2018 09:30:22 ******/
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__Historico__AG_NU__04E4BC85]') AND parent_object_id = OBJECT_ID(N'[dbo].[Historico_datas]'))
ALTER TABLE [dbo].[Historico_datas]  WITH NOCHECK ADD  CONSTRAINT [FK__Historico__AG_NU__04E4BC85] FOREIGN KEY([AG_NUMERO])
REFERENCES [dbo].[Agendamento] ([AG_NUMERO])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__Historico__AG_NU__04E4BC85]') AND parent_object_id = OBJECT_ID(N'[dbo].[Historico_datas]'))
ALTER TABLE [dbo].[Historico_datas] CHECK CONSTRAINT [FK__Historico__AG_NU__04E4BC85]
GO
/****** Object:  ForeignKey [FK__Historico__HD_RE__03F0984C]    Script Date: 07/27/2018 09:30:22 ******/
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__Historico__HD_RE__03F0984C]') AND parent_object_id = OBJECT_ID(N'[dbo].[Historico_datas]'))
ALTER TABLE [dbo].[Historico_datas]  WITH NOCHECK ADD  CONSTRAINT [FK__Historico__HD_RE__03F0984C] FOREIGN KEY([HD_RESPONSAVEL])
REFERENCES [dbo].[UserCRT] ([USERID])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__Historico__HD_RE__03F0984C]') AND parent_object_id = OBJECT_ID(N'[dbo].[Historico_datas]'))
ALTER TABLE [dbo].[Historico_datas] CHECK CONSTRAINT [FK__Historico__HD_RE__03F0984C]
GO
/****** Object:  ForeignKey [FK__Historico__AG_NU__787EE5A0]    Script Date: 07/27/2018 09:30:23 ******/
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__Historico__AG_NU__787EE5A0]') AND parent_object_id = OBJECT_ID(N'[dbo].[Historico_Eventos]'))
ALTER TABLE [dbo].[Historico_Eventos]  WITH NOCHECK ADD  CONSTRAINT [FK__Historico__AG_NU__787EE5A0] FOREIGN KEY([AG_NUMERO])
REFERENCES [dbo].[Agendamento] ([AG_NUMERO])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__Historico__AG_NU__787EE5A0]') AND parent_object_id = OBJECT_ID(N'[dbo].[Historico_Eventos]'))
ALTER TABLE [dbo].[Historico_Eventos] CHECK CONSTRAINT [FK__Historico__AG_NU__787EE5A0]
GO
/****** Object:  ForeignKey [FK__Historico__HE_RE__778AC167]    Script Date: 07/27/2018 09:30:23 ******/
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__Historico__HE_RE__778AC167]') AND parent_object_id = OBJECT_ID(N'[dbo].[Historico_Eventos]'))
ALTER TABLE [dbo].[Historico_Eventos]  WITH NOCHECK ADD  CONSTRAINT [FK__Historico__HE_RE__778AC167] FOREIGN KEY([HE_RESPONSAVEL])
REFERENCES [dbo].[UserCRT] ([USERID])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__Historico__HE_RE__778AC167]') AND parent_object_id = OBJECT_ID(N'[dbo].[Historico_Eventos]'))
ALTER TABLE [dbo].[Historico_Eventos] CHECK CONSTRAINT [FK__Historico__HE_RE__778AC167]
GO
/****** Object:  ForeignKey [FK__Historico__ID_SI__76969D2E]    Script Date: 07/27/2018 09:30:23 ******/
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__Historico__ID_SI__76969D2E]') AND parent_object_id = OBJECT_ID(N'[dbo].[Historico_Eventos]'))
ALTER TABLE [dbo].[Historico_Eventos]  WITH NOCHECK ADD  CONSTRAINT [FK__Historico__ID_SI__76969D2E] FOREIGN KEY([ID_SITUACAO])
REFERENCES [dbo].[Situacoes] ([ID_SITUACAO])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__Historico__ID_SI__76969D2E]') AND parent_object_id = OBJECT_ID(N'[dbo].[Historico_Eventos]'))
ALTER TABLE [dbo].[Historico_Eventos] CHECK CONSTRAINT [FK__Historico__ID_SI__76969D2E]
GO
/****** Object:  ForeignKey [FK__Historico__HEOS___2180FB33]    Script Date: 07/27/2018 09:30:23 ******/
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__Historico__HEOS___2180FB33]') AND parent_object_id = OBJECT_ID(N'[dbo].[Historico_EventosOS]'))
ALTER TABLE [dbo].[Historico_EventosOS]  WITH NOCHECK ADD  CONSTRAINT [FK__Historico__HEOS___2180FB33] FOREIGN KEY([HEOS_RESPONSAVEL])
REFERENCES [dbo].[UserCRT] ([USERID])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__Historico__HEOS___2180FB33]') AND parent_object_id = OBJECT_ID(N'[dbo].[Historico_EventosOS]'))
ALTER TABLE [dbo].[Historico_EventosOS] CHECK CONSTRAINT [FK__Historico__HEOS___2180FB33]
GO
/****** Object:  ForeignKey [FK__Historico__ID_SI__208CD6FA]    Script Date: 07/27/2018 09:30:23 ******/
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__Historico__ID_SI__208CD6FA]') AND parent_object_id = OBJECT_ID(N'[dbo].[Historico_EventosOS]'))
ALTER TABLE [dbo].[Historico_EventosOS]  WITH NOCHECK ADD  CONSTRAINT [FK__Historico__ID_SI__208CD6FA] FOREIGN KEY([ID_SITUACAO])
REFERENCES [dbo].[Situacoes] ([ID_SITUACAO])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__Historico__ID_SI__208CD6FA]') AND parent_object_id = OBJECT_ID(N'[dbo].[Historico_EventosOS]'))
ALTER TABLE [dbo].[Historico_EventosOS] CHECK CONSTRAINT [FK__Historico__ID_SI__208CD6FA]
GO
/****** Object:  ForeignKey [FK__Historico_Evento__22751F6C]    Script Date: 07/27/2018 09:30:23 ******/
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__Historico_Evento__22751F6C]') AND parent_object_id = OBJECT_ID(N'[dbo].[Historico_EventosOS]'))
ALTER TABLE [dbo].[Historico_EventosOS]  WITH NOCHECK ADD  CONSTRAINT [FK__Historico_Evento__22751F6C] FOREIGN KEY([OS_ID], [AG_NUMERO])
REFERENCES [dbo].[Ordem_de_Servico] ([OS_ID], [AG_NUMERO])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__Historico_Evento__22751F6C]') AND parent_object_id = OBJECT_ID(N'[dbo].[Historico_EventosOS]'))
ALTER TABLE [dbo].[Historico_EventosOS] CHECK CONSTRAINT [FK__Historico_Evento__22751F6C]
GO
/****** Object:  ForeignKey [FK_HISTORICO_PLATAFORMA_EQUIPAMENTOS_SCE_EQUIPAMENTOS]    Script Date: 07/27/2018 09:30:23 ******/
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_HISTORICO_PLATAFORMA_EQUIPAMENTOS_SCE_EQUIPAMENTOS]') AND parent_object_id = OBJECT_ID(N'[dbo].[HISTORICO_PLATAFORMA_EQUIPAMENTOS]'))
ALTER TABLE [dbo].[HISTORICO_PLATAFORMA_EQUIPAMENTOS]  WITH CHECK ADD  CONSTRAINT [FK_HISTORICO_PLATAFORMA_EQUIPAMENTOS_SCE_EQUIPAMENTOS] FOREIGN KEY([EQ_ID])
REFERENCES [dbo].[SCE_Equipamentos] ([EQ_ID])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_HISTORICO_PLATAFORMA_EQUIPAMENTOS_SCE_EQUIPAMENTOS]') AND parent_object_id = OBJECT_ID(N'[dbo].[HISTORICO_PLATAFORMA_EQUIPAMENTOS]'))
ALTER TABLE [dbo].[HISTORICO_PLATAFORMA_EQUIPAMENTOS] CHECK CONSTRAINT [FK_HISTORICO_PLATAFORMA_EQUIPAMENTOS_SCE_EQUIPAMENTOS]
GO
/****** Object:  ForeignKey [FK_HISTORICO_PLATAFORMA_EQUIPAMENTOS_SERVICOS_PLATAFORMAS]    Script Date: 07/27/2018 09:30:23 ******/
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_HISTORICO_PLATAFORMA_EQUIPAMENTOS_SERVICOS_PLATAFORMAS]') AND parent_object_id = OBJECT_ID(N'[dbo].[HISTORICO_PLATAFORMA_EQUIPAMENTOS]'))
ALTER TABLE [dbo].[HISTORICO_PLATAFORMA_EQUIPAMENTOS]  WITH CHECK ADD  CONSTRAINT [FK_HISTORICO_PLATAFORMA_EQUIPAMENTOS_SERVICOS_PLATAFORMAS] FOREIGN KEY([S_ID])
REFERENCES [dbo].[Servicos_Plataformas] ([S_ID])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_HISTORICO_PLATAFORMA_EQUIPAMENTOS_SERVICOS_PLATAFORMAS]') AND parent_object_id = OBJECT_ID(N'[dbo].[HISTORICO_PLATAFORMA_EQUIPAMENTOS]'))
ALTER TABLE [dbo].[HISTORICO_PLATAFORMA_EQUIPAMENTOS] CHECK CONSTRAINT [FK_HISTORICO_PLATAFORMA_EQUIPAMENTOS_SERVICOS_PLATAFORMAS]
GO
/****** Object:  ForeignKey [FK_LB_ACOESTOMADAS_LB_LogBook]    Script Date: 07/27/2018 09:30:24 ******/
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_LB_ACOESTOMADAS_LB_LogBook]') AND parent_object_id = OBJECT_ID(N'[dbo].[LB_ACOESTOMADAS]'))
ALTER TABLE [dbo].[LB_ACOESTOMADAS]  WITH NOCHECK ADD  CONSTRAINT [FK_LB_ACOESTOMADAS_LB_LogBook] FOREIGN KEY([ACT_LB])
REFERENCES [dbo].[LB_LogBook] ([LB_ID])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_LB_ACOESTOMADAS_LB_LogBook]') AND parent_object_id = OBJECT_ID(N'[dbo].[LB_ACOESTOMADAS]'))
ALTER TABLE [dbo].[LB_ACOESTOMADAS] CHECK CONSTRAINT [FK_LB_ACOESTOMADAS_LB_LogBook]
GO
/****** Object:  ForeignKey [FK_LB_ACOESTOMADAS_LB_TIPOACAOTOMADA]    Script Date: 07/27/2018 09:30:24 ******/
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_LB_ACOESTOMADAS_LB_TIPOACAOTOMADA]') AND parent_object_id = OBJECT_ID(N'[dbo].[LB_ACOESTOMADAS]'))
ALTER TABLE [dbo].[LB_ACOESTOMADAS]  WITH NOCHECK ADD  CONSTRAINT [FK_LB_ACOESTOMADAS_LB_TIPOACAOTOMADA] FOREIGN KEY([ACT_TIPOACAO])
REFERENCES [dbo].[LB_TIPOACAOTOMADA] ([TAT_ID])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_LB_ACOESTOMADAS_LB_TIPOACAOTOMADA]') AND parent_object_id = OBJECT_ID(N'[dbo].[LB_ACOESTOMADAS]'))
ALTER TABLE [dbo].[LB_ACOESTOMADAS] CHECK CONSTRAINT [FK_LB_ACOESTOMADAS_LB_TIPOACAOTOMADA]
GO
/****** Object:  ForeignKey [FK_LB_ACOESTOMADAS_USERCRT]    Script Date: 07/27/2018 09:30:24 ******/
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_LB_ACOESTOMADAS_USERCRT]') AND parent_object_id = OBJECT_ID(N'[dbo].[LB_ACOESTOMADAS]'))
ALTER TABLE [dbo].[LB_ACOESTOMADAS]  WITH CHECK ADD  CONSTRAINT [FK_LB_ACOESTOMADAS_USERCRT] FOREIGN KEY([ACT_RESPONSAVEL])
REFERENCES [dbo].[UserCRT] ([USERID])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_LB_ACOESTOMADAS_USERCRT]') AND parent_object_id = OBJECT_ID(N'[dbo].[LB_ACOESTOMADAS]'))
ALTER TABLE [dbo].[LB_ACOESTOMADAS] CHECK CONSTRAINT [FK_LB_ACOESTOMADAS_USERCRT]
GO
/****** Object:  ForeignKey [FK_LB_ACOESTOMADAS_LB_ACOESTOMADAS_ARQUIVOS]    Script Date: 07/27/2018 09:30:24 ******/
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_LB_ACOESTOMADAS_LB_ACOESTOMADAS_ARQUIVOS]') AND parent_object_id = OBJECT_ID(N'[dbo].[LB_ACOESTOMADAS_ARQUIVOS]'))
ALTER TABLE [dbo].[LB_ACOESTOMADAS_ARQUIVOS]  WITH CHECK ADD  CONSTRAINT [FK_LB_ACOESTOMADAS_LB_ACOESTOMADAS_ARQUIVOS] FOREIGN KEY([ACT_ID])
REFERENCES [dbo].[LB_ACOESTOMADAS] ([ACT_ID])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_LB_ACOESTOMADAS_LB_ACOESTOMADAS_ARQUIVOS]') AND parent_object_id = OBJECT_ID(N'[dbo].[LB_ACOESTOMADAS_ARQUIVOS]'))
ALTER TABLE [dbo].[LB_ACOESTOMADAS_ARQUIVOS] CHECK CONSTRAINT [FK_LB_ACOESTOMADAS_LB_ACOESTOMADAS_ARQUIVOS]
GO
/****** Object:  ForeignKey [FK_LB_LOGBOOK_LB_ACOESTOMADAS_ARQUIVOS]    Script Date: 07/27/2018 09:30:24 ******/
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_LB_LOGBOOK_LB_ACOESTOMADAS_ARQUIVOS]') AND parent_object_id = OBJECT_ID(N'[dbo].[LB_ACOESTOMADAS_ARQUIVOS]'))
ALTER TABLE [dbo].[LB_ACOESTOMADAS_ARQUIVOS]  WITH CHECK ADD  CONSTRAINT [FK_LB_LOGBOOK_LB_ACOESTOMADAS_ARQUIVOS] FOREIGN KEY([LB_ID])
REFERENCES [dbo].[LB_LogBook] ([LB_ID])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_LB_LOGBOOK_LB_ACOESTOMADAS_ARQUIVOS]') AND parent_object_id = OBJECT_ID(N'[dbo].[LB_ACOESTOMADAS_ARQUIVOS]'))
ALTER TABLE [dbo].[LB_ACOESTOMADAS_ARQUIVOS] CHECK CONSTRAINT [FK_LB_LOGBOOK_LB_ACOESTOMADAS_ARQUIVOS]
GO
/****** Object:  ForeignKey [FK__LB_LogBoo__LBTO___73BA3083]    Script Date: 07/27/2018 09:30:25 ******/
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__LB_LogBoo__LBTO___73BA3083]') AND parent_object_id = OBJECT_ID(N'[dbo].[LB_LogBook]'))
ALTER TABLE [dbo].[LB_LogBook]  WITH NOCHECK ADD  CONSTRAINT [FK__LB_LogBoo__LBTO___73BA3083] FOREIGN KEY([LBTO_ID])
REFERENCES [dbo].[LB_TipoOcorrencia] ([LBTO_ID])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__LB_LogBoo__LBTO___73BA3083]') AND parent_object_id = OBJECT_ID(N'[dbo].[LB_LogBook]'))
ALTER TABLE [dbo].[LB_LogBook] CHECK CONSTRAINT [FK__LB_LogBoo__LBTO___73BA3083]
GO
/****** Object:  ForeignKey [FK_LB_LogBook_UserCRT]    Script Date: 07/27/2018 09:30:25 ******/
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_LB_LogBook_UserCRT]') AND parent_object_id = OBJECT_ID(N'[dbo].[LB_LogBook]'))
ALTER TABLE [dbo].[LB_LogBook]  WITH NOCHECK ADD  CONSTRAINT [FK_LB_LogBook_UserCRT] FOREIGN KEY([LB_RATRESPONSAVEL])
REFERENCES [dbo].[UserCRT] ([USERID])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_LB_LogBook_UserCRT]') AND parent_object_id = OBJECT_ID(N'[dbo].[LB_LogBook]'))
ALTER TABLE [dbo].[LB_LogBook] CHECK CONSTRAINT [FK_LB_LogBook_UserCRT]
GO
/****** Object:  ForeignKey [FK__LogBook_A__AG_NU__74AE54BC]    Script Date: 07/27/2018 09:30:26 ******/
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__LogBook_A__AG_NU__74AE54BC]') AND parent_object_id = OBJECT_ID(N'[dbo].[LogBook_Agendamento]'))
ALTER TABLE [dbo].[LogBook_Agendamento]  WITH NOCHECK ADD  CONSTRAINT [FK__LogBook_A__AG_NU__74AE54BC] FOREIGN KEY([AG_NUMERO])
REFERENCES [dbo].[Agendamento] ([AG_NUMERO])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__LogBook_A__AG_NU__74AE54BC]') AND parent_object_id = OBJECT_ID(N'[dbo].[LogBook_Agendamento]'))
ALTER TABLE [dbo].[LogBook_Agendamento] CHECK CONSTRAINT [FK__LogBook_A__AG_NU__74AE54BC]
GO
/****** Object:  ForeignKey [FK__LogBook_A__LB_ID__75A278F5]    Script Date: 07/27/2018 09:30:26 ******/
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__LogBook_A__LB_ID__75A278F5]') AND parent_object_id = OBJECT_ID(N'[dbo].[LogBook_Agendamento]'))
ALTER TABLE [dbo].[LogBook_Agendamento]  WITH NOCHECK ADD  CONSTRAINT [FK__LogBook_A__LB_ID__75A278F5] FOREIGN KEY([LB_ID])
REFERENCES [dbo].[LB_LogBook] ([LB_ID])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__LogBook_A__LB_ID__75A278F5]') AND parent_object_id = OBJECT_ID(N'[dbo].[LogBook_Agendamento]'))
ALTER TABLE [dbo].[LogBook_Agendamento] CHECK CONSTRAINT [FK__LogBook_A__LB_ID__75A278F5]
GO
/****** Object:  ForeignKey [FK_Ordem_de_Servico_Agendamento]    Script Date: 07/27/2018 09:30:27 ******/
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_Ordem_de_Servico_Agendamento]') AND parent_object_id = OBJECT_ID(N'[dbo].[Ordem_de_Servico]'))
ALTER TABLE [dbo].[Ordem_de_Servico]  WITH NOCHECK ADD  CONSTRAINT [FK_Ordem_de_Servico_Agendamento] FOREIGN KEY([AG_NUMERO])
REFERENCES [dbo].[Agendamento] ([AG_NUMERO])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_Ordem_de_Servico_Agendamento]') AND parent_object_id = OBJECT_ID(N'[dbo].[Ordem_de_Servico]'))
ALTER TABLE [dbo].[Ordem_de_Servico] CHECK CONSTRAINT [FK_Ordem_de_Servico_Agendamento]
GO
/****** Object:  ForeignKey [FK_Ordem_de_Servico_SCE_Equipamentos]    Script Date: 07/27/2018 09:30:27 ******/
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_Ordem_de_Servico_SCE_Equipamentos]') AND parent_object_id = OBJECT_ID(N'[dbo].[Ordem_de_Servico]'))
ALTER TABLE [dbo].[Ordem_de_Servico]  WITH NOCHECK ADD  CONSTRAINT [FK_Ordem_de_Servico_SCE_Equipamentos] FOREIGN KEY([EQ_ID_AMOSTRA])
REFERENCES [dbo].[SCE_Equipamentos] ([EQ_ID])
NOT FOR REPLICATION
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_Ordem_de_Servico_SCE_Equipamentos]') AND parent_object_id = OBJECT_ID(N'[dbo].[Ordem_de_Servico]'))
ALTER TABLE [dbo].[Ordem_de_Servico] CHECK CONSTRAINT [FK_Ordem_de_Servico_SCE_Equipamentos]
GO
/****** Object:  ForeignKey [FK_Ordem_de_Servico_Servicos_Plataformas_Plataforma]    Script Date: 07/27/2018 09:30:27 ******/
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_Ordem_de_Servico_Servicos_Plataformas_Plataforma]') AND parent_object_id = OBJECT_ID(N'[dbo].[Ordem_de_Servico]'))
ALTER TABLE [dbo].[Ordem_de_Servico]  WITH NOCHECK ADD  CONSTRAINT [FK_Ordem_de_Servico_Servicos_Plataformas_Plataforma] FOREIGN KEY([S_ID_PLATAFORMA])
REFERENCES [dbo].[Servicos_Plataformas] ([S_ID])
NOT FOR REPLICATION
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_Ordem_de_Servico_Servicos_Plataformas_Plataforma]') AND parent_object_id = OBJECT_ID(N'[dbo].[Ordem_de_Servico]'))
ALTER TABLE [dbo].[Ordem_de_Servico] CHECK CONSTRAINT [FK_Ordem_de_Servico_Servicos_Plataformas_Plataforma]
GO
/****** Object:  ForeignKey [FK_Ordem_de_Servico_Servicos_Plataformas_Servico]    Script Date: 07/27/2018 09:30:27 ******/
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_Ordem_de_Servico_Servicos_Plataformas_Servico]') AND parent_object_id = OBJECT_ID(N'[dbo].[Ordem_de_Servico]'))
ALTER TABLE [dbo].[Ordem_de_Servico]  WITH NOCHECK ADD  CONSTRAINT [FK_Ordem_de_Servico_Servicos_Plataformas_Servico] FOREIGN KEY([S_ID_SERVICO])
REFERENCES [dbo].[Servicos_Plataformas] ([S_ID])
NOT FOR REPLICATION
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_Ordem_de_Servico_Servicos_Plataformas_Servico]') AND parent_object_id = OBJECT_ID(N'[dbo].[Ordem_de_Servico]'))
ALTER TABLE [dbo].[Ordem_de_Servico] CHECK CONSTRAINT [FK_Ordem_de_Servico_Servicos_Plataformas_Servico]
GO
/****** Object:  ForeignKey [FK_Ordem_de_Servico_Testes]    Script Date: 07/27/2018 09:30:27 ******/
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_Ordem_de_Servico_Testes]') AND parent_object_id = OBJECT_ID(N'[dbo].[Ordem_de_Servico]'))
ALTER TABLE [dbo].[Ordem_de_Servico]  WITH NOCHECK ADD  CONSTRAINT [FK_Ordem_de_Servico_Testes] FOREIGN KEY([T_ID])
REFERENCES [dbo].[TESTES] ([T_ID])
NOT FOR REPLICATION
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_Ordem_de_Servico_Testes]') AND parent_object_id = OBJECT_ID(N'[dbo].[Ordem_de_Servico]'))
ALTER TABLE [dbo].[Ordem_de_Servico] CHECK CONSTRAINT [FK_Ordem_de_Servico_Testes]
GO
/****** Object:  ForeignKey [FK_Ordem_de_Servico_UserCRT]    Script Date: 07/27/2018 09:30:27 ******/
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_Ordem_de_Servico_UserCRT]') AND parent_object_id = OBJECT_ID(N'[dbo].[Ordem_de_Servico]'))
ALTER TABLE [dbo].[Ordem_de_Servico]  WITH CHECK ADD  CONSTRAINT [FK_Ordem_de_Servico_UserCRT] FOREIGN KEY([OS_RESPONSAVEL])
REFERENCES [dbo].[UserCRT] ([USERID])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_Ordem_de_Servico_UserCRT]') AND parent_object_id = OBJECT_ID(N'[dbo].[Ordem_de_Servico]'))
ALTER TABLE [dbo].[Ordem_de_Servico] CHECK CONSTRAINT [FK_Ordem_de_Servico_UserCRT]
GO
/****** Object:  ForeignKey [FK__Participa__AG_NU__1DB06A4F]    Script Date: 07/27/2018 09:30:28 ******/
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__Participa__AG_NU__1DB06A4F]') AND parent_object_id = OBJECT_ID(N'[dbo].[Participantes_Externos]'))
ALTER TABLE [dbo].[Participantes_Externos]  WITH NOCHECK ADD  CONSTRAINT [FK__Participa__AG_NU__1DB06A4F] FOREIGN KEY([AG_NUMERO])
REFERENCES [dbo].[Agendamento] ([AG_NUMERO])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__Participa__AG_NU__1DB06A4F]') AND parent_object_id = OBJECT_ID(N'[dbo].[Participantes_Externos]'))
ALTER TABLE [dbo].[Participantes_Externos] CHECK CONSTRAINT [FK__Participa__AG_NU__1DB06A4F]
GO
/****** Object:  ForeignKey [FK__Plantao__PLA_USE__0F624AF8]    Script Date: 07/27/2018 09:30:29 ******/
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__Plantao__PLA_USE__0F624AF8]') AND parent_object_id = OBJECT_ID(N'[dbo].[Plantao]'))
ALTER TABLE [dbo].[Plantao]  WITH NOCHECK ADD  CONSTRAINT [FK__Plantao__PLA_USE__0F624AF8] FOREIGN KEY([PLA_USERID])
REFERENCES [dbo].[UserCRT] ([USERID])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__Plantao__PLA_USE__0F624AF8]') AND parent_object_id = OBJECT_ID(N'[dbo].[Plantao]'))
ALTER TABLE [dbo].[Plantao] CHECK CONSTRAINT [FK__Plantao__PLA_USE__0F624AF8]
GO
/****** Object:  ForeignKey [FK_Reserva_Ambientes_Agendamento]    Script Date: 07/27/2018 09:30:30 ******/
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_Reserva_Ambientes_Agendamento]') AND parent_object_id = OBJECT_ID(N'[dbo].[Reserva_ambientes]'))
ALTER TABLE [dbo].[Reserva_ambientes]  WITH CHECK ADD  CONSTRAINT [FK_Reserva_Ambientes_Agendamento] FOREIGN KEY([RAM_AS])
REFERENCES [dbo].[Agendamento] ([AG_NUMERO])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_Reserva_Ambientes_Agendamento]') AND parent_object_id = OBJECT_ID(N'[dbo].[Reserva_ambientes]'))
ALTER TABLE [dbo].[Reserva_ambientes] CHECK CONSTRAINT [FK_Reserva_Ambientes_Agendamento]
GO
/****** Object:  ForeignKey [FK_Reserva_Ambientes_Ambientes]    Script Date: 07/27/2018 09:30:30 ******/
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_Reserva_Ambientes_Ambientes]') AND parent_object_id = OBJECT_ID(N'[dbo].[Reserva_ambientes]'))
ALTER TABLE [dbo].[Reserva_ambientes]  WITH CHECK ADD  CONSTRAINT [FK_Reserva_Ambientes_Ambientes] FOREIGN KEY([AMB_ID])
REFERENCES [dbo].[Ambientes] ([AMB_ID])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_Reserva_Ambientes_Ambientes]') AND parent_object_id = OBJECT_ID(N'[dbo].[Reserva_ambientes]'))
ALTER TABLE [dbo].[Reserva_ambientes] CHECK CONSTRAINT [FK_Reserva_Ambientes_Ambientes]
GO
/****** Object:  ForeignKey [FK_ResolucaoLB_LB_LogBook]    Script Date: 07/27/2018 09:30:30 ******/
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_ResolucaoLB_LB_LogBook]') AND parent_object_id = OBJECT_ID(N'[dbo].[ResolucaoLB]'))
ALTER TABLE [dbo].[ResolucaoLB]  WITH NOCHECK ADD  CONSTRAINT [FK_ResolucaoLB_LB_LogBook] FOREIGN KEY([LB_ID])
REFERENCES [dbo].[LB_LogBook] ([LB_ID])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_ResolucaoLB_LB_LogBook]') AND parent_object_id = OBJECT_ID(N'[dbo].[ResolucaoLB]'))
ALTER TABLE [dbo].[ResolucaoLB] CHECK CONSTRAINT [FK_ResolucaoLB_LB_LogBook]
GO
/****** Object:  ForeignKey [FK_SCE_Acessorios_SCE_Equipamentos]    Script Date: 07/27/2018 09:30:30 ******/
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_SCE_Acessorios_SCE_Equipamentos]') AND parent_object_id = OBJECT_ID(N'[dbo].[SCE_Acessorios]'))
ALTER TABLE [dbo].[SCE_Acessorios]  WITH NOCHECK ADD  CONSTRAINT [FK_SCE_Acessorios_SCE_Equipamentos] FOREIGN KEY([eq_id])
REFERENCES [dbo].[SCE_Equipamentos] ([EQ_ID])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_SCE_Acessorios_SCE_Equipamentos]') AND parent_object_id = OBJECT_ID(N'[dbo].[SCE_Acessorios]'))
ALTER TABLE [dbo].[SCE_Acessorios] CHECK CONSTRAINT [FK_SCE_Acessorios_SCE_Equipamentos]
GO
/****** Object:  ForeignKey [FK_SCE_AreasUtil_Modelo_SCE_AreaUtilizacao]    Script Date: 07/27/2018 09:30:31 ******/
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_SCE_AreasUtil_Modelo_SCE_AreaUtilizacao]') AND parent_object_id = OBJECT_ID(N'[dbo].[SCE_AreasUtil_Modelo]'))
ALTER TABLE [dbo].[SCE_AreasUtil_Modelo]  WITH NOCHECK ADD  CONSTRAINT [FK_SCE_AreasUtil_Modelo_SCE_AreaUtilizacao] FOREIGN KEY([AU_ID])
REFERENCES [dbo].[SCE_AreaUtilizacao] ([AU_ID])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_SCE_AreasUtil_Modelo_SCE_AreaUtilizacao]') AND parent_object_id = OBJECT_ID(N'[dbo].[SCE_AreasUtil_Modelo]'))
ALTER TABLE [dbo].[SCE_AreasUtil_Modelo] CHECK CONSTRAINT [FK_SCE_AreasUtil_Modelo_SCE_AreaUtilizacao]
GO
/****** Object:  ForeignKey [FK_SCE_AreasUtil_Modelo_SCE_Modelos]    Script Date: 07/27/2018 09:30:31 ******/
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_SCE_AreasUtil_Modelo_SCE_Modelos]') AND parent_object_id = OBJECT_ID(N'[dbo].[SCE_AreasUtil_Modelo]'))
ALTER TABLE [dbo].[SCE_AreasUtil_Modelo]  WITH NOCHECK ADD  CONSTRAINT [FK_SCE_AreasUtil_Modelo_SCE_Modelos] FOREIGN KEY([MOD_ID])
REFERENCES [dbo].[SCE_Modelos] ([MOD_ID])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_SCE_AreasUtil_Modelo_SCE_Modelos]') AND parent_object_id = OBJECT_ID(N'[dbo].[SCE_AreasUtil_Modelo]'))
ALTER TABLE [dbo].[SCE_AreasUtil_Modelo] CHECK CONSTRAINT [FK_SCE_AreasUtil_Modelo_SCE_Modelos]
GO
/****** Object:  ForeignKey [FK_SCE_Documentacao_ENF_ID]    Script Date: 07/27/2018 09:30:32 ******/
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_SCE_Documentacao_ENF_ID]') AND parent_object_id = OBJECT_ID(N'[dbo].[SCE_Documentacao]'))
ALTER TABLE [dbo].[SCE_Documentacao]  WITH CHECK ADD  CONSTRAINT [FK_SCE_Documentacao_ENF_ID] FOREIGN KEY([ENF_ID])
REFERENCES [dbo].[SCE_Empresa_Nota_Fiscal] ([ENF_ID])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_SCE_Documentacao_ENF_ID]') AND parent_object_id = OBJECT_ID(N'[dbo].[SCE_Documentacao]'))
ALTER TABLE [dbo].[SCE_Documentacao] CHECK CONSTRAINT [FK_SCE_Documentacao_ENF_ID]
GO
/****** Object:  ForeignKey [FK_SCE_Equipamentos_SCE_Modelos]    Script Date: 07/27/2018 09:30:32 ******/
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_SCE_Equipamentos_SCE_Modelos]') AND parent_object_id = OBJECT_ID(N'[dbo].[SCE_Equipamentos]'))
ALTER TABLE [dbo].[SCE_Equipamentos]  WITH CHECK ADD  CONSTRAINT [FK_SCE_Equipamentos_SCE_Modelos] FOREIGN KEY([MOD_ID])
REFERENCES [dbo].[SCE_Modelos] ([MOD_ID])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_SCE_Equipamentos_SCE_Modelos]') AND parent_object_id = OBJECT_ID(N'[dbo].[SCE_Equipamentos]'))
ALTER TABLE [dbo].[SCE_Equipamentos] CHECK CONSTRAINT [FK_SCE_Equipamentos_SCE_Modelos]
GO
/****** Object:  ForeignKey [FK_SCE_Equipamentos_Controle_EQ_ID]    Script Date: 07/27/2018 09:30:33 ******/
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_SCE_Equipamentos_Controle_EQ_ID]') AND parent_object_id = OBJECT_ID(N'[dbo].[SCE_Equipamentos_Controle]'))
ALTER TABLE [dbo].[SCE_Equipamentos_Controle]  WITH CHECK ADD  CONSTRAINT [FK_SCE_Equipamentos_Controle_EQ_ID] FOREIGN KEY([EQ_ID])
REFERENCES [dbo].[SCE_Equipamentos] ([EQ_ID])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_SCE_Equipamentos_Controle_EQ_ID]') AND parent_object_id = OBJECT_ID(N'[dbo].[SCE_Equipamentos_Controle]'))
ALTER TABLE [dbo].[SCE_Equipamentos_Controle] CHECK CONSTRAINT [FK_SCE_Equipamentos_Controle_EQ_ID]
GO
/****** Object:  ForeignKey [FK_SCE_MODELOS_FAB_ID]    Script Date: 07/27/2018 09:30:34 ******/
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_SCE_MODELOS_FAB_ID]') AND parent_object_id = OBJECT_ID(N'[dbo].[SCE_Modelos]'))
ALTER TABLE [dbo].[SCE_Modelos]  WITH NOCHECK ADD  CONSTRAINT [FK_SCE_MODELOS_FAB_ID] FOREIGN KEY([FAB_ID])
REFERENCES [dbo].[SCE_Fabricantes] ([fab_id])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_SCE_MODELOS_FAB_ID]') AND parent_object_id = OBJECT_ID(N'[dbo].[SCE_Modelos]'))
ALTER TABLE [dbo].[SCE_Modelos] CHECK CONSTRAINT [FK_SCE_MODELOS_FAB_ID]
GO
/****** Object:  ForeignKey [FK_SCE_Movimentacao_SCE_Documentacao]    Script Date: 07/27/2018 09:30:35 ******/
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_SCE_Movimentacao_SCE_Documentacao]') AND parent_object_id = OBJECT_ID(N'[dbo].[SCE_Movimentacao]'))
ALTER TABLE [dbo].[SCE_Movimentacao]  WITH NOCHECK ADD  CONSTRAINT [FK_SCE_Movimentacao_SCE_Documentacao] FOREIGN KEY([DOC_ID])
REFERENCES [dbo].[SCE_Documentacao] ([DOC_ID])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_SCE_Movimentacao_SCE_Documentacao]') AND parent_object_id = OBJECT_ID(N'[dbo].[SCE_Movimentacao]'))
ALTER TABLE [dbo].[SCE_Movimentacao] CHECK CONSTRAINT [FK_SCE_Movimentacao_SCE_Documentacao]
GO
/****** Object:  ForeignKey [FK_SCE_Movimentacao_SCE_Equipamentos]    Script Date: 07/27/2018 09:30:35 ******/
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_SCE_Movimentacao_SCE_Equipamentos]') AND parent_object_id = OBJECT_ID(N'[dbo].[SCE_Movimentacao]'))
ALTER TABLE [dbo].[SCE_Movimentacao]  WITH CHECK ADD  CONSTRAINT [FK_SCE_Movimentacao_SCE_Equipamentos] FOREIGN KEY([EQ_ID])
REFERENCES [dbo].[SCE_Equipamentos] ([EQ_ID])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_SCE_Movimentacao_SCE_Equipamentos]') AND parent_object_id = OBJECT_ID(N'[dbo].[SCE_Movimentacao]'))
ALTER TABLE [dbo].[SCE_Movimentacao] CHECK CONSTRAINT [FK_SCE_Movimentacao_SCE_Equipamentos]
GO
/****** Object:  ForeignKey [FK_SCE_Movimentacao_SCE_Natureza_Operacao]    Script Date: 07/27/2018 09:30:35 ******/
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_SCE_Movimentacao_SCE_Natureza_Operacao]') AND parent_object_id = OBJECT_ID(N'[dbo].[SCE_Movimentacao]'))
ALTER TABLE [dbo].[SCE_Movimentacao]  WITH CHECK ADD  CONSTRAINT [FK_SCE_Movimentacao_SCE_Natureza_Operacao] FOREIGN KEY([NO_ID])
REFERENCES [dbo].[SCE_Natureza_Operacao] ([NO_ID])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_SCE_Movimentacao_SCE_Natureza_Operacao]') AND parent_object_id = OBJECT_ID(N'[dbo].[SCE_Movimentacao]'))
ALTER TABLE [dbo].[SCE_Movimentacao] CHECK CONSTRAINT [FK_SCE_Movimentacao_SCE_Natureza_Operacao]
GO
/****** Object:  ForeignKey [FK_SCE_Movimentacao_SCE_Nota_Fiscal]    Script Date: 07/27/2018 09:30:35 ******/
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_SCE_Movimentacao_SCE_Nota_Fiscal]') AND parent_object_id = OBJECT_ID(N'[dbo].[SCE_Movimentacao]'))
ALTER TABLE [dbo].[SCE_Movimentacao]  WITH NOCHECK ADD  CONSTRAINT [FK_SCE_Movimentacao_SCE_Nota_Fiscal] FOREIGN KEY([NF_ID])
REFERENCES [dbo].[SCE_Nota_Fiscal] ([NF_ID])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_SCE_Movimentacao_SCE_Nota_Fiscal]') AND parent_object_id = OBJECT_ID(N'[dbo].[SCE_Movimentacao]'))
ALTER TABLE [dbo].[SCE_Movimentacao] CHECK CONSTRAINT [FK_SCE_Movimentacao_SCE_Nota_Fiscal]
GO
/****** Object:  ForeignKey [FK_SCE_Nota_Fiscal_SCE_Empresa_Nota_Fiscal]    Script Date: 07/27/2018 09:30:36 ******/
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_SCE_Nota_Fiscal_SCE_Empresa_Nota_Fiscal]') AND parent_object_id = OBJECT_ID(N'[dbo].[SCE_Nota_Fiscal]'))
ALTER TABLE [dbo].[SCE_Nota_Fiscal]  WITH CHECK ADD  CONSTRAINT [FK_SCE_Nota_Fiscal_SCE_Empresa_Nota_Fiscal] FOREIGN KEY([ENF_ID])
REFERENCES [dbo].[SCE_Empresa_Nota_Fiscal] ([ENF_ID])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_SCE_Nota_Fiscal_SCE_Empresa_Nota_Fiscal]') AND parent_object_id = OBJECT_ID(N'[dbo].[SCE_Nota_Fiscal]'))
ALTER TABLE [dbo].[SCE_Nota_Fiscal] CHECK CONSTRAINT [FK_SCE_Nota_Fiscal_SCE_Empresa_Nota_Fiscal]
GO
/****** Object:  ForeignKey [FK_SCE_Nota_Fiscal_SCE_Empresa_Nota_Fiscal_Transportadora]    Script Date: 07/27/2018 09:30:36 ******/
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_SCE_Nota_Fiscal_SCE_Empresa_Nota_Fiscal_Transportadora]') AND parent_object_id = OBJECT_ID(N'[dbo].[SCE_Nota_Fiscal]'))
ALTER TABLE [dbo].[SCE_Nota_Fiscal]  WITH CHECK ADD  CONSTRAINT [FK_SCE_Nota_Fiscal_SCE_Empresa_Nota_Fiscal_Transportadora] FOREIGN KEY([TRANS_ID])
REFERENCES [dbo].[SCE_Empresa_Nota_Fiscal] ([ENF_ID])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_SCE_Nota_Fiscal_SCE_Empresa_Nota_Fiscal_Transportadora]') AND parent_object_id = OBJECT_ID(N'[dbo].[SCE_Nota_Fiscal]'))
ALTER TABLE [dbo].[SCE_Nota_Fiscal] CHECK CONSTRAINT [FK_SCE_Nota_Fiscal_SCE_Empresa_Nota_Fiscal_Transportadora]
GO
/****** Object:  ForeignKey [FK_SCE_Nota_Fiscal_SCE_Nota_Fiscal]    Script Date: 07/27/2018 09:30:36 ******/
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_SCE_Nota_Fiscal_SCE_Nota_Fiscal]') AND parent_object_id = OBJECT_ID(N'[dbo].[SCE_Nota_Fiscal]'))
ALTER TABLE [dbo].[SCE_Nota_Fiscal]  WITH NOCHECK ADD  CONSTRAINT [FK_SCE_Nota_Fiscal_SCE_Nota_Fiscal] FOREIGN KEY([nf_id_pai])
REFERENCES [dbo].[SCE_Nota_Fiscal] ([NF_ID])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_SCE_Nota_Fiscal_SCE_Nota_Fiscal]') AND parent_object_id = OBJECT_ID(N'[dbo].[SCE_Nota_Fiscal]'))
ALTER TABLE [dbo].[SCE_Nota_Fiscal] CHECK CONSTRAINT [FK_SCE_Nota_Fiscal_SCE_Nota_Fiscal]
GO
/****** Object:  ForeignKey [FK_SCE_PartNumberModelo_SCE_Modelos]    Script Date: 07/27/2018 09:30:36 ******/
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_SCE_PartNumberModelo_SCE_Modelos]') AND parent_object_id = OBJECT_ID(N'[dbo].[SCE_PartNumberModelo]'))
ALTER TABLE [dbo].[SCE_PartNumberModelo]  WITH NOCHECK ADD  CONSTRAINT [FK_SCE_PartNumberModelo_SCE_Modelos] FOREIGN KEY([MOD_ID])
REFERENCES [dbo].[SCE_Modelos] ([MOD_ID])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_SCE_PartNumberModelo_SCE_Modelos]') AND parent_object_id = OBJECT_ID(N'[dbo].[SCE_PartNumberModelo]'))
ALTER TABLE [dbo].[SCE_PartNumberModelo] CHECK CONSTRAINT [FK_SCE_PartNumberModelo_SCE_Modelos]
GO
/****** Object:  ForeignKey [FK_SCE_Passagem_Carga_AG_NUMERO_DEST]    Script Date: 07/27/2018 09:30:37 ******/
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_SCE_Passagem_Carga_AG_NUMERO_DEST]') AND parent_object_id = OBJECT_ID(N'[dbo].[SCE_Passagem_Carga]'))
ALTER TABLE [dbo].[SCE_Passagem_Carga]  WITH NOCHECK ADD  CONSTRAINT [FK_SCE_Passagem_Carga_AG_NUMERO_DEST] FOREIGN KEY([AG_NUMERO_DEST])
REFERENCES [dbo].[Agendamento] ([AG_NUMERO])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_SCE_Passagem_Carga_AG_NUMERO_DEST]') AND parent_object_id = OBJECT_ID(N'[dbo].[SCE_Passagem_Carga]'))
ALTER TABLE [dbo].[SCE_Passagem_Carga] CHECK CONSTRAINT [FK_SCE_Passagem_Carga_AG_NUMERO_DEST]
GO
/****** Object:  ForeignKey [FK_SCE_Passagem_Carga_AG_NUMERO_ORIG]    Script Date: 07/27/2018 09:30:37 ******/
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_SCE_Passagem_Carga_AG_NUMERO_ORIG]') AND parent_object_id = OBJECT_ID(N'[dbo].[SCE_Passagem_Carga]'))
ALTER TABLE [dbo].[SCE_Passagem_Carga]  WITH NOCHECK ADD  CONSTRAINT [FK_SCE_Passagem_Carga_AG_NUMERO_ORIG] FOREIGN KEY([AG_NUMERO_ORIG])
REFERENCES [dbo].[Agendamento] ([AG_NUMERO])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_SCE_Passagem_Carga_AG_NUMERO_ORIG]') AND parent_object_id = OBJECT_ID(N'[dbo].[SCE_Passagem_Carga]'))
ALTER TABLE [dbo].[SCE_Passagem_Carga] CHECK CONSTRAINT [FK_SCE_Passagem_Carga_AG_NUMERO_ORIG]
GO
/****** Object:  ForeignKey [FK_SCE_Passagem_Carga_EQ_ID]    Script Date: 07/27/2018 09:30:37 ******/
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_SCE_Passagem_Carga_EQ_ID]') AND parent_object_id = OBJECT_ID(N'[dbo].[SCE_Passagem_Carga]'))
ALTER TABLE [dbo].[SCE_Passagem_Carga]  WITH NOCHECK ADD  CONSTRAINT [FK_SCE_Passagem_Carga_EQ_ID] FOREIGN KEY([EQ_ID])
REFERENCES [dbo].[SCE_Equipamentos] ([EQ_ID])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_SCE_Passagem_Carga_EQ_ID]') AND parent_object_id = OBJECT_ID(N'[dbo].[SCE_Passagem_Carga]'))
ALTER TABLE [dbo].[SCE_Passagem_Carga] CHECK CONSTRAINT [FK_SCE_Passagem_Carga_EQ_ID]
GO
/****** Object:  ForeignKey [FK_SCE_Reserva_Agendamento]    Script Date: 07/27/2018 09:30:37 ******/
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_SCE_Reserva_Agendamento]') AND parent_object_id = OBJECT_ID(N'[dbo].[SCE_Reserva]'))
ALTER TABLE [dbo].[SCE_Reserva]  WITH NOCHECK ADD  CONSTRAINT [FK_SCE_Reserva_Agendamento] FOREIGN KEY([AG_NUMERO])
REFERENCES [dbo].[Agendamento] ([AG_NUMERO])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_SCE_Reserva_Agendamento]') AND parent_object_id = OBJECT_ID(N'[dbo].[SCE_Reserva]'))
ALTER TABLE [dbo].[SCE_Reserva] CHECK CONSTRAINT [FK_SCE_Reserva_Agendamento]
GO
/****** Object:  ForeignKey [FK_SCE_Reserva_Ambientes]    Script Date: 07/27/2018 09:30:37 ******/
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_SCE_Reserva_Ambientes]') AND parent_object_id = OBJECT_ID(N'[dbo].[SCE_Reserva]'))
ALTER TABLE [dbo].[SCE_Reserva]  WITH CHECK ADD  CONSTRAINT [FK_SCE_Reserva_Ambientes] FOREIGN KEY([AMB_ID])
REFERENCES [dbo].[Ambientes] ([AMB_ID])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_SCE_Reserva_Ambientes]') AND parent_object_id = OBJECT_ID(N'[dbo].[SCE_Reserva]'))
ALTER TABLE [dbo].[SCE_Reserva] CHECK CONSTRAINT [FK_SCE_Reserva_Ambientes]
GO
/****** Object:  ForeignKey [FK_SCE_Reserva_UserCRT]    Script Date: 07/27/2018 09:30:37 ******/
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_SCE_Reserva_UserCRT]') AND parent_object_id = OBJECT_ID(N'[dbo].[SCE_Reserva]'))
ALTER TABLE [dbo].[SCE_Reserva]  WITH CHECK ADD  CONSTRAINT [FK_SCE_Reserva_UserCRT] FOREIGN KEY([RES_RESPONSAVEL])
REFERENCES [dbo].[UserCRT] ([USERID])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_SCE_Reserva_UserCRT]') AND parent_object_id = OBJECT_ID(N'[dbo].[SCE_Reserva]'))
ALTER TABLE [dbo].[SCE_Reserva] CHECK CONSTRAINT [FK_SCE_Reserva_UserCRT]
GO
/****** Object:  ForeignKey [FK__SCE_Reser__AMB_I__40A6377F]    Script Date: 07/27/2018 09:30:38 ******/
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__SCE_Reser__AMB_I__40A6377F]') AND parent_object_id = OBJECT_ID(N'[dbo].[SCE_Reserva_Equipamentos]'))
ALTER TABLE [dbo].[SCE_Reserva_Equipamentos]  WITH CHECK ADD FOREIGN KEY([AMB_ID])
REFERENCES [dbo].[Ambientes] ([AMB_ID])
GO
/****** Object:  ForeignKey [FK_SCE_Reserva_Equipamentos_AG_NUMERO]    Script Date: 07/27/2018 09:30:38 ******/
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_SCE_Reserva_Equipamentos_AG_NUMERO]') AND parent_object_id = OBJECT_ID(N'[dbo].[SCE_Reserva_Equipamentos]'))
ALTER TABLE [dbo].[SCE_Reserva_Equipamentos]  WITH CHECK ADD  CONSTRAINT [FK_SCE_Reserva_Equipamentos_AG_NUMERO] FOREIGN KEY([AG_NUMERO])
REFERENCES [dbo].[Agendamento] ([AG_NUMERO])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_SCE_Reserva_Equipamentos_AG_NUMERO]') AND parent_object_id = OBJECT_ID(N'[dbo].[SCE_Reserva_Equipamentos]'))
ALTER TABLE [dbo].[SCE_Reserva_Equipamentos] CHECK CONSTRAINT [FK_SCE_Reserva_Equipamentos_AG_NUMERO]
GO
/****** Object:  ForeignKey [FK_SCE_Reserva_Equipamentos_EQ_ID]    Script Date: 07/27/2018 09:30:38 ******/
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_SCE_Reserva_Equipamentos_EQ_ID]') AND parent_object_id = OBJECT_ID(N'[dbo].[SCE_Reserva_Equipamentos]'))
ALTER TABLE [dbo].[SCE_Reserva_Equipamentos]  WITH CHECK ADD  CONSTRAINT [FK_SCE_Reserva_Equipamentos_EQ_ID] FOREIGN KEY([EQ_ID])
REFERENCES [dbo].[SCE_Equipamentos] ([EQ_ID])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_SCE_Reserva_Equipamentos_EQ_ID]') AND parent_object_id = OBJECT_ID(N'[dbo].[SCE_Reserva_Equipamentos]'))
ALTER TABLE [dbo].[SCE_Reserva_Equipamentos] CHECK CONSTRAINT [FK_SCE_Reserva_Equipamentos_EQ_ID]
GO
/****** Object:  ForeignKey [FK_SCE_Reserva_Equipamentos_Reserva_AG_NUMERO]    Script Date: 07/27/2018 09:30:38 ******/
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_SCE_Reserva_Equipamentos_Reserva_AG_NUMERO]') AND parent_object_id = OBJECT_ID(N'[dbo].[SCE_Reserva_Equipamentos]'))
ALTER TABLE [dbo].[SCE_Reserva_Equipamentos]  WITH CHECK ADD  CONSTRAINT [FK_SCE_Reserva_Equipamentos_Reserva_AG_NUMERO] FOREIGN KEY([AG_NUMERO])
REFERENCES [dbo].[SCE_Reserva] ([AG_NUMERO])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_SCE_Reserva_Equipamentos_Reserva_AG_NUMERO]') AND parent_object_id = OBJECT_ID(N'[dbo].[SCE_Reserva_Equipamentos]'))
ALTER TABLE [dbo].[SCE_Reserva_Equipamentos] CHECK CONSTRAINT [FK_SCE_Reserva_Equipamentos_Reserva_AG_NUMERO]
GO
/****** Object:  ForeignKey [FK_SERVICOS_PLATAFORMAS_SERVICOS_PLATAFORMAS_PAI]    Script Date: 07/27/2018 09:30:40 ******/
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_SERVICOS_PLATAFORMAS_SERVICOS_PLATAFORMAS_PAI]') AND parent_object_id = OBJECT_ID(N'[dbo].[Servicos_Plataformas]'))
ALTER TABLE [dbo].[Servicos_Plataformas]  WITH CHECK ADD  CONSTRAINT [FK_SERVICOS_PLATAFORMAS_SERVICOS_PLATAFORMAS_PAI] FOREIGN KEY([S_ID_PAI])
REFERENCES [dbo].[Servicos_Plataformas] ([S_ID])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_SERVICOS_PLATAFORMAS_SERVICOS_PLATAFORMAS_PAI]') AND parent_object_id = OBJECT_ID(N'[dbo].[Servicos_Plataformas]'))
ALTER TABLE [dbo].[Servicos_Plataformas] CHECK CONSTRAINT [FK_SERVICOS_PLATAFORMAS_SERVICOS_PLATAFORMAS_PAI]
GO
/****** Object:  ForeignKey [FK__Situacoes__SITUA__6E01572D]    Script Date: 07/27/2018 09:30:41 ******/
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__Situacoes__SITUA__6E01572D]') AND parent_object_id = OBJECT_ID(N'[dbo].[Situacoes_Situacoes]'))
ALTER TABLE [dbo].[Situacoes_Situacoes]  WITH NOCHECK ADD  CONSTRAINT [FK__Situacoes__SITUA__6E01572D] FOREIGN KEY([SITUACAO_PROXIMA])
REFERENCES [dbo].[Situacoes] ([ID_SITUACAO])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__Situacoes__SITUA__6E01572D]') AND parent_object_id = OBJECT_ID(N'[dbo].[Situacoes_Situacoes]'))
ALTER TABLE [dbo].[Situacoes_Situacoes] CHECK CONSTRAINT [FK__Situacoes__SITUA__6E01572D]
GO
/****** Object:  ForeignKey [FK__Situacoes__SITUA__6EF57B66]    Script Date: 07/27/2018 09:30:41 ******/
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__Situacoes__SITUA__6EF57B66]') AND parent_object_id = OBJECT_ID(N'[dbo].[Situacoes_Situacoes]'))
ALTER TABLE [dbo].[Situacoes_Situacoes]  WITH NOCHECK ADD  CONSTRAINT [FK__Situacoes__SITUA__6EF57B66] FOREIGN KEY([SITUACAO_ATUAL])
REFERENCES [dbo].[Situacoes] ([ID_SITUACAO])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__Situacoes__SITUA__6EF57B66]') AND parent_object_id = OBJECT_ID(N'[dbo].[Situacoes_Situacoes]'))
ALTER TABLE [dbo].[Situacoes_Situacoes] CHECK CONSTRAINT [FK__Situacoes__SITUA__6EF57B66]
GO
/****** Object:  ForeignKey [FK_TAREFAS_PREVISTAS_TAREFAS]    Script Date: 07/27/2018 09:30:42 ******/
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_TAREFAS_PREVISTAS_TAREFAS]') AND parent_object_id = OBJECT_ID(N'[dbo].[TAREFAS_PREVISTAS]'))
ALTER TABLE [dbo].[TAREFAS_PREVISTAS]  WITH NOCHECK ADD  CONSTRAINT [FK_TAREFAS_PREVISTAS_TAREFAS] FOREIGN KEY([TAREFA_ID])
REFERENCES [dbo].[TAREFAS] ([TAR_ID])
NOT FOR REPLICATION
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_TAREFAS_PREVISTAS_TAREFAS]') AND parent_object_id = OBJECT_ID(N'[dbo].[TAREFAS_PREVISTAS]'))
ALTER TABLE [dbo].[TAREFAS_PREVISTAS] NOCHECK CONSTRAINT [FK_TAREFAS_PREVISTAS_TAREFAS]
GO
/****** Object:  ForeignKey [FK_TAREFAS_PREVISTAS_UserCRT]    Script Date: 07/27/2018 09:30:42 ******/
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_TAREFAS_PREVISTAS_UserCRT]') AND parent_object_id = OBJECT_ID(N'[dbo].[TAREFAS_PREVISTAS]'))
ALTER TABLE [dbo].[TAREFAS_PREVISTAS]  WITH NOCHECK ADD  CONSTRAINT [FK_TAREFAS_PREVISTAS_UserCRT] FOREIGN KEY([PES_USERNAME])
REFERENCES [dbo].[UserCRT] ([USERID])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_TAREFAS_PREVISTAS_UserCRT]') AND parent_object_id = OBJECT_ID(N'[dbo].[TAREFAS_PREVISTAS]'))
ALTER TABLE [dbo].[TAREFAS_PREVISTAS] CHECK CONSTRAINT [FK_TAREFAS_PREVISTAS_UserCRT]
GO
/****** Object:  ForeignKey [FK_Tecnologia_Area_Tecnologica]    Script Date: 07/27/2018 09:30:42 ******/
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_Tecnologia_Area_Tecnologica]') AND parent_object_id = OBJECT_ID(N'[dbo].[TECNOLOGIA]'))
ALTER TABLE [dbo].[TECNOLOGIA]  WITH NOCHECK ADD  CONSTRAINT [FK_Tecnologia_Area_Tecnologica] FOREIGN KEY([AT_ID])
REFERENCES [dbo].[Area_Tecnologica] ([AT_ID])
NOT FOR REPLICATION
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_Tecnologia_Area_Tecnologica]') AND parent_object_id = OBJECT_ID(N'[dbo].[TECNOLOGIA]'))
ALTER TABLE [dbo].[TECNOLOGIA] CHECK CONSTRAINT [FK_Tecnologia_Area_Tecnologica]
GO
/****** Object:  ForeignKey [FK_Testes_Tipo_Teste]    Script Date: 07/27/2018 09:30:43 ******/
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_Testes_Tipo_Teste]') AND parent_object_id = OBJECT_ID(N'[dbo].[TESTES]'))
ALTER TABLE [dbo].[TESTES]  WITH CHECK ADD  CONSTRAINT [FK_Testes_Tipo_Teste] FOREIGN KEY([TIT_ID])
REFERENCES [dbo].[Tipo_Teste] ([TIT_ID])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_Testes_Tipo_Teste]') AND parent_object_id = OBJECT_ID(N'[dbo].[TESTES]'))
ALTER TABLE [dbo].[TESTES] CHECK CONSTRAINT [FK_Testes_Tipo_Teste]
GO
/****** Object:  ForeignKey [FK_UserCRT_Orgao]    Script Date: 07/27/2018 09:30:45 ******/
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_UserCRT_Orgao]') AND parent_object_id = OBJECT_ID(N'[dbo].[UserCRT]'))
ALTER TABLE [dbo].[UserCRT]  WITH CHECK ADD  CONSTRAINT [FK_UserCRT_Orgao] FOREIGN KEY([ORGA_ID])
REFERENCES [dbo].[Orgao] ([ORGA_ID])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_UserCRT_Orgao]') AND parent_object_id = OBJECT_ID(N'[dbo].[UserCRT]'))
ALTER TABLE [dbo].[UserCRT] CHECK CONSTRAINT [FK_UserCRT_Orgao]
GO
