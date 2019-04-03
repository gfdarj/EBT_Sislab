<%



dim xmlResult : xmlResult = "<?xml version=""1.0"" encoding=""UTF-8""?>" & _
    "<Usuario><DN>CN=galmeida,OU=CORC,OU=Departamentos,OU=ALERJ,DC=alerj,DC=gov,DC=br</DN>" & _
    "<Email>galmeida@alerj.rj.gov.br</Email><Nome>Gilberto Almeida</Nome><CodigoLotacao>CodigoLotacao 1</CodigoLotacao>" & _
    "<Departamento>Departamento 1</Departamento>" & _
    "<Diretoria>Diretoria 1</Diretoria><Sexo>Masc</Sexo><CategoriaEmpregado>CategoriaEmpregado 1</CategoriaEmpregado>" & _
    "<DataAdmissao>DataAdmissao 1</DataAdmissao><AreaLotacao>AreaLotacao 1</AreaLotacao>" & _
    "<CategoriaCargo>CategoriaCargo 1</CategoriaCargo><Lotacao>Lotacao 1</Lotacao><Matricula>Matricula 1</Matricula>" & _
    "<DataNascimento>23/01/1975</DataNascimento><Empresa>Empresa 1</Empresa>" & _
    "<Telefone>Telefone 1</Telefone><Celular>Celular 12</Celular></Usuario>"



chr_Login = ValorXML(xmlResult, "Email")
chr_Nome_Reduzido = ValorXML(xmlResult, "Nome>")
chr_Ramal = ValorXML(xmlResult, "Ramal")
chr_Celular = ValorXML(xmlResult, "Celular")
chr_Matricula = ValorXML(xmlResult, "Matricula")
chr_Empresa = ValorXML(xmlResult, "Empresa")
chr_CodigoLotacao = ValorXML(xmlResult, "CodigoLotacao")
chr_Departamento = ValorXML(xmlResult, "Departamento")
chr_Diretoria = ValorXML(xmlResult, "Diretoria")
chr_Sexo = ValorXML(xmlResult, "Sexo")
chr_CategoriaEmpregado = ValorXML(xmlResult, "CategoriaEmpregado")
chr_DataAdmissao = ValorXML(xmlResult, "DataAdmissao")
chr_AreaLotacao = ValorXML(xmlResult, "AreaLotacao")
chr_CategoriaCargo = ValorXML(xmlResult, "CategoriaCargo")
chr_Lotacao = ValorXML(xmlResult, "Lotacao")
chr_DataNascimento = ValorXML(xmlResult, "DataNascimento")

response.write nOW
response.write "<BR><BR>chr_Login: " & chr_Login
response.write "<BR><BR>chr_Nome_Reduzido: " & chr_Nome_Reduzido 
response.write "<BR><BR>chr_Ramal: " & chr_Ramal 
response.write "<BR><BR>chr_Celular: " & chr_Celular 
response.write "<BR><BR>chr_Matricula: " & chr_Matricula 
response.write "<BR><BR>chr_Empresa: " & chr_Empresa 
response.write "<BR><BR>chr_CodigoLotacao: " & chr_CodigoLotacao 
response.write "<BR><BR>chr_Departamento: " & chr_Departamento 
response.write "<BR><BR>chr_Diretoria: " & chr_Diretoria 
response.write "<BR><BR>chr_Sexo: " & chr_Sexo 
response.write "<BR><BR>chr_CategoriaEmpregado: " & chr_CategoriaEmpregado 
response.write "<BR><BR>chr_DataAdmissao: " & chr_DataAdmissao
response.write "<BR><BR>chr_AreaLotacao: " & chr_AreaLotacao 
response.write "<BR><BR>chr_CategoriaCargo: " & chr_CategoriaCargo 
response.write "<BR><BR>chr_Lotacao: " & chr_Lotacao 
response.write "<BR><BR>chr_DataNascimento: " & chr_DataNascimento 


Function ValorXML(str, tag)
    Dim ini, fim
    ini = InStr(1, str, "<" & tag & ">")
    fim = InStr(1, str, "</" & tag & ">")
    If fim - ini > 0 Then
        ValorXML = Mid(str, ini, fim - ini)
    Else
        ValorXML = ""
    End If
End Function


