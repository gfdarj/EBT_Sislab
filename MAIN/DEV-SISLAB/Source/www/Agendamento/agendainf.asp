<!--#include file="includes\cabecalho.inc"-->
<!--#include file="../includes/conexao.inc"-->
<% 
Dim data, dI, mI, aI, dF, mF, aF
Dim tpid, atividade, tipo_atividade, observacao

atividade = "-1"
tipo_atividade = 1
dI = ""
mI = "-1"
aI = year(date)
dF = ""
mF = "-1"
aF = year(date)

Dim objConn, objRS
call Connection(True, objConn)

if (Request.form("tpid") <> "-1") AND (Request.form("tpid") <> "") Then
  tpid = Request.form("tpid")
	call RecordSet(True, objRS, "SP_CONSULTA_TAREFA "&tpid, objConn)
  if not objrs.eof then
		atividade = objRS("TAREFA_ID")
		if objRS("TAREFA_TIPO") then
			tipo_atividade = 1
		else
			tipo_atividade = 0
		end if
		observacao = objRS("TP_OBSERVACAO")
	  dI = day(objrs("TP_DATAINICIAL"))
	  mI = right("0"&month(objrs("TP_DATAINICIAL")),2)
	  aI = year(objrs("TP_DATAINICIAL"))
	  dF = day(objrs("TP_DATAFINAL"))
	  mF = right("0"&month(objrs("TP_DATAFINAL")),2)
	  aF = year(objrs("TP_DATAFINAL"))
	end if
	call RecordSet(False, objRS, null, null)
else
	tpid = "-1"
end if
%>
<html>
<head>
	<title>Agendamento</title>
<!-- Atribui os estilos apropriados para cada resolucao -->
<!--#include file="includes\verificaResolucao.inc"-->
<!-- Funcao isDate (data), onde data = dd/mm/aaaa -->
<script type="text/javascript" src="includes\isDate.js"></script>
<script type="text/javascript">
function mudaAtividade()
{
	var frm = document.frmInicioTermino;
	if (frm.tarefa_id.value == "-2")
	{
		document.all.tarefa_id.style.display = "none";
		document.all.nova_tarefa.style.display = "block";
		frm.nova_tarefa.focus();
	}
}

function alocar()
{
	if (validaForm())
	{
	  var frm = document.frmInicioTermino;
		frm.action = "alocar.asp";
		frm.method = "post";
		frm.target = "escondido";
		frm.submit();
	}
}

function relocar()
{
	if (validaForm())
	{
		var frm = document.frmInicioTermino;
		if (confirm("Deseja realmente relocar esta Tarefa?"))
		{
			frm.action = "relocar.asp";
			frm.method = "post";
			frm.target = "escondido";
			frm.submit();
		}
	}
}

function remover()
{
  var frm = document.frmInicioTermino;
	if (confirm("Deseja realmente remover esta Alocação?"))
	{
		frm.action = "remover.asp";
		frm.method = "post";
		frm.target = "escondido";
		frm.submit();
	}
}

function mudaTipo(valor,selecionado)
{
  var frm = document.frmInicioTermino;
  frm.action = "mudaTipo.asp?tipo="+valor+"&selecionado="+selecionado;
 	frm.target = "escondido";
	frm.method = "post";
  frm.submit();
}

//retorna =0 datas iguais; >0 data2 > data1; <0 data2 < data1
function comparaData(data1, data2) //formato dd/mm/aaaa
{
	ii = new Date(Date.UTC(data1.substring(6,10), data1.substring(3,5), data1.substring(0,2), 0, 0)) 
	ff = new Date(Date.UTC(data2.substring(6,10), data2.substring(3,5), data2.substring(0,2), 0, 0)) 
	return (ff-ii);  
}

