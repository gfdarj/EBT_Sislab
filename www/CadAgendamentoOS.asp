<!--#include file="includes/Sislab_Lib.asp"-->
<!--#include file="includes/global.asp" -->
<!--#include file="includes/PadraoHTML.asp" -->
<!--#include file="includes/controleshtml.asp" -->
<!--#include file="includes/funcoes.asp" -->
<%
Dim ssql, motivo, num_ag, num_os, nova_os, servico, plataforma, eq_id
Dim int_Repetido, os_observacoes, hora, id_situacao

num_ag = request("num_ag")
num_os = request("num_os")
nova_os = request("novaOs")
motivo = ""
id_situacao = ""
situacao_atual = "null"
int_Repetido = 0
os_observacoes = ""
hora = ""

If nova_os = "0" then
	ssql = "select * from vw_OrdemDeServico where ag_numero = " & num_ag & " and os_id = " & num_os
	call Env.RecordSet( true, objSiteRS, sSQL)

	If not (objSiteRS.Eof and objSiteRS.Bof) then
		servico = objSiteRS("S_ID_SERVICO")
		if IsNull(servico) then servico = ""
		plataforma = objSiteRS("S_ID_PLATAFORMA")
		if IsNull(plataforma) then plataforma = ""
		eq_id = objSiteRS("EQ_ID_AMOSTRA")
		if IsNull(eq_id) then eq_id = ""
		teste = objSiteRS("T_ID")
		if IsNull(teste) then teste = ""
		motivo = objSiteRS("HEOS_MOTIVO")
		situacao_atual = objSiteRS("ID_SITUACAO")
		if isNull(situacao_atual) then situacao_atual = "null"
		if IsNull(motivo) then motivo = ""
		int_Repetido = objSiteRS("OS_FLAGREPETICAO")
		If VVVNZ(int_Repetido) Then int_Repetido = 0
		os_observacoes = objSiteRS("os_observacoes")
		If VVVNZ(os_observacoes) Then os_observacoes = ""
		If Not VVVNZ(objSiteRS("HEOS_DATAINICIO")) Then hora = objSiteRS("HEOS_DATAINICIO")
		If Not VVVNZ(objSiteRS("id_situacao")) Then id_situacao = objSiteRS("id_situacao")
	End If
End If

call ImprimeCabecalho2("Ordem de Serviço - AS " & NUM_AG, MENU_OFF, false, "100%", "Cadastro de Ordem de Serviço", "window.close()", "")
%>
<script language="javascript" src="includes/anexo.js"></script>

<script language="JavaScript">
function Historico(){
	var strurl
	strurl = "eventosinternos.asp?hdnEvento=10&num_os=" + '<%=num_os%>' + "&num_ag=" + '<%=num_ag%>'
	window.open(strurl,'','toolbar=no,location=no,directories=no,status=no,menubar=no,scrollbars=yes,resizable=no,copyhistory=no,width=400,height=300,top=0,left=0');
}

function avaliaSituacao()
{
	var frm = document.forms[0];

//	alert("aqui    " + frm.hdnSituacao.value + "  .... " + frm.cmbSituacao.value);

	if (frm.hdnSituacao.value == frm.cmbSituacao.value)
	{
		frm.motivo.style.backgroundColor = "#EEEEEE";	
		frm.horaINICIO.style.backgroundColor = "#EEEEEE";	
		frm.minutoINICIO.style.backgroundColor = "#EEEEEE";	
		frm.diaINICIO.style.backgroundColor = "#EEEEEE";	
		frm.mesINICIO.style.backgroundColor = "#EEEEEE";	
		frm.anoINICIO.style.backgroundColor = "#EEEEEE";	

		frm.motivo.disabled = true;
		frm.motivo.value = frm.motivo_old.value
		frm.horaINICIO.disabled = true;
		frm.minutoINICIO.disabled = true;
		frm.diaINICIO.disabled = true;
		frm.mesINICIO.disabled = true;
		frm.anoINICIO.disabled = true;
	}
	else
	{
		frm.motivo.style.backgroundColor = "#FFFFFF";	
		frm.horaINICIO.style.backgroundColor = "#FFFFFF";	
		frm.minutoINICIO.style.backgroundColor = "#FFFFFF";	
		frm.diaINICIO.style.backgroundColor = "#FFFFFF";	
		frm.mesINICIO.style.backgroundColor = "#FFFFFF";	
		frm.anoINICIO.style.backgroundColor = "#FFFFFF";	

		frm.motivo.disabled = false;
		frm.motivo.value = '';
		frm.horaINICIO.disabled = false;
		frm.minutoINICIO.disabled = false;
		frm.diaINICIO.disabled = false;
		frm.mesINICIO.disabled = false;
		frm.anoINICIO.disabled = false;
	}
}

