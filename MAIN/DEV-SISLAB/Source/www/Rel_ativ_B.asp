<!--#include file="includes/Sislab_Lib.asp"-->
<!--#include file="includes/PadraoHTML.asp" -->
<!--#include file="includes/global.asp" -->
<!--#include file="includes/funcoes.asp" -->
<!--#include file="includes/controleshtml.asp" -->
<%
Server.ScriptTimeout = 100000

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

'response.Write sSQL
'response.End

Call Env.RecordSet( true, objSiteRS, sSQL)

total_registros = objSiteRS.RecordCount

Call Tela.ImprimeCabecalho2(TITULO_SITE, MENU_ON, true, "", "Acompanhamento de Agendamento", "location.href='rel_ativ.asp'", "")
%>
<script type="text/javascript" src="includes/manipulaObj.js"></script>
<script type="text/javascript">
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
<div class="margem-10">
    <form action="rel_ativ_B.asp" method="post">

    <input type="hidden" name="total_registros" value="<%=total_registros%>">
    <input type=hidden name="pagina">
    <input type="hidden" name="ssql2" value="<%=ssql%>">

    <br />
    <table class="largura-total table-condensed table-bordered table-striped table-hover">
    <tr>
	    <th class="texto-centralizado">AS</th>
	    <th class="texto-justificado">Descrição</th>
	    <th class="texto-centralizado">Situação</th>
	    <th class="texto-centralizado">
		    <%if auxClientes = true then%>
		    Cliente
		    <%else%>
		    Atividade
		    <%end if%>
	    </th>
	    <th class="texto-centralizado">Solicitante</th>
	    <th>Resp. Técnico<br>Coordenação (CRT)</th>
	    <th>Dt. Solicitada<br>Início - Término</th>
	    <th>&nbsp;</th>
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
    <tr style="vertical-align: top;">
	    <td class="texto-centralizado" style="vertical-align: top;">
		    <a title="Clique aqui para ver os dados desta AS" href="javascript: chama_as(<%=atual%>, 0);"><%=atual%></a>
	    </td>

	    <td class="texto-justificado">
                
<%			if (aux_SIGILO > 0) then%>
            <!--<img align="absmiddle" src="img/Iccadeado.gif" border="0" title="Sigilo de resultado">-->
            <span class="glyphicon glyphicon-lock" title="Sigilo de resultado" style="color: red;"></span>
<%			end if

			if TemArq then
				If bln_MostraDadoSigiloso Then%>
    		<a href="#" onClick="javascript:NewWindow('rel_ativ_arquivos.asp?selecao=<%=atual%>', '', 400, 200, 'yes');">
<%				End If %>
	    		<!--<img align="absmiddle" src="img/icnote.gif" border="0" title="Este agendamento possui arquivo(s) anexo(s)">-->
                <span class="glyphicon glyphicon-paperclip" title="Este agendamento possui arquivo(s) anexo(s)" style="color: darkblue;"></span>
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

	    <td class="texto-centralizado">
		    <%=auxsituacao%>&nbsp;
	    </td>

    	<td class="texto-centralizado">
<%			if auxClientes = true then response.write auxCliente else response.write aux_Atividade%>&nbsp;
	    </td>

	    <td class="texto-centralizado">
		    <%=auxAG_USERNAME%><%if auxorgao <> "" then response.write "<br><small>(" & auxorgao & ")</small>"%>&nbsp;
	    </td>

	    <td class="texto-centralizado">
		    <%=UCase(auxRES_AS)%><br><%=UCase(auxRAT_AG)%>&nbsp;
	    </td>
	
	    <td class="texto-centralizado">
		    <span font-size: 9px;"><%=auxAG_DATAINICIO_F & "-" & auxAG_DATATERMINO_F %></span>
	    </td>
	    <td class="texto-centralizado">
<%		If bln_MostraDadoSigiloso Then %>
	    	<a class="texto_tabela" href="javascript: showAguarde(); chama_as(<%=atual%>, 1);" title="Clique aqui para editar esta AS">
                <!--<img src="img/edit.gif" border="0">-->
                <span class="glyphicon glyphicon-log-in"></span>
	    	</a>
<%		Else%>
    		&nbsp;
<%		End If%>
	    </td>
    </tr>
<%		objSiteRS.MoveNext
	wend
%>
    </table>

    <script type="text/javascript">
        var frm = document.forms[0];
        frm.pagina.value = <%=contpagina %>;
    </script>

    <table class="largura-total">
    <tr>
	    <td width="150px">
		    <%if contpagina > 1 then%>
			    <a href="javascript:paginaAnterior()"><small>&laquo; Voltar</small></a>
		    <%end if%>
	    </td>
	    <td class="texto-centralizado">
            <small>
		    Página atual: <%=contpagina%>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
            Total de Registros: <%=total_registros%></small>
	    </td>
	    <td class="texto-direito" style="width: 150px;">
		    <%if objsiteRS.eof = false then%>
			    <a href="javascript:proximaPagina()"><small>Avançar &raquo;</small></a>
		    <%end if%>
	    </td>
    </tr>
<%
else
%>
    <tr>
	    <td colspan="8" align="center">
		    <strong>Não existem testes agendados com estes critérios de seleção.<br />
		    <%=auxrt%></strong>
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
</div>
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
