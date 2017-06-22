<!--#include file="../includes/Sislab_Lib.asp"-->
<!--#include file="../includes/global.asp"-->
<!--#include file="../includes/funcoes.asp"-->
<!--#include file="../includes/Geral_Lib.asp"-->
<%
'#####
'#	Troca a prioridade de um agendamento
'###

'response.Write(Request("ag_numero"))
'response.End()

If Not VVVNZ(Request("ag_numero")) Then
	Dim RS
	Set RS = Env.oConn.Execute( _
		"UPDATE Agendamento SET AG_PRIORIDADE = " & IIf(Request("id_prioridade") = "", "NULL", Request("id_prioridade")) & " " & VbCrLf & _
		"WHERE AG_NUMERO = " & Request("ag_numero") & "; " & VbCrLf _
	)
	Set RS = Nothing
	Response.Write("")
End If
%>

