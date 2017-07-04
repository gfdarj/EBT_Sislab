<!--#include file="includes\cabecalho.inc"-->
<!--#include file="../includes/conexao.inc"-->
<!--#include file="includes\funcoesAux.inc"-->
<%
	Dim tipo, selecionado
	tipo = request.querystring("tipo")
	selecionado = request.querystring("selecionado")
%>
<html>
<head>
	<title>Agendamento</title>
<script language="JavaScript">
parent.frames[2].document.all.atividadeCelula.innerHTML = "<font class='fonte2'>Aguarde...</font>";
var str = '<font class="fonte2">'
 		str+= '<select name="tarefa_id" class="select7" onchange="mudaAtividade()">';
		str+= '<option value="-1"> -- Escolha a Atividade -- '
<%
	Dim objConn, objRS
	Call Connection(True, objConn)
	if tipo = 0 then
		call RecordSet(True, objRS, "SELECT * FROM Agendamento order by ag_numero desc", objConn)
		If not(objRS.EOF AND objRS.BOF) Then
			While( NOT( objRS.EOF ) )%>
				str += '<option value="<%=objRS("AG_NUMERO")%>"><%=objRS("AG_NUMERO")%>: <% trocaAspas(objRS("AG_OBJETIVO"))%>';
<%			objRS.MoveNext
			Wend
		End If
		Call RecordSet(False, objRS, Null, Null)
	else%>
		str+= '<option value="-2"> --    Nova Tarefa    -- '
<%	call RecordSet(True, objRS, "select * from tarefas order by tar_descricao", objConn)
		If not(objRS.EOF AND objRS.BOF) Then
			While( NOT( objRS.EOF ) )%>
				str += '<option value="<%=objRS("TAR_ID")%>"><% trocaAspas(objRS("TAR_DESCRICAO"))%>';
<%			objRS.MoveNext
			Wend
		End If
		Call RecordSet(False, objRS, Null, Null)
	end if
	Call Connection(False, objConn)
%>
str+='</select>';
str+='</font>';
str+='<INPUT TYPE="text" NAME="nova_tarefa" MAXLENGTH="250" class="texto7" style="display:none;">';

parent.frames[2].document.all.atividadeCelula.innerHTML = str;
parent.frames[2].document.frmInicioTermino.tarefa_id.value = "<%=selecionado%>";
</script>
</head>
<body>
</body>
</html>
<!--#include file="includes\rodape.inc"-->