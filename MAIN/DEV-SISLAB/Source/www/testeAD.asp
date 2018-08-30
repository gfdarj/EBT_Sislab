<!DOCTYPE html>
<html>
    <head>
        <meta charset="utf-8" />
        <title>AD - SISLAB - TESTE</title>
    </head>
    <body>
<%
Dim txtUsuario
txtUsuario = Request("txtUsuario")

Dim strNTUser, strUser, strDN, strRootTDSE
Dim objRootDSE, objConnection, objCommand, objRecordSet, objUser, objNTUserInfo
Dim net

set net = createobject("wscript.network")

strNTUser = Request.ServerVariables("AUTH_USER")
strUser = Mid(strNTUser,(instr(1,strNTUser,"\")+1),len(strNTUser))

Set objConnection = Server.CreateObject("ADODB.Connection")
Set objCommand = Server.CreateObject("ADODB.Command")
objConnection.Provider = "ADsDSOObject"
objConnection.Open "Active Directory Provider"
Set objCommand.ActiveConnection = objConnection

'objCommand.Properties("Page Size") = 1000'
objCommand.Properties("Searchscope") = 2 'ADS_SCOPE_SUBTREE 

Set objRootDSE = GetObject("LDAP://rootDSE")
'Set objRootDSE = GetObject("LDAP://alerj.rj.gov.br")
strRootTDSE = objRootDSE.Get("defaultNamingContext")

IF txtUsuario = "" Then
    txtUsuario = net.UserName
End If

objCommand.CommandText = _
    "SELECT distinguishedName, givenName, displayName, description, telephoneNumber, mail, streetAddress, title, department, company " & _
        ", homePhone, otherHomePhone, pager, otherPager, mobile, otherMobile, facsimileTelephoneNumber, otherFacsimileTelephoneNumber, ipPhone, otherIpPhone, info, manager " & _
        "FROM 'LDAP://" & strRootTDSE & "' " & _
        "WHERE objectCategory='user' AND sAMAccountName = '" & txtUsuario & "'" 

Set objRecordSet = objCommand.Execute

If Not objRecordSet.BOF Then objRecordSet.MoveFirst
If Not objRecordSet.EOF Then
    response.Write "<h1>Entrei no If EOF strDN !!!!!!!!!!!!!!</h1>"
    While Not objRecordSet.Eof
        strDN = objRecordSet.Fields("distinguishedName").Value
'        response.Write "strDN: " & strDN & "<br><br>"

Response.Write "<BR>RootDSE: " & strRootTDSE
Response.Write "<BR>DN: " & objRecordSet.Fields("distinguishedName")
Response.Write "<BR>"
Response.Write "<BR>GENERAL"
Response.Write "<BR>First name: " & objRecordSet.Fields("givenName")
'Response.Write "<BR>Initials: " & objRecordSet.Fields("initials")
'Response.Write "<BR>Last name: " & objRecordSet.Fields("sn")
Response.Write "<BR>Display name: " & objRecordSet.Fields("displayName")
'Response.Write "<BR>Description: " & objRecordSet.Fields("description")
'Response.Write "<BR>Office: " & objRecordSet.Fields("physicalDeliveryOfficeName")
Response.Write "<BR>Telephone number: " & objRecordSet.Fields("telephoneNumber")
'Response.Write "<BR>Other Telephone numbers: " & objRecordSet.Fields("otherTelephone")
Response.Write "<BR>Email: " & objRecordSet.Fields("mail")
'Response.Write "<BR>Web page: " & objRecordSet.Fields("wWWHomePage")
'Response.Write "<BR>Other Web pages: " & objRecordSet.Fields("url")
Response.Write "<BR>"
Response.Write "<BR>ADDRESS"
Response.Write "<BR>Street: " & objRecordSet.Fields("streetAddress")
'Response.Write "<BR>P.O. Box: " & objRecordSet.Fields("postOfficeBox")
'Response.Write "<BR>City: " & objRecordSet.Fields("l")
'Response.Write "<BR>State/province: " & objRecordSet.Fields("st")
'Response.Write "<BR>Zip/Postal Code: " & objRecordSet.Fields("postalCode")
'Response.Write "<BR>Country/region: " & objRecordSet.Fields("countryCode")
Response.Write "<BR>"
'Response.Write "<BR>ACCOUNT"
'Response.Write "<BR>User logon name: " & objRecordSet.Fields("userPrincipalName")
'Response.Write "<BR>pre-Windows 2000 logon name: " & objRecordSet.Fields("sAMAccountName")
'Response.Write "<BR>AccountDisabled: " & objRecordSet.Fields("AccountDisabled")
'Response.Write "<BR>Logon Hours: " & CStr(objRecordSet.Fields("logonHours"))
'Response.Write "<BR>Logon On To (Logon Workstations): " & objRecordSet.Fields("userWorkstations")
'Response.Write "<BR>User cannot change password: " & objRecordSet.Fields("userAccountControl")
'Response.Write "<BR>Password never expires: " & objRecordSet.Fields("userAccountControl")
'Response.Write "<BR>Store password using reversible encryption: " & objRecordSet.Fields("userAccountControl")
'Response.Write "<BR>"
'Response.Write "<BR>PROFILE"
'Response.Write "<BR>Profile path: " & objRecordSet.Fields("profilePath")
'Response.Write "<BR>Logon script: " & objRecordSet.Fields("scriptPath")
'Response.Write "<BR>Home folder, local path: " & objRecordSet.Fields("homeDirectory")
'Response.Write "<BR>Home folder, Connect, Drive: " & objRecordSet.Fields("homeDrive")
'Response.Write "<BR>Home folder, Connect, To:: " & objRecordSet.Fields("homeDirectory")
'Response.Write "<BR>"
'Response.Write "<BR>TELEPHONE"
Response.Write "<BR>Home: " & objRecordSet.Fields("homePhone")
Response.Write "<BR>Other Home phone numbers: " & objRecordSet.Fields("otherHomePhone")
Response.Write "<BR>Pager: " & objRecordSet.Fields("pager")
'Response.Write "<BR>Other Pager numbers: " & CStr(objRecordSet.Fields("otherPager"))
Response.Write "<BR>Mobile: " & objRecordSet.Fields("mobile")
Response.Write "<BR>Other Mobile numbers: " & objRecordSet.Fields("otherMobile")
Response.Write "<BR>Fax: " & objRecordSet.Fields("facsimileTelephoneNumber")
Response.Write "<BR>Other Fax numbers: " & objRecordSet.Fields("otherFacsimileTelephoneNumber")
Response.Write "<BR>IP phone: " & objRecordSet.Fields("ipPhone")
Response.Write "<BR>Other IP phone numbers: " & objRecordSet.Fields("otherIpPhone")
Response.Write "<BR>Notes: " & objRecordSet.Fields("info")
Response.Write "<BR>"
Response.Write "<BR>ORGANISATION"
Response.Write "<BR>Title: " & objRecordSet.Fields("title")
Response.Write "<BR>Department: " & objRecordSet.Fields("department")
Response.Write "<BR>Company: " & objRecordSet.Fields("company")
Response.Write "<BR>Manager: " & objRecordSet.Fields("manager")
Response.Write "<BR><hr>"

        objRecordSet.MoveNext
    WEnd
End If

response.write "<BR><h3>FORA DO LOOP !!!</h3>" & now
response.write "<br><br>AUTH_USER: " & Request.ServerVariables("AUTH_USER")
response.write "<br><br>net.UserName: " & net.UserName
response.write "<br><br>net.UserDomain: " & net.UserDomain
response.write "<br><br>strNTUser: " & strNTUser
response.write "<br><br>strUser: " & strUser
response.write "<br><br>strRootTDSE: " & strRootTDSE
response.write "<br><br>objCommand.CommandText: " & objCommand.CommandText
'response.write "<br><br>fullname: " & objUser.fullname
'response.write "<br><br>Mail: " & objUser.mail

response.write "<br><hr>FIM"
'response.End
%>

        <form>
            Username: <input type="text" name="txtUsuario" />
            <input type="submit" value="Enviar" />
        </form>

    </body>
</html>