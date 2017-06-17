
insert into Agenda_Servicos_Plataforma
	select * from SISLAB_DADOS_PROD..Agenda_Servicos_Plataforma
go

set identity_insert Agendamento on
go
insert into Agendamento (AG_NUMERO,TA_ID,AT_ID,AG_DATASOLICITACAO,AG_DATAINICIO,AG_DATATERMINO,AG_RESPONSAVEL,AG_RAT,AG_SIGILO
			,AG_FLAGREMARCACAO,AG_OBJETIVO,AG_MOTIVO,AG_USERNAME,AG_RECEBEMAIL,AG_ORGAO,AG_CLIENTEEXTERNO,AG_RETIFICACAO
			,AG_RELAT_RAT,AG_RELAT_RT,AG_REPETIDO,AG_AMBIENTE,AG_RECURSOS,AG_OBSERVACAO,AG_NECESSITA_OS,AG_EXECUTANTE
			,AG_RETORNOCLIENTE,AG_PLANODEMETAS,TEC_ID,AG_SOLICITOUCANCELAMENTO,AG_TITULO,AG_VALORCONTRATOCLIENTE, AG_PRIORIDADE )
	select AG_NUMERO,TA_ID,AT_ID,AG_DATASOLICITACAO,AG_DATAINICIO,AG_DATATERMINO,AG_RESPONSAVEL,AG_RAT,AG_SIGILO
			,AG_FLAGREMARCACAO,AG_OBJETIVO,AG_MOTIVO,AG_USERNAME,AG_RECEBEMAIL,AG_ORGAO,AG_CLIENTEEXTERNO,AG_RETIFICACAO
			,AG_RELAT_RAT,AG_RELAT_RT,AG_REPETIDO,AG_AMBIENTE,AG_RECURSOS,AG_OBSERVACAO,AG_NECESSITA_OS,AG_EXECUTANTE
			,AG_RETORNOCLIENTE,AG_PLANODEMETAS,TEC_ID,AG_SOLICITOUCANCELAMENTO,AG_TITULO,AG_VALORCONTRATOCLIENTE, AG_PRIORIDADE 
		from SISLAB_DADOS_PROD..Agendamento
go
set identity_insert Agendamento off
go

set identity_insert Ambientes on
go
insert into ambientes (AMB_ID,AMB_NOME,AMB_USADOPORAG)
		select AMB_ID,AMB_NOME,AMB_USADOPORAG
		from SISLAB_DADOS_PROD..ambientes
go
set identity_insert Ambientes off
go

set identity_insert Area_Tecnologica on
go
insert into Area_Tecnologica (AT_ID, AT_NOME)
	select AT_ID, AT_NOME
	from SISLAB_DADOS_PROD..Area_Tecnologica
set identity_insert Area_Tecnologica off
go

set identity_insert Arquivos on
go
insert into Arquivos (ARQ_CODARQ,ARQ_CODARQTIPO,ARQ_LINK,ARQ_NOMEARQ,ARQ_RESPONSAVEL,ARQ_IDORGAO,ARQ_OBSERVACAO,ARQ_VINCULACAO,ARQ_VERSAO,ARQ_OCULTAR,ARQ_DATAATUALIZACAO,IPCADASTRO,ARQ_DATAAPROVACAO,USERIDCADASTRO,ARQ_DESCRICAO,ARQ_IDSITUACAO,ARQ_OS,ARQ_O1,ARQ_O2,ARQ_O3,ARQ_VALIDACAO,ARQ_NOTIFICACAOEXPIRACAO)
	select ARQ_CODARQ,ARQ_CODARQTIPO,ARQ_LINK,ARQ_NOMEARQ,ARQ_RESPONSAVEL,ARQ_IDORGAO,ARQ_OBSERVACAO,ARQ_VINCULACAO,ARQ_VERSAO,ARQ_OCULTAR,ARQ_DATAATUALIZACAO,IPCADASTRO,ARQ_DATAAPROVACAO,USERIDCADASTRO,ARQ_DESCRICAO,ARQ_IDSITUACAO,ARQ_OS,ARQ_O1,ARQ_O2,ARQ_O3,ARQ_VALIDACAO,ARQ_NOTIFICACAOEXPIRACAO
	from SISLAB_DADOS_PROD..Arquivos
