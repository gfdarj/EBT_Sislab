<!--#include file="includes/Sislab_Lib.asp"-->
<!--#include file="includes/PadraoHTML.asp" -->
<!--#include file="includes/global.asp" -->
<%
call imprimeCabecalho2(TITULO_SITE, MENU_ON, true, "", "Alteração de Datas", "location.href='sislab.asp'", "")

Dim numAS, frm, s, objRS

numAS = Request("num_as")
frm = UCase(Request.form("frm"))

if frm <> "" then
	response.write "<hr><span class='texto'>"

	set objRS = Server.CreateObject("ADODB.Command")
	objRS.ActiveConnection = Env.oConn

	'-- Form da tabela de agendamento
	if frm = "FRMAGENDAMENTO" then
		dim AG_DATASOLICITACAO, AG_DATAINICIO, AG_DATATERMINO

		AG_DATASOLICITACAO = Request("AG_DATASOLICITACAO")
		AG_DATAINICIO = Request("AG_DATAINICIO")
		AG_DATATERMINO = Request("AG_DATATERMINO")

		s = "Update agendamento set AG_DATASOLICITACAO = convert(smalldatetime, '" & AG_DATASOLICITACAO & "', 103), "
		s = s & "AG_DATAINICIO = convert(smalldatetime, '" & AG_DATAINICIO & "', 103), "
		s = s & "AG_DATATERMINO = convert(smalldatetime, '" & AG_DATATERMINO & "', 103) "
		s = s & "where AG_NUMERO = " & numAS
		objRS.CommandText = s

		on error resume next
		objRS.execute
		if err <> 0 then
			response.write "N�o foi poss&iacute;vel atualizar o Agendamento.<BR><BR>"
        	response.write "ERRO: " & Err.Source & "-->" & Err.Description & "<BR>"
		else
			response.write "Agendamento Atualizado !!!<BR><BR>"
		end if

	'-- Tabela de historico de datas
	elseif frm = "FRMHISTORICO_DATAS" then
		ID_TABELA = Request("ID_TABELA")

		if request("excluir") = "1" then
			s = "DELETE FROM Historico_Datas WHERE HD_MARCACAO = " & ID_TABELA
		else
			dim ID_TABELA, HD_DATAINICIO, HD_DATATERMINO, HD_MOTIVO

			HD_DATAINICIO = Request("HD_DATAINICIO")
			HD_DATATERMINO = Request("HD_DATATERMINO")
			HD_MOTIVO = Trim(Request("HD_MOTIVO"))
			if HD_MOTIVO = "" then HD_MOTIVO = "NULL" else HD_MOTIVO = "'" & HD_MOTIVO & "'"

			s = "Update Historico_Datas set "
			s = s & "HD_DATAINICIO = convert(smalldatetime, '" & HD_DATAINICIO & "', 103), "
			s = s & "HD_DATATERMINO = convert(smalldatetime, '" & HD_DATATERMINO & "', 103), "
			s = s & "HD_MOTIVO = " & HD_MOTIVO & " "
			s = s & "where AG_NUMERO = " & numAS & " and HD_MARCACAO = " & ID_TABELA
		end if

		objRS.CommandText = s
		on error resume next
		objRS.execute
		if err <> 0 then
			response.write "Não foi poss&iacute;vel atualizar o Hist&oacute;rico de Datas.<BR><BR>"
        	response.write "ERRO: " & Err.Source & "-->" & Err.Description & "<BR><BR>"
		else
			response.write "Hist&oacute;rico de Datas atualizado !!!<BR><BR>"
		end if

	'-- Tabela de historico de eventos
	elseif frm = "FRMHISTORICO_EVENTOS" then
		ID_TABELA = Request("ID_TABELA")

		if request("excluir") = "1" then
			s = "DELETE FROM Historico_Eventos WHERE HE_ID = " & ID_TABELA
		else
			dim HE_DATAINICIO, HE_DATATERMINO, MOTIVO

			HE_DATAINICIO = Trim(Request("HE_DATAINICIO"))
			HE_DATATERMINO = Trim(Request("HE_DATATERMINO"))
			MOTIVO = Trim(Request("HE_MOTIVO"))
			if HE_DATATERMINO = "" then HE_DATATERMINO = "NULL" else HE_DATATERMINO = "convert(smalldatetime, '" & HE_DATATERMINO & "', 103)"
			if MOTIVO = "" then MOTIVO = "NULL" else MOTIVO = "'" & MOTIVO & "'"

			s = "Update Historico_Eventos set "
			s = s & "HE_DATAINICIO = convert(smalldatetime, '" & HE_DATAINICIO & "', 103), "
			s = s & "HE_DATATERMINO = " & HE_DATATERMINO & ", "
			s = s & "HE_MOTIVO = " & MOTIVO & " "
			s = s & "where AG_NUMERO = " & numAS & " and HE_ID = " & ID_TABELA
		end if

		objRS.CommandText = s
		on error resume next
		objRS.execute
		if err <> 0 then
			response.write "N�o foi poss&iacute;vel atualizar o Hist&oacute;rico de Eventos.<BR><BR>"
        	response.write "ERRO: " & Err.Source & "-->" & Err.Description & "<BR><BR>"
		else
			response.write "Hist&oacute;rico de Eventos atualizado !!!<BR><BR>"
		end if

	elseif frm = "FRMHISTORICO_EVENTOSOS" then
		ID_TABELA = Request("ID_TABELA")

		if request("excluir") = "1" then
			s = "DELETE FROM Historico_EventosOS WHERE HEOS_ID = " & ID_TABELA
		else
			dim HEOS_DATAINICIO, HEOS_DATATERMINO, HEOS_MOTIVO

			HEOS_DATAINICIO = Trim(Request("HEOS_DATAINICIO"))
			HEOS_DATATERMINO = Trim(Request("HEOS_DATATERMINO"))
			HEOS_MOTIVO = Trim(Request("HEOS_MOTIVO"))
			if HEOS_DATATERMINO = "" then HEOS_DATATERMINO = "NULL" else HEOS_DATATERMINO = "convert(smalldatetime, '" & HEOS_DATATERMINO & "', 103)"
			if HEOS_MOTIVO = "" then HEOS_MOTIVO = "NULL" else HEOS_MOTIVO = "'" & HEOS_MOTIVO & "'"

			s = "Update Historico_EventosOS set "
			s = s & "HEOS_DATAINICIO = convert(smalldatetime, '" & HEOS_DATAINICIO & "', 103), "
			s = s & "HEOS_DATATERMINO = " & HEOS_DATATERMINO & ", "
			s = s & "HEOS_MOTIVO = " & HEOS_MOTIVO & " "
			s = s & "where AG_NUMERO = " & numAS & " and HEOS_ID = " & ID_TABELA
		end if

		objRS.CommandText = s
		on error resume next
		objRS.execute
		if err <> 0 then
			response.write "Não foi poss&iacute;vel atualizar o Hist&oacute;rico de Eventos da OS.<BR><BR>"
        	response.write "ERRO: " & Err.Source & "-->" & Err.Description & "<BR><BR>"
		else
			response.write "Hist&oacute;rico de Eventos da OS atualizado !!!<BR><BR>"
		end if
	end if

	response.write "<u>Comando SQL:</u> " & s & "<BR>"
	response.write "</span><hr>"
	set objRS = Nothing
