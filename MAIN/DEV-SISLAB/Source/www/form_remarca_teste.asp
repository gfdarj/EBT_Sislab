<!--#include file="includes/Sislab_Lib.asp"-->
<!--#include file="includes/PadraoHTML.asp" -->
<!--#include file="includes/global.asp" -->
<%
Dim Ebt

Set Ebt = New TEbt

'call ImprimeCabecalho2(TITULO_SITE, MENU_ON, true, "", "Cancelamento ou Remarcação de Testes/Ensaios", "", "")
call ImprimeCabecalho2(TITULO_SITE, MENU_ON, true, "", "Remarcação de Agendamento", "", "")

Env.ArmazenaCaminhoAnterior()

Response.Buffer = true

Dim rs_agendamento
Dim num_agendamento, num_erro, desc_erro, i, mes(12)
Dim data_inicio, data_termino, tecnologia, nome_responsavel, matricula, orgao, email, ramal, remarcado 

function formataData(pData)
	Dim auxData, dia, mes, ano
	dia = day(pData)
	mes = month(pData)
	ano = year(pData)
	if dia \ 10 = 0 then 
		auxData = "0" & dia
	else
		auxData = dia
	end if
	if mes \ 10 = 0 then
		auxData = auxData & "/0" & mes
	else
		auxData = auxData & "/" & mes
	end if
	formataData = auxData & "/" & ano
End function

mes(1) = "janeiro"
mes(2) = "fevereiro"
mes(3) = Server.HTMLEncode("março")
mes(4) = "abril"
mes(5) = "maio"
mes(6) = "junho"
mes(7) = "julho"
mes(8) = "agosto"
mes(9) = "setembro"
mes(10) = "outubro"
mes(11) = "novembro"
mes(12) = "dezembro"

num_agendamento = request("cmbNumeroAgendamento")

sSQL = "Select *, convert(smalldatetime, AG_DATAINICIO, 103) as dti, convert(smalldatetime, AG_DATATERMINO, 103) as dtf"
sSQL = sSQL & " from AGENDAMENTO A LEFT JOIN TECNOLOGIA AT ON A.TEC_ID = AT.TEC_ID "
sSQL = sSQL & " where AG_NUMERO = " & num_agendamento

call Env.RecordSet( true, rs_agendamento, sSQL)

if rs_agendamento.eof then
	Response.Clear 
	rs_agendamento.Close
	set rs_agendamento = nothing
	num_erro = Server.URLEncode("-1")
	desc_erro = Server.URLEncode("Esse regisrto foi apagado")
	Consite.Close
	set Consite = nothing
	Response.Redirect "erro.asp?perro=" & num_erro & "&pdescricao=" & desc_erro 
end if

data_inicio = rs_agendamento("dti")
data_termino = rs_agendamento("dtf")
remarcado = rs_agendamento("AG_FLAGREMARCACAO")
If isNull(remarcado) Then
	remarcado = false
Else
	remarcado = CBool(rs_agendamento("AG_FLAGREMARCACAO"))
End If

tecnologia = rs_agendamento("TEC_NOME")


Call Ebt.BuscaDadosEmbratel(rs_agendamento("AG_USERNAME"))

If Ebt.EhFuncionario Then
	nome_responsavel = Ebt.Nome_Reduzido
	matricula = Ebt.MATRICULA
	ramal = Ebt.TEL1_COM
Else
	nome_responsavel = "xxxx"
	matricula = "xxxx"
	ramal = "xxxx"
End If

Set Ebt = nothing


orgao = rs_agendamento("AG_ORGAO")
email = rs_agendamento("AG_USERNAME") & "@embratel.com.br"

rs_agendamento.Close
set rs_agendamento = nothing
%>

