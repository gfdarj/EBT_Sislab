<%
'--------------------------------------------------------------------------------------------
'-- ARQUIVO DE FUNCOES E VALIDACOES STRINGS - SISTEMA SCE
'-- coppetec
'--------------------------------------------------------------------------------------------

'-- exibe tela de erro com uma mensagem HTML passada por parametro
function erroHtml(msg)%>
<html>
<head>
	<title>SCE - ERRO</title>
	<link rel="stylesheet" href="css/estilo.css">
</head>
<body>
	<table height="100%" width="100%" align="center">
	<tr valign="middle">
		<td><%response.write msg%></td>
	</tr>
	</table>
</body>
</html><%
end function

function Zeros(num, tamanho)
	Dim n
	n = trim(cstr(num))
	if tamanho - len(n) > 0 then Zeros = string(tamanho - len(n), "0") & n else Zeros = n
end function

Function FormataData(data, hora)
	Dim sDay, sMonth, sYear, sHour, sMinute, sSecond, ret

	if data <> "" and not isnull(data) then
		sDay = Day(data)
		sMonth = Month(data)
		sYear = Year(data)
		If len(sDay) = 1 Then
			sDay = "0" & sDay
		end if
		If len(sMonth ) = 1 Then
			sMonth = "0" & sMonth
		end if
	end if

	if hora <> "" and not isNull(hora) then
		sHour = Hour(hora)
		sMinute = Minute(hora)
		sSecond = Second(hora)
		If len(sHour) = 1 Then
			sHour = "0" & sHour
		end if
		If len(sMinute) = 1 Then
			sMinute = "0" & sMinute
		end if
		If len(sSecond) = 1 Then
			sSecond = "0" & sSecond
		end if
	end if

	ret = ""
	if data <> "" and not isNull(data) then ret = sDay & "/" & sMonth & "/" & sYear

	if hora <> "" and not isNull(hora) then
		if ret <> "" then ret = ret + " "
		ret = ret & sHour & ":" & sMinute & ":" & sSecond
	end if

	'Response.Write sDay & "/" & sMonth & "/" & sYear " " & sHour & ":" & sMinute & ":" & sSecond
	FormataData = ret
End Function

Function SimNao(valor)
	if IsNull(valor) then
		SimNao = "&nbsp;"
	else
		if valor then
			SimNao = "Sim"
		else
			SimNao = "Não"
		end if
	end if
End Function

Function ehVazio(valor)
	if trim(valor) = "" or lcase(trim(valor)) = "&nbsp;" or IsNull(valor) then
		ehVazio = True
	else
		ehVazio = False
	end if
End Function

Function ConverteNulo(valor)
	if trim(valor) = "" or lcase(trim(valor)) = "&nbsp;" or IsNull(valor) then
		ConverteNulo = ""
	else
		ConverteNulo = valor
	end if
End Function

Function ConverteNuloHTML(valor)
	if trim(valor) = "" or lcase(trim(valor)) = "&nbsp;" or IsNull(valor) then
		ConverteNuloHTML = "&nbsp;"
	else
		ConverteNuloHTML = valor
	end if
End Function

Function FormataCnpj(valor)
	if IsNull(valor) then
		FormataCnpj = ""
	else
		valor = trim(valor)
		FormataCnpj = _
				left(valor, 2) + "." + mid(valor, 3, 3) + "." + _
				mid(valor, 6, 3) + "/" + mid(valor, 9, 4) + "-" + _
				right(valor, 2)
	end if
End Function

Function ConcatenaDataHora(data, hora)
	ConcatenaDataHora = Trim(ConverteNulo(data) & " " & ConverteNulo(hora))
End Function

Function RepeteStr(str, qtde)
	Dim i : i = 1
	RepeteStr = ""
	for i = 1 to qtde
		RepeteStr = RepeteStr & str
	next
End Function

'-- insere um BR em uma string para que seja quebrada durante a exibicao em uma
'-- lista
Function InsereBR(valor, tamanho)
	Dim int_quebras
	Dim int_conta
	Dim chr_Buf
	Dim chr_Aux

	If IsNull(valor) Then valor = ""

	chr_Buf = ""

	If Len(valor) > tamanho Then
		int_quebras = int(Len(valor) / tamanho)
		For int_conta = 1 To int_quebras
			'chr_Buf = chr_Buf & Left(valor, tamanho) & "<br>" & Mid(valor, tamanho+1, Len(valor))

			chr_Aux = Left(valor, tamanho)
			valor = Mid(valor, tamanho+1, Len(valor))
			chr_Buf = chr_Buf & chr_Aux & "<br>"
		Next
	Else
		chr_Buf = valor
	End If

	InsereBR = chr_Buf
End Function

%>