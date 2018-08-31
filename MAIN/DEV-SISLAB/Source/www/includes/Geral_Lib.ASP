<%
'----------------------------------------------------------------------------------
' GERAL_LIB.ASP
'
' Biblioteca de funções gerais do SISLAB
'----------------------------------------------------------------------------------

Sub RW(chr_Buf)
	Response.Write chr_Buf
End Sub

Sub RE
	Response.End
End Sub

Sub RR(chr_Buf)
	Response.Redirect chr_Buf
End Sub

Function RQ(chr_Buf)
	RQ = Request(chr_Buf)
End Function

Function IIf(condition, string_expression1, string_expression2)
	If condition Then
		IIf = string_expression1
	Else
		IIf = string_expression2
	End If
End Function

'***********************************************************************
' verifica se o valor passado é nulo, vazio ou zero
' Marcio Barbosa - 27/11/2002
' VVVNZ = verifica valor vazio nulo zero
'***********************************************************************
Function VVVNZ(valor)
    If VVVN(valor) Or Trim(valor) = "0" Then
		VVVNZ = True
	Else
		VVVNZ = False
	End If
End Function

'***********************************************************************
' verifica se o valor passado é nulo ou vazio
' Marcio Barbosa - 28/01/2003
' VVVN = verifica valor vazio nulo
'***********************************************************************
Function VVVN(valor)
	On Error Resume Next
	If isObject(valor) Then
		if valor is nothing Then
			VVVN = True
			Exit Function
		End If
	End If

	Dim chr_aux
	chr_aux = valor
    If IsNull(chr_aux) Or Trim(chr_aux) = "" Or Trim(UCase(chr_aux)) = "NULL" Or isEmpty(chr_aux) Then
        VVVN = True
    Else
        VVVN = False
    End If

    If Err <> 0 Then VVVN = True

	On Error GoTo 0

End Function


Function Reticencias(chr_Texto, int_Size)

	If Len(chr_Texto) > int_Size Then
		Reticencias = Left(chr_Texto, int_Size) & "..."
	Else
		Reticencias = chr_Texto
	End If

End Function
%>