end if

On Error Goto 0
%>
<form name="frmPesquisa" method="post">
<table class="tabela1">
<tr>
	<td>Entre com o n&uacute;mero da AS:</td>
	<td><input type="Text" name="num_as" size="6" value="<%=numAS%>" class="texto1"></td>
	<td><input type="Submit" name="btnPesquisar" value="Pesquisar" class="texto1"></td>
	<td><input type="Button" name="btnVoltar" value="Voltar" onClick="javascript:location.href='sislab.asp';" class="texto1"></td>
</tr>
</table>
</form>
<%
if numAS <> "" then%>
<hr>
<h3>Resultado da pesquisa</h3>

<form name="frmAgendamento" method="post">
<input type="hidden" name="num_as" value="<%=numAS%>">
<input type="hidden" name="frm" value="frmAgendamento">
<%	set objRS = Server.CreateObject("ADODB.RecordSet")
	s = "Select AG_DATASOLICITACAO, AG_DATAINICIO, AG_DATATERMINO "
	s = s & "from agendamento where AG_NUMERO = " & numAS & " "
	s = s & "order by AG_NUMERO"
	objRS.Open s, Env.oConn

	if objRS.Eof then
		Response.write "&nbsp;&nbsp;&nbsp;<b><i>Agendamento n�o encontrado.</i></b><BR>"
	else
		'--pego as datas da tabela agendamento%>
