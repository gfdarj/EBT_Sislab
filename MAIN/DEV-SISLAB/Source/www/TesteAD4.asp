<%
response.write "AGORA: " & now & "<BR><BR>"
            'pesquisa no diretorio AD
            Dim conn, strQueryDL, strAttrs, objCmd, objRs, chr_Login , ReturnValue 

            Set conn = CreateObject("ADODB.Connection")
            conn.Provider = "ADsDSOObject"
            conn.Open "ADs Provider"

            strAttrs = "sAMAccountName,displayName,distinguishedName" ' get attributes
            'strQueryDL = "<LDAP://" & str_dc & ">;(& (sAMAccountName=" & email(0) & ") );" & strAttrs & ";SubTree"
            strQueryDL = "<LDAP://DC=alerj,DC=gov,DC=br>;(& (sAMAccountName=galmeida*) );sAMAccountName,displayName,distinguishedName,mail;SubTree"

            Set objCmd = CreateObject("ADODB.Command")
            objCmd.ActiveConnection = Conn
            'objCmd.Properties("SearchScope") = 2 ' search everything
            'objCmd.Properties("Page Size") = 100 ' bulk operation
            objCmd.CommandText = strQueryDL
'    response.write "AQUI:" & strQueryDL
'    response.End

            Set objRs = objCmd.Execute

'ReturnValue = objRs.Fields(0).name
'response.Write ReturnValue
'Response.End

ReturnValue = objRs.Fields.Count
response.Write  ReturnValue  & "<br>"
Coluna = objRs.Fields.Item(0).Name
Response.Write Coluna & objRS("mail")
Response.Write "<br>"

RESPONSE.End

            If Not (objRS.Eof And objRS.Bof) Then
                Response.Write "<BR><BR>AQUI: " &  objRs.Fields("sAMAccountName") & " / " & objRs.Fields("displayName") & " / " & objRs.Fields("distinguishedName") & "<BR><BR>"
                'chr_Login = objRs.Fields("email")
                'chr_Nome_Reduzido = objRs.Fields("FullName")
            End IF
            objRs.Close
            Conn.close
            set objRs = Nothing
            set conn = Nothing
  response.write "<BR>END"
    response.end
     %>