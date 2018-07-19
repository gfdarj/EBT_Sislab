CREATE TABLE [dbo].[FAC_CIRCUITO] (
    [CTO_ID]         INT           IDENTITY (1, 1) NOT NULL,
    [CTO_NOME]       VARCHAR (200) NULL,
    [TPC_ID]         INT           NOT NULL,
    [CTO_PERMANENTE] BIT           NULL,
    [CTO_ATIVADO]    BIT           NOT NULL,
    [AG_Numero]      INT           NULL,
    PRIMARY KEY NONCLUSTERED ([CTO_ID] ASC) WITH (FILLFACTOR = 90),
    CONSTRAINT [FK__FAC_CIRCU__TPC_I__6BA4D8C6] FOREIGN KEY ([TPC_ID]) REFERENCES [dbo].[FAC_TIPO_CIRCUITO] ([TPC_ID])
);


GO
ALTER TABLE [dbo].[FAC_CIRCUITO] NOCHECK CONSTRAINT [FK__FAC_CIRCU__TPC_I__6BA4D8C6];


GO

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
             @errmsg = 'Cannot cascade FAC_CIRCUITO UPDATE because more than one row has been affected.'
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
             @errmsg = 'Cannot cascade FAC_CIRCUITO UPDATE because more than one row has been affected.'
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
             @errmsg = 'Cannot UPDATE FAC_CIRCUITO because FAC_TIPO_CIRCUITO does not exist.'
      goto error
    end
  end


  /* ERwin Builtin Wed Apr 10 09:54:26 2002 */
  return
error:
    raiserror @errno @errmsg
    rollback transaction
end

GO
DISABLE TRIGGER [dbo].[tU_FAC_CIRCUITO]
    ON [dbo].[FAC_CIRCUITO];


GO

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

GO
DISABLE TRIGGER [dbo].[tD_FAC_CIRCUITO]
    ON [dbo].[FAC_CIRCUITO];


GO

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
             @errmsg = 'Cannot INSERT FAC_CIRCUITO because FAC_TIPO_CIRCUITO does not exist.'
      goto error
    end
  end


  /* ERwin Builtin Wed Apr 10 09:54:26 2002 */
  return
error:
    raiserror @errno @errmsg
    rollback transaction
end

GO
DISABLE TRIGGER [dbo].[tI_FAC_CIRCUITO]
    ON [dbo].[FAC_CIRCUITO];