function validaForm()
{
  var frm = document.frmInicioTermino;
	var frm1 = parent.frames[0].document.formSuperior;
	frm.pes_username.value = frm1.nome.value;
	if (parseFloat(frm.diaInicio.value) < 10)
		frm.tp_datainicial.value = "0"+parseFloat(frm.diaInicio.value)+"/"+frm.mesInicio.value+"/"+frm.anoInicio.value;
	else	frm.tp_datainicial.value = frm.diaInicio.value+"/"+frm.mesInicio.value+"/"+frm.anoInicio.value;
	if (parseFloat(frm.diaFim.value) < 10)
		frm.tp_datafinal.value = "0"+parseFloat(frm.diaFim.value)+"/"+frm.mesFim.value+"/"+frm.anoFim.value;
	else	frm.tp_datafinal.value = frm.diaFim.value+"/"+frm.mesFim.value+"/"+frm.anoFim.value;
	if (frm.pes_username.value == -1)
	{
		alert("Escolha o Responsável!");
		frm1.nome.focus();
		return;
	}
	if (frm.tarefa_id.value == -1)
	{
		alert("Defina uma Atividade!");
		frm.tarefa_id.focus();
		return;
	}
	if (!isDate(frm.tp_datainicial.value))
	{
		alert("Data Inicial Inválida!");
		frm.diaInicio.focus();
		return;
	}
	if (!isDate(frm.tp_datafinal.value))
	{
		alert("Data Final Inválida!");
		frm.diaFim.focus();
		return;
	}
	if (comparaData(frm.tp_datainicial.value, frm.tp_datafinal.value) < 0)
	{
		alert("Data Inicial superior à data de Término!");
		frm.diaFim.focus();
		return;
	}
	return true;
}

function inicial()
{
  var frm = document.frmInicioTermino;
  frm.mesInicio.value = "<%=mI%>";
  frm.mesFim.value = "<%=mF%>";
	frm.tarefa_id.value = "<%=atividade%>";
	frm.tarefa_tipo[<%=tipo_atividade%>].checked = true;
}

function limpa()
{
  var frm = document.frmInicioTermino;
  frm.tpid.value = "-1";
  frm.action = "agendainf.asp";
  frm.target = "inferior";
	parent.frames[0].gravacookie("flag_2=1");
  frm.submit();
/*
	frm.tarefa_id.disabled = false;
	frm.tp_observacao.disabled = false;
	frm.tarefa_tipo[0].disabled = false;
	frm.tarefa_tipo[1].disabled = false;
*/
	parent.frames[1].limpaMarcados();
}

function verificaVoltar()
{
	if (parent.frames[0].lecookie("flag_2")=="0")
		window.parent.location.replace("default.htm");
}

</SCRIPT>
</head>
<body bgcolor="#FFFFFF" TOPMARGIN="10" leftmargin="3" ONLOAD="inicial();">
<FORM NAME="frmInicioTermino" METHOD="post">
<table width="774" border=0>
<tr>
  <td>
    <font class="fonte2">Atividade:</font>
	</td>
	<td><table border="0" cellpadding="0" cellspacing="0"><tr>
	<td id="atividadeCelula">
    <font class="fonte2">
		<SELECT NAME="tarefa_id" class="select7" onchange="mudaAtividade()">
	  <OPTION VALUE="-1" selected> -- Escolha a Atividade --
<%if tipo_atividade = 0 then
		call RecordSet(True, objRS, "select * from agendamento order by ag_numero desc", objConn)
		If not(objRS.EOF AND objRS.BOF) Then
			While( NOT( objRS.EOF ) )%>
				<option value="<%=objRS("AG_NUMERO")%>"><%=objRS("AG_NUMERO")%>: <%=objRS("AG_OBJETIVO")%>
<%			objRS.MoveNext
			Wend
		End If
	else%>
			<option value="-2"> --    Nova Tarefa    -- 
<%	call RecordSet(True, objRS, "select * from tarefas order by tar_descricao", objConn)
		If not(objRS.EOF AND objRS.BOF) Then
			While( NOT( objRS.EOF ) )%>
				<option value="<%=objRS("TAR_ID")%>"><%=objRS("TAR_DESCRICAO")%>
<%			objRS.MoveNext
			Wend
		End If
	end if
	Call RecordSet(False, objRS, Null, Null)
	Call Connection(False, objConn)
