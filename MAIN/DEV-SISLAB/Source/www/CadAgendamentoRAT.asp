<!--#include file="includes/Sislab_Lib.asp"-->
<!--#include file="includes/controlesHTML.asp" -->
<!--#include file="includes/PadraoHTML.asp" -->
<!--#include file="includes/global.asp" -->
<!--#include file="includes/funcoes.asp" -->
<%
Dim num_ag, tem_os, objSiteRS, objSiteRS2, objRS_TEM_OS
Dim RS
Dim bln_RT_Visivel
Dim bln_RT_TodosUsuarios
Dim chr_RT_MsgErro
Dim bln_RAT_Visivel
Dim bln_RAT_TodosUsuarios
Dim chr_RAT_MsgErro

num_ag = request("hdAG")
tem_os = False

Tela.SetMostraMenu = MENU_ON
Tela.SetMostraImagem = True
Tela.SetNomeTela = "Cadastro de Agendamento - RAT"
Tela.SetLinkVoltar = ""
Call Tela.MostraCabecalho()
'''''Call Tela.ImprimeCabecalho2(TITULO_SITE, MENU_ON, true, "", "Cadastro de Agendamento - RAT", "", "")

If num_ag <> "" Then
	Dim rsEBT,rsCLI
	sSQL = "Select * from agendamento where ag_numero=" & num_ag & ";"
	Call Env.RecordSet( true, objSiteRS, sSQL)

	'-- verifico se existe ou nao OS, caso exista nao posso deixar
	'-- marcar o flag NECESSITA_OS como falso
	sSQL = "Select COUNT(*) from ORDEM_DE_SERVICO where ag_numero=" & num_ag & ";"
	Call Env.RecordSet(true, objRS_TEM_OS, sSQL)
	tem_os = (objRS_TEM_OS(0) > 0)
	Call Env.RecordSet(false, objRS_TEM_OS, sSQL)

	sSQL = "select top 1 * from historico_eventos where ag_numero = " & num_ag & " order by he_id desc"
	Call Env.RecordSet( true, objSiteRS2, sSQL)


	'>>> Verifica o usuário RAT do agendamento
	bln_RAT_Visivel = True
	bln_RAT_TodosUsuarios = False
	chr_RAT_MsgErro = ""
	If Not VVVNZ(objSiteRS("AG_RAT")) Then
		sSQL = "SELECT RT, RAT, Exibir FROM UserCRT Where UPPER(USERID) = UPPER('" & objSiteRS("AG_RAT") & "')"
		Call Env.RecordSet(True, RS, sSQL)
		If Not (RS.Eof And RS.Bof) Then
			If RS("RAT") And (Not RS("Exibir")) Then 
				bln_RAT_Visivel = False
			ElseIf Not RS("RAT") Then
				bln_RAT_TodosUsuarios = True
				chr_RAT_MsgErro = "* O Usuário " & UCase(objSiteRS("AG_RAT")) & " não está selecionado como RAT"
			End If
		End If
		RS.Close
	End If

	'>>> Verifica o usuário RT do agendamento
	bln_RT_Visivel = True
	bln_RT_TodosUsuarios = False
	chr_RT_MsgErro = ""
	If Not VVVNZ(objSiteRS("AG_RESPONSAVEL")) Then
		sSQL = "SELECT RT, RAT, Exibir FROM UserCRT Where UPPER(USERID) = UPPER('" & objSiteRS("AG_RESPONSAVEL") & "')"
		Call Env.RecordSet(True, RS, sSQL)
		If Not (RS.Eof And RS.Bof) Then
			If RS("RT") And (Not RS("Exibir")) Then 
				bln_RT_Visivel = False
			ElseIf Not RS("RT") Then
				bln_RT_TodosUsuarios = True
				chr_RT_MsgErro = "* O Usuário " & UCase(objSiteRS("AG_RESPONSAVEL")) & " não está selecionado como RT"
			End If
		End If
		RS.Close
	End If

	Set RS = Nothing
Else
	'-- nao posso receber como parametro uma AS em branco
	Response.redirect "index.asp"
End If
%>
<script language="javascript" src="includes/anexo.js"></script>
<script type="text/javascript">
    function areaCliente(){
	    var frm = document.forms[0];
	    frm.action = "CadAgendamentoCliente.asp";
	    frm.method = "POST";
	    frm.target = "";
	    frm.submit();
    }
    function areaRT(){
	    var frm = document.forms[0];
	    frm.action = "CadAgendamentoRT.asp";
	    frm.method = "POST";
	    frm.target = "";
	    frm.submit();
    }
    function Historico(){
	    var strurl
	    strurl = "eventosinternos.asp?hdnEvento=12&num_ag=" + '<%=num_ag%>'
	    window.open(strurl,'','toolbar=no,location=no,directories=no,status=no,menubar=no,scrollbars=yes,resizable=no,copyhistory=no,width=400,height=300,top=0,left=0');
    }

    function ValidaCampos(){
	    var frm = document.forms[0];

	    if (frm.tipoatividade.value==""){
		    alert("Informe o Tipo da atividade do agendamento.");
	        frm.tipoatividade.focus();
		    return false;
	    }
	
	    if (frm.hdnSituacao.value != frm.cmbSituacao.value){

		    if ((frm.cmbSituacao.value=="") || (frm.cmbSituacao.value=="0")) {
			    alert("Informe a Situação do agendamento.");
	    	    frm.cmbSituacao.focus();
			    return false;
		    }

		    if (frm.motivo.value==""){
			    alert("O Motivo da mudança não foi informado.");
	    	    frm.motivo.focus();
			    return false;
		    }

		    if (!(isDate(frm.diaINICIO.value+"/"+frm.mesINICIO.value+"/"+frm.anoINICIO.value))){
			    alert("A data de inicio da situação atual deve ser uma uma data válida.");
			    frm.diaINICIO.focus();
			    return false;
		    }

		    if ((frm.horaINICIO.value=="")||(frm.minutoINICIO.value=="")){
			    alert("Hora e/ou minuto do início não informada.");
	    	    frm.horaINICIO.focus();
			    return false;
		    }

		    if (AchaAspas(frm.motivo.value)){
			    alert("O Motivo da mudança não pode conter Aspas ou apóstrofes.");
	    	    frm.motivo.focus();
			    return false;	
		    }
	    }

<%if tem_os then%>
	    if (frm.cmbOS[1].checked) { // NAO NECESSITA OS
			    alert("ATENÇÃO !\n\nEste agendamento possui Ordem de Serviço.\n\nNáo é permitido retirar a necessidade de OS sem antes o\nRAT/RT remover as mesmas.");
	    	    frm.cmbOS1.focus();
			    return false;
	    }
<%end if%>

	    if (frm.cmbRATRESP.value==""){
		    alert("Informe RAT responsável pelo agendamento.");
	        frm.cmbRATRESP.focus();
		    return false;
	    }
	
	    if (frm.cmbRESP.value==""){
		    alert("Informe RT responsável pelo agendamento.");
	        frm.cmbRESP.focus();
		    return false;
	    }

	    /* --- preencho a lista de participantes */
	    var i;
	    var separador = '<%=SEPARADOR_REGISTRO%>';

	    var listaEBT = frm.lstParticipantesEBT;
	    frm.strParticipantesEBT.value = '';
	    for(i=0; i<listaEBT.options.length; i++) {
		    frm.strParticipantesEBT.value += listaEBT.options[i].value + separador;
	    }
	    /* --- fim do preenchimento das lista */

	    frm.action = "CadAgendamentoRatA.asp";
	    frm.method = "POST";
	    frm.target = "_parent";
	    frm.submit();
    }
</script>

<div class="margem-10">

<form method="post" action="CadAgendamentoRatA.asp" name="frmAgendaTeste">

<input type="hidden" name="hdnSituacao">
<input type="hidden" name="hdAG" value="<%=num_ag%>">
<input type="hidden" name="strParticipantesEBT">
<input type="hidden" name="strAmbientesOriginal">
<input type="hidden" name="rat_original" value="<%=UCase(objSiteRS("ag_rat"))%>">
<input type="hidden" name="rt_original" value="<%=UCase(objSiteRS("ag_responsavel"))%>">

<table border="0" width="100%" class="table-condensed">
<tr> 
	<td>
		<b><span class="texto-vermelho-bold">*</span>&nbsp; Indica um Campo Obrigatório</b></td>
		<td align="right"><b><span class="menu">Agendamento Nº &nbsp;<%=num_ag%></span></b></td>
</tr>
</table>

<table border="0" width="100%" cellspacing="0" class="table-condensed">
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
<tr height="34"> 
   	<td colspan="10">
		<span class="texto-vermelho-bold"><b>*</b></span>&nbsp;Tipo de Atividade:
		<%call comboBDSQL( "tipoatividade", objConn,"Select ta_ID as valor,ta_descricao as descricao from TIPO_ATividade order by ta_ID asc;", "", "N")%>
	</td>
</tr>
<tr height="34">
	<td  colspan="2">
		Situação:&nbsp;
		<select name="cmbSituacao"  onchange="avaliaSituacao();">
         		<option value="0" selected></option>
			<%	strSQL = "select distinct s.ID_SITUACAO as valor  , s.S_DESCRICAO as descricao"
				strSQL = strSQL & " from situacoes_situacoes ss, situacoes s"
				strSQL = strSQL & " where ss.situacao_proxima = s.id_situacao and S_OS = 0 and ss.situacao_atual = " &  objSiteRS2("id_situacao")
				strSQL = strSQL & " UNION select distinct s.ID_SITUACAO as valor  , s.S_DESCRICAO as descricao"
				strSQL = strSQL & " from situacoes_situacoes ss, situacoes s"
				strSQL = strSQL & " where S_OS = 0 AND s.ID_SITUACAO = " &  objSiteRS2("id_situacao")
				call comboBD(objConn,strSQL)%>
		</select> 
	</td>
	<td  colspan="4">
			<span class="texto-vermelho-bold"><b>*</b></span>&nbsp;Data Início:&nbsp;
			<%call comboData("INICIO")%>
		</td>
	<td  colspan="4">
			<span class="texto-vermelho-bold"><b>*</b></span>&nbsp;Hora Início:&nbsp;
			<%call comboHorario("INICIO")%>
	</td>
</tr>
<tr>
	<td colspan="10">
		<span class="texto-vermelho-bold"><b>*</b></span>&nbsp;Motivo ( Somente em caso de mudança de Situação ):</a><br>
		<textarea name="motivo"  cols=147 rows=4 ></textarea>
	</td>
</tr>
<tr height="34">
	<td colspan="10"> 
        <p><span class="texto-vermelho-bold"><b>*</b></span>&nbsp;RAT Responsável : &nbsp;
		<%
		If bln_RAT_TodosUsuarios Then
			Call comboUserCRTVivoEMortos("cmbRATRESP",objConn,"N")
			RW "&nbsp;<span style='color: red;'><i>" & chr_RAT_MsgErro & "</i></span>"
		Else
			If bln_RAT_Visivel Then
				call comboRAT("cmbRATRESP",objConn,"N")
			Else
				call comboRatTodos("cmbRATRESP",objConn,"N")
			End If
		End If
		%>

        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span class="texto-vermelho-bold"><b>*</b></span>&nbsp;Responsável Técnico : &nbsp;
		<%
		If bln_RT_TodosUsuarios Then
			Call comboUserCRTVivoEMortos("cmbRESP",objConn,"N")
			RW "&nbsp;<span style='color: red;'><i>" & chr_RT_MsgErro & "</i></span>"
		Else
			If bln_RAT_Visivel Then
				call comboRatERt("cmbRESP",objConn,"N")
			Else
				call comboRatERtTodos("cmbRESP",objConn,"N")
			End If
		End If
		%>
		<br>
        </p>
	</td>
</tr>
<tr>
	<td colspan="10">
		<%call ControleParticipantesInternos("ParticipantesEBT",22, "", "", num_ag)%>
		<script type="text/javascript">
			document.all.tabParticipantesEBT.style.display = 'block';
		</script>
	</td>
</tr>
<tr height="34">
	<td colspan="10">
		<p><span class="texto-vermelho-bold"><b>*</b></span>&nbsp;Agendamento Necessita de Ordem de Serviço (OS): &nbsp;
		<input type="radio" name="cmbOS" value="1" id = "cmbOS1">Sim&nbsp;
		<input type="radio" name="cmbOS" value="0"  id = "cmbOS0">Não
	</td>
</tr>
<tr height="34">
	<td colspan="3">
		Teste tem repetição:&nbsp;
		<input type="Checkbox" name="chkRepeticao" >
	</td>
	<td colspan="7">
		Tem Executante do CRT:&nbsp;
		<input type="Checkbox" name="chkExecutante" >
	</td>
</tr>

<!--XXXXXXXXXXXXXXXXXXXXXXX  AMBIENTES XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX-->
<tr>
	<td colspan="10">
<%	strSQL = "Select AMB_ID as valor , AMB_NOME as descricao from Ambientes WHERE AMB_USADOPORAG = 1 ORDER BY AMB_NOME"
	Call ControleComboMultiplo3("Ambientes","Ambientes Utilizados","Ambientes", strSQL, "10")%>
	</td>
</tr>

<tr>
	<th align="left" colspan="10">
		Relatório de andamento de agendamentos (interno CRT)
	</th>
</tr>
<tr>
	<td colspan="10">Relatório de Agendamento:<br>
		<textarea name="relatAS"  cols="147" rows="12"></textarea>
	</td>
</tr>
<tr height="34">
	<td colspan="10" align="left">
		<%if Env.ehRAT then%>
			<input type="button"  onclick="ValidaCampos()" value=" &nbsp;&nbsp;Salvar Dados&nbsp;&nbsp;"/>
		<%else%>
			<input type="button"  onclick="" value=" &nbsp;&nbsp;Salvar Dados&nbsp;&nbsp;" disabled/>
		<%end if%>

		<input type="button"  onclick="areaCliente()" value=" &nbsp;&nbsp;Área do Cliente &nbsp;&nbsp;"/>
		<input type="button"  onclick="areaRT()" value=" &nbsp;&nbsp;Área do RT &nbsp;&nbsp;"/>
	</td>
</tr>
</table>
</form>
<iframe width="770" height="200" name="escondido" style="display: none;"></iframe>

    <br />
</div>


<script type="text/javascript">
    function avaliaSituacao()
    {
        var frm = document.forms[0]
        if (frm.hdnSituacao.value == frm.cmbSituacao.value){
	        frm.motivo.style.backgroundColor = "#EEEEEE";	
	        frm.horaINICIO.style.backgroundColor = "#EEEEEE";	
	        frm.minutoINICIO.style.backgroundColor = "#EEEEEE";	
	        frm.diaINICIO.style.backgroundColor = "#EEEEEE";	
	        frm.mesINICIO.style.backgroundColor = "#EEEEEE";	
	        frm.anoINICIO.style.backgroundColor = "#EEEEEE";	

	        frm.motivo.disabled = true;
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
	        frm.horaINICIO.disabled = false;
	        frm.minutoINICIO.disabled = false;
	        frm.diaINICIO.disabled = false;
	        frm.mesINICIO.disabled = false;
	        frm.anoINICIO.disabled = false;
        }
    }

    var frm = document.forms[0]
    var frmAll = document.all
<%if num_ag <> "" then%>
	frm.hdAG.value = '<%=num_ag%>'
	frm.cmbRATRESP.value='<%=Ucase(objSiteRS("ag_rat"))%>'
    frm.cmbRESP.value='<%=UCase(objSiteRS("ag_responsavel"))%>'
    frm.motivo.value='<%=strToTexto(objSiteRS2("he_motivo"))%>'
	<%if objSiteRS("AG_REPETIDO")= TRUE then%>
		frm.chkRepeticao.checked = true;
	<%end if%>
	<%if objSiteRS("AG_EXECUTANTE")= TRUE then%>
		frm.chkExecutante.checked = true;
	<%end if%>

	frm.relatAS.value = '<%=strToTexto(objSiteRS("AG_Relat_RAT"))%>';
	frm.cmbSituacao.value = '<%=objSiteRS2("id_situacao")%>'
	frmAll.cmbOS<%if objSiteRS("ag_necessita_os") then response.write 1 else response.write 0%>.checked = true
	frm.diaINICIO.value = '<%= itoa(day(objSiteRS2("HE_DATAINICIO")),2)%>'
	frm.mesINICIO.value = '<%=itoa(month(objSiteRS2("HE_DATAINICIO")),2)%>'
	frm.anoINICIO.value = '<%=year(objSiteRS2("HE_DATAINICIO"))%>'
	frm.horaINICIO.value = '<%= itoa(hour(objSiteRS2("HE_DATAINICIO")),2)%>'
	frm.minutoINICIO.value = '<%=itoa(minute(objSiteRS2("HE_DATAINICIO")),2)%>'
	frm.tipoatividade.value = '<%=objSiteRS("ta_id")%>'
	frm.hdnSituacao.value = '<%=objSiteRS2("id_situacao")%>'
	avaliaSituacao();

	var lista = frm.lst<%="ParticipantesEBT"%>;
<%	'-- ADICIONO OS PARTICIPANTES EXTERNOS EMBRATEL ----------------------------------
	Dim rsPart
	sSQL = "Select * from participantes_externos where PE_QUEMINCLUIU = 'RAT' AND ag_numero = " & num_ag
	call Env.RecordSet( true, rsPart, sSQL)
	while not rsPart.eof%>
		ultimo_da_lista = lista.options.length;
		lista.options[ultimo_da_lista]=new Option('<%=rsPart("PE_USERNAME")%>' + ' <%=SEPARADOR_CAMPO%> ' + '<%=rsPart("PE_NOME")%>' + ' <%=SEPARADOR_CAMPO%> ' + '<%=rsPart("PE_MOTIVO")%>');
		lista.options[ultimo_da_lista].value = '<%=rsPart("PE_USERNAME")%>' + '<%=SEPARADOR_CAMPO%>' + '<%=rsPart("PE_NOME")%>' + '<%=SEPARADOR_CAMPO%>' + '<%=rsPart("PE_MOTIVO")%>';
<%		rsPart.MOVENEXT
	wend
	call Env.RecordSet( true, rsPart, sSQL)
%>

<%	'-- ADICIONO OS AMBIENTES DESTE AGENDAMENTO ----------------------------------
	Dim rsAmbientes
	strSQL = _
			"SELECT a.AMB_ID, a.AMB_NOME FROM Reserva_Ambientes ra INNER JOIN Ambientes a " & _
			"ON ra.AMB_ID = a.AMB_ID WHERE a.AMB_USADOPORAG = 1 AND ra.RAM_AS = " & NUM_AG & " " & _
			"ORDER BY a.AMB_NOME"
	call Env.RecordSet( true, rsAmbientes, strSQL)
	if not (rsAmbientes.EOF and rsAmbientes.BOF) then%>

	var lista = frm.lstAmbientes;
	var str2 = frm.strAmbientes;
	var str2Original = frm.strAmbientesOriginal;

	str2.value = '';
<%		While Not rsAmbientes.Eof%>
	lista.options[lista.options.length] = new Option('<%=rsAmbientes("AMB_NOME")%>',<%=rsAmbientes("AMB_ID")%>);
	str2.value = str2.value + '<%=rsAmbientes("AMB_ID")%>' + '<%=SEPARADOR_REGISTRO%>';
	str2Original.value = str2Original.value + '<%=rsAmbientes("AMB_ID")%>' + '<%=SEPARADOR_REGISTRO%>';
<%			rsAmbientes.MoveNext
		WEnd
	End If
End If
%>
</script>

<%
Call Tela.MostraRodape()
%>
