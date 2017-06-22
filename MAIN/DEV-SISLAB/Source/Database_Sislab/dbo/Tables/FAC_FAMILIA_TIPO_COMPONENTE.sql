CREATE TABLE [dbo].[FAC_FAMILIA_TIPO_COMPONENTE] (
    [FTC_NOME] VARCHAR (200) NOT NULL,
    [FTC_ID]   INT           IDENTITY (1, 1) NOT NULL,
    PRIMARY KEY NONCLUSTERED ([FTC_ID] ASC) WITH (FILLFACTOR = 90)
);


GO

create trigger [dbo].[tD_FAC_FAMILIA_TIPO_COMPONENTE] on [dbo].[FAC_FAMILIA_TIPO_COMPONENTE] for DELETE as
/* ERwin Builtin Wed Apr 10 09:54:27 2002 */
/* DELETE trigger on FAC_FAMILIA_TIPO_COMPONENTE */
begin
  declare  @errno   int,
           @errmsg  varchar(255)
    /* ERwin Builtin Wed Apr 10 09:54:27 2002 */
    /* FAC_FAMILIA_TIPO_COMPONENTE R/15 FAC_TIPO_COMPONENTE ON PARENT DELETE RESTRICT */
    if exists (
      select * from deleted,FAC_TIPO_COMPONENTE
      where
        /*  FAC_TIPO_COMPONENTE.FTC_ID = deleted.FTC_ID */
        FAC_TIPO_COMPONENTE.FTC_ID = deleted.FTC_ID
    )
    begin
      select @errno  = 30001,
             @errmsg = 'Cannot DELETE FAC_FAMILIA_TIPO_COMPONENTE because FAC_TIPO_COMPONENTE exists.'
      goto error
    end


    /* ERwin Builtin Wed Apr 10 09:54:27 2002 */
    return
error:
    raiserror @errno @errmsg
    rollback transaction
end

GO
DISABLE TRIGGER [dbo].[tD_FAC_FAMILIA_TIPO_COMPONENTE]
    ON [dbo].[FAC_FAMILIA_TIPO_COMPONENTE];


GO

create trigger [dbo].[tU_FAC_FAMILIA_TIPO_COMPONENTE] on [dbo].[FAC_FAMILIA_TIPO_COMPONENTE] for UPDATE as
/* ERwin Builtin Wed Apr 10 09:54:27 2002 */
/* UPDATE trigger on FAC_FAMILIA_TIPO_COMPONENTE */
begin
  declare  @numrows int,
           @nullcnt int,
           @validcnt int,
           @insFTC_ID int,
           @errno   int,
           @errmsg  varchar(255)

  select @numrows = @@rowcount
  /* ERwin Builtin Wed Apr 10 09:54:27 2002 */
  /* FAC_FAMILIA_TIPO_COMPONENTE R/15 FAC_TIPO_COMPONENTE ON PARENT UPDATE CASCADE */
  if
    /* update(FTC_ID) */
    update(FTC_ID)
  begin
    if @numrows = 1
    begin
      select @insFTC_ID = inserted.FTC_ID
        from inserted
      update FAC_TIPO_COMPONENTE
      set
        /*  FAC_TIPO_COMPONENTE.FTC_ID = @insFTC_ID */
        FAC_TIPO_COMPONENTE.FTC_ID = @insFTC_ID
      from FAC_TIPO_COMPONENTE,inserted,deleted
      where
        /*  FAC_TIPO_COMPONENTE.FTC_ID = deleted.FTC_ID */
        FAC_TIPO_COMPONENTE.FTC_ID = deleted.FTC_ID
    end
    else
    begin
      select @errno = 30006,
             @errmsg = 'Cannot cascade FAC_FAMILIA_TIPO_COMPONENTE UPDATE because more than one row has been affected.'
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
DISABLE TRIGGER [dbo].[tU_FAC_FAMILIA_TIPO_COMPONENTE]
    ON [dbo].[FAC_FAMILIA_TIPO_COMPONENTE];