<script language="JavaScript">
var msgMotivo,remarca
msgMotivo = "O campo 'Motivo do Cancelamento' deve ser preenchido."
remarca = 0
//=========================================================================================
function montaInicio()
{
	var frm = document.frmRemarcaTeste
	if(frm.cmbInicio_dia.value != "0" && frm.cmbInicio_mes.value != "0" && frm.cmbInicio_ano.value != "0")
		frm.txtInicio.value = frm.cmbInicio_dia.value +"/"+ frm.cmbInicio_mes.value +"/"+ frm.cmbInicio_ano.value;
	else
		frm.txtInicio.value = "";
}
//=========================================================================================
function montaFim()
{
	var frm = document.frmRemarcaTeste
	if(frm.cmbFim_dia.value != "0" && frm.cmbFim_mes.value != "0" && frm.cmbFim_ano.value != "0")
		frm.txtFim.value = frm.cmbFim_dia.value +"/"+ frm.cmbFim_mes.value +"/"+ frm.cmbFim_ano.value;
	else
		frm.txtFim.value = "";
}
//=========================================================================================
function isDate(pdata)
{
	var dia, mes, ano;
	var meses = new Array(31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31);
	dia = pdata.substr(0, 2);
	mes = pdata.substr(3, 2);
	ano = pdata.substr(6, 4);
	if (ano%4 == 0)
		meses[1] = 29;
	return(mes>=1 && mes<=12 && dia>=1 && dia<=meses[mes-1]);
}
//=========================================================================================
function InicioMaiorFim()
{
	var frm = document.frmRemarcaTeste
	var inicio = new Date(frm.cmbInicio_ano.value, frm.cmbInicio_mes.value-1, frm.cmbInicio_dia.value)
	var fim = new Date(frm.cmbFim_ano.value, frm.cmbFim_mes.value-1 , frm.cmbFim_dia.value)
	return(inicio>fim)
}
//=========================================================================================
function validaDataInicio()
{
	var frm = document.frmRemarcaTeste
	var hoje = new Date();
	var inicio = new Date(frm.cmbInicio_ano.value, frm.cmbInicio_mes.value-1, frm.cmbInicio_dia.value)
	var limite = new Date()
	limite.setMonth(6) //limite de seis meses
	return(hoje<inicio && inicio<=limite)
}
//=========================================================================================
function validaCampos(form)
//Valida os campos quando o formulário é submetido
{
	if (form.txtInicio.value == "" &&  remarca == 1) 
	{
		alert("O campo 'Período previsto para teste/Início' deve ser preenchido.");
		form.cmbInicio_dia.focus();
		return(false);
	}
	else if (!isDate(form.txtInicio.value) &&  remarca == 1) 
	{
		alert("O campo 'Período previsto para teste/Início' deve ser preenchido com uma data válida.");
		form.cmbInicio_dia.focus();
		return(false);
	}
	else if (form.txtFim.value == "" && remarca == 1) 
	{
		alert("O campo 'Período previsto para teste/Fim' deve ser preenchido.");
		form.cmbFim_dia.focus();
		return(false);
	}

	else if (!isDate(form.txtFim.value) && remarca == 1) 
	{
		alert("O campo 'Período previsto para teste/Fim' deve ser preenchido com uma data válida.");
		form.cmbFim_dia.focus();
		return(false);
	}
	else if (InicioMaiorFim() && remarca == 1) 
	{
		alert("O campo 'Período previsto para teste/Inicio' deve ser preenchido com a data de 'Inicio' anterior a data de 'Fim'.");
		form.cmbInicio_dia.focus();
		return(false);
	}
	else if (form.txaMotivo.value == "") 
	{
		alert(msgMotivo);
		form.txaMotivo.focus();
		return(false);
	}
	else
		return(true);
}
//=========================================================================================

function voltar()
{
<%if Env.ehRAT then%>
	location.href = 'sislab.ASP';
<%else%>
	location.href = 'index.ASP';
<%end if%>
}