set identity_insert Arquivos off
go

insert into diagramas
	select *
	from SISLAB_DADOS_PROD..diagramas
go

set identity_insert DisposicaoLB on
go
insert into DisposicaoLB (D_ID,LB_ID,D_DISPOSICAO,D_EXECUTANTE,D_PRAZO,D_DATACONCLUSAO,D_EFICACIA)
	select D_ID,LB_ID,D_DISPOSICAO,D_EXECUTANTE,D_PRAZO,D_DATACONCLUSAO,D_EFICACIA
	from SISLAB_DADOS_PROD..DisposicaoLB
go
set identity_insert DisposicaoLB off
go


insert into equipeembratel
	select *
	from SISLAB_DADOS_PROD..equipeembratel
go

/*
set identity_insert FAC_CARACTERISTICAS on
set identity_insert FAC_CIRCUITO on
set identity_insert FAC_COMPONENTES on
set identity_insert FAC_FABRICANTE_TIPO_COMPONENTE on
set identity_insert FAC_FACILIDADES on
set identity_insert FAC_FAMILIA_TIPO_COMPONENTE on
set identity_insert FAC_LOCAIS_ESPECIFICOS_EQUIP on
set identity_insert FAC_LOCAIS_GENERICOS_EQUIP on
set identity_insert FAC_TIPO_CIRCUITO on
set identity_insert FAC_TIPO_COMPONENTE on
set identity_insert FAC_TIPO_INTERFACE on
set identity_insert FERIADO on
*/

set identity_insert HISTORICO_ARQUIVOS on
go
insert into HISTORICO_ARQUIVOS (HA_ID,HA_CODARQ,HA_USUARIO,HA_DATAATUALIZACAO,HA_ACAO)
	select HA_ID,HA_CODARQ,HA_USUARIO,HA_DATAATUALIZACAO,HA_ACAO
	from SISLAB_DADOS_PROD..HISTORICO_ARQUIVOS
go
set identity_insert HISTORICO_ARQUIVOS off
go

insert into HISTORICO_DATAS
	select *
	from SISLAB_DADOS_PROD..HISTORICO_DATAS
go

set identity_insert Historico_Eventos on
go
insert into Historico_Eventos (HE_ID,HE_RESPONSAVEL,ID_SITUACAO,AG_NUMERO,HE_DATAINICIO,HE_DATATERMINO,HE_MOTIVO)
	select HE_ID,HE_RESPONSAVEL,ID_SITUACAO,AG_NUMERO,HE_DATAINICIO,HE_DATATERMINO,HE_MOTIVO
	from SISLAB_DADOS_PROD..Historico_Eventos
go
set identity_insert Historico_Eventos off
go

set identity_insert Historico_EventosOS on
go
insert into Historico_EventosOS (HEOS_ID,HEOS_RESPONSAVEL,AG_NUMERO,ID_SITUACAO,OS_ID,HEOS_DATAINICIO,HEOS_DATATERMINO,HEOS_MOTIVO)
	select HEOS_ID,HEOS_RESPONSAVEL,AG_NUMERO,ID_SITUACAO,OS_ID,HEOS_DATAINICIO,HEOS_DATATERMINO,HEOS_MOTIVO
	from SISLAB_DADOS_PROD..Historico_EventosOS
go
set identity_insert Historico_EventosOS off
go

set identity_insert HISTORICO_PLATAFORMA_EQUIPAMENTOS on
go
insert into HISTORICO_PLATAFORMA_EQUIPAMENTOS (HPE_ID,HPE_DATAALTERACAO,HPE_TIPOMOVIMENTO,EQ_ID,S_ID)
	select HPE_ID,HPE_DATAALTERACAO,HPE_TIPOMOVIMENTO,EQ_ID,S_ID
	from SISLAB_DADOS_PROD..HISTORICO_PLATAFORMA_EQUIPAMENTOS
