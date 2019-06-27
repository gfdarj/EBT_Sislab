<!--#include file="includes/Sislab_Lib.asp"-->
<!--#include file="includes/global.asp" -->
<!--#include file="includes/PadraoHTML.asp" -->
<!--#include file="includes/controleshtml.asp" -->
<!--#include file="includes/funcoes.asp" -->
<%
Dim ssql, motivo, num_ag, num_os, nova_os, servico, plataforma, eq_id
Dim int_Repetido, os_observacoes, hora, id_situacao
'Dim dataAS

num_ag = request("num_ag")
num_os = request("num_os")
nova_os = request("novaOs")
motivo = ""
id_situacao = ""
situacao_atual = "null"
int_Repetido = 0
os_observacoes = ""
hora = Now

'-- OS Existente
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
Else
    sSQL = "SELECT AG_DATAINICIO FROM Agendamento WHERE ag_numero = " & num_ag 
	Call Env.RecordSet(true, objSiteRS, sSQL)

	If Not (objSiteRS.Eof And objSiteRS.Bof) Then
        hora = objSiteRS("AG_DATAINICIO")
    Else
        hora = Now
    End If
End If

'If num_ag <> "" Then
'    sSQL = "SELECT AG_DATAINICIO FROM Agendamento WHERE ag_numero = " & num_ag 
'	Call Env.RecordSet(true, objSiteRS, sSQL)
'
'	If Not (objSiteRS.Eof And objSiteRS.Bof) Then
'        dataAS = objSiteRS("AG_DATAINICIO")
'    End If
'Else
'    dataAS = Now
'End If

Call Tela.ImprimeCabecalho2("Ordem de Serviço - AS " & NUM_AG, MENU_OFF, false, "100%", "Cadastro de Ordem de Serviço", "window.close()", "")
%>
<script type="text/javascript" src="includes/anexo.js"></script>

