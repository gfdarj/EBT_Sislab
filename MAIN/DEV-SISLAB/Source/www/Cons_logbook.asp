<!-- #INCLUDE FILE="includes/inicializacao.inc" -->
<%
'	On Error Resume Next
'Chama função em config.inc que faz a conexão com o Banco de dados

Conecta True

' Inicializo variavel de conexão 

Dim objSiteRS, cont, sSQL, tot
Dim auxcadastradopor,auxtipooco,auxsituacao,auxdias

if Request.form("doform")=1 then
	auxcadastradopor=request.form("cadastradopor")
	auxtipooco=request.form("tipoocorrencia")
	auxsituacao=request.form("situacao")
	auxdias=request.form("dias")
  else
	auxcadastradopor="Todos"
	auxtipooco="Todos"
	auxsituacao="Todos"
	auxdias=30
end if

%>

<html>
<head>
<title>Site do Centro de Referência Tecnológica</title>
<meta http-equiv="Pragma" content="no-cache">
</head>

<script type="text/javascript">

function ValidaCampos()
{
if (document.formulario.tipoocorrencia.value=="")
	{
	alert("Tipo de ocorrência não informado.\nInforme o Tipo de ocorrência.");
		return false;
		formulario.tipoocorrencia.focus();	
	}
if (document.formulario.situacao.value=="")
	{
	alert("Situação da ocorrência não informada.\nInforme a Situação da ocorrência.");
		return false;
		formulario.situacao.focus();	
	}
if (document.formulario.cadastradopor.value=="")
	{
	alert("Username do Responsável pelo cadastro não informado.\nInforme o Responsável pelo Cadastro (Cadastrado por).");
		return false;
		formulario.cadastradopor.focus();	
	}
if (document.formulario.dias.value=="")
	{
	alert("Período (em dias) para seleção das últimas ocorrências informadas.\nInforme o Período desejado em dias.");
		return false;
		formulario.dias.focus();	
	}
}


function chama_oc(cod_oc)
{
    	sel.selecao.value=cod_oc;
	sel.submit();
}

</script>

<link rel="stylesheet" href="estilos/style.css">
<body bgcolor="#FFFFFF" topmargin=0 leftmargin=0>

<% 

'Chamo a Barra comum a todas as paginas

	Call MostraHeader 

%>


<table width="700" border="0" cellspacing="0" cellpadding="0">
<tr>
<td colspan=4 bgcolor="#FFFFFF">
<table width="700" border="0" cellspacing="0" cellpadding="0">
<tr>
<td bgcolor="#000030" width="300">
<font face="tahoma" style="font-size=10pt" color="#FFFF00">
<img src="img/icutiliz.gif" border=0 align="absmiddle">&nbsp;<B>&nbsp;Utilizando o CRT</B><br>
</font>
</td>
<td bgcolor="#000030" align="center">
<font face="tahoma" style="font-size=9pt" color="#B1D2FF">
<B>Relat&oacute;rio de Ocorrências</B><br>
</font>
</td>
<td bgcolor="#000030" align="right">
<font face="tahoma" style="font-size=10pt" color="#FFFFFF">
&nbsp;<B><a href="javascript: history.go(-1);" class="Menu">Voltar</a></B>&nbsp;&nbsp;&nbsp;<br>
</font>
</td>
</tr>
</table>

</td>
</tr>
<tr>

<td valign="top">
&nbsp;
</td>
</tr>

</table>
<center>

<form name="formulario" method="post" action="cons_logbook.asp" onSubmit="return ValidaCampos(this);">
<input type=hidden name="doform" value=1>
<table width=740>
<tr>
<td width=11%>
</td>
<td width=10%>
</td>
<td width=10%>
</td>
<td width=7%>
</td>
<td width=10%>
</td>
<td width=13%>
</td>
<td width=10%>
</td>
<td width=10%>
</td>
<td width=5%>
</td>
<td width=14%>
</td>
</tr>
<tr>
<td colspan=10 bgcolor="#000050">
<font face="tahoma" class="Fonttit1Cad"  color="#FFFFFF"><B>
<center>
Filtros para Acompanhamento de Ocorrências (Log Book):</B></Font>
</td>
</tr>
<tr>
<td colspan=3 bgcolor="#AACDEF" align=left valign=top>
<font face="tahoma" class="fontmenu1"><B>
&nbsp;Tipo Ocorrência:</B><br>
&nbsp;
<select name="tipoocorrencia"  >
<option value="Todos">Todos os Tipos de Ocorrência</option>

