<!--#include file="includes/Sislab_Lib.asp"-->
<!--#include file="includes/PadraoHTML.asp" -->
<!--#include file="includes/global.asp" -->
<!--#include file="includes/bib_data.inc" -->
<!--#include file="includes/funcoes.asp" -->
<%
Dim username, EhRat, EhCrt
Dim auxAG_DATAINICIO_F
Dim auxAG_DATATERMINO_F
Dim chr_Ordem
Dim conta : conta = 0

Username = Env.Usuario
EhRat = Env.EhRat : EhRat = False
EhCrt = Env.UsuarioCrt : EhCrt = False
chr_Ordem = UCase(RQ("ordem"))

If Request("emjanela") = "1" Then
	If Request("hoje") = "1" Then
		Call ImprimeCabecalho2(TITULO_SITE, MENU_OFF, false, "100%", "Lista de Atividades - Hoje no CRT", "SO_IMPRESSORA", "")
	Else
		Call ImprimeCabecalho2(TITULO_SITE, MENU_OFF, false, "100%", "Lista de Atividades do CRT", "SO_IMPRESSORA", "")
	End If
Else
	If Request("hoje") = "1" Then
		Call ImprimeCabecalho2(TITULO_SITE, MENU_ON, true, "", "Lista de Atividades - Hoje no CRT", "", "")
	Else
		Call ImprimeCabecalho2(TITULO_SITE, MENU_ON, true, "", "Lista de Atividades do CRT", "", "")
	End If
End If

Dim objRS, s, objSiteRS, sSQL, indice, cont
%>

<!-- AJAX -->
<script type="text/javascript" src="ajax/max_ajax_ref.js" ></script>
<script type="text/javascript">
	function trocaPrioridade(agNumero, idPrioridade){
		var url = "ajax/sislab_ag_prioridade_upd.asp";
		url += "?ag_numero=" + agNumero;
		url += "&id_prioridade=" + idPrioridade;

		var maxAjaxObj = new max.Ajax(url,{update:"",onComplete:
			function(texto,xml){
				//document.all.dtUltInventario.value = texto;
			}
		});
		maxAjaxObj.get();
		return true;
	}
</script>


<form name="formulario" method="get">
<input type="hidden" name="num_as">
<input type="hidden" name="selecao">
<input type="hidden" name="hoje" value="<%=request("hoje")%>">
<table width="100%" border="0" cellspacing="0" cellpadding="0" align="left" class="tabela1">
<tr>
	<td>
		<table width="100%" cellpadding="0" cellspacing="0" border="0">
		<tr>
			<td class="fonteTitulo1"><span style="color: red">&raquo;</span>&nbsp;Agendamentos do CRT</td>
			<td align="right" class="texto1" style="color: gray;">Ordenar por:&nbsp;
				<select name="ordem" class="texto1" onChange="javascript:document.formulario.submit();" style="color: gray;">
					<option value=""<%=IIf(chr_Ordem = "", " selected", "")%>>Situação</option>
					<option value="S"<%=IIf(chr_Ordem = "S", "selected", "")%>>Salas</option>
					<option value="D"<%=IIf(chr_Ordem = "D", "selected", "")%>>Data Término</option>
					<option value="P"<%=IIf(chr_Ordem = "P", "selected", "")%>>Prioridade</option>
					<option value="R"<%=IIf(chr_Ordem = "R", "selected", "")%>>Resp. Técnico</option>
				</select>
			</td>
		</tr>
		</table>
	</td>
</tr>

<tr> 
	<td height="25">
  	  <table width="100%" border="0" cellspacing="0" cellpadding="0" height="25" class="tabela1">
      <tr>
		<td width="180" class="fonteTitulo1">&nbsp;</td>
		<td>
	        <div align="right" class="links">Agendamentos em andamento: <b><span id="tot_agenda">XX</span></b>&nbsp;
          <font color="#993300">l</font>&nbsp; Agendamentos futuros: <b><%
s = "select count(*) as Total_Futuros From vw_Agendamento "
s = s & "where ID_SITUACAO = 1 or (ID_SITUACAO=3 and AG_DATAINICIO > getDate())"
Call Env.RecordSet( true, objRS, s)
if not IsNull( objRS(0) ) then Response.write objRS(0)
Call Env.RecordSet( false, objRS, s )
%>
					</b></div>
        </td>
      </tr>
  	  </table>
    </td>
</tr>

<tr><td height="1" bgcolor="#003366"></td></tr>

<tr>
    <td height="10">
		<font class="noticias">
<%
sSQL = "select * from dbo.vw_PESQ_SATISFACAO order by indice desc; "
Call Env.RecordSet(True, objSiteRS, sSQL)
if not(objSiteRS.EOF) Then
	objSiteRS.MoveFirst
%>
			&nbsp;<b>Pesquisa Satisfação</b>: Total de <%=objSiteRS("TIPO")%>: <%=objSiteRS("Indice")%><br>
<%
	indice = objSiteRS("Indice")
	objSiteRS.MoveNext %><div align="right"><%
	While not(objSiteRS.EOF)%>
			<%=objSiteRS("TIPO")%>: <%=objSiteRS("Indice")%> (<%=FormatNumber(objSiteRS("Indice")*100/indice,2)%>%)
<%		objSiteRS.MoveNext
		If Not objSiteRS.Eof Then Response.Write "&nbsp;&nbsp;"
	Wend %>
			</div>
<%
End If%>
		</font>
	</td>
</tr>

<tr>
	<td>
<%
'### Imprime o corpo da lista de acordo com a ordenação escolhida
If chr_Ordem = "S" Then
	Call MontaVisaoPorSalas
ElseIf chr_Ordem = "D" Then
	Call MontaVisaoPorDataTermino
ElseIf chr_Ordem = "P" Then
	Call MontaVisaoPorPrioridade
ElseIf chr_Ordem = "R" Then
	Call MontaVisaoPorRT
Else
	Call MontaVisaoPorSituacao
End If
%>
    </td>
