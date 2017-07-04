<!--#include file="../includes/Sislab_Lib.asp"-->
<!--#include file="../includes/global.asp"-->
<%
'###
'###	AJAX DA COMBO DE NATUREZA DE OPERAÇÃO NA TELA DE MOVIMENTAÇÃO DO SCE
'###

'# Evitar problemas com acentuação no ajax
Response.Charset="ISO-8859-1"

'#####
'#	Atualiza o inventário do equipamento com a data de hoje
'###
If Not VVVNZ(Request("no_id")) Then
	Dim RS
	Dim sSQL
	Dim sBuffer

	sSQL = "select CAST(CDE AS INT) AS CDE, CAST(ASA AS INT) AS ASA from sce_natureza_operacao where no_id = " & Request("no_id")

	Set RS = Env.oConn.Execute(ssql)

	If Not (RS.Eof and RS.Bof) Then
		if IsNull(RS("CDE")) Then sBuffer = "0" Else sBuffer = RS("CDE")
		if IsNull(RS("ASA")) Then sBuffer = sBuffer & "0" Else sBuffer = sBuffer & RS("ASA")
	End If

	Response.Write(sBuffer)

	Set RS = Nothing
End If
%>

