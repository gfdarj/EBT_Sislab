CREATE TABLE [dbo].[FAC_REL_CIRCUITO_AGENDAMENTO] (
    [AG_NUMERO] SMALLINT NOT NULL,
    [CTO_ID]    INT      NOT NULL,
    PRIMARY KEY NONCLUSTERED ([AG_NUMERO] ASC, [CTO_ID] ASC) WITH (FILLFACTOR = 90),
    CONSTRAINT [FK__FAC_REL_C__AG_NU__76226739] FOREIGN KEY ([AG_NUMERO]) REFERENCES [dbo].[Agendamento] ([AG_NUMERO]),
    CONSTRAINT [FK__FAC_REL_C__CTO_I__1D472152] FOREIGN KEY ([CTO_ID]) REFERENCES [dbo].[FAC_CIRCUITO] ([CTO_ID])
);


GO
ALTER TABLE [dbo].[FAC_REL_CIRCUITO_AGENDAMENTO] NOCHECK CONSTRAINT [FK__FAC_REL_C__AG_NU__76226739];


GO
ALTER TABLE [dbo].[FAC_REL_CIRCUITO_AGENDAMENTO] NOCHECK CONSTRAINT [FK__FAC_REL_C__CTO_I__1D472152];


GO

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
             @errmsg = 'Cannot UPDATE FAC_REL_CIRCUITO_AGENDAMENTO because FAC_CIRCUITO does not exist.'
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
             @errmsg = 'Cannot UPDATE FAC_REL_CIRCUITO_AGENDAMENTO because Agendamento does not exist.'
      goto error
    end
  end


  /* ERwin Builtin Wed Apr 10 09:54:28 2002 */
  return
error:
    raiserror @errno @errmsg
    rollback transaction
end

GO
DISABLE TRIGGER [dbo].[tU_FAC_REL_CIRCUITO_AGENDAMENTO]
    ON [dbo].[FAC_REL_CIRCUITO_AGENDAMENTO];


GO

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
             @errmsg = 'Cannot INSERT FAC_REL_CIRCUITO_AGENDAMENTO because FAC_CIRCUITO does not exist.'
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
             @errmsg = 'Cannot INSERT FAC_REL_CIRCUITO_AGENDAMENTO because Agendamento does not exist.'
      goto error
    end
  end


  /* ERwin Builtin Wed Apr 10 09:54:27 2002 */
  return
error:
    raiserror @errno @errmsg
    rollback transaction
end

GO
DISABLE TRIGGER [dbo].[tI_FAC_REL_CIRCUITO_AGENDAMENTO]
    ON [dbo].[FAC_REL_CIRCUITO_AGENDAMENTO];

