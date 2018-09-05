<%
'** Retorna uma string data. Formatada para o formado dd/mm/aaaa
Function Data(d)
	dim dd, mm, aa
	if IsNull(d) or (d = "") or (not IsDate(d)) then
		dd = Day(date)
		mm = Month(date)
		aa = Year(date)
	else
		dd = Day(d)
		mm = Month(d)
		aa = Year(d)
	end if
	if len(dd) = 1 then dd = "0" & dd
	if len(mm) = 1 then mm = "0" & mm
	Data = dd & "/" & mm & "/" & aa
End Function
%>