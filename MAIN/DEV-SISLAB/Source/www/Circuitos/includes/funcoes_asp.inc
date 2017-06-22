<%
'== Comeco de rotinas genericas em ASP =========================================================
Function FormataDataHoraDB(dDataaFormatar)
	' Formats to "m/d/yyyy h:mm:ss AM" format
	' Change as appropriate to match your DB
	Dim strMonth, strDay, strYear
	Dim strHour, strMinute, strSecond
	Dim strAMPM
	
	strMonth = Month(dDataaFormatar)
	strDay = Day(dDataaFormatar)
	strYear = Year(dDataaFormatar)
	'strYear = Right(Year(dDataaFormatar), 2)

	strHour = Hour(dDataaFormatar) Mod 24
'	If strHour = 0 Then strHour = 12
	
'	If Hour(dDataaFormatar) < 12 Then
'		strAMPM = "AM"
'	Else
'		strAMPM = "PM"
'	End If

	strMinute = Minute(dDataaFormatar)
	If Len(strMinute) = 1 Then strMinute = "0" & strMinute
	
	strSecond = Second(dDataaFormatar)
	If Len(strSecond) = 1 Then strSecond = "0" & strSecond

	' "d/m/yyyy h:mm:ss AM" for all those who have had problems.
'	FormataDataHoraDB = strDay & "/" & strMonth & "/" & strYear & " " & strHour & ":" & strMinute & ":" & strSecond 
	
	FormataDataHoraDB = strMonth & "/" & strDay & "/" & strYear & " " & strHour & ":" & strMinute & ":" & strSecond & " " & strAMPM
End Function

Function FormataDataDisplay(dDataaformatar)
	' Formats to "m/d/yyyy h:mm:ss AM" format
	' Change as appropriate to match your display wishes
	Dim strMonth, strDay, strYear

	
	strMonth = Month(dDataaformatar)
	strDay = Day(dDataaformatar)
	strYear = Year(dDataaformatar)

	FormataDataDisplay = strDay & "/" & strMonth & "/" & strYear  

End Function

Function FormataDataHoraDisplay(dDataaformatar)
	' Formats to "m/d/yyyy h:mm:ss AM" format
	' Change as appropriate to match your display wishes
	Dim strMonth, strDay, strYear
	Dim strHour, strMinute, strSecond
	Dim strAMPM
	
	strMonth = Month(dDataaformatar)
	strDay = Day(dDataaformatar)
	strYear = Year(dDataaformatar)
	'strYear = Right(Year(dDataaformatar), 2)

	strHour = Hour(dDataaformatar)

	strMinute = Minute(dDataaformatar)
	If Len(strMinute) = 1 Then strMinute = "0" & strMinute
	
	strSecond = Second(dDataaformatar)
	If Len(strSecond) = 1 Then strSecond = "0" & strSecond

	' "d/m/yyyy h:mm:ss AM" for all those who have had problems.
	FormataDataHoraDisplay = strDay & "/" & strMonth & "/" & strYear & " " & strHour & ":" & strMinute & ":" & strSecond 

End Function
'== Fim das Rotinas ==============================================================
%>