go
set identity_insert HISTORICO_PLATAFORMA_EQUIPAMENTOS off
go

set identity_insert LB_ACOESTOMADAS on
go
insert into LB_ACOESTOMADAS (ACT_ID,ACT_LB,ACT_DESCRICAO,ACT_EXECUTANTE,ACT_PRAZO,ACT_DATACONCLUSAO,ACT_EFICACIA,ACT_OBS,ACT_TIPOACAO,ACT_RESPONSAVEL)
	select ACT_ID,ACT_LB,ACT_DESCRICAO,ACT_EXECUTANTE,ACT_PRAZO,ACT_DATACONCLUSAO,ACT_EFICACIA,ACT_OBS,ACT_TIPOACAO,ACT_RESPONSAVEL
	from SISLAB_DADOS_PROD..LB_ACOESTOMADAS
go
set identity_insert LB_ACOESTOMADAS off
go


set identity_insert LB_ACOESTOMADAS_ARQUIVOS on
go
insert into LB_ACOESTOMADAS_ARQUIVOS (ACA_ID,ACT_ID,LB_ID,ACA_LINK,ACA_USUARIOCADASTROU,ACA_DATACADASTRO)
	select ACA_ID,ACT_ID,LB_ID,ACA_LINK,ACA_USUARIOCADASTROU,ACA_DATACADASTRO
	from SISLAB_DADOS_PROD..LB_ACOESTOMADAS_ARQUIVOS
go
set identity_insert LB_ACOESTOMADAS_ARQUIVOS off
go


set identity_insert LB_LogBook on
go
insert into LB_LogBook (LB_ID,LBTO_ID,LB_DATAHORACAD,LB_USERNAMECAD,LB_IPCAD,LB_DESCRICAO,LB_OBSERVACAO,LB_PROVIDENCIAS,LB_CONCLUIDO,LB_CONCLUIDOGQ,LB_DATAHORAOCO,LB_PRAZO,LB_RESPEXEC,LB_EXECUTOR,LB_OBSERVACOESGQ,LB_OBSERVACOESRES,LB_PENDENCIAS,LB_ANALISEGQ,LB_DOCASSOCIADO,LB_REQUISITONORMA,LB_CRITICIDADE,LB_OPM,LB_RATRESPONSAVEL,LB_DATAHORACONCLUSAO)
	select LB_ID,LBTO_ID,LB_DATAHORACAD,LB_USERNAMECAD,LB_IPCAD,LB_DESCRICAO,LB_OBSERVACAO,LB_PROVIDENCIAS,LB_CONCLUIDO,LB_CONCLUIDOGQ,LB_DATAHORAOCO,LB_PRAZO,LB_RESPEXEC,LB_EXECUTOR,LB_OBSERVACOESGQ,LB_OBSERVACOESRES,LB_PENDENCIAS,LB_ANALISEGQ,LB_DOCASSOCIADO,LB_REQUISITONORMA,LB_CRITICIDADE,LB_OPM,LB_RATRESPONSAVEL,LB_DATAHORACONCLUSAO
	from SISLAB_DADOS_PROD..LB_LogBook
go
set identity_insert LB_LogBook off
go

insert into LB_TIPOACAOTOMADA
	select *
	from SISLAB_DADOS_PROD..LB_TIPOACAOTOMADA
go


set identity_insert LB_TipoOcorrencia on
go
insert into LB_TipoOcorrencia (LBTO_ID,LBTO_DESCRICAO)
	select LBTO_ID,LBTO_DESCRICAO
	from SISLAB_DADOS_PROD..LB_TipoOcorrencia
go
set identity_insert LB_TipoOcorrencia off
go


