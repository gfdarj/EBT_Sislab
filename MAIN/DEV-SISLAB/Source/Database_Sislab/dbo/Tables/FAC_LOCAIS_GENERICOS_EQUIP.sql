CREATE TABLE [dbo].[FAC_LOCAIS_GENERICOS_EQUIP] (
    [LGE_ID]   INT          IDENTITY (1, 1) NOT NULL,
    [LGE_NOME] VARCHAR (50) NOT NULL,
    [LGE_TIPO] CHAR (1)     NOT NULL,
    PRIMARY KEY NONCLUSTERED ([LGE_ID] ASC) WITH (FILLFACTOR = 90)
);


GO

create trigger [dbo].[tU_FAC_LOCAIS_GENERICOS_EQUIP] on [dbo].[FAC_LOCAIS_GENERICOS_EQUIP] for UPDATE as
/* ERwin Builtin Wed Apr 10 09:54:27 2002 */
/* UPDATE trigger on FAC_LOCAIS_GENERICOS_EQUIP */
begin
  declare  @numrows int,
           @nullcnt int,
           @validcnt int,
           @insLGE_ID int,
           @errno   int,
           @errmsg  varchar(255)

  select @numrows = @@rowcount
  /* ERwin Builtin Wed Apr 10 09:54:27 2002 */
  /* FAC_LOCAIS_GENERICOS_EQUIP R/10 FAC_LOCAIS_ESPECIFICOS_EQUIP ON PARENT UPDATE CASCADE */
  if
    /* update(LGE_ID) */
    update(LGE_ID)
  begin
    if @numrows = 1
    begin
      select @insLGE_ID = inserted.LGE_ID
        from inserted
      update FAC_LOCAIS_ESPECIFICOS_EQUIP
      set
        /*  FAC_LOCAIS_ESPECIFICOS_EQUIP.LGE_ID = @insLGE_ID */
        FAC_LOCAIS_ESPECIFICOS_EQUIP.LGE_ID = @insLGE_ID
      from FAC_LOCAIS_ESPECIFICOS_EQUIP,inserted,deleted
      where
        /*  FAC_LOCAIS_ESPECIFICOS_EQUIP.LGE_ID = deleted.LGE_ID */
        FAC_LOCAIS_ESPECIFICOS_EQUIP.LGE_ID = deleted.LGE_ID
    end
    else
    begin
      select @errno = 30006,
             @errmsg = 'Cannot cascade FAC_LOCAIS_GENERICOS_EQUIP UPDATE because more than one row has been affected.'
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
DISABLE TRIGGER [dbo].[tU_FAC_LOCAIS_GENERICOS_EQUIP]
    ON [dbo].[FAC_LOCAIS_GENERICOS_EQUIP];


GO

create trigger [dbo].[tD_FAC_LOCAIS_GENERICOS_EQUIP] on [dbo].[FAC_LOCAIS_GENERICOS_EQUIP] for DELETE as
/* ERwin Builtin Wed Apr 10 09:54:27 2002 */
/* DELETE trigger on FAC_LOCAIS_GENERICOS_EQUIP */
begin
  declare  @errno   int,
           @errmsg  varchar(255)
    /* ERwin Builtin Wed Apr 10 09:54:27 2002 */
    /* FAC_LOCAIS_GENERICOS_EQUIP R/10 FAC_LOCAIS_ESPECIFICOS_EQUIP ON PARENT DELETE CASCADE */
    delete FAC_LOCAIS_ESPECIFICOS_EQUIP
      from FAC_LOCAIS_ESPECIFICOS_EQUIP,deleted
      where
        /*  FAC_LOCAIS_ESPECIFICOS_EQUIP.LGE_ID = deleted.LGE_ID */
        FAC_LOCAIS_ESPECIFICOS_EQUIP.LGE_ID = deleted.LGE_ID


    /* ERwin Builtin Wed Apr 10 09:54:27 2002 */
    return
error:
    raiserror @errno @errmsg
    rollback transaction
end

GO
DISABLE TRIGGER [dbo].[tD_FAC_LOCAIS_GENERICOS_EQUIP]
    ON [dbo].[FAC_LOCAIS_GENERICOS_EQUIP];

