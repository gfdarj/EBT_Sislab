<!--#include file="includes/Sislab_Lib.asp"-->
<!--#include file="includes/controlesHTML.asp" -->
<!--#include file="includes/PadraoHTML.asp" -->
<!--#include file="includes/global.asp" -->
<!--#include file="includes/funcoes.asp" -->
<%
Dim SolicitouCancela : SolicitouCancela = False
Dim sSQL, rsArquivos, objSiteRS
Dim situacao_ag : situacao_ag = 0
Dim situacao_ag_desc
Dim chr_OrgaoSQL
Dim bln_ehRat : bln_ehRat = False
Dim bln_ehRT : bln_ehRT = False
Dim bln_usuarioCRT : bln_usuarioCRT = False
Dim rsCLI,rsPart
Dim Nome_Reduzido, Matricula, SiglaOrgao, TEL1_COM
Dim bln_AchouEBT
Dim Ebt
Dim int_sigilo
Dim chr_Username

chr_Username = ""
bln_AchouEBT = False
int_sigilo = 0
bln_ehRat = Env.ehRAT
bln_ehRT = Env.ehRT
bln_usuarioCRT = Env.UsuarioCRT
chr_OrgaoSQL = "--"

'-- DEBUG
'bln_ehRat = False
'bln_ehRT = False
'bln_usuarioCRT = False
'--

Call Tela.ImprimeCabecalho2(TITULO_SITE, MENU_ON, true, "", "Cadastro de Agendamento - Cliente", "", "")

num_ag = request("selecao")
as_referencia = request("as_referencia")
If Env.ehRAT Then solicitante = request("solicitante") else solicitante = "" End If
solicitante = request("solicitante")
If num_ag = "" Then num_ag = request("hdAG")


If num_ag <> "" Then
	sSQL = "Select * from vw_Agendamento where ag_numero=" & num_ag & ";"
	Call Env.RecordSet( true, objSiteRS, sSQL)
	If Not (objSiteRS.Eof and objSiteRS.Bof) Then
		SolicitouCancela = objSiteRS("AG_SOLICITOUCANCELAMENTO")
		situacao_ag = objSiteRS("ID_SITUACAO")
		situacao_ag_desc = objSiteRS("S_DESCRICAO")
		int_sigilo = objSiteRS("ag_sigilo")
		chr_Username = objSiteRS("AG_USERNAME")
		chr_OrgaoSQL = objSiteRS("AG_ORGAO")
		If IsNull(chr_OrgaoSQL) Then chr_OrgaoSQL = "--" Else chr_OrgaoSQL = Trim(chr_OrgaoSQL)
	End If
End If
%>
<script language="javascript" src="includes/anexo.js"></script>
<script>

