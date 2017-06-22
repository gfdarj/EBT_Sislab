<!--#include file="includes/Sislab_Lib.asp" -->
<!--#include file="includes/PadraoHTML.asp" -->
<!--#include file="includes/global.asp" -->
<!--#include file="includes/emailHTML.asp" -->
<!--#include file="includes/funcoes.asp" -->
<%
Dim objRS, sSQL, username

username = Env.Usuario
%>
<html>
<head>
	<title>SISLAB</title>
	<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
	<link rel="stylesheet" href="estilos/principal.css" type="text/css">
</head>
<script language="JavaScript">
function chama_oc(cod_oc)
{
  seloc.ocorrencia.value=cod_oc;
	seloc.submit();
}

</script>
<form name="seloc" target="_parent" action="CAD_evLogBook.asp" method="post">
	<input type="Hidden" name="ocorrencia" value="">
</form>
<body bgcolor="#FFFFFF" text="#000000" leftmargin="0" topmargin="0">
<table width="100%" border="0" cellspacing="0" cellpadding="0">
<tr> 
	<td width="2px">&nbsp;</td>
	<td width="*" height="25" class="fonteTitulo1"><span class="Vermelho2">&raquo;</span>&nbsp; Informações de Log Book</td>
</tr>
<tr>
	<td height="1"></td>
	<td height="1" bgcolor="#003366"></td>
</tr>
<tr>
	<td width="2px">&nbsp;</td>
	<td class="texto" valign="top">

<table width="147px" border="0" cellspacing="0" cellpadding="0">

<%
IF Env.EhRat() then%>
<%
sSQL = "select distinct LB_ID "
sSQL = sSQL & "from LB_LOGBOOK "
sSQL = sSQL & "where "
sSQL = sSQL & "(LB_CONCLUIDOGQ = 0) AND LB_RATRESPONSAVEL IS NULL"
'response.write ssql
'response.end
Call Env.RecordSet(true, objRS, sSQL)
If Not (objRS.EOF and objRS.BOF) Then
	objRS.Movefirst%>
<tr><td class="texto"> Novas Ocorrências...</td></tr>
<tr>
<td class="texto" align="justify">
      OC's:
<%while not objRS.EOF%>
			<a href="javascript:chama_oc(<%=objRS("LB_ID")%>);" class="link_ocs"><%=objRS("LB_ID")%></a>
<%	objRS.MoveNext
		if not objRS.EOF then response.write ",&nbsp;"
	wend
End If%>
		</td>
 </tr>

<%
sSQL = "select distinct LB_ID "
sSQL = sSQL & "from LB_LOGBOOK "
sSQL = sSQL & "where "
sSQL = sSQL & "(LB_CONCLUIDOGQ = 0) AND LB_RATRESPONSAVEL='" & username & "'"
'response.write ssql
'response.end
Call Env.RecordSet(true, objRS, sSQL)
If Not (objRS.EOF and objRS.BOF) Then
	objRS.Movefirst%>
<tr>
<td class="texto"><br> Em Análise... <br>
      OC's:
<%while not objRS.EOF%>
			<a href="javascript:chama_oc(<%=objRS("LB_ID")%>);" class="link_ocs"><%=objRS("LB_ID")%></a>
<%	objRS.MoveNext
		if not objRS.EOF then response.write ",&nbsp;"
	wend
End If%>
		</td>
  </tr>

<%
end if
%>
   <tr> 
    	<td valign="top" class="texto" height="10"></td>
	 </tr>
		<%
		sSQL = "Select Distinct LB_ID "
		sSQL = sSQL & "from LB_LOGBOOK "
		sSQL = sSQL & "Where "
		sSQL = sSQL & "(LB_ConcluidoGQ = 0) AND "
		sSQL = sSQL & "(LB_RespExec = '" & username & "') "
		Call Env.RecordSet(true, objRS, sSQL)
		If Not (objRS.EOF and objRS.BOF) Then
			objRS.Movefirst%>
			 <tr> 
    		<td class="texto"> Sob sua responsabilidade... <br>
		    OC's:
			<%while not objRS.EOF%>
		      <a href="javascript:chama_oc(<%=objRS("LB_ID")%>);" class="link_ocs"><%=objRS("LB_ID")%></a>
				<%	objRS.MoveNext
				if not objRS.EOF then response.write ",&nbsp;"
			wend
		End If
Call Env.RecordSet(false, objRS, null)
%>
		</td>
  </tr>
   <tr> 
    	<td valign="top" class="texto" height="10"></td>
	 </tr>
		<%

		sSQL = "Select Distinct LB_ID "
		sSQL = sSQL & "from LB_LOGBOOK "
		sSQL = sSQL & "Where "
		sSQL = sSQL & "(LB_ConcluidoGQ = 0) AND "
		sSQL = sSQL & "(LB_UsernameCad = '" & username & "') "
		Call Env.RecordSet(true, objRS, sSQL)
		If Not (objRS.EOF and objRS.BOF) Then
			objRS.Movefirst%>
			<tr> 
    		<td class="texto">Suas Ocorrências Cadastradas... <br>
		    OC's:
			<%while not objRS.EOF%>
		      <a href="javascript:chama_oc(<%=objRS("LB_ID")%>);" class="link_ocs"><%=objRS("LB_ID")%></a>
				<%	objRS.MoveNext
				if not objRS.EOF then response.write ",&nbsp;"
			wend
		End If
Call Env.RecordSet(false, objRS, null)
%>
		</td>
  </tr>
	<tr> 
    <td valign="top" class="texto" height="10"></td>
  </tr>
</table>

	</td>
</tr>
</table>
</body>
</html>
