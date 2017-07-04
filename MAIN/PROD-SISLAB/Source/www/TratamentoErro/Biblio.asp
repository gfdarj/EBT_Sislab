<!--#include file="adovbs.inc"-->
<%
Response.Expires =0

'Declaração de Variáveis Globais
Dim ObjConn
Dim ObjRS
Dim ObjConn1
Dim ObjConn2
Dim ObjRS1
Dim ObjCmd
Dim ObjParam
'Dim Vetor_Campos(220)

Sub Conecta_Base()
	Dim StrConn
	Set ObjConn = Server.CreateObject ("ADODB.Connection")
	Set ObjRS = Server.CreateObject ("ADODB.RecordSet")
	ObjRS.CursorLocation = adUseClient
	ObjRS.CursorType = adOpenKeySet
	ObjRS.LockType = adLockBatchOptimistic
	
	'Abre a conecção
	ObjConn.ConnectionString = "file name=d:\inetpub\ConexaoSQL\GerenciaWeb.udl"
	ObjConn.Open StrConn
	
End Sub


'------------------------------------------------------------------------------------
' PerguntasRespostas -  ListarPergunta - Lista uma pergunta a partir do seu código
Sub x()
	Set ObjCmd = Server.CreateObject ("ADODB.Command")
	
	ObjCmd.CommandText = "WEB_ListarErros"		' Nome procedimento no servidor
	ObjCmd.CommandType  = adCmdStoredProc		        ' Tipo comando
	Set ObjCmd.ActiveConnection = ObjConn		        ' Associa o cammand com a conecção corrente
	
	Set ObjParam = ObjCmd.CreateParameter("ReturnCode", adInteger, adParamReturnValue)
	ObjCmd.Parameters.Append ObjParam
	
	Set ObjRS = ObjCmd.Execute()

End Sub
'----------------------------------------------------------------------------------------



'Desconecta os objetos de dados
Sub Desconecta_Base()

	ObjRs.Close : ObjConn.Close 
	Set ObjConn = Nothing
	Set ObjRs = Nothing 
	Set ObjCmd = Nothing 
	Set ObjParam = Nothing 

End Sub 

'Desconecta a base corrente
Sub Desconecta_Conn()

	ObjConn.Close 
	Set ObjConn = Nothing

End Sub

%>


