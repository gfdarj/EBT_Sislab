<%
'***********************************************************************************
'
' Classe para acessar WebServices
' Author: Angelo Bestetti
' http://www.i-stream.com.br
' Purpose: Acessar webservices www.consultacpf.com
' Date: 2007/10/18
'***********************************************************************************

'---- O site já usa essa opção
'Option Explicit

'**************************************************** 
' Classe para WebService
'****************************************************
Class TWebService
  Public Url
  Public Method
  Public ContentType
  Public Response
  Public Parameters

 
  ' Funcao para Invokar o WebService
  Public Function Invoke()
    Dim xmlhttp
    Set xmlhttp = Server.CreateObject("MSXML2.XMLHTTP")
    xmlhttp.open "POST", Url & "/" & Method, false
    xmlhttp.setRequestHeader "Content-Type", ContentType
    xmlhttp.Send Parameters.toString
    response = xmlhttp.responseText
    response = Replace(response, "<string xmlns=""http://tempuri.org/"">", "")
    response = Replace(response, "</string>", "")
    set xmlhttp = nothing
  End Function


  ' Funcao para Invokar o WebService, convertendo a string binária do XML em um binário para escrita como arquivo
  Public Function InvokeBinary()
    Dim xmlhttp
    Set xmlhttp = Server.CreateObject("MSXML2.XMLHTTP")

    xmlhttp.open "POST", Url & "/" & Method, false
    xmlhttp.setRequestHeader "Content-Type", ContentType
    xmlhttp.Send "&" & Parameters.toString
    response = xmlhttp.responseText

    Dim tmpDoc, nodeB64
    Set tmpDoc = Server.CreateObject("MSXML2.DomDocument")
    Set nodeB64 = tmpDoc.CreateElement("b64")
    nodeB64.DataType = "bin.base64" ' stores binary as base64 string
    On Error Resume Next
    nodeB64.Text = LTrim(Replace(Replace(Replace(response, "<?xml version=""1.0"" encoding=""utf-8""?>" & VbCrLf, ""), "<base64Binary xmlns=""http://tempuri.org/"">", ""), "</base64Binary>", ""))
    On Error Goto 0
    response = nodeB64.NodeTypedValue 'get bytes and write

    set xmlhttp = nothing
    set nodeB64 = nothing
    set tmpDoc = nothing
  End Function


  ' Funcao para Invokar o WebService
  Public Function InvokeBody()
    Dim xmlhttp
    Set xmlhttp = Server.CreateObject("MSXML2.XMLHTTP")
    xmlhttp.open "POST", Url & "/" & Method, false
    xmlhttp.setRequestHeader "Content-Type", ContentType
    xmlhttp.Send Parameters.toString
    response = xmlhttp.ResponseBody
    set xmlhttp = nothing
  End Function

  
  Private Sub Class_Initialize()
    Set Parameters = New wsParameters
    ContentType = "application/x-www-form-urlencoded"
  End Sub
  
  Private Sub Class_Terminate()
    Set Parameters = Nothing
  End Sub
  
End class

'**************************************************** 
' Classe para wsParameters
'****************************************************
Class wsParameters
  Public mCol
  Public Function toString()
    Dim nItem
    Dim buffer
    buffer = ""
    For nItem = 1 to Count
      buffer = buffer & Item(nItem).toString & "&"
    Next
    If right(buffer,1)="&" then
      buffer = left(buffer,len(buffer)-1)
    End if
    toString = buffer 
  End Function
  
  Public Sub Clear
    set mcol = nothing 
    Set mCol = Server.CreateObject("Scripting.Dictionary") 
  End Sub
  
  Public Sub Add(pKey,pValue)
    Dim NewParameter
  
    Set NewParameter = New wsParameter
    NewParameter.Key = pKey
    NewParameter.Value = pValue
    mCol.Add mCol.count+1, NewParameter
  
    Set NewParameter = Nothing
  End Sub
  
  Public Function Item(nKey)
    Set Item=mCol.Item(nKey)
  End Function
  
  Public Function ExistsXKey(pKey)
    Dim nItem
  
    For nItem = 1 to mcol.count
      If mCol.Item(nItem).key = pKey Then
        ExistsXKeyword = True
        Exit For
      End if
    Next
  End Function
  
  Public Sub Remove(nKey)
    mCol.Remove(nKey)
  End sub
  
  Public Function Count()
    Count=mCol.count
  End Function
  
  Private Sub Class_Initialize()
    Set mCol = Server.CreateObject("Scripting.Dictionary")
  End Sub
  
  Private Sub Class_Terminate()
    Set mCol = Nothing
  End Sub
  
End class

'**************************************************** 
' Classe para wsParameter
'****************************************************
Class wsParameter
   Public Key
   Public Value
   Public Function toString()
     toString = Key & "=" & Value
   End Function
End Class




'**************************************************** 
'   EXEMPLO DO ASP !!!
'**************************************************** 
'#include file="cls_webservice.asp"--&gt;
'dim ws

'set ws = new webservice
'ws.url = "http://www.consultacpf.com/webservices/consultacpf.asmx"
'' Podendo ser: ConsultaSaldoCliente, ConsultaSinteseCadastralSERASA, ConsultaSimplesSERASASandBox, ConsultaSimplesSERASA, ConsultaDetalhadaSERASA
'' Maiores Informações: http://www.consultacpf.com/webservices/consultacpf.asmx
'ws.method = "ConsultaDetalhadaSERASA" 

'ws.parameters.Add "Email","seuemailaqui"
'ws.parameters.Add "Senha","suasenhaaqui"
'ws.parameters.Add "Documento","cpf/cnpj a ser consultado"
 
'ws.Invoke
'response.Write ws.response

'set ws = nothing
'**************************************************** 

%>
