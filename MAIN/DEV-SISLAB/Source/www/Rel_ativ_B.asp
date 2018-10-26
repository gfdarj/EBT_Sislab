<!--#include file="includes/Sislab_Lib.asp"-->
<!--#include file="includes/PadraoHTML.asp" -->
<!--#include file="includes/global.asp" -->
<!--#include file="includes/funcoes.asp" -->
<!--#include file="includes/controleshtml.asp" -->
<%
dim objConn, rsArquivos
Dim objSiteRS, objSiteMail, contat, sSQL, tot, objsiteCRT
Dim auxareateste,auxtipoteste,auxsituacaoteste,auxdiasteste, auxdescricao, auxsolicitante
Dim auxRT, auxRAT, EH_CRT, aux_Sigilo, auxorgao, auxtecnologia, auxAs
Dim total_registros
Dim TemArq
Dim auxAG_DATAINICIO_F
Dim	auxAG_DATATERMINO_F
Dim bln_MostraDadoSigiloso : bln_MostraDadoSigiloso = True

EH_CRT = Env.UsuarioCRT()

if request("ssql") = "" then	'-- foi submetido por este mesmo form
	ssql = request("ssql2")
	pagina = request("pagina")
else	'-- veio do form Rel_Ativ_A.asp
	ssql = request("ssql")
	pagina = 1
end if

call Env.RecordSet( true, objSiteRS, sSQL)

total_registros = objSiteRS.RecordCount

Call Tela.ImprimeCabecalho2(TITULO_SITE, MENU_ON, true, "", "Acompanhamento de Agendamento", "location.href='rel_ativ.asp'", "")
%>
<script language="javascript" src="includes/manipulaObj.js"></script>
<script language="javascript">
function chama_as(cod_as, oquefazer)
{
	if(oquefazer == 1) {
	   	sel.selecao.value=cod_as;
		sel.action = 'CadAgendamentoCliente.asp'
		sel.method = 'Post'
		sel.submit();
	}
	else {
		var jan = window.open('ficha_as.asp?emjanela=1&selecao=' + cod_as, '', 'toolbar=no,location=no,directories=no,status=yes,menubar=no,scrollbars=yes,resizable=yes,copyhistory=no');
		jan.focus();
	}
}

function proximaPagina()
{
	var frm = document.forms[0];
	frm.pagina.value = <%=pagina+1%>;
	frm.submit();
}
function VaiPagina(pagina)
{
	var frm = document.forms[0];
	frm.pagina.value = pagina;
	frm.submit();
}

function paginaAnterior()
{
	var frm = document.forms[0];
	frm.pagina.value = <%=pagina-1%>;
	frm.submit();
}
</script>
<form action="rel_ativ_B.asp" method="post">
<input type="hidden" name="total_registros" value="<%=total_registros%>">
<input type=hidden name="pagina">
<input type="hidden" name="ssql2" value="<%=ssql%>">
<br>
<table border="1" width="100%" cellpadding="2" cellspacing="0" class="table-bordered" style="border: solid thin;">
<tr>
	<th width="35px" style="font-size: xx-small;">N&deg; AS</th>
	<th style="font-size: xx-small;">Atividade</th>
	<th style="font-size: xx-small;">Situação</th>
	<th style="font-size: xx-small;">
		<%if auxClientes = true then%>
		Cliente
		<%else%>
		Atividade
		<%end if%>
	</th>
	<th style="font-size: xx-small;">Solicitante</th>
	<th style="font-size: xx-small;">Resp. Técnico<br>Coordenação (CRT)</th>
	<th style="font-size: xx-small;">Dt. Solicitada<br>Início - Término</th>
	<th width="20">&nbsp;</th>
</tr>
<%
If Not(objSiteRS.EOF) Then
	Dim	auxRES_AS, auxsituacao, auxAG_USERNAME, auxAG_DATAINICIO
	Dim auxAG_DATATERMINO, atual, testeAtual, aux_DescSigilo, AUXRAT_AG

	if request("pagina") = "" then contpagina = 1 else contpagina = cint(request("pagina"))
	objSiteRS.AbsolutePage = contpagina

	while (intrec < objSiteRS.PageSize and not objSiteRS.EOF)

		if not IsNull(objSiteRS("AG_TITULO")) then auxAG_OBJETIVO = objSiteRS("AG_TITULO") else auxAG_OBJETIVO = objSiteRS("AG_OBJETIVO")

		atual = objSiteRS("AG_NUMERO")
		aux_Atividade = objSiteRS("TA_DESCRICAO")
		aux_Sigilo = objsiteRS("AG_SIGILO")
		aux_DescSigilo = objsiteRS("TS_DESCRICAO")
		auxsituacao = objSiteRS("S_DESCRICAO")
		auxRAT_AG = objSiteRS("AG_RAT")
		auxAG_USERNAME = UCase(objSiteRS("AG_USERNAME"))
		auxAG_DATAINICIO = objSiteRS("AG_DATAINICIO")
		auxAG_DATATERMINO = objSiteRS("AG_DATATERMINO")
		auxAG_DATAINICIO_F = objSiteRS("AG_DATAINICIO_F")
		auxAG_DATATERMINO_F = objSiteRS("AG_DATATERMINO_F")
		auxRES_AS = objSiteRS("AG_RESPONSAVEL")
		auxorgao = objSiteRS("AG_ORGAO")
		auxAS = objSiteRS("AG_NUMERO")
		auxtecnologia = objSiteRS("TEC_NOME")
		auxcliente = objSiteRS("AG_CLIENTEEXTERNO")
		auxRepetido = objSiteRS("AG_REPETIDO")

		bln_MostraDadoSigiloso = MostraDadoSigiloso(aux_SIGILO, auxAG_USERNAME)

		TemArq = TemArquivo(objConn, objSiteRS("AG_NUMERO"))

		intrec = intrec + 1
%>
<tr valign="middle">
	<td align="left" valign="middle">
		&nbsp;<a title="Clique aqui para ver os dados desta AS" href="javascript: chama_as(<%=atual%>, 0);"><B> <%=atual%></a>
	</td>

	<td align="justify">
<%			if (aux_SIGILO > 0) then%>
<img align="absmiddle" src="img/Iccadeado.gif" border="0" title="Sigilo de resultado">
<%			end if

			if TemArq then
				If bln_MostraDadoSigiloso Then%>
		<a href="#" onClick="javascript:NewWindow('rel_ativ_arquivos.asp?selecao=<%=atual%>', '', 400, 200, 'yes');">
<%				End If %>
			<img align="absmiddle" src="img/icnote.gif" border="0" title="Este agendamento possui arquivo(s) anexo(s)">
<%				If bln_MostraDadoSigiloso Then%>
		</a>
<%				End If %>
<%			end if%>

<%			'sSQL = "Select AG_RELAT_RT, AG_RELAT_RAT from Agendamento " & _
			'	"WHERE AG_Numero = " & anterior
			'call Env.RecordSet( true, objSiteMail, sSQL, objConn)
			if ( (not IsNull(objSiteRS("AG_RELAT_RT"))) or _
				(not IsNull(objSiteRS("AG_RELAT_RT"))) ) and EH_CRT = true then%>
		<img align="absmiddle" src="img/ico_mail.gif" border="0" title="Esta AS possui Relatório de RAT/RT">
<%			end if

			if auxRepetido = true then%>
		<img align="absmiddle" src="img/icon3.gif" border="0" title="Repetição">
<%			end if%>

<%
			if auxtecnologia <> "" then response.write auxtecnologia & "&nbsp;-&nbsp;"
			if aux_Atividade <> "" then response.write aux_Atividade & "&nbsp;-&nbsp;"
			if auxAG_OBJETIVO <> "" then response.write auxAG_OBJETIVO & "&nbsp;-&nbsp;"
			if aux_DescSigilo <> "" then response.write aux_DescSigilo 
%>
	</td>

	<td align="center">
		<span font-size: 9px;"><%=auxsituacao%>&nbsp;</span>
	</td>

	<td align="center">
<%			if auxClientes = true then response.write auxCliente else response.write aux_Atividade%>&nbsp;
	</td>

	<td align="center">
		<span font-size: 9px;"><%=auxAG_USERNAME%><%if auxorgao <> "" then response.write "<br><i>(" & auxorgao & ")</i>"%>&nbsp;</span>
	</td>

	<td align="center">
		<span font-size: 9px;"><%=UCase(auxRES_AS)%><br><%=UCase(auxRAT_AG)%>&nbsp;</span>
	</td>
	
	<td align="center">
		<span font-size: 9px;"><%=auxAG_DATAINICIO_F & "-" & auxAG_DATATERMINO_F %></span>
	</td>
	<td width="20px" align="center">
<%		If bln_MostraDadoSigiloso Then %>
		<a class="texto_tabela" href="javascript: showAguarde(); chama_as(<%=atual%>, 1);" title="Clique aqui para editar esta AS"><img src="img/edit.gif" border="0"></a>
<%		Else%>
		&nbsp;
<%		End If%>
	</td>
</tr>
<%		objSiteRS.MoveNext
	wend
%>
</table>
<script language="JavaScript">
	var frm = document.forms[0]
	frm.pagina.value = <%=contpagina%>
</script>

<table width="100%" border="0" cellspacing="2" cellpadding="0" class="table-bordered">
<tr>
	<td align="left" width="150px">
		<%if contpagina > 1 then%>
			<a href="javascript:paginaAnterior()" class="menu"><span class="cinza1">&laquo;</span> Voltar</a>
		<%end if%>
	</td>
	<td align="center">
		<B>&nbsp;&nbsp;Página atual: <%=contpagina%></B>&nbsp;&nbsp;&nbsp;&nbsp;
		<B>&nbsp;&nbsp;Total de Registros: <%=total_registros%></B>&nbsp;&nbsp;&nbsp;&nbsp;
	</td>
	<td align="right" width="150px">
		<%if objsiteRS.eof = false then%>
			<a href="javascript:proximaPagina()" class="menu">Avançar <span class="cinza1">&raquo;</span></a>
		<%end if%>
	</td>
</tr>
<%
else
%>
<tr>
	<td colspan="8" align="center">
		<b><i>Não existem testes agendados com estes critérios de seleção.
		<%=auxrt%></i></b>
	</td>
</tr>
<%
end if
%>
</table>
</form>

<form name="sel" action="ficha_as.asp" method="post">
<input type="hidden" name="selecao">
</form>
<%
Call Tela.MostraRodape()

Function TesteRepetido(str, procurar_por)
	Dim ret : ret = True
	Dim val
	val = instr(1, str, procurar_por, 1)
	if ( val = 0 ) or ( val = null ) then ret = False
	TesteRepetido = ret
End Function
%>