<script language="JavaScript">
function AtualizaAgendamento() {
	f = document.all.frmAgendamento;
	if(f.ag_datasolicitacao.value == "") {
		alert('Data da solicitação inválida.');
		f.ag_datasolicitacao.focus();
	}
	else if(f.ag_datainicio.value == "") {
		alert('Data de início inválida.');
		f.ag_datainicio.focus();
	}
	else if(f.ag_datatermino.value == "") {
		alert('Data de término inválida.');
		f.ag_datatermino.focus();
	}
	else
		f.submit();
}
</script>
<table width="100%" border="1" class="tabela1" cellpadding="2" cellspacing="0">
<tr><th align="left" colspan="4"><b>Agendamento <%=numAS%></b></th></tr>
<tr style="font-weight: bold;">
	<td>Data da Solicita&ccedil;&atilde;o</td>
	<td>Data de In&iacute;cio</td>
	<td>Data de T&eacute;rmino</td>
	<td>&nbsp;</td>
</tr>
<%		while not objRS.EOF%>
<tr>
	<td><input class="texto1" size="20" type="Text" value="<%=RetiraMiliSegundos(objRS("AG_DATASOLICITACAO"))%>" name="<%=lcase(objRS("AG_DATASOLICITACAO").Name)%>"></td>
	<td><input class="texto1" size="20" type="Text" value="<%=RetiraMiliSegundos(objRS("AG_DATAINICIO"))%>" name="<%=lcase(objRS("AG_DATAINICIO").Name)%>"></td>
	<td><input class="texto1" size="20" type="Text" value="<%=RetiraMiliSegundos(objRS("AG_DATATERMINO"))%>" name="<%=lcase(objRS("AG_DATATERMINO").Name)%>"></td>
	<td align="center"><input class="texto1" type="Button" value="Ok" onclick="javascript:AtualizaAgendamento();"></td>
</tr>
<%			objRS.MoveNext
		wend%>
</table>
</form><br>
<%		objRS.Close

		'-- Pego o hist�rico de datas
		s = "Select HD_MARCACAO, HD_DATAINICIO, HD_DATATERMINO, "
		s = s & "case when HD_FLAGREMARCADO = 0 then 'Não' "
		s = s & "when HD_FLAGREMARCADO = 1 then 'Sim' end "
		s = s & "as HD_FLAGREMARCADO, HD_MOTIVO "
		s = s & "from Historico_Datas where AG_NUMERO = " & numAS
		s = s & "order by AG_NUMERO, HD_MARCACAO"
		objRS.Open s, Env.oConn
		if not objRS.Eof then%>
<script language="JavaScript">
// Passo o ID da tabela por parametro para cada linha
function AtualizaHistorico_Datas(id_tabela, hd_datainicio, hd_datatermino, hd_motivo) {
	f = document.all.frmHistorico_Datas;
	if(hd_datainicio.value == "") {
		alert('Data de in�cio inv�lida.');
		hd_datainicio.focus();
	}
	else if(hd_datatermino.value == "") {
		alert('Data de t�rmino inv�lida.');
		hd_datatermino.focus();
	}
	else {
		// utilizo os campos escondidos para enviar a informacao
		f.id_tabela.value = id_tabela;
		f.hd_datainicio.value = hd_datainicio.value;
		f.hd_datatermino.value = hd_datatermino.value;
		f.hd_motivo.value = hd_motivo.value;
		f.submit();
	}
}
function ExcluiHistorico_Datas(id_tabela)	{
	if(confirm('ATEN��O !!!\n\n\nPara confirmar esta exclus�o clique em OK.'))
	{
		f = document.all.frmHistorico_Datas;
		f.excluir.value = '1';
		f.id_tabela.value = id_tabela;
		f.submit();
	}
}
</script>
<form name="frmHistorico_Datas" method="post">
<input type="hidden" name="num_as" value="<%=numAS%>">
<input type="hidden" name="frm" value="frmHistorico_Datas">
<input type="Hidden" name="id_tabela">
<input type="Hidden" name="hd_datainicio">
<input type="Hidden" name="hd_datatermino">
<input type="Hidden" name="hd_motivo">
<input type="Hidden" name="excluir" value="">
<table width="100%" border="1" class="tabela1" cellpadding="2" cellspacing="0">
<tr><th align="left" colspan="7"><b>Hist&oacute;rico de Datas (<%=numAS%>)</b></th></tr>
<tr style="font-weight: bold;">
	<td>ID</td>
	<td>Data de In&iacute;cio</td>
	<td>Data de T&eacute;rmino</td>
	<td>Atendido</td>
	<td>Motivo</td>
	<td>&nbsp;</td>
	<td>&nbsp;</td>
