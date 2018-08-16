<%
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
strRootTDSE = objRootDSE.Get("defaultNamingContext")
Set objRootDSE = Nothing

objCommand.CommandText = _
    "SELECT distinguishedName FROM 'LDAP://" & strRootTDSE & "' " & _
        "WHERE objectCategory='user' AND sAMAccountName = '" & net.UserName & "'" 
'objCommand.CommandText = _
'    "SELECT distinguishedName FROM 'LDAP://" & strRootTDSE & "' " & _
'        "WHERE objectCategory='user' AND sAMAccountName = '" & strUser & "'" 

Set objRecordSet = objCommand.Execute

If Not objRecordSet.BOF Then objRecordSet.MoveFirst
If Not objRecordSet.EOF Then
     response.Write "strDN !!!!!!!!!!!!!!<br>"
    While Not objRecordSet.Eof
        strDN = objRecordSet.Fields("distinguishedName").Value
        response.Write "strDN: " & strDN & "<br>"
        objRecordSet.MoveNext
    WEnd
End If


response.write "MAMAMIA !!! " & now
response.write "<br><br>net.UserName: " & net.UserName
response.write "<br><br>net.UserDomain: " & net.UserDomain
response.write "<br><br>strNTUser: " & strNTUser
response.write "<br><br>strUser: " & strUser
response.write "<br><br>strRootTDSE: " & strRootTDSE
response.write "<br><br>objCommand.CommandText: " & objCommand.CommandText
'response.write "<br><br>fullname: " & objUser.fullname
'response.write "<br><br>Mail: " & objUser.mail

response.write "<br><br><br>AQUI ! executou !: "
response.End


Set objConnection = Nothing
Set objCommand = Nothing
Set objRecordSet = Nothing

Set objUser = GetObject("LDAP://" & strDN)




'====FUNCIONADO===============================================================================

'Dim net
'set net = Server.CreateObject("wscript.network")

'RESPONSE.wRITE "<br>net.username: " & net.username
'RESPONSE.wRITE "<br>net.UserDomain: " & net.UserDomain
'response.write "<br>request.servervariables(LOGON_USER): " & request.servervariables("LOGON_USER")

'Dim objSysInfo
'Dim objUsuario
'Dim objGrupo
'Dim objColl
		
'Criação dos objetos
'Set objSysInfo	= Server.CreateObject("ADSystemInfo")

'response.write "<br>objSysInfo.UserName: " & objSysInfo.UserName
'response.write "<br>objSysInfo.DomainDNSName: " & objSysInfo.DomainDNSName

'Set objUser = GetObject("LDAP://" & objSysInfo.UserName)

'response.write "<br><br>fullname: " & objUser.fullname
'response.write "<br><br>Mail: " & objUser.mail

'response.write "<br><br><br>AQUI !: "
'response.End

'====FUNCIONADO===============================================================================





'=========Account and connection string information for LDAP=======
Set objDomain = GetObject ("GC://RootDSE")
objADsPath = objDomain.Get("defaultNamingContext")
Set objDomain = Nothing
Set objConn = Server.CreateObject("ADODB.Connection")
objConn.provider ="ADsDSOObject"
'objConn.Properties("User ID") = "al\galmeida" 'domain account with read access to LDAP
'objConn.Properties("Password") = "230175" 'domain account password
'objConn.Properties("Encrypt Password") = True
objConn.open "Active Directory Provider"

Set objCom = CreateObject("ADODB.Command")
Set objCom.ActiveConnection = objConn
objCom.CommandText ="select name,telephonenumber,mobile,mail,company,title,department,sAMAccountName,sn,userAccountControl,msexchhidefromaddresslists FROM 'GC://"+objADsPath+"' where sAMAccountname='*' ORDER by sAMAccountname"


'=======Executre queury on LDAP for all accounts=========
Set objRS = objCom.Execute

'Loop through records and write out all information using ASP
Response.Write "<center><table>"

Do While Not objRS.EOF Or objRS.BOF
Response.Write "<tr>"
Response.Write "<td>"
Response.Write objRS("name")
Response.Write "</td><td>"
Response.Write objRS("mail")
Response.Write "</td><td>"
Response.Write objRS("telephonenumber")
Response.Write "</td><td>"
Response.Write objRS("mobile")
Response.Write "</td><td>"
Response.Write objRS("company")
Response.Write "</td><td>"
Response.Write objRS("department")
Response.Write "</td><td>"
Response.Write objRS("title")
Response.Write "</td><td>"
Response.Write objRS("userAccountControl")
Response.Write "</td><td>"
Response.Write objRS("sAMAccountName")
Response.Write "</td><td>"
Response.Write objRS("msexchhidefromaddresslists")
Response.Write "</td><td>"
Response.Write FormatDateTime(Date,2)
Response.Write "</td>"
Response.Write "</tr>"
objRS.MoveNext
Response.Flush
Loop

Response.Write "</table>"

'Close objects and remove from memory
objRS.Close
objConn.Close
Set objRS = Nothing
Set objConn = Nothing
Set objCom = Nothing
Set objADsPath = Nothing
Set objDomain = Nothing

%>