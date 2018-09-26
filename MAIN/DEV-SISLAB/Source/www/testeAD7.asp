<!--#include file="Classes/Classe_WebService.asp"-->
<!--#inc    lude file="Classes/Classe_EmbratelSVC.asp"-->

<%
dim ws, usuario, URL

URL = Application("SISLAB_HTTP_WEBSERVICE")

usuario = "t3gfba"
'usuario = "galmeida"


Set ws = New TWebservice
ws.url = URL
'ws.method = "HelloWorld"
ws.method = "ObtemUsuario"
ws.parameters.Add "login", usuario
ws.Invoke



response.write "WS: " & URL
response.write "<BR><BR>"
response.write "Response: " & ws.Response
'response.write "Response: " & SoapRequest.responseXML
response.write "<BR><BR>"

response.end








' Cria uma instância do controle
Set MsXml = Server.CreateObject("MSXML2.DOMDocument.3.0")
' Indicamos que o download em segundo plano não é permitido
MsXml.async = False
' Carrega o documento XML
MsXml.loadXML(ws.Response)
 
' A propriedade documentElement refere-se à raiz do documento
Set raiz = MsXml.documentElement

'Looping para percorrer todos os elementos filhos
For i = 0 To raiz.childNodes.length -1
' A propriedade NodeName contém o nome do elemento e a propriedade childNodes contém a lista de elementos filhos
	Response.Write raiz.NodeName & "<br />"
'	Response.Write raiz.childNodes.item(i).childNodes.item(0).text & "<br />"
'	Response.Write raiz.childNodes.item(i).childNodes.item(1).text & "<br />"
Next 

' Tira o objeto da memória
Set MsXml = Nothing






response.end















Dim xml: Set xml = Server.CreateObject("MSXML2.DOMDocument.3.0") 
xml.LoadXml(ws.Response)'Load string into objXMLDoc

Dim sResult: sResult = ""
Dim node
'node = xml.selectSingleNode("/usuario")
'For Each node in xml.selectSingleNode("/usuario").childNodes
'	sResult = sResult & node.xml
'Next
'Response.Write "xmlDoc: " & xml.DocumentElement.GetElementsByTagName("Usuario/Nome")
'Response.Write Server.HTMLEncode(sResult) 




Dim xmlResult
Set xmlResult = Server.CreateObject("MSXML2.DomDocument.3.0")
xmlResult.loadXML(ws.response)

'Set oRoot = xmlResult.selectSingleNode("//Usuario//Nome/text()")

'response.write "XXXX AQUI !<BR><BR>"  & oroot.Text

'For Each Node In oRoot
'    '' # Do something useful... ?? Distinct fields??
'    Set Node = Node.selectSingleNode("Nome")
'    If Not Node Is Nothing Then
'        Response.Write Server.HTMLEncode(Node.nodeValue) & "<br />"
'    End If
'Next



Response.End


'Looping para percorrer todos os elementos filhos
For i = 0 to raiz.childNodes.length -1
	'A propriedade NodeName contém o nome do elemento
	'A propriedade childNodes contém a lista de elementos filhos
	response.Write raiz.NodeName & "<br>" & raiz.childNodes.item(i).childNodes.item(0).text & "<br>" & raiz.childNodes.item(i).childNodes.item(1).text & "<br>" & raiz.childNodes.item(i).childNodes.item(2).text & "<br>" & raiz.childNodes.item(i).childNodes.item(3).text & "<p>"
next







'resultado = xmlResult.SelectNodes("/Nome").Text


if resultado = "-2" then
     %><script>alert("CEP inválido");</script><%
else
     resultado_txt = xmlResult.selectSingleNode("/Usuario").Text
     uf = xmlResult.SelectNodes("//Nome").item(0).Text
     cidade = xmlResult.SelectNodes("//Email").item(0).Text
end if

response.write      resultado_txt & "<BR><BR>"
response.write     uf & "<BR><BR>"
response.write     cidade  & "<BR><BR>"


set xmlHttp = nothing
set xmlResult = nothing








Dim myXML
Set myXML = Server.CreateObject("MSXML.DOMDocument")
myXML.Async = False

If Not myXML.Load(ws.Response) Then
'If Not myXML.Load(SoapRequest.responseXML) Then
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
