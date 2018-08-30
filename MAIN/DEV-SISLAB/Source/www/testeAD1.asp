<%@ Language="VBScript" %>
<%
Option Explicit
%>
<!DOCTYPE html>
<HTML>
<HEAD>
<TITLE>Listing of Domain Groups</TITLE>
</HEAD>
<%
Dim oRootDSE, oCon, oCmd, oRecordSet
Dim sDomainADsPath, sUser, sPassword, sGroup, sProperties
Dim aDescription, aMember, iCount

Set oRootDSE 		= GetObject("LDAP://RootDSE")
sDomainADsPath		= "LDAP://" & oRootDSE.Get("defaultNamingContext")
'Set oRootDSE 		= Nothing

Set oCon 		= Server.CreateObject("ADODB.Connection")

sUser			= "galmeida"
sPassword		= "230175"

oCon.Provider 		= "ADsDSOObject"

oCon.Open "ADProvider", sUser, sPassword

Set oCmd		= Server.CreateObject("ADODB.Command")
Set oCmd.ActiveConnection = oCon

sProperties		= "name,ADsPath,description,member"
sGroup			= "*"

oCmd.CommandText	= "<" & sDomainADsPath & ">;(&(objectCategory=group)(name=" & sGroup & "));" & sProperties & ";subtree"
oCmd.Properties("Page Size") = 100

'response.Write "<BR>" & sDomainADsPath
'response.Write "<BR>< " & sDomainADsPath & ">;(&(objectCategory=group)(name=" & sGroup & "));" & sProperties & ";subtree"
'response.end

Set oRecordSet = oCmd.Execute

Response.Write("<strong> Global Groups for the domain: " & Replace(Mid(sDomainADsPath,11), ",DC=", ".") & "</strong>")

Response.Write("<table border='1'>")
Response.Write("<tr><th>Name</th><th>ADsPath</th><th>Description</th><th>Members</th></tr>")
Response.Write("<font size=-2>")
While Not oRecordSet.EOF
	Response.Write("<tr><td>" & oRecordSet.Fields("name") & "</td>")
	Response.Write("<td>" & oRecordSet.Fields("ADsPath") & "</td>")
	aDescription = oRecordSet.Fields("description")
	Response.Write("<td> ")
	If Not IsNull(aDescription) Then Response.Write aDescription(0)
	Response.Write("</td>")
	aMember = oRecordSet.Fields("member")
	Response.Write("<td><select size = '5'> ")
	If Not IsNull(aMember) Then
		For icount = 0 to UBound(aMember)
			Response.Write("<option>" & aMember(iCount))
		Next
	End If
	Response.Write("</td></tr>")
	oRecordSet.MoveNext
Wend
Response.Write("</font>")
Response.Write("</table>")

oRecordSet.Close
oCon.Close

Set oRecordSet = Nothing
Set oCon = Nothing
%>
</BODY>
</HTML>
