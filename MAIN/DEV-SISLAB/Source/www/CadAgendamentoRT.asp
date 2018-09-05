<!--#include file="includes/Sislab_Lib.asp"-->
<!--#include file="includes/controlesHTML.asp" -->
<!--#include file="includes/PadraoHTML.asp" -->
<!--#include file="includes/global.asp" -->
<!--#include file="includes/funcoes.asp" -->
<%
Dim num_ag, necessita_OS
num_ag = request("hdAG")

call ImprimeCabecalho2(TITULO_SITE, MENU_ON, true, "", "Cadastro de Agendamento - RT", "", "")
%>
<body bgcolor="#FFFFFF" topmargin=0 leftmargin=0>
<script>
function areaRAT(){
	var frm = document.forms[0];
	frm.action = "CadAgendamentoRAT.asp";
	frm.method = "POST";
	frm.target = "";
	frm.submit();
}
function areaCliente(){
	var frm = document.forms[0];
	frm.action = "CadAgendamentoCliente.asp";
	frm.target = "";
	frm.method = "POST";
	frm.submit();
}

function ValidaCampos(){
	var frm = document.forms[0];

	/* --- preencho a lista de participantes */
	var i;
	var separador = '<%=SEPARADOR_REGISTRO%>';

	var listaEBT = frm.lstParticipantesEBT;
	frm.strParticipantesEBT.value = '';
	for(i=0; i<listaEBT.options.length; i++) {
		frm.strParticipantesEBT.value += listaEBT.options[i].value + separador;
	}
	/* --- fim do preenchimento das lista */

	frm.action = "CadAgendamentoRTA.ASP";
	frm.method = "POST";
	frm.target = "_parent";
	frm.submit();
}
</script>
<form method="post" action="novoCadAgendamentoClienteA.asp" name="frmAgendaTeste">
<input type="Hidden" name="hdAG" value="<%=num_ag%>">
<input type="Hidden" name="strParticipantesEBT">
<table border="0" width="100%" class="tabela1">
<tr> 
	<td>
		&nbsp;&nbsp;<b><span class="vermelho2">*</span>&nbsp; Indica um Campo Obrigatório</b></td>
		<td align="right"><b><span class="menu">Agendamento Nº &nbsp;<%=num_ag%></span></b></td>
</tr>
</table>

<table border="0" width="100%%" cellspacing="0" class="tabela1">
<tr>
	<td width="10%"></td>
	<td width="10%"></td>
	<td width="10%"></td>
	<td width="10%"></td>
	<td width="10%"></td>
	<td width="10%"></td>
	<td width="10%"></td>
	<td width="10%"></td>
	<td width="10%"></td>
	<td width="10%"></td>
</tr>
<tr>
	<th align="left" colspan="10">&nbsp;&nbsp;Criação de Ordens de Serviço</td>
</tr>
<tr valign="top"> 
	<td colspan="9" valign="top">
		&nbsp;&nbsp;&nbsp;Ordem de Serviços Associadadas:<br>
		&nbsp;&nbsp;
		<select name="lstdisposicao" size="5" class="combo"
            style="LINE-HEIGHT: 50px; PADDING-TOP: 3px; WIDTH: 600px"
		>
	</td>
	<td colspan="1" valign="top">
		<%if Env.ehRAT or Env.ehRT then%>
			<input type="button" class="fontmenu1" name="btAcao" value="Criar Nova OS" onClick="NovaOS()" style="width:80px;"/><br><br>
			<input type="button" class="fontmenu1" name="btAlterar" value="Alterar OS" onClick="AbreOS()" style="width:80px;"/><br><br>
			<input type="button" class="fontmenu1" name="btAcaoRem" value="Remover OS" onClick="RemoveOS()" style="width:80px;"/><br><br>
		<%else%>
			<input type="button" class="fontmenu1" name="btAcao" value="Criar Nova OS" onClick="" disabled/><br><br>
			<input type="button" class="fontmenu1" name="btAlterar" value="Visualizar OS" onClick="AbreOS()"/><br><br>
			<input type="button" class="fontmenu1" name="btAcaoRem" value="Remover OS" onClick="" disabled/><br><br>
		<%end if%>			
	</td>
</tr>
<!--
<tr>
	<th align="left" colspan="10">&nbsp;&nbsp;Acessórios Reservados&nbsp;&nbsp;&nbsp;<input type="button" class="fontmenu1" name="btNovoConsumivel" value="Novo consumível" onClick="NovoConsumivel();" style="width:90px;"/></th>
</tr>
<tr>
	<td colspan="10">