set identity_insert Mensagem on
go
insert into Mensagem (CodMensagem,DeMensagem,TextoMensagem)
	select CodMensagem,DeMensagem,TextoMensagem
	from SISLAB_DADOS_PROD..Mensagem
go
set identity_insert Mensagem off
go

insert into ordem_de_servico
	select * from SISLAB_DADOS_PROD..ordem_de_servico
go


set identity_insert Orgao on
go
insert into Orgao (ORGA_ID,ORGA_SIGLA,ORGA_DESCRICAO,ORGA_FAX,ORGA_RAMAL,ORGA_EXIBIR,ORGA_TIPO,ORGA_USERIDCHEFE,ORGA_HIERARQUIA)
	select ORGA_ID,ORGA_SIGLA,ORGA_DESCRICAO,ORGA_FAX,ORGA_RAMAL,ORGA_EXIBIR,ORGA_TIPO,ORGA_USERIDCHEFE,ORGA_HIERARQUIA
	from SISLAB_DADOS_PROD..Orgao
go
set identity_insert Orgao off
go


set identity_insert Participantes_Externos on
go
insert into Participantes_Externos (PE_ID,PE_NOME,AG_NUMERO,PE_EMPRESA,PE_MOTIVO,PE_USERNAME,PE_QUEMINCLUIU)
	select PE_ID,PE_NOME,AG_NUMERO,PE_EMPRESA,PE_MOTIVO,PE_USERNAME,PE_QUEMINCLUIU
	from SISLAB_DADOS_PROD..Participantes_Externos
go
set identity_insert Participantes_Externos off
go


insert into perfil_sce
	select * from SISLAB_DADOS_PROD..perfil_sce
go


set identity_insert PesquisaSatisfacao on
go
insert into PesquisaSatisfacao (PSQ_Id,PSQ_UsernameCadastro,PSQ_IPCadastro,PSQ_DataHoraCadastro,PSQ_NAg,PSQ_Nome,PSQ_Telefone,PSQ_Email,PSQ_OrgaoEmpresa,PSQ_Origem,PSQ_R1,PSQ_R2,PSQ_R3,PSQ_R4,PSQ_R5,PSQ_R6,PSQ_R7,PSQ_R8,PSQ_R9,PSQ_R10,PSQ_R11,PSQ_C1,PSQ_C2,PSQ_C3,PSQ_C4,PSQ_C5,PSQ_C6,PSQ_C7,PSQ_C8,PSQ_C9,PSQ_C10,PSQ_C11,PSQ_C_3,PSQ_C_4)
	select PSQ_Id,PSQ_UsernameCadastro,PSQ_IPCadastro,PSQ_DataHoraCadastro,PSQ_NAg,PSQ_Nome,PSQ_Telefone,PSQ_Email,PSQ_OrgaoEmpresa,PSQ_Origem,PSQ_R1,PSQ_R2,PSQ_R3,PSQ_R4,PSQ_R5,PSQ_R6,PSQ_R7,PSQ_R8,PSQ_R9,PSQ_R10,PSQ_R11,PSQ_C1,PSQ_C2,PSQ_C3,PSQ_C4,PSQ_C5,PSQ_C6,PSQ_C7,PSQ_C8,PSQ_C9,PSQ_C10,PSQ_C11,PSQ_C_3,PSQ_C_4
	from SISLAB_DADOS_PROD..PesquisaSatisfacao
go
set identity_insert PesquisaSatisfacao off
go


set identity_insert Plantao on
go
insert into Plantao (PLA_CODNOTICIA,PLA_TITNOTICIA,PLA_DATAINICIO,PLA_DATATERMINO,PLA_USERID,PLA_DATACADASTRO,PLA_LINK)
	select PLA_CODNOTICIA,PLA_TITNOTICIA,PLA_DATAINICIO,PLA_DATATERMINO,PLA_USERID,PLA_DATACADASTRO,PLA_LINK
	from SISLAB_DADOS_PROD..Plantao
go
set identity_insert Plantao off
go


