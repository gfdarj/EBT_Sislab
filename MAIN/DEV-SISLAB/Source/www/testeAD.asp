<%
Dim net
set net = createobject("wscript.network")

RESPONSE.wRITE "<br>net.username: " & net.username
RESPONSE.wRITE "<br>net.UserDomain: " & net.UserDomain
response.write "<br>request.servervariables(LOGON_USER): " & request.servervariables("LOGON_USER")

Dim objSysInfo
Dim objUsuario
Dim objGrupo
Dim objColl
		
'Criação dos objetos
Set objSysInfo	= Server.CreateObject("ADSystemInfo")

response.write "<br>objSysInfo.UserName: " & objSysInfo.UserName
response.write "<br>objSysInfo.DomainDNSName: " & objSysInfo.DomainDNSName



response.write "<br><br><br>AQUI !: "

username = "T3GFBA"

Set rootDSE = GetObject("LDAP://RootDSE")
base  = "<LDAP://" & rootDSE.Get("defaultNamingContext") & ">"
'filter on user objects with the given account name
fltr  = "(&(objectClass=user)(objectCategory=Person)" & _
        "(sAMAccountName=" & username & "))"
'add other attributes according to your requirements
attr  = "distinguishedName,sAMAccountName"
scope = "subtree"

Set conn = CreateObject("ADODB.Connection")
conn.Provider = "ADsDSOObject"
conn.Open "Active Directory Provider"

Set cmd = CreateObject("ADODB.Command")
Set cmd.ActiveConnection = conn
cmd.CommandText = base & ";" & fltr & ";" & attr & ";" & scope

Set rs = cmd.Execute
Do Until rs.EOF
  response.write base & ";" & fltr & ";" & attr & ";" & scope & "<BR>" & rs.Fields("distinguishedName").Value
  rs.MoveNext
Loop
rs.Close

conn.Close


%>