<%
'	chr_SQL = _
'		"SELECT c.*, ta.chr_NomeAplicacao, tc.chr_NomeConsumivel, rc.int_Qtd as int_QtdReservada, rc.dtt_Movimentacao, rc.dtt_Cadastro " & _
'		"FROM SCC_Consumivel c " & _
'		"INNER JOIN SCC_TipoAplicacao ta ON c.id_TipoAplicacao = ta.id_TipoAplicacao " & _
'		"left JOIN SCC_ReservaConsumivel rc ON rc.id_consumivel = c.id_consumivel " & _
'		"INNER JOIN SCC_TipoConsumivel tc ON c.id_TipoConsumivel = tc.id_TipoConsumivel " & _
'		"WHERE 1 = 1 "
'		'"WHERE rc.AG_NUMERO = " & num_ag & " "
'
'	chr_SQL = chr_SQL & "ORDER BY tc.chr_NomeConsumivel, ta.chr_NomeAplicacao, c.chr_Descricao, rc.dtt_Cadastro;"
'
'	Call Env.RecordSet(True, RS, chr_SQL)
'	If Not RS.Eof Then
'
'		chr_Buf = _
'			"<table border='0' align='center' width='100%' class='tabela1' cellpadding='2' cellspacing='0' style='border: none;'>" & VbCrLf & _
'			"<tr>" & VbCrLf & _
'			"	<th  align='left'>Tipo</th>" & VbCrLf & _
'			"	<th  align='left'>Aplicação</th>" & VbCrLf & _
'			"	<th  align='left'>Descrição</th>" & VbCrLf & _
'			"	<th  align='left'>Cód.SAP</th>" & VbCrLf & _'
'			"	<th >Qtd.Min.</th>" & VbCrLf & _
' 			"	<th >Qtd Estoque</th>" & VbCrLf & _
' 			"	<th >Reserva</th>" & VbCrLf & _
' 			"	<th ></th>" & VbCrLf
'
'		While Not RS.Eof
'			chr_Buf = chr_Buf & _
'				"<tr id='tr_" & RS("id_consumivel") & "' style='display: block;'>" & VbCrLf & _
'				"	<td>" & RS("chr_NomeConsumivel") & "</td>" & VbCrLf & _
'				"	<td>" & RS("chr_NomeAplicacao") & "</td>" & VbCrLf & _
'				"	<td>" & RS("chr_Descricao") & "&nbsp;</td>" & VbCrLf & _
'				"	<td>" & RS("chr_CodigoSap") & "&nbsp;</td>" & VbCrLf & _
'				"	<td align='center' id='id_QtdMin_" & RS("id_consumivel") &  "'>" & RS("int_QtdMinima") & "</td>" & VbCrLf & _
'				"	<td align='center' id='id_QtdEst_" & RS("id_consumivel") &  "' style='color:" & IIf(RS("int_Qtd")<RS("int_QtdMinima"), "red", "green") & ";'>" & RS("int_Qtd") & "</td>" & VbCrLf & _
'				"	<td align='center' id='id_QtdRes_" & RS("id_consumivel") &  "'>" & RS("int_QtdReservada") & "</td>" & VbCrLf & _
'				"	<td align='center' id='id_Excluir_" & RS("id_consumivel") &  "'><a href='#'>Excluir</a></td>" & VbCrLf & _
'				"</tr>" & VbCrLf
'
'			RS.MoveNext
'		WEnd
'
'		chr_Buf = chr_Buf & _
'			"</table>"
'
'		RW chr_Buf
'	Else
'		RW "<center><p class='texto1'>Não foi encontrado nenhum consumível.</p></center>"
'	End If
%>
	</td>
</tr>
-->
<tr><td>&nbsp;</td></tr>
<tr>
	<td colspan="10">
		<%call ControleParticipantesInternos("ParticipantesEBT",22, "", "", num_ag)%>
		<script language="JavaScript">
			document.all.tabParticipantesEBT.style.display = 'block';
		</script>
	</td>
</tr>
<!--XXXXXXXXXXXXXXXXXXXXXXX  SISTEMA XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX-->
<tr style="font-weight: lighter;">
	<td style="font-weight: lighter;" colspan="10">
<%	sql = "Select convert(varchar,S_ID) + ' - ' + S_Descricao as valor , S_Descricao as descricao from Servicos_Plataformas where S_SERVICO = 0 ORDER BY S_Descricao"
	CALL ControleComboMultiplo("Sistema","&nbsp;&nbsp;Plataformas ou Sistemas utilizados","Plataforma ou<br>&nbsp;Sistema",sql,"9")%>
	</td>
</tr>
<!--XXXXXXXXXXXXXXXXXXXXXXX  SERVIÇO XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX-->
<tr style="font-weight: lighter;">
	<td style="font-weight: lighter;" colspan="10">
