<%
'------------------------------------------------------------------------------------------------------
'
'   CLASSE EMBRATEL - AQUI PEGA OS DADOS DO USUÁRIO LOGADO NO AD (Active Directory)
'
'------------------------------------------------------------------------------------------------------

Class TEbt

    Private bln_TemErro
    Private chr_MsgErro
    Private chr_Login
    Private bln_ehFuncionario
    Private chr_Nome_Reduzido
	Private bln_usuarioCRT
	Private bln_ehRT
	Private bln_ehRAT
	Private bln_ehGQ
	Private bln_usuarioCRT_Cadastrado
	Private bln_UsuarioSCE
	Private int_PerfilSCE
	Private chr_Sigla_Orgao
    Private chr_Ramal
    Private chr_Celular
    Private chr_Matricula
	Private bln_ehGerente
	Private chr_Sigla_Orgao_Gerente

    Private oSql

    '-Property------------------------------------------------------------------------'

    Public Property Get ehFuncionario()
	    ehFuncionario = bln_ehFuncionario
    End Property

    Public Property Get Usuario()
	    Usuario = chr_Login
    End Property

    Public Property Get NomeReduzido()
	    NomeReduzido = chr_Nome_Reduzido
    End Property

    Public Property Get TemErro()
        TemErro = bln_TemErro
    End Property

    Public Property Get MensagemErro()
        MensagemErro = chr_MsgErro
    End Property

    Public Property Get ehRT()
	    ehRT = bln_ehRT
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

    Public Property Get UsuarioCRTCadastrado()
	    UsuarioCRTCadastrado = bln_usuarioCRT_Cadastrado
    End Property

    Public Property Get Matricula()
	    Matricula = chr_Matricula
    End Property

    Public Property Get SiglaOrgao()
	    SiglaOrgao = chr_Sigla_Orgao
    End Property

    Public Property Get Ramal()
	    Ramal = chr_Ramal
    End Property

    Public Property Get Celular()
	    Celular = chr_Celular
    End Property

    Public Property Get ehGerente()
	    ehGerente = bln_ehGerente
    End Property

    Public Property Get SiglaOrgaoGerente()
	    SiglaOrgaoGerente = chr_Sigla_Orgao_Gerente
    End Property

    '-INIT------------------------------------------------------------------------'

    Private Sub Class_Initialize()
        Set oSql = New TSql

        bln_TemErro = False
        chr_MsgErro = ""
		bln_usuarioCRT = False
		bln_ehRT = False
		bln_ehRAT = False
		bln_ehGQ = False
		bln_usuarioCRT_Cadastrado = False
		bln_UsuarioSCE = 0
		int_PerfilSCE = 0
		chr_Sigla_Orgao = ""
        chr_Ramal = ""
        chr_Matricula = ""
		bln_ehGerente = False
		chr_Sigla_Orgao_Gerente = ""
        chr_Nome_Reduzido = ""
        bln_ehFuncionario = False
    End Sub


    Private Sub Class_Terminate()
        Set oSQL = Nothing
    End Sub


    Public Sub LoginUsuario(chr_Usuario)
	    Dim chr_SQL
	    Dim objRS
        Dim bln_EhAmbienteLocal

        chr_Login = ""

        Call BuscaDadosEmbratel(chr_Usuario)    'Preenche as variáveis Login e FullName, vindas do AD

        '--- SE ESTIVERMOS LOCALMENTE COLOCO O USUARIO GERENTE
        If (Left(Application("SISLAB_AMBIENTE"), 3) = "LOC" And chr_Login = "") Then
            chr_Login = "josesp@embratel.com.br"
        End If

	    '-- Pega os dados do usuario se for do CRT
	    chr_SQL = "SELECT u.USERID, u.RAT, u.GQ, u.RT, u.EXIBIR, u.ID_PERFIL_SCE, u.CELULAR, u.RAMAL, u.MATRICULA, " & _
                  "     o.ORGA_SIGLA, o.ORGA_DESCRICAO, o.ORGA_USERIDCHEFE " & _
                  "FROM UserCRT u LEFT JOIN Orgao o ON u.ORGA_ID = o.ORGA_ID " & _
                  "WHERE UPPER(USERID) = '" & chr_Login & "'"
	    Set objRS = oSQL.Executar(chr_SQL)

	    If objRS.BOF And objRS.EOF Then 
		    bln_usuarioCRT = False
		    bln_ehRT = False
		    bln_ehRAT = False
		    bln_ehGQ = False
		    bln_usuarioCRT_Cadastrado = False
		    bln_UsuarioSCE = False
		    int_PerfilSCE = 0
		    chr_Sigla_Orgao = ""
            chr_Ramal = ""
            chr_Celular = ""
            chr_Matricula = ""
	    Else
		    bln_usuarioCRT = True
		    bln_ehRT = CBool(objRS("RT"))
		    bln_ehRAT = CBool(objRS("RAT"))
		    bln_ehGQ = CBool(objRS("GQ"))
		    bln_usuarioCRT_Cadastrado = True
		    bln_UsuarioSCE = (int_PerfilSCE > 0)
		    int_PerfilSCE = IIf(IsNull(objRS("ID_PERFIL_SCE")), 0, objRS("ID_PERFIL_SCE"))
		    chr_Sigla_Orgao = objRS("ORGA_SIGLA")
            chr_Ramal = objRS("RAMAL")
            chr_Celular = objRS("CELULAR")
            chr_Matricula = objRS("MATRICULA")
	    End If
	    Set objRS = Nothing

        Set objRS = oSQL.Executar("SELECT ORGA_SIGLA FROM ORGAO WHERE ORGA_USERIDCHEFE = '" & chr_Login & "'")
        If Not (objRS.Eof And objRS.Bof) Then
			bln_ehGerente = True
			chr_Sigla_Orgao_Gerente = objRS("ORGA_SIGLA")
		End if
	    Set objRS = Nothing

    End Sub

    '---------------------------------------------------------------------------------'

    Public Sub BuscaDadosEmbratel(chr_Usuario)
        Dim objSysInfo
	    Dim objUser

        'VAZIO: é igual a pegar o usuário logado no sistema
        If VVVNZ(chr_Usuario) Then
            On Error Resume Next
            Set objSysInfo = Server.CreateObject("ADSystemInfo")
            'response.write "<br>objSysInfo.UserName: " & objSysInfo.UserName & " / <br>objSysInfo.DomainDNSName: " & objSysInfo.DomainDNSName
            chr_Login = objSysInfo.UserName
            On Error Goto 0

            Set objUser = GetObject("LDAP://" & chr_Login)

            chr_Login = objUser.Mail
            chr_Nome_Reduzido = objUser.FullName
            bln_ehFuncionario = True

            Set objSysInfo = Nothing
            Set objUser = Nothing

        'EMAIL: precisa buscar o usuário no AD
        Else

            'monta o DC
            Dim email, adress, dc, str_dc, str_cn
            dc = ""
            str_dc = ""
            email = Split(chr_Usuario, "@")
            adress = Split(email(1), ".")
            'response.Write email(0) & " ---- " & email(1) & "<BR><BR>" & adress(0) & " ---- " & adress(1) & "<BR><BR>"

            For Each dc in adress
                str_dc = str_dc & "DC=" & dc & ","
                'response.Write "DC=" & dc & ","
            Next

            str_cn = "CN=" & email(0)
            str_dc =  Left(str_dc, Len(str_dc) - 1)
            'response.Write "<br><br>str_dc --> " & str_dc & "<BR><BR>"


            'pesquisa no diretorio AD
            Dim conn, strQueryDL, strAttrs, objCmd, objRs

            Set conn = CreateObject("ADODB.Connection")
            conn.Provider = "ADsDSOObject"
            conn.Open "ADs Provider"

            strAttrs = "sAMAccountName,displayName,distinguishedName,mail" ' get attributes
            strQueryDL = "<LDAP:/" & "/" & str_dc & ">;(& (sAMAccountName=" & email(0) & "*) );" & strAttrs & ";SubTree"
            'strQueryDL = "<LDAP://DC=alerj,DC=gov,DC=br>;(& (sAMAccountName=galmeida*) );sAMAccountName,displayName,distinguishedName,mail;SubTree"

            Set objCmd = CreateObject("ADODB.Command")
            objCmd.ActiveConnection = Conn
            'objCmd.Properties("SearchScope") = 2 ' search everything
            'objCmd.Properties("Page Size") = 100 ' bulk operation
            objCmd.CommandText = strQueryDL
    'chr_login = "AQUI:" & strQueryDL
    'chr_usuario = chr_login
    'exit sub
            On Error Resume Next
            Set objRs = objCmd.Execute

    		If oConn.Errors.Count = 0 then
                If Not objRS.Eof Then
                    'Response.Write  objRs.Fields("sAMAccountName") & " / " & objRs.Fields("displayName") & " / " & objRs.Fields("distinguishedName") & "<BR><BR>"
                    chr_Login = objRs.Fields("mail")
                    chr_Nome_Reduzido = objRs.Fields("displayName")
                End If
                bln_TemErro = False
            Else
                bln_TemErro = True
                chr_MsgErro = Err.Description
            End If

            objRs.Close
            Conn.close
            On Error Goto 0

    'chr_login = "AQUI:" & str_dc
    'chr_login = "AQUI:" & objRs.Fields("mail") & " / " & objRs.Fields("displayName")
    'exit sub

            If bln_TemErro Then
                chr_Login = chr_Usuario
                chr_Nome_Reduzido = "****"
            End If


            Set objRs = Nothing
            Set conn = Nothing

            chr_Login = chr_Usuario
        End If

        If VVVNZ(chr_Login) Or bln_TemErro Then
            bln_ehFuncionario = False
        Else
            bln_ehFuncionario = True
        End If

    End Sub


    Public Function ExisteUsuario(chr_Usuario)
	    Dim objUser

        Set objUser = GetObject("LDAP://" & chr_Usuario)

        If VVVNZ(objUser.FullName) Then
	        ExisteUsuario = False
        Else
	        ExisteUsuario = True
        End If

	    Set objUser = Nothing
    End Function


    Public Function AchaNomeEmbratel(chr_Usuario)
	    Dim objUser

        Set objUser = GetObject("LDAP://" & chr_Usuario)
        AchaNomeEmbratel = objUser.FullName
	    Set objUser = Nothing
    End Function

End Class
%>