insert into PLATAFORMA_EQUIPAMENTOS
	select * from SISLAB_DADOS_PROD..PLATAFORMA_EQUIPAMENTOS
go


set identity_insert Reserva_ambientes on
go
insert into Reserva_ambientes (RAM_ID,RAM_DataInicio,RAM_DataFim,RAM_Horario,RAM_Titulo,RAM_Descricao,AMB_ID,RAM_Contato,RAM_Responsavel,RAM_AS)
	select RAM_ID,RAM_DataInicio,RAM_DataFim,RAM_Horario,RAM_Titulo,RAM_Descricao,AMB_ID,RAM_Contato,RAM_Responsavel,RAM_AS
	from SISLAB_DADOS_PROD..Reserva_ambientes
go
set identity_insert Reserva_ambientes off
go


set identity_insert ResolucaoLB on
go
insert into ResolucaoLB (R_ID,LB_ID,R_NOME,R_NUMERO)
	select R_ID,LB_ID,R_NOME,R_NUMERO
	from SISLAB_DADOS_PROD..ResolucaoLB
go
set identity_insert ResolucaoLB off
go

insert into SCE_Acessorios
	select * from SISLAB_DADOS_PROD..SCE_Acessorios
go


set identity_insert SCE_AreasUtil_Modelo on
go
insert into SCE_AreasUtil_Modelo (AU_ID,MOD_ID,id)
	select AU_ID,MOD_ID,id
	from SISLAB_DADOS_PROD..SCE_AreasUtil_Modelo
go
set identity_insert SCE_AreasUtil_Modelo off
go


set identity_insert SCE_AreaUtilizacao on
go
insert into SCE_AreaUtilizacao (COD_SGP,AU_ID,AU_DESCRICAO,AU_CODAREAUTIL)
	select COD_SGP,AU_ID,AU_DESCRICAO,AU_CODAREAUTIL
	from SISLAB_DADOS_PROD..SCE_AreaUtilizacao
go
set identity_insert SCE_AreaUtilizacao off
go

insert into SCE_Documentacao
	select * from SISLAB_DADOS_PROD..SCE_Documentacao
go


set identity_insert SCE_Empresa_Nota_Fiscal on
go
insert into SCE_Empresa_Nota_Fiscal (ENF_OBSERVACAO,ENF_CONTATO,ENF_FAX,ENF_TEL,ENF_CEP,ENF_UF,ENF_CIDADE,ENF_ENDERECO,ENF_CNPJ,ENF_IE,ENF_NOME,ENF_ID,enf_ddd,enf_ddd_fax,enf_email,enf_cpf,ENF_TIPOEMPRESA)
	select ENF_OBSERVACAO,ENF_CONTATO,ENF_FAX,ENF_TEL,ENF_CEP,ENF_UF,ENF_CIDADE,ENF_ENDERECO,ENF_CNPJ,ENF_IE,ENF_NOME,ENF_ID,enf_ddd,enf_ddd_fax,enf_email,enf_cpf,ENF_TIPOEMPRESA
	from SISLAB_DADOS_PROD..SCE_Empresa_Nota_Fiscal
go
set identity_insert SCE_Empresa_Nota_Fiscal off
go


set identity_insert SCE_Equipamentos on
go
insert into SCE_Equipamentos (EQ_ID,EQ_CODIGOBARRAS,EQ_NUMEROSERIE,EQ_LOCALIZACAO,MOD_ID,EQ_OBS,STATUS,EQ_OPER_DELTA,EQ_OPER_UMIDADE,EQ_OPER_WARMUP,EQ_ARMA_DELTA,EQ_ARMA_UMIDADE,EQ_MANUT_PREVENTIVA,EQ_INSTRUMENTAL,EQ_PROPRIEDADE,EQ_CONFORME,EQ_DT_ULT_INVENTARIO,EQ_FREQ_CALIBRACAO,EQ_CODIGOBARRASANTERIOR)
	select EQ_ID,EQ_CODIGOBARRAS,EQ_NUMEROSERIE,EQ_LOCALIZACAO,MOD_ID,EQ_OBS,STATUS,EQ_OPER_DELTA,EQ_OPER_UMIDADE,EQ_OPER_WARMUP,EQ_ARMA_DELTA,EQ_ARMA_UMIDADE,EQ_MANUT_PREVENTIVA,EQ_INSTRUMENTAL,EQ_PROPRIEDADE,EQ_CONFORME,EQ_DT_ULT_INVENTARIO,EQ_FREQ_CALIBRACAO,EQ_CODIGOBARRASANTERIOR
	from SISLAB_DADOS_PROD..SCE_Equipamentos