<script type="text/javascript">
    function Historico(){
	    var strurl
	    strurl = "eventosinternos.asp?hdnEvento=10&num_os=" + '<%=num_os%>' + "&num_ag=" + '<%=num_ag%>'
	    window.open(strurl,'','toolbar=no,location=no,directories=no,status=no,menubar=no,scrollbars=yes,resizable=no,copyhistory=no,width=400,height=300,top=0,left=0');
    }

    function avaliaSituacao()
    {
	    var frm = document.forms[0];
		var _horaINICIO = "<%=itoa(HOUR(hora),2)%>";
		var _minutoINICIO = "<%=itoa(MINUTE(hora),2)%>";
		var _diaINICIO = "<%=itoa(DAY(hora),2)%>";
		var _mesINICIO = "<%=itoa(MONTH(hora),2)%>";
        var _anoINICIO = "<%=YEAR(hora)%>";

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

            frm.horaINICIO.value = _horaINICIO;
		    frm.minutoINICIO.value = _minutoINICIO;
		    frm.diaINICIO.value = _diaINICIO;
		    frm.mesINICIO.value = _mesINICIO;
		    frm.anoINICIO.value = _anoINICIO;

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

    function envia()
    {
        var frm = document.forms[0];
        var dataHoje = "<%=Year(hora) & Right("0" & Month(hora), 2) & Right("0" & Day(hora), 2)%>";
        var horaHoje = "<%=Right("0" & Hour(hora), 2) & Right("0" & Minute(hora), 2)%>";

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
        else if (frm.anoINICIO.value + frm.mesINICIO.value + frm.diaINICIO.value < dataHoje)
	    {
		    alert("Selecione uma Data de Início maior ou igual ao Agendamento");
		    frm.diaINICIO.focus();
	    }
        else if (frm.horaINICIO.value == "")
	    {
		    alert("Selecione a hora de início");
		    frm.horaINICIO.focus();
	    }
	    else if(frm.minutoINICIO.value == "")
	    {
		    alert("Selecione o minuto de início");
		    frm.minutoINICIO.focus();
        }
        else if (frm.horaINICIO.value + frm.minutoINICIO.value < horaHoje)
	    {
		    alert("Selecione uma Hora de Início maior ou igual ao Agendamento");
		    frm.horaINICIO.focus();
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

<div class="margem-10">
    <form name="frm" method="post">
    <input type="hidden" name="hdnTeste">
    <input type="hidden" name="hdnSituacao">
    <input type="hidden" name="hdnEvento" value="9">
    <input type="hidden" name="num_os" value="<%=num_os%>">
    <input type="hidden" name="num_ag" value="<%=num_ag%>">
    <input type="hidden" name="nova_os" value="<%=nova_os%>">

    <div class="linha-fundo" style="width: 100%">
        <strong>Ordem de Serviço Nº <%=num_os%></strong>
<%If int_Repetido > 0 Then %>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
        <span class="glyphicon glyphicon-repeat" title="Repetição" style="color: darkblue;"></span>
        &nbsp;&nbsp;<b>Esta OS está marcada para repetição</b>
<%End If%>
    </div>

    <table class="table-condensed" border="0" style="width: 100%;">
    <tr valign="middle">
	    <th align="left">
		    Controle da Situação da Ordem de Serviço
	    </th>
	    <th width="200px" style="text-align: right; margin-right: 20px;">
		<%if nova_os = "0" then%>
			<a href="javascript:Historico();">Histórico</a>
		<%else%>
			<small>Sem Histórico</small>
		<%end if%>
	    </th>
    </tr>
    <tr>
	    <td colspan="2">
		    Situação:&nbsp;
		    <select name="cmbSituacao"  onchange="avaliaSituacao();">
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
	    <td colspan="2" height="34" id="dadosSituacao1">
		    Data Início:&nbsp;<%call comboData("INICIO")%>
            <span id="dadosSituacao2">
                &nbsp;&nbsp;&nbsp;&nbsp;
                Hora Início:&nbsp;<%call comboHorario("INICIO")%>
            </span>
	    </td>
    </tr>
    <tr>
	    <td colspan="2" id="dadosSituacao3">Motivo ( Somente em caso de mudança de Situação ):</font><br>
		    <textarea name="motivo"  cols="110" rows="4"><%=motivo%></textarea>
		    <textarea name="motivo_old"  style="display:none;"><%=motivo%></textarea>
	    </td>
    </tr>
    </table>

    <br />
    <div class="linha-fundo" style="width: 100%"><strong>Equipamento e Teste Associado</strong></div>

<!--XXXXXXXXXXXXXXXXXXXXXXX  EQUIPAMENTO XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX-->
    <table class="table-condensed">
    <tr>
	    <td colspan="2">
		    Equipamento (Atenção: Deve ter sido reservado pelo SCE)&nbsp;<br>
<%		'-- eq´s movimentado e amostra
		ssql = _
			"SELECT e.EQ_ID as valor, e.EQ_CODIGOBARRAS + ' - ' + e.MOD_DESCRICAO as descricao " & _
			"   FROM vw_SCE_Equipamentos_Fabricantes e INNER JOIN SCE_Reserva_Equipamentos r " & _
			"   ON e.EQ_ID = r.EQ_ID " & _
			"WHERE r.AG_NUMERO = " & num_ag & " AND r.REQ_MOVIMENTOU = 1 /* AND r.REQ_EQSETUP = 'A' */ " & _
			"   AND e.EQ_ID NOT IN (SELECT EQ_ID_AMOSTRA FROM Ordem_de_Servico os WHERE os.AG_NUMERO = " & num_ag & " " & _
			"   AND os.EQ_ID_AMOSTRA = e.EQ_ID) "

			if nova_os = "0" then
				ssql = ssql & _
					"UNION " & _
					"SELECT e.EQ_ID as valor, e.EQ_CODIGOBARRAS + ' - ' + e.MOD_DESCRICAO as descricao " & _
					"FROM vw_SCE_Equipamentos_Fabricantes e INNER JOIN Ordem_de_Servico os1 " & _
					"   ON e.EQ_ID = os1.EQ_ID_AMOSTRA " & _
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
			Plataforma ou Sistema utilizado no teste<br>
			<%call comboBDSQL("cmbPlataforma", objConn, "SELECT S_ID as valor, S_DESCRICAO as descricao FROM Servicos_Plataformas WHERE S_SERVICO = 0 ORDER BY S_DESCRICAO", plataforma, true)%>
		</td>
    </tr>
    <tr>
	    <td colspan="2">
			Serviço ou Solução utilizada no teste<br>
			<%call comboBDSQL("cmbServico", objConn, "SELECT S_ID as valor, S_DESCRICAO as descricao FROM Servicos_Plataformas WHERE S_SERVICO = 1 ORDER BY S_DESCRICAO", servico, true)%>
		</td>
	</tr>
    <tr>
	    <td colspan="2">Observação:<br>
			<textarea name="obs"  cols=110 rows=4 ><%=os_observacoes%></textarea>
	    </td>
    </tr>
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

    <script type="text/javascript">
    var frm = document.forms[0];
<%'if nova_os = "0" then
'	    If Not VVVNZ(hora) Then %>
	    frm.horaINICIO.value = "<%=itoa(HOUR(hora),2)%>";
	    frm.minutoINICIO.value = "<%=itoa(MINUTE(hora),2)%>";
	    frm.diaINICIO.value = "<%=itoa(DAY(hora),2)%>";
	    frm.mesINICIO.value = "<%=itoa(MONTH(hora),2)%>";
	    frm.anoINICIO.value = "<%=YEAR(hora)%>";
<%'	End If %>
	    //frm.obs.value = '<%'=objSiteRS("os_observacoes")%>';
	    frm.hdnSituacao.value = '<%=id_situacao%>';

	    avaliaSituacao();
<%'end if%>
	    var	frm1 = document.all;
    </script>

</div>
<%
if nova_os = "0" then
	Call Env.RecordSet(false, objSiteRS, null)
end if

Call Tela.MostraRodape()
%>
