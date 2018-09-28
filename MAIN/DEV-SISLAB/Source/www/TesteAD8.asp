<!--#include file="includes/Global.asp"-->
<!--#include file="classes/Classe_WebService.asp"-->
<%
Response.Clear
%>
<!doctype html>

<html>

<head>
    <meta charset="utf-8"/>
</head>

<body>
    <form method="get" name="form1">
        <p>Login: <input type="text" name="txtLogin" /> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <input type="submit" /></p>
        <p>Domínio: <input type="text" name="txtDominio" /> </p>
    </form>
<%
dim ws
        Dim objSysInfo
	    Dim objUser
        Dim strNTUser, strUser
        Dim email, adress, dc, str_dc, str_cn
        Dim ldap_testeAL
        Dim xmlResult

        'monta o DC
        dc = ""
        str_dc = ""
        ldap_testeAL = False

'chr_login =    Request.ServerVariables("AUTH_USER")
'exit sub
    chr_Usuario = Request("txtLogin")

        'VAZIO: Pega o usuario logado no sistema
        If chr_Usuario = "" Then
            strNTUser = Request.ServerVariables("AUTH_USER")

            email = Split(strNTUser, "\")  'Mid(strNTUser,(instr(1,strNTUser,"\")+1),len(strNTUser))

            str_cn = "CN=" & email(1)

            'Verifica o domínio do usuário logado
            If UCase(Trim(email(0))) = "EMBRATEL" Then
                str_dc = "DC=nt,DC=embratel,DC=com,DC=br"
            ElseIf UCase(Trim(email(0))) = "CLARO" Then
                str_dc = "DC=claro,DC=com,DC=br"
            ElseIf UCase(Trim(email(0))) = "AL" Then
                str_dc = "DC=alerj,DC=gov,DC=br"
                ldap_testeAL = True
            Else
                str_dc = "DC=net,DC=com,DC=br"
            End If

            strUser = email(1)

        'EMAIL: precisa buscar o usuario no AD
        Else

            If InStr(1, chr_Usuario, "@") = 0 Then
                chr_Usuario = Trim(chr_Usuario) & SUFIXOEMAIL
            End If

            email = Split(chr_Usuario, "@")
            adress = Split(email(1), ".")
            'response.Write email(0) & " ---- " & email(1) & "<BR><BR>" & adress(0) & " ---- " & adress(1) & "<BR><BR>"
            For Each dc in adress
                str_dc = str_dc & "DC=" & dc & ","
                'response.Write "DC=" & dc & ","
            Next

            strUser = email(0)
            str_cn = "CN=" & email(0)
            str_dc =  Left(str_dc, Len(str_dc) - 1)
            'response.Write "<br><br>str_dc --> " & str_dc & "<BR><BR>"
        End If

        'Faz requisição para o WebService
        'xmlResult = Server.HTMLEncode(WS_ObtemUsuarioAD(strUser))
        xmlResult = WS_ObtemUsuarioAD(strUser, str_dc)

response.write "<BR><BR>Parametro Login: " & strUser
response.write "<BR><BR>Parametro Dominio: " & str_dc
response.write "<BR><BR>SISLAB_HTTP_WEBSERVICE: " & Application("SISLAB_HTTP_WEBSERVICE")
response.write "<BR><BR>AUTH_USER: " & Request.ServerVariables("AUTH_USER")
response.write "<BR><BR>chr_usuario: " & chr_usuario
response.write "<BR><BR>xmlResult: " & xmlResult
response.write "<BR><BR>strUser: " & strUser

    If Left(xmlResult, 4) = "ERRO" Then
        response.write "<BR><BR>strUser: " & xmlResult
    Else
 
        Dim oxml, nodes, attributes
        set oxml = Server.CreateObject("MSXML2.DOMDocument.6.0")
        oxml.async = false
        oxml.LoadXML xmlResult
       'If err.Number <> 0 Then 
       '  Response.Write(err.Description)
       'End If

       'nodes = oxml.selectNodes("//book")
       'Response.Write(nodes.length)

       'For Each node in nodes
       '    Response.Write(node.nodeName & ": " & node.Text & "<br />")
       'Next
        set nodes = oxml.selectNodes("//Usuario")
        response.write "<BR>nodes: " & nodes.length
        response.write "<BR>---<BR>DN: " & oxml.SelectSingleNode("Usuario/DN").text
        response.write "<BR>Nome: " & oxml.SelectSingleNode("Usuario/Nome").text
        response.write "<BR>Email: " & oXml.SelectSingleNode("Usuario/Email").text
        response.write "<BR>Diretoria: " & oxml.SelectSingleNode("Usuario/Diretoria").text
        response.write "<BR>Telefone: " & oXml.SelectSingleNode("Usuario/Telefone").text
        response.write "<BR>Celular: " & oXml.SelectSingleNode("Usuario/Celular").text
        response.write "<BR>Matricula: " & oXml.SelectSingleNode("Usuario/Matricula").text
        response.write "<BR>Empresa: " & oXml.SelectSingleNode("Usuario/Empresa").text
        response.write "<BR>CodigoLotacao: " & oXml.SelectSingleNode("Usuario/CodigoLotacao").text
        response.write "<BR>Departamento: " & oXml.SelectSingleNode("Usuario/Departamento").text
        response.write "<BR>Sexo: " & oXml.SelectSingleNode("Usuario/Sexo").text
        response.write "<BR>CategoriaEmpregado: " & oXml.SelectSingleNode("Usuario/CategoriaEmpregado").text
        response.write "<BR>DataAdmissao: " & oXml.SelectSingleNode("Usuario/DataAdmissao").text
        response.write "<BR>AreaLotacao: " & oXml.SelectSingleNode("Usuario/AreaLotacao").text
        response.write "<BR>CategoriaCargo: " & oXml.SelectSingleNode("Usuario/CategoriaCargo").text
        response.write "<BR>Lotacao: " & oXml.SelectSingleNode("Usuario/Lotacao").text
        response.write "<BR>DataNascimento: " & oXml.SelectSingleNode("Usuario/DataNascimento").text


    '    for i = 0 to nodes.length -1
    '        set attributes = nodes.item(i).attributes
    '        for j = 0 to attributes.length - 1
    '            response.write("<BR><BR>TESTE MS: " & attributes.item(j).nodeName & " - " & attributes.item(j).value & "<br />")
    '        next
    '    next

        set oxml = Nothing
    '    response.end
    'Call ParseCDRXML(xmlResult)
    End If


'       Set CurrentXML=Server.CreateObject("Microsoft.XMLDOM")
'        CurrentXML.async = false
'        CurrentXML.LoadXml(xmlResult)
'        set lixo = CurrentXML.documentElement
''        Response.Write "<BR>" & lixo.ChildNodes
'        'Response.Write("<BR>"&Server.HTMLEncode(CurrentXML.SelectSingleNode("/Usuario/Nome").XML)) 'I want to return  without the div, the correct result should be <p>abc <span>other span</span></p>




'        chr_DN = ValorXML(xmlResult, "DN")
'        chr_Login = ValorXML(xmlResult, "Email")
'        chr_Nome_Reduzido = ValorXML(xmlResult, "Nome>")
'        chr_Ramal = ValorXML(xmlResult, "Ramal")
'        chr_Celular = ValorXML(xmlResult, "Celular")
'        chr_Matricula = ValorXML(xmlResult, "Matricula")
'        chr_Empresa = ValorXML(xmlResult, "Empresa")
'        chr_CodigoLotacao = ValorXML(xmlResult, "CodigoLotacao")
'        chr_Departamento = ValorXML(xmlResult, "Departamento")
'        chr_Diretoria = ValorXML(xmlResult, "Diretoria")
'        chr_Sexo = ValorXML(xmlResult, "Sexo")
'        chr_CategoriaEmpregado = ValorXML(xmlResult, "CategoriaEmpregado")
'        chr_DataAdmissao = ValorXML(xmlResult, "DataAdmissao")
'        chr_AreaLotacao = ValorXML(xmlResult, "AreaLotacao")
'        chr_CategoriaCargo = ValorXML(xmlResult, "CategoriaCargo")
'        chr_Lotacao = ValorXML(xmlResult, "Lotacao")
'        chr_DataNascimento = ValorXML(xmlResult, "DataNascimento")

'response.write "<BR><BR>NOW: " & nOW
'response.write "<BR><BR>chr_DN: " & chr_DN
'response.write "<BR><BR>chr_Login: " & chr_Login
'response.write "<BR><BR>chr_Nome_Reduzido: " & chr_Nome_Reduzido 
'response.write "<BR><BR>chr_Ramal: " & chr_Ramal 
'response.write "<BR><BR>chr_Celular: " & chr_Celular 
'response.write "<BR><BR>chr_Matricula: " & chr_Matricula 
'response.write "<BR><BR>chr_Empresa: " & chr_Empresa 
'response.write "<BR><BR>chr_CodigoLotacao: " & chr_CodigoLotacao 
'response.write "<BR><BR>chr_Departamento: " & chr_Departamento 
'response.write "<BR><BR>chr_Diretoria: " & chr_Diretoria 
'response.write "<BR><BR>chr_Sexo: " & chr_Sexo 
'response.write "<BR><BR>chr_CategoriaEmpregado: " & chr_CategoriaEmpregado 
'response.write "<BR><BR>chr_DataAdmissao: " & chr_DataAdmissao
'response.write "<BR><BR>chr_AreaLotacao: " & chr_AreaLotacao 
'response.write "<BR><BR>chr_CategoriaCargo: " & chr_CategoriaCargo 
'response.write "<BR><BR>chr_Lotacao: " & chr_Lotacao 
'response.write "<BR><BR>chr_DataNascimento: " & chr_DataNascimento 


'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''



    Private Sub InicializaWebService()
        Set ws = New Twebservice
        ws.url = Application("SISLAB_HTTP_WEBSERVICE")
    End Sub

    Private Sub FinalizaWebService()
        Set ws = Nothing
    End Sub

    Public Function WS_ObtemUsuarioAD(usuario, dominio)
        dim ret
        Call InicializaWebService()
        ws.method = "ObtemUsuario"
        ws.parameters.Add "login", usuario
        ws.parameters.Add "dominio", dominio
        ws.Invoke
        ret = ws.Response
        ret = Replace(ret, "&gt;", ">")
        ret = Replace(ret, "&lt;", "<")
'response.write "<BR><BR>" & ws.Response
        Call FinalizaWebService()
        WS_ObtemUsuarioAD = ret
    End Function


    Public Function ValorXML(str, tag)
        Dim ini, fim
        Dim strEnc

'STR = "<Usuario><DN>CN=galmeida,OU=CORC,OU=Departamentos,OU=ALERJ,DC=alerj,DC=gov,DC=br</DN><Email>galmeida@alerj.rj.gov.br</Email><Nome>Gilberto Almeida</Nome><CodigoLotacao></CodigoLotacao><Departamento></Departamento><Diretoria></Diretoria><Sexo></Sexo><CategoriaEmpregado></CategoriaEmpregado><DataAdmissao></DataAdmissao><AreaLotacao></AreaLotacao><CategoriaCargo></CategoriaCargo><Lotacao></Lotacao><Matricula></Matricula><DataNascimento></DataNascimento><Empresa></Empresa><Telefone></Telefone><Celular></Celular></Usuario>"
        ini = InStr(1, str, "<" & tag & ">")
        fim = InStr(1, str, "</" & tag & ">")

'response.Write "<BR><BR>ValorXML / UCase(strEnc): " & UCase(strEnc)
''response.Write "<BR>ValorXML / TAG: " & UCase("&lt;/" & tag & "&gt;")
'response.Write "<BR><BR>ValorXML / str: " & str
'response.Write "<BR><BR>ValorXML / ini: " & ini
'response.Write "<BR><BR>ValorXML / fim: " & fim

        If fim - ini > 0 Then
            ValorXML = Mid(strEnc, ini, fim - ini)
        Else
            ValorXML = ""
        End If
'response.Write "<BR>ValorXML: " & ValorXML
'response.Write "<BR>----<BR>"
    End Function




Function ParseCDRXML(strXML)
	Dim objXML,objRoot ,I, thisNode,strID, strNarrative
	
	Set objXML= Server.CreateObject("Microsoft.XMLDOM") 
	objXML.async = False 
	objXML.loadXML(strXML) 
	Set objRoot = objXML.documentElement 

'response.write "<BR>AQUI KCT<BR>"

    For I = 0 TO (objRoot.childNodes.length - 1) 
        Set thisChild = objRoot.childNodes(I) 
        'strID 			= thisChild.childNodes(0).Text 
        'strNarrative 	= thisChild.childNodes(2).Text

        response.write "<BR><BR>strID: " & thisChild.text
	Next	   	
End Function

%>

</body>

</html>
