<!------- SCE ------->
<!--#include file="includes/global_SCE.asp"-->
<!------- SISLAB ---->
<!--#include file="../includes/bib_str.asp"-->
<!--#include file="../includes/padraoHTML.asp"-->
<!--#include file="../includes/global.asp" -->   <!-- constantes usada pelo menu -->
<!--#include file="../includes/Geral_Lib.asp"-->
<!--#include file="../includes/Sislab_Lib.asp"-->
<!------- LIB ------->
<!--#include file="../Classes/Classe_Sce.asp"-->
<%
'-- GERA UMA LISTAGEM DE RESERVAS MOSTRANDO TODOS OS EQUIPAMENTOS, SELECIONADOS PELA
'-- CONSULTA DE RESERVAS
Server.ScriptTimeout = 10000

Dim ssql, where, agnumero, agtemp, ReservaOK, ehRelatorio, nomeTela
Dim contaAS, ehReservado, dt_inicio, dt_termino, abrir_como, ambiente

abrir_como = UCase(request("abrir_como"))

'-- parametro que define se o form veio de uma consulta ou relatorio
if abrir_como = "REL" then
	ehRelatorio = True 
	Tela.SetNomeTela = "SCE > Relatório > Reserva de Equipamento"
else
	ehRelatorio = False
	Tela.SetNomeTela = "SCE > Consulta > Reserva de Equipamento"
end if

Tela.SetCaminhoRelativo = "../"
Call Tela.MostraCabecalho()

If Env.UsuarioSCE() Then
    Dim Sce
    Set Sce = New TSce

    Call Tela.ImprimeMenuSce()

    ssql =	"SELECT * " & _
		    "FROM vw_SCE_Reserva_Equipamentos "

    where = ""

    '-- se for alteracao de reserva, nao preciso mostrar os equipamentos movimentados
    if abrir_como <> "REL" then
	    if where <> "" then where = where & " AND "
	    where = where &"REQ_MOVIMENTOU = 0 "
    end if

    if request("ag_numero") <> "" then
	    if where <> "" then where = where & " AND "
	    where = where &"AG_NUMERO = " & request("ag_numero") & " "
    end if
    if request("ag_responsavel") <> "" then
	    if where <> "" then where = where & " AND "
	    where = where &"RES_RESPONSAVEL = '" & request("ag_responsavel") & "' "
    end if
    if request("codbarras") <> "" then
	    if where <> "" then where = where & " AND "
	    where = where &"EQ_CODIGOBARRAS like '%"& trim(request("codbarras")) &"%' "
    end if
    if request("fabricante") <> "" then
	    if where <> "" then where = where & " AND "
	    where = where &"FAB_ID = " & request("fabricante") & " "
    end if
    if request("modelo") <> "" then
	    if where <> "" then where = where & " AND "
	    where = where &"MOD_CODNOME like '%"& trim(request("modelo")) &"%' "
    end if
    if request("desc_modelo") <> "" then
	    if where <> "" then where = where & " AND "
	    where = where &"MOD_DESCRICAO like '%"& trim(request("desc_modelo")) &"%' "
    end if
    if request("numeroserie") <> "" then
	    if where <> "" then where = where & " AND "
	    where = where &"EQ_NUMEROSERIE like '%" & trim(request("numeroserie")) &"%' "
    end if
    if request("conforme") <> "" then
	    if where <> "" then where = where & " AND "
	    where = where &"EQ_CONFORME = " & request("conforme") & " "
    end if
    if request("status") <> "" then
	    if where <> "" then where = where & " AND "
	    where = where &"STATUS = " & request("status") & " "
    end if
    if request("instrumental") <> "" then
	    if where <> "" then where = where & " AND "
	    where = where & "EQ_INSTRUMENTAL = " & request("instrumental") & " "
    end if
    if request("propriedade") <> "" then
	    if where <> "" then where = where & " and "
	    where = where &" EQ_PROPRIEDADE IN ('" & request("propriedade") & "') "
    end if

    if request("diainicio") <> "" and request("mesinicio") <> "" and request("anoinicio") <> "" then
	    dt_inicio = "'" & request("diainicio") & "/" & request("mesinicio") & "/" & request("anoinicio") & "'"
    else
	    dt_inicio = ""
    end if
    if request("diatermino") <> "" and request("mestermino") <> "" and request("anotermino") <> "" then
	    dt_termino = "'" & request("diatermino") & "/" & request("mestermino") & "/" & request("anotermino") & "'"
    else
	    dt_termino = ""
    end if

    if dt_inicio <> "" then
	    if where <> "" then where = where & " AND "

	    if dt_termino = "" then dt_termino = "getdate() + 1"

	    where = where & _
		    "(CONVERT(datetime, " & dt_inicio & ", 103) BETWEEN REQ_DATAINICIO AND REQ_DATATERMINO) " & _
		    "OR (CONVERT(datetime, " & dt_termino & ", 103) BETWEEN REQ_DATAINICIO AND REQ_DATATERMINO) "
    end if

    if where <> "" then where = " where " & where & " "

    ssql = ssql & where & "order by RES_DATACADASTRO, AG_NUMERO, AMB_NOME, EQ_CODIGOBARRAS;"

    'response.write "<!--SQL:" & ssql & "-->"
    'response.end

    Set rec = Server.CreateObject("ADODB.Recordset")
    rec.ActiveConnection = Env.oConn
    rec.Open ssql, Env.oConn, adOpenKeyset, adLockPessimistic, adCmdText

    '-- se nao for relatorio entao mostro opcoes de mostrar planilha e/ou fazer a movimentacao
    If Not ehRelatorio Then