<%	sql = "Select convert(varchar,S_ID) + ' - ' + S_Descricao as valor , S_Descricao as descricao from Servicos_Plataformas where S_SERVICO = 1 ORDER BY S_Descricao"
	CALL ControleComboMultiplo("Servico","&nbsp;&nbsp;Serviço ou Solução utilizadas","Serviço ou<br>&nbsp;Solução",sql,"9")%>
	</td>
</tr>
<tr>
	<th align="left" colspan="10">&nbsp;&nbsp;Relatório de andamento de agendamentos (interno CRT)</th>
</tr>
<tr>
	<td colspan="10">&nbsp;&nbsp;Relatório de Agendamento:<br>
		&nbsp;&nbsp;<textarea name="relatAS" class="texto1" cols="145" rows="12"></textarea>
	</td>
</tr>
<tr height="34">
	<td colspan="10" align="left" valign="middle"> &nbsp;&nbsp;	
		<%if Env.ehRAT or Env.ehRT then%>
			<input type="Button" class="texto1" onclick="ValidaCampos()" value=" &nbsp;&nbsp;Salvar Dados&nbsp;&nbsp;"/>
		<%else%>
			<input type="Button" class="texto1" value=" &nbsp;&nbsp;Salvar Dados&nbsp;&nbsp;" disabled/>
		<%end if%>
		<input type="Button" class="texto1" onclick="areaCliente()" value=" &nbsp;&nbsp;Área do Cliente &nbsp;&nbsp;"/>
		<input type="Button" class="texto1" onclick="areaRAT()" value=" &nbsp;&nbsp;Área do RAT &nbsp;&nbsp;"/>
	</td>
</tr>
</table>
</form>
<iframe width="770" height="200" name="escondido" style="display: none;"></iframe>
<script>
var frm = document.forms[0]
var lista = frm.lstdisposicao
var str1 = frm.strSistema;
var listaSitema = frm.lstSistema;
var str2 = frm.strServico;
var listaServico = frm.lstServico;
<%
Dim s_descricao
s_descricao = ""
SSQL = "SELECT * FROM ORDEM_DE_SERVICO WHERE AG_NUMERO = " & NUM_AG
call Env.RecordSet( true, objSiteRS, sSQL)
if not (objSiteRS.EOF and objSiteRS.BOF) then
	WHILE objSiteRS.EOF = FALSE
		ssql = "select s_descricao from historico_eventosos h inner join situacoes s on h.id_situacao = s.id_situacao where heos_id =(select max(heos_id) from historico_eventosos where OS_ID = " & objSiteRS("os_ID") &  " and ag_numero = " & NUM_AG & ")"
		call Env.RecordSet( true, objSiteRS2, sSQL)
		if not (objSiteRS2.EOF and objSiteRS2.BOF) then
			s_descricao = objSiteRS2("s_descricao")
		Else
			s_descricao = "(sem descrição no histórico)"
		End If%>
	lista.options[lista.options.length] = new Option('Ordem de Serviço Nº <%=objSiteRS("os_ID")%> - <%=s_descricao%>',<%=objSiteRS("os_ID")%>);
<%		ultima0S = objSiteRS("os_ID")
		objSiteRS.MOVENEXT
	WEND
end if

'XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
'Preenchendo os combos de sistema e serviços
'XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX

SSQL = "Select convert(varchar,s.S_ID) + ' - ' + S_Descricao as valor , S_Descricao as descricao  from Servicos_Plataformas s "
SSQL = SSQL & " inner join agenda_servicos_plataforma p on AG_NUMERO = " & NUM_AG & " and p.s_id = s.s_id "
SSQL= SSQL & "where S_SERVICO = 0"
'response.write SSQL
'response.end
call Env.RecordSet( true, objSiteRS, SSQL)%>
<%WHILE objSiteRS.EOF = FALSE%>
	listaSitema.options[listaSitema.options.length] = new Option('<%=objSiteRS("valor")%>');
	str1.value = str1.value + '<%=objSiteRS("valor")%>' + '<%=SEPARADOR_REGISTRO%>';
<%
	objSiteRS.movenext
wend%>
//listaSitema.options[0]=null;

<%
SSQL = "Select convert(varchar,s.S_ID) + ' - ' + S_Descricao as valor , S_Descricao as descricao  from Servicos_Plataformas s "
SSQL = SSQL & " inner join agenda_servicos_plataforma p on AG_NUMERO = " & NUM_AG & " and p.s_id = s.s_id "
SSQL= SSQL & "where S_SERVICO = 1"
'response.write SSQL
'response.end
call Env.RecordSet( true, objSiteRS, SSQL)%>
<%WHILE objSiteRS.EOF = FALSE%>
	listaServico.options[listaServico.options.length] = new Option('<%=objSiteRS("valor")%>');
	str2.value = str2.value + '<%=objSiteRS("valor")%>' + '<%=SEPARADOR_REGISTRO%>';
