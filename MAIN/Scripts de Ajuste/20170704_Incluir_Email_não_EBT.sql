alter table agendamento add CONSTRAINT FK_Agendamento_UserCRT_RAT foreign key (AG_RAT) references UserCRT (Userid)
go

alter table agendamento add CONSTRAINT FK_Agendamento_UserCRT_RT foreign key (AG_RESPONSAVEL) references UserCRT (USERID)
go