</tr>
<%			while not objRS.EOF%>
<tr>
	<td><%=objRS("HD_MARCACAO")%></td>
	<td><input class="texto1" size="20" type="Text" value="<%=RetiraMiliSegundos(objRS("HD_DATAINICIO"))%>" name="<%=lcase(objRS("HD_DATAINICIO").Name)&objRS("HD_MARCACAO")%>"></td>
	<td><input class="texto1" size="20" type="Text" value="<%=RetiraMiliSegundos(objRS("HD_DATATERMINO"))%>" name="<%=lcase(objRS("HD_DATATERMINO").Name)&objRS("HD_MARCACAO")%>"></td>
	<td align="center"><%=objRS("HD_FLAGREMARCADO")%></td>
	<td><textarea name="<%=lcase(objRS("HD_MOTIVO").Name)&objRS("HD_MARCACAO")%>" class="texto1" rows="3" cols="50"><%=objRS("HD_MOTIVO")%></textarea></td>
	<td><input class="texto1" type="Button" value="Ok" onclick="javascript:AtualizaHistorico_Datas(<%=objRS("HD_MARCACAO")%>, document.all.<%=lcase(objRS("HD_DATAINICIO").Name)&objRS("HD_MARCACAO")%>, document.all.<%=lcase(objRS("HD_DATATERMINO").Name)&objRS("HD_MARCACAO")%>, document.all.<%=lcase(objRS("HD_MOTIVO").Name)&objRS("HD_MARCACAO")%>);"></td>
	<td><input class="texto1" type="Button" value="Excluir" onclick="javascript:ExcluiHistorico_Datas(<%=objRS("HD_MARCACAO")%>);"></td>
</tr>
<%				objRS.MoveNext
			wend%>
</table>
</form><br>
<%		end if
		objRS.Close


		'-- Pego o hist�rico de eventos
		s = "Select HE_ID, sit.S_DESCRICAO, HE_DATAINICIO, HE_DATATERMINO, "
		s = s & "HE_MOTIVO from Historico_Eventos he inner join "
		s = s & "Situacoes sit on he.ID_SITUACAO = sit.ID_SITUACAO "
		s = s & "where AG_NUMERO = " & numAS & " "
		s = s & "order by AG_NUMERO, he.HE_DATAINICIO"
		's = s & "order by AG_NUMERO, he.HE_ID"
		objRS.Open s, Env.oConn
		if not objRS.Eof then%>