<%
	objSiteRS.movenext
wend
sSQL = "Select AG_Relat_RT, AG_NECESSITA_OS from agendamento where ag_numero=" & NUM_AG & ";"
call Env.RecordSet( true, objRelatRT, SSQL)

necessita_OS = False
if not (objRelatRT.eof and objRelatRT.Bof) then
	if not IsNull(objRelatRT("AG_NECESSITA_OS")) then necessita_OS = objRelatRT("AG_NECESSITA_OS")
%>
	//listaServico.options[0]=null;
	frm.relatAS.value = '<%=strToTexto(objRelatRT("AG_Relat_RT"))%>'
<%
end if
%>

	var lista = frm.lst<%="ParticipantesEBT"%>;
<%	'-- ADICIONO OS PARTICIPANTES EXTERNOS EMBRATEL ----------------------------------
	Dim rsPart
	sSQL = "Select * from participantes_externos where PE_QUEMINCLUIU = 'RTE' AND ag_numero = " & num_ag
	call Env.RecordSet( true, rsPart, sSQL)
	while not rsPart.eof%>
		ultimo_da_lista = lista.options.length;
		lista.options[ultimo_da_lista]=new Option('<%=rsPart("PE_USERNAME")%>' + ' <%=SEPARADOR_CAMPO%> ' + '<%=rsPart("PE_NOME")%>' + ' <%=SEPARADOR_CAMPO%> ' + '<%=rsPart("PE_MOTIVO")%>');
		lista.options[ultimo_da_lista].value = '<%=rsPart("PE_USERNAME")%>' + '<%=SEPARADOR_CAMPO%>' + '<%=rsPart("PE_NOME")%>' + '<%=SEPARADOR_CAMPO%>' + '<%=rsPart("PE_MOTIVO")%>';
<%		rsPart.MOVENEXT
	wend
	call Env.RecordSet( true, rsPart, sSQL)
%>

<%
'XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
'XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
%>
function NovoConsumivel()
{
	var janela = window.open("scc/selCadConsumivel.asp?Acao=CAD_RES_RT&ag_numero=<%=num_ag%>", "cad_reserva_acessorio_rt", "width=770, height=550, left=5, top=5, toolbar=no, status=yes, menubar=no, scrollbars=yes");
	janela.focus();
}
function NovaOS(){
<%if necessita_os then%>
	var janela;
	janela = window.open("CadAgendamentoOS.asp?num_ag=<%=num_ag%>&num_os=<%=ultima0S+1%>&novaOS=1", "cad_contato", "width=690, height=550, toolbar=no, status=yes, menubar=no, scrollbars=yes");
	janela.focus();
<%else%>
	alert("ATENÇÃO !\n\nEste agendamento não necessita de OS. Veja com o seu RAT a necessidade de criação de OS´s.");
<%end if%>
}
function Recarrega(){
	window.location.replace("CadAgendamentoRT.asp?hdAG=<%=num_ag%>")
}
function RemoveOS(){
	var janela;
	var frm = document.forms[0]
	var lista = frm.lstdisposicao
	var cta_id;
	cta_id = lista.selectedIndex;

	if (cta_id == -1){
		alert("Não há OS Selecionada!");
		return;
	}
	else{
		resp = confirm('Tem certeza de que deseja remover a Ordem de Serviço nº ' + lista[cta_id].value + ' ?')
		if (resp == true){
			var frm = document.forms[0];
			frm.action = "eventosinternos.asp?hdnevento=11&num_ag=<%=num_ag%>&num_os=" + lista[cta_id].value;
			frm.method = "POST";
			frm.target = "escondido";
			frm.submit();
		}
	
	}
}
function AbreOS(){
var janela;
var frm = document.forms[0]
var lista = frm.lstdisposicao
var cta_id;
cta_id = lista.selectedIndex;

if (cta_id == -1){
	alert("Não há OS Selecionada!");
	return;
}
else{
	janela = window.open("CadAgendamentoOS.asp?num_ag=<%=num_ag%>&num_os=" + lista[cta_id].value + "&novaOS=0", "cad_contato", "width=690, height=550, toolbar=no, status=yes, menubar=no, scrollbars=yes");
	janela.focus();
}
}
</script>
<%
call imprimeRodape(RODAPE_OFF)
%>
