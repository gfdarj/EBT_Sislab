CREATE TABLE [dbo].[FAC_FACILIDADES] (
    [CPT_ID]            INT     NOT NULL,
    [CTO_ID]            INT     NOT NULL,
    [FAC_ORDEM]         TINYINT NOT NULL,
    [FAC_ID]            INT     IDENTITY (1, 1) NOT NULL,
    [TIPO_INTERFACE_ID] INT     NULL,
    PRIMARY KEY NONCLUSTERED ([FAC_ID] ASC) WITH (FILLFACTOR = 90),
    CONSTRAINT [FK__FAC_FACIL__CPT_I__15A5FF8A] FOREIGN KEY ([CPT_ID]) REFERENCES [dbo].[FAC_COMPONENTES] ([CPT_ID]),
    CONSTRAINT [FK__FAC_FACIL__CTO_I__169A23C3] FOREIGN KEY ([CTO_ID]) REFERENCES [dbo].[FAC_CIRCUITO] ([CTO_ID])
);


GO
ALTER TABLE [dbo].[FAC_FACILIDADES] NOCHECK CONSTRAINT [FK__FAC_FACIL__CPT_I__15A5FF8A];


GO
ALTER TABLE [dbo].[FAC_FACILIDADES] NOCHECK CONSTRAINT [FK__FAC_FACIL__CTO_I__169A23C3];


GO

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
             @errmsg = 'Cannot INSERT FAC_FACILIDADES because FAC_CIRCUITO does not exist.'
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
             @errmsg = 'Cannot INSERT FAC_FACILIDADES because FAC_COMPONENTES does not exist.'
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
DISABLE TRIGGER [dbo].[tI_FAC_FACILIDADES]
    ON [dbo].[FAC_FACILIDADES];


GO

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
             @errmsg = 'Cannot cascade FAC_FACILIDADES UPDATE because more than one row has been affected.'
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
             @errmsg = 'Cannot UPDATE FAC_FACILIDADES because FAC_CIRCUITO does not exist.'
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
             @errmsg = 'Cannot UPDATE FAC_FACILIDADES because FAC_COMPONENTES does not exist.'
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
DISABLE TRIGGER [dbo].[tU_FAC_FACILIDADES]
    ON [dbo].[FAC_FACILIDADES];


GO

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

GO
DISABLE TRIGGER [dbo].[tD_FAC_FACILIDADES]
    ON [dbo].[FAC_FACILIDADES];