</tr>
</table>
</form>
<%
'### Rodapé
if request("emjanela") = "1" then
	call ImprimeRodape(RODAPE_OFF)
else
	call ImprimeRodape(RODAPE_ON)
end if
%>
<script language="JavaScript">
//-- comentado o codigo que utiliza esta linha !!!!!
document.all.tot_agenda.innerText = "<%=conta%>"; // atualizo o contador de agendamentos

function chama_as(cod_as, oquefazer)
{
	if(oquefazer == 1) {
		document.formulario.action = "cadAgendamentoCliente.asp";
		document.formulario.num_as.value = cod_as;
		document.formulario.selecao.value = cod_as;
		document.formulario.submit();
	}
	else {
		var jan = window.open('ficha_as.asp?emjanela=1&selecao=' + cod_as, '', 'toolbar=no,location=no,directories=no,status=yes,menubar=no,scrollbars=yes,resizable=yes,copyhistory=no');
		jan.focus();
	}
}
</script>

<%
'#########################################################################################################
'# Rotinas para montar a tela de acordo com a ordenação
'#########################################################################################################

Sub MontaVisaoPorSituacao

	Dim	auxAG_OBJETIVO, auxsituacao, auxAG_USERNAME, auxRT, iPrioridade, aux_AgNumero
	Dim auxAG_DATAINICIO, auxAG_DATATERMINO, anterior, atual, aux_DescSigilo, auxTEC
	Dim aux_Sigilo, auxbarq, auxbgcolor, AUXSITUACAOCHG, aux_Atividade
%>
      <table border="0" width="100%" cellspacing="3" cellpadding="4" class="texto_tabela" align="center" class="tabela1">
        <tr>
          <th>AS</th>
			<th>Prioridade</th>
          <th>Atividade</th>
          <th>Data solicitada<br>in&iacute;cio-t&eacute;rmino</th>
		  <th>Salas</th>
          <th>&nbsp;</th>
        </tr>
<%
	s = "SELECT a.*, CONVERT(VARCHAR, AG_DATAINICIO, 103) AS AG_DATAINICIO_F, CONVERT(VARCHAR, AG_DATATERMINO, 103) AS AG_DATATERMINO_F " & _
		"FROM vw_Agendamento a  " & _
		"WHERE a.ID_SITUACAO in "

	if request("hoje") = "1" then
		s = s & "(3, 6, 7) AND (a.AG_DATAINICIO < getDate()) "
	else
		s = s & "(1, 2, 3, 6, 7) "
	end if

	s = s & "ORDER BY a.ID_SITUACAO ASC, a.AG_NUMERO DESC"

	Call Env.RecordSet( true, objRS, s)
	if not (objRS.EOF and objRS.BOF) then
		atual = objRS("AG_NUMERO")

		'-- pego o titulo do agendamento, caso nao exista mostro o objetivo
		if not IsNull(objRS("AG_TITULO")) then auxAG_OBJETIVO = objRS("AG_TITULO") else auxAG_OBJETIVO = objRS("AG_OBJETIVO")

		while not objRS.EOF
			aux_Sigilo = objRS("AG_SIGILO")
			aux_Atividade = objRS("TA_DESCRICAO")
			aux_DescSigilo = objRS("TS_DESCRICAO")
			auxsituacao = objRS("S_DESCRICAO")
			auxAG_USERNAME = objRS("AG_USERNAME")
			auxAG_DATAINICIO = objRS("AG_DATAINICIO")
			auxAG_DATATERMINO = objRS("AG_DATATERMINO")
			auxAG_DATAINICIO_F = objRS("AG_DATAINICIO_F")
			auxAG_DATATERMINO_F = objRS("AG_DATATERMINO_F")
			auxRT = objRS("AG_RESPONSAVEL")
			auxTEC = objRS("TEC_NOME")
			if IsNull(auxTEC) then auxTEC = ""
			iPrioridade = IIf(IsNull(objRS("AG_PRIORIDADE")), "", objRS("AG_PRIORIDADE"))
			aux_AgNumero = objRS("AG_NUMERO")

			if (auxAG_DATATERMINO < date() or (auxsituacao="Agendado" and auxAG_DATAINICIO < date())) then
				auxbgcolor="Vermelho1Bg"
			else
				auxbgcolor="Padrao"
			end if

			if TemArquivo(Env.oConn, objRS("AG_NUMERO"))  then auxbarq=1 else auxbarq=0
			if not IsNull(objRS("AG_TITULO")) then auxAG_OBJETIVO = objRS("AG_TITULO") else auxAG_OBJETIVO = objRS("AG_OBJETIVO")

			objRS.MoveNext

			if not objRS.eof then
				anterior = atual
				atual = objRS("AG_NUMERO")
			else
				if anterior <> atual then anterior = atual
				atual = 0
			end if

			conta = 0
			if not ((atual = anterior) or (objRS.eof and (atual <> 0))) Then
				conta = conta + 1

				if auxSITUACAO <> AUXSITUACAOCHG Then

					if AUXSITUACAOCHG <> "" Then
%>
		<tr bgcolor="#ffffff"> 
			<td align="RIGHT" class="texto_tabela" COLSPAN="5"><br>
				<B>total: <%=cont%></B>
			</td>
		</tr>
<%
						cont=0
					end if%>

		<tr bgcolor="#ffffff"> 
			<td align="LEFT" class="texto_tabela" COLSPAN="5"><br>
			<B>Agendamentos Situação: <%=AUXSITUACAO%></B>
			</td>
		</tr>
<%
					AUXSITUACAOCHG=auxSITUACAO 
				end if%>

		<tr class="<%=auxbgcolor%>" valign="top">
			<td width="40px" align="center">
				<b>
<%
	cont=cont+1

	'### Se for usuario de fora do CRT apenas coloco o numero da AS
	'if MostraDadoSigiloso(aux_SIGILO, auxAG_USERNAME) Then%>
				<a title="Clique aqui para ver os dados desta AS" class="texto_tabela" href="javascript: chama_as(<%=anterior%>, 0);"><%=anterior%></a>