<script language="JavaScript">
// Passo o ID da tabela por parametro para cada linha
function AtualizaHistorico_Eventos(id_tabela, he_datainicio, he_datatermino, he_motivo) {
	f = document.all.frmHistorico_Eventos;
	if(he_datainicio.value == "") {
		alert('Data de in�cio inv�lida.');
		he_datainicio.focus();
	}
	else {
		// utilizo os campos escondidos para enviar a informacao
		f.id_tabela.value = id_tabela;
		f.he_datainicio.value = he_datainicio.value;
		f.he_datatermino.value = he_datatermino.value;
		f.he_motivo.value = he_motivo.value;
		f.submit();
	}
}
function ExcluiHistorico_Eventos(id_tabela)	{
	if(confirm('ATENÇÃO !!!\n\n\nPara confirmar esta exclusão clique em OK.'))
	{
		f = document.all.frmHistorico_Eventos;
		f.excluir.value = '1';
		f.id_tabela.value = id_tabela;
		f.submit();
	}
}
</script>
<form name="frmHistorico_Eventos" method="post">
<input type="hidden" name="num_as" value="<%=numAS%>">
<input type="hidden" name="frm" value="frmHistorico_Eventos">
<input type="Hidden" name="id_tabela">
<input type="Hidden" name="he_datainicio">
<input type="Hidden" name="he_datatermino">
<input type="Hidden" name="he_motivo">
<input type="Hidden" name="excluir" value="">
<table border="1" class="tabela1" width="100%" cellpadding="2" cellspacing="0">
<tr><th align="left" colspan="7"><b>Hist&oacute;rico de Eventos (<%=numAS%>)</b></th></tr>
<tr>
	<td colspan="7">
		<br><span style="font-weight: bold; color: red;">Atenção: A data de término não deverá estar preenchida caso o último evento não seja terminal (Por ex. finalizado, cancelado).</span><br><br>
	</td>
</tr>
<tr style="font-weight: bold;">
	<td>ID</td>
	<td>Data de In&iacute;cio</td>
	<td>Data de T&eacute;rmino</td>
	<td>Situa&ccedil;&atilde;o</td>
	<td>Motivo</td>
	<td>&nbsp;</td>
	<td>&nbsp;</td>
</tr>
<%			while not objRS.EOF%>
<tr>
	<td><%=objRS("HE_ID")%></td>
	<td><input class="texto1" size="20" type="Text" value="<%=RetiraMiliSegundos(objRS("HE_DATAINICIO"))%>" name="<%=lcase(objRS("HE_DATAINICIO").Name)&objRS("HE_ID")%>"></td>
	<td><input class="texto1" size="20" type="Text" value="<%=RetiraMiliSegundos(objRS("HE_DATATERMINO"))%>" name="<%=lcase(objRS("HE_DATATERMINO").Name)&objRS("HE_ID")%>"></td>
	<td><%=objRS("S_DESCRICAO")%></td>
	<td><textarea name="<%=lcase(objRS("HE_MOTIVO").Name)&objRS("HE_ID")%>" class="texto1" rows="3" cols="50"><%=objRS("HE_MOTIVO")%></textarea></td>
	<td align="center"><input class="texto1" type="Button" value="Ok" onclick="javascript:AtualizaHistorico_Eventos(<%=objRS("HE_ID")%>, document.all.<%=lcase(objRS("HE_DATAINICIO").Name)&objRS("HE_ID")%>, document.all.<%=lcase(objRS("HE_DATATERMINO").Name)&objRS("HE_ID")%>, document.all.<%=lcase(objRS("HE_MOTIVO").Name)&objRS("HE_ID")%>);"></td>
	<td align="center"><input class="texto1" type="Button" value="Excluir" onclick="javascript:ExcluiHistorico_Eventos(<%=objRS("HE_ID")%>);"></td>
</tr>
<%				objRS.MoveNext
			wend%>
</table>
</form><br>
<%		end if
		objRS.Close

		'-- Pego o hist�rico de eventos da OS
		s = "Select HEOS_ID, he.OS_ID, sit.S_DESCRICAO, HEOS_DATAINICIO, "
		s = s & "HEOS_DATATERMINO, HEOS_MOTIVO from Historico_EventosOS he inner join "
		s = s & "Situacoes sit on he.ID_SITUACAO = sit.ID_SITUACAO "
		s = s & "where AG_NUMERO = " & numAS & " "
		s = s & "order by AG_NUMERO, he.OS_ID, he.HEOS_DATAINICIO"
		's = s & "order by AG_NUMERO, he.OS_ID, he.HEOS_ID"
		objRS.Open s, Env.oConn
		if not objRS.Eof then%>
