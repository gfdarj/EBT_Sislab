<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8" />
    <title></title>
</head>
<body>
<%
'Get AD User full name and Email address
Dim oConn

Set oConn = CreateObject("ADODB.Connection")
Set oRS = CreateObject("ADODB.Recordset")

oConn.Open ("Data Source=Active Directory Provider;Provider=ADsDSOObject;" & _
    "User ID=" & "EMBRATEL" & "\" & "T3GFBA" & ";password=" & "Timbau230175" & ";") 


Function getDomain() 
    Set objRootDSE = GetObject("LDAP://RootDSE")
    sConfig = objRootDSE.Get("configurationNamingContext") 
    getDomain = objRootDSE.Get("defaultNamingContext")
End Function

Function getLogon()
    getLogon = (Mid(Request.ServerVariables("LOGON_USER"), _
        InStrRev(Request.ServerVariables("LOGON_USER"), "\") + 1))
End Function 

Function GetUserDetails(sDomain, sLogon)
    strNAME="SELECT displayName " & _
        "FROM 'LDAP://" & sDomain & "' " & _
        "WHERE samaccountname='" & sLogon & "'"
    RESPONSE.Write("<BR>strName: " & strName)

    Set oRS = oConn.Execute("SELECT displayName " & "FROM 'LDAP://" & sDomain & "' " & "WHERE samaccountname='" & sLogon & "'")

    If Not oRs.EOF Then
        RESPONSE.Write("<BR>oRs('displayName'): " & oRs("displayName"))
        GetUserDetails = oRs("displayName")
    Else
        RESPONSE.Write("No Department Listed")
        GetUserDetails = "No Department Listed"
    End If
End Function    

Response.Write "TESTE AD"
'response.End
Response.Write "<BR>getLogon: " & getLogon()
Response.Write "<BR>getDomain: " & getDomain()
Response.Write "<BR>GetUserDetails: " & GetUserDetails(getDomain(), getLogon())    

%>
</body>
</html>