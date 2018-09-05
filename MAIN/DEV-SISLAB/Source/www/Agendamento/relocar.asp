<!--#include file="includes\cabecalho.inc"-->
<!--#include file="../includes/conexao.inc"-->
<% 
	on error resume next

  Dim tp_id, tarefa_id, tp_datainicial, tp_datafinal, _
			pes_username, tp_observacao, tarefa_tipo
	tp_id						= request.form("tpid")
	tarefa_id				= request.form("tarefa_id")
	tp_datainicial	= request.form("tp_datainicial")
	tp_datafinal		= request.form("tp_datafinal")
	pes_username		= request.form("pes_username")
	tp_observacao		= request.form("tp_observacao")
	tarefa_tipo			= request.form("tarefa_tipo")

	Dim objConn, objSP, erroBD
	call Connection(True, objConn)
	Call StoredProcedure(True, objSP, "SP_AG_RELOCA", objConn)
	With objSP
		.Parameters.Append .CreateParameter("RETORNO", 					adInteger, adParamReturnValue)
		.Parameters.Append .CreateParameter("@tp_id", 					adInteger, adParamInput, , tp_id)
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
	call Connection(False, objConn)
%>
<html>
<head>
<title>Agendamento</title>
<script>
<%if (erroBD > 0) then%>
  var frm = parent.frames[0].document.formSuperior;
  frm.action = "agendatab.asp";
  frm.target = "tabela";
	parent.frames[0].gravacookie("flag_1=1");
  frm.submit();
  frm.action = "agendainf.asp";
  frm.target = "inferior";
	parent.frames[0].gravacookie("flag_2=1");
  frm.submit();
	alert("Relocação efetivada com sucesso!");
<%else
		if erroBD = -2 then%>
		alert("Período de Alocação Inválido!");
<%	else%>
		alert("Houve um erro imprevisível no Banco de Dados.\nA alocação não foi efetivada.<%=erroBD%>");
<%	end if
	end if%>
</script>
</head>
<body>
</body>
</html>
<!--#include file="includes\rodape.inc"-->