<%
	'else
	'				Response.Write anterior
	'end if
%>
				</b>
			</td>

			<td><%=MostraPrioridade(iPrioridade, aux_AgNumero)%></td>

			<td width="*" align="justify">
<%		If aux_SIGILO > 0 Then %>
				<img align="absmiddle" src="img/Iccadeado.gif" border=0>&nbsp;&nbsp;
<%		end if %>
<%		if auxbarq then %>
				<img src="img/icnote.gif" title="Este agendamento possui arquivo(s) anexo(s)">&nbsp;&nbsp;
<%		end if %>

<%	'If Not MostraDadoSigiloso(aux_SIGILO, auxAG_USERNAME) Then 
	'	Response.Write "ACESSO RESTRITO (SIGILOSO)"
	'else
		if auxTEC <> "" then response.write auxTEC & "&nbsp;-&nbsp;"
		if aux_Atividade <> "" then response.write aux_Atividade & "&nbsp;-&nbsp;"
		if auxAG_OBJETIVO <> "" then response.write auxAG_OBJETIVO & "&nbsp;-&nbsp;"
		if aux_DescSigilo <> "" then response.write aux_DescSigilo %>
			<br><b> Solicitante: <%=Ucase(auxAG_USERNAME)%> - RT: <%=Ucase(auxRT)%></b>
<%	'End If%>
			</td>

			<td width="140px" align="center">
				<span font-size: 9px;"><%=auxAG_DATAINICIO_F%>-<%=auxAG_DATATERMINO_F%>
				<br><span style="color:#600000; font-size: 9px;">(<%=auxsituacao%>)</span></span>
			</td>

			<td width="120px"><span style="font-size: 9px;"><%=AmbienteAS(Env.oConn, anterior, ", ")%>&nbsp;</span></td>

			<td align="center">
<%			If MostraDadoSigiloso(aux_SIGILO, auxAG_USERNAME) Then %>
				<a class="texto_tabela" href="javascript: chama_as(<%=anterior%>, 1);" title="Clique aqui para editar esta AS"><img src="img/edit.gif" border="0"></a>
<%			Else%>
				&nbsp;
<%		End If%>		
			</td>
        </tr>
<%		'AuxAG_OBJETIVO = testeAtual
			end if

			response.flush
		wend
	end if
	conta = objRS.RecordCount
	Call Env.RecordSet( false, objRS, s)
%>

        <tr bgcolor="#ffffff"> 
          <td align="RIGHT" COLSPAN="4"><br>
		<B>total: <%=cont%></B>
<%cont=0%>
	  </TD>
	</tr>

        </tbody> 
      </table>
<%
End Sub

'######################################################################################################
Sub MontaVisaoPorSalas
'###
	Dim	auxAG_OBJETIVO, auxsituacao, auxAG_USERNAME, auxRT, auxSala, auxSalaOld, iPrioridade, aux_AgNumero
	Dim auxAG_DATAINICIO, auxAG_DATATERMINO, anterior, atual, aux_DescSigilo, auxTEC
	Dim aux_Sigilo, auxbarq, auxbgcolor, AUXSITUACAOCHG, aux_Atividade
	Dim bln_Primeira : bln_Primeira = True
%>
      <table border="0" width="100%" cellspacing="3" cellpadding="4" class="texto_tabela" align="center" class="tabela1">
        <tr>
          <th>AS</th>
		  <th>Prioridade</th>
          <th>Atividade</th>
          <th>Data solicitada<br>in&iacute;cio-t&eacute;rmino</th>
		  <th>Salas</th>
          <th>&nbsp;</th>
        </tr>
<%
	s = "SELECT ab.AMB_NOME, a.*, CONVERT(VARCHAR, AG_DATAINICIO, 103) AS AG_DATAINICIO_F, CONVERT(VARCHAR, AG_DATATERMINO, 103) AS AG_DATATERMINO_F " & _
		"FROM vw_Agendamento a " & _
		"LEFT JOIN Reserva_Ambientes ra ON ra.RAM_AS = a.AG_NUMERO " & _
		"LEFT JOIN Ambientes ab ON ra.AMB_ID = ab.AMB_ID " & _
		"WHERE a.ID_SITUACAO in "

	if request("hoje") = "1" then
		s = s & "(3, 6, 7) AND (a.AG_DATAINICIO < getDate()) "
	else
		s = s & "(1, 2, 3, 6, 7) "
	end if

	s = s & "ORDER BY ab.AMB_NOME ASC, a.ID_SITUACAO ASC, a.AG_NUMERO DESC"

'RW s & "<BR>"

	Call Env.RecordSet( true, objRS, s)
	if not (objRS.EOF and objRS.BOF) then
		atual = objRS("AG_NUMERO")
		auxSalaOld = ""

		'-- pego o titulo do agendamento, caso nao exista mostro o objetivo
		if not IsNull(objRS("AG_TITULO")) then auxAG_OBJETIVO = objRS("AG_TITULO") else auxAG_OBJETIVO = objRS("AG_OBJETIVO")

		while not objRS.EOF
			aux_Sigilo = objRS("AG_SIGILO")
			aux_Atividade = objRS("TA_DESCRICAO")
			aux_DescSigilo = objRS("TS_DESCRICAO")
			auxsituacao = objRS("S_DESCRICAO")
			auxAG_USERNAME = objRS("AG_USERNAME")
			auxAG_DATAINICIO = objRS("AG_DATAINICIO")
			auxAG_DATATERMINO = objRS("AG_DATATERMINO")
			auxAG_DATAINICIO_F = objRS("AG_DATAINICIO_F")
			auxAG_DATATERMINO_F = objRS("AG_DATATERMINO_F")
			auxRT = objRS("AG_RESPONSAVEL")
			auxTEC = objRS("TEC_NOME")
			auxSala = objRS("AMB_NOME")
			iPrioridade = IIf(IsNull(objRS("AG_PRIORIDADE")), "", objRS("AG_PRIORIDADE"))
			aux_AgNumero = objRS("AG_NUMERO")

			if IsNull(auxSala) then auxSala = "Nenhum Ambiente Selecionado"
			if IsNull(auxTEC) then auxTEC = ""

			if (auxAG_DATATERMINO < date() or (auxsituacao="Agendado" and auxAG_DATAINICIO < date())) then
				auxbgcolor="Vermelho1Bg"
		   else
				auxbgcolor="Padrao"
			end if

			if TemArquivo(Env.oConn, objRS("AG_NUMERO"))  then auxbarq=1 else auxbarq=0
			if not IsNull(objRS("AG_TITULO")) then auxAG_OBJETIVO = objRS("AG_TITULO") else auxAG_OBJETIVO = objRS("AG_OBJETIVO")

			objRS.MoveNext

			if not objRS.eof then 
				anterior = atual
				atual = objRS("AG_NUMERO")
			else
				if anterior <> atual then anterior = atual
				atual = 0
			end if

			conta = 0
			if not ((atual = anterior) or (objRS.eof and (atual <> 0))) Then
				conta = conta + 1

	if (auxSala <> auxSalaOld) Then

		if auxSalaOld <> "" Then