response.End


    chr_Usuario=""

        Dim objSysInfo
	    Dim objUser
        Dim strNTUser, strUser
        Dim email, adress, dc, str_dc, str_cn

        'monta o DC
        dc = ""
        str_dc = ""

        'VAZIO: Pega o usuario logado no sistema
        If chr_Usuario = "" Then
            strNTUser = Request.ServerVariables("AUTH_USER")
            email = Split(strNTUser, "\")  'Mid(strNTUser,(instr(1,strNTUser,"\")+1),len(strNTUser))

            str_cn = "CN=" & email(1)

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
                chr_Usuario = Trim(chr_Usuario) & Application("SISLAB_EMAIL_SUFIXO")
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


        'pesquisa no diretorio AD
        Dim conn, strQueryDL, strAttrs, objCmd, objRs, strRootTDSE

        Set conn = CreateObject("ADODB.Connection")
        conn.Provider = "ADsDSOObject"
        conn.Open "ADs Provider"  '"Active Directory Provider"

        strAttrs = "distinguishedName, givenName, displayName, description, telephoneNumber, mail, streetAddress, " & _ 
                   "title, department, otherHomePhone, pager, otherPager, mobile, otherMobile, " & _
                   "facsimileTelephoneNumber, otherFacsimileTelephoneNumber, ipPhone, otherIpPhone, info, manager" ' get attributes
'        strAttrs = "distinguishedName, givenName, displayName, description, telephoneNumber, mail, streetAddress, " & _ 
'                   "title, department, companyhomePhone, otherHomePhone, pager, otherPager, mobile, otherMobile, " & _
'                   "facsimileTelephoneNumber, otherFacsimileTelephoneNumber, ipPhone, otherIpPhone, info, manager" ' get attributes
        strQueryDL = "<LDAP://" & str_dc & ">;(& (objectCategory=person)(objectClass=user)(sAMAccountName=" & strUser & "*) );" & strAttrs & ";SubTree"
        'strQueryDL = "<LDAP:/ /DC=alerj,DC=gov,DC=br>;(& (sAMAccountName=galmeida*) );sAMAccountName,displayName,distinguishedName,mail;SubTree"

        Set objRootDSE = GetObject("LDAP://rootDSE")
        strRootTDSE = objRootDSE.Get("defaultNamingContext")

chr_login = "AQUI:" & str_cn & "<BR>str_dc:" & str_dc
chr_usuario = str_dc

response.write "<br>chr_login: " & chr_login
response.write "<br>chr_usuario: " & chr_usuario
response.write "<br>strQueryDL: " & strQueryDL


        'strQueryDL = _
        '    "SELECT " & strAttrs & _
        '        "FROM 'LDAP://" & strRootTDSE & "' " & _
        '        "WHERE objectCategory='user' AND sAMAccountName = '" & strUser & "'" 

        Set objCmd = CreateObject("ADODB.Command")
        objCmd.ActiveConnection = Conn
        'objCmd.Properties("SearchScope") = 2 ' search everything
        'objCmd.Properties("Page Size") = 100 ' bulk operation
        objCmd.CommandText = strQueryDL

'        On Error Resume Next
        Set objRs = objCmd.Execute

chr_login = strUser & "1"

'    	If oConn.Errors.Count = 0 then
'            If Not objRS.Eof Then
'                'Response.Write  objRs.Fields("sAMAccountName") & " / " & objRs.Fields("displayName") & " / " & objRs.Fields("distinguishedName") & "<BR><BR>"
'
'                If objRs.Fields("mail")="" Then
'                    'chr_Login = objRs.Fields("Mail")
'                    chr_Login = objRs.Fields("sAMAccountName")
'                Else
'                    chr_Login = objRs.Fields("sAMAccountName")
'                End If
'
'                chr_Nome_Reduzido = objRs.Fields("displayName")
'            End If
'            bln_TemErro = False
'        Else
'            bln_TemErro = True
'            chr_MsgErro = Err.Description
'        End If
'
'        objRs.Close
'        Conn.close
'        On Error Goto 0

    'chr_login = "AQUI:" & str_dc
    'chr_login = "AQUI:" & objRs.Fields("mail") & " / " & objRs.Fields("displayName")
'    exit sub

        If bln_TemErro Then
            chr_Login = chr_Usuario
            chr_Nome_Reduzido = "****"
        End If

        Set objRs = Nothing
        Set conn = Nothing

        If chr_Login="" Or bln_TemErro Then
            bln_ehFuncionario = False
        Else
            bln_ehFuncionario = True
        End If

%>
