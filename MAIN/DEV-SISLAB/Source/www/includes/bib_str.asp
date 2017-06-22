<%
'--------------------------------------------------------------------------------------------
'-- ARQUIVO DE FUNCOES E VALIDACOES - SISTEMA SCE / SISLAB
'-- coppetec
'--------------------------------------------------------------------------------------------

function FormataNumero(numero)
	if trim(numero) = "" Then Exit function

	Dim iWhole, iLen, sFraction, iDecimalPoints
	Dim i
	Dim sResult

	numero = Round(numero, 2)
	iWhole = Int(numero)
	iLen = Len(iWhole)
	iDecimalPoints = Len(numero) - iLen
	if iDecimalPoints > 0 Then sFraction = Right(numero, iDecimalPoints)
	For i = 1 To iLen
		sResult = Mid(iWhole, iLen - i + 1, 1) & sResult
		if (i Mod 3 = 0) And (i <> iLen) Then sResult = "," & sResult
	Next
	FormataNumero = sResult & sFraction
End function


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

Function Br2Enter(valor)	'-- converte <br> em carriage return + line feed
	Br2Enter = replace(valor, "<br>", vbCrLf)
	Br2Enter = replace(Br2Enter, "<BR>", vbCrLf)
	Br2Enter = replace(Br2Enter, "<Br>", vbCrLf)
	Br2Enter = replace(Br2Enter, "<bR>", vbCrLf)
End Function

Function Enter2Br(valor)	'-- converte carriage return + line feed em <br>
	Enter2Br = replace(valor, vbCrLf, "<br>")
	Enter2Br = replace(Enter2Br, vbCrLf, "<BR>")
	Enter2Br = replace(Enter2Br, vbCrLf, "<Br>")
	Enter2Br = replace(Enter2Br, vbCrLf, "<bR>")
End Function

Function Nome_do_Mes(mes)
	Select Case mes
	Case 1
		Nome_do_Mes = "Janeiro"
	Case 2
		Nome_do_Mes = "Fevereiro"
	Case 3
		Nome_do_Mes = "Março"
	Case 4
		Nome_do_Mes = "Abril"
	Case 5
		Nome_do_Mes = "Maio"
	Case 6
		Nome_do_Mes = "Junho"
	Case 7
		Nome_do_Mes = "Julho"
	Case 8
		Nome_do_Mes = "Agosto"
	Case 9
		Nome_do_Mes = "Setembro"
	Case 10
		Nome_do_Mes = "Outubro"
	Case 11
		Nome_do_Mes = "Novembro"
	Case 12
		Nome_do_Mes = "Dezembro"
	Case Else
		Nome_do_Mes = "Mês Inválido"
	End Select
End Function

'insere um BR em uma string para que seja quebrada durante a exibicao em uma lista
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