%>
		<tr bgcolor="#ffffff"> 
			<td align="RIGHT" class="texto_tabela" COLSPAN="5"><br>
				<B>total: <%=cont%></B>
			</td>
		</tr>
<%
			cont=0
		end if%>

		<tr bgcolor="#ffffff"> 
			<td align="LEFT" class="texto_tabela" COLSPAN="5"><br>
			<B>Sala: <%=auxSala%></B>
			</td>
		</tr>
<%
		auxSalaOld = auxSala
	end if %>

		<tr class="<%=auxbgcolor%>" valign="top">
			<td width="40px" align="center">
				<b>
<%
	cont=cont+1

	'### Se for usuario de fora do CRT apenas coloco o numero da AS
	'if MostraDadoSigiloso(aux_SIGILO, auxAG_USERNAME) Then%>
				<a title="Clique aqui para ver os dados desta AS" class="texto_tabela" href="javascript: chama_as(<%=anterior%>, 0);"><%=anterior%></a>
<%
	'else
	'				Response.Write anterior
	'end if
%>
				</b>
			</td>

			<td><%=MostraPrioridade(iPrioridade, aux_AgNumero)%></td>

			<td width="*" align="justify">
<%		If aux_SIGILO > 0 Then %>
				<img align="absmiddle" src="img/Iccadeado.gif" border=0>&nbsp;&nbsp;
<%		end if %>
<%		if auxbarq then %>
				<img src="img/icnote.gif" title="Este agendamento possui arquivo(s) anexo(s)">&nbsp;&nbsp;
<%		end if %>

<%	'If Not MostraDadoSigiloso(aux_SIGILO, auxAG_USERNAME) Then 
	'	Response.Write "ACESSO RESTRITO (SIGILOSO)"
	'else
		if auxTEC <> "" then response.write auxTEC & "&nbsp;-&nbsp;"
		if aux_Atividade <> "" then response.write aux_Atividade & "&nbsp;-&nbsp;"
		if auxAG_OBJETIVO <> "" then response.write auxAG_OBJETIVO & "&nbsp;-&nbsp;"
		if aux_DescSigilo <> "" then response.write aux_DescSigilo %>
			<br><b> Solicitante: <%=Ucase(auxAG_USERNAME)%> - RT: <%=Ucase(auxRT)%></b>
<%	'End If%>
			</td>

			<td width="140px" align="center">
				<span font-size: 9px;"><%=auxAG_DATAINICIO_F%>-<%=auxAG_DATATERMINO_F%>
				<br><span style="color:#600000; font-size: 9px;">(<%=auxsituacao%>)</span></span>
			</td>

			<td width="120px"><span style="font-size: 9px;"><%=AmbienteAS(Env.oConn, anterior, ", ")%>&nbsp;</span></td>

			<td align="center">
<%			If MostraDadoSigiloso(aux_SIGILO, auxAG_USERNAME) Then %>
				<a class="texto_tabela" href="javascript: chama_as(<%=anterior%>, 1);" title="Clique aqui para editar esta AS"><img src="img/edit.gif" border="0"></a>
<%			Else%>
				&nbsp;
<%		End If%>		
			</td>
        </tr>
<%		'AuxAG_OBJETIVO = testeAtual
			end if

			response.flush
		wend
	end if
	conta = objRS.RecordCount
	Call Env.RecordSet( false, objRS, s)
%>

        <tr bgcolor="#ffffff"> 
          <td align="RIGHT" COLSPAN="4"><br>
		<B>total: <%=cont%></B>
<%cont=0%>
	  </TD>
	</tr>

        </tbody> 
      </table>
<%
End Sub


'######################################################################################################
Sub MontaVisaoPorPrioridade
'###
	Dim	auxAG_OBJETIVO, auxsituacao, auxAG_USERNAME, auxRT, auxSala, auxSalaOld
	Dim auxAG_DATAINICIO, auxAG_DATATERMINO, anterior, atual, aux_DescSigilo, auxTEC, aux_AgNumero
	Dim aux_Sigilo, auxbarq, auxbgcolor, AUXSITUACAOCHG, aux_Atividade, iPrioridade, iPrioridadeOld
	Dim bln_Primeira : bln_Primeira = True
%>
      <table border="0" width="100%" cellspacing="3" cellpadding="4" class="texto_tabela" align="center" class="tabela1">
        <tr>
          <th>AS</th>
<%	If EhRat Then %>
		  <th>Prioridade</th>
<%	End If %>
          <th>Atividade</th>
          <th>Data solicitada<br>in&iacute;cio-t&eacute;rmino</th>
		  <th>Salas</th>
          <th>&nbsp;</th>
        </tr>
