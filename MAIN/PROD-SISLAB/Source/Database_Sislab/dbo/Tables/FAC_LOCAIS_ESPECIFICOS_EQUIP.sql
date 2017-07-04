CREATE TABLE [dbo].[FAC_LOCAIS_ESPECIFICOS_EQUIP] (
    [LGE_ID]   INT          NOT NULL,
    [LEE_NOME] VARCHAR (50) NOT NULL,
    [LEE_ID]   INT          IDENTITY (1, 1) NOT NULL,
    PRIMARY KEY NONCLUSTERED ([LEE_ID] ASC) WITH (FILLFACTOR = 90),
    CONSTRAINT [FK__FAC_LOCAI__LGE_I__178E47FC] FOREIGN KEY ([LGE_ID]) REFERENCES [dbo].[FAC_LOCAIS_GENERICOS_EQUIP] ([LGE_ID])
);


GO
ALTER TABLE [dbo].[FAC_LOCAIS_ESPECIFICOS_EQUIP] NOCHECK CONSTRAINT [FK__FAC_LOCAI__LGE_I__178E47FC];


GO

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
             @errmsg = 'Cannot INSERT FAC_LOCAIS_ESPECIFICOS_EQUIP because FAC_LOCAIS_GENERICOS_EQUIP does not exist.'
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
DISABLE TRIGGER [dbo].[tI_FAC_LOCAIS_ESPECIFICOS_EQUIP]
    ON [dbo].[FAC_LOCAIS_ESPECIFICOS_EQUIP];


GO

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
             @errmsg = 'Cannot DELETE FAC_LOCAIS_ESPECIFICOS_EQUIP because FAC_COMPONENTES exists.'
      goto error
    end


    /* ERwin Builtin Wed Apr 10 09:54:27 2002 */
    return
error:
    raiserror @errno @errmsg
    rollback transaction
end

GO
DISABLE TRIGGER [dbo].[tD_FAC_LOCAIS_ESPECIFICOS_EQUIP]
    ON [dbo].[FAC_LOCAIS_ESPECIFICOS_EQUIP];


GO

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
             @errmsg = 'Cannot cascade FAC_LOCAIS_ESPECIFICOS_EQUIP UPDATE because more than one row has been affected.'
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
             @errmsg = 'Cannot UPDATE FAC_LOCAIS_ESPECIFICOS_EQUIP because FAC_LOCAIS_GENERICOS_EQUIP does not exist.'
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
DISABLE TRIGGER [dbo].[tU_FAC_LOCAIS_ESPECIFICOS_EQUIP]
    ON [dbo].[FAC_LOCAIS_ESPECIFICOS_EQUIP];

