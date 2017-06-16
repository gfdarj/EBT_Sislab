<!--#include file="adovbs.inc"-->
<%Sub Connection(opcao, conexao)
	On Error Resume Next 'necessário novamente devido à forma como este comando foi implementado
	'If(opcao)Then
		Set conexao = Server.CreateObject("ADODB.Connection")
		'-- desenv
		'---------conexao.Open "Provider=sqloledb;User ID=sislab1;Password=sislab1; Initial Catalog=SISLAB1; Data Source=ntspo905"

		'-- prod
		conexao.Open "Provider=sqloledb;User ID=sislab1;Password=sislab1001; Initial Catalog=SISLAB; Data Source=ntspo006"
		If conexao.Errors.Count > 0 Then Call ImprimeErrosConexao(conexao.Errors)
	'Else
		'conexao.Close
		'Set conexao = Nothing
	'End If
End Sub

Sub RecordSet(opcao, record, strExec, conexao)
	If(opcao)Then
		Set record = Server.CreateObject("ADODB.RecordSet")
		record.Open strExec, conexao ', adOpenKeySet
	Else
		record.close
		Set record = Nothing
	End If
End Sub

Sub StoredProcedure(opcao, command, strExec, conexao)
	If(opcao)Then
		Set command = Server.CreateObject("ADODB.Command")
		command.CommandType = adCmdStoredProc
		command.CommandText = strExec
		Set command.ActiveConnection = conexao
	Else
		Set command.ActiveConnection = Nothing
		Set command = Nothing
	End If
End Sub
%>