%>
    </SELECT>
		</font>
		<INPUT type="text" NAME="nova_tarefa" MAXLENGTH="250" class="texto7" style="display:none;">
	</td>
	<td>
    <input type="radio" name="tarefa_tipo" value="0" onclick="mudaTipo(0,-1)"><font class="fonte2">AS</font>
    <input type="radio" name="tarefa_tipo" value="1" onclick="mudaTipo(1,-1)"><font class="fonte2">Tarefa</font>
	</td></tr></table>
	</td>
  <td>
		<font class="fonte2">Início:</font>
	</td>
	<td>
		<INPUT type="text" NAME="diaInicio" MAXLENGTH="2" class="texto05" VALUE="<%=dI%>"> /
		<font class="fonte2">
		<SELECT NAME="mesInicio" class="select1">
	    <OPTION VALUE="-1"> -Mês-
	    <OPTION VALUE="01"> Jan
	    <OPTION VALUE="02"> Fev
	    <OPTION VALUE="03"> Mar
	    <OPTION VALUE="04"> Abr
	    <OPTION VALUE="05"> Mai
	    <OPTION VALUE="06"> Jun
	    <OPTION VALUE="07"> Jul
	    <OPTION VALUE="08"> Ago
	    <OPTION VALUE="09"> Set
	    <OPTION VALUE="10"> Out
	    <OPTION VALUE="11"> Nov
	    <OPTION VALUE="12"> Dez
	  </SELECT> /
	  <INPUT type="text" NAME="anoInicio" MAXLENGTH="4"  VALUE="<%=aI%>">
	</td>
<tr>
  <td>
    <font class="fonte2">Observação:</font>
	</td>
	<td>
    <font class="fonte2">
		<textarea name="tp_observacao" class="list9" rows="2" cols="10"><%= observacao%></textarea>
		</font>
	</td>
  <td>
		<font class="fonte2">Término:</font>
	</td>
	<td>
	  <INPUT type="text" NAME="diaFim" VALUE="<%=dF%>" MAXLENGTH="2" class="texto05"> /
		<font class="fonte2">
	  <SELECT NAME="mesFim" class="select1">
	    <OPTION VALUE="-1"> -Mês-
	    <OPTION VALUE="01"> Jan
	    <OPTION VALUE="02"> Fev
	    <OPTION VALUE="03"> Mar
	    <OPTION VALUE="04"> Abr
	    <OPTION VALUE="05"> Mai
	    <OPTION VALUE="06"> Jun
	    <OPTION VALUE="07"> Jul
	    <OPTION VALUE="08"> Ago
	    <OPTION VALUE="09"> Set
	    <OPTION VALUE="10"> Out
	    <OPTION VALUE="11"> Nov
	    <OPTION VALUE="12"> Dez
	  </SELECT>
	  </font> /
	  <INPUT type="text" NAME="anoFim" MAXLENGTH="4"  VALUE=<%=aF%>>
	</td>
</tr>
</table>
	<INPUT type="hidden" NAME="data" VALUE=<%= data%>> 
  <INPUT type="hidden" NAME="tpid" value=<%= tpid%>>
	<INPUT type="hidden" NAME="tp_datainicial" value="">
  <INPUT type="hidden" NAME="tp_datafinal" value="">
  <INPUT type="hidden" NAME="pes_username" value="">
<table width="774" border=0>
<tr>
 <%if tpid <> "-1" then%>
 	<script>
/*
		document.frmInicioTermino.tarefa_id.disabled = true;
		document.frmInicioTermino.tp_observacao.disabled = true;
		document.frmInicioTermino.tarefa_tipo[0].disabled = true;
		document.frmInicioTermino.tarefa_tipo[1].disabled = true;
*/
	</script>
	<td align="center">
    <INPUT type="button" NAME="btn" VALUE=" Relocar " class="botao2" ONCLICK="relocar()">
    <INPUT type="button" NAME="btn" VALUE=" Remover " class="botao2" ONCLICK="remover()">
    <INPUT type="button" NAME="btn" VALUE=" Cancelar " class="botao2" ONCLICK="limpa()">
  </td>
 <%else%>
	<td align="center">
    <INPUT type="button" NAME="btn" VALUE=" Alocar" class="botao2" ONCLICK="javascript:alocar()">
    <INPUT type="button" NAME="btn" VALUE=" Cancelar " class="botao2" onclick="limpa()">
  </td>
 <%end if%>
</tr>
</table>
</form>
<script>
verificaVoltar();
parent.frames[0].gravacookie("flag_2=0");
</script>
</body>
</html>
<!--#include file="includes\rodape.inc"-->