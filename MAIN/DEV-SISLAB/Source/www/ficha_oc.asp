<!-- #INCLUDE FILE="includes/inicializacao.inc" -->
<%
'	On Error Resume Next
'Chama função em config.inc que faz a conexão com o Banco de dados

Conecta True

' Declaro variaveis 

Dim objSiteRS, objDisp, objRes, objGQ, i, cont, sSQL, tot, auxtipoOcorrencia,Auxselecao, ebt1
Dim AuxRamal,AuxOrgao,AuxDataHoraOco,AuxIP,AuxUsername
Dim AuxMatricula, AUxResponsavel,Matricula,rst,AuxDataCadastro
Dim auxexecutor,auxrespexecucao,auxprazo, auxobservacaoGQ, auxrequisitoNorma
Dim auxSituacao, auxanaliseGQ, auxpendencias, auxobservacaoRes
Dim auxDescricao,auxobservacao,auxprovidencias, auxdocassociado

Auxselecao=Request.form("selecao")
%>
<!DOCTYPE html>

<html>

<head>
    <title>Site do Centro de Referência Tecnológica</title>
    <meta http-equiv="Pragma" content="no-cache">
    <meta charset="<%=Application("SISLAB_CHARSET")%>" />
    <link rel="stylesheet" href="estilos/style.css">
</head>

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

sSQL = "Select * From vw_conslogbook "
sSQL = sSQL & " WHERE LB_ID="&AuxSelecao&"; "

	Set objSiteRS = ObterRecordset(sSQL)

objSiteRS.MoveFirst

Auxusername=objSiteRS("LB_usernameCad")
AuxDataHoraOco=FormataDataHoraDisplay(objSiteRS("LB_DataHoraOco"))
AuxDataCadastro=FormataDataDisplay(objSiteRS("LB_DataHoraCad"))
Auxobservacao=Replace(objSiteRS("LB_Observacao"),vbcrlf,"<BR>")
AuxDescricao=Replace(objSiteRS("LB_DESCRICAO"),vbcrlf,"<BR>")
AuxTipoOcorrencia=objSiteRS("LBTO_Descricao")
Auxexecutor=objSiteRS("LB_executor")
AuxRespexecucao=objSiteRS("LB_respExec")
Auxprazo=objSiteRS("LB_prazo")
auxobservacaoGQ=objSiteRS("LB_observacoesGQ")
auxobservacaoRes=objSiteRS("LB_observacoesRes")
auxpendencias=objSiteRS("LB_pendencias")
auxanaliseGQ=objSiteRS("LB_analiseGQ")
auxdocassociado=objSiteRS("LB_DOCASSOCIADO")
auxrequisitoNorma=objSiteRS("LB_RequisitoNorma")

if objSiteRS("LB_ConcluidoGQ") then
	AuxSituacao="Concluído"
  else
	AuxSituacao="Pendente"
end if

AuxIP=objSiteRS("LB_IPCad")
Auxprovidencias=Replace(objSiteRS("LB_providencias"),vbcrlf,"<BR>")

Set ebt1 = New TEbt

Call ebt1.LoginUsuario(AuxUsername)

AuxMatricula = ebt1.Matricula()
AuxResponsavel = ebt1.NomeReduzido
AuxOrgao = ebt1.SiglaOrgao
AuxRamal =  ebt1.Ramal

Set ebt1  = nothing
%>

<CENTER>
<font style="font-size: 5pt"><br></font>

<table border="0" width="720" cellpadding="2">
  <tr>
<td  bgcolor="#000030">
<font face="arial" class="Fonttit1Cad"  color="#FFFFFF"><B>
<center>
Dados da Ocorrência - N<sup>o</sup> OC: <%=auxselecao%> </B></Font>
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
<td  bgcolor="#666666" align="center" colspan="5">
<font face="verdana" class="FontMenu1" color="#FFFFFF" >
<B>
TIPO DE OCORRÊNCIA
</B>
</font>
</td>


<td  bgcolor="#666666" align="center" colspan="1">
<font face="verdana" class="FontMenu1" color="#FFFFFF" >
<B>
PRAZO<br>(em dias)
</B>
</font>
</td>

<td  bgcolor="#666666" align="center" colspan="2">
<font face="verdana" class="FontMenu1" color="#FFFFFF">
<B>
DATA DA OCORRÊNCIA
</B>
</font>
</td>

<td  bgcolor="#666666" align="center" colspan="2">
<font face="verdana" class="FontMenu1" color="#FFFFFF">
<B>
SITUAÇÃO
</B>
</font>
</td>

</tr>