%>	<script type="text/javascript">
	function geraPlanilhaReserva(agnumero) {
		var sql = "<%=where%>";
		if(sql.search(/where/gi) == -1) sql += " where "; else sql += " AND ";
		sql += "AG_NUMERO = " + agnumero;
		window.open("sel_cad_reserva2_xls.asp?sql="+sql+"&ag_numero="+agnumero, 'reservaXLS');
		//'menubar = 1, status = 1, toolbar = 1, scrollbars= 1, resizeable=1'
	}
	</script>
<%  end if %>

<table width="100%" >
<%
    if rec.eof and rec.bof then%>
    <tr>
	    <td align="center" ><i>Nenhuma reserva encontrada !</i></td>
    </tr>
<%  else %>
    <tr><td class="destaque">Listagem de reservas por ordem de cadastro</td></tr>
    <tr><td ><i>Os itens em destaque (<span class="vencido">&nbsp;&nbsp;</span>) est&atilde;o sendo utilizados em mais de uma reserva.</i></td></tr>
</table>

<br />

<%
While Not rec.eof
    ambiente = ""
	contaAS = 1
	agnumero = rec("AG_NUMERO")
	obs = rec("RES_OBSERVACAO")
	If IsNull(obs) Then obs = "" End If
%>
<table width="100%" border="0"  cellpadding="0" cellspacing="0">
    <tr class="linha_par">
	    <th>AS</th>
	    <th>Dt In&iacute;cio</th>
	    <th>Dt T&eacute;rmino</th>
	    <th>Respons&aacute;vel</th>
	    <th><%If ehRelatorio Then Response.Write "&nbsp;" Else Response.Write "Planilha XLS" End If %></th>
    </tr>
	<tr class="linha_par">
        <td align="center"><a href="cad_reserva.asp?ag_numero=<%=rec("AG_NUMERO")%>"><b><%=rec("AG_NUMERO")%></b></a></td>
		<td align="center"><b><%=FormataData(rec("AG_DATAINICIO"), null)%></b></td>
		<td align="center"><b><%=FormataData(rec("AG_DATATERMINO"), null)%></b></td>
		<td align="center"><b><%if isnull(rec("RES_RESPONSAVEL")) then response.write "&nbsp;" else response.write rec("RES_RESPONSAVEL")%></b></td>
		<td align="center">
<%		    If Not ehRelatorio Then%>
				<b>(<a href="#" onclick="javascript:geraPlanilhaReserva(<%=rec("AG_NUMERO")%>);">Gerar</a>)</b>
