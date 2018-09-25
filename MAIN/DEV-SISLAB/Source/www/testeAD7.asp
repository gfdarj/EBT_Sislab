<!--#include file="Classes/Classe_WebService.asp"-->
<!--#inc    lude file="Classes/Classe_EbtWS.asp"-->

<%
dim ws, usuario

usuario = "galmeida"


Dim SoapRequest, SoapUrl
Set SoapRequest = Server.CreateObject("MSXML2.XMLHTTP")
SoapUrl = Application("SISLAB_HTTP_WEBSERVICE") & "/HelloWorld"
SoapRequest.open "GET", SoapUrl, False
SoapRequest.send (SoapUrl)


'Set ws = New TWebservice
'ws.url = Application("SISLAB_HTTP_WEBSERVICE")
''ws.method = "HelloWorld"
'ws.method = "ObtemUsuario"
'ws.parameters.Add "login", usuario
'ws.Invoke


Dim myXML
Set myXML = Server.CreateObject("MSXML.DOMDocument")
myXML.Async = False

response.write "WS: " & Application("SISLAB_HTTP_WEBSERVICE") & "/ObtemUsuario?login=galmeida"
response.write "<BR><BR>"
'response.write "Response: " & ws.Response
'response.write "Response: " & SoapRequest.responseXML


'If Not myXML.Load(ws.Response) Then
If Not myXML.Load(SoapRequest.responseXML) Then
    response.write "<BR><BR>"
    response.write "** ERRO LEITURA  "
Else
    Dim nodesURL
    Dim ret

    Response.ContentType = "text/xml"
    Set nodesURL = myXML.documentElement.selectNodes("Usuario")
    ret = myXML.documentElement.childNodes(0).nodeValue

    response.write "<BR><BR>"
    response.write "Email: " & ret

End If






response.write "<BR><BR>** FIM **"


Set ws = Nothing
%>