<tr>
<td  bgcolor="#FFFFFF" align="left" colspan="5">
<font face="verdana" class="FontMenu1" color="#000000">
&nbsp;<%=auxtipoocorrencia%>&nbsp;&nbsp;
<br></font>
</a>
</td>
<td bgcolor="#FFFFFF" align="center" colspan="1">
<font face="verdana" class="FontMenu1" color="#000000">&nbsp;<%=Auxprazo%><br></font>
</td>
<td bgcolor="#FFFFFF" align="center" colspan="2">
<font face="verdana" class="FontMenu1" color="#000000">&nbsp;<%=AuxDataHoraOco%><br></font>
</td>
<td bgcolor="#FFFFFF" align="center" colspan="2">
<font face="verdana" class="FontMenu1" color="#000000">&nbsp;<%=AuxSituacao%><br></font>
</td>
</tr>


<tr>
<td  bgcolor="#666666" align="left" colspan="2">
<font face="verdana" class="FontMenu1" color="#FFFFFF" >
<B>
&nbsp;&nbsp;RESPONSÁVEL
</B>
</font>
</td>

<td  bgcolor="#666666" align="left" colspan="3">
<font face="verdana" class="FontMenu1" color="#FFFFFF" >
<B>
&nbsp;&nbsp;DOC. ASSOCIADO
</B>
</font>
</td>

<td  bgcolor="#666666" align="center" colspan="5">
<font face="verdana" class="FontMenu1" color="#FFFFFF">
<B>
EXECUTOR</B>
</font>
</td>
</tr>

<tr>
<td  bgcolor="#FFFFFF" align="left" colspan="2">
<font face="verdana" class="FontMenu1" color="#000000">
&nbsp;<%=auxrespexecucao%>&nbsp;
<br></font>
</a>
</td>
<td  bgcolor="#FFFFFF" align="left" colspan="3">
<font face="verdana" class="FontMenu1" color="#000000">
&nbsp;<%=auxdocassociado%>&nbsp;
<br></font>
</a>
</td>
<td bgcolor="#FFFFFF" align="center" colspan="5">
<font face="verdana" class="FontMenu1" color="#000000">&nbsp;<%=Auxexecutor%><br></font>
</td>
</tr>

<tr>
<td  bgcolor="#666666" align="left" colspan="10">
<font face="verdana" class="FontMenu1" color="#FFFFFF" >
<B>
&nbsp;&nbsp;OCORRÊNCIA
</B>
</font>
</td>

<!--td  bgcolor="#666666" align="center" colspan="3">
<font face="verdana" class="FontMenu1" color="#FFFFFF">
<B>
DATA DA ÚLTIMA ATUALIZAÇÃO</B>
</font>
</td-->
</tr>

<tr>
<td  bgcolor="#FFFFFF" align="left" colspan="10">
<font face="verdana" class="FontMenu1" color="#000000">
&nbsp;<%=auxdescricao%>&nbsp;
<br></font>
</a>
</td>
<!--td bgcolor="#FFFFFF" align="center" colspan="3">
<font face="verdana" class="FontMenu1" color="#000000">&nbsp;<%=AuxDataCadastro%><br></font>
</td-->
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

<tr>
<td  bgcolor="#666666" align="left" colspan="5">
<font face="verdana" class="FontMenu1" color="#FFFFFF">
<B>
&nbsp;&nbsp;PROVIDÊNCIAS
</B>
</font>
</td>

<td  bgcolor="#666666" align="left" colspan="5">
<font face="verdana" class="FontMenu1" color="#FFFFFF">
<B>
&nbsp;&nbsp;OBSERVAÇÕES DA OCORRÊNCIA
</B>
</font>
</td>
</tr>

<tr>
<td  bgcolor="#FFFFFF" align="left" colspan="5">
<font face="verdana" class="FontMenu1" color="#000000">
<%=auxprovidencias%>&nbsp;
<br></font>
</td>
<td  bgcolor="#FFFFFF" align="left" colspan="5">
<font face="verdana" class="FontMenu1" color="#000000">
<%=auxobservacao%>&nbsp;
<br></font>
</td>
</tr>

<tr>
<td  bgcolor="#666666" align="left" colspan="10">
<font face="verdana" class="FontMenu1" color="#FFFFFF">
<B>
&nbsp;&nbsp;REQUISITO DA NORMA ASSOCIADO
</B>
</font>
</td>
</tr>

<tr>
<td  bgcolor="#FFFFFF" align="left" colspan="10">
<font face="verdana" class="FontMenu1" color="#000000">
<%=auxrequisitoNorma%>&nbsp;
<br></font>
</td>
</tr>

<tr>
<td  bgcolor="#666666" align="left" colspan="5">
<font face="verdana" class="FontMenu1" color="#FFFFFF">
<B>
&nbsp;&nbsp;OBSERVAÇOES GQ
</B>
</font>
</td>

<td  bgcolor="#666666" align="left" colspan="5">
<font face="verdana" class="FontMenu1" color="#FFFFFF">
<B>
&nbsp;&nbsp;OBSERVAÇÕES DO RESPONSÁVEL
</B>
</font>
</td>
</tr>

<tr>
<td  bgcolor="#FFFFFF" align="left" colspan="5">
<font face="verdana" class="FontMenu1" color="#000000">
<%=auxobservacaoGQ%>&nbsp;
<br></font>
</td>
<td  bgcolor="#FFFFFF" align="left" colspan="5">
<font face="verdana" class="FontMenu1" color="#000000">
<%=auxobservacaoRES%>&nbsp;
<br></font>
</td>
</tr>