<%		    Else%>
				&nbsp;
<%		    End If%>
		</td>
	</tr>
    <tr><td>&nbsp;</td></tr>
</table>

<center>

<table width="90%" border="0"  cellpadding="0" cellspacing="0">
<%  If Not IsNull(rec("EQ_ID")) Then %>

<%      agtemp = rec("AG_NUMERO") %>
<%      While (Not rec.Eof) And (agnumero = IIf(VVVN(rec("AG_NUMERO")), 0, rec("AG_NUMERO"))) %>
<%	        If ambiente <> rec("AMB_NOME") Then %>
<%              If ambiente <> "" Then %>
            </table>
        </td>
    </tr>
	<tr><td>&nbsp;</td></tr>
<%              End If %>
	<tr><td><font color="#008080"><p><b><%=rec("AMB_NOME")%></b>&nbsp;</p></font></td></tr>
	<tr><td>&nbsp;</td></tr>
	<tr>
		<td>
			<table width="100%" border="1"  cellpadding="2" cellspacing="0" style="border: none ;">
			<tr>
                <th>#</th>
				<th>C&oacute;d Barras</th>
				<th>Modelo</th>
				<th>Descri&ccedil;&atilde;o</th>
				<th>Fabricante</th>
				<th>Num. S&eacute;rie</th>
				<th>Dt. In&iacute;cio</th>
				<th>Dt. T&eacute;mino</th>
				<th>Aceito</th>
			</tr>
<%		    End If %>

<%			ehReservado = Trim(Sce.VerificaReservaItem(false, agnumero, rec("EQ_ID"), false))

		    If ehReservado <> "" then%>
			<tr class="vencido">
<%			Else%>
			<tr>
<%			End If%>
                <td><%=contaAS%></td>
			    <td><b><%if IsNull(rec("EQ_CODIGOBARRAS")) then response.write "&nbsp;" else response.write rec("EQ_CODIGOBARRAS")%></b></td>
			    <td><%=rec("MOD_CODNOME")%></td>
			    <td><%=rec("MOD_DESCRICAO")%></td>
			    <td><%=rec("FAB_NOME")%></td>
			    <td><%if IsNull(rec("EQ_NUMEROSERIE")) then response.write "&nbsp;" else response.write InsereBR(rec("EQ_NUMEROSERIE"),10)%></td>
			    <td><%=FormataData(rec("REQ_DATAINICIO"), null)%></td>
			    <td><%=FormataData(rec("REQ_DATATERMINO"), null)%></td>
			    <td align="center">
<%  			'-- MOSTRO COMBO DE ACEITE PARA CASO NAO TENHA TIDO NENHUMA RESERVA ACEITA
	    		'-- RESERVA ACEITA = MOVIMENTACAO FEITA
		    If rec("REQ_MOVIMENTOU") or session("status") = PERFIL_RAT or ehRelatorio then
				If Not IsNull(rec("REQ_ACEITO")) Then response.write SimNao(rec("REQ_ACEITO")) else response.write "--" End If
			Else %>
				    <select name="aceite_<%=agnumero%>_<%=contaAS%>" >
					    <option value="__<%=rec("EQ_ID")%>">--</option>
					    <option value="1_<%=rec("EQ_ID")%>" <%if rec("REQ_ACEITO") = 1 then response.write "selected"%>>Sim</option>
					    <option value="0_<%=rec("EQ_ID")%>" <%if rec("REQ_ACEITO") = 0 then response.write "selected"%>>Não</option>
				    </select>
<%		    End If
			contaAS = contaAS + 1    %>
				</td>
			</tr>

<%			if ehReservado <> "" then%>
			<tr class="vencido">
<%		    else%>
			<tr>
<%		    end if%>
			    <td colspan="9"><i>
				    Localiza&ccedil;&atilde;o:&nbsp;<%=rec("EQ_LOCALIZACAO")%>
				    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
				    Status:&nbsp;<%=rec("DESC_STATUS")%>
				    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
				    Instrumental:&nbsp;<%=SimNao(rec("EQ_INSTRUMENTAL"))%>
				    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
				    Conforme:&nbsp;<%=SimNao(rec("EQ_CONFORME"))%>
    <%				    if ehReservado <> "" then%>
				    <br><b>Reserva(s):<%=ehReservado%></b>
    <%				    end if%>
				    </i>
			    </td>
			</tr>
