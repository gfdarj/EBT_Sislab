<!--#include file="Classe_WebService.asp"-->
<%
'------------------------------------------------------------------------------------------------------
'
'   CLASSE EMBRATEL - AQUI PEGA OS DADOS DO USUÁRIO LOGADO NO AD (Active Directory)
'
'------------------------------------------------------------------------------------------------------

Class TEbtWs

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
    Private chr_CodigoLotacao
    Private chr_Departamento
    Private chr_Diretoria
    Private chr_Sexo
    Private chr_CategoriaEmpregado
    Private chr_DataAdmissao
    Private chr_AreaLotacao
    Private chr_CategoriaCargo
    Private chr_Lotacao
    Private chr_DataNascimento
    Private chr_Empresa

    Private oSql


    '-Property------------------------------------------------------------------------'

    Public Property Get CodigoLotacao()
        CodigoLotacao = chr_CodigoLotacao
    End Property

    Public Property Get Departamento()
        Departamento = chr_Departamento
    End Property

    Public Property Get Diretoria()
        Diretoria = chr_Diretoria
    End Property

    Public Property Get Sexo()
        Sexo = chr_Sexo
    End Property

    Public Property Get CategoriaEmpregado()
        CategoriaEmpregado = chr_CategoriaEmpregado
    End Property

    Public Property Get DataAdmissao()
        DataAdmissao = chr_DataAdmissao
    End Property

    Public Property Get AreaLotacao()
        AreaLotacao = chr_AreaLotacao
    End Property

    Public Property Get CategoriaCargo()
        CategoriaCargo = chr_CategoriaCargo
    End Property

    Public Property Get Lotacao()
        Lotacao = chr_Lotacao
    End Property

    Public Property Get DataNascimento()
        DataNascimento = chr_DataNascimento
    End Property

    Public Property Get Empresa()
        Empresa = chr_Empresa
    End Property

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
		bln_UsuarioSCE = False
		int_PerfilSCE = 0
		chr_Sigla_Orgao = ""
        chr_Ramal = ""
		bln_ehGerente = False
		chr_Sigla_Orgao_Gerente = ""
        chr_Nome_Reduzido = ""
        bln_ehFuncionario = False
        chr_CodigoLotacao = ""      :         chr_Departamento = "" :        chr_Diretoria = ""         :         chr_Sexo = ""
        chr_CategoriaEmpregado = "" :         chr_DataAdmissao = "" :        chr_AreaLotacao = ""       :         chr_CategoriaCargo = ""
        chr_Lotacao = ""            :         chr_Matricula = ""    :        chr_DataNascimento = ""    :         chr_Empresa = ""
    End Sub


    Private Sub Class_Terminate()
        Set oSQL = Nothing
    End Sub


    'WebService
    Private Sub InicializaWebService()
        Set ws = New Twebservice
        ws.url = Application("SISLAB_HTTP_WEBSERVICE")
    End Sub

    Private Sub FinalizaWebService()
        Set ws = Nothing
    End Sub

    Public Function WS_ObtemUsuarioAD(usuario)
        ws.method = "ObtemUsuarioAD"
        ws.parameters.Add "login", usuario
        ws.InvokeBinary
        ObtemUsuarioAD = ws.Response
        Retorno = "word"
        Arquivo = ws.method & ".docx"
    End Function



    Public Sub LoginUsuario(chr_Usuario)
	    Dim chr_SQL
	    Dim objRS
        Dim bln_EhAmbienteLocal

        chr_Login = ""

        Call BuscaDadosEmbratelAD(chr_Usuario)    'Preenche as vari?veis Login e FullName, vindas do AD

        '--- SE ESTIVERMOS LOCALMENTE COLOCO O USUARIO GERENTE
        If chr_Login = "" Then
            chr_Login = "josesp@embratel.com.br"
        End If

	    '-- Pega os dados do usuario se for do CRT
	    chr_SQL = "SELECT u.USERID, u.RAT, u.GQ, u.RT, u.EXIBIR, u.ID_PERFIL_SCE, u.CELULAR, u.RAMAL, u.MATRICULA, " & _
                  "     o.ORGA_SIGLA, o.ORGA_DESCRICAO, o.ORGA_USERIDCHEFE " & _
                  "FROM UserCRT u LEFT JOIN Orgao o ON u.ORGA_ID = o.ORGA_ID " & _
                  "WHERE LOWER(USERID) = '" & chr_Login & "'"
	    Set objRS = oSQL.Executar(chr_SQL)

	    If objRS.BOF And objRS.EOF Then 
		    bln_usuarioCRT = False
		    bln_ehRT = False
		    bln_ehRAT = true
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
        This.LoginUsuario(chr_Usuario)
    End Sub

    'Busca os dados do AD
    Public Sub BuscaDadosEmbratelAD(chr_Usuario)
        Dim objSysInfo
	    Dim objUser
        Dim strNTUser, strUser
        Dim email, adress, dc, str_dc, str_cn
        Dim ldap_testeAL

        'monta o DC
        dc = ""
        str_dc = ""
        ldap_testeAL = False

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
                ldap_testeAL = True
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

        If ldap_testeAL Then
            strAttrs = _
                "sAMAccountName, distinguishedName, displayname, mail, description"
        Else
            strAttrs = _
                "sAMAccountName, distinguishedName, description, embratellotacao, department, displayname, mail, embrateldescdsmdlotacao, embratelsexo, " & _
                "embratelcatempregado, embrateladmissao, embratelarealotacao, embratelcatcargo, embrateldesclotacao, employeeid, " & _
                "embrateldatanasc, company, telephonenumber, mobile"
        End If

        Set objRootDSE = GetObject("LDAP://rootDSE")
        strRootTDSE = objRootDSE.Get("defaultNamingContext")

        strQueryDL = _
            "SELECT " & strAttrs & " " & _
                "FROM 'LDAP://" & strRootTDSE & "' " & _
                "WHERE objectCategory='user' AND sAMAccountName = '" & strUser & "'" 

        Set objCmd = CreateObject("ADODB.Command")
        objCmd.ActiveConnection = Conn
        'objCmd.Properties("SearchScope") = 2 ' search everything
        'objCmd.Properties("Page Size") = 100 ' bulk operation
        objCmd.CommandText = strQueryDL

        'On Error Resume Next
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
                chr_Descricao = objRs.Fields("description")

                If Not ldap_testeAL Then
                    chr_Ramal = objRs.Fields("telephoneNumber")
                    chr_Celular = objRs.Fields("mobile")
                    chr_Matricula = objRs.Fields("employeeid")
                    chr_Empresa = objRs.Fields("company")
                    chr_CodigoLotacao = objRs.Fields("embratellotacao")
                    chr_Departamento = objRs.Fields("department")
                    chr_Diretoria = objRs.Fields("embrateldescdsmdlotacao")
                    chr_Sexo = objRs.Fields("embratelsexo")
                    chr_CategoriaEmpregado = objRs.Fields("embratelcatempregado")
                    chr_DataAdmissao = objRs.Fields("embrateladmissao")
                    chr_AreaLotacao = objRs.Fields("embratelarealotacao")
                    chr_CategoriaCargo = objRs.Fields("embratelcatcargo")
                    chr_Lotacao = objRs.Fields("embrateldesclotacao")
                    chr_DataNascimento = objRs.Fields("embrateldatanasc")
                End If
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