go
set identity_insert SCE_Equipamentos off
go


set identity_insert SCE_Equipamentos_Controle on
go
insert into SCE_Equipamentos_Controle (EQC_ID,EQ_ID,EQC_DIAS,EQC_DATA,EQC_REGISTRO,EQC_RESPONSAVEL,EQC_TIPO)
	select EQC_ID,EQ_ID,EQC_DIAS,EQC_DATA,EQC_REGISTRO,EQC_RESPONSAVEL,EQC_TIPO
	from SISLAB_DADOS_PROD..SCE_Equipamentos_Controle
go
set identity_insert SCE_Equipamentos_Controle off
go


set identity_insert SCE_Fabricantes on
go
insert into SCE_Fabricantes (fab_id,fab_nome)
	select fab_id,fab_nome
	from SISLAB_DADOS_PROD..SCE_Fabricantes
go
set identity_insert SCE_Fabricantes off
go


set identity_insert SCE_Historico on
go
insert into SCE_Historico (id,id_usuario,acao,data,MODULO)
	select id,id_usuario,acao,data,MODULO
	from SISLAB_DADOS_PROD..SCE_Historico
go
set identity_insert SCE_Historico off
go


set identity_insert SCE_Historico_Movimentacao on
go
insert into SCE_Historico_Movimentacao (ID,MOV_ID,DATA_OLD,USUARIO,TEXTO,no_id,tipo_id,eq_id,DATA_OLD_COPIA,DATA)
	select ID,MOV_ID,DATA_OLD,USUARIO,TEXTO,no_id,tipo_id,eq_id,DATA_OLD_COPIA,DATA
	from SISLAB_DADOS_PROD..SCE_Historico_Movimentacao
go
set identity_insert SCE_Historico_Movimentacao off
go


set identity_insert SCE_Modelos on
go
insert into SCE_Modelos (COD_SGP,MOD_ID,MOD_CODNOME,MOD_NET,MOD_OBS,TIPO_ID,FAB_ID,sgp,mod_descricao)
	select COD_SGP,MOD_ID,MOD_CODNOME,MOD_NET,MOD_OBS,TIPO_ID,FAB_ID,sgp,mod_descricao
	from SISLAB_DADOS_PROD..SCE_Modelos
go
set identity_insert SCE_Modelos off
go


set identity_insert SCE_Movimentacao on
go
insert into SCE_Movimentacao (MOV_ID,EQ_ID,NO_ID,MOV_DESPACHANTE,MOV_SOLICITANTE,TIPO,CDE,ASA,RESERVA,SAIDA,NF_ID,EXCLUIDA,DOC_ID,MOV_DATA,MOV_PASSAGEM,FL_CALIBRACAO)
	select MOV_ID,EQ_ID,NO_ID,MOV_DESPACHANTE,MOV_SOLICITANTE,TIPO,CDE,ASA,RESERVA,SAIDA,NF_ID,EXCLUIDA,DOC_ID,MOV_DATA,MOV_PASSAGEM,FL_CALIBRACAO
	from SISLAB_DADOS_PROD..SCE_Movimentacao
go
set identity_insert SCE_Movimentacao off
go


set identity_insert SCE_Natureza_Operacao on
go
insert into SCE_Natureza_Operacao (NO_DESCRICAO,NO_ID,NO_TIPO,CDE,DEFEITO,PRAZO,ASA)
	select NO_DESCRICAO,NO_ID,NO_TIPO,CDE,DEFEITO,PRAZO,ASA
	from SISLAB_DADOS_PROD..SCE_Natureza_Operacao
