<!-- #INCLUDE FILE="adovbs.inc" -->
<%
If Request.ServerVariables("REMOTE_USER")="" Then
	Response.Status = "401 access denied"
else 
	Session("Username")=UCase(trim(mid(Request.ServerVariables("REMOTE_USER"),10)))
end if

'== Inicio das Contantes ============================================================
' Area de Definicao de Constantes p/ melhor entendimento do Codigo

Dim DB_CONNECTIONSTRING, DB_USERNAME, DB_PASSWORD

'-- DB_CONNECTIONSTRING = "DRIVER={SQL Server}; Server=ntrjo411;Database=SISLAB;"
'-- DB_CONNECTIONSTRING = "DRIVER={SQL Server}; Server=antonio;Database=SISLAB1;"

'-- desenvolvimento
'DB_CONNECTIONSTRING = "Provider=SQLOLEDB; Data Source = ntspo905; Initial Catalog=SISLAB1;" 
'DB_USERNAME = "User ID =sislab1;"
'DB_PASSWORD = "Password=sislab1;"

'-- producao - READ ONLY
'-- DB_CONNECTIONSTRING = "Provider=SQLOLEDB; Data Source = ntspo911; Initial Catalog=SISLAB1;" 
'-- DB_USERNAME = "User ID =sislabread;"
'-- DB_PASSWORD = "Password=sislabread;"

'-- producao
DB_CONNECTIONSTRING = "Provider=SQLOLEDB; Data Source = ntspo006; Initial Catalog=SISLAB1;"
DB_USERNAME = "User ID =sislab1;"
DB_PASSWORD = "Password=sislab1001;"

Session("DataAtual")=day(now)&"/"&month(now)&"/"&year(now)

	If Len(minute(now)) = 1 Then 
	  Session("HoraAtual")=hour(now)&":0"&minute(now)
	elseif Len(minute(now)) = 0 Then 
	  Session("HoraAtual")=hour(now)&":00"&minute(now)
	else
	  Session("HoraAtual")=hour(now)&":"&minute(now)
	end if
Session("DataHoraAtual")=FormataDataHoraDisplay(now)

'== DIM das Constantes ==============================================================

'== Inicio SUBS & FUNCTIONS =====================================================
Sub MostraHeader()
%>
<script language=javascript>
function Atualiza()
{
//	document.cabecalho.action=document.cabecalho.menu[document.cabecalho.menu.selectedIndex].value
	document.cabecalho.action="index.asp"
	document.cabecalho.submit();
}
</script>

<left>
<form name="cabecalho" method="post">
<!--table cellpadding="0" cellspacing="0" border="0" height="69" id="cabecalho">
<tr>
	<td background="img/barcantoesq.gif" width="23" height="69">
		&nbsp;
	</td>
	<td background="img/barmeio.gif" width="195"  height="69" valign="top" align="left">
		<a href="index.asp"><img src="img/logobarra3.gif" valign="top" border="0" /></a>
	</td>
	<td background="img/barmeio.gif" width="330"  height="69" valign="top" align="center">
		<a href="index.asp"><img src="img/barratitulo1.gif" valign="top" border="0" /></a>
	</td>
	<td background="img/barmeio.gif" width="150"  height="69" valign="top" align="right">
		<a href="http://pegasus/"><img src="img/ebtbar.gif" valign="top" border="0" /></a>
	</td>
	<td background="img/barcantodir.gif" width="70" height="69">
		&nbsp;
	</td>
</tr>
</table-->
<map name="teste">
<!-- aponta para producao, deveria apontar para o caminho relativo --
		<area alt="" coords="3,3,250,68" href="http://ntspo901/PORTALVPR/ProjetosEAdmRede/EstrategiaPortifTec/SISLAB1/index.asp">-->
<area alt="" coords="3,3,250,68" href="index.asp">
<area alt="" coords="637,4,756,65" href="http://pegasus/">
</map>
<img src="img/barra_crt2.jpg" border=0 usemap="#teste">
</form>
</left><%
End Sub

'-- aparentemente nao ta sendo utilizada !!
Sub MostraHeader2()
%>
<script language="JavaScript1.2">
function Atualiza()
{
//	document.cabecalho.action=document.cabecalho.menu[document.cabecalho.menu.selectedIndex].value
	document.cabecalho.action="index.asp"
	document.cabecalho.submit();
}
</script>

