<!-- #INCLUDE FILE="includes/inicializacao.inc" -->
<%
'	On Error Resume Next
'Chama função em config.inc que faz a conexão com o Banco de dados

Conecta True

' Declaro variaveis 

Dim objSiteRS, cont, sSQL, tot, auxtitulo,Auxselecao,obj1
Dim AuxRamal,AuxOrgao,AuxDataHoraMsg,AuxIP,AuxUsername
Dim AuxMatricula, AUxResponsavel,Matricula,rst,AuxDataCadastro
Dim auxDescricao,auxobservacao,auxprovidencias, AuxAgNumero

Auxselecao=Request.form("selecao")
%>

<html>
<head>
<title>Site do Centro de Referência Tecnológica</title>
<meta http-equiv="Pragma" content="no-cache">
</head>
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
<B>Relat&oacute;rio de Mensagens</B><br>
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
<table width=470>
<tr>
<td>
<font face=tahoma style="font-size=12pt;">

<div align=justify>
<%

'On Error Resume Next


tot=0

   'Crio um RecordSet para Montar Consulta


' Consulta agenda segundo filtros

sSQL = "Select * From mensagem M  "
sSQL = sSQL & " WHERE ME_ID="&AuxSelecao&"; "

	Set objSiteRS = ObterRecordset(sSQL)

objSiteRS.MoveFirst

Auxusername=objSiteRS("ME_Remetente")
AuxDataHoraMsg=FormataDataHoraDisplay(objSiteRS("ME_DataHoraMsg"))
AuxDescricao=Replace(objSiteRS("ME_DESCRICAO"),vbcrlf,"<BR>")
AuxTitulo=objSiteRS("ME_Titulo")
AuxIP=objSiteRS("ME_IPCad")
AuxAgNumero=objSiteRS("ME_AGNUMERO")

Set obj1 = Server.CreateObject("WebEmbratel.ClsUsername")
	Matricula = obj1.GetMatricula(AuxUsername)
	
	set obj1=nothing


Set obj1 = Server.CreateObject("WebEmbratel.ClsCadastro")
	Set rst = obj1.GetDados(matricula)

	if rst IS nothing then
		AuxResponsavel = ""
		AuxOrgao = ""
		AuxRamal =  ""
	else
		AuxResponsavel = rst("Nome_Reduzido")
		AuxOrgao = rst("SiglaOrgao")
		AuxRamal =  rst("TEL1_COM") ' caso nulo usuario nao atualizou no CTE
        end if

               Set obj1  = nothing

AuxMatricula=matricula

%>

<CENTER>
<font style="font-size: 5pt"><br></font>

<table border="0" width="720" cellpadding="2">
  <tr>
<td  bgcolor="#000030">
<font face="arial" class="Fonttit1Cad"  color="#FFFFFF"><B>
<center>
Dados da Mensagem - N<sup>o</sup> MSG: <%=auxselecao%> </B></Font>
<br></center>
</td></tr>
</table>




<table width="720" border=1>
<tr>
<td width="10%">
</td>
<td width="10%">
</td>
<td width="10%">
</td>
<td width="10%">
</td>
<td width="10%">
</td>
<td width="10%">
</td>
<td width="10%">
</td>
<td width="10%">
</td>
<td width="10%">
</td>
<td width="10%">
</td>
</tr>



<tr>
<td  bgcolor="#666666" align="center" colspan="6">
<font face="verdana" class="FontMenu1" color="#FFFFFF" >
<B>
TÍTULO DA MENSAGEM
</B>
</font>
</td>

<td  bgcolor="#666666" align="center" colspan="4">
<font face="verdana" class="FontMenu1" color="#FFFFFF">
<B>
DATA DA MENSAGEM
</B>
</font>
</td>

</tr>

<tr>
<td  bgcolor="#FFFFFF" align="left" colspan="6">
<font face="verdana" class="FontMenu1" color="#000000">
&nbsp;<%=auxtitulo%>&nbsp;&nbsp;
<br></font>
</a>
</td>
<td bgcolor="#FFFFFF" align="center" colspan="4">
<font face="verdana" class="FontMenu1" color="#000000">&nbsp;<%=AuxDataHoraMsg%><br></font>
</td>
</tr>

<tr>
<td  bgcolor="#666666" align="left" colspan="10">
<font face="verdana" class="FontMenu1" color="#FFFFFF" >
<B>
&nbsp;&nbsp;NÚMERO DO AGENDAMENTO
</B>
</font>
</td>
</tr>

<tr>
<tr>
<td  bgcolor="#FFFFFF" align="left" colspan="10">
<font face="verdana" class="FontMenu1" color="#000000">
&nbsp;<%=auxagnumero%>&nbsp;&nbsp;
<br></font>
</a>
</td>
</tr>

</tr>
<tr>
<td  bgcolor="#666666" align="left" colspan="10">
<font face="verdana" class="FontMenu1" color="#FFFFFF" >
<B>
&nbsp;&nbsp;MENSAGEM
</B>
</font>
</td>
</tr>

<tr>
<td  bgcolor="#FFFFFF" align="left" colspan="10">
<font face="verdana" class="FontMenu1" color="#000000">
&nbsp;<%=auxdescricao%>&nbsp;
<br></font>
</a>
</tr>

<tr>
<td  bgcolor="#666666" align="left" colspan="6">
<font face="verdana" class="FontMenu1" color="#FFFFFF" >
<B>
&nbsp;&nbsp;RESPONSÁVEL PELO CADASTRO (USERNAME - MATRÍCULA)
</B>
</font>
</td>

<td  bgcolor="#666666" align="center" colspan="2">
<font face="verdana" class="FontMenu1" color="#FFFFFF">
<B>
RAMAL
</B>
</font>
</td>

<td  bgcolor="#666666" align="center" colspan="2">
<font face="verdana" class="FontMenu1" color="#FFFFFF">
<B>
ÓRGÃO
</B>
</font>
</td>

</tr>

<tr>
<td  bgcolor="#FFFFFF" align="left" colspan="6">
<font face="verdana" class="FontMenu1" color="#000000">
&nbsp;<%=AuxResponsavel%>&nbsp;(<%=AuxUsername%>&nbsp;-&nbsp;<%=AuxMatricula%>)
<br></font>
</a>
</td>
<td bgcolor="#FFFFFF" align="center" colspan="2">
<font face="verdana" class="FontMenu1" color="#000000">
&nbsp;<%=AUXRAMAL%><br></font>
</td>
<td bgcolor="#FFFFFF" align="center" colspan="2">
<font face="verdana" class="FontMenu1" color="#000000">
&nbsp;<%=AUXORGAO%><br></font>
</td>
</tr>

</table>

<font style="font-size: 5pt"><br></font>



</div>

</font>
</td>
</tr>
</table>
</center>

<%
	'Fechar Objetos abertos
 	Conecta False

%>
<%
	Call MostraFooter
%>