<%
            agnumero = rec("AG_NUMERO")
            ambiente = rec("AMB_NOME")
            agtemp = rec("AG_NUMERO")   'fiz isso porque dava erro !!!
            rec.MoveNext
            
	    WEnd 'Loop pelo agendamento

    	If obs <> "" Then%>
			<tr>
				<td colspan="9">
					<table  cellpadding="0" cellspacing="0" width="100%">
					<tr>
						<td width="60px" valign="top"><i>Observação:</i></td>
						<td><i><%=Replace(obs, VbCrLf, "<br>")%></i></td>
					</tr>
					</table>
				</td>
			</tr>
<%      End If%>
		    </table>

<%	    ReservaOK = Sce.ReservaFechada(agnumero)

		If Env.PerfilSce <> PERFIL_RAT and (not ReservaOK) and (not ehRelatorio) then%>
		    <p align="right"><input type="button"  value="Aceitar AS <%=agnumero%>" onclick="javascript:movimentarAS(<%=agnumero%>, <%=contaAS-1%>);">&nbsp;&nbsp;&nbsp;&nbsp;</p>
<%	    Elseif ReservaOK then%>
    		<p align="right"><i>Reserva da AS <%=agnumero%> movimentada pela Log&iacute;stica</i></p>
<%		End if%>
        </td>
    </tr>
    <tr><td>&nbsp;</td></tr>
    <tr><td>&nbsp;</td></tr>
<%  End If

    If Not (rec.Eof Or rec.BOF) Then
        rec.MoveNext 
    End If

    If contaAS mod 6 Then
        Response.Flush
    End If
WEnd
%>
</table>
</center>

<iframe style="display: none;" name="escondido"></iframe>

<form name="formulario" action="sel_cad_reserva2_aceite.asp">
    <input type="hidden" name="ag_numero" value="">
    <select name="lista_itens" style="display: none; width:500px" multiple></select>
    <input type="hidden" name="tudoAceitoOK" value="SIM">
</form>

<script type="text/javascript">
function movimentarAS(ag_numero, total_itens) {
	var i, oOption, itemOK = true;

	document.all.lista_itens.length = 0;  // limpa o select
	document.all.ag_numero.value = ag_numero;
	for(i=1; i<= total_itens; i++)
	{	// CONCATENO O SELECT COM O ACEITE + O ID DO EQUIPAMENTO, APENAS SE TODOS OS EQUIPAMENTOS
		// ESTIVEREM MARCADOS COMO ACEITO É CHAMADA A TELA DE MOVIMENTACAO
		// "1_" para ACEITO, "0_" para NAO ACEITO e "__" para nao escolhido
		if(document.all["aceite_" + ag_numero + "_"+i].value.substr(0,1) != "1") {
			itemOK = false;  // algum item esta como Não ou sem aceite
		}
		oOption = document.createElement("OPTION");
		document.all.lista_itens.options.add(oOption);

		oOption.innerText = document.all["aceite_" + ag_numero + "_"+i].value;
		oOption.value = oOption.innerText;
		oOption.selected = true;
	}

	if( !itemOK ) {
		document.all.tudoAceitoOK.value = "NAO";
		if(!confirm("ATENÇÂO !\n\nExistem itens não aceitos ou não verificados.\n\nDeseja mesmo assim gravar a aceitação ?")) {
			return false;
		}
	}
	else
		document.all.tudoAceitoOK.value = "SIM";

	if(document.all.lista_itens.length > 0) {
		document.formulario.target = "escondido";
		document.formulario.submit();
	}
	else
		alert("ERRO !\n\nNenhum item foi incluído na lista");
}
</script>
<%
    End If 'eof

    Set Sce = Nothing
Else
    RW Tela.Mensagem.AcessoRestritoSCE()
End If

Call Tela.MostraRodape()
%>
