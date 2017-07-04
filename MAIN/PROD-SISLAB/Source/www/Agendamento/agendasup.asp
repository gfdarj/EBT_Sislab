<!--#include file="includes/cabecalho.inc"-->
<!--#include file="../includes/conexao.inc"-->
<!--#include file="includes/montatela.inc"-->
<%
	SESSION.LCID = 1046 'BRASIL

	Dim cordescricao, cortexto, cordia1, cordia2
	cordescricao="#000080"
	cortexto="#ffffff"
	cordia1="#555580"
	cordia2="#000080"
	
  Dim data, semana, nrodia, i
  if (Request.QueryString("data") <> date()) AND (Request.QueryString("data") <> "") Then
    data = cdate(Request.QueryString("data"))
  else
    data = date()
  end if
  semana = array("","Dom","Seg","Ter","Qua","Qui","Sex","Sáb")
  nrodia = weekday(data)
%>

<HTML>
<HEAD>
  <TITLE>Agendamento</TITLE>
<!-- Atribui os estilos apropriados para cada resolucao -->
<!--#include file="includes\verificaResolucao.inc"-->
<!-- Funcao isDate (data), onde data = dd/mm/aaaa -->
<script type="text/javascript" src="includes\isDate.js"></script>
<script language="javascript">
function getCookieVal (offset) 
{
	var endstr = document.cookie.indexOf (";", offset);
  if (endstr == -1)
  	endstr = document.cookie.length;
	return unescape(document.cookie.substring(offset, endstr));
}

function FixCookieDate (date) 
{
	var base = new Date(0);
	var skew = base.getTime(); // dawn of (Unix) time - should be 0
	if (skew > 0)  // Except on the Mac - ahead of its time
		date.setTime (date.getTime() - skew);
}

function GetCookie (name) 
{
	var arg = name + "=";
	var alen = arg.length;
	var clen = document.cookie.length;
	var i = 0;
	while (i < clen) 
	{
		var j = i + alen;
		if (document.cookie.substring(i, j) == arg)
			return getCookieVal (j);
			i = document.cookie.indexOf(" ", i) + 1;
			if (i == 0) break; 
	}
	return;
}

function lecookie(nome) 
{
	return GetCookie(nome);
}

function gravacookie(str) 
{ 
 	document.cookie = str + "; expires=" + expdate.toGMTString();
}

var expdate = new Date ();
FixCookieDate (expdate); // Correct for Mac date bug - call only once for given Date object!
expdate.setTime (expdate.getTime() + (1 * 24 * 60 * 60 * 1000)); // valido por um dia

gravacookie("flag_1=1");
gravacookie("flag_2=1");
function mudaData(tipo) // Ex: m-1 = um mes anterior
{
  var frm = document.formSuperior;
  frm.dataTipo.value = tipo.substring(0, 1);
  frm.dataQtd.value = tipo.substring(1, 3);
  desenhaTabela();
  frm.dataTipo.value = "";
  frm.dataQtd.value = "";
}

function mudouNome()
{
	desenhaTabela();
  var frm1 = parent.frames[2].document.frmInicioTermino;
	if (frm1.tpid != "-1")
	{
  	frm1.tpid.value = "-1";
	  frm1.action = "agendainf.asp";
  	frm1.target = "inferior";
		gravacookie("flag_2=1");
	  frm1.submit();
	}
}

function desenhaTabela()
{
  var frm = document.formSuperior;
  frm.action = "agendatab.asp";
  frm.target = "tabela";
	gravacookie("flag_1=1");
  frm.submit();
}

function localizaData(d)
{
  var frm = document.formSuperior;
  if (isDate(frm.dataI.value))
    frm.data.value = frm.dataI.value;
  else
  {
		alert("Data Invalida! Formato correto: dd/mm/aaaa");
		frm.dataI.focus();
		return;
  }
  desenhaTabela();
}
function inicial()
{
	desenhaTabela();
  var frm = document.formSuperior;
  frm.action = "agendainf.asp";
  frm.target = "inferior";
	gravacookie("flag_2=1");
  frm.submit();
}
</SCRIPT>

