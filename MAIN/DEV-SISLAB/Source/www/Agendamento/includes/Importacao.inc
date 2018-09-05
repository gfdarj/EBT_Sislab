<%
Response.Expires=0
Response.Buffer = TRUE
Response.Clear

Dim byteCount, RequestBin, UploadRequest, contentType, filepathname, filename, value, ScriptObject, _
    pathEnd, PathFileName, MyFile, i, importacao, str, strerro  

byteCount = Request.TotalBytes

RequestBin = Request.BinaryRead(byteCount)

Set UploadRequest = CreateObject("Scripting.Dictionary")

BuildUploadRequest  RequestBin

contentType = UploadRequest.Item("txtArquivo").Item("ContentType")
filepathname = UploadRequest.Item("txtArquivo").Item("FileName")
filename = Right(filepathname,Len(filepathname)-InstrRev(filepathname,"\"))
value = UploadRequest.Item("txtArquivo").Item("Value")

'Create FileSytemObject Component
 Set ScriptObject = Server.CreateObject("Scripting.FileSystemObject")

'Create and Write to a File
 pathEnd = Len(Server.mappath(Request.ServerVariables("PATH_INFO")))-tam
 
 if LenB(value) > 0 then

    PathFileName = Left( Server.mappath(Request.ServerVariables("PATH_INFO")),pathEnd)&"Arquivos\"&filename
    Set MyFile = ScriptObject.CreateTextFile(PathFileName)
 
    For i = 1 to LenB(value)
	   MyFile.Write chr(AscB(MidB(value,i,1)))
    Next
    MyFile.Close
    Set MyFile = Nothing
    
 else
   strerro= "Importacao.asp?err=2"
 end if
      
 
   Set ScriptObject=Nothing
  
%>
