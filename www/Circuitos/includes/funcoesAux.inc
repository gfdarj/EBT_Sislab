<%
	Function trocaAspas(str)
		if (isNull(str)=false) then	str = Replace(str,"\","\\")
		if (isNull(str)=false) then	str = Replace(str,"'","\'")
'		Response.write str
		trocaAspas = str
	End Function

	Sub trocaEnter(str)
		if (isNull(str)=false) then	str = Replace(str,vbcrlf," \n")
		Response.write str
	End Sub

	Sub trocaVirgula(valor)
		if (isNull(valor)=false) then
			valor = FormatNumber(valor,2,,,0)
'			valor = Replace(valor,".","")
'                        valor = fix(cdbl(valor)*100)/100
		end if
		Response.write valor
	End Sub

	Sub moeda(valor)
		if (isNull(valor)=false) then
			valor = Replace(valor,",",".")
			if instr(valor, ".")=0 then valor = valor&".00"
			if instr(valor, ".")=len(valor)-1	then valor = valor&"0"
		end if
		Response.write valor
	End Sub

	Sub FormataNumero(valor,casas)
		if (isNull(valor)=false) then
			valor = FormatNumber(valor,casas)
		end if
		Response.write valor
	End Sub

	Sub FormataDinheiro(valor,casas)
		if (isNull(valor)=false) then
			valor = FormatCurrency(valor,casas)
		end if
		Response.write valor
	End Sub

	Function TruncaStr(str, tamanho)
		dim s
		s = trim(str)
		if len(s) > tamanho then
			TruncaStr =  left(s,tamanho-3) & "..."
		else
			TruncaStr = s
		end if
	End Function
%>
