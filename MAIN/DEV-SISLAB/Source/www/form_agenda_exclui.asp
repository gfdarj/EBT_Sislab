<!--#include file="includes/Sislab_Lib.asp"-->
<!--#include file="includes/PadraoHTML.asp" -->
<!--#include file="includes/ControlesHTML.asp" -->
<!--#include file="includes/global.asp" -->
<%
Dim objRS, objConn, s
Dim agnumero : agnumero = ""

agnumero = request("cmbAS")

call imprimeCabecalho2(TITULO_SITE, MENU_ON, true, "", "Administração do SISLAB - Excluir um Agendamento", "location.href='sislab.asp'", "")
%>
<script language="JavaScript">
    function selecionarAS(eu) {
	    if(eu.value == "")
		    alert("Selecione um agendamento");
	    else {
		    document.formulario.action = "form_agenda_exclui.asp";
		    document.formulario.submit();
	    }
    }
</script>

<form name="formulario" method="post" action="form_agenda_exclui.asp">
<input type="Hidden" name="ag_numero" value="<%=agnumero%>">
<input type="Hidden" name="os_id" value="">
<table width="100%" cellpadding="2" cellspacing="0" border="0" class="tabela1">
<tr>
	<td>
		<span class="texto1B">Selecione uma AS para exclus&atilde;o</span><br>
		<%Call comboAgendamento("txtAS", "cmbAS", objConn, agnumero, "N")%>
		&nbsp;&nbsp;&nbsp;
		<input class="texto1" type="button" onclick="javascript:selecionarAS(document.all.cmbAS);" value=" Selecionar ">
	</td>
</tr>
<tr><td>&nbsp;</td></tr>
<%
if agnumero <> "" then
	s = _
		"SELECT AG_OBJETIVO, CONVERT(VARCHAR, AG_DATASOLICITACAO, 103) AS AG_DATASOLICITACAO, " & _
		"CONVERT(VARCHAR, AG_DATAINICIO, 103) AS AG_DATAINICIO, " & _
		"CONVERT(VARCHAR, AG_DATATERMINO, 103) AS AG_DATATERMINO, " & _
		"AG_RESPONSAVEL, AG_RAT, t.TEC_NOME " & _
		"FROM Agendamento a LEFT JOIN Tecnologia t ON a.TEC_ID = t.TEC_ID " & _
		"WHERE a.AG_NUMERO = " & agnumero
	call Env.RecordSet(true, objRS, s)
	if not (objRS.Eof and objRS.Bof) then
%>
<tr>
	<td>
		<table width="100%" cellpadding="2" cellspacing="0" class="tabela1" border="1">
		<tr>
			<td class="realce1" colspan="2">Dados do Agendamento <%=agnumero%></td>
			<td width="60px" rowspan="7" align="center" valign="middle"><input type="Button" value=" Excluir Agendamento" class="texto1" onclick="javascript:excluirAS(<%=agnumero%>);"></td>
		</tr>
		<tr><td width="75px">&nbsp;<b>Tecnologia:</b></td><td>&nbsp;<%=objRS("TEC_NOME")%></td></tr>
		<tr><td>&nbsp;<b>Objetivo:</b></td><td>&nbsp;<%=objRS("AG_OBJETIVO")%></td></tr>
		<tr><td>&nbsp;<b>Solicita&ccedil;&atilde;o:</b></td><td>&nbsp;<%=objRS("AG_DATASOLICITACAO")%></td></tr>
		<tr><td>&nbsp;<b>Per&iacute;odo:</b></td><td>&nbsp;<%=objRS("AG_DATAINICIO")%>&nbsp;-&nbsp;<%=objRS("AG_DATATERMINO")%></td></tr>
		<tr><td>&nbsp;<b>RT:</b></td><td>&nbsp;<%=objRS("AG_RESPONSAVEL")%></td></tr>
		<tr><td>&nbsp;<b>RAT:</b></td><td>&nbsp;<%=objRS("AG_RAT")%></td></tr>
		</table>
	</td>
</tr>
		<script language="JavaScript">
			function excluirAS(agnumero) {
				var ok = false;
				var msg = "Confirma a exclusão do agendamento " + agnumero + " ?";
				if(confirm(msg)) {
					document.forms[0].action = "form_agenda_excluiA.asp";
					document.forms[0].os_id.value = "";
					document.forms[0].ag_numero.value = agnumero;
					document.forms[0].submit();
				}
			}
		</script>

<%		'-- pego as OS´s
		call Env.RecordSet(false, objRS, null)
		s = _
			"SELECT os.OS_ID, t.T_TITULO " & _
			"FROM Ordem_de_Servico os INNER JOIN Testes t ON os.T_ID = t.T_ID " & _
			"WHERE AG_NUMERO = " & agnumero
		call Env.RecordSet(true, objRS, s)
		if not (objRS.Eof and objRS.Bof) then%>
<tr><td>&nbsp;</td></tr>
<tr>
	<td>
		<table width="100%" cellpadding="2" cellspacing="0" class="tabela1" border="1">
		<tr><td class="realce1" colspan="3">Dados da Ordem de Servi&ccedil;o</td></tr>
		<tr style="font-weight: bold;"><td width="70px">Nº OS</td><td>Teste</td><td width="150px">&nbsp;</td></tr>
<%			while not objRS.Eof%>
		<tr><td><%=objRS("OS_ID")%></td><td><%=objRS("T_TITULO")%>&nbsp;</td><td align="center"><input type="Button" class="texto1" value="Excluir OS <%=objRS("OS_ID")%>" onclick="javascript:excluirOS(<%=agnumero%>,<%=objRS("OS_ID")%>);"></td></tr>
<%				objRS.MoveNext
			wend%>
		<tr><td colspan="2">&nbsp;</td><td align="center"><input type="Button" class="texto1" value="Excluir Tudo" onclick="javascript:excluirOS(<%=agnumero%>,-1);"></td></tr>
		</table>
	</td>
</tr>
		<script language="JavaScript">
			function excluirOS(agnumero, os) {
				var ok = false;
				var msg = (os < 0) ? "Confirma a exclusão de todas as OS´s do agendamento " + agnumero + " ?" : "Confirma a exclusão da OS número " + os + " do agendamento " + agnumero + " ?";
				if(confirm(msg)) {
					document.forms[0].action = "form_agenda_excluiA.asp";
					document.forms[0].exclui = "OS";
					document.forms[0].os_id.value = os;
					document.forms[0].ag_numero.value = agnumero;
					document.forms[0].submit();
				}
			}
		</script>
<%		end if
	else%>
<tr><td align="center">Agendamento n&atilde;o encontrado</td></tr>
<%
	end if
	call Env.RecordSet(false, objRS, null)
end if
%>
</table>
</form>


<%response.end%>

<script language="javascript">
function chama_as(cod_as) {
	sel.selecao.value=cod_as;
	sel.submit();
}
</script>

<table width=470>
<tr>
<td>
<font face=tahoma style="font-size=12pt;">

<div align=justify>
<%
sSQL = "Select A.*, TA.*, U.*"
sSQL = sSQL & " from USERCRT U, TIPO_ATIVIDADE TA, AGENDAMENTO A "
sSQL = sSQL & " where A.AG_RESPONSAVEL = U.USERID"
sSQL = sSQL & " and A.TA_ID = TA.TA_ID"
sSQL = sSQL & " ORDER BY AG_DATAINICIO ASC"

Set objSiteRS = Env.oConn.Execute(sSQL)
%>

<CENTER>
<font style="font-size: 5pt"><br></font>

<table border="0" width="720" cellpadding="2">
  <tr>
<td  bgcolor="#000030">
<font face="arial" class="Fonttit1Cad"  color="#FFFFFF"><B>
<center>
Escolha o Agendamento a ser excluído</B></Font>
<br></center>
</td></tr>
</table>

<table width="720">
<tr>
<td  bgcolor="#666666" align="center" width="48%">
<font face="verdana" class="FontMenu1" color="#FFFFFF" >
<B>
ATIVIDADE
</B>
</font>
</td>

<td  bgcolor="#666666" align="center" width="15%">
<font face="verdana" class="FontMenu1" color="#FFFFFF">
<B>
SOLICITANTE
</B>
</font>
</td>

<td  bgcolor="#666666" align="center" width="15%">
<font face="verdana" class="FontMenu1" color="#FFFFFF">
<B>
RESPONSÁVEL</B>
</font>
</td>

<td  bgcolor="#666666" align="center" width="22%">
<font face="verdana" class="FontMenu1" color="#FFFFFF">
<B>
INÍCIO - TÉRMINO
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
<B>
&nbsp;&nbsp;<a href="javascript: chama_as(<%=objSiteRS("AG_NUMERO")%>)" style="color=#FFFF77;">&nbsp;N<sup>o</sup> AS: <%=objSiteRS("AG_Numero")%> - <%=objSiteRS("AG_OBJETIVO")%></a>
</B>
</font>
</a>
</td>
<td bgcolor="#888888" align="center">
<font face="verdana" class="FontMenu1" color="#FFFFFF">
<%=objSiteRS("NOME")%></font>
</td>
<td bgcolor="#888888" align="center">
<font face="verdana" class="FontMenu1" color="#FFFFFF">
<%=objSiteRS("NOME")%></font>
</td>
<td bgcolor="#888888" align="center">
<font face="verdana" class="FontMenu1" color="#FFFFFF">
<%=FormataDataDisplay(objSiteRS("AG_DATAINICIO"))%> - <%=FormataDataDisplay(objSiteRS("AG_DATATERMINO"))%></font>
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
Não existem atividades agendadas no momento.
<br>
</font>
</div>
</td>
</tr>
<% end if %>
</table>

<font style="font-size: 5pt"><br></font>


<form name="sel" action="form_agenda_excluiA.asp" method="post">
<input type="hidden" name="selecao">
</form>

<!--

<table border="0" width="720" cellpadding="2">
  <tr>
<td  bgcolor="#000030">
<font face="arial" class="Fonttit1Cad" color="#FFFFFF"><B>
<center>
Últimas Atividades Realizadas</B></Font>
<br></center>
</td></tr>
</table>


<table width="720">

<tr>
<td  bgcolor="#666666" align="center" width="48%">
<font face="verdana" color="#FFFFFF" class="FontMenu1">
<B>
ATIVIDADE
</B>
</font>
</td>

<td  bgcolor="#666666" align="center" width="15%">
<font face="verdana" color="#FFFFFF" class="FontMenu1">
<B>
SOLICITANTE
</B>
</font>
</td>

<td  bgcolor="#666666" align="center" width="15%">
<font face="verdana" color="#FFFFFF" class="FontMenu1">
<B>
RESPONSÁVEL</B>
</font>
</td>

<td  bgcolor="#666666" align="center" width="22%">
<font face="verdana"  color="#FFFFFF" class="FontMenu1">
<B>
INÍCIO - TÉRMINO
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
<B>
&nbsp;&nbsp;<%=objSiteRS("ARQ_Link")%>
</B>
</font>
</a>
</td>
<td bgcolor="#888888" align="center">
<font face="verdana" color="#FFFFFF" class="FontMenu1">
<%=objSiteRS("TAR_TipoArquivo")%></font>
</td>
<td bgcolor="#888888" align="center">
<font face="verdana" color="#FFFFFF" class="FontMenu1">
<%=objSiteRS("TAR_TipoArquivo")%></font>
</td>
<td bgcolor="#888888" align="center">
<font face="verdana" color="#FFFFFF" class="FontMenu1">
<%=objSiteRS("ARQ_DataAtualizacao")%></font>
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
Não existem atividades realizadas no momento.
<br>
</font>
</div>
</td>
</tr>
<% end if %>
</table>

-->

</div>
</font>
</td>
</tr>
</table>
<%
Call imprimeRodape(RODAPE_On)
%>