function areaRAT(){
	var frm = document.forms[0];
	frm.action = "CadAgendamentoRAT.asp";
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

function usarReferencia(){
	var frm = document.forms[0];
	frm.action = "CadAgendamentoCliente.asp?as_referencia=" + frm.asRef.value;
	frm.submit();
}

<%if Env.EhRat() then%>
	function BuscarSolicitante(){
		var frm = document.forms[0];
		<%if as_referencia <> "" then%>
			str = "CadAgendamentoCliente.asp?as_referencia=<%=as_referencia%>&solicitante=" + frm.txtSolicitante.value;
		<%else%>
			str = "CadAgendamentoCliente.asp?solicitante=" + frm.txtSolicitante.value;
		<%end if%>
		frm.action = str;
		frm.submit();
	}
<%end if%>

function ValidaCampos(){
	var frm = document.forms[0];

	if (frm.txtTitulo.value==""){
		alert("Informe o título deste agendamento.");
	    frm.txtTitulo.focus();
		return false;
	}
	if (AchaAspas(frm.txtTitulo.value)){
		alert("O título deste agendamento não pode conter aspas ou apóstrofes.");
	    frm.txtTitulo.focus();
		return false;	
	}

	if (!(isDate(frm.diaINICIO.value+"/"+frm.mesINICIO.value+"/"+frm.anoINICIO.value))){
		alert("A data de inicio do agendamento deve ser uma uma data válida.");
		frm.diaINICIO.focus();
		return false;
	}

	if (!(isDate(frm.diaFIM.value+"/"+frm.mesFIM.value+"/"+frm.anoFIM.value))){
		alert("A data de fim do agendamento deve ser uma uma data válida.");
		frm.diaFIM.focus();
		return false;
	}


	/* valido data inicial maior que data final */
	var dI = frm.anoINICIO.value + '' + frm.mesINICIO.value + '' + frm.diaINICIO.value;
	var dF = frm.anoFIM.value + '' + frm.mesFIM.value + '' + frm.diaFIM.value;

	if(dI > dF) {
		alert('Data inicial é maior que a data final');
		frm.diaINICIO.focus();
		return false;
	}


	if (frm.cmbTec.value==""){
		alert("Informe a tecnologia usada no agendamento.");
	    frm.cmbTec.focus();
		return false;
	}

	//Optei por participantes externos
	if (frmAgendaTeste.cmbPartExternos(0).checked){
		if (frm.lstParticipantes.options.length == 0){
			alert("Você optou por presenca de participantes externos mas não cadastrou nenhum.")
			return false;
		}
	}

	//Optei por participantes EBT
	if (frmAgendaTeste.cmbPartEBT(0).checked){
		if (frm.lstParticipantesEBT.options.length == 0){
			alert("Você optou por presenca de participantes embratel mas não cadastrou nenhum.")
			return false;
		}
	}

	if (frm.objetivos.value==""){
		alert("Objetivos do agendamento não foram informados.");
	    frm.objetivos.focus();
		return false;
	}

	if (AchaAspas(frm.objetivos.value)){
		alert("Objetivos do agendamento não podem conter Aspas ou apóstrofes.");
	    frm.objetivos.focus();
		return false;
	}


	if (frm.objetivos.value==""){
		alert("Objetivos do agendamento não foram informados.");
	    frm.objetivos.focus();
		return false;
	}

	if (AchaAspas(frm.objetivos.value)){
		alert("Objetivos do agendamento não podem conter Aspas ou apóstrofes.");
	    frm.objetivos.focus();
		return false;	
	}

	if (!(frm.cmbCliExternos(0).checked || frm.cmbCliExternos(1).checked)){
		alert("É necessário explicitar se Atividade visa atender a cliente externo a Embratel ou não.");
	    frm.cmbCliExternos(0).focus();
		return false;	
	}

	//Cliente externo
	if (frm.cmbCliExternos(0).checked){
		//Nome Cliente
		if (frm.txtNomeCliente.value == ""){
			alert("Em Dados do Cliente não foi especificada o Nome do Cliente.")
		    frm.txtNomeCliente.focus();
			return false;	
		}
		if (AchaAspas(frm.txtNomeCliente.value)){
			alert("Em Dados do Cliente o Nome do Cliente não pode conter Aspas ou apóstrofes.");
	    	frm.txtNomeCliente.focus();
			return false;	
		}
		//Retorno
		//if (frm.txtRetornoCliente.value == "0" || frm.txtRetornoCliente.value == "0,00"){
		//	alert("Em Dados do Cliente não foi especificado o Retorno.")
		//	frm.txtRetornoCliente.focus();
		//	return false;	
		//}

	}
	//Cliente EBT
	if (frm.cmbCliExternos(1).checked){
		//Plano de metas
//		if (frm.cmbItemCliente.value == ""){
//			alert("Em Dados do Cliente não foi especificada o Item associado ao plano de metas.")
//		    frm.cmbItemCliente.focus();
//			return false;	
//		}
	}

	if (frm.ambiente.value==""){
		alert("Ambiente Necessário não foram informado.");
	    frm.ambiente.focus();
		return false;
	}

	if (AchaAspas(frm.ambiente.value)){
		alert("Ambiente Necessário não podem conter Aspas ou apóstrofes.");
	    frm.ambiente.focus();
		return false;
	}

	if (frm.recursos.value==""){
		alert("Recursos Necessários não foram informado.");
	    frm.recursos.focus();
		return false;
	}

	if (AchaAspas(frm.recursos.value)){
		alert("Recursos Necessários não podem conter Aspas ou apóstrofes.");
	    frm.recursos.focus();
		return false;
	}

	/* --- preencho a lista de participantes */
	var strExt = frm.strParticipantesExternos;
	var strEBT = frm.strParticipantesEBT;
	var i;
	var separador = '<%=SEPARADOR_REGISTRO%>';
	var listaExt = frm.lstParticipantes;

	strExt.value = '';
	for(i=0; i<listaExt.options.length; i++) {
		strExt.value += listaExt.options[i].value + separador;
	}

	var listaEBT = frm.lstParticipantesEBT;
	strEBT.value = '';
	for(i=0; i<listaEBT.options.length; i++) {
		strEBT.value += listaEBT.options[i].value + separador;
	}
	/* --- fim do preenchimento das lista */

	frm.action = "CadAgendamentoClienteA.asp";
	frm.method = "POST";
	frm.target = "";
	frm.btn_Salvar.disabled = true;
	frm.submit();
}
function PreparaCamposPART() {
	if (frmAgendaTeste.cmbPartEBT(0).checked)
		tabParticipantesEBT.style.display = 'block';
	else
		tabParticipantesEBT.style.display = 'none';
}
function PreparaCamposCLI(){
	if (frmAgendaTeste.cmbCliExternos(0).checked){
		tabClienteEBT.style.display = 'block';
		tabCliente.style.display = 'none';
		//frm.txtNomeCliente.value = '';
		//frm.txtRetornoCliente.value = '0';
	}else{
		tabClienteEBT.style.display = 'none';
		tabCliente.style.display = 'block';
		//frm.txtNomeCliente.value = 'EBT';
	}
}

function PreparaCamposPARTEXT()
{
	if (frmAgendaTeste.cmbPartExternos(0).checked)
		tabParticipantes.style.display = 'block';
	else
		tabParticipantes.style.display = 'none';
}
</script>
<form method="post" action="CadAgendamentoClienteA.asp" name="frmAgendaTeste">
<input type="Hidden" name="hdAG">
<input type="Hidden" name="strParticipantesExternos">
<input type="Hidden" name="strParticipantesEBT">
<table border="0" width="100%" class="tabela1">
<tr valign="middle">
	<td>
		&nbsp;<span class="vermelho2"><b>*</span>&nbsp; Indica um Campo Obrigatório</b>
	</td>
	<td align="right">
		<b>
		<%if num_ag <> "" then%>
		Agendamento Nº &nbsp;<%=num_ag%> (<%=situacao_ag_desc%>)
		<%else%>
		<a href="javascript:;" title="Utiliza os dados de agendamentos anteriores como referência para um novo">
		Novo Agendamento&nbsp;&nbsp;-&nbsp;&nbsp;Usar uma AS como modelo</a>
		</b>
		<select name="asRef" class="combo">
		<option value="">--</option>
		<%
		if bln_usuarioCRT then
			ssql = "select ag_numero as valor,ag_numero as descricao from agendamento order by ag_numero desc"
		else
			ssql = "select ag_numero as valor,ag_numero as descricao from agendamento where ag_username = '" & Env.Usuario & "' order by ag_numero desc"
		end if
		call comboBD(objConn,ssql)%>
		</select>
		<input class="combo" type="Button" value="Ok" onclick="usarReferencia();">
	<%end if%>
	</td>
</tr>
</table>

<table border="0" width="100%" cellpadding="2" cellspacing="0" class="tabela1">
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
<%
if num_ag <> "" then
	sSQL = "Select VW.* From vw_ArquivosTeste VW "
	sSQL = sSQL & " WHERE VW.AG_NUMERO=" & num_ag
	call Env.RecordSet( true, rsArquivos, sSQL)
	if Not rsArquivos.eof then%>
<tr>
	<th align="left" colspan="10">Arquivos Associados</th>
</tr>
<tr>
	<td colspan="10">
<%		If MostraDadoSigiloso(int_Sigilo, chr_Username) Then %>
		<table border="0" width="100%" cellpadding="2" cellspacing="1" class="tabela1">
<%			rsArquivos.MoveFirst
			Do while Not rsArquivos.eof%>
		<tr class="texto1">
			<td>&nbsp;&nbsp;<span class="cinza">&raquo;</span>&nbsp;<b><%=rsArquivos("TAR_TipoArquivo")%>:&nbsp;</b><a href="arquivos/<%=rsArquivos("Arq_nomeArq")%>" target="_blank"><%=rsArquivos("Arq_Link")%></a></td>
		</tr>
<%			rsArquivos.MoveNext
			Loop%>
		</table>
<%		Else
			Response.Write ExibeMensagemSigiloAS(0)
		End If%>
	</td>
</tr>
<%	End if
End if
%>
<tr height="5px">
	<td colspan="10" bgcolor="#FFFFFF" valign="middle"></td>
</tr>
<%
if Env.EhRat() then
%>
<tr>
	<th align="left" colspan="10">&nbsp;Solicitar Agendamento pelo Cliente</th>
</tr>
<tr height="34"> 
	<td colspan="10">&nbsp;&nbsp;Nome do Solicitante: &nbsp;
		<input type="text" class="combo" name="txtSolicitante" size="15"  maxlength="20">
		<input  class="combo" type="Button" value="Buscar" onclick="BuscarSolicitante();">
	</td>
</tr>
<%
end if
%>
<tr>
	<th align="left" colspan="10">&nbsp;Dados do Solicitante</th>
</tr>
<tr height="34"> 
	<td colspan="6">&nbsp;&nbsp;Nome do Responsável: &nbsp;
		<input type="text" class="texto1" READONLY name="txtResponsavel" size="55" tabindex="2" maxlength="200">
	</td>
	<td colspan="4">&nbsp;&nbsp;Matrícula:&nbsp;
		<input class="texto1" READONLY  name="txtMatricula" size="7" tabindex="3">
	</td>
</tr>
<tr height="34">
	<td  colspan="3">&nbsp;&nbsp;Órgão:&nbsp;
		<input class="texto1" READONLY name="txtOrgao" size="12" tabindex="4" maxlength="50">
	</td>
	<td  colspan="4">&nbsp;&nbsp;E-mail:&nbsp;
		<input type=hidden name="Username">
		<input class="texto1"  READONLY  name="txtEMail" size="50" tabindex="5" maxlength="80">
	</td>
	<td  colspan="3">&nbsp;&nbsp;Ramal:&nbsp;
		<input class="texto1"  name="txtRamal" size="20" tabindex="6" maxlength="10" >
	</td>
</tr>
<tr>
	<th align="left" colspan="10">&nbsp;Dados do Agendamento</th>
</tr>
<tr height="34">
    <td colspan="10">&nbsp;&nbsp;<span class="vermelho2"><b>*</b></span>&nbsp;
		<a href="javascript:;" title="Nome de referência associada a atividade.">Título do agendamento:</a>&nbsp;
		<input class="texto1"  name="txtTitulo" size="70" tabindex="7" maxlength="50">
	</td>
</tr>
<tr height="34">
    <td colspan="10">&nbsp;&nbsp;Período previsto para a atividade:&nbsp;
		&nbsp;&nbsp;
		<span class="vermelho2"><b>*</b></span>Início:&nbsp;
		<%call comboData("INICIO")%>
		&nbsp;&nbsp;&nbsp;&nbsp;<span class="vermelho2"><b>*</b></span>Fim:&nbsp;
		<%call comboData("FIM")%>
	</td>
</tr>
<tr height="34"> 
	<td colspan="10">
			&nbsp;&nbsp;<span class="vermelho2"><b>*</b></span>&nbsp;
			<a href="javascript:;" title="Selecionar a principal tecnologia associada a atividade.">Tecnologia:</a>
			<%call comboTecnologia("cmbTec",objConn,"N")%>
	</td>
</tr>
<tr>
	<td colspan="10">&nbsp;&nbsp;<span class="vermelho2"><b>*</b></span>&nbsp;Tipo de Sigilo:
        <input type="radio" name="cmbSigilo"  value="1" id="cmbSigilo1">
        Sigilo de Resultado&nbsp;
        <input type="radio" name="cmbSigilo"  value="2" id="cmbSigilo2">
        Sigilo de Ambiente e Resultado&nbsp;
		<input type="radio" name="cmbSigilo"  value="0" id="cmbSigilo0" checked>
		Sem Sigilo&nbsp;
	</td>
</tr>
<!--
<tr>
	<td colspan="10"> 
        <p>&nbsp;&nbsp;<span class="vermelho2"><b>*</b></span>&nbsp;Receber e-mail de acompanhamento da situação da AS: &nbsp;
        <input type="radio" name="cmbEmail" value="1" id="cmbEmail1">
        Sim&nbsp;
        <input type="radio" name="cmbEmail"  value="0" checked id="cmbEmail0">
	    Não&nbsp;
	</td>
</tr>
-->
        <input type="hidden" name="cmbEmail" value="1" id="cmbEmail1">

<tr>
	<td colspan="10"> 
        <p>&nbsp;&nbsp;<span class="vermelho2"><b>*</b></span>&nbsp;Participantes externos a Embratel: &nbsp;
        <input type="radio" name="cmbPartExternos" onClick="PreparaCamposPARTEXT()" value="1" tabindex="13" ID="cmbPartExternos1">
        Sim&nbsp;
        <input type="radio" name="cmbPartExternos"  onClick="PreparaCamposPARTEXT()" value="0" tabindex="14" ID="cmbPartExternos0" checked>
	    Não&nbsp;
	</td>
</tr>
<tr>
	<td colspan="10">
		<%call ControleParticipantesExternos("Participantes",14)%>
	</td>
</tr>
<tr>
	<td colspan="10"> 
        &nbsp;&nbsp;<span class="vermelho2"><b>*</b></span>&nbsp;Participantes Embratel: &nbsp;
        <input type="radio" name="cmbPartEBT" onClick="PreparaCamposPART(this.form)" value="1" tabindex="21" ID="cmbPartEBT1">
        Sim&nbsp;
        <input type="radio" name="cmbPartEBT"  onClick="PreparaCamposPART(this.form)" value="0" tabindex="22" checked ID="cmbPartEBT0">
	    Não&nbsp;
	</td>
</tr>
<tr>
	<td colspan="10"> 
		<%call ControleParticipantesInternos("ParticipantesEBT",22, "", "", num_ag)%>
	</td>
</tr>
<tr>
	<td colspan="10">&nbsp;&nbsp;<span class="vermelho2"><b>*</b></span>&nbsp;<a href="javascript:;" title="Informar uma breve descrição e seu objetivo.">Breve descrição do objetivo principal da atividade:</font></a><br>
		&nbsp;&nbsp;<textarea name="objetivos" class="texto1" cols="120" rows="4"></textarea>
	</td>
</tr>
<tr>
	<td colspan="10"> 
        <p>&nbsp;&nbsp;<span class="vermelho2"><b>*</b></span>&nbsp;Atividade visa atender a cliente externo a Embratel: &nbsp;
        <input type="radio" name="cmbCliExternos" onClick="PreparaCamposCLI()" id ="cmbCliExternos1" value="1" tabindex="27">
        Sim&nbsp;
        <input type="radio" name="cmbCliExternos"  onClick="PreparaCamposCLI()" id ="cmbCliExternos0" value="0" tabindex="28">
	    Não&nbsp;
	</td>
</tr>
<tr>
	<td colspan="10">
		<%call ControleClientes("Cliente",28,objConn)%>
	</td>
</tr>
<tr>
	<td colspan="10">&nbsp;&nbsp;<span class="vermelho2"><b>*</b></span>&nbsp;</b><a href="javascript:;" title="Informar a necessidade de área util (m2), sala de apoio, mesa adicional ou rack para equipamento,pontos de energia e telefônicos (qtde/tipo), aterramento, armazenamento de materiais.">Ambiente Necessário:</a><br>
		&nbsp;&nbsp;<textarea name="ambiente" class="texto1" cols="120" rows="4"></textarea>
	</td>
</tr>
<tr>
	<td colspan="10">&nbsp;&nbsp;<span class="vermelho2"><b>*</b></span>&nbsp;</b><a href="javascript:;" title="Informar instrumentos, cabos, conectores, facilidades, interfaces, apoio técnico p/ execução, equipamento (HW/SW).">Recursos Necessários:</a></font><br>
		&nbsp;&nbsp;<textarea name="recursos" class="texto1" cols="120" rows="4"></textarea>
	</td>
</tr>
<tr>
	<td colspan="10">&nbsp;&nbsp;&nbsp;<a href="javascript:;" title="Informar documentos ou links de referência associadas a atividade ou informações complementares. Diagramas e arquivos podem ser anexados na próxima fase do cadastro ou enviado por e-mail para ilab@embratel.com.br com a identificação do agendamento.">Observações:</a><br>
		&nbsp;&nbsp;<textarea name="obs" class="texto1" cols="120" rows="4"></textarea>
	</td>
</tr>
<tr>
	<td colspan="10">&nbsp;</td>
</tr>
<tr height="34">
	<td colspan="10" align="left">&nbsp;&nbsp;
<%		if num_ag = "" then %>
		<input class="texto1" type="Button" name="btn_Salvar" onclick="ValidaCampos()" value=" &nbsp;&nbsp;Salvar Dados&nbsp;&nbsp;">
<%		else
			if bln_ehRAT then 'or bln_ehRT then%>
		<input class="texto1" type="Button" name="btn_Salvar" onclick="ValidaCampos()" value=" &nbsp;&nbsp;Salvar Dados&nbsp;&nbsp;">
<%			else %>
		<input type="Button" value=" &nbsp;&nbsp;Salvar Dados&nbsp;&nbsp;" disabled>
<%			end if
			if bln_usuarioCRT then %>
		<input class="texto1" type="Button" onclick="areaRAT()" value=" &nbsp;&nbsp;Área do RAT &nbsp;&nbsp;">
		<input class="texto1" type="Button" onclick="areaRT()" value=" &nbsp;&nbsp;Área do RT &nbsp;&nbsp;">
<%			end if %>
<%		end if %>
<%		If Env.Usuario = chr_Username Or bln_usuarioCRT Then %>
		<input class="texto1" type="Button" onclick="javascript:uploadArquivo()" value="Anexar Arquivos" title="Anexa um ou mais arquivos associados ao Agendamento">
<%		End If %>

<%'if not SolicitouCancela then%>
<!-- AQUI: AINDA NAO TERMINEI A IMPLANTACAO
		<input type="Button" value="Solicitar Cancelamento" title="Solicita o cancelamento deste Agendamento" onclick="javascript:solicitaCancelamentoAS();">
		<script language="JavaScript">
		function solicitaCancelamentoAS() {
			alert("oi");
		}
		</script>
-->
<%'end if%>
	</td>
</tr>
</table>
</form>
<iframe width="770" height="200" name="escondido" style="display: none;"></iframe>
<script>
	function uploadArquivo() {
<%if num_ag = "" then%>
		alert('ATENÇÃO !\n\nPara fazer upload este agendamento deve ser salvo');
<%else
	'-- se nao for RAT ou RT so podera fazer upload enquanto o AG estiver
	'-- na situação de cadastrado
	if situacao_ag <> AS_Cadastrado and not (bln_ehRAT or bln_ehRT) then%>
		alert('ATENÇÃO !\n\nEste agendamento não pode mais sofrer alterações, por favor\nentre em contato com o Responsável Técnico.');
<%	else%>
		var jan = window.open('cadAgendamentoUploadCliente.asp?agendamento=<%=num_ag%>', 'cadAgendamentoUploadCliente', 'toolbar=no,location=no,directories=no,status=no,menubar=no,scrollbars=yes,resizable=no,copyhistory=no,width=460,height=300,top=5,left=5');
		jan.focus();
<%	end if%>
<%end if%>
	}


	var frm = document.forms[0];
	var frmAll = document.all;
	var ultimo_da_lista;

	frm.txtResponsavel.style.backgroundColor = '#EEEEEE';
	frm.txtMatricula.style.backgroundColor = '#EEEEEE';
	frm.txtOrgao.style.backgroundColor = '#EEEEEE';
	frm.txtEMail.style.backgroundColor = '#EEEEEE';
	frm.txtRamal.style.backgroundColor = '#EEEEEE';
<%
'XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
'Pego dados do agendamento jah existente
'XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
if num_ag <> "" then

	Set Ebt = New TEbt

	Call Ebt.BuscaDadosEmbratel(objSiteRS("ag_username"))

	Nome_Reduzido = Ebt.NomeReduzido
	Matricula = Ebt.Matricula
	SiglaOrgao = Ebt.SiglaOrgao
	TEL1_COM = Ebt.Ramal
	bln_AchouEBT = Ebt.ehFuncionario

	sSQL = "Select * from participantes_externos where PE_QUEMINCLUIU = 'CLI' AND ag_numero = " & num_ag
	call Env.RecordSet( true, rsPart, sSQL)
	%>
	frm.hdAG.value = '<%=num_ag%>';
	<%if bln_AchouEBT then%>
		frm.txtResponsavel.value = '<%=Nome_Reduzido%>';
		frm.txtMatricula.value = '<%=Matricula%>';
		frm.txtOrgao.value = '<%=SiglaOrgao%>';
		frm.txtRamal.value='<%=TEL1_COM%>';
	<%else
		'Usuario não existe mais na base embratel%>
		frm.txtResponsavel.value = '<%=objSiteRS("ag_username")%>';
		frm.txtMatricula.value = '--';
		frm.txtOrgao.value = '<%=chr_OrgaoSQL%>';
		frm.txtRamal.value='--';
	<%end if%>
	frm.txtTitulo.value='<%=objSiteRS("ag_titulo")%>';
	frm.Username.value='<%=objSiteRS("ag_username")%>';
    frm.txtEMail.value='<%=objSiteRS("ag_username")%>';
	frm.diaINICIO.value = '<%= itoa(day(objSiteRS("ag_datainicio")),2)%>';
	frm.mesINICIO.value = '<%=itoa(month(objSiteRS("ag_datainicio")),2)%>';
	frm.anoINICIO.value = '<%=year(objSiteRS("ag_datainicio"))%>';
	frm.diaFIM.value = '<%=itoa(day(objSiteRS("ag_datatermino")),2)%>';
	frm.mesFIM.value = '<%=itoa(month(objSiteRS("ag_datatermino")),2)%>';
	frm.anoFIM.value = '<%=year(objSiteRS("ag_datatermino"))%>';
	frm.cmbTec.value = '<%=objSiteRS("tec_id")%>';
	frmAll.cmbSigilo<%=objSiteRS("ag_sigilo")%>.checked = true;
	//frmAll.cmbEmail<%'if objSiteRS("ag_recebemail") then response.write 1 else response.write 0%>.checked = true;

	frmAll.cmbCliExternos<%if IsNull(objSiteRS("ag_clienteexterno")) then response.write 0 else response.write 1%>.checked = true;
	PreparaCamposCLI();
	frm.txtNomeCliente.value = '<%=objSiteRS("ag_clienteexterno")%>';

	<%IF objSiteRS("AG_retornoCLIENTE") & ""  =  "" THEN%>
		frm.txtRetornoCliente.value = "0,00";
	<%ELSE%>
		frm.txtRetornoCliente.value = '<%=mid(formatcurrency(objSiteRS("AG_retornoCLIENTE")),4,len(formatcurrency(objSiteRS("AG_retornoCLIENTE"))))%>';
	<%END IF%>

	<%IF objSiteRS("AG_VALORCONTRATOCLIENTE") & ""  =  "" THEN%>
		frm.txtValorContratoCliente.value = "0,00";
	<%ELSE%>
		frm.txtValorContratoCliente.value = '<%=mid(formatcurrency(objSiteRS("AG_VALORCONTRATOCLIENTE")),4,len(formatcurrency(objSiteRS("AG_VALORCONTRATOCLIENTE"))))%>';
	<%END IF%>

	<%while not rsPart.eof%>
		<%if rsPart("PE_EMPRESA") = "EBT" then%>
			frmAll.cmbPartEBT1.checked = true;
			PreparaCamposPART();
			var lista = frm.lst<%="ParticipantesEBT"%>;
			ultimo_da_lista = lista.options.length;
			lista.options[ultimo_da_lista]=new Option('<%=rsPart("PE_USERNAME")%>' + ' <%=SEPARADOR_CAMPO%> ' + '<%=rsPart("PE_NOME")%>' + ' <%=SEPARADOR_CAMPO%> ' + '<%=rsPart("PE_MOTIVO")%>');
			lista.options[ultimo_da_lista].value = '<%=rsPart("PE_USERNAME")%>' + '<%=SEPARADOR_CAMPO%>' + '<%=rsPart("PE_NOME")%>' + '<%=SEPARADOR_CAMPO%>' + '<%=rsPart("PE_MOTIVO")%>';
		<%else%>
			frmAll.cmbPartExternos1.checked = true;
			PreparaCamposPARTEXT();
			var lista = frm.lst<%="Participantes"%>;
			ultimo_da_lista = lista.options.length;
			lista.options[ultimo_da_lista] = new Option('<%=rsPart("PE_NOME")%>' + ' <%=SEPARADOR_CAMPO%> ' + '<%=rsPart("PE_EMPRESA")%>' + ' <%=SEPARADOR_CAMPO%> ' + '<%=rsPart("PE_MOTIVO")%>');
			lista.options[ultimo_da_lista].value = '<%=rsPart("PE_NOME")%>' + '<%=SEPARADOR_CAMPO%>' + '<%=rsPart("PE_EMPRESA")%>' + '<%=SEPARADOR_CAMPO%>' + '<%=rsPart("PE_MOTIVO")%>';
		<%end if%>
<%
		rsPart.MOVENEXT
	wend%>
	frm.objetivos.value = '<%=strToTexto(objSiteRS("AG_OBJETIVO"))%>';
	frm.ambiente.value = '<%=strToTexto(objSiteRS("AG_AMBIENTE"))%>';
	frm.recursos.value = '<%=strToTexto(objSiteRS("AG_RECURSOS"))%>';
	frm.obs.value = '<%=strToTexto(objSiteRS("AG_OBSERVACAO"))%>';
<%else%>
	frm.txtResponsavel.value = '<%=Env.NomeReduzido%>';
	frm.txtMatricula.value = '<%=Env.Matricula%>';
	frm.txtOrgao.value = '<%=Env.SiglaOrgao%>';
	frm.Username.value='<%=Env.usuario%>';
    frm.txtEMail.value='<%=Env.Usuario%>';
	frm.txtRamal.value='<%=Env.Ramal%>';
<%end if
'XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
'XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX

'XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
'Pega uma as para usar como referência
'XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
if as_referencia <> "" then
	sSQL = "Select * from agendamento where ag_numero=" & as_referencia & ";"
	call Env.RecordSet( true, objSiteRS, sSQL)

	sSQL = "Select * from participantes_externos where PE_QUEMINCLUIU = 'RAT' AND ag_numero = " & as_referencia
	call Env.RecordSet( true, rsPart, sSQL)
	%>
	frm.asRef.value = <%=as_referencia%>;
	frm.cmbTec.value = '<%=objSiteRS("tec_id")%>';
	frm.txtTitulo.value='<%=objSiteRS("ag_titulo")%>';
	frmAll.cmbSigilo<%=objSiteRS("ag_sigilo")%>.checked = true;
	//frmAll.cmbEmail<%'if objSiteRS("ag_recebemail") then response.write 1 else response.write 0%>.checked = true;

	frmAll.cmbCliExternos<%if IsNull(objSiteRS("ag_clienteexterno")) Then response.write 0 Else response.write 1%>.checked = True;
	PreparaCamposCLI();
	frm.txtNomeCliente.value = '<%=objSiteRS("ag_clienteexterno")%>';

	<%If objSiteRS("AG_retornoCLIENTE") & ""  =  "" Then%>
		frm.txtRetornoCliente.value = '0,00';
	<%Else%>
		frm.txtRetornoCliente.value = '<%=mid(formatcurrency(objSiteRS("AG_retornoCLIENTE")),4,len(formatcurrency(objSiteRS("AG_retornoCLIENTE"))))%>';
	<%End If%>

	<%If objSiteRS("AG_VALORCONTRATOCLIENTE") & ""  =  "" Then%>
		frm.txtValorContratoCliente.value = "0,00";
	<%Else%>
		frm.txtValorContratoCliente.value = '<%=mid(formatcurrency(objSiteRS("AG_VALORCONTRATOCLIENTE")),4,len(formatcurrency(objSiteRS("AG_VALORCONTRATOCLIENTE"))))%>';
	<%End If%>

	<%While Not rsPart.eof%>
		<%if rsPart("PE_EMPRESA") = "EBT" Then%>
			frmAll.cmbPartEBT1.checked = true;
			PreparaCamposPART();
			var lista = frm.lst<%="ParticipantesEBT"%>;
			ultimo_da_lista = lista.options.length;
			lista.options[ultimo_da_lista]=new Option('<%=rsPart("PE_USERNAME")%>' + ' <%=SEPARADOR_CAMPO%> ' + '<%=rsPart("PE_NOME")%>' + ' <%=SEPARADOR_CAMPO%> ' + '<%=rsPart("PE_MOTIVO")%>');
			lista.options[ultimo_da_lista].value = '<%=rsPart("PE_USERNAME")%>' + '<%=SEPARADOR_CAMPO%>' + '<%=rsPart("PE_NOME")%>' + '<%=SEPARADOR_CAMPO%>' + '<%=rsPart("PE_MOTIVO")%>';
		<%else%>
			frmAll.cmbPartExternos1.checked = true;
			PreparaCamposPARTEXT();
			var lista = frm.lst<%="Participantes"%>;
			ultimo_da_lista = lista.options.length;
			lista.options[ultimo_da_lista] = new Option('<%=rsPart("PE_NOME")%>' + ' <%=SEPARADOR_CAMPO%> ' + '<%=rsPart("PE_EMPRESA")%>' + ' <%=SEPARADOR_CAMPO%> ' + '<%=rsPart("PE_MOTIVO")%>');
			lista.options[ultimo_da_lista].value = '<%=rsPart("PE_NOME")%>' + '<%=SEPARADOR_CAMPO%>' + '<%=rsPart("PE_EMPRESA")%>' + '<%=SEPARADOR_CAMPO%>' + '<%=rsPart("PE_MOTIVO")%>';
		<%end if%>
<%
		rsPart.MOVENEXT
	WEnd%>

	frm.objetivos.value = '<%=strToTexto(objSiteRS("AG_OBJETIVO"))%>';
	frm.ambiente.value = '<%=strToTexto(objSiteRS("AG_AMBIENTE"))%>';
	frm.recursos.value = '<%=strToTexto(objSiteRS("AG_RECURSOS"))%>';
	frm.obs.value = '<%=strToTexto(objSiteRS("AG_OBSERVACAO"))%>';
<%End If%>

<%If Env.EhRat() then
	If solicitante <> "" Then
		Set Ebt = New TEbt

		Call Ebt.BuscaDadosEmbratel(solicitante)

		If Ebt.ehFuncionario Then%>
			frm.txtResponsavel.value = '<%=Ebt.NomeReduzido%>';
			frm.txtMatricula.value = '<%=Ebt.Matricula%>';
			frm.txtOrgao.value = '<%=Ebt.SiglaOrgao()%>';
			frm.txtRamal.value='<%=Ebt.Ramal%>';
			frm.Username.value='<%=solicitante%>';
			frm.txtEMail.value='<%=solicitante%>';
		<%Else%>
			alert("Username Inválido!")
<%		End If
	End If%>
<%End If%>
</script>
<%
Set Ebt = Nothing

Call Tela.MostraRodape()
'Call imprimeRodape(RODAPE_OFF)
%>
