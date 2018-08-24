<!--#include file="includes/PadraoHTML.asp" -->
<!--#include file="Global.asa"-->
<!--#include file="includes/EmailHTML.asp" -->
<!--#include file="includes/global.asp" -->
<!--#include file="includes/Sislab_Lib.asp"-->
<%
    chr_Usuario=""

        'VAZIO: é igual a pegar o usuário logado no sistema
        If VVVNZ(chr_Usuario) Then
            On Error Resume Next
            Set objSysInfo = Server.CreateObject("ADSystemInfo")
            'response.write "<br>objSysInfo.UserName: " & objSysInfo.UserName & " / <br>objSysInfo.DomainDNSName: " & objSysInfo.DomainDNSName
            chr_Login = objSysInfo.UserName
            On Error Goto 0

            Set objUser = GetObject("LDAP://" & chr_Login)
            'Set objUser = GetObject("LDAP://RootDSE")

            chr_Login = objUser.Mail
            chr_Nome_Reduzido = objUser.FullName
            bln_ehFuncionario = True

            response.Write "chr_Login: " & objUser.mail
            response.Write "<br>samaccountname: " & objUser.samaccountname
            response.Write "<br>chr_Nome_Reduzido: " & chr_Nome_Reduzido
            response.Write "<br>bln_ehFuncionario: " & bln_ehFuncionario

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
            response.Write email(0) & " ---- " & email(1) & "<BR><BR>" & adress(0) & " ---- " & adress(1) & "<BR><BR>"

            For Each dc in adress
                str_dc = str_dc & "DC=" & dc & ","
                response.Write "DC=" & dc & ","
            Next

            str_cn = "CN=" & email(0)
            str_dc =  Left(str_dc, Len(str_dc) - 1)
            response.Write "<br><br>str_dc --> " & str_dc & "<BR><BR>"


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



%>
