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
'#	Fornecedor SCE
'###
sBuf = sBuf & "<option value=''>--</option>"

If Not VVVNZ(Request("tipo")) Then
	Dim RS
	Dim sSQL
    Dim tipo, completa

    tipo = UCase(Request("tipo"))
    completa = UCase(Request("completa"))

	sSQL = "select enf_id as VALOR, (case when enf_nome is null then '' else LEFT(enf_nome, 50) end) + "

	If completa = "S" Then
		sSQL = sSQL & "(case when enf_cidade is null or enf_cidade = '' then '' else ' / ' + enf_cidade end) + "
	End If

	sSQL = sSQL & _
			"(case when enf_cnpj is null or enf_cnpj = '' then '' else '&nbsp;&nbsp;(' + " & _
			"left(enf_cnpj, 2) + '.' + substring(enf_cnpj, 3, 3) + '.' + substring(enf_cnpj, 6, 3) + '/' + substring(enf_cnpj, 9, 4) + '-' + right(enf_cnpj, 2) + ')' end) "

	If completa = "S" Then
		sSQL = sSQL & " + ' [' + ENF_TIPOEMPRESA + ']' "
	End If

	sSQL = sSQL & _
			"as DESCRICAO " & _
			"from sce_empresa_nota_fiscal "

	If tipo = "F" Then
		ssql = ssql & "where enf_tipoempresa = 'F'"
	Elseif tipo = "T" Then
		ssql = ssql & "where enf_tipoempresa = 'T'"
	End If

	sSQL = sSQL & "order by enf_nome, enf_cidade"

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

'response.Write sSQL 
Response.Write(sBuf)
%>