<tr>
<td  bgcolor="#666666" align="left" colspan="5">
<font face="verdana" class="FontMenu1" color="#FFFFFF">
<B>
&nbsp;&nbsp;ANÁLISE GQ
</B>
</font>
</td>

<td  bgcolor="#666666" align="left" colspan="5">
<font face="verdana" class="FontMenu1" color="#FFFFFF">
<B>
&nbsp;&nbsp;PENDÊNCIAS
</B>
</font>
</td>
</tr>

<tr>
<td  bgcolor="#FFFFFF" align="left" colspan="5">
<font face="verdana" class="FontMenu1" color="#000000">
<%=auxanaliseGQ%>&nbsp;
<br></font>
</td>
<td  bgcolor="#FFFFFF" align="left" colspan="5">
<font face="verdana" class="FontMenu1" color="#000000">
<%=auxpendencias%>&nbsp;
<br></font>
</td>
</tr>


<tr>
<td  bgcolor="#666666" align="center" colspan="4">
<font face="verdana" class="FontMenu1" color="#FFFFFF" >
<B>
DISPOSICAO
</B>
</font>
</td>


<td  bgcolor="#666666" align="center" colspan="1">
<font face="verdana" class="FontMenu1" color="#FFFFFF" >
<B>
PRAZO<br>
</B>
</font>
</td>

<td  bgcolor="#666666" align="center" colspan="2">
<font face="verdana" class="FontMenu1" color="#FFFFFF">
<B>
DATA DA CONCLUSÃO
</B>
</font>
</td>

<td  bgcolor="#666666" align="center" colspan="2">
<font face="verdana" class="FontMenu1" color="#FFFFFF">
<B>
EXECUTANTE
</B>
</font>
</td>


<td  bgcolor="#666666" align="center" colspan="1">
<font face="verdana" class="FontMenu1" color="#FFFFFF">
<B>
EFICÁCIA
</B>
</font>
</td>

</tr>
<%
sSQL = "Select * From disposicaoLB "
sSQL = sSQL & " WHERE LB_ID="&AuxSelecao&"; "

	Set objDisp = ObterRecordset(sSQL)

If not objDisp.EOF then objDisp.MoveFirst

While not objDisp.EOF
	
%>
<tr>
<td  bgcolor="#FFFFFF" align="left" colspan="4">
<font face="verdana" class="FontMenu1" color="#000000">
&nbsp;<%=objDisp("D_DISPOSICAO")%>&nbsp;&nbsp;
<br></font>
</a>
</td>
<td bgcolor="#FFFFFF" align="center" colspan="1">
<font face="verdana" class="FontMenu1" color="#000000">&nbsp;<%=objDisp("D_Prazo")%><br></font>
</td>
<td bgcolor="#FFFFFF" align="center" colspan="2">
<font face="verdana" class="FontMenu1" color="#000000">&nbsp;<%=objDisp("D_DataConclusao")%><br></font>
</td>
<td bgcolor="#FFFFFF" align="center" colspan="2">
<font face="verdana" class="FontMenu1" color="#000000">&nbsp;<%=objDisp("D_Executante")%><br></font>
</td>
<td bgcolor="#FFFFFF" align="center" colspan="1">
<font face="verdana" class="FontMenu1" color="#000000">&nbsp;<%if objDisp("D_Eficacia") = 1 then%>Sim <%elseif objDisp("D_Eficacia") = 0 then%>Não<%End if%><br></font>
</td>
</tr>
<%ObjDisp.MoveNext
  WEnd%>

<tr>
<td  bgcolor="#666666" align="center" colspan="7">
<font face="verdana" class="FontMenu1" color="#FFFFFF" >
<B>
TIPO DE AÇÃO
</B>
</font>
</td>


<td  bgcolor="#666666" align="center" colspan="3">
<font face="verdana" class="FontMenu1" color="#FFFFFF" >
<B>
NÚMERO DO REGISTRO<br>
</B>
</font>
</td>
</tr>
<%
sSQL = "Select * From resolucaoLB "
sSQL = sSQL & " WHERE LB_ID="&AuxSelecao&"; "

	Set objRes = ObterRecordset(sSQL)

If not objRes.EOF then objRes.MoveFirst

While not objRes.EOF
	
%>
<tr>
<td  bgcolor="#FFFFFF" align="left" colspan="7">
<font face="verdana" class="FontMenu1" color="#000000">
&nbsp;<%=objRes("R_NOME")%>&nbsp;&nbsp;
<br></font>
</a>
</td>
<td bgcolor="#FFFFFF" align="center" colspan="3">
<font face="verdana" class="FontMenu1" color="#000000">&nbsp;<%=objRes("R_Numero")%><br></font>
</td>
</tr>
<%ObjRes.MoveNext
  WEnd%>


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