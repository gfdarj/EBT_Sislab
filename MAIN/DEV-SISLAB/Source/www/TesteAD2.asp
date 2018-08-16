<%
'On Error Resume Next

Response.Clear

Dim objSysInfo, objUser
Set objSysInfo = CreateObject("ADSystemInfo")

' Currently logged in User
'Set objUser = GetObject("LDAP://" & objSysInfo.UserName)
 ' or specific user:
'Set objUser = GetObject("LDAP://CN=galmeida,OU=CORC,OU=Departamentos,OU=ALERJ,DC=alerj,DC=gov,DC=br")
Set objUser = GetObject("LDAP://CN=aalmeida,OU=,DC=alerj,DC=gov,DC=br")

'response.End

Response.Write "<BR>DN: " & objUser.distinguishedName

Response.Write "<BR>"
Response.Write "<BR>GENERAL"
Response.Write "<BR>First name: " & objUser.givenName
'Response.Write "<BR>First name: " & objUser.FirstName
Response.Write "<BR>Initials: " & objUser.initials
Response.Write "<BR>Last name: " & objUser.sn
'Response.Write "<BR>Last name: " & objUser.LastName
Response.Write "<BR>Display name: " & objUser.displayName
'Response.Write "<BR>Display name: " & objUser.FullName
Response.Write "<BR>Description: " & objUser.description
Response.Write "<BR>Office: " & objUser.physicalDeliveryOfficeName
Response.Write "<BR>Telephone number: " & objUser.telephoneNumber
Response.Write "<BR>Other Telephone numbers: " & objUser.otherTelephone
Response.Write "<BR>Email: " & objUser.mail
' Response.Write "<BR>Email: " & objUser.EmailAddress
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
' Response.Write "<BR>Account Control #: " & objUser.userAccountControl
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
Response.Write "<BR>Mobile: " & objUser.mobile
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

%>
