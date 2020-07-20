<!--#include file="includes/Sislab_Lib.asp"-->
<!--#include file="includes/controlesHTML.asp" -->
<!--#include file="includes/PadraoHTML.asp" -->
<!--#include file="includes/global.asp" -->
<!--#include file="includes/funcoes.asp" -->
<%
Dim num_ag, necessita_OS
num_ag = request("hdAG")

Tela.SetMostraMenu = MENU_ON
Tela.SetMostraImagem = True
Tela.SetNomeTela = "Cadastro de Agendamento - RT"
Tela.SetLinkVoltar = ""
Call Tela.MostraCabecalho()
'''''Call Tela.ImprimeCabecalho2(TITULO_SITE, MENU_ON, true, "", "Cadastro de Agendamento - RT", "", "")
%>

<script type="text/javascript">
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


<div class="margem-10">

<form method="post" action="novoCadAgendamentoClienteA.asp" name="frmAgendaTeste">
<input type="hidden" name="hdAG" value="<%=num_ag%>">
<input type="hidden" name="strParticipantesEBT">

<table border="0" width="100%" class="">
<tr> 
	<td>
		<b><span class="texto-vermelho-bold">*</span>&nbsp; Indica um Campo Obrigatório</b></td>
		<td align="right"><b><span class="menu">Agendamento Nº &nbsp;<%=num_ag%></span></b></td>
</tr>
</table>

<br />

<div style="width: 100%;" class="linha-fundo"><strong>Criação de Ordens de Serviço</strong></div>

<table border="0" width="100%%" cellspacing="0" class="table-condensed">
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
<tr valign="top"> 
	<td colspan="7" valign="top">
		Ordem de Serviços Associadadas:<br>
		<select name="lstdisposicao" size="5" 
            style="LINE-HEIGHT: 50px; PADDING-TOP: 3px; WIDTH: 600px"
		>
	</td>
	<td colspan="3" valign="top">
		<%if Env.ehRAT or Env.ehRT then%>
			<input type="button" class="btn btn-primary" name="btAcao" value="Criar Nova OS" onClick="NovaOS()" style="width:150px;"/><br><br>
			<input type="button" class="btn btn-primary" name="btAlterar" value="Alterar OS" onClick="AbreOS()" style="width:150px;"/><br><br>
			<input type="button" class="btn btn-primary" name="btAcaoRem" value="Remover OS" onClick="RemoveOS()" style="width:150px;"/><br><br>
		<%else%>
			<input type="button" class="btn btn-primary" name="btAcao" value="Criar Nova OS" onClick="" disabled/><br><br>
			<input type="button" class="btn btn-primary" name="btAlterar" value="Visualizar OS" onClick="AbreOS()"/><br><br>
			<input type="button" class="btn btn-primary" name="btAcaoRem" value="Remover OS" onClick="" disabled/><br><br>
		<%end if%>			
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

<!--XXXXXXXXXXXXXXXXXXXXXXX  SISTEMA XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX-->
<tr style="font-weight: lighter;">
	<td style="font-weight: lighter;" colspan="10">
<%	sql = "Select convert(varchar,S_ID) + ' - ' + S_Descricao as valor , S_Descricao as descricao from Servicos_Plataformas where S_SERVICO = 0 ORDER BY S_Descricao"
	CALL ControleComboMultiplo("Sistema", "Plataformas ou Sistemas utilizados", "Plataforma ou Sistema", sql, "9")%>
	</td>
</tr>

<!--XXXXXXXXXXXXXXXXXXXXXXX  SERVIÇO XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX-->
<tr style="font-weight: lighter;">
	<td style="font-weight: lighter;" colspan="10">
<%	sql = "Select convert(varchar,S_ID) + ' - ' + S_Descricao as valor , S_Descricao as descricao from Servicos_Plataformas where S_SERVICO = 1 ORDER BY S_Descricao"
	CALL ControleComboMultiplo("Servico", "Serviço ou Solução utilizadas", "Serviço ou Solução", sql, "9")%>
	</td>
</tr>

<tr>
    <td colspan="10">
        <div style="width: 100%;" class="linha-fundo"><strong>Relatório de andamento de agendamentos (interno CRT)</strong></div>
    </td>
</tr>
<tr>
    <td colspan="10">
        Relatório de Agendamento:<br>
	    <textarea name="relatAS"  cols="145" rows="12"></textarea>
    </td>
</tr>
<tr>
    <td colspan="10">
	    <%if Env.ehRAT or Env.ehRT then%>
		    <input type="button" class="btn btn-primary" onclick="ValidaCampos()" value=" &nbsp;&nbsp;Salvar Dados&nbsp;&nbsp;"/>
	    <%else%>
		    <input type="button"class="btn btn-primary" value=" &nbsp;&nbsp;Salvar Dados&nbsp;&nbsp;" disabled/>
	    <%end if%>
	    <input type="button" class="btn btn-primary" onclick="areaCliente()" value=" &nbsp;&nbsp;Área do Cliente &nbsp;&nbsp;"/>
	    <input type="button" class="btn btn-primary" onclick="areaRAT()" value=" &nbsp;&nbsp;Área do RAT &nbsp;&nbsp;"/>
    </td>
</tr>
</table>

</form>

    <iframe width="770" height="200" name="escondido" style="display: none;"></iframe>

    <br />
</div>

<script type="text/javascript">
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

    function Recarrega() {
	    window.location.replace("CadAgendamentoRT.asp?hdAG=<%=num_ag%>")
    }

    function RemoveOS()
    {
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
    function AbreOS()
    {
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
            janela = window.open("CadAgendamentoOS.asp?num_ag=<%=num_ag%>&num_os=" +
                lista[cta_id].value + "&novaOS=0",
                "cad_contato",
                "width=830, height=700, resizable=yes, toolbar=no, status=yes, menubar=no, scrollbars=yes");
	        janela.focus();
        }
    }

    function NovaOS()
    {
    <%if necessita_os then%>
	    var janela;
        janela = window.open("CadAgendamentoOS.asp?num_ag=<%=num_ag%>&num_os=<%=ultima0S+1%>&novaOS=1",
            "cad_contato",
            "width=830, height=700, resizable=yes, toolbar=no, status=yes, menubar=no, scrollbars=yes");
	    janela.focus();
    <%else%>
	    alert("ATENÇÃO !\n\nEste agendamento não necessita de OS. Veja com o seu RAT a necessidade de criação de OS´s.");
    <%end if%>
    }
</script>
<%
Call Tela.MostraRodape()
%>