</head>
<body bgcolor="#FFFFFF" topmargin="3" leftmargin="3" onload="inicial();">

<%call MostraHeader%>
<form name="formSuperior" method="post">
<INPUT TYPE="hidden" NAME="data" VALUE="<%= data%>">
<INPUT TYPE="hidden" NAME="dataTipo" VALUE="">
<INPUT TYPE="hidden" NAME="dataQtd" VALUE="">
<table width="774" border=0 cellspacing=0>
<tr>
  <td>
    <font class="fonte2">Nome:</font>
    <font  class="fonte2">
    <SELECT NAME="nome" size="1" class="select5" ONCHANGE="mudouNome();">
	  <OPTION VALUE="-1">- Escolha o Responsável -</OPTION>
<%	Dim objConn, objRS
		Call Connection(True, objConn)
		Call RecordSet(True, objRS, "select USERID, NOME from userCRT order by userid", objConn)
		If not(objRS.EOF AND objRS.BOF) Then
			While( NOT( objRS.EOF ) )%>
				<option value="<%=objRS("USERID")%>"><%=ucase(objRS("USERID"))%> - <%=objRS("NOME")%>
<%			objRS.MoveNext
			Wend
		End If
		Call RecordSet(False, objRS, Null, Null)
		Call Connection(False, objConn)
%>
    </SELECT>
		</font>
  </td>
	<td align="center">
	  <INPUT TYPE="button" VALUE=" < Mês " ONCLICK="mudaData('m-1')" class="botao1">
	  <INPUT TYPE="button" VALUE=" < Sem " ONCLICK="mudaData('d-7')" class="botao1">
	  <INPUT TYPE="button" VALUE=" < Dia " ONCLICK="mudaData('d-1')" class="botao1">
	  <INPUT TYPE="button" VALUE=" Dia > " ONCLICK="mudaData('d+1')" class="botao1">
	  <INPUT TYPE="button" VALUE=" Sem > " ONCLICK="mudaData('d+7')" class="botao1">
	  <INPUT TYPE="button" VALUE=" Mês > " ONCLICK="mudaData('m+1')" class="botao1">
	</td>
	<td align="right">
		<font class="fonte2">Data:</font>
		<INPUT TYPE="text" NAME="dataI" SIZE="8" MAXLENGTH="10" class="texto2">
		<INPUT TYPE="button" VALUE="->" ONCLICK="localizaData()" class="botao05">
	</td>
</tr>
</form>		
</table>
<table width="770" border=1 cellspacing="0" cellpadding="0"><tr><td>
<table width="770" border=0 cellspacing="0" cellpadding="0">
<tr>
  <td width="200" bgcolor="<%=cordescricao%>" align="middle" height="33" id="tituloAtividade">
	<font color="<%=cortexto%>" class="fonte2">
	Atividades<br>
	(<%=day(data)&"/"&month(data)&"/"&year(data)%> a 
	<%=day(data+13)&"/"&month(data+13)&"/"&year(data+13)%>)
	</font></td>
<%for i=0 to 13
		if (i mod 2)=1 then%>
    <td id="dia<%= i%>" width="35" height="33" align="center" bgcolor="<%=cordia2%>">&nbsp;</td>
<%  else%>
    <td id="dia<%= i%>" width="35" height="33" align="center" bgcolor="<%=cordia1%>">&nbsp;</td>
<%  end if
	next %>

  <SCRIPT>
  <%for i=0 to 13%>
		parent.frames[0].document.all.dia<%= i%>.innerHTML = "<font color='<%=cortexto%>' class='fonte1'><%= day(data+i)&"/"&month(data+i)%></font><BR>" + 
		"<font color='<%=cortexto%>' class='fonte1'><%= semana(nrodia)%></font>" 
<%		nrodia = nrodia + 1
      if nrodia > 7 then 
        nrodia=1 
      end if
    next
   %>
  </SCRIPT>
</tr>
</table>
</td></tr></table>
</body>
</html>
<!--#include file="includes\rodape.inc"-->