function envia(){
	var frm = document.forms[0];

	if( (frm.cmbSituacao.value == "") || (frm.cmbSituacao.value == "0") )
	{
		alert("Escolha a situação da OS");
		frm.cmbSituacao.focus();
	}
	else if(frm.diaINICIO.value == "")
	{
		alert("Selecione o dia de início");
		frm.diaINICIO.focus();
	}
	else if(frm.mesINICIO.value == "")
	{
		alert("Selecione o mês de início");
		frm.mesINICIO.focus();
	}
	else if(frm.anoINICIO.value == "")
	{
		alert("Selecione o ano de início");
		frm.anoINICIO.focus();
	}
	else if(frm.horaINICIO.value == "")
	{
		alert("Selecione a hora de início");
		frm.horaINICIO.focus();
	}
	else if(frm.minutoINICIO.value == "")
	{
		alert("Selecione o minuto de início");
		frm.minutoINICIO.focus();
	}
	else if(frm.cmbTeste.value == "")
	{
		alert("Nenhum teste associado ao equipamento foi selecionado");
		frm.cmbTeste.focus();
	}
	else if(frm.cmbPlataforma.value == "")
	{
		alert("Nenhuma plataforma associada ao teste foi selecionada");
		frm.cmbPlataforma.focus();
	}
	else if(frm.cmbServico.value == "")
	{
		alert("Nenhum serviço associado ao teste foi selecionado");
		frm.cmbServico.focus();
	}
	else {
		frm.method = "POST";
		frm.action = "CadAgendamentoOSA.asp";
		frm.target = "_parent";
		frm.submit();
	}
}
</script>
<form name="frm" method="post">
<input type="Hidden" name="hdnTeste">
<input type="Hidden" name="hdnSituacao">
<input type="Hidden" name="hdnEvento" value="9">
<input type="Hidden" name="num_os" value="<%=num_os%>">
<input type="Hidden" name="num_ag" value="<%=num_ag%>">
<input type="Hidden" name="nova_os" value="<%=nova_os%>">
<table width="100%" class="tabela1">
<tr>
	<td colspan="2">
		<table width="100%" class="tabela1">
		<tr>
			<td ><b>Ordem de Serviço Nº <%=num_os%></b></td>
<%
If int_Repetido > 0 Then
%>
			<td align="right" valign="middle">
				<img align="absmiddle" src="img/icon3.gif" border="0" title="Repetição">&nbsp;&nbsp;<b>Esta OS está marcada para repetição</b>&nbsp;&nbsp;
			</td>
<%
End If
%>
		</tr>
		</table>
	</td>
</tr>
<tr><td colspan="2">&nbsp;</td></tr>
<tr valign="middle">
	<th align="left">
		&nbsp;&nbsp;Controle da Situação da Ordem de Serviço
	</th>
	<th width="100px">
		&nbsp;&nbsp;
		<%if nova_os = "0" then%>
			<a href="javascript:Historico();">Histórico</a>
		<%else%>
			Sem Histórico
		<%end if%>
	</th>
</tr>
<tr height="34">
	<td>
		Situação:&nbsp;
		<select name="cmbSituacao" class="combo" onchange="avaliaSituacao();">
<%		if nova_os <> "1" then
			strSQL = "select distinct s.ID_SITUACAO as valor  , s.S_DESCRICAO as descricao"
				strSQL = strSQL & " from situacoes_situacoes ss, situacoes s"
				strSQL = strSQL & " where ss.situacao_proxima = s.id_situacao and S_OS = 1 and ss.situacao_atual = " & situacao_atual
				strSQL = strSQL & " UNION select distinct s.ID_SITUACAO as valor  , s.S_DESCRICAO as descricao"
				strSQL = strSQL & " from situacoes_situacoes ss, situacoes s"
				strSQL = strSQL & " where S_OS = 1 AND s.ID_SITUACAO = " & situacao_atual
		else
			strSQL = "select distinct ID_SITUACAO as valor  , S_DESCRICAO as descricao"
			strSQL = strSQL & " from situacoes where id_situacao = 9"
		end if
		call comboBDpadrao(objConn, strSQL, situacao_atual)%>
		</select> 
	</td>
</tr>
<tr>
	<td height="34" id="dadosSituacao1">
		Data Início:&nbsp;
		<%call comboData("INICIO")%>
	</td>
</tr>
<tr>
	<td height="34"  id="dadosSituacao2">
		Hora Início:&nbsp;
		<%call comboHorario("INICIO")%>
	</td>
</tr>
<tr>
	<td id="dadosSituacao3">Motivo ( Somente em caso de mudança de Situação ):</font><br>
		<textarea name="motivo" class="texto1" cols="110" rows="4"><%=motivo%></textarea>
		<textarea name="motivo_old" class="texto1" style="display:none;"><%=motivo%></textarea>
	</td>
</tr>
<tr><td colspan="2">&nbsp;</td></tr>
<tr>
	<th align="left" colspan="2">&nbsp;&nbsp;Equipamento e Teste Associado</td>
</tr>

<!--XXXXXXXXXXXXXXXXXXXXXXX  EQUIPAMENTO XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX-->
<tr>
	<td colspan="2">
		Equipamento (Atenção: Deve ter sido reservado pelo SCE)&nbsp;<br>
<%		'-- eq´s movimentado e amostra
		ssql = _
			"SELECT e.EQ_ID as valor, e.EQ_CODIGOBARRAS + ' - ' + e.MOD_DESCRICAO as descricao " & _
			"FROM vw_SCE_Equipamentos_Fabricantes e INNER JOIN SCE_Reserva_Equipamentos r " & _
			"ON e.EQ_ID = r.EQ_ID " & _
			"WHERE r.AG_NUMERO = " & num_ag & " AND r.REQ_MOVIMENTOU = 1 /* AND r.REQ_EQSETUP = 'A' */ " & _
			"AND e.EQ_ID NOT IN (SELECT EQ_ID_AMOSTRA FROM Ordem_de_Servico os WHERE os.AG_NUMERO = " & num_ag & " " & _
			"AND os.EQ_ID_AMOSTRA = e.EQ_ID) "

			if nova_os = "0" then
				ssql = ssql & _
					"UNION " & _
					"SELECT e.EQ_ID as valor, e.EQ_CODIGOBARRAS + ' - ' + e.MOD_DESCRICAO as descricao " & _
					"FROM vw_SCE_Equipamentos_Fabricantes e INNER JOIN Ordem_de_Servico os1 " & _
					"ON e.EQ_ID = os1.EQ_ID_AMOSTRA " & _
					"WHERE os1.AG_NUMERO = " & num_ag & " AND os1.OS_ID = " & num_os & " "
			end if

		ssql = ssql & "ORDER BY descricao"

		call comboBDSQL("cmbEquipamento", objConn, ssql, eq_id, "N")%>
	</td>
</tr>
<tr>
	<td colspan="2">
		Teste Relacionado à OS<br>
		<%call comboBDSQL("cmbTeste", objConn, "SELECT T_ID as valor, LEFT(T_TITULO, 100) as descricao FROM Testes ORDER BY T_TITULO", teste, true)%>
	</td>
</tr>
<tr>
	<td colspan="2">
		<table class="tabela1" width="100%" cellpadding="0" cellspacing="0">
		<tr>
			<td>
				Plataforma ou Sistema utilizado no teste<br>
				<%call comboBDSQL("cmbPlataforma", objConn, "SELECT S_ID as valor, S_DESCRICAO as descricao FROM Servicos_Plataformas WHERE S_SERVICO = 0 ORDER BY S_DESCRICAO", plataforma, true)%>
			</td>
			<td>
				Serviço ou Solução utilizada no teste<br>
				<%call comboBDSQL("cmbServico", objConn, "SELECT S_ID as valor, S_DESCRICAO as descricao FROM Servicos_Plataformas WHERE S_SERVICO = 1 ORDER BY S_DESCRICAO", servico, true)%>
			</td>
		</tr>
	</td>
</tr>
<tr>
	<td colspan="2">Observação:<br>
			<textarea name="obs" class="texto1" cols=110 rows=4 ><%=os_observacoes%></textarea>
	</td>
</tr>
<tr><td>&nbsp;</td></tr>
<tr>
	<td colspan="2">
<%	if Env.ehRAT or Env.ehRT then%>
		<input type="button" onclick="envia()" value="&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Ok&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;" />
	<%else%>
		<input type="button" onclick="javascript:window.close();" value="&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Fechar&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;" />
	<%end if%>
	</td>
</tr>
</table>
</form>
<iframe width="770" height="50" name="escondido" style="display: none;"></iframe>
<script>
var frm = document.forms[0];
<%if nova_os = "0" then
	If Not VVVNZ(hora) Then %>
	frm.horaINICIO.value = "<%=itoa(HOUR(hora),2)%>";
	frm.minutoINICIO.value = "<%=itoa(MINUTE(hora),2)%>";
	frm.diaINICIO.value = "<%=itoa(DAY(hora),2)%>";
	frm.mesINICIO.value = "<%=itoa(MONTH(hora),2)%>";
	frm.anoINICIO.value = "<%=YEAR(hora)%>";
<%	End If %>
	//frm.obs.value = '<%'=objSiteRS("os_observacoes")%>';
	frm.hdnSituacao.value = '<%=id_situacao%>';

	avaliaSituacao();
<%end if%>
	var	frm1 = document.all;
</script>
<%
if nova_os = "0" then
	Call Env.RecordSet(false, objSiteRS, null)
end if

Call imprimeRodape(RODAPE_OFF)
%>