go
set identity_insert SCE_Natureza_Operacao off
go


set identity_insert SCE_Nota_Fiscal on
go
insert into SCE_Nota_Fiscal (NF_NUMERONOTA,NF_QTDEVOLUMES,NF_CFOP,NF_VALORTOTAL,NF_DATAEMISSAO,NF_NCONHECIMENTO,NF_TIPO,TRANS_ID,ENF_ID,NF_ID,nf_descriminacao,no_id,nf_id_pai,nf_validade,nf_data,nf_recebimento,nf_obs,NF_ACEITE,NF_VOLUME,NF_CARTA,NF_INTEGRIDADE,NF_DEVOLUCAOCOMPLETA,NF_VALORTOTAL_CHAR)
	select NF_NUMERONOTA,NF_QTDEVOLUMES,NF_CFOP,NF_VALORTOTAL,NF_DATAEMISSAO,NF_NCONHECIMENTO,NF_TIPO,TRANS_ID,ENF_ID,NF_ID,nf_descriminacao,no_id,nf_id_pai,nf_validade,nf_data,nf_recebimento,nf_obs,NF_ACEITE,NF_VOLUME,NF_CARTA,NF_INTEGRIDADE,NF_DEVOLUCAOCOMPLETA,NF_VALORTOTAL_CHAR
	from SISLAB_DADOS_PROD..SCE_Nota_Fiscal
go
set identity_insert SCE_Nota_Fiscal off
go


set identity_insert SCE_PartNumberModelo on
go
insert into SCE_PartNumberModelo (MOD_ID,PN_PARTNUMBER,id)
	select MOD_ID,PN_PARTNUMBER,id
	from SISLAB_DADOS_PROD..SCE_PartNumberModelo
go
set identity_insert SCE_PartNumberModelo off
go

insert into SCE_Passagem_Carga
	select * from SISLAB_DADOS_PROD..SCE_Passagem_Carga
go
insert into SCE_Rel_Gerencial_Anual_NF_Mov
	select * from SISLAB_DADOS_PROD..SCE_Rel_Gerencial_Anual_NF_Mov
go
insert into SCE_Reserva
	select * from SISLAB_DADOS_PROD..SCE_Reserva
go
insert into SCE_Reserva_Equipamentos
	select * from SISLAB_DADOS_PROD..SCE_Reserva_Equipamentos
go


set identity_insert SCE_Tipo_NO on
go
insert into SCE_Tipo_NO (id,no_id,tipo_id)
	select id,no_id,tipo_id
	from SISLAB_DADOS_PROD..SCE_Tipo_NO
go
set identity_insert SCE_Tipo_NO off
go


insert into SCE_TipoMovimentacao
	select * from SISLAB_DADOS_PROD..SCE_TipoMovimentacao
go


set identity_insert SCE_Tipos on
go
insert into SCE_Tipos (TIPO_ID,TIPO_APELIDO,TIPO_SUPERTIPO,TIPO_DESCRICAO,COD_SGP,SGP)
	select TIPO_ID,TIPO_APELIDO,TIPO_SUPERTIPO,TIPO_DESCRICAO,COD_SGP,SGP
	from SISLAB_DADOS_PROD..SCE_Tipos
go
set identity_insert SCE_Tipos off
go


insert into SCE_Usuarios
	select * from SISLAB_DADOS_PROD..SCE_Usuarios
go


set identity_insert Servicos_Plataformas on
go
insert into Servicos_Plataformas (S_ID,S_TIPO,S_DESCRICAO,S_SERVICO,S_ID_PAI)
	select S_ID,S_TIPO,S_DESCRICAO,S_SERVICO,S_ID_PAI
	from SISLAB_DADOS_PROD..Servicos_Plataformas
go
set identity_insert Servicos_Plataformas off
go


