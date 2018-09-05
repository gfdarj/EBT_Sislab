<%
'------------------------------------------------------------------------------------------------------
'
'   CLASSE EMBRATEL - AQUI PEGA OS DADOS DO USUÁRIO LOGADO NO AD (Active Directory)
'
'------------------------------------------------------------------------------------------------------

Class TEbt

    Private chr_Descricao
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

    Public Property Get Descricao()
        Descricao = chr_Descricao
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

        chr_Descricao = ""
        chr_Login = ""
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

        Call BuscaDadosEmbratel(chr_Usuario)    'Preenche as vari?veis Login e FullName, vindas do AD

        '--- SE ESTIVERMOS LOCALMENTE COLOCO O USUARIO GERENTE
        If Application("SISLAB_AMBIENTE") = "LOC_CASA" And chr_Login = "" Then
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
            chr_Descricao = ""
	    Else
		    bln_usuarioCRT = True
		    bln_ehRT = CBool(objRS("RT"))
		    bln_ehRAT = CBool(objRS("RAT"))
		    bln_ehGQ = CBool(objRS("GQ"))
		    bln_usuarioCRT_Cadastrado = True
		    int_PerfilSCE = IIf(IsNull(objRS("ID_PERFIL_SCE")), 0, objRS("ID_PERFIL_SCE"))
		    bln_UsuarioSCE = (int_PerfilSCE > 0)
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
        Dim strNTUser, strUser
        Dim email, adress, dc, str_dc, str_cn

        'monta o DC
        dc = ""
        str_dc = ""

'chr_login =    Request.ServerVariables("AUTH_USER")
'exit sub

        'VAZIO: Pega o usuario logado no sistema
        If VVVNZ(chr_Usuario) Then
            strNTUser = Request.ServerVariables("AUTH_USER")

            If strNTUser = "" Then Exit Sub

            email = Split(strNTUser, "\")  'Mid(strNTUser,(instr(1,strNTUser,"\")+1),len(strNTUser))

            str_cn = "CN=" & email(1)

            'Verifica o domínio do usuário logado
            If UCase(Trim(email(0))) = "EMBRATEL" Then
                str_dc = "DC=nt,DC=embratel,DC=com,DC=br"
            ElseIf UCase(Trim(email(0))) = "CLARO" Then
                str_dc = "DC=claro,DC=com,DC=br"
            ElseIf UCase(Trim(email(0))) = "AL" Then
                str_dc = "DC=alerj,DC=gov,DC=br"
            Else
                str_dc = "DC=net,DC=com,DC=br"
            End If

            strUser = email(1)

        'EMAIL: precisa buscar o usuario no AD
        Else

            If InStr(1, chr_Usuario, "@") = 0 Then
                chr_Usuario = Trim(chr_Usuario) & SUFIXOEMAIL
            End If

            email = Split(chr_Usuario, "@")
            adress = Split(email(1), ".")
            'response.Write email(0) & " ---- " & email(1) & "<BR><BR>" & adress(0) & " ---- " & adress(1) & "<BR><BR>"
            For Each dc in adress
                str_dc = str_dc & "DC=" & dc & ","
                'response.Write "DC=" & dc & ","
            Next

            strUser = email(0)
            str_cn = "CN=" & email(0)
            str_dc =  Left(str_dc, Len(str_dc) - 1)
            'response.Write "<br><br>str_dc --> " & str_dc & "<BR><BR>"
        End If

'chr_login = "AQUI:" & str_cn & "<BR>str_dc:" & str_dc
'chr_usuario = str_dc
'exit sub

        'pesquisa no diretorio AD
        Dim conn, strQueryDL, strAttrs, objCmd, objRs, strRootTDSE

        Set conn = CreateObject("ADODB.Connection")
        conn.Provider = "ADsDSOObject"
        conn.Open "Active Directory Provider"   '"ADs Provider"

        strAttrs = "sAMAccountName, distinguishedName, givenName, displayName, description, telephoneNumber, mail, streetAddress, " & _ 
                   "title, department, otherHomePhone, mobile, otherMobile, " & _
                   "ipPhone, otherIpPhone, info, manager " ' get attributes
        'strQueryDL = "<LDAP:/ /" & str_dc & ">;(& (sAMAccountName=" & strUser & "*) );" & strAttrs & ";SubTree"
        'strQueryDL = "<LDAP:/ /DC=alerj,DC=gov,DC=br>;(& (sAMAccountName=galmeida*) );sAMAccountName,displayName,distinguishedName,mail;SubTree"

        Set objRootDSE = GetObject("LDAP://rootDSE")
        strRootTDSE = objRootDSE.Get("defaultNamingContext")

        strQueryDL = _
            "SELECT " & strAttrs & _
                "FROM 'LDAP://" & strRootTDSE & "' " & _
                "WHERE objectCategory='user' AND sAMAccountName = '" & strUser & "'" 

        Set objCmd = CreateObject("ADODB.Command")
        objCmd.ActiveConnection = Conn
        'objCmd.Properties("SearchScope") = 2 ' search everything
        'objCmd.Properties("Page Size") = 100 ' bulk operation
        objCmd.CommandText = strQueryDL

'        On Error Resume Next
        Set objRs = objCmd.Execute

        chr_login = strUser

    	If conn.Errors.Count = 0 then
            If Not objRS.Eof Then
                If VVVNZ(objRs.Fields("mail")) Then
                    chr_Login = objRs.Fields("sAMAccountName")
                Else
                    chr_Login = objRs.Fields("mail")
                End If
                chr_Nome_Reduzido = objRs.Fields("displayName")
                chr_Ramal = objRs.Fields("telephoneNumber")
                chr_Celular = objRs.Fields("mobile")
                chr_Descricao = objRs.Fields("description")
            End If
            bln_TemErro = False
        Else
            bln_TemErro = True
            chr_MsgErro = Err.Description
        End If

        objRs.Close
        Conn.close
        On Error Goto 0

'    chr_login = "AQUI:" & chr_Celular & " ---- " & chr_login
    'chr_login = "AQUI:" & objRs.Fields("mail") & " / " & objRs.Fields("displayName")
'    exit sub

        If bln_TemErro Then
            chr_Login = chr_Usuario
            chr_Nome_Reduzido = "****"
        End If

        Set objRs = Nothing
        Set conn = Nothing

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