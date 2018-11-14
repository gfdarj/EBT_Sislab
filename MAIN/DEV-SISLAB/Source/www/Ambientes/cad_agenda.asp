<!--#include file="../includes/Sislab_Lib.asp"-->
<!--#include file="../includes/PadraoHTML.asp" -->
<!--#include file="../includes/global.asp" -->
<!--#include file="../includes/controlesHTML.asp" -->
<!--#include file="../includes/bib_str.asp" -->
<%
dim objRS, s
dim auxidagenda, auxdescricao, auxtitulo, auxdatainicio, auxdatafim
dim auxhorario, auxcontato,auxaltera, auxlocalizacao, auxas, auxresponsavel

Call Tela.ImprimeCabecalho2(TITULO_SITE, MENU_ON, true, "", "Cadastro de Reserva de Ambientes", "location.href='sel_Cad_Agenda.asp'", "../")
%>
<script type="text/javascript">
function AtualizaData() {
	var datainicio, datatermino, dataas;
	// var inputedData =  prompt ("type something!", "" );
	dataas=document.formulario.as.options[document.formulario.as.selectedIndex].text;
	datainicio  = dataas.substring(0,10);
	datatermino = dataas.substring(11,21);
	
	if (confirm("Você quer atualizar as datas da reserva com as datas do agendamento?")) {
		document.formulario.datainicio.value=datainicio
		document.formulario.datafim.value=datatermino
	}
}

function ValidaCampos()	{
	var d = document.formulario;
	var dI = d.anoInicio.value + '' + d.mesInicio.value + '' + d.diaInicio.value;
	var dF = d.anoFim.value + '' + d.mesFim.value + '' + d.diaFim.value;

	if (document.formulario.titulo.value=="")	{
		alert("Título do Evento em Branco.\nComplete o Campo Título do evento.");
		return false;
	}
	if((d.diaInicio.value == '') || (d.mesInicio.value == '') || (d.anoInicio.value == '') || (d.diaFim.value == '') || (d.mesFim.value == '') || (d.anoFim.value == '')) {
		alert('O período informado é inválido');
		return false;
	}
	if(dI > dF)	{
		alert('Data inicial é maior que a data final');
		return false;
	}
	if (document.formulario.descricao.value=="")	{
		alert("Descrição do Evento em Branco.\nComplete o Campo Descrição.");
		return false;
	}
	if (document.formulario.responsavel.value=="")	{
		alert("Responsável pela marcação do Evento em Branco.\nSelecione um Responsável pelo evento.");
			return false;
	}
	if (document.formulario.localizacao.value==0)	{
		alert("Ambiente do Evento em Branco.\nComplete o Campo Localização.");
		return false;
	}			
	document.formulario.submit();
}
function Apagar(){
	document.formulario.tipocomando.value = "apagar";
	document.formulario.submit();
}
function abreLista() {
	var j = window.open('cons_agenda.asp');
	j.focus();
}
</script>
<%
if (IsEmpty(request.form("sel"))) Then
	auxselecao=0
     else
	auxselecao=CInt(trim(request.form("sel")))
End if

s = "Select RAM_id, RAM_descricao, RAM_Titulo, RAM_horario, RAM_contato, AMB_ID, RAM_AS, RAM_Responsavel, CONVERT(VARCHAR, RAM_datainicio, 103) as RAM_DATAINICIO, CONVERT(VARCHAR, RAM_datafim, 103) AS RAM_datafim " & _
	"from reserva_ambientes " & _
	"Where RAM_id=" & auxselecao & ";"
call Env.RecordSet( true, objRS, s)

If Not objRS.EOF Then
    objRS.Movefirst
	auxIDagenda=objRS("RAM_id")
	auxdescricao=objRS("RAM_descricao")
	auxtitulo=objRS("RAM_Titulo")
	auxdatainicio=objRS("RAM_datainicio")
	auxdatafim=objRS("RAM_datafim")
	auxhorario=objRS("RAM_horario")
	auxcontato=objRS("RAM_contato")
	auxlocalizacao=objRS("AMB_ID")
	auxas=objRS("RAM_AS")
	auxresponsavel=Ucase(objRS("RAM_Responsavel"))
	auxaltera="Alterar"
else
	auxaltera="Cadastrar"
End if

