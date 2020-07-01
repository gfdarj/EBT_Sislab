<!--#include file="../includes/Sislab_Lib.asp"-->
<!--#include file="../includes/global.asp"-->
<%
'###
'###	AJAX DE TESTE DO NÚMERO DE SÉRIE - RETORNA O "OK" PARA N/S SEM REPETIÇÃO E "ERRO" QUANDO JÁ EXISTE
'###

Dim RS
Dim sSQL
Dim sBuffer

sBuffer = "OK"
'response.write "AQUI"
'response.end

If Not VVVNZ(Request("eq_numeroserie")) Then

    If VVVNZ(Request("eq_id")) Then
		sSQL = "select ISNULL(count(EQ_NUMEROSERIE), 0) AS [a] from SCE_Equipamentos where EQ_NUMEROSERIE = LTRIM(RTRIM('" & Request("eq_numeroserie") & "'))"
    Else
		sSQL = "select ISNULL(count(EQ_NUMEROSERIE), 0) AS [a] from SCE_Equipamentos where EQ_NUMEROSERIE = LTRIM(RTRIM('" & Request("eq_numeroserie") & "')) AND EQ_ID <> " & Request("eq_id")
    End If

	Set RS = Env.oConn.Execute(ssql)

	If Not (RS.Eof and RS.Bof) Then
        If RS(0) = 0 Then
		    sBuffer = "OK"
        Else
		    sBuffer = "ERRO"
        End If
	Else
	    sBuffer = "OK"
	End If

	Set RS = Nothing
End If

Response.Write(sBuffer)
%>
