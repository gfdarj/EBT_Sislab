<%
'### BIBLIOTECA GENERICA COM FUNCOES DE DATA E HORA ###

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

	strHour = Hour(dDataaformatar) Mod 24

	strMinute = Minute(dDataaformatar)
	If Len(strMinute) = 1 Then strMinute = "0" & strMinute
	
	strSecond = Second(dDataaformatar)
	If Len(strSecond) = 1 Then strSecond = "0" & strSecond

	' "d/m/yyyy h:mm:ss AM" for all those who have had problems.
	FormataDataHoraDisplay = strDay & "/" & strMonth & "/" & strYear & " " & strHour & ":" & strMinute & ":" & strSecond 

End Function
'== Fim das Rotinas ==============================================================
%>