<%
sSQL="Select * from LB_TipoOcorrencia "
sSQL=sSQL&" order by LBTO_Descricao asc;"


 ' trazer os dados de Informacoes dos usuarios
	Set objSiteRS = ObterRecordset(sSQL)
If Not objSiteRS.EOF Then
    objSiteRS.Movefirst

	Do while not(objSiteRS.eof)

%>
<option value=<%=objSiteRS("lbto_ID")%>><%=left(objSiteRS("LBTO_Descricao"),35)%></option>
<%

	objSiteRS.MoveNext
	Loop

	'Fechar Objetos abertos

	objSiteRS.Close
	Set objSiteRS = Nothing

end if
%>
</select>

</Font>
</td>
<td colspan=2 bgcolor="#AACDEF" align=left valign=top>
<font face="tahoma" class="fontmenu1"><B>
&nbsp;Situação:</B><br>
&nbsp;
<select name="situacao"  >
<option value="Todos">Todos as Situações</option>
<option value="P">Pendentes</option>
<option value="C">Concluídas</option>
</select>
</Font>
</td>
<td colspan=2 bgcolor="#AACDEF" align=left valign=top>
<font face="tahoma" class="fontmenu1"><B>
&nbsp;Cadastrado por:</B><br>
&nbsp;
<select name="cadastradopor"  >
<option value="Todos">Todos os Cadastrantes</option>

<%
sSQL="Select * from UserCRT order by USERID asc;"
 ' trazer os dados de Informacoes dos usuarios
	Set objSiteRS = ObterRecordset(sSQL)
If Not objSiteRS.EOF Then
    objSiteRS.Movefirst

	Do while not(objSiteRS.eof)

%>
<option value=<%=objSiteRS("USERID")%>><%=left(objSiteRS("USERID"),35)%></option>
<%

	objSiteRS.MoveNext
	Loop

	'Fechar Objetos abertos

	objSiteRS.Close
	Set objSiteRS = Nothing

end if
%>
</select>

</Font>
</td>
<td colspan=2 bgcolor="#AACDEF" align=left valign=top>
<font face="tahoma" class="fontmenu1"><B>
&nbsp;Ocorrências últimos <br>&nbsp;<input class="cxtexto" name=dias size=2 value=30 maxlength=3> dias</B></Font>
</td>
<td colspan=1 bgcolor="#AACDEF" align=center valign=center>
<input type=submit name="Filtro" class="fontmenu1" Value="Aplicar filtro"></td>
</tr>
</table>

<table width=470>
<tr>
<td>
<font face=tahoma style="font-size=8pt;">

<div align=justify>
<%

'On Error Resume Next


tot=0

   'Crio um RecordSet para Montar Consulta


' Consulta de Todas os arquivos segundo filtros

sSQL = "Select * From vw_conslogbook "

sSQL=sSQL&" Where DATEDIFF(day, LB_DataHoraOco,getDate()-"&auxdias&")<0 "
if auxcadastradopor<>"Todos" then
sSQL=sSQL&" AND LB_UsernameCad='"&auxcadastradopor&"' "
end if
if auxtipooco<>"Todos" then
sSQL=sSQL&" AND LBTO_ID="&auxtipooco&" "
end if
if auxSituacao<>"Todos" then
  if auxsituacao="P" then
    sSQL=sSQL&" AND LB_concluido=0 "
   else
    sSQL=sSQL&" AND LB_concluido=1 "
  end if
end if

sSQL = sSQL & " ORDER BY LB_ID DESC; "

	Set objSiteRS = ObterRecordset(sSQL)


%>

<CENTER>
<font style="font-size: 2pt"><br></font>
<table border="0" width="740" cellpadding="2">
  <tr>
