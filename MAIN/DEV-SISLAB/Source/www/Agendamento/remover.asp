<!--#include file="includes\cabecalho.inc"-->
<!--#include file="../includes/conexao.inc"-->
<% 
  Dim tp_id
	tp_id	= request.form("tpid")

	Dim objConn, objSP, erroBD
	call Connection(True, objConn)
	Call StoredProcedure(True, objSP, "SP_AG_REMOVE", objConn)
	With objSP
		.Parameters.Append .CreateParameter("RETORNO",	adInteger, adParamReturnValue)
		.Parameters.Append .CreateParameter("@tp_id",		adInteger, adParamInput, , tp_id)
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
	alert("A alocação foi removida com sucesso!");
<%else%>
	alert("Houve um erro imprevisível no Banco de Dados.\nA alocação não pode ser removida.<%=erroBD%>");
<%end if%>
</script>
</head>
<body>
</body>
</html>
<!--#include file="includes\rodape.inc"-->