<%
Class TEnvironment

    Private chr_Nome
    Private chr_Usuario
    Private chr_Matricula
    Private chr_PaginaInicial
    Private chr_CaminhoAnt
    Private chr_MeuIP
    Private int_PerfilSCE
    Private p_moduloLog

    Public siglaApp
    Public nomeApp
    Public nomeAppHtml
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

    Public Property Get PaginaInicial()
	    PaginaInicial = chr_PaginaInicial
    End Property

    Public Property Get IP()
	    IP = chr_MeuIP
    End Property

    Public Property Get Modulo()
	    Modulo = p_moduloLog
    End Property

    Public Property Let SetModulo(modulo)
        p_moduloLog = UCase(modulo)
    End Property


    Public Property Get ehRT()
	    'ehRT = Ebt.ehRT
	    ehRT = True
	    'ehRT = False
    End Property

    Public Property Get ehRAT()
	    'ehRAT = Ebt.ehRAT
	    ehRAT = True
	    'ehRAT = False
    End Property

    Public Property Get ehGQ()
	    'ehGQ = Ebt.ehGQ
	    ehGQ = True
	    'ehGQ = False
    End Property

    Public Property Get UsuarioCRT()
	    'UsuarioCRT = Ebt.UsuarioCRT
	    UsuarioCRT = True
	    'UsuarioCRT = False
    End Property

    Public Property Get UsuarioSCE()
        UsuarioSCE = Ebt.UsuarioSCE
    End Property

    Public Property Get PerfilSCE()
        PerfilSCE = Ebt.PerfilSCE
    End Property

    Public Property Get UsuarioCRT_Cadastrado()
	    UsuarioCRT_Cadastrado = Ebt.UsuarioCRTCadastrado
    End Property

    Public Property Get Usuario()
	    Usuario = Ebt.Usuario
    End Property

    Public Property Get Matricula()
	    Matricula = Ebt.Matricula
    End Property

    Public Property Get ehFuncionario()
	    ehFuncionario = Ebt.ehFuncionario
    End Property

    Public Property Get NomeReduzido()
	    NomeReduzido = Ebt.NomeReduzido
    End Property

    Public Property Get SiglaOrgao()
	    SiglaOrgao = Ebt.SiglaOrgao
    End Property

    Public Property Get ehGerente()
	    ehGerente = Ebt.ehGerente
    End Property

    Public Property Get SiglaOrgaoGerente()
	    Sigla_Orgao_Gerente = Ebt.SiglaOrgaoGerente
    End Property

    Public Property Get Ramal()
	    Ramal = Ebt.Ramal
    End Property

    Public Property Get Celular()
	    Celular = Ebt.Celular
    End Property

    Public Property Get DN()
	    DN = ""
    End Property

    Public Property Get UF_Com()
	    UF_Com = ""
    End Property

    Public Property Get CID_COM()
	    CID_COM = ""
    End Property

    Public Property Get TEL1_COM()
	    TEL1_COM = ""
    End Property

    '---------------------------------------------------------------------------------'

    Private Sub Class_Initialize()

	    Set Ebt = New TEbt

        p_moduloLog = "SISLAB"
	    chr_PaginaInicial = "index.asp"
        chr_Nome = "" :  chr_Usuario = "" :  chr_Sigla_Orgao = "" :  chr_DN = "" :  chr_UF_Com = "" :  chr_CID_COM = ""
		chr_TEL1_COM = "" :  bln_ehGerente = False :  chr_Sigla_Orgao_Gerente = "" :  chr_Matricula = ""


        Call Ebt.LoginUsuario("")


	    'chr_Usuario = replace(ucase(Request.ServerVariables("REMOTE_USER")),"EMBRATEL\","")
	    chr_Usuario = Ebt.Usuario()

	    chr_MeuIP = Request.ServerVariables("REMOTE_ADDR")

	    chr_CaminhoAnt = ""

	    int_TAMANHOPAGINA = 10

	    bln_TemErro = False
	    chr_MsgErro = ""

	    int_PerfilSCE = 0 'perfil sem acesso

	    '-->>> variáveis de configuração
	    siglaApp = "CRT"
	    nomeApp = "Sistema de Gestão de Laboratório"
	    nomeAppHtml = "Sistema de Gest&atilde;o de Laborat&oacute;rio"
	    versaoApp = "2006"
	    orgaoEbt = "VPO28"
	    siglaCrt = "CRT"
	    nomeCrt = "Centro de Referência Tecnológica"
	    ramalContato = "521-8297"
	    emailContato = Application("SISLAB_EMAIL_AUTOMATICO")
	    periodoValidacaoDocumento = 6

	    Call ConectaBD()

	    Call Init()

    End Sub

    Private Sub Class_Terminate()
	    Call DesconectaBD()
	    Call DesconectaBDAccess()
    End Sub


    '---------------------------------------------------------------------------------'

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


    Private Sub DesconectaBD()
	    oConn.Close
	    Set oConn = Nothing
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


    Public Function ArmazenaCaminhoAnterior()
	    chr_CaminhoAnt = Request.ServerVariables("HTTP_REFERER")
    End Function



	' Métodos trazidos da Classe_Ebt 
    Public Function ExisteUsuario(chr_Usuario)
	    Dim objUser

        ExisteUsuario = False

        If Not VVVNZ(chr_Usuario) Then
			Set objUser = New TEbt

			Call objUser.LoginUsuario(chr_Usuario)

            If Not VVVNZ(objUser.Matricula) Then
	            ExisteUsuario = True
            End If

    	    Set objUser = Nothing
        End If
    End Function


	' Métodos trazidos da Classe_Ebt 
    Public Function AchaNomeEmbratel(chr_Usuario)
	    Dim objUser

		AchaNomeEmbratel = ""

        If Not VVVNZ(chr_Usuario) Then
			Set objUser = New TEbt

			Call objUser.LoginUsuario(chr_Usuario)

            If Not VVVNZ(objUser.NomeReduzido) Then
	            AchaNomeEmbratel = objUser.NomeReduzido
            End If

    	    Set objUser = Nothing
        End If
	End Function




    '---------------------------------------------------------------------------------------------------------------------
    '-- MANTIVE ESSAS ROTINAS POR COMPATIBILIDADE COM TODO O SITE POIS REPLIQUEI ESSAS ROTINAS PARA A CLASSE_SQL
    '--
    '--     Obs: 09/08/2018
    '---------------------------------------------------------------------------------------------------------------------

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

    Private Sub ImprimeErrosConexao()
        ImprimeErrosConexao = "ERRO"
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


    Public Function ObtemLinkCodigoEtica()
	    Dim RS

	    '-- Pega os dados de Configuracao da aplicacao SISLAB
	    Set RS = oConn.Execute("SELECT top 1 ARQ_NOMEARQ FROM ARQUIVOS WHERE ARQ_CODARQTIPO = " & Application("SISLAB_ID_CODARQTIPO_CODIGOETICA") & " AND ARQ_IDSITUACAO = " & Application("SISLAB_ID_SITUACAOARQUIVO_APROVADO"))
        If RS.Eof And RS.Bof Then
            ObtemLinkCodigoEtica = "#"
        Else
            ObtemLinkCodigoEtica = "Arquivos/" & RS("ARQ_NOMEARQ")
        End If
    End Function

    Public Function ObtemLinkManualSistemaGestao()
	    Dim RS

	    '-- Pega os dados de Configuracao da aplicacao SISLAB
	    Set RS = oConn.Execute("SELECT top 1 ARQ_NOMEARQ FROM ARQUIVOS WHERE ARQ_CODARQTIPO = " & Application("SISLAB_ID_CODARQTIPO_MANUALGESTAO") & " AND ARQ_IDSITUACAO = " & Application("SISLAB_ID_SITUACAOARQUIVO_APROVADO"))
        If RS.Eof And RS.Bof Then
            ObtemLinkManualSistemaGestao = "#"
        Else
            ObtemLinkManualSistemaGestao = "Arquivos/" & RS("ARQ_NOMEARQ")
        End If
    End Function

    Public Function MensagemAcessoExclusivo()
        Dim s
        s = ""
        s = s & "<div class='container'>"
        s = s & "   <div class='row'>"
        s = s & "       <div class='col-xs-12 col-sm-12 col-md-12 col-lg-12'>"
        s = s & "           Desculpe, esta página é de acesso exclusivo à Equipe do CRT."
        s = s & "       </div>"
        s = s & "   </div>"
        s = s & "</div>"
        MensagemAcessoExclusivo = s
    End Function

End Class
%>
