CREATE TABLE [dbo].[FAC_REL_CARACTERISTICAS_TIPO] (
    [CAR_ID]         INT      NOT NULL,
    [RCT_QUANTIDADE] SMALLINT NULL,
    [TPC_ID]         INT      NOT NULL,
    PRIMARY KEY NONCLUSTERED ([CAR_ID] ASC, [TPC_ID] ASC) WITH (FILLFACTOR = 90),
    CONSTRAINT [FK__FAC_REL_C__CAR_I__1A6AB4A7] FOREIGN KEY ([CAR_ID]) REFERENCES [dbo].[FAC_CARACTERISTICAS] ([CAR_ID]),
    CONSTRAINT [FK__FAC_REL_C__TPC_I__1B5ED8E0] FOREIGN KEY ([TPC_ID]) REFERENCES [dbo].[FAC_TIPO_COMPONENTE] ([TPC_ID])
);


GO
ALTER TABLE [dbo].[FAC_REL_CARACTERISTICAS_TIPO] NOCHECK CONSTRAINT [FK__FAC_REL_C__CAR_I__1A6AB4A7];


GO
ALTER TABLE [dbo].[FAC_REL_CARACTERISTICAS_TIPO] NOCHECK CONSTRAINT [FK__FAC_REL_C__TPC_I__1B5ED8E0];


GO

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
             @errmsg = 'Cannot INSERT FAC_REL_CARACTERISTICAS_TIPO because FAC_TIPO_COMPONENTE does not exist.'
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
             @errmsg = 'Cannot INSERT FAC_REL_CARACTERISTICAS_TIPO because FAC_CARACTERISTICAS does not exist.'
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
DISABLE TRIGGER [dbo].[tI_FAC_REL_CARACTERISTICAS_TIPO]
    ON [dbo].[FAC_REL_CARACTERISTICAS_TIPO];


GO

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
             @errmsg = 'Cannot cascade FAC_REL_CARACTERISTICAS_TIPO UPDATE because more than one row has been affected.'
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
             @errmsg = 'Cannot UPDATE FAC_REL_CARACTERISTICAS_TIPO because FAC_TIPO_COMPONENTE does not exist.'
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
             @errmsg = 'Cannot UPDATE FAC_REL_CARACTERISTICAS_TIPO because FAC_CARACTERISTICAS does not exist.'
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
DISABLE TRIGGER [dbo].[tU_FAC_REL_CARACTERISTICAS_TIPO]
    ON [dbo].[FAC_REL_CARACTERISTICAS_TIPO];


GO

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
             @errmsg = 'Cannot DELETE FAC_REL_CARACTERISTICAS_TIPO because FAC_REL_CARACTERISTICAS_FACILIDADES exists.'
      goto error
    end


    /* ERwin Builtin Wed Apr 10 09:54:27 2002 */
    return
error:
    raiserror @errno @errmsg
    rollback transaction
end

GO
DISABLE TRIGGER [dbo].[tD_FAC_REL_CARACTERISTICAS_TIPO]
    ON [dbo].[FAC_REL_CARACTERISTICAS_TIPO];

