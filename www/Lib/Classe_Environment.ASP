<%
Class TEnvironment

Private bln_usuarioCRT
Private bln_ehRT
Private bln_ehRAT
Private bln_ehGQ
Private chr_Usuario
Private chr_Matricula
Private bln_usuarioCRT_Cadastrado
Private chr_PaginaInicial
Private bln_ehFuncionario
Private chr_CaminhoAnt
Private chr_MeuIP
Private int_PerfilSCE
Private bln_usuarioSCE
Private p_moduloLog

Public siglaApp
Public nomeApp
Public versaoApp
Public orgaoEbt
Public siglaCrt
Public nomeCrt
Public ramalContato
Public emailContato
Public periodoValidacaoDocumento

Public bln_TemErro
Public chr_MsgErro

Public oConn	'conexao SQL Server
Public oConnAc	'conexao access
Public Ebt

Private int_TAMANHOPAGINA

Private Sub Class_Initialize()

	Set Ebt = New TEbt

	bln_ehRT = False
	bln_ehRAT = False
	bln_ehGQ = False
	bln_UsuarioCRT = False
	bln_UsuarioCRT_Cadastrado = False
	bln_UsuarioSCE = False
    p_moduloLog = "SISLAB"

	chr_Matricula = ""
	chr_PaginaInicial = "index.asp"

	chr_Usuario = replace(ucase(Request.ServerVariables("REMOTE_USER")),"EMBRATEL\","")
	chr_MeuIP = Request.ServerVariables("REMOTE_ADDR")

	chr_CaminhoAnt = ""

	int_TAMANHOPAGINA = 10

	bln_TemErro = False
	chr_MsgErro = ""

	int_PerfilSCE = 0 'perfil sem acesso

	'-->>> variáveis de configuração
	siglaApp = "CRT"
	nomeApp = "Sistema de Gestão de Laboratório"
	versaoApp = "2006"
	orgaoEbt = "VPO28"
	siglaCrt = "CRT"
	nomeCrt = "Centro de Referência Tecnológica"
	ramalContato = "521-8297"
	emailContato = "ilab@embratel.com.br"
	periodoValidacaoDocumento = 6

	Call ConectaBD()

	Call Init()

End Sub

Private Sub Class_Terminate()
	Call DesconectaBD()
	Call DesconectaBDAccess()
End Sub

'-Property------------------------------------------------------------------------'
Public Property Get TemErro()
    TemErro = bln_TemErro
End Property

Public Property Get MensagemErro()
    MensagemErro = chr_MsgErro
End Property

Public Property Get RetornaCaminhoAnterior()
	If chr_CaminhoAnt = "" Then RetornaCaminhoAnterior = "index.asp" Else RetornaCaminhoAnterior = chr_CaminhoAnt
End Property

Public Property Get ehRT()
	ehRT = bln_ehRT
End Property

Public Property Get IP()
	IP = chr_MeuIP
End Property

Public Property Get ehRAT()
	ehRAT = bln_ehRAT
End Property

Public Property Get ehGQ()
	ehGQ = bln_ehGQ
End Property

Public Property Get UsuarioCRT()
	UsuarioCRT = bln_UsuarioCRT
End Property

Public Property Get UsuarioSCE()
    UsuarioSCE = bln_UsuarioSCE
End Property

Public Property Get PerfilSCE()
    PerfilSCE = int_PerfilSCE
End Property

Public Property Get UsuarioCRT_Cadastrado()
	UsuarioCRT_Cadastrado = bln_UsuarioCRT_Cadastrado
End Property

Public Property Get Usuario()
	Usuario = chr_Usuario
End Property

Public Property Get PaginaInicial()
	PaginaInicial = chr_PaginaInicial
End Property

Public Property Get Matricula()
	Matricula = Ebt.Matricula
End Property

Public Property Get ehFuncionario()
	ehFuncionario = Ebt.ehFuncionario
End Property

Public Property Get Nome_Reduzido()
	Nome_Reduzido = Ebt.Nome_Reduzido
End Property

Public Property Get Sigla_Orgao()
	Sigla_Orgao = Ebt.Sigla_Orgao
End Property

Public Property Get DN()
	DN = Ebt.DN
End Property

Public Property Get UF_Com()
	UF_Com = Ebt.UF_Com
End Property

Public Property Get CID_COM()
	CID_COM = Ebt.CID_COM
End Property

Public Property Get TEL1_COM()
	TEL1_COM = Ebt.TEL1_COM
End Property

Public Property Get ehGerente()
	ehGerente = Ebt.ehGerente
End Property

Public Property Get Sigla_Orgao_Gerente()
	Sigla_Orgao_Gerente = Ebt.Sigla_Orgao_Gerente
End Property

Public Property Get Modulo()
	Modulo = p_moduloLog
End Property

Public Property Let SetModulo(modulo)
    p_moduloLog = UCase(modulo)
End Property

'---------------------------------------------------------------------------------'

Private Sub DesconectaBD()
	oConn.Close
	Set oConn = Nothing
End Sub

Private Sub ConectaBD()
	Dim chr_Conn

	On Error Resume Next

	Set Me.oConn = Server.CreateObject("ADODB.Connection")

	chr_Conn = _
			"Provider=sqloledb; " & _
			"User ID=" & Application("SISLAB_DataUser") & "; " & _
			"Password=" & Application("SISLAB_DataUserPwd") & "; " & _
			"Initial Catalog=" & Application("SISLAB_InitialCatalog") & "; " & _
			"Data Source=" & Application("SISLAB_DataSource")

	Me.oConn.Open chr_Conn

	If Me.oConn.Errors.Count > 0 Then
		bln_TemErro = True
		chr_MsgErro = Me.oConn.Errors.Description
		Call Me.ImprimeErrosConexao()
	End If

	On Error Goto 0
End Sub


Public Sub InitAccess()
	Call ConectaBDAccess()
End Sub

Private Sub DesconectaBDAccess()
    On Error Resume Next
	oConnAc.Close
	On Error Goto 0
	Set oConnAc = Nothing
End Sub


Private Sub ConectaBDAccess()
	Dim chr_Caminho

'Comentei esse código porque dá erro no IIS7+Windows7 (15/03/2012)
'
'	On Error Resume Next

	chr_Caminho = Server.MapPath(".") & "\dados\sislab.mdb"

	Set Me.oConnAc = Server.CreateObject("ADODB.Connection")

'rw Application("SISLAB_ACCESS_PROVIDER") & chr_Caminho & ";User Id=admin;Password=;"
're
	Me.oConnAc.Open Application("SISLAB_ACCESS_PROVIDER") & chr_Caminho & ";User Id=admin;Password=;"
'rw "<BR>" & Me.oConnAc.Errors.Count 
're
	If Me.oConnAc.Errors.Count > 0 Then
		bln_TemErro = True
		chr_MsgErro = Me.oConnAc.Errors.Description
'		Call ImprimeErrosConexao(Me.oConnAc.Errors)
	End If

	On Error Goto 0
End Sub


Private Sub Init()
	Dim RS

	On Error Resume Next
	'-- Pega os dados de Configuracao da aplicacao SISLAB
	Set RS = oConn.Execute("SELECT TOP 1 * FROM Configuracao WHERE CFG_ID_APLICACAO = " & Application("SISLAB_ID_APLICACAO_SISLAB") )

	If Not(RS Is Nothing) Then
		If Not(RS.Eof And RS.Bof) Then
			siglaApp = RS("CFG_SIGLA_APLICACAO")
			nomeApp = RS("CFG_NOME_APLICACAO")
			versaoApp = RS("CFG_VERSAO_APLICACAO")
			orgaoEbt = RS("CFG_ORGAO_EBT")
		 	siglaCrt = RS("CFG_SIGLA_CRT")
 			nomeCrt = RS("CFG_NOME_CRT")
			ramalContato = RS("CFG_RAMAL_CONTATO")
			emailContato = RS("CFG_EMAIL_CONTATO")
			periodoValidacaoDocumento = RS("CFG_VALIDACAO_DOCUMENTOS")
		End If
	End If
	On Error Goto 0

	Set RS = Nothing
End Sub

Public Sub LoginUsuario(chr_LoginName)
	Dim chr_SQL
	Dim objRS

	If Application("SISLAB_AMBIENTE") = "LOC" Then
		chr_Usuario = "JOSESP"
	Else
		If chr_LoginName = "" then
			chr_Usuario = replace(ucase(Request.ServerVariables("REMOTE_USER")),"EMBRATEL\","")
		Else
			chr_Usuario = chr_LoginName
		End if
	End If

	'-- Pega os dados do usuario se for do CRT
	chr_SQL = "select USERID, RAT, GQ, RT, EXIBIR, ID_PERFIL_SCE FROM UserCRT where UPPER(USERID) = '" & chr_Usuario & "'"
	Call RecordSet(True, objRS, chr_SQL)

	If objRS.BOF And objRS.EOF Then 
		bln_usuarioCRT = False
		bln_ehRT = False
		bln_ehRAT = False
		bln_ehGQ = False
		bln_usuarioCRT_Cadastrado = False
		bln_UsuarioSCE = False
		int_PerfilSCE = 0
	Else
		bln_usuarioCRT = True
		bln_ehRT = CBool(objRS("RT"))
		bln_ehRAT = CBool(objRS("RAT"))
		bln_ehGQ = CBool(objRS("GQ"))
		bln_usuarioCRT_Cadastrado = True 'CBool(objRS("EXIBIR"))
		int_PerfilSCE = IIf(IsNull(objRS("ID_PERFIL_SCE")), 0, objRS("ID_PERFIL_SCE"))
		bln_UsuarioSCE = (int_PerfilSCE > 0)
	End If

	Call RecordSet(False, objRS, Null)

	Call Ebt.BuscaDadosEmbratel(chr_Usuario)


'--DEBUG----------------------------------------------------
	If Application("SISLAB_DEBUG") = "SIM" Then
		bln_ehRT = False
		bln_ehRAT = False
		bln_ehGQ = False
		bln_UsuarioCRT = False
		bln_UsuarioCRT_Cadastrado = False
		chr_Usuario = "TESTE"
		bln_UsuarioSCE = False
		int_PerfilSCE = 0
	End If
'--DEBUG----------------------------------------------------

End Sub


Public Sub RecordSet(opcao, record, strExec)
	If(opcao)Then
		Set record = Server.CreateObject("ADODB.RecordSet")
		record.PageSize = int_TAMANHOPAGINA + 1
		record.cursortype = 3
		record.Open strExec, Me.oConn

		if oConn.Errors.Count <> 0 then
			Call Me.ImprimeErrosConexao()

			''-- Nao sei o que PORRA o paulo fez para colocar este RS aqui dentro !!!
			''-- Nem eu sei como isto veio parar aqui -- Paulo !!!!
			'if not( IsEmpty(rs_agendamento) or IsNull(rs_agendamento) ) then 
			'	Response.Clear 
			'	rs_agendamento.Close
			'	set rs_agendamento = nothing

			'	num_erro = Server.URLEncode(Err.number)
			'	desc_erro = Server.URLEncode(Err.Description)
			'	response.write num_erro & " - " & desc_erro & "<br>" & strExec
			'	Response.End
			'end if
		end if
	Else
		record.close
		Set record = Nothing
	End If
End Sub


Public Sub StoredProcedure(opcao, command, strExec)
	If(opcao)Then
		Set command = Server.CreateObject("ADODB.Command")
		command.CommandType = adCmdStoredProc
		command.CommandText = strExec
		Set command.ActiveConnection = Me.oConn
	Else
		Set command.ActiveConnection = Nothing
		Set command = Nothing
	End If
End Sub

Public Function ArmazenaCaminhoAnterior()
	chr_CaminhoAnt = Request.ServerVariables("HTTP_REFERER")
End Function

Public Function LogErroBD()
    Call Me.Log(p_moduloLog & "/ERRO", oConn.Errors.Description)
End Function

Public Function Log(mensagem)
    Dim objSP

	Call Me.StoredProcedure(True, objSP, "sp_LogEvento")
	With objSP
	    .Parameters.item("@USER_ID").Value = Env.Usuario
	    .Parameters.item("@MODULO").Value = p_moduloLog
	    .Parameters.item("@MSG").Value = mensagem
	    on error resume next
	    .Execute
	    If Err.number <> 0 Then
	        bln_TemErro = True
	        chr_MsgErro = Err.Description
	    End If
	    on error goto 0
	End With
	Call Me.StoredProcedure(False, objSP, Null)
End Function

Public Function LogSCE(mensagem)
    p_moduloLog = "SCE"
    Call Me.Log(mensagem)
End Function

End Class
%>
