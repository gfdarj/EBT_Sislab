<!--#include file="includes\cabecalho.inc"-->
<!--#include file="../includes/conexao.inc"-->
<% 
  Dim tp_id, tarefa_id, tp_datainicial, tp_datafinal, _
			pes_username, tp_observacao, tarefa_tipo, nova_tarefa
	tp_id						= request.form("tpid")
	tarefa_id				= request.form("tarefa_id")
	tp_datainicial	= request.form("tp_datainicial")
	tp_datafinal		= request.form("tp_datafinal")
	pes_username		= request.form("pes_username")
	tp_observacao		= request.form("tp_observacao")
	tarefa_tipo			= request.form("tarefa_tipo")
	nova_tarefa			= request.form("nova_tarefa")

	Dim objConn, objSP, erroBD, retorno
	call Connection(True, objConn)

	retorno = 0
	if tarefa_id = "-2" then
		Call StoredProcedure(True, objSP, "SP_AG_CADASTRA_TAREFA", objConn)
		With objSP
			.Parameters.Append .CreateParameter("RETORNO", 					adInteger, adParamReturnValue)
			.Parameters.Append .CreateParameter("@nova_tarefa", 		adVarChar, adParamInput, 255, nova_tarefa)
			.Execute
			retorno = .Parameters("RETORNO")
		End With
		tarefa_id = retorno
		Call StoredProcedure(False, objSP, Null, Null)
	end if

	if retorno >= 0 then
		Call StoredProcedure(True, objSP, "SP_AG_ALOCA", objConn)
		With objSP
			.Parameters.Append .CreateParameter("RETORNO", 					adInteger, adParamReturnValue)
			.Parameters.Append .CreateParameter("@tarefa_id", 			adInteger, adParamInput, , tarefa_id)
			.Parameters.Append .CreateParameter("@tp_datainicial", 	adVarChar, adParamInput, 10, tp_datainicial)
			.Parameters.Append .CreateParameter("@tp_datafinal", 		adVarChar, adParamInput, 10, tp_datafinal)
			.Parameters.Append .CreateParameter("@pes_username", 		adVarChar, adParamInput, 10, pes_username)
			.Parameters.Append .CreateParameter("@tp_observacao", 	adVarChar, adParamInput, 8000, tp_observacao)
			.Parameters.Append .CreateParameter("@tarefa_tipo", 		adBoolean, adParamInput, , tarefa_tipo)
			.Execute
			erroBD = .Parameters("RETORNO")
		End With
		Call StoredProcedure(False, objSP, Null, Null)
	end if
	call Connection(False, objConn)%>

<html>
<title>Agendamento</title>
<head>
<script>
<%
if retorno >= 0 then
	if (erroBD > 0) then%>
  var frm = parent.frames[0].document.formSuperior;
  frm.action = "agendatab.asp";
  frm.target = "tabela";
	parent.frames[0].gravacookie("flag_1=1");
  frm.submit();
<%	if retorno <> 0 then%>	
	  var frm = parent.frames[2].document.frmInicioTermino;
  	frm.action = "mudaTipo.asp?tipo=1&selecionado=<%=retorno%>";
	 	frm.target = "escondido";
		frm.method = "post";
	  frm.submit();
<%	end if%>
	alert("Alocação efetivada com sucesso!");
<%else
		if erroBD = -2 then%>
		alert("Período de Alocação Inválido!");
<%	else%>
		alert("Houve um erro imprevisível no Banco de Dados.\nA alocação não foi efetivada.");
<%	end if
	end if
else
	if retorno = -1 then%>
		alert("Houve um erro imprevisível no Banco de Dados.\nA tarefa não foi cadastrada e a alocação não foi efetivada.");
<%else%>
		alert("A descrição desta Tarefa já consta no Banco de Dados!");
<%end if
end if
%>
</script>
</head>
<body>
</body>
</html>
<!--#include file="includes\rodape.inc"-->