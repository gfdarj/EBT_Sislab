<!-- #INCLUDE FILE="includes/inicializacao.inc" -->
<%'	On Error Resume Next
	
	
'Chama função em config.inc que faz a conexão com o Banco de dados

	Conecta True

' Inicializo variavel de conexão 
%>
<script>
function chama_oc(cod_oc)
{
    	sel.selecao.value=cod_oc;
	sel.submit();
}
</script>
<style>
.celula
{        
	BORDER-TOP: black thin inset; 
}
</style> 
<HTML>
<HEAD>
  <TITLE>Consulta de Resolução das Ocorrências</TITLE>
</HEAD>
<BODY bgcolor="#FFFFFF" topmargin="0" leftmargin="3" link="#FFFFFF" vlink="#FFFFFD" alink="#FFFFF6">
<%call MostraHeader%>
<table width="750" cellspacing="0">
	<tr>
		<td colspan="5" align="center" bgcolor="#05527A" valign="top">
			<font face="arial" class="Fonttit1Cad"  color="#FFFFFF"><B>Quadro de Registros (OPM, RAC e RAP) em Ocorrências</b></font>
		</td>
	</tr>		
<%
	Dim sSQL, objSiteRS, TipoRes, objConn
	
	sSQL = "SELECT R_NOME, R_NUMERO, LB.LB_DESCRICAO, "
  sSQL = sSQL & "U.NOME, U.UserId, "
  sSQL = sSQL & "LB.LB_ID, LB_AnaliseGQ, LB_DataHoraOco "
  sSQL = sSQL & "FROM LB_LogBook LB "
  sSQL = sSQL & "LEFT JOIN "
  sSQL = sSQL & "UserCRT U ON "
  sSQL = sSQL & "LB.LB_RESPEXEC = U.USERID "
  sSQL = sSQL & "LEFT JOIN "
  sSQL = sSQL & "ResolucaoLB R on R.LB_ID = LB.LB_ID "
  sSQL = sSQL & "Where R.LB_ID is not null and R_NOME <> 'NA' "
  sSQL = sSQL & "order by R_NOME, R_Numero "

Set objsiteRS = obterRecordset(sSQL)
	if not(objSiteRS.EOF) then
		objSiteRS.MoveFirst
		TipoRes = ""

			While( NOT( objSiteRS.EOF ) )
			if (TipoRES <> ucase(objsiteRS("R_NOME"))) then
				if (TipoRES <> "") then%>
					<tr>
						<td colspan="4" height="30">
							&nbsp;
						</td>
					</tr>
<%			end if%>
	<tr>
	<td width="550" colspan="5" bgcolor="#c0c0c0">
		<font class="fonte3"><b><%=ucase(objSiteRS("R_NOME"))%></b></font>
	</td>
	</tr>
	<tr>
	<td class="celula" width="80" valign="baseline" align="center">
		<font class="fonte2">&nbsp;N&deg; <%=objSiteRS("R_NOME")%></font>
	</td>
	<td class="celula" width="50" valign="baseline" align="center">
		<font class="fonte2">N&deg; OC</font>
	</td>
	<td class="celula" width="175" valign="baseline" align="center">
		<font class="fonte2">Ocorrência</font>
	</td>
	<td class="celula" width="175" valign="baseline" align="center">
		<font class="fonte2">Análise GQ</font>
	</td>
	<td class="celula" width="70" valign="baseline" align="center">
		<font class="fonte2">Data</font>
	</td>
	</tr>
<%		end if%>
	<tr>
	<td class="celula" width="50" valign="baseline" align="right">
		<font face="Arial" size="-5">&nbsp;&nbsp;&nbsp;<%=objSiteRS("R_NUMERO")%></font>
	</td>
	<td class="celula" width="50" valign="baseline" align="justify">
		<font face="Arial" size="-5">&nbsp;<a href="javascript: chama_oc(<%=objSiteRS("LB_ID")%>)" style="color=#800000;"><B> <%=objSiteRS("LB_ID")%></a></font>
	</td>
	<td class="celula" width="175" valign="baseline" align="justify">
		<font face="Arial" size="-5">&nbsp;<%=objSiteRS("LB_DESCRICAO")%></font>
	</td>
	<td class="celula" width="175" valign="baseline" align="justify">
		<font face="Arial" size="-5">&nbsp;<%=objSiteRS("LB_ANALISEGQ")%></font>
	</td>
	<td class="celula" width="100" valign="baseline" align="justify">
		<font face="Arial" size="-5">&nbsp;<%=objSiteRS("LB_DATAHORAOCO")%></font>
	</td>
	</tr>
<%			TipoRes = ucase(objSiteRS("R_NOME"))
				objSiteRS.MoveNext
			Wend
		else%>
	<tr>
		<td colspan="4" align="center">
			<font class="fonte3"><i><b>Nenhum resultado foi encontrado neste período.</b></i></font>
		</td>
	</tr>		
<%	end if
set objSiteRS = Nothing
%>

</table>
<form name="sel" action="ficha_oc.asp" method="post">
<input type="hidden" name="selecao">
</form>
</BODY>
</HTML>
<%
	'Fechar Objetos abertos
 	Conecta False

	Call MostraFooter
%>