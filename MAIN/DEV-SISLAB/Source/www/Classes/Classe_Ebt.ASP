<!--#include file="Classe_WebService.asp"-->
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


    '-WebService------------------------------------------------------------------------'
    Private Sub InicializaWebService()
        Set ws = New Twebservice
        ws.url = Application("SISLAB_HTTP_WEBSERVICE")
    End Sub

    Private Sub FinalizaWebService()
        Set ws = Nothing
    End Sub

    Public Function WS_ObtemUsuarioAD(usuario)
        Call InicializaWebService()
        ws.method = "ObtemUsuarioAD"
        ws.parameters.Add "login", usuario
        ws.InvokeBinary
        WS_ObtemUsuarioAD = ws.Response
        Call FinalizaWebService()
    End Function


    '-Métodos------------------------------------------------------------------------'
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
        Dim xmlResult

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

        'Faz requisição para o WebService
        xmlResult = WS_ObtemUsuarioAD(strUser)

        chr_Login = Mid(xmlResult, Instr(1, "<Email>") + 7, InStr(1, "</Email>") + 8)
        chr_Nome_Reduzido = Mid(xmlResult, Instr(1, "<Nome>") + 6, InStr(1, "</Nome>") + 7)
        chr_Ramal = Mid(xmlResult, Instr(1, "<Ramal>") + 6, InStr(1, "</Ramal>") + 8)
        chr_Celular = Mid(xmlResult, Instr(1, "<Celular>") + 9, InStr(1, "</Celular>") + 10)
        chr_Matricula = Mid(xmlResult, Instr(1, "<Matricula>") + 11, InStr(1, "</Matricula>") + 12)
        chr_Empresa = Mid(xmlResult, Instr(1, "<Empresa>") + 9, InStr(1, "</Empresa>") + 10)
        chr_CodigoLotacao = Mid(xmlResult, Instr(1, "<CodigoLotacao>") + 15, InStr(1, "</CodigoLotacao>") + 16)
        chr_Departamento = Mid(xmlResult, Instr(1, "<Departamento>") + 14, InStr(1, "</Departamento>") + 15)
        chr_Diretoria = Mid(xmlResult, Instr(1, "<Diretoria>") + 11, InStr(1, "</Diretoria>") + 12)
        chr_Sexo = Mid(xmlResult, Instr(1, "<Sexo>") + 6, InStr(1, "</Sexo>") + 7)
        chr_CategoriaEmpregado = Mid(xmlResult, Instr(1, "<CategoriaEmpregado>") + 20, InStr(1, "</CategoriaEmpregado>") + 21)
        chr_DataAdmissao = Mid(xmlResult, Instr(1, "<DataAdmissao>") + 14, InStr(1, "</DataAdmissao>") + 15)
        chr_AreaLotacao = Mid(xmlResult, Instr(1, "<AreaLotacao>") + 13, InStr(1, "</AreaLotacao>") + 14)
        chr_CategoriaCargo = Mid(xmlResult, Instr(1, "<CategoriaCargo>") + 16, InStr(1, "</CategoriaCargo>") + 17)
        chr_Lotacao = Mid(xmlResult, Instr(1, "<Lotacao>") + 9, InStr(1, "</Lotacao>") + 10)
        chr_DataNascimento = Mid(xmlResult, Instr(1, "<DataNascimento>") + 16, InStr(1, "</DataNascimento>") + 17)

'chr_login = "AQUI:" & str_cn & "<BR>str_dc:" & str_dc
'chr_usuario = str_dc
'exit sub


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