<%
	s = "SELECT ab.AMB_NOME, a.*, CONVERT(VARCHAR, AG_DATAINICIO, 103) AS AG_DATAINICIO_F, CONVERT(VARCHAR, AG_DATATERMINO, 103) AS AG_DATATERMINO_F " & _
		"FROM vw_Agendamento a " & _
		"LEFT JOIN Reserva_Ambientes ra ON ra.RAM_AS = a.AG_NUMERO " & _
		"LEFT JOIN Ambientes ab ON ra.AMB_ID = ab.AMB_ID " & _
		"WHERE a.ID_SITUACAO in "

	if request("hoje") = "1" then
		s = s & "(3, 6, 7) AND (a.AG_DATAINICIO < getDate()) "
	else
		s = s & "(1, 2, 3, 6, 7) "
	end if

	s = s & "ORDER BY ISNULL(AG_PRIORIDADE, 99), a.ID_SITUACAO ASC, a.AG_NUMERO DESC"

'RW s & "<BR>"

	Call Env.RecordSet( true, objRS, s)
	if not (objRS.EOF and objRS.BOF) then
		atual = objRS("AG_NUMERO")
		auxSalaOld = ""

		'-- pego o titulo do agendamento, caso nao exista mostro o objetivo
		if not IsNull(objRS("AG_TITULO")) then auxAG_OBJETIVO = objRS("AG_TITULO") else auxAG_OBJETIVO = objRS("AG_OBJETIVO")

		while not objRS.EOF
			aux_AgNumero = objRS("AG_NUMERO")
			aux_Sigilo = objRS("AG_SIGILO")
			aux_Atividade = objRS("TA_DESCRICAO")
			aux_DescSigilo = objRS("TS_DESCRICAO")
			auxsituacao = objRS("S_DESCRICAO")
			auxAG_USERNAME = objRS("AG_USERNAME")
			auxAG_DATAINICIO = objRS("AG_DATAINICIO")
			auxAG_DATATERMINO = objRS("AG_DATATERMINO")
			auxAG_DATAINICIO_F = objRS("AG_DATAINICIO_F")
			auxAG_DATATERMINO_F = objRS("AG_DATATERMINO_F")
			auxRT = objRS("AG_RESPONSAVEL")
			auxTEC = objRS("TEC_NOME")
			auxSala = objRS("AMB_NOME")
			iPrioridade = IIf(IsNull(objRS("AG_PRIORIDADE")), "", objRS("AG_PRIORIDADE"))

			if IsNull(auxSala) then auxSala = "Nenhum Ambiente Selecionado"
			if IsNull(auxTEC) then auxTEC = ""

			if (auxAG_DATATERMINO < date() or (auxsituacao="Agendado" and auxAG_DATAINICIO < date())) then
				auxbgcolor="Vermelho1Bg"
		   else
				auxbgcolor="Padrao"
			end if

			if TemArquivo(Env.oConn, objRS("AG_NUMERO"))  then auxbarq=1 else auxbarq=0
			if not IsNull(objRS("AG_TITULO")) then auxAG_OBJETIVO = objRS("AG_TITULO") else auxAG_OBJETIVO = objRS("AG_OBJETIVO")

			objRS.MoveNext

			if not objRS.eof then 
				anterior = atual
				atual = objRS("AG_NUMERO")
			else
				if anterior <> atual then anterior = atual
				atual = 0
			end if

			conta = 0
			if not ((atual = anterior) or (objRS.eof and (atual <> 0))) Then
				conta = conta + 1

	if (iPrioridade <> iPrioridadeOld) Then

		if iPrioridadeOld <> "" Then
%>
		<tr bgcolor="#ffffff"> 
			<td align="RIGHT" class="texto_tabela" COLSPAN="5"><br>
				<B>total: <%=cont%></B>
			</td>
		</tr>
<%
			cont=0
		end if%>

		<tr bgcolor="#ffffff"> 
			<td align="LEFT" class="texto_tabela" COLSPAN="5"><br>
			<B>Prioridade: <%=MostraPrioridade(iPrioridade, "")%></B>
			</td>
		</tr>
<%
		iPrioridadeOld = iPrioridade
	end if %>

		<tr class="<%=auxbgcolor%>" valign="top">
			<td width="40px" align="center">
				<b>
<%
	cont=cont+1

	'### Se for usuario de fora do CRT apenas coloco o numero da AS
	'if MostraDadoSigiloso(aux_SIGILO, auxAG_USERNAME) Then%>
				<a title="Clique aqui para ver os dados desta AS" class="texto_tabela" href="javascript: chama_as(<%=anterior%>, 0);"><%=anterior%></a>
<%
	'else
	'				Response.Write anterior
	'end if
%>
				</b>
			</td>

<%	If EhRat Then %>
			<td><%=MostraPrioridade(iPrioridade, aux_AgNumero)%></td>
<%	End If %>

			<td width="*" align="justify">
<%		If aux_SIGILO > 0 Then %>
				<img align="absmiddle" src="img/Iccadeado.gif" border=0>&nbsp;&nbsp;
<%		end if %>
<%		if auxbarq then %>
				<img src="img/icnote.gif" title="Este agendamento possui arquivo(s) anexo(s)">&nbsp;&nbsp;
<%		end if %>

<%	'If Not MostraDadoSigiloso(aux_SIGILO, auxAG_USERNAME) Then 
	'	Response.Write "ACESSO RESTRITO (SIGILOSO)"
	'else
		if auxTEC <> "" then response.write auxTEC & "&nbsp;-&nbsp;"
		if aux_Atividade <> "" then response.write aux_Atividade & "&nbsp;-&nbsp;"
		if auxAG_OBJETIVO <> "" then response.write auxAG_OBJETIVO & "&nbsp;-&nbsp;"
		if aux_DescSigilo <> "" then response.write aux_DescSigilo %>
			<br><b> Solicitante: <%=Ucase(auxAG_USERNAME)%> - RT: <%=Ucase(auxRT)%></b>
<%	'End If%>
			</td>

			<td width="140px" align="center">
				<span font-size: 9px;"><%=auxAG_DATAINICIO_F%>-<%=auxAG_DATATERMINO_F%>
				<br><span style="color:#600000; font-size: 9px;">(<%=auxsituacao%>)</span></span>
			</td>

			<td width="120px"><span style="font-size: 9px;"><%=AmbienteAS(Env.oConn, anterior, ", ")%>&nbsp;</span></td>

			<td align="center">
<%			If MostraDadoSigiloso(aux_SIGILO, auxAG_USERNAME) Then %>
				<a class="texto_tabela" href="javascript: chama_as(<%=anterior%>, 1);" title="Clique aqui para editar esta AS"><img src="img/edit.gif" border="0"></a>
<%			Else%>
				&nbsp;
<%		End If%>		
			</td>
        </tr>
<%		'AuxAG_OBJETIVO = testeAtual
			end if

			response.flush
		wend
	end if
	conta = objRS.RecordCount
	Call Env.RecordSet( false, objRS, s)
%>

        <tr bgcolor="#ffffff"> 
          <td align="RIGHT" COLSPAN="4"><br>
		<B>total: <%=cont%></B>
<%cont=0%>
	  </TD>
	</tr>

        </tbody> 
      </table>
<%
End Sub


'######################################################################################################
Sub MontaVisaoPorDataTermino
'###
	Dim	auxAG_OBJETIVO, auxsituacao, auxAG_USERNAME, auxRT, iPrioridade, aux_AgNumero
	Dim auxAG_DATAINICIO, auxAG_DATATERMINO, anterior, atual, aux_DescSigilo, auxTEC
	Dim aux_Sigilo, auxbarq, auxbgcolor, AUXSITUACAOCHG, aux_Atividade
	Dim auxMesAnoOld : auxMesAnoOld = CDate("01/01/1980")
%>
      <table border="0" width="100%" cellspacing="3" cellpadding="4" class="texto_tabela" align="center" class="tabela1">
        <tr>
          <th>AS</th>
		  <th>Prioridade</th>
          <th>Atividade</th>
          <th>Data solicitada<br>in&iacute;cio-t&eacute;rmino</th>
		  <th>Salas</th>
          <th>&nbsp;</th>
        </tr>
<%
	s = "SELECT a.*, CONVERT(VARCHAR, AG_DATAINICIO, 103) AS AG_DATAINICIO_F, CONVERT(VARCHAR, AG_DATATERMINO, 103) AS AG_DATATERMINO_F " & _
		"FROM vw_Agendamento a " & _
		"WHERE a.ID_SITUACAO in "

	if request("hoje") = "1" then
		s = s & "(3, 6, 7) AND (a.AG_DATAINICIO < getDate()) "
	else
		s = s & "(1, 2, 3, 6, 7) "
	end if

	s = s & "ORDER BY a.AG_DATATERMINO ASC, a.AG_NUMERO DESC"

'RW s & "<BR>"

	Call Env.RecordSet( true, objRS, s)
	if not (objRS.EOF and objRS.BOF) then
		atual = objRS("AG_NUMERO")

		'-- pego o titulo do agendamento, caso nao exista mostro o objetivo
		if not IsNull(objRS("AG_TITULO")) then auxAG_OBJETIVO = objRS("AG_TITULO") else auxAG_OBJETIVO = objRS("AG_OBJETIVO")

		while not objRS.EOF
			aux_Sigilo = objRS("AG_SIGILO")
			aux_Atividade = objRS("TA_DESCRICAO")
			aux_DescSigilo = objRS("TS_DESCRICAO")
			auxsituacao = objRS("S_DESCRICAO")
			auxAG_USERNAME = objRS("AG_USERNAME")
			auxAG_DATAINICIO = objRS("AG_DATAINICIO")
			auxAG_DATATERMINO = objRS("AG_DATATERMINO")
			auxAG_DATAINICIO_F = objRS("AG_DATAINICIO_F")
			auxAG_DATATERMINO_F = objRS("AG_DATATERMINO_F")
			auxRT = objRS("AG_RESPONSAVEL")
			auxTEC = objRS("TEC_NOME")
			iPrioridade = IIf(IsNull(objRS("AG_PRIORIDADE")), "", objRS("AG_PRIORIDADE"))
			aux_AgNumero = objRS("AG_NUMERO")

			if IsNull(auxSala) then auxSala = ""
			if IsNull(auxTEC) then auxTEC = ""

			if (auxAG_DATATERMINO < date() or (auxsituacao="Agendado" and auxAG_DATAINICIO < date())) then
				auxbgcolor="Vermelho1Bg"
		   else
				auxbgcolor="Padrao"
			end if

			if TemArquivo(Env.oConn, objRS("AG_NUMERO"))  then auxbarq=1 else auxbarq=0
			if not IsNull(objRS("AG_TITULO")) then auxAG_OBJETIVO = objRS("AG_TITULO") else auxAG_OBJETIVO = objRS("AG_OBJETIVO")

			objRS.MoveNext

			if not objRS.eof then 
				anterior = atual
				atual = objRS("AG_NUMERO")
			else
				if anterior <> atual then anterior = atual
				atual = 0
			end if

			conta = 0
			if not ((atual = anterior) or (objRS.eof and (atual <> 0))) Then
				conta = conta + 1

	If (Month(auxAG_DATATERMINO) <> Month(auxMesAnoOld)) Or (Year(auxAG_DATATERMINO) <> Year(auxMesAnoOld)) Then

		If auxMesAnoOld <> CDate("01/01/1980") Then
%>
		<tr bgcolor="#ffffff"> 
			<td align="RIGHT" class="texto_tabela" COLSPAN="5"><br>
				<B>total: <%=cont%></B>
			</td>
		</tr>
<%
			cont=0
		end if%>

		<tr bgcolor="#ffffff"> 
			<td align="LEFT" class="texto_tabela" COLSPAN="5"><br>
			<B>Término: <%=IIf(IsNull(auxAG_DATATERMINO), "", Right("0"&Month(auxAG_DATATERMINO),2) & "/" & Year(auxAG_DATATERMINO))%></B>
			</td>
		</tr>
<%
		auxMesAnoOld = auxAG_DATATERMINO
	End If %>

		<tr class="<%=auxbgcolor%>" valign="top">
			<td width="40px" align="center">
				<b>
<%
	cont=cont+1

	'### Se for usuario de fora do CRT apenas coloco o numero da AS
	'if MostraDadoSigiloso(aux_SIGILO, auxAG_USERNAME) Then%>
				<a title="Clique aqui para ver os dados desta AS" class="texto_tabela" href="javascript: chama_as(<%=anterior%>, 0);"><%=anterior%></a>
<%
	'else
	'				Response.Write anterior
	'end if
%>
				</b>
			</td>

			<td><%=MostraPrioridade(iPrioridade, aux_AgNumero)%></td>

			<td width="*" align="justify">
<%		If aux_SIGILO > 0 Then %>
				<img align="absmiddle" src="img/Iccadeado.gif" border=0>&nbsp;&nbsp;
<%		end if %>
<%		if auxbarq then %>
				<img src="img/icnote.gif" title="Este agendamento possui arquivo(s) anexo(s)">&nbsp;&nbsp;
<%		end if %>

<%	'If Not MostraDadoSigiloso(aux_SIGILO, auxAG_USERNAME) Then 
	'	Response.Write "ACESSO RESTRITO (SIGILOSO)"
	'else
		if auxTEC <> "" then response.write auxTEC & "&nbsp;-&nbsp;"
		if aux_Atividade <> "" then response.write aux_Atividade & "&nbsp;-&nbsp;"
		if auxAG_OBJETIVO <> "" then response.write auxAG_OBJETIVO & "&nbsp;-&nbsp;"
		if aux_DescSigilo <> "" then response.write aux_DescSigilo %>
			<br><b> Solicitante: <%=Ucase(auxAG_USERNAME)%> - RT: <%=Ucase(auxRT)%></b>
<%	'End If%>
			</td>

			<td width="140px" align="center">
				<span font-size: 9px;"><%=auxAG_DATAINICIO_F%>-<%=auxAG_DATATERMINO_F%>
				<br><span style="color:#600000; font-size: 9px;">(<%=auxsituacao%>)</span></span>
			</td>

			<td width="120px"><span style="font-size: 9px;"><%=AmbienteAS(Env.oConn, anterior, ", ")%>&nbsp;</span></td>

			<td align="center">
<%			If MostraDadoSigiloso(aux_SIGILO, auxAG_USERNAME) Then %>
				<a class="texto_tabela" href="javascript: chama_as(<%=anterior%>, 1);" title="Clique aqui para editar esta AS"><img src="img/edit.gif" border="0"></a>
<%			Else%>
				&nbsp;
<%		End If%>		
			</td>
        </tr>
<%		'AuxAG_OBJETIVO = testeAtual
			end if

			response.flush
		wend
	end if
	conta = objRS.RecordCount
	Call Env.RecordSet( false, objRS, s)
%>

        <tr bgcolor="#ffffff"> 
          <td align="RIGHT" COLSPAN="4"><br>
		<B>total: <%=cont%></B>
<%cont=0%>
	  </TD>
	</tr>

        </tbody> 
      </table>
<%
End Sub


'###################################################################################################################3
Sub MontaVisaoPorRT
'###
	Dim	auxAG_OBJETIVO, auxsituacao, auxAG_USERNAME, auxRT, auxRTOld, auxRespTec, iPrioridade, aux_AgNumero
	Dim auxAG_DATAINICIO, auxAG_DATATERMINO, anterior, atual, aux_DescSigilo, auxTEC
	Dim aux_Sigilo, auxbarq, auxbgcolor, AUXSITUACAOCHG, aux_Atividade
%>
      <table border="0" width="100%" cellspacing="3" cellpadding="4" class="texto_tabela" align="center" class="tabela1">
        <tr>
          <th>AS</th>
		  <th>Prioridade</th>
          <th>Atividade</th>
          <th>Data solicitada<br>in&iacute;cio-t&eacute;rmino</th>
		  <th>Salas</th>
          <th>&nbsp;</th>
        </tr>
<%
	s = "SELECT a.*, CONVERT(VARCHAR, AG_DATAINICIO, 103) AS AG_DATAINICIO_F, CONVERT(VARCHAR, AG_DATATERMINO, 103) AS AG_DATATERMINO_F " & _
		"FROM vw_Agendamento a  " & _
		"WHERE a.ID_SITUACAO in "

	if request("hoje") = "1" then
		s = s & "(3, 6, 7) AND (a.AG_DATAINICIO < getDate()) "
	else
		s = s & "(1, 2, 3, 6, 7) "
	end if

	s = s & "ORDER BY a.AG_RESPONSAVEL ASC, a.ID_SITUACAO DESC, a.AG_NUMERO DESC"

	Call Env.RecordSet( true, objRS, s)
	if not (objRS.EOF and objRS.BOF) then
		atual = objRS("AG_NUMERO")

		'-- pego o titulo do agendamento, caso nao exista mostro o objetivo
		if not IsNull(objRS("AG_TITULO")) then auxAG_OBJETIVO = objRS("AG_TITULO") else auxAG_OBJETIVO = objRS("AG_OBJETIVO")

		while not objRS.EOF
			aux_Sigilo = objRS("AG_SIGILO")
			aux_Atividade = objRS("TA_DESCRICAO")
			aux_DescSigilo = objRS("TS_DESCRICAO")
			auxsituacao = objRS("S_DESCRICAO")
			auxAG_USERNAME = objRS("AG_USERNAME")
			auxAG_DATAINICIO = objRS("AG_DATAINICIO")
			auxAG_DATATERMINO = objRS("AG_DATATERMINO")
			auxAG_DATAINICIO_F = objRS("AG_DATAINICIO_F")
			auxAG_DATATERMINO_F = objRS("AG_DATATERMINO_F")
			auxRT = objRS("AG_RESPONSAVEL")
			auxTEC = objRS("TEC_NOME")
			iPrioridade = IIf(IsNull(objRS("AG_PRIORIDADE")), "", objRS("AG_PRIORIDADE"))
			aux_AgNumero = objRS("AG_NUMERO")

			if IsNull(auxRT) then auxRT = ""
			auxRespTec = IIf(VVVN(objRS("AG_RESPONSAVEL")), "Nenhum RT definido", objRS("AG_RESPONSAVEL"))
			if IsNull(auxTEC) then auxTEC = ""

			if (auxAG_DATATERMINO < date() or (auxsituacao="Agendado" and auxAG_DATAINICIO < date())) then
				auxbgcolor="Vermelho1Bg"
			else
				auxbgcolor="Padrao"
			end if

			if TemArquivo(Env.oConn, objRS("AG_NUMERO"))  then auxbarq=1 else auxbarq=0
			if not IsNull(objRS("AG_TITULO")) then auxAG_OBJETIVO = objRS("AG_TITULO") else auxAG_OBJETIVO = objRS("AG_OBJETIVO")

			objRS.MoveNext

			if not objRS.eof then
				anterior = atual
				atual = objRS("AG_NUMERO")
			else
				if anterior <> atual then anterior = atual
				atual = 0
			end if

			conta = 0
			if not ((atual = anterior) or (objRS.eof and (atual <> 0))) Then
				conta = conta + 1

				if auxRespTec <> auxRTOld Then

					if auxRTOld <> "" Then
