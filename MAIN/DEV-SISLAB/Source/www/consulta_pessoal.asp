<!--#include file="includes/Sislab_Lib.asp"-->
<!--#include file="includes/PadraoHTML.asp" -->
<!--#include file="includes/global.asp" -->
<!--#include file="includes/bib_str.asp" -->
<%
session.lcid = 1046 'Brasil

' recuperando o periodo da consulta e o username
Dim PathRelativo : PathRelativo = ""
Dim tp_datainicial, tp_datafinal, username
tp_datainicial = request("tp_datainicial")
tp_datafinal = request("tp_datafinal")
username = request("username")
exibeTodos = request("exibeTodos")
if exibeTodos <> "1" then exibeTodos = "0"
if username = "" or username = null then username="-1"

call ImprimeCabecalho2(TITULO_SITE, MENU_ON, true, "", "Consulta de Pessoal Alocado por Período", "location.href='sislab.asp'", "")
%>

<!-- Funcao isDate (data), onde data = dd/mm/aaaa -->
<script language="JavaScript" src="<%=PathRelativo%>includes/manipulaObj.js"></script>
<style>
.celula
{        
	BORDER-TOP: black thin inset; 
}
</style> 
<script>
//retorna =0 datas iguais; >0 data2 > data1; <0 data2 < data1
function comparaData(data1, data2) //formato dd/mm/aaaa
{
	ii = new Date(Date.UTC(data1.substring(6,10), data1.substring(3,5), data1.substring(0,2), 0, 0)) 
	ff = new Date(Date.UTC(data2.substring(6,10), data2.substring(3,5), data2.substring(0,2), 0, 0)) 
	return (ff-ii);  
}

function validaForm()
{
  var frm = document.frmPessoal;
	if (parseFloat(frm.diaInicio.value) < 10)
		frm.tp_datainicial.value = "0"+parseFloat(frm.diaInicio.value)+"/"+frm.mesInicio.value+"/"+frm.anoInicio.value;
	else	frm.tp_datainicial.value = frm.diaInicio.value+"/"+frm.mesInicio.value+"/"+frm.anoInicio.value;
	if (parseFloat(frm.diaFim.value) < 10)
		frm.tp_datafinal.value = "0"+parseFloat(frm.diaFim.value)+"/"+frm.mesFim.value+"/"+frm.anoFim.value;
	else	frm.tp_datafinal.value = frm.diaFim.value+"/"+frm.mesFim.value+"/"+frm.anoFim.value;
	if (!isDate(frm.tp_datainicial.value))
	{
		alert("Data Inicial Inválida!");
		frm.diaInicio.focus();
		return;
	}
	if (!isDate(frm.tp_datafinal.value))
	{
		alert("Data Final Inválida!");
		frm.diaFim.focus();
		return;
	}
	if (comparaData(frm.tp_datainicial.value, frm.tp_datafinal.value) < 0)
	{
		alert("Data Inicial superior à data de Término!");
		frm.diaFim.focus();
		return;
	}
	return true;
}
function submeter()
{
	if (validaForm())
		document.frmPessoal.submit();	
}
</script>

<form name="frmPessoal" action="consulta_pessoalA.asp" method="post">
<input type="hidden" name="tp_datainicial" value="">
<input type="hidden" name="tp_datafinal" value="">
<table class="texto1" width="100%" border="0" cellpadding="2" cellspacing="0">
<tr>
  <td>
		<font class="fonte2">Início:</font>
		<INPUT TYPE="text" NAME="diaInicio" size="3" MAXLENGTH="2" class="combo"> /
		<font class="fonte2">
		<SELECT NAME="mesInicio" class="combo">
	    <OPTION VALUE="-1"> -Mês-
	    <OPTION VALUE="01"> Jan
	    <OPTION VALUE="02"> Fev
	    <OPTION VALUE="03"> Mar
	    <OPTION VALUE="04"> Abr
	    <OPTION VALUE="05"> Mai
	    <OPTION VALUE="06"> Jun
	    <OPTION VALUE="07"> Jul
	    <OPTION VALUE="08"> Ago
	    <OPTION VALUE="09"> Set
	    <OPTION VALUE="10"> Out
	    <OPTION VALUE="11"> Nov
	    <OPTION VALUE="12"> Dez
	  </SELECT> /
	  <INPUT TYPE="text" size="4" NAME="anoInicio" MAXLENGTH="4" class="combo">
	</td>
  <td>
		<font class="fonte2">Término:</font>
	  <INPUT TYPE="text" NAME="diaFim" MAXLENGTH="2" size="3" class="combo"> /
		<font class="fonte2">
	  <SELECT NAME="mesFim" class="combo">
	    <OPTION VALUE="-1"> -Mês-
	    <OPTION VALUE="01"> Jan
	    <OPTION VALUE="02"> Fev
	    <OPTION VALUE="03"> Mar
	    <OPTION VALUE="04"> Abr
	    <OPTION VALUE="05"> Mai
	    <OPTION VALUE="06"> Jun
	    <OPTION VALUE="07"> Jul
	    <OPTION VALUE="08"> Ago
	    <OPTION VALUE="09"> Set
	    <OPTION VALUE="10"> Out
	    <OPTION VALUE="11"> Nov
	    <OPTION VALUE="12"> Dez
	  </SELECT>
	  </font> /
	  <INPUT TYPE="text" NAME="anoFim" size="4" MAXLENGTH="4" class="combo">
	</td>
	<td>
	  <INPUT TYPE="button" VALUE=" Ok " onclick="submeter()">
	</td>
</tr>
<tr>
  <td colspan="3">
		<font class="fonte2">Nome:</font>
    <font  class="fonte2">
    <SELECT NAME="username" size="1" class="combo">
	  <OPTION VALUE="-1">- Todos -</OPTION>
<%	Dim objRS
		Call Env.RecordSet(True, objRS, "select USERID, NOME from userCRT order by userid")
		If not(objRS.EOF AND objRS.BOF) Then
			While( NOT( objRS.EOF ) )%>
				<option value="<%=objRS("USERID")%>"><%=ucase(objRS("USERID"))%> - <%=objRS("NOME")%>
<%			objRS.MoveNext
			Wend
		End If
		Call Env.RecordSet(False, objRS, Null)
%>
    </SELECT>
		</font>
	</td>
</tr>
<tr>
	<td colspan="3">
		<input type="Checkbox" name="exibeTodos" value="1" class="texto">
		<font class="fonte2">Exibir Todos os Agendamentos</font>
	</td>
</tr>
</table>
</form>

<script>
var frm = document.frmPessoal;
<%if tp_datainicial = "" then%>
frm.tp_datainicial.value = "<%=FormataData(Date(), "")%>";
<%else%>
frm.tp_datainicial.value = "<%=FormataData(tp_datainicial, "")%>";
<%end if%>
frm.diaInicio.value = frm.tp_datainicial.value.substring(0,2);
frm.mesInicio.value = frm.tp_datainicial.value.substring(3,5);
frm.anoInicio.value = frm.tp_datainicial.value.substring(6,10);
if (frm.mesInicio.value == "") frm.mesInicio.value = "-1"
<%if tp_datainicial = "" then%>
frm.tp_datafinal.value = "<%=FormataData(date()+30, "")%>";
<%else%>
frm.tp_datafinal.value = "<%=FormataData(tp_datafinal, "")%>";
<%end if%>
frm.diaFim.value = frm.tp_datafinal.value.substring(0,2);
frm.mesFim.value = frm.tp_datafinal.value.substring(3,5);
frm.anoFim.value = frm.tp_datafinal.value.substring(6,10);
if (frm.mesFim.value == "") frm.mesFim.value = "-1"
frm.exibeTodos.checked = <%if exibeTodos then response.write "true" else response.write "false"%>;
frm.username.value = "<%=username%>";
</script>
<%
Call imprimeRodape2(RODAPE_OFF, "")
%>
