CREATE TABLE [dbo].[FAC_TIPO_COMPONENTE] (
    [TPC_ID]   INT          IDENTITY (1, 1) NOT NULL,
    [TPC_NOME] VARCHAR (50) NOT NULL,
    [FTC_ID]   INT          NOT NULL,
    [FAB_ID]   INT          NOT NULL,
    PRIMARY KEY NONCLUSTERED ([TPC_ID] ASC) WITH (FILLFACTOR = 90),
    CONSTRAINT [FK__FAC_TIPO___FAB_I__1E3B458B] FOREIGN KEY ([FAB_ID]) REFERENCES [dbo].[FAC_FABRICANTE_TIPO_COMPONENTE] ([FAB_ID]),
    CONSTRAINT [FK__FAC_TIPO___FTC_I__1F2F69C4] FOREIGN KEY ([FTC_ID]) REFERENCES [dbo].[FAC_FAMILIA_TIPO_COMPONENTE] ([FTC_ID])
);


GO
ALTER TABLE [dbo].[FAC_TIPO_COMPONENTE] NOCHECK CONSTRAINT [FK__FAC_TIPO___FAB_I__1E3B458B];


GO
ALTER TABLE [dbo].[FAC_TIPO_COMPONENTE] NOCHECK CONSTRAINT [FK__FAC_TIPO___FTC_I__1F2F69C4];


GO

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
             @errmsg = 'Cannot DELETE FAC_TIPO_COMPONENTE because FAC_COMPONENTES exists.'
      goto error
    end


    /* ERwin Builtin Wed Apr 10 09:54:28 2002 */
    return
error:
    raiserror @errno @errmsg
    rollback transaction
end

GO
DISABLE TRIGGER [dbo].[tD_FAC_TIPO_COMPONENTE]
    ON [dbo].[FAC_TIPO_COMPONENTE];


GO

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
             @errmsg = 'Cannot cascade FAC_TIPO_COMPONENTE UPDATE because more than one row has been affected.'
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
             @errmsg = 'Cannot cascade FAC_TIPO_COMPONENTE UPDATE because more than one row has been affected.'
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
             @errmsg = 'Cannot UPDATE FAC_TIPO_COMPONENTE because FAC_FABRICANTE_TIPO_COMPONENTE does not exist.'
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
             @errmsg = 'Cannot UPDATE FAC_TIPO_COMPONENTE because FAC_FAMILIA_TIPO_COMPONENTE does not exist.'
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
DISABLE TRIGGER [dbo].[tU_FAC_TIPO_COMPONENTE]
    ON [dbo].[FAC_TIPO_COMPONENTE];


GO

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
             @errmsg = 'Cannot INSERT FAC_TIPO_COMPONENTE because FAC_FABRICANTE_TIPO_COMPONENTE does not exist.'
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
             @errmsg = 'Cannot INSERT FAC_TIPO_COMPONENTE because FAC_FAMILIA_TIPO_COMPONENTE does not exist.'
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
DISABLE TRIGGER [dbo].[tI_FAC_TIPO_COMPONENTE]
    ON [dbo].[FAC_TIPO_COMPONENTE];