<td  bgcolor="#000030">
<font face="arial" class="Fonttit1Cad"  color="#FFFFFF"><B>
<center>
Ocorrências - Log Book</B></Font>
<br></center>
</td></tr>
</table>

<table width="740">

<tr height="15">
<td  bgcolor="#666666" align="center" width="25%">
<font face="verdana" class="FontMenu1" color="#FFFFFF" >
<B>
N&deg; OC - DATA
</B>
</font>
</td>

<td  bgcolor="#666666" align="center" width="30%">
<font face="verdana" class="FontMenu1" color="#FFFFFF" >
<B>
TIPO DE OCORRÊNCIA
</B>
</font>
</td>

<td  bgcolor="#666666" align="center" width="12%">
<font face="verdana" class="FontMenu1" color="#FFFFFF">
<B>
CADASTRADO POR</B>
</font>
</td>

<td  bgcolor="#666666" align="center" width="8%">
<font face="verdana" color="#FFFFFF" class="FontMenu1">
<B>
PRAZO (Em Dias)
</B>
</font>
</td>

<td  bgcolor="#666666" align="center" width="10%">
<font face="verdana" color="#FFFFFF" class="FontMenu1">
<B>
SITUAÇÃO
</B>
</font>
</td>

<td  bgcolor="#666666" align="center" width="15%">
<font face="verdana" class="FontMenu1" color="#FFFFFF">
<B>
RESPONSÁVEL
</B>
</font>
</td>

</tr>
<%


     If Not(objSiteRS.EOF) Then

	Do while Not(objSiteRS.EOF)
%>
<tr>
<td  bgcolor="#888888" align="left">
<font face="verdana" color="#FFFFFF" class="FontMenu1">
&nbsp;&nbsp;<a href="javascript: chama_oc(<%=objSiteRS("LB_ID")%>)" style="color=#FFFF77;"><B> <%=objSiteRS("LB_ID")%> - <%=FormataDataHoraDisplay(objSiteRS("LB_DataHoraOCo"))%></a>
</B><br>
</font>
</td>
<td  bgcolor="#888888" align="center">
<font face="verdana" color="#FFFFFF" class="FontMenu1"><B>
<%=objSiteRS("LBTO_Descricao")%> - <%=objSiteRS("LB_Descricao")%>
</B><br>
</font>
</td>
<td bgcolor="#888888" align="center">
<font face="verdana" class="FontMenu1" color="#FFFFFF">
<%=objSiteRS("LB_UsernameCad")%><br></font>
</td>
<td bgcolor="#888888" align="center">
<font face="verdana" class="FontMenu1" color="#FFFFFF">
<%=objSiteRS("LB_Prazo")%><br></font>
</td>
<td bgcolor="#888888" align="center">
<font face="verdana" class="FontMenu1" color="#FFFFFF">
<%if objSiteRS("LB_Concluido") then%>
concluído
<%else%>
pendente
<%end if%>
<br></font>
</td>
<td bgcolor="#888888" align="center">
<font face="verdana" class="FontMenu1" color="#FFFFFF">
<%=objSiteRS("LB_RESPEXEC")%><br></font>
</td>
</tr>
<%objSiteRS.movenext%>
<%loop%>
<%else%>
<tr>
<td colspan=5>
<div align="justify">
<font face="verdana" color="#000050" Style="font-size=12pt">
<br>
Não existem ocorrências para estes critérios de consulta.<br>
<br>
</font>
</div>
</td>
</tr>
<% end if %>
</table>
<font style="font-size: 5pt"><br></font>
</form>

<%

	auxcadastradopor="Todos"
	auxtipooco="Todos"
	auxsituacao="Todos"
	auxdias=30

%>

<script type="text/javascript">
formulario.tipoocorrencia.value='<%=auxtipooco%>'
formulario.dias.value=<%=auxdias%>
formulario.situacao.value='<%=auxsituacao%>'
formulario.cadastradopor.value='<%=auxcadastradopor%>'
</script>

<form name="sel" action="ficha_oc.asp" method="post">
<input type="hidden" name="selecao">
</form>

</center>

<%
	'Fechar Objetos abertos
 	Conecta False

%>
<%
	Call MostraFooter
%>