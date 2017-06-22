CREATE TABLE [dbo].[FAC_TIPO_CIRCUITO] (
    [TPC_ID]   INT          IDENTITY (1, 1) NOT NULL,
    [TPC_NOME] VARCHAR (50) NOT NULL,
    CONSTRAINT [PK__FAC_TIPO_CIRCUIT__68C86C1B] PRIMARY KEY NONCLUSTERED ([TPC_ID] ASC) WITH (FILLFACTOR = 90)
);


GO
create trigger [dbo].[tD_FAC_TIPO_CIRCUITO] on [dbo].[FAC_TIPO_CIRCUITO] for DELETE as
/* ERwin Builtin Wed Apr 10 09:54:28 2002 */
/* DELETE trigger on FAC_TIPO_CIRCUITO */
begin
  declare  @errno   int,
           @errmsg  varchar(255)
    /* ERwin Builtin Wed Apr 10 09:54:28 2002 */
    /* FAC_TIPO_CIRCUITO R/5 FAC_CIRCUITO ON PARENT DELETE RESTRICT */
    if exists (
      select * from deleted,FAC_CIRCUITO
      where
        /*  FAC_CIRCUITO.TPC_ID = deleted.TPC_ID */
        FAC_CIRCUITO.TPC_ID = deleted.TPC_ID
    )
    begin
      select @errno  = 30001,
             @errmsg = 'Cannot DELETE FAC_TIPO_CIRCUITO because FAC_CIRCUITO exists.'
      goto error
    end


    /* ERwin Builtin Wed Apr 10 09:54:28 2002 */
    return
error:
    raiserror @errno @errmsg
    rollback transaction
end

GO
DISABLE TRIGGER [dbo].[tD_FAC_TIPO_CIRCUITO]
    ON [dbo].[FAC_TIPO_CIRCUITO];


GO
create trigger [dbo].[tU_FAC_TIPO_CIRCUITO] on [dbo].[FAC_TIPO_CIRCUITO] for UPDATE as
/* ERwin Builtin Wed Apr 10 09:54:28 2002 */
/* UPDATE trigger on FAC_TIPO_CIRCUITO */
begin
  declare  @numrows int,
           @nullcnt int,
           @validcnt int,
           @insTPC_ID int,
           @errno   int,
           @errmsg  varchar(255)

  select @numrows = @@rowcount
  /* ERwin Builtin Wed Apr 10 09:54:28 2002 */
  /* FAC_TIPO_CIRCUITO R/5 FAC_CIRCUITO ON PARENT UPDATE CASCADE */
  if
    /* update(TPC_ID) */
    update(TPC_ID)
  begin
    if @numrows = 1
    begin
      select @insTPC_ID = inserted.TPC_ID
        from inserted
      update FAC_CIRCUITO
      set
        /*  FAC_CIRCUITO.TPC_ID = @insTPC_ID */
        FAC_CIRCUITO.TPC_ID = @insTPC_ID
      from FAC_CIRCUITO,inserted,deleted
      where
        /*  FAC_CIRCUITO.TPC_ID = deleted.TPC_ID */
        FAC_CIRCUITO.TPC_ID = deleted.TPC_ID
    end
    else
    begin
      select @errno = 30006,
             @errmsg = 'Cannot cascade FAC_TIPO_CIRCUITO UPDATE because more than one row has been affected.'
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
DISABLE TRIGGER [dbo].[tU_FAC_TIPO_CIRCUITO]
    ON [dbo].[FAC_TIPO_CIRCUITO];