insert into SituacaoArquivo
	select * from SISLAB_DADOS_PROD..SituacaoArquivo
go


set identity_insert Situacoes on
go
insert into Situacoes (ID_SITUACAO,S_DESCRICAO,S_OS,S_MENSAGEM)
	select ID_SITUACAO,S_DESCRICAO,S_OS,S_MENSAGEM
	from SISLAB_DADOS_PROD..Situacoes
go
set identity_insert Situacoes off
go


insert into Situacoes_Situacoes
	select * from SISLAB_DADOS_PROD..Situacoes_Situacoes
go


set identity_insert TAREFAS on
go
insert into TAREFAS (TAR_ID,TAR_DESCRICAO)
	select TAR_ID,TAR_DESCRICAO
	from SISLAB_DADOS_PROD..TAREFAS
go
set identity_insert TAREFAS off
go


set identity_insert TAREFAS_PREVISTAS on
go
insert into TAREFAS_PREVISTAS (TAREFA_ID,TP_ID,TP_DATAINICIAL,TP_DATAFINAL,TP_OBSERVACAO,TAREFA_TIPO,PES_USERNAME)
	select TAREFA_ID,TP_ID,TP_DATAINICIAL,TP_DATAFINAL,TP_OBSERVACAO,TAREFA_TIPO,PES_USERNAME
	from SISLAB_DADOS_PROD..TAREFAS_PREVISTAS
go
set identity_insert TAREFAS_PREVISTAS off
go


set identity_insert TECNOLOGIA on
go
insert into TECNOLOGIA (TEC_ID,TEC_NOME,AT_ID)
	select TEC_ID,TEC_NOME,AT_ID
	from SISLAB_DADOS_PROD..TECNOLOGIA
go
set identity_insert TECNOLOGIA off
go


set identity_insert TESTES on
go
insert into TESTES (T_ID,T_TITULO,T_DESCRICAO,T_DISPONIVEL,T_TIPO,T_OBSERVACAO,TIT_ID,T_PERIODOREPETICAO)
	select T_ID,T_TITULO,T_DESCRICAO,T_DISPONIVEL,T_TIPO,T_OBSERVACAO,TIT_ID,T_PERIODOREPETICAO
	from SISLAB_DADOS_PROD..TESTES
go
set identity_insert TESTES off
go


set identity_insert Tipo_Atividade on
go
insert into Tipo_Atividade (TA_ID,TA_DESCRICAO,TA_FLAGTABELA)
	select TA_ID,TA_DESCRICAO,TA_FLAGTABELA
	from SISLAB_DADOS_PROD..Tipo_Atividade
go
set identity_insert Tipo_Atividade off
go


insert into Tipo_Sigilo
	select * from SISLAB_DADOS_PROD..Tipo_Sigilo
go


set identity_insert Tipo_Teste on
go
insert into Tipo_Teste (TIT_ID,TIT_DESCRICAO)
	select TIT_ID,TIT_DESCRICAO
	from SISLAB_DADOS_PROD..Tipo_Teste
go
set identity_insert Tipo_Teste off
go


set identity_insert TipoArquivo on
go
insert into TipoArquivo (TAR_CODTIPOARQUIVO,TAR_TIPOARQUIVO,TAR_CONFIDENCIAL,TAR_SENHA,TAR_DocQual)
	select TAR_CODTIPOARQUIVO,TAR_TIPOARQUIVO,TAR_CONFIDENCIAL,TAR_SENHA,TAR_DocQual
	from SISLAB_DADOS_PROD..TipoArquivo
go
set identity_insert TipoArquivo off
go


set identity_insert Transporte on
go
insert into Transporte (CodHorario,DeHoraIda,DeHoraVolta)
	select CodHorario,DeHoraIda,DeHoraVolta
	from SISLAB_DADOS_PROD..Transporte
go
set identity_insert Transporte off
go


insert into UserCRT
	select * from SISLAB_DADOS_PROD..UserCRT
go

