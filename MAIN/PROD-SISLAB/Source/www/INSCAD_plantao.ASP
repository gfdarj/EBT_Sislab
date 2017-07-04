<!--#include file="includes/Sislab_Lib.asp"-->
<%
' Se Sessão expirou enviar para novo logon

If IsEmpty(Env.usuario) Then
	response.redirect "msgAcessoNA.asp"
End if

Dim objSiteRS, sSQL
Dim auxtitulo,auxdatainiexibicao,auxdatafimexibicao
Dim auxlink,auxnoticia,auxusername,auxcodnoticia
Dim auxidorgao,auxtipocomando,auxdataatual

auxtitulo=request.form("titulo")  
auxdatainiexibicao=request.form("diainiexibicao")&"/"&request.form("mesiniexibicao")&"/"&request.form("anoiniexibicao")
auxdatafimexibicao=request.form("diafimexibicao")&"/"&request.form("mesfimexibicao")&"/"&request.form("anofimexibicao")
'auxnoticia=request.form("link")
auxlink=request.form("link")
'auxIdorgao=request.form("orgao")
auxtipocomando=request.form("tipocomando")
auxusername = Env.Usuario
auxdataatual=FormataDataHoraDB(Date & " " & time)
auxcodnoticia=request.form("codNoticia")

'---
'--- completamente sem finalidade isto aqui !!
'---
'If nOT (auxtipocomando="Alterar \ Excluir" OR auxtipocomando="Excluir") Then
'	sSQL = "Select * from Plantao where PLA_titNoticia='" & auxtitulo & "'; "
'	Set objSiteRS = ObterRecordset(sSQL)
'	If Not(objSiteRS.EOF)  Then 
'   		Response.Redirect "errocomando.asp"
'	End if
'End if

If auxtipocomando="Alterar \ Excluir" Then
	sSQL = "Update Plantao "
	sSQL = sSQL & "Set PLA_titNoticia='" & auxtitulo & "', "
	sSQL = sSQL & "PLA_datainicio=Convert(smalldatetime, '" & auxdatainiexibicao & "',103), "
	sSQL = sSQL & "PLA_datatermino=Convert(smalldatetime,'" & auxdatafimexibicao & "',103), "
	sSQL = sSQL & "PLA_datacadastro=getDate(), "
	sSQL = sSQL & "PLA_UserId='" & auxUsername & "', "
	sSQL = sSQL & "PLA_link='" & auxlink & "' "
	sSQL = sSQL & "Where PLA_CodNoticia=" & auxcodNoticia & "; "
elseIf auxtipocomando="Excluir" Then
	sSQL = "Delete Plantao "
	sSQL = sSQL & "Where PLA_CodNoticia=" & auxcodNoticia & "; "
else
	sSQL = "Insert Into Plantao "
	sSQL = sSQL & "(PLA_titNoticia,PLA_datainicio, "
	sSQL = sSQL & "PLA_datatermino,PLA_datacadastro,PLA_link,PLA_UserId) "	
	sSQL = sSQL & "values ('" & auxtitulo & "', "
	sSQL = sSQL & "Convert(smalldatetime, '" & auxdatainiexibicao & "',103),Convert(smalldatetime,'" & auxdatafimexibicao & "',103),getDate(), "
	sSQL = sSQL & "'" & auxlink & "','" & auxUsername & "');"	
end if

On Error Resume Next
Call Env.oConn.Execute(sSQL)
On Error Goto 0
%>
<html>
<head>
<title>CRT - Cadastro de Notícias</title>
<meta http-equiv="refresh" content="4; url=sel_cad_plantao.asp">
</head>
<body bgcolor="#FFFFFF">

<div align="center">
  <table width="90%" bgcolor="#88BBBB">
    <tr> 
      <td width="10%" height="0"></td>
      <td width="10%" height="0"></td>
      <td width="10%" height="0"></td>
      <td width="10%" height="0"></td>
      <td width="10%" height="0"></td>
      <td width="10%" height="0"></td>
      <td width="10%" height="0"></td>
      <td width="10%" height="0"></td>
      <td width="10%" height="0"></td>
      <td width="10%" height="0"></td>
    </tr>
    <tr valign="middle" bgcolor="#88BBBB" border="1"> 
      <td colspan="10" align="center">&nbsp;&nbsp;&nbsp;<b>Comando SQL</b></td>
    </tr>
    <tr valign="middle" bgcolor="#AADDDD"> 
      <td colspan="10">&nbsp;&nbsp;&nbsp;Comando SQL Digitado</td>
    </tr>
    <tr valign="middle"> 
      <td colspan="10" bgcolor="#FFFFFF"  height="180"> 
        <div align="center">&nbsp; 
<%=sSQL%>
        </div>
      </td>
    </tr>
  </table>

<% If Err Then %>
<center>
<table border="0" bgcolor="#FFFFFF" width="80%">
<tr>
<td>
<div align="left">
  <font style="font-size=10pt;" color="#000000"> 
<b>&nbsp;&nbsp;Erro Nº:</b> <%=Err.Number%><br>
<b>&nbsp;&nbsp;Descrição:</b> <%=Err.Description%><br>
  </font>
<% else %>
  <font style="font-size=10pt;" color="#600000">
   <b>Comando Executado com Sucesso</b> <br>
  </font>
<% end if %>
</div>
</td>
</tr>
</table>
</center>
<%
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
%>
</html>
