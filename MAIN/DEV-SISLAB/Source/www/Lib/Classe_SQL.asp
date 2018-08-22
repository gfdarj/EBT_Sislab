<%
Class TSql

    Private chr_Conn
    Private bln_TemErro
    Private chr_MsgErro
    Private p_moduloLog

    Public Conexao	'conexao SQL Server
'    Public ConexaoAC	'conexao access

    Private int_TAMANHOPAGINA   'Tamanho da página do Recordset

'-Property------------------------------------------------------------------------'

    Public Property Get TemErro()
        TemErro = bln_TemErro
    End Property

    Public Property Get MensagemErro()
        MensagemErro = chr_MsgErro
    End Property

    Public Property Get PaginaInicial()
	    PaginaInicial = chr_PaginaInicial
    End Property

    Public Property Let PaginaInicial(valor)
	    chr_PaginaInicial = valor
    End Property

'---------------------------------------------------------------------------------'

    Private Sub Class_Initialize()
	    int_TAMANHOPAGINA = 10

        'String de conexão
	    chr_Conn = _
			    "Provider=sqloledb; " & _
			    "User ID=" & Application("SISLAB_DataUser") & "; " & _
			    "Password=" & Application("SISLAB_DataUserPwd") & "; " & _
			    "Initial Catalog=" & Application("SISLAB_InitialCatalog") & "; " & _
			    "Data Source=" & Application("SISLAB_DataSource")

	    Call Conectar()
    End Sub

    Private Sub Class_Terminate()
	    Call Desconectar()
    End Sub

    '---------------------------------------------------------------------------------'

    Private Sub Conectar()
	    Dim chr_Conn

	    On Error Resume Next

	    Set Conexao = Server.CreateObject("ADODB.Connection")

	    Conexao.Open chr_Conn

	    If Me.Conexao.Errors.Count > 0 Then
		    bln_TemErro = True
		    chr_MsgErro = Me.Conexao.Errors.Description
	    End If

	    On Error Goto 0
    End Sub

    Private Sub Desconectar()
        On Error Resume Next
	    Conexao.Close
        On Error Goto 0
	    Set Conexao = Nothing
    End Sub


    '-- Para a função funcionar precisa retornar o recordset desconectado!
    Public Function Executar(strExec)
        Dim record, Command, oConn

	    Set oConn = Server.CreateObject("ADODB.Connection")
	    oConn.Open chr_Conn

        Set Command = Server.CreateObject("ADODB.Command")
        Command.ActiveConnection = oConn
        Command.CommandText = strExec

		Set record = Server.CreateObject("ADODB.RecordSet")
		record.PageSize = int_TAMANHOPAGINA + 1
		record.CursorType = 3
        record.CursorLocation = adUseClient
        Call Me.Log("EXEC_RS", strExec)
		record.Open Command, , adOpenForwardOnly, adLockReadOnly

		if Conexao.Errors.Count <> 0 then
		    bln_TemErro = True
		    'chr_MsgErro = ConexaoAc.Errors.Description
            Call Me.LogErro(chr_MsgErro)
		end if

        Set Command.ActiveConnection = Nothing
        Set Command = Nothing
        Set record.ActiveConnection = Nothing
        oConn.Close
        Set oConn = Nothing

        Set Executar = record
    End Function


    Public Function ExecutarSP(strExec)
        Dim command, oConn

	    Set oConn = Server.CreateObject("ADODB.Connection")
	    oConn.Open chr_Conn

		Set command = Server.CreateObject("ADODB.Command")
		command.CommandType = adCmdStoredProc
		command.CommandText = strExec
		Set command.ActiveConnection = oConn
	    on error resume next
        Call Me.Log("EXEC_SP", strExec)
	    .Execute
	    If Err.number <> 0 Then
	        bln_TemErro = True
	        chr_MsgErro = Err.Description
            ExecutarSP = Err.number
            Call Me.LogErro(chr_MsgErro)
        Else
            ExecutarSP = 0
    	End If
	    on error goto 0
		Set command.ActiveConnection = Nothing
		Set command = Nothing
        oConn.Close
        Set oConn = Nothing
    End Function


    Public Sub StoredProcedure(objSP, strExec)
        Dim command, oConn

	    Set oConn = Server.CreateObject("ADODB.Connection")
	    oConn.Open chr_Conn

		Set command = Server.CreateObject("ADODB.Command")
		command.CommandType = adCmdStoredProc
		command.CommandText = strExec
		Set command.ActiveConnection = oConn
    End Sub


    '-- LOG --
    Public Function LogErro(mensagem)
        Call Me.Log("SQL_ERRO", mensagem)
    End Function

    Public Function Log(modulo, mensagem)
        Dim objSP

	    'Call StoredProcedure(objSP, "sp_LogEvento")

	    'With objSP
	    '    objSP.Parameters.item("@USER_ID").Value = "" 'Env.Usuario
	    '    objSP.Parameters.item("@MODULO").Value = modulo
	    '    objSP.Parameters.item("@MSG").Value = mensagem
	    '    on error resume next
	    '    objSP.Execute
	    '    If Err.number <> 0 Then
	    '        bln_TemErro = True
	    '        chr_MsgErro = Err.Description
        '        Log = Err.number 
        '    Else
        '        Log = 0
	    '    End If
	    '    on error goto 0
	    'End With

	    'Set objSP = Nothing
    End Function

    Public Function LogSCE(mensagem)
        Call Me.Log("SCE", mensagem)
    End Function

    '-- Acesso ao banco ACCESS --
    Public Sub InitAccess()
	    Call ConectaBDAccess()
    End Sub

    Private Sub DesconectaBDAccess()
        On Error Resume Next
	    'ConexaoAc.Close
	    On Error Goto 0
	    'Set ConexaoAc = Nothing
    End Sub

    Private Sub ConectaBDAccess()
	    Dim chr_Caminho

    'Comentei esse código porque dá erro no IIS7+Windows7 (15/03/2012)
    '
    '	On Error Resume Next

'	    chr_Caminho = Server.MapPath(".") & "\dados\sislab.mdb"

'	    Set Me.ConexaoAc = Server.CreateObject("ADODB.Connection")

    'rw Application("SISLAB_ACCESS_PROVIDER") & chr_Caminho & ";User Id=admin;Password=;"
    're
	    'ConexaoAc.Open Application("SISLAB_ACCESS_PROVIDER") & chr_Caminho & ";User Id=admin;Password=;"
    'rw "<BR>" & Me.ConexaoAc.Errors.Count 
    're
	    'If ConexaoAc.Errors.Count > 0 Then
		'    bln_TemErro = True
		'    chr_MsgErro = Me.ConexaoAc.Errors.Description
	    'End If

	    On Error Goto 0
    End Sub

End Class
%>
