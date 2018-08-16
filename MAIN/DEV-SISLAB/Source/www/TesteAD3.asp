<%
' c:> cscript -nologo script.vbs
' c:> wscript script.vbs
' http://msdn.microsoft.com/en-us/library/d6dw7aeh%28v=vs.85%29.aspx

' WindowsAD queries
' http://www.kouti.com/tables/userattributes.htm

Option Explicit
'On Error Resume Next

'Dim objUser
''Set objUser = GetObject("LDAP://CN=Firstname Lastname,OU=Internal Users,OU=MyCompany,OU=Boston,OU=Root,DC=REGION1,DC=COM")
'Set objUser = GetObject("LDAP://CN=galmeida,DC=alerj,DC=gov,DC=br")

'Response.Write objUser.givenName & " " & objUser.middleName & " " & objUser.lastName
'Response.Write "name=" & objUser.name
'Response.Write "displayName=" & objUser.displayName
'Response.Write "userPrincipalName=" & objUser.userPrincipalName
'Response.Write "sAMAccountName=" & objUser.sAMAccountName
'Response.Write "distinguishedName=" & objUser.distinguishedName
'Response.Write "<BR>"

Dim conn, strQueryDL, strAttrs, objCmd, objRs, idx

set conn = createobject("ADODB.Connection")
conn.Provider = "ADsDSOObject"
conn.Open "ADs Provider"

strAttrs = "sAMAccountName,displayName,distinguishedName" ' get attributes

'strQueryDL = "<LDAP://dc=REGION1,dc=COM>;(& (objectCategory=person) );" & strAttrs & ";SubTree"
'strQueryDL = "<LDAP://dc=REGION1,dc=COM>;(& (objectCategory=person)(objectClass=user) );" & strAttrs & ";SubTree"    
'strQueryDL = "<LDAP://dc=REGION1,dc=COM>;(& (objectCategory=person)(objectClass=user)(sAMAccountName=smith*) );" & strAttrs & ";SubTree"

strQueryDL = "<LDAP://dc=alerj,dc=gov,dc=br>;(& (sAMAccountName=aal*) );" & strAttrs & ";SubTree"


set objCmd = createobject("ADODB.Command")
objCmd.ActiveConnection = Conn
objCmd.Properties("SearchScope") = 2 ' search everything
objCmd.Properties("Page Size") = 100 ' bulk operation

objCmd.CommandText = strQueryDL
Response.Write "objCmd.CommandText: " & objCmd.CommandText & "<BR><BR><br>"
Set objRs = objCmd.Execute
idx=0
do while Not objRS.eof
  idx=idx+1
  Response.Write  objRs.Fields("sAMAccountName") & " / " & objRs.Fields("displayName") & " / " & objRs.Fields("distinguishedName") & "<BR><BR>"
  if (idx>5) then exit do
  objRS.MoveNext
loop
objRs.Close
Conn.close
set objRs = Nothing
set conn = Nothing

Response.Write "FIM<BR>"

%>