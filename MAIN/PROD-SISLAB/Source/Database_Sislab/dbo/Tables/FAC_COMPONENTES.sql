CREATE TABLE [dbo].[FAC_COMPONENTES] (
    [TPC_ID]          INT           NOT NULL,
    [CPT_ID]          INT           IDENTITY (1, 1) NOT NULL,
    [CPT_NOME]        VARCHAR (200) NOT NULL,
    [LEE_ID]          INT           NOT NULL,
    [CPT_COD_SGP_SCE] VARCHAR (50)  NULL,
    [VSW_STD]         VARCHAR (100) NULL,
    [VSW_ATU]         VARCHAR (100) NULL,
    [Obs]             VARCHAR (255) NULL,
    PRIMARY KEY NONCLUSTERED ([CPT_ID] ASC) WITH (FILLFACTOR = 90),
    CONSTRAINT [FK__FAC_COMPO__LEE_I__13BDB718] FOREIGN KEY ([LEE_ID]) REFERENCES [dbo].[FAC_LOCAIS_ESPECIFICOS_EQUIP] ([LEE_ID]),
    CONSTRAINT [FK__FAC_COMPO__TPC_I__14B1DB51] FOREIGN KEY ([TPC_ID]) REFERENCES [dbo].[FAC_TIPO_COMPONENTE] ([TPC_ID])
);


GO
ALTER TABLE [dbo].[FAC_COMPONENTES] NOCHECK CONSTRAINT [FK__FAC_COMPO__LEE_I__13BDB718];


GO
ALTER TABLE [dbo].[FAC_COMPONENTES] NOCHECK CONSTRAINT [FK__FAC_COMPO__TPC_I__14B1DB51];


GO

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
             @errmsg = 'Cannot cascade FAC_COMPONENTES UPDATE because more than one row has been affected.'
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
             @errmsg = 'Cannot UPDATE FAC_COMPONENTES because FAC_LOCAIS_ESPECIFICOS_EQUIP does not exist.'
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
             @errmsg = 'Cannot UPDATE FAC_COMPONENTES because FAC_TIPO_COMPONENTE does not exist.'
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
DISABLE TRIGGER [dbo].[tU_FAC_COMPONENTES]
    ON [dbo].[FAC_COMPONENTES];


GO

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
             @errmsg = 'Cannot INSERT FAC_COMPONENTES because FAC_LOCAIS_ESPECIFICOS_EQUIP does not exist.'
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
             @errmsg = 'Cannot INSERT FAC_COMPONENTES because FAC_TIPO_COMPONENTE does not exist.'
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
DISABLE TRIGGER [dbo].[tI_FAC_COMPONENTES]
    ON [dbo].[FAC_COMPONENTES];


GO

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
             @errmsg = 'Cannot DELETE FAC_COMPONENTES because FAC_FACILIDADES exists.'
      goto error
    end


    /* ERwin Builtin Wed Apr 10 09:54:26 2002 */
    return
error:
    raiserror @errno @errmsg
    rollback transaction
end

GO
DISABLE TRIGGER [dbo].[tD_FAC_COMPONENTES]
    ON [dbo].[FAC_COMPONENTES];

