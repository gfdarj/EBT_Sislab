<!--#include file="../includes/Sislab_Lib.asp"-->
<%
'###
'###	AJAX DAS COMBOS DE FILTRO DOS MULTIPLOS AMBIENTES
'###
Dim sBuf

Response.Clear()

'# Evitar problemas com acentuação no ajax
Response.Charset = Application("SISLAB_CHARSET")

sBuf = "<option value=''>--</option>"

'If Not VVVNZ(Request("AS")) Then
	Dim RS
	Dim sSQL

    If Cstr(Request("amb_modulo")) = Cstr(Application("SISLAB_ID_APLICACAO_SCE")) Then
    	sSQL = "SELECT a.AMB_ID AS [VALOR], crt.SIGLA_CRT + '-' + a.AMB_NOME AS [DESCRICAO] "
    Else
    	sSQL = "SELECT a.AMB_ID AS [VALOR], a.AMB_NOME + ' (' + crt.NM_CRT + ' / ' + CASE WHEN AMB_MODULO = " & Application("SISLAB_ID_APLICACAO_SISLAB") & " THEN 'SISLAB' ELSE 'SCE' END + ')' AS [DESCRICAO] "
    End If

    sSQL = sSQL & _
        "FROM Ambientes a INNER JOIN CentroReferencia crt ON a.ID_CRT = crt.ID_CRT " & _
		"WHERE 1 = 1" & IIf(VVVNZ(Request("amb_id")), "", " AND a.AMB_ID = " & Request("amb_id")) & _
        "           " & IIf(VVVNZ(Request("id_crt")), "", " AND a.ID_CRT= " & Request("id_crt")) & _
        "           " & IIf(VVVNZ(Request("amb_modulo")), "", " AND a.AMB_MODULO= " & Request("amb_modulo"))

    If Cstr(Request("amb_modulo")) = Cstr(Application("SISLAB_ID_APLICACAO_SCE")) Then
        sSQL = sSQL & _
            "ORDER BY crt.SIGLA_CRT, a.AMB_NOME;"
    Else
        sSQL = sSQL & _
            "ORDER BY a.AMB_NOME;"
    End If

    'response.Write ssql & "<br>"

	Set RS = Env.oConn.Execute(sSQL)

    If Not (RS.Eof And RS.Bof) Then
	    While Not RS.Eof
		    sBuf = sBuf & "<option value='" & RS("VALOR") & "'>" & RS("DESCRICAO") & "</option>"
		    RS.MoveNext
	    WEnd
    Else
    End If

	Set RS = Nothing
'End If

Response.Write(sBuf)
%>

