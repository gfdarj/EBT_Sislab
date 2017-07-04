CREATE TABLE [dbo].[FAC_REL_CARACTERISTICAS_FACILIDADES] (
    [CAR_ID]                           INT           NOT NULL,
    [TPC_ID]                           INT           NOT NULL,
    [RCF_IDENTIFICADOR_CARACTERISTICA] VARCHAR (255) NOT NULL,
    [FAC_ID]                           INT           NOT NULL,
    CONSTRAINT [PK__FAC_REL_CARACTER__630F92C5] PRIMARY KEY NONCLUSTERED ([CAR_ID] ASC, [TPC_ID] ASC, [FAC_ID] ASC) WITH (FILLFACTOR = 90),
    CONSTRAINT [FK__FAC_REL_C__FAC_I__7251D655] FOREIGN KEY ([FAC_ID]) REFERENCES [dbo].[FAC_FACILIDADES] ([FAC_ID]),
    CONSTRAINT [FK__FAC_REL_CARACTER__715DB21C] FOREIGN KEY ([CAR_ID], [TPC_ID]) REFERENCES [dbo].[FAC_REL_CARACTERISTICAS_TIPO] ([CAR_ID], [TPC_ID])
);


GO
ALTER TABLE [dbo].[FAC_REL_CARACTERISTICAS_FACILIDADES] NOCHECK CONSTRAINT [FK__FAC_REL_C__FAC_I__7251D655];


GO
ALTER TABLE [dbo].[FAC_REL_CARACTERISTICAS_FACILIDADES] NOCHECK CONSTRAINT [FK__FAC_REL_CARACTER__715DB21C];


GO
create trigger [dbo].[tI_FAC_REL_CARACTERISTICAS_FACILIDADES] on [dbo].[FAC_REL_CARACTERISTICAS_FACILIDADES] for INSERT as
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
             @errmsg = 'Cannot INSERT FAC_REL_CARACTERISTICAS_FACILIDADES because FAC_REL_CARACTERISTICAS_TIPO does not exist.'
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
             @errmsg = 'Cannot INSERT FAC_REL_CARACTERISTICAS_FACILIDADES because FAC_FACILIDADES does not exist.'
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
DISABLE TRIGGER [dbo].[tI_FAC_REL_CARACTERISTICAS_FACILIDADES]
    ON [dbo].[FAC_REL_CARACTERISTICAS_FACILIDADES];


GO
create trigger [dbo].[tU_FAC_REL_CARACTERISTICAS_FACILIDADES] on [dbo].[FAC_REL_CARACTERISTICAS_FACILIDADES] for UPDATE as
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
             @errmsg = 'Cannot UPDATE FAC_REL_CARACTERISTICAS_FACILIDADES because FAC_REL_CARACTERISTICAS_TIPO does not exist.'
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
             @errmsg = 'Cannot UPDATE FAC_REL_CARACTERISTICAS_FACILIDADES because FAC_FACILIDADES does not exist.'
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
DISABLE TRIGGER [dbo].[tU_FAC_REL_CARACTERISTICAS_FACILIDADES]
    ON [dbo].[FAC_REL_CARACTERISTICAS_FACILIDADES];