function PreparaCampos(f)
{
	frm1 = document.all;
//	if( f.cmbCancelar[ 0 ].checked ){
//		frm1.tabAgendamento.style.display = 'none';
//		frm1.TabMotivo.innerHTML = "&nbsp;&nbsp;Motivo do Cancelamento:&nbsp;";
//		msgMotivo = "O campo 'Motivo do Cancelamento' deve ser preenchido.";
//		remarca = 0;
//		//frm1.OSCelula.innerHTML = "<input type='Hidden' name = 'cmbOs' value ='-1'/>"
//	}
//	else{
		frm1.tabAgendamento.style.display = 'block';
		frm1.TabMotivo.innerHTML = "&nbsp;&nbsp;Motivo da Remarcação:&nbsp;";
		msgMotivo = "O campo 'Motivo da Remarcação' deve ser preenchido.";
		remarca = 1;
//	}
}
//=========================================================================================

</script>

<form method="post" action="form_remarca_testeA.asp" name="frmRemarcaTeste" onSubmit="return validaCampos(this);">
<input type="hidden" name="txtInicioAnt" value="<%=data_inicio%>">
<input type="hidden" name="txtFimAnt" value="<%=data_termino%>">
<input type="hidden" name="txtNum_agendamento" value="<%= num_agendamento%>">

<input type="hidden" name="txtUsernameSol" value="<%=email%>">
<input type="hidden" name="txtNomeSol" value="<%=nome_Responsavel%>">

