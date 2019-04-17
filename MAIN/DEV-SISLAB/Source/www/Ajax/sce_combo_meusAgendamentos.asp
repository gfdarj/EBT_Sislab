<!--#include file="../includes/Sislab_Lib.asp"-->
<%
'###
'###	AJAX DA COMBO DE NATUREZA DE OPERAÇÃO NA TELA DE MOVIMENTAÇÃO DO SCE
'###
Dim sBuf

Response.Clear()

'# Evitar problemas com acentuação no ajax
Response.Charset = Application("SISLAB_CHARSET")

'#####
'#	Atualiza o inventário do equipamento com a data de hoje
'###
sBuf = sBuf & "<option value=''>--</option>"

If Not VVVNZ(Request("AS")) Then
	Dim RS
	Dim sSQL

	sBuf = ""

	sSQL = _
		"select AG_NUMERO as VALOR, CASE WHEN AG_TITULO IS NULL THEN Cast(AG_NUMERO as VARCHAR(10)) ELSE Cast(AG_NUMERO as VARCHAR(10)) + '-' + AG_TITULO END AS DESCRICAO " & _
		"from Agendamento where CAST(AG_NUMERO AS VARCHAR) LIKE '" & Request("AS")  & "%' order by AG_NUMERO desc"

	Set RS = Env.oConn.Execute(sSQL)

    If Not (RS.Eof And RS.Bof) Then
	    While Not RS.Eof
		    sBuf = sBuf & "<option value='" & RS("VALOR") & "'>" & RS("DESCRICAO") & "</option>"
		    RS.MoveNext
	    WEnd
    Else
    End If

	Set RS = Nothing
End If

Response.Write(sBuf)
%>