<left>
<form name="cabecalho" method="post">
<!--table cellpadding="0" cellspacing="0" border="0" height="69">
<tr>
	<td background="../img/barcantoesq.gif" width="23" height="69">
	</td>
	<td background="../img/barmeio.gif" width="195" height="69" valign="top" align="left">
		<a href="../index.asp"><img src="../img/logobarra3.gif" valign="top" border="0" /></a>
	</td>
	<td background="../img/barmeio.gif" width=330  height="69" valign="top" align="center">
		<a href="../index.asp"><img src="../img/barratitulo1.gif" valign="top" border="0" /></a>
	</td>
	<td background="../img/barmeio.gif" width=150  height="69" valign="top" align="right">
		<a href="http://pegasus/"><img src="../img/ebtbar.gif" valign="top" border="0" /></a>
	</td>
	<td background="../img/barcantodir.gif" width=70  height="69">

	</td>
</tr>
</table-->

<map name="teste">
<!-- aponta para producao. Deveria apontar para o caminho relativo --
		<area alt="" coords="3,3,250,68" href="http://ntspo901/PORTALVPR/ProjetosEAdmRede/EstrategiaPortifTec/SISLAB1/index.asp"> -->
<area alt="" coords="3,3,250,68" href="index.asp">
<area alt="" coords="637,4,756,65" href="http://pegasus/">
</map>
<img src="../img/barra_crt2.jpg" border=0 usemap="#teste">
</form>
</left><%
End Sub

'-- aparentemente nao ta sendo utilizada !!
Sub MostraHeader1_1()
%>
<HTML>
<HEAD>
<meta http-equiv="pragma" content="no-cache">
<STYLE TYPE="text/css">
<!--
	A:link {color:#000060;}
	A:visited {color:#333360;}
	A:hover {color:#0000FF;}
	A:active {color:black;}
	A {text-decoration:none}
-->
</STYLE>
<TITLE>Site da Controladoria</TITLE>
<%
End Sub

Sub MostraFooter()%>
	</BODY>
	</HTML><%
End Sub

'== Comeco do Processamento ============================================================
' Este é o processo de controle de conexao p/ todas as paginas!
Sub Conecta(bAbrirConexao)
	'Se uma conexão for solicitada, Conecta(true) então...
	If bAbrirConexao Then
		Set conSite = Server.CreateObject("ADODB.Connection")
		conSite.CommandTimeout = 30
		conSite.ConnectionTimeout = 20
 		conSite.Open DB_CONNECTIONSTRING & DB_USERNAME & DB_PASSWORD

	'Se for solicitada uma desconexão, Conecta(false) então...
	  else
		conSite.Close
		Set conSite = Nothing
	If Response.Buffer Then 
		Response.Flush
	End If
     End If
End Sub


'== INICIO Base de Dados (RecordSet) =============================================================
Function ObterRecordset(sSQL)
	Dim objRSObterRecordset

	Set objRSObterRecordset = Server.CreateObject("ADODB.RecordSet")
	objRSObterRecordset.Open sSQL, conSite, adOpenStatic, adLockReadOnly
	'--	objRSObterRecordset.Open sSQL, conSite, adOpenStatic, adLockReadOnly

	Set ObterRecordset = objRSObterRecordset

	'objRSGetRecordset.Close
	Set objRSObterRecordset = Nothing
End Function

'== Comeco de rotinas ============================================================

Function chkcombo(RSAtual,RSCombo)
	if (RSAtual=RSCombo) then
		chkcombo=" SELECTED " 
	else
		chkcombo=""
	end if
End Function

Function chkOpt(RSAtual,RSOpt)
	if (RSAtual=RSOpt) then
		chkOpt=" CHECKED " 
	else
		chkOpt=""
	end if
End Function

Sub validaInteiro(Varteste)
	If Not(IsNumeric(Varteste)) Then
		validaInteiro=False	
	End If
End sub

Sub validaData(Varteste)

End sub

sub validaVazio(Varteste)
	If Varteste="" Then
		validaVazio=False
	End If
End sub

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

	strHour = Hour(dDataaformatar) Mod 24

	strMinute = Minute(dDataaformatar)
	If Len(strMinute) = 1 Then strMinute = "0" & strMinute
	
	strSecond = Second(dDataaformatar)
	If Len(strSecond) = 1 Then strSecond = "0" & strSecond

	' "d/m/yyyy h:mm:ss AM" for all those who have had problems.
	FormataDataHoraDisplay = strDay & "/" & strMonth & "/" & strYear & " " & strHour & ":" & strMinute & ":" & strSecond 


	If (FormataDataHoraDisplay="// ::") then FormataDataHoraDisplay=""

End Function
'== Fim das Rotinas ==============================================================
%>