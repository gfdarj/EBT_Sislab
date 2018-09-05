<!--#INCLUDE FILE="../SCE/includes/abre.asp" -->
<!--#inc lude file="../includes/Sislab_Lib.asp"-->
<!--#incl ude file="../includes/global.asp"-->
<!--#inc lude file="../includes/funcoes.asp"-->
<!--#include file="../SCE/includes/controlesHTML_SCE.asp" -->
<%
'###
'###	AJAX DA COMBO DE NATUREZA DE OPERAÇÃO NA TELA DE MOVIMENTAÇÃO DO SCE
'###
Response.Clear()

'# Evitar problemas com acentuação no ajax
Response.Charset="ISO-8859-1"

'#####
'#	Atualiza o inventário do equipamento com a data de hoje
'###
If Not VVVNZ(Request("tipo_mov")) Then
	Dim RS
	Dim sSQL
	Dim sBuf

	sBuf = "" ' " [val]--[fim]"

	sSQL = _
		"select no_id as VALOR, no_descricao as DESCRICAO from sce_natureza_operacao " & VbCrLf & _
		"where no_tipo = " & Request("tipo_mov") & " " & VbCrLf & _
		"order by no_descricao asc"
	'call comboBDSQL("noid", Conn, sSQL, no_id, "N")
	Set RS = Conn.Execute(sSQL)

	While Not RS.Eof
		sBuf = sBuf & RS("VALOR") & "[val]" & RS("DESCRICAO") & "[fim]"
		RS.MoveNext
	WEnd

	Response.Write(sBuf)

	'Response.Write("<scr" & "ipt language='javascript'>document.all.noid.onchange = atualizarNOCampos;</scr" & "ipt>")
	Set RS = Nothing
End If
%>