%>
		<tr bgcolor="#ffffff"> 
			<td align="RIGHT" class="texto_tabela" COLSPAN="5"><br>
				<B>total: <%=cont%></B>
			</td>
		</tr>
<%
						cont=0
					end if%>

		<tr bgcolor="#ffffff"> 
			<td align="LEFT" class="texto_tabela" COLSPAN="5"><br>
			<B>Responsável Técnico: <%=auxRespTec%></B>
			</td>
		</tr>
<%
					auxRTOld = auxRespTec
				end if%>

		<tr class="<%=auxbgcolor%>" valign="top">
			<td width="40px" align="center">
				<b>
<%
	cont=cont+1

	'### Se for usuario de fora do CRT apenas coloco o numero da AS
	'if MostraDadoSigiloso(aux_SIGILO, auxAG_USERNAME) Then%>
				<a title="Clique aqui para ver os dados desta AS" class="texto_tabela" href="javascript: chama_as(<%=anterior%>, 0);"><%=anterior%></a>
<%
	'else
	'				Response.Write anterior
	'end if
%>
				</b>
			</td>

			<td><%=MostraPrioridade(iPrioridade, aux_AgNumero)%></td>

			<td width="*" align="justify">
<%		If aux_SIGILO > 0 Then %>
				<img align="absmiddle" src="img/Iccadeado.gif" border=0>&nbsp;&nbsp;
<%		end if %>
<%		if auxbarq then %>
				<img src="img/icnote.gif" title="Este agendamento possui arquivo(s) anexo(s)">&nbsp;&nbsp;
<%		end if %>

<%	'If Not MostraDadoSigiloso(aux_SIGILO, auxAG_USERNAME) Then 
	'	Response.Write "ACESSO RESTRITO (SIGILOSO)"
	'else
		if auxTEC <> "" then response.write auxTEC & "&nbsp;-&nbsp;"
		if aux_Atividade <> "" then response.write aux_Atividade & "&nbsp;-&nbsp;"
		if auxAG_OBJETIVO <> "" then response.write auxAG_OBJETIVO & "&nbsp;-&nbsp;"
		if aux_DescSigilo <> "" then response.write aux_DescSigilo %>
			<br><b> Solicitante: <%=Ucase(auxAG_USERNAME)%> - RT: <%=Ucase(auxRT)%></b>
<%	'End If%>
			</td>

			<td width="140px" align="center">
				<span font-size: 9px;"><%=auxAG_DATAINICIO_F%>-<%=auxAG_DATATERMINO_F%>
				<br><span style="color:#600000; font-size: 9px;">(<%=auxsituacao%>)</span></span>
			</td>

			<td width="120px"><span style="font-size: 9px;"><%=AmbienteAS(Env.oConn, anterior, ", ")%>&nbsp;</span></td>

			<td align="center">
<%			If MostraDadoSigiloso(aux_SIGILO, auxAG_USERNAME) Then %>
				<a class="texto_tabela" href="javascript: chama_as(<%=anterior%>, 1);" title="Clique aqui para editar esta AS"><img src="img/edit.gif" border="0"></a>
<%			Else%>
				&nbsp;
<%		End If%>		
			</td>
        </tr>
<%		'AuxAG_OBJETIVO = testeAtual
			end if

			response.flush
		wend
	end if
	conta = objRS.RecordCount
	Call Env.RecordSet( false, objRS, s)
%>

        <tr bgcolor="#ffffff"> 
          <td align="RIGHT" COLSPAN="4"><br>
		<B>total: <%=cont%></B>
<%cont=0%>
	  </TD>
	</tr>

        </tbody> 
      </table>
<%
End Sub

'#########################################################################################################
Function MostraPrioridade(valor, agnumero)
	Dim Val

	If IsNull(valor) Then
		Val = ""
	Else
		Val = CStr(valor)
	End If

	If EhRat And Not VVVNZ(agnumero) Then
		MostraPrioridade = _
			"<select name='idPrioridade' class='texto' style='width: 60px;' onChange='javascript:return trocaPrioridade(" & agnumero& ", this.value);'>" & VbCrLf & _
			"<option value='1'" & IIf(Val = "1", "selected", "") & ">Alta</option>" & VbCrLf & _
			"<option value='2'" & IIf(Val = "2", "selected", "") & ">Média</option>" & VbCrLf & _
			"<option value='3'" & IIf(Val = "3", "selected", "") & ">Baixa</option>" & VbCrLf & _
			"<option value=''" & IIf(Val = "", "selected", "") & ">N/A</option>" & VbCrLf & _
			"</select>" & VbCrLf
	Else
		Select Case Val
		Case "1"
			MostraPrioridade = "Alta"
		Case "2"
			MostraPrioridade = "Média"
		Case "3"
			MostraPrioridade = "Baixa"
		Case Else
			MostraPrioridade = "N/A"
		End Select
	End If
End Function
%>
