<%
'===============================================================================================

'    PEGA TODOS OS CAMPOS DO ACTIVE DIRECTORY 

'===============================================================================================


strNTUser = Request.ServerVariables("AUTH_USER")

email = Split(strNTUser, "\")  'Mid(strNTUser,(instr(1,strNTUser,"\")+1),len(strNTUser))

Response.Write "Mid: " & Mid(strNTUser,(instr(1,strNTUser,"\")+1),len(strNTUser))

'strNTUSer = "EMBRATEL\JOACA"

Response.Write "<BR><BR>strNTUSer: " & strNTUSer
Response.Write "<BR><BR>Domain / User: " & email(0) & " ---- " & email(1)

Response.Write "<br><br>"

response.End

' Get the inputs.
'containerName = "10.54.24.197/OU=User Accounts,DC=corp,DC=clarobr"
containerName = "10.54.24.197"
'containerName = "ldapebt.embratel.com.br"

' Validate compName before using.

If Not ("" = containerName) Then
  ' Bind to the object.
  adsPath = "LDAP://" & containerName
  Set comp = GetObject(adsPath)

  ' Write the ADsPath of each of the child objects.
  Response.Write("<p>Enumeration:</p>")
  For Each obj in comp
    Response.Write(obj.ADsPath + "<BR>")
  Next
End If
   

Response.Write "<br><br>"



Set objConnection = Server.CreateObject("ADODB.Connection")
Set objCommand = Server.CreateObject("ADODB.Command")
objConnection.Provider = "ADsDSOObject"
objConnection.Open "Active Directory Provider"
Set objCommand.ActiveConnection = objConnection

objCommand.Properties("Page Size") = 3000
objCommand.Properties("Searchscope") = 2 'ADS_SCOPE_SUBTREE 

'joaquim.carvalho
'109305
'jose.paulajunior@claro.com.br

'email(1) = "JOSESP"
'email(1) = "laila.desousa@claro.com.br"
'email(1) = "walderson.vidal@claro.com.br"
email(1) = "Jose.PaulaJunior@claro.com.br"

objCommand.CommandText = "SELECT * FROM 'LDAP://" & containerName & "'" & _
                         "WHERE accountNameHistory = '" & strNTUSer & "'"
                         '"WHERE mail = '" & email(1) & "'"
                         '"WHERE cn = '" & email(1) & "'"
                         '"WHERE objectCategory='user' "
                         '"AND sAMAccountName = 'negociacao01'"
                         '"AND mail = 'joaquim.carvalho@claro.com.br'"
'objCommand.CommandText = "SELECT sn,name,distinguishedName,sAMAccountName FROM 'LDAP://" & containerName & "' WHERE objectCategory='user'"
'objCommand.CommandText = "<LDAP:/" & "/" & containerName & ">"
'objCommand.CommandText = _
'    "SELECT " & _
'        "distinguishedName, givenName, displayName, description, telephoneNumber, mail, streetAddress, title, department, company " & _
'        ", homePhone, otherHomePhone, pager, otherPager, mobile, otherMobile, facsimileTelephoneNumber, otherFacsimileTelephoneNumber, ipPhone, otherIpPhone, info, manager " & _
'        "FROM 'LDAP://" & containerName & "' "

response.write objCommand.CommandText 
'response.end

Set objRecordSet = objCommand.Execute

If Not objRecordSet.BOF Then objRecordSet.MoveFirst
If Not objRecordSet.EOF Then
    response.Write "<h1>Entrei no If EOF strDN !!!!!!!!!!!!!!</h1>"
    While Not objRecordSet.Eof

        for i = 0 to objRecordSet.fields.count - 1
            response.write "<BR>Name: " & objRecordSet.fields(i).name & "<br>Value: " & objRecordSet.fields(i).value
        next
        response.write "<BR>"

	    strAdsPath = objRecordSet.Fields("ADsPath").Value
    	Set objADObject = GetObject(strAdsPath)
	    Set objClass = GetObject(objADObject.Schema)

    '	Write which object is grabbed from AD
	    Response.Write(Replace(strAdsPath, ",", ";;;"))
        Response.Write("<br>")
    '	Enumerate mandatory object properties.
	    For Each strProperty In objClass.MandatoryProperties
		    On Error Resume Next
		    strValue = objADObject.Get(strProperty)
		    If (Err.Number = 0) Then
			    On Error GoTo 0
			    If (TypeName(strValue) = "String") Or (TypeName(strValue) = "Long") Or (TypeName(strValue) = "Date") Then
				    Response.Write("," & strProperty & " = " & Replace(CStr(strValue), ",", ";;;"))
                    Response.Write("<br>")
			    ElseIf (TypeName(strValue) = "Byte()") Then
				    strHex = OctetToHexStr(strValue)
				    Response.Write("," & strProperty & " = " & CStr(strHex))
                    Response.Write("<br>")
			    ElseIf (TypeName(strValue) = "Variant()") Then
				    For Each strItem In strValue
					    On Error Resume Next
					    Response.Write("," & strProperty & " = " & Replace(CStr(strItem), ",", ";;;"))
                        Response.Write("<br>")
					    If (Err.Number <> 0) Then
						    On Error GoTo 0
						    Response.Write("," & strProperty & " = Value cannot be displayed")
                            Response.Write("<br>")
					    End If
					    On Error GoTo 0
				    Next
			    ElseIf (TypeName(strValue) = "Boolean") Then
				    Response.Write("," & strProperty & " = " & CBool(strValue))
                    Response.Write("<br>")
			    Else
				    Response.Write("," & strProperty & " = Type:" & TypeName(strValue))
                    Response.Write("<br>")
			    End If
		    Else
			    Err.Clear
			    sColl = objADObject.GetEx(strProperty)
			    If (Err.Number = 0) Then
				    For Each strItem In sColl
					    Response.Write("," & strProperty & " = " & CStr(strItem))
					    If (Err.Number <> 0) Then
						    Response.Write("," & strProperty & " = Value cannot be displayed")
                            Response.Write("<br>")
					    End If
				    Next
				    On Error GoTo 0
			    Else
				    Err.Clear
				    Set objDate = objADObject.Get(strProperty)
				    If (Err.Number = 0) Then
					    lngHigh = objDate.HighPart
					    If (Err.Number = 0) Then
						    lngLow = objDate.LowPart
						    If (lngLow < 0) Then
							    lngHigh = lngHigh + 1
						    End If
						    lngValue = (lngHigh * (2 ^ 32)) + lngLow
						    If (lngValue > 120000000000000000) Then
							    dtmValue = #1/1/1601# + (lngValue / 600000000 - lngBias) / 1440
							    On Error Resume Next
							    dtmDate = CDate(dtmValue)
							    If (Err.Number <> 0) Then
								    Response.Write("," & strProperty & " = <Never>")
                                    Response.Write("<br>")
							    Else
								    Response.Write("," & strProperty & " = " & CStr(dtmDate))
                                    Response.Write("<br>")
							    End If
						    Else
							    Response.Write("," & strProperty & " = " & FormatNumber(lngValue, 0))
                                Response.Write("<br>")
						        End If
					    Else
						    Response.Write("," & strProperty & " = Value cannot be displayed")
                            Response.Write("<br>")
					    End If
				    Else
					    On Error GoTo 0
					    Response.Write("," & strProperty)
                        Response.Write("<br>")
				    End If
				    On Error GoTo 0
			    End If
		    End If
	    Next

    '	Enumerate optional object properties.
	    For Each strProperty In objClass.OptionalProperties
		    On Error Resume Next
		    strValue = objADObject.Get(strProperty)
		    If (Err.Number = 0) Then
			    On Error GoTo 0
			    If (TypeName(strValue) = "String") Then
				    Response.Write("," & strProperty & " = " & Replace(CStr(strValue), ",", ";;;"))
                    Response.Write("<br>")
			    ElseIf (TypeName(strValue) = "Long") Then
				    Response.Write("," & strProperty & " = " & Replace(CStr(strValue), ",", ";;;"))			
                    Response.Write("<br>")
			    ElseIf (TypeName(strValue) = "Date") Then
				    Response.Write("," & strProperty & " = " & Replace(CStr(strValue), ",", ";;;"))
                    Response.Write("<br>")
			    ElseIf (TypeName(strValue) = "Byte()") Then
				    strHex = OctetToHexStr(strValue)
				    Response.Write("," & strProperty & " = " & CStr(strHex))
                    Response.Write("<br>")
			    ElseIf (TypeName(strValue) = "Variant()") Then
				    For Each strItem In strValue
					    On Error Resume Next
					    Response.Write("," & strProperty & " = " & Replace(CStr(strItem), ",", ";;;"))
                        Response.Write("<br>")
					    If (Err.Number <> 0) Then
						    On Error GoTo 0
						    Response.Write("," & strProperty & " = Value cannot be displayed")
                            Response.Write("<br>")
					    End If
					    On Error GoTo 0
				    Next
			    ElseIf (TypeName(strValue) = "Boolean") Then
				    Response.Write("," & strProperty & " = " & CBool(strValue))
                    Response.Write("<br>")
			    Else
				    Response.Write("," & strProperty & " = Type:" & TypeName(strValue))
                    Response.Write("<br>")
			    End If
		    Else
			    Err.Clear
			    sColl = objADObject.GetEx(strProperty)
			    If (Err.Number = 0) Then
				    For Each strItem In sColl
					    Response.Write("," & strProperty & " = " & CStr(strItem))
                        Response.Write("<br>")
					    If (Err.Number <> 0) Then
						    Response.Write("," & strProperty & " = Value cannot be displayed")
                            Response.Write("<br>")
					    End If
				    Next
				    On Error GoTo 0
			    Else
				    Err.Clear
				    Set objDate = objADObject.Get(strProperty)
				    If (Err.Number = 0) Then
					    lngHigh = objDate.HighPart
					    If (Err.Number = 0) Then
						    lngLow = objDate.LowPart
						    If (lngLow < 0) Then
							    lngHigh = lngHigh + 1
						    End If
						    lngValue = (lngHigh * (2 ^ 32)) + lngLow
						    If (lngValue > 120000000000000000) Then
							    dtmValue = #1/1/1601# + (lngValue / 600000000 - lngBias) / 1440
							    On Error Resume Next
							    dtmDate = CDate(dtmValue)
							    If (Err.Number <> 0) Then
								    Response.Write("," & strProperty & " = <Never>")
                                    Response.Write("<br>")
							    Else
								    Response.Write("," & strProperty & " = " & CStr(dtmDate))
                                    Response.Write("<br>")
							    End If
						    Else
							    Response.Write("," & strProperty & " = " & lngValue)
                                Response.Write("<br>")
						    End If
					    Else
						    Response.Write("," & strProperty & " = Value cannot be displayed")
                            Response.Write("<br>")
					    End If
				    Else
					    On Error GoTo 0
					    Response.Write("," & strProperty & " = ")
                        Response.Write("<br>")
				    End If
				    On Error GoTo 0
			    End If
		    End If

            Response.Flush
	    Next
	    Response.Write("<BR>------------------------<BR>")

        objRecordSet.MoveNext
    WEnd
End If

response.write "<BR><h3>FORA DO LOOP !!!</h3>" & now


response.end
   
   
   
   
   
   
   
   
   
   
   
'On Error Resume Next

Response.Clear

response.write "AUTH_USER: " & Request.ServerVariables("AUTH_USER") & "<BR>"
response.write "LOGON_USER: " & Request.ServerVariables("LOGON_USER")  & "<BR>"


Dim objSysInfo, objUser
Set objSysInfo = CreateObject("ADSystemInfo")

'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''

    'Set objRootDSE = GetObject("LDAP://ldapebt.embratel.com.br")
    'Set objRootDSE = GetObject("LDAP://RootDSE")
    Set objRootDSE = GetObject("LDAP://10.54.24.197")

     'Set objRootDSE = GetObject("LDAP://alerj.gov.br")

    ' Currently logged in User
    Set objUser = GetObject("LDAP://" & objSysInfo.UserName)
'    Set objUser = GetObject("LDAP://" & "CN=JOSESP,OU=Rio de Janeiro,OU=Usuarios,DC=nt,DC=embratel,DC=com,DC=br")

'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
     ' or specific user:
'    Dim strQueryDL
    'strQueryDL = "LDAP://CN=galmeida,OU=CORC,OU=Departamentos,OU=ALERJ,DC=alerj,DC=gov,DC=br"
'    strQueryDL = "<LDAP://CN=JOSESP,DC=nt,DC=embratel,DC=com,DC=br>"
    'strQueryDL = "<LDAP://CN=T3GSAN,OU=Rio de Janeiro,OU=Usuarios,DC=nt,DC=embratel,DC=com,DC=br>"

'    response.Write strQueryDL 
'    response.End

'    Set objUser = GetObject(strQueryDL)

'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''

Response.Write "<BR>objSysInfo.UserName: " & objSysInfo.UserName
Response.Write "<BR>DN: " & objUser.distinguishedName
Response.Write "<BR>"
Response.Write "<BR>GENERAL"
Response.Write "<BR>First name: " & objUser.givenName
'Response.Write "<BR>First name: " & objUser.FirstName
Response.Write "<BR>Initials: " & objUser.initials
Response.Write "<BR>Last name: " & objUser.sn
Response.Write "<BR>Last name: " & objUser.LastName
Response.Write "<BR>Display name: " & objUser.displayName
Response.Write "<BR>Full Name: " & objUser.FullName
Response.Write "<BR>Description: " & objUser.description
Response.Write "<BR>Office: " & objUser.physicalDeliveryOfficeName
Response.Write "<BR>Telephone number: " & objUser.telephoneNumber
Response.Write "<BR>Other Telephone numbers: " & objUser.otherTelephone
Response.Write "<BR>Email: " & objUser.mail
Response.Write "<BR>Email: " & objUser.EmailAddress
Response.Write "<BR>Web page: " & objUser.wWWHomePage
Response.Write "<BR>Other Web pages: " & objUser.url
Response.Write "<BR>"
Response.Write "<BR>ADDRESS"
Response.Write "<BR>Street: " & objUser.streetAddress
Response.Write "<BR>P.O. Box: " & objUser.postOfficeBox
Response.Write "<BR>City: " & objUser.l
Response.Write "<BR>State/province: " & objUser.st
Response.Write "<BR>Zip/Postal Code: " & objUser.postalCode
Response.Write "<BR>Country/region: " & objUser.countryCode
'Response.Write "<BR>Country/region: " & objUser.c    '(ISO 4217)
Response.Write "<BR>"
Response.Write "<BR>ACCOUNT"
Response.Write "<BR>User logon name: " & objUser.userPrincipalName
Response.Write "<BR>pre-Windows 2000 logon name: " & objUser.sAMAccountName
Response.Write "<BR>AccountDisabled: " & objUser.AccountDisabled
Response.Write "<BR>Account Control #: " & objUser.userAccountControl
Response.Write "<BR>Logon Hours: " & CStr(objUser.logonHours)
Response.Write "<BR>Logon On To (Logon Workstations): " & objUser.userWorkstations
' Response.Write "<BR>User must change password at next logon: " & objUser.pwdLastSet
Response.Write "<BR>User cannot change password: " & objUser.userAccountControl
Response.Write "<BR>Password never expires: " & objUser.userAccountControl
Response.Write "<BR>Store password using reversible encryption: " & objUser.userAccountControl
' Response.Write "<BR>Account expires end of (date): " & objUser.accountExpires
Response.Write "<BR>"
Response.Write "<BR>PROFILE"
Response.Write "<BR>Profile path: " & objUser.profilePath
' Response.Write "<BR>Profile path: " & objUser.Profile
Response.Write "<BR>Logon script: " & objUser.scriptPath
Response.Write "<BR>Home folder, local path: " & objUser.homeDirectory
Response.Write "<BR>Home folder, Connect, Drive: " & objUser.homeDrive
Response.Write "<BR>Home folder, Connect, To:: " & objUser.homeDirectory
Response.Write "<BR>"
Response.Write "<BR>TELEPHONE"
Response.Write "<BR>Home: " & objUser.homePhone
Response.Write "<BR>Other Home phone numbers: " & objUser.otherHomePhone
Response.Write "<BR>Pager: " & objUser.pager
Response.Write "<BR>Other Pager numbers: " & objUser.otherPager
Response.Write "<BR>Mobile 1111: " & objUser.mobile
Response.Write "<BR>Other Mobile numbers: " & objUser.otherMobile
Response.Write "<BR>Fax: " & objUser.facsimileTelephoneNumber
Response.Write "<BR>Other Fax numbers: " & objUser.otherFacsimileTelephoneNumber
Response.Write "<BR>IP phone: " & objUser.ipPhone
Response.Write "<BR>Other IP phone numbers: " & objUser.otherIpPhone
Response.Write "<BR>Notes: " & objUser.info
Response.Write "<BR>"
Response.Write "<BR>ORGANISATION"
Response.Write "<BR>Title: " & objUser.title
Response.Write "<BR>Department: " & objUser.department
Response.Write "<BR>Company: " & objUser.company
Response.Write "<BR>Manager: " & objUser.manager
Response.Write "<BR>department: " & objUser.department
Response.Write "<BR>homephone: " & objUser.homephone
Response.Write "<BR>l: " & objUser.l
Response.Write "<BR>location: " & objUser.location
Response.Write "<BR>mobile: " & objUser.mobile
'Response.Write "<BR>ObjectClass: " & objUser.ObjectClass
Response.Write "<BR>OU: " & objUser.OU
Response.Write "<BR>postalCode: " & objUser.postalCode
Response.Write "<BR>st: " & objUser.st
Response.Write "<BR>streetAddress: " & objUser.streetAddress
Response.Write "<BR>userAccountControl: " & objUser.userAccountControl
Response.Write "<BR>dNSHostname: " & objUser.dNSHostname
Response.Write "<BR>rID: " & objUser.rID
Response.Write "<BR>url: " & objUser.url




'	Function to convert OctetString (Byte Array) to a hex string.
Function OctetToHexStr(arrbytOctet)
	Dim k
	OctetToHexStr = ""
	For k = 1 To Lenb(arrbytOctet)
		OctetToHexStr = OctetToHexStr _
			& Right("0" & Hex(Ascb(Midb(arrbytOctet, k, 1))), 2)
	Next
End Function

%>

