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
	nome_responsavel = Ebt.NomeReduzido
	matricula = Ebt.MATRICULA
	ramal = Ebt.Ramal
Else
	nome_responsavel = "xxxx"
	matricula = "xxxx"
	ramal = "xxxx"
End If

Set Ebt = nothing


orgao = rs_agendamento("AG_ORGAO")
email = rs_agendamento("AG_USERNAME")

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
	frm1 = document.forms[0];
	//frm1.tabAgendamento.style.display = 'block';
	//frm1.TabMotivo.innerHTML = "&nbsp;&nbsp;Motivo da Remarcação:&nbsp;";
	msgMotivo = "O campo 'Motivo da Remarcação' deve ser preenchido.";
	remarca = 1;
}
//=========================================================================================

</script>

<form method="post" action="form_remarca_testeA.asp" name="frmRemarcaTeste" onSubmit="return validaCampos(this);">
    <input type="hidden" name="txtInicioAnt" value="<%=data_inicio%>">
    <input type="hidden" name="txtFimAnt" value="<%=data_termino%>">
    <input type="hidden" name="txtNum_agendamento" value="<%= num_agendamento%>">

    <input type="hidden" name="txtUsernameSol" value="<%=email%>">
    <input type="hidden" name="txtNomeSol" value="<%=nome_Responsavel%>">

    <p style="margin-left: 10px;">
        <!--<input type="radio" name="cmbCancelar" onClick="PreparaCampos(this.form)" value="1" tabindex="13" checked /><font class="opcao">Cancelamento&nbsp;-->
        <!--<input type="radio" name="cmbCancelar" onClick="PreparaCampos(this.form)" value="0" tabindex="14" checked/><font class="opcao">Remarcação&nbsp;-->
        <input type="radio" name="cmbCancelar" value="0" tabindex="13" checked/><font class="opcao">Remarcação</fonte>
    </p>

<%If remarcado Then%>
    <p>&nbsp;&nbsp;<b>Este teste está aguardando validação de remarcação</b></p>
<%End If%>

    <p style="margin-left: 10px;">
        <div id="tabAgendamento">
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
        </div>
    </p>

    <p>
        <div style="width: 400px; display:inline-block; margin-left: 10px;"><b>Nº do Agendamento:&nbsp;<%= num_agendamento%></b></div>
	    <div style="display:inline-block; margin-left: 10px;">Tecnologia:&nbsp;<%=tecnologia%></div>
    </p>

    <p>
        <div style="width: 400px; display:inline-block; margin-left: 10px;">Nome do Responsável: &nbsp; <%= nome_responsavel%></div>
	    <div style="display:inline-block; margin-left: 10px;">Matrícula:&nbsp; <%=matricula%></div>
    </p>

    <p>
        <div style="width: 400px; display:inline-block; margin-left: 10px;">E-mail:&nbsp; <%= email%></div>
	    <div style="width: 200px; display:inline-block; margin-left: 10px;">Órgão:&nbsp; <%= orgao%></div>
	    <div style="width: 200px; display:inline-block; margin-left: 10px;">Ramal:&nbsp; <%= ramal%></div>
    </p>

    <p >
        <div style="vertical-align: top; margin-left: 10px;">
            <div style="display:inline-block; vertical-align:top;">Motivo do Cancelamento:</div>
	        <div style="display:inline-block; vertical-align: top;"><TEXTAREA class="texto1" cols=80 name=txaMotivo rows=3 tabIndex=28></TEXTAREA></div>
        </div>
    </p>

    <br>

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
