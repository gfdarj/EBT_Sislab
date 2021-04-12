<!--#include file="../Classes/Classe_WebService.asp"-->
<%
    Set ws = New Twebservice
    ws.url = Application("SISLAB_HTTP_WEBSERVICE")

    Public Function WS_ObtemUsuarioTeste()
        dim ret

        ws.method = "ObtemUsuarioTeste"
        ws.Invoke
        ret = ws.Response
        ret = Replace(ret, "&gt;", ">")
        ret = Replace(ret, "&lt;", "<")
response.write "<BR><BR>ws.Response: " & ws.Response & "<BR>"
'response.End

        WS_ObtemUsuarioTeste = ret
    End Function


    'Busca os dados do AD
    Public Sub BuscaDadosEmbratel

        'Faz requisição para o WebService
       If Application("SISLAB_DEBUG") = "SIM" Then
           xmlResult = WS_ObtemUsuarioTeste()
'       Else
'           xmlResult = WS_ObtemUsuarioAD(strUser, str_dc)
       End If
		chr_RetornoWS = xmlResult
        'xmlResult = "ERRO"
response.write "<BR><BR>xmlResult: " & xmlResult & "<BR>"

        If Left(xmlResult, 4) <> "ERRO" Then
            Dim oXml ', nodes
            Set oXml = Server.CreateObject("MSXML2.DOMDocument.3.0")
            oxml.async = false
            oxml.LoadXML(xmlResult)
            'Set nodes = oxml.selectNodes("//Usuario")

            chr_ID = oxml.SelectSingleNode("Usuario/ID").text
            chr_DN = oxml.SelectSingleNode("Usuario/DN").text
            chr_Nome_Reduzido = oxml.SelectSingleNode("Usuario/Nome").text
            chr_Login = oXml.SelectSingleNode("Usuario/Email").text
            chr_Diretoria = oxml.SelectSingleNode("Usuario/Diretoria").text
            chr_Ramal = oXml.SelectSingleNode("Usuario/Telefone").text
            chr_Celular = oXml.SelectSingleNode("Usuario/Celular").text
            chr_Matricula = oXml.SelectSingleNode("Usuario/Matricula").text
            chr_Empresa = oXml.SelectSingleNode("Usuario/Empresa").text
            chr_CodigoLotacao = oXml.SelectSingleNode("Usuario/CodigoLotacao").text
            chr_Sigla_Orgao = chr_CodigoLotacao
            chr_Departamento = oXml.SelectSingleNode("Usuario/Departamento").text
            chr_Sexo = oXml.SelectSingleNode("Usuario/Sexo").text
            chr_CategoriaEmpregado = oXml.SelectSingleNode("Usuario/CategoriaEmpregado").text
            chr_DataAdmissao = oXml.SelectSingleNode("Usuario/DataAdmissao").text
            chr_AreaLotacao = oXml.SelectSingleNode("Usuario/AreaLotacao").text
            chr_CategoriaCargo = oXml.SelectSingleNode("Usuario/CategoriaCargo").text
            chr_Lotacao = oXml.SelectSingleNode("Usuario/Lotacao").text
            chr_DataNascimento = oXml.SelectSingleNode("Usuario/DataNascimento").text

response.write "<BR>chr_ID: " & chr_ID
response.write "<BR>chr_DN: " & chr_DN
response.write "<BR>chr_Nome_Reduzido: " & chr_Nome_Reduzido
response.write "<BR>chr_Login: " & chr_Login
            chr_Diretoria = oxml.SelectSingleNode("Usuario/Diretoria").text
            chr_Ramal = oXml.SelectSingleNode("Usuario/Telefone").text
            chr_Celular = oXml.SelectSingleNode("Usuario/Celular").text
            chr_Matricula = oXml.SelectSingleNode("Usuario/Matricula").text
            chr_Empresa = oXml.SelectSingleNode("Usuario/Empresa").text
            chr_CodigoLotacao = oXml.SelectSingleNode("Usuario/CodigoLotacao").text
            chr_Sigla_Orgao = chr_CodigoLotacao
            chr_Departamento = oXml.SelectSingleNode("Usuario/Departamento").text
            chr_Sexo = oXml.SelectSingleNode("Usuario/Sexo").text
            chr_CategoriaEmpregado = oXml.SelectSingleNode("Usuario/CategoriaEmpregado").text
            chr_DataAdmissao = oXml.SelectSingleNode("Usuario/DataAdmissao").text
response.write "<BR>chr_AreaLotacao: " & chr_AreaLotacao
response.write "<BR>chr_CategoriaCargo: " & chr_CategoriaCargo
response.write "<BR>chr_Lotacao: " & chr_Lotacao
response.write "<BR>chr_DataNascimento:" & chr_DataNascimento

            Set oXml = Nothing
            'Set nodes = Nothing
        End If


    End Sub
    
    
    
    
%>



<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8" />
    <title></title>
</head>
<body>
    <h2>TESTE DE WEBSERVICE</h2>

    AQUI:
    <%Call BuscaDadosEmbratel %>
</body>
</html>

<%
Set ws = Nothing
%>