<!--#include file="../includes/Sislab_Lib.asp"-->
<!--#include file="../includes/global.asp"-->
<%
'###
'###	AJAX DE TESTE DO CÓDIGO DE BARRAS - RETORNA O ID DO CÓDIGO, SE NÃO EXISTE ZERO
'###

'# Evitar problemas com acentuação no ajax
Response.Charset="ISO-8859-1"

'#####
'#	Atualiza o inventário do equipamento com a data de hoje
'###
If Not VVVNZ(Request("codbarras")) Then
	Dim RS
	Dim sSQL
	Dim sBuffer

	sSQL = "select EQ_ID from sce_equipamentos where EQ_CODIGOBARRAS = '" & Request("codbarras") & "'"
	Set RS = Env.oConn.Execute(ssql)

	If Not (RS.Eof and RS.Bof) Then
		sBuffer = RS("EQ_ID")
	Else
	    sBuffer = 0
	End If

	Response.Write(sBuffer)

	Set RS = Nothing
End If
%>