<TABLE border=0 cellSpacing=0 width="100%" class="tabela1">
	<TR>
		<TD></TD>
		<TD></TD>
		<TD></TD>
		<TD></TD>
		<TD></TD>
		<TD></TD>
		<TD></TD>
		<TD></TD>
		<TD></TD>
		<TD></TD>
	</TR>
	<tr>
		<td colspan="10"> 
			<p>
			<!--<input type="radio" name="cmbCancelar" onClick="PreparaCampos(this.form)" value="1" tabindex="13" checked /><font class="opcao">Cancelamento&nbsp;-->
			<!--<input type="radio" name="cmbCancelar" onClick="PreparaCampos(this.form)" value="0" tabindex="14" checked/><font class="opcao">Remarcação&nbsp;-->
			<input type="radio" name="cmbCancelar" value="0" tabindex="13" checked/><font class="opcao">Remarcação</fonte>
			</p>
		</td>
	</tr>

	<%If remarcado Then%>
	<TR height="34">
		<TD colSpan=10>
			&nbsp;&nbsp;<b>Este teste está aguardando validação de remarcação</b>
		</TD>
	</TR>
	<%End If%>
	<tr height="34"> 
		<td  colspan="10" id="tabAgendamento" style="display: none;">
			&nbsp;&nbsp;Período previsto para teste:&nbsp;
			&nbsp;&nbsp;Início:&nbsp;
			<input type="hidden" name="txtInicio" size="10" value="<%=formataData(data_inicio)%>">
			<select name="cmbInicio_dia" class="combo" tabindex="7" onchange="montaInicio()" <%'if data_inicio < date() then response.write "disabled"%>>
				<option value="0" selected></option>
				<%For i=1 to 31
					if (i \ 10) = 0 then%>
						<option value="0<%=i%>" <%if day(data_inicio) = i then response.write "selected"%>><%=i%></option>
					<%else%>
						<option value="<%=i%>" <%if day(data_inicio) = i then response.write "selected"%>><%=i%></option>
					<%end if%>
				<%Next%>
			</select>/
			<select name="cmbInicio_mes" class="combo" tabindex="8" onchange="montaInicio()" <%'if data_inicio < date() then response.write "disabled"%>>
				<option value="0" selected></option>
				<%For i=1 to 12
					if (i \ 10) = 0 then%>
						<option value="0<%=i%>" <%if month(data_inicio) = i then response.write "selected"%>><%=mes(i)%></option>
					<%else%>
						<option value="<%=i%>" <%if month(data_inicio) = i then response.write "selected"%>><%=mes(i)%></option>
					<%end if%>
				<%Next%>
			</select>/
				<select name="cmbInicio_ano" class="combo" tabindex="9" onchange="montaInicio()" <%'if data_inicio < date() then response.write "disabled"%>>
				<option value="0" selected></option>
				<%For i=year(date())-1 to year(date())+1%>
					<option value="<%=i%>" <%if year(data_inicio) = i then response.write "selected"%>><%=i%></option>
				<%Next%>
			</select>
	
			&nbsp;&nbsp;&nbsp;&nbsp;Fim:&nbsp;
			<input type="hidden" name="txtFim" size="10" tabindex="7" value="<%=formataData(data_termino)%>">
			<select name="cmbFim_dia" class="combo" tabindex="10" onchange="montaFim()">
				<option value="0" selected></option>
				<%For i=1 to 31
					if (i \ 10) = 0 then%>
						<option value="0<%=i%>" <%if day(data_termino) = i then response.write "selected"%>><%=i%></option>
					<%else%>
						<option value="<%=i%>" <%if day(data_termino) = i then response.write "selected"%>><%=i%></option>
					<%end if%>
				<%Next%>
			</select>/
			<select name="cmbFim_mes" class="combo" tabindex="11" onchange="montaFim()">
				<option value="0" selected></option>
				<%For i=1 to 12
					if (i \ 10) = 0 then%>
						<option value="0<%=i%>" <%if month(data_termino) = i then response.write "selected"%>><%=mes(i)%></option>
					<%else%>
						<option value="<%=i%>" <%if month(data_termino) = i then response.write "selected"%>><%=mes(i)%></option>
					<%end if%>
				<%Next%>
        	</select>/
			<select name="cmbFim_ano" class="combo" tabindex="12" onchange="montaFim()">
				<option value="0" selected></option>
				<%For i=year(date())-1 to year(date())+1%>
					<option value="<%=i%>" <%if year(data_termino) = i then response.write "selected"%>><%=i%></option>
				<%Next%>
        	</select>
		</td>
	</tr>
	<TR height="34">
		<TD colSpan=5>
			&nbsp;&nbsp;Tecnologia:&nbsp;
			<%=tecnologia%>
			
		</TD>
		<TD colSpan=5>
			
				<b>Nº do Agendamento:&nbsp;<%= num_agendamento%></b>
			
		</TD>
	</TR>
	<TR height="34"> 
		<td colspan="7">
			&nbsp;&nbsp;Nome do Responsável: &nbsp; <%= nome_responsavel%>
	    </td>
	    <td colspan="3">
              &nbsp;&nbsp;Matrícula:&nbsp; <%=matricula%>
		</td>
	</tr>
	<tr height="34">	
		<td  colspan="3">
			&nbsp;&nbsp;Órgão:&nbsp; <%= orgao%>
		</td>
		<td  colspan="4">
			&nbsp;&nbsp;E-mail:&nbsp; <%= email%>
		</td>
		<td  colspan="3"> 
			&nbsp;&nbsp;Ramal:&nbsp; <%= ramal%>
	    </td>
	</tr>

    <tr height="34"> 
        <td valign="top" colspan="2" id="TabMotivo">
			&nbsp;&nbsp;Motivo do Cancelamento:&nbsp;
        </td>
        <td valign="top" colspan="8">
          	<TEXTAREA class="texto1" cols=80 name=txaMotivo rows=3 tabIndex=28></TEXTAREA>
        </td>
    </tr>
</TABLE>
<br><br>
  <p align="center"> 
    <input class="texto1" type="submit" value="    Ok    " name="btnOk" style="width: 80px;">
    <input class="texto1" type="button" name="Submit2" value="Voltar" onclick="voltar()" style="width: 80px;">
  </p>
</form>
<script language="JavaScript">
	/*** O cancelamento pelo usuario foi retirado em 29/01/2007 ***/
	PreparaCampos(null);
</script>
<%
Call imprimeRodape(RODAPE_OFF)

if Err.number <> 0 then
	Response.Redirect "erro.asp?perro=" & Server.URLEncode(Err.number) & "&pdescricao=" & Server.URLEncode(Err.description) 
end if
%>
