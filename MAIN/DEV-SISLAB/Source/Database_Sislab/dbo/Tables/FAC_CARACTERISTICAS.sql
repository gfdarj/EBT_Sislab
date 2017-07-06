CREATE TABLE [dbo].[FAC_CARACTERISTICAS] (
    [CAR_ID]        INT            IDENTITY (1, 1) NOT NULL,
    [CAR_NOME]      VARCHAR (50)   NOT NULL,
    [CAR_DEFINICAO] VARCHAR (5000) NULL,
    PRIMARY KEY NONCLUSTERED ([CAR_ID] ASC) WITH (FILLFACTOR = 90)
);


GO

create trigger [dbo].[tU_FAC_CARACTERISTICAS] on [dbo].[FAC_CARACTERISTICAS] for UPDATE as
/* ERwin Builtin Wed Apr 10 09:54:26 2002 */
/* UPDATE trigger on FAC_CARACTERISTICAS */
begin
  declare  @numrows int,
           @nullcnt int,
           @validcnt int,
           @insCAR_ID int,
           @errno   int,
           @errmsg  varchar(255)

  select @numrows = @@rowcount
  /* ERwin Builtin Wed Apr 10 09:54:26 2002 */
  /* FAC_CARACTERISTICAS R/6 FAC_REL_CARACTERISTICAS_TIPO ON PARENT UPDATE CASCADE */
  if
    /* update(CAR_ID) */
    update(CAR_ID)
  begin
    if @numrows = 1
    begin
      select @insCAR_ID = inserted.CAR_ID
        from inserted
      update FAC_REL_CARACTERISTICAS_TIPO
      set
        /*  FAC_REL_CARACTERISTICAS_TIPO.CAR_ID = @insCAR_ID */
        FAC_REL_CARACTERISTICAS_TIPO.CAR_ID = @insCAR_ID
      from FAC_REL_CARACTERISTICAS_TIPO,inserted,deleted
      where
        /*  FAC_REL_CARACTERISTICAS_TIPO.CAR_ID = deleted.CAR_ID */
        FAC_REL_CARACTERISTICAS_TIPO.CAR_ID = deleted.CAR_ID
    end
    else
    begin
      select @errno = 30006,
             @errmsg = 'Cannot cascade FAC_CARACTERISTICAS UPDATE because more than one row has been affected.'
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
DISABLE TRIGGER [dbo].[tU_FAC_CARACTERISTICAS]
    ON [dbo].[FAC_CARACTERISTICAS];


GO




create trigger [dbo].[tD_FAC_CARACTERISTICAS] on [dbo].[FAC_CARACTERISTICAS] for DELETE as
/* ERwin Builtin Wed Apr 10 09:54:26 2002 */
/* DELETE trigger on FAC_CARACTERISTICAS */
begin
  declare  @errno   int,
           @errmsg  varchar(255)
    /* ERwin Builtin Wed Apr 10 09:54:26 2002 */
    /* FAC_CARACTERISTICAS R/6 FAC_REL_CARACTERISTICAS_TIPO ON PARENT DELETE RESTRICT */
    if exists (
      select * from deleted,FAC_REL_CARACTERISTICAS_TIPO
      where
        /*  FAC_REL_CARACTERISTICAS_TIPO.CAR_ID = deleted.CAR_ID */
        FAC_REL_CARACTERISTICAS_TIPO.CAR_ID = deleted.CAR_ID
    )
    begin
      select @errno  = 30001,
             @errmsg = 'Cannot DELETE FAC_CARACTERISTICAS because FAC_REL_CARACTERISTICAS_TIPO exists.'
      goto error
    end


    /* ERwin Builtin Wed Apr 10 09:54:26 2002 */
    return
error:
    raiserror @errno @errmsg
    rollback transaction
end

GO
DISABLE TRIGGER [dbo].[tD_FAC_CARACTERISTICAS]
    ON [dbo].[FAC_CARACTERISTICAS];