call Env.RecordSet( false, objRS, null)
%>
<form method="post" action="ins_cad_agenda.asp" name="formulario">
<input type=hidden name=tipocomando value="<%=auxaltera%>">
<input type=hidden name=selecao value="<%=auxidagenda%>">
<input type=hidden name=tipotxt value="-1">
<input type=hidden name=acao value="-1">
<table width="100%" cellspacing="0" cellpadding="3" class="table-bordered">
<tr>
	<td width="75px">&nbsp;Título:</td>
	<td>
		<input type="text" value="<%=auxtitulo%>" name="titulo" size="80" >
		&nbsp;&nbsp;&nbsp;
		<input type="button"  value=" Ver Reservas " onclick="javascript:abreLista();">
	</td>
</tr>
<tr>
	<td>&nbsp;Data Inicio:</td>
	<td>
		<%call comboData("Inicio")%>
		&nbsp;&nbsp;&nbsp;&nbsp;
		Data Fim:&nbsp;
		<%call comboData("Fim")%>

<%if IsDate(auxdatainicio) then%>
		<script type="text/javascript">
			document.forms[0].diaInicio.value = '<%=Zeros(Day(auxdatainicio),2)%>';
			document.forms[0].mesInicio.value = '<%=Zeros(Month(auxdatainicio),2)%>';
			document.forms[0].anoInicio.value = '<%=Year(auxdatainicio)%>';
		</script>
<%end if%>
<%if IsDate(auxdatafim) then%>
		<script type="text/javascript">
			document.forms[0].diaFim.value = '<%=Zeros(Day(auxdatafim),2)%>';
			document.forms[0].mesFim.value = '<%=Zeros(Month(auxdatafim),2)%>';
			document.forms[0].anoFim.value = '<%=Year(auxdatafim)%>';
		</script>
<%end if%>
	</td>
</tr>

<tr>
	<td>&nbsp;Horário:</td>
	<td>
		<input type="text" name="horario"  size="50" value="<%=auxhorario%>">
		&nbsp;&nbsp;&nbsp;&nbsp;
	</td>
</tr>
<tr>
	<td>&nbsp;Responsável:</td>
	<td>	
<%
s = "Select * From UserCRT  where  Exibir=1 order by Nome asc; "
call Env.RecordSet( true, objRS, s)

If Not objRS.EOF Then
	objRS.MoveFirst%>
		<select name="responsavel" >
		<option value="">Selecione o Responsável</option>
<%	do while not objRS.EOF%>
		<option value=<%=Ucase(objRS("userid"))%>><%=Ucase(objRS("userid"))%> - <%=left(objRS("Nome"),40)%></option> 
<%		objRS.movenext
	loop%>
		</select><%
end if%>
	</td>
</tr>
<tr>
	<td>&nbsp;Descrição:</td>
	<td><textarea name=descricao cols="100" rows="6" ><%=auxdescricao%></textarea></td>
</tr>
<tr>
	<td>&nbsp;Localização:</td>
	<td>
<%
'-- pego os ambientes que não são reservados por AS, nestes, a reserva é feita pelo
'-- cadastro de agendamento / área do RAT
s = "Select * From Ambientes WHERE AMB_USADOPORAG = 0 order by AMB_Nome asc;"
call Env.RecordSet( true, objRS, s)
If Not objRS.EOF Then
	objRS.MoveFirst%>
		<select name="localizacao" >
		<option value=0>Selecione o Ambiente a ser usado</option>
	 <% do while not objRS.EOF %>
		<option value=<%=objRS("AMB_ID")%>><%=objRS("AMB_Nome")%></option> 
	<%objRS.movenext%>
	<%loop%>
		</select>
<%  end if %>
	</td>
</tr>
<tr>
	<td>Agendamento:</td>
	<td><%call comboAgendamento("txtas", "as", Env.oConn, "", "N")%></td>
</tr>
<tr>
	<td>&nbsp;Contato:</td>
	<td><textarea name="contato" cols="100" rows="3" ><%=auxcontato%></textarea></td>
</tr>
<tr><td colspan="2">&nbsp;</td></tr>
<tr>
	<td colspan="2">
		<input type="button" value="Cadastrar"  onClick="ValidaCampos();">
<% if auxaltera="Alterar" then%>
		<input type="button" value="Cancelar Reserva"  onClick="Apagar();">&nbsp;
<%end if%>
	</td>
</tr>
</table>
</form>

<script type="text/javascript">
<%if auxlocalizacao <> "" then%>
	document.formulario.localizacao.value=<%=auxlocalizacao%>
<%end if%>
<%if auxas <> 0 then%>
	document.formulario.as.value=<%=auxas%>
<%end if%>
<%if auxresponsavel <> "" then%>
	document.formulario.responsavel.value='<%=auxresponsavel%>'
<%end if%>
</script>

<%
call Tela.MostraRodape()
%>