<script language="JavaScript">
// Passo o ID da tabela por parametro para cada linha
function AtualizaHistorico_EventosOS(id_tabela, heos_datainicio, heos_datatermino, heos_motivo) {
	f = document.all.frmHistorico_EventosOS;
	if(heos_datainicio.value == "") {
		alert('Data de início inválida.');
		heos_datainicio.focus();
	}
	else {
		// utilizo os campos escondidos para enviar a informacao
		f.id_tabela.value = id_tabela;
		f.heos_datainicio.value = heos_datainicio.value;
		f.heos_datatermino.value = heos_datatermino.value;
		f.heos_motivo.value = heos_motivo.value;
		f.submit();
	}
}
function ExcluiHistorico_EventosOS(id_tabela)	{
	if(confirm('ATENÇÃO !!!\n\n\nPara confirmar esta exclusão clique em OK.'))
	{
		f = document.all.frmHistorico_EventosOS;
		f.excluir.value = '1';
		f.id_tabela.value = id_tabela;
		f.submit();
	}
}
</script>
<form name="frmHistorico_EventosOS" method="post">
<input type="hidden" name="num_as" value="<%=numAS%>">
<input type="hidden" name="frm" value="frmHistorico_EventosOS">
<input type="Hidden" name="id_tabela">
<input type="Hidden" name="heos_datainicio">
<input type="Hidden" name="heos_datatermino">
<input type="Hidden" name="heos_motivo">
<input type="Hidden" name="excluir" value="">
<table width="100%" border="1" class="tabela1" cellpadding="2" cellspacing="0">
<tr><th align="left" colspan="8"><b>Hist&oacute;rico de Eventos - Ordem de Servi&ccedil;o(<%=numAS%>)</b></th></tr>
<tr style="font-weight: bold;">
	<td>ID</td>
	<td>Nº OS</td>
	<td>Data de In&iacute;cio</td>
	<td>Data de T&eacute;rmino</td>
	<td>Situa&ccedil;&atilde;o</td>
	<td>Motivo</td>
	<td>&nbsp;</td>
	<td>&nbsp;</td>
</tr>
<%			while not objRS.EOF%>
<tr>
	<td><%=objRS("HEOS_ID")%></td>
	<td align="center"><b><%=objRS("OS_ID")%></b></td>
	<td><input class="texto1" size="20" type="Text" value="<%=RetiraMiliSegundos(objRS("HEOS_DATAINICIO"))%>" name="<%=lcase(objRS("HEOS_DATAINICIO").Name)&objRS("HEOS_ID")%>"></td>
	<td><input class="texto1" size="20" type="Text" value="<%=RetiraMiliSegundos(objRS("HEOS_DATATERMINO"))%>" name="<%=lcase(objRS("HEOS_DATATERMINO").Name)&objRS("HEOS_ID")%>"></td>
	<td><%=objRS("S_DESCRICAO")%></td>
	<td><textarea name="<%=lcase(objRS("HEOS_MOTIVO").Name)&objRS("HEOS_ID")%>" class="texto1" rows="3" cols="50"><%=objRS("HEOS_MOTIVO")%></textarea></td>
	<td align="center"><input class="texto1" type="Button" value="Ok" onclick="javascript:AtualizaHistorico_EventosOS(<%=objRS("HEOS_ID")%>, document.all.<%=lcase(objRS("HEOS_DATAINICIO").Name)&objRS("HEOS_ID")%>, document.all.<%=lcase(objRS("HEOS_DATATERMINO").Name)&objRS("HEOS_ID")%>, document.all.<%=lcase(objRS("HEOS_MOTIVO").Name)&objRS("HEOS_ID")%>);"></td>
	<td align="center"><input class="texto1" type="Button" value="Excluir" onclick="javascript:ExcluiHistorico_EventosOS(<%=objRS("HEOS_ID")%>);"></td>
</tr>
<%				objRS.MoveNext
			wend%>
</table>
</form><br>
<%		end if
		objRS.Close

		set objRS = nothing
	end if
end if

'-- retiro a parte do milisegundo do campo data/hora (Caso exista)
function RetiraMiliSegundos(data)
	if right(data,3) = ":00" then
		RetiraMiliSegundos = left(data, len(data)-3)
	else
		RetiraMiliSegundos = data
	end if
end function

call imprimeRodape(RODAPE_OFF)
%>
