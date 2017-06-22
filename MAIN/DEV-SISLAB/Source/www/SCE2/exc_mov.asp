<!--#include file="../includes/conexao.inc"-->
<!--#include file="includes/bib_str.asp"-->
<!--#include file="includes/bib_bd.asp"-->
<!--#include file="includes/abre.asp"-->
<%
Dim mov_id, user_id

mov_id = request("mov_id")
user_id = session("user_id")

Call StoredProcedure(True, objSP, "sp_SCE_EXCLUI_MOVIMENTACAO", Conn)
With objSP
	.Parameters.item("@mov_id").Value = mov_id
	.Parameters.item("@user_id").Value = session("user_id")
	on error resume next
	.Execute
	on error goto 0
End With
Call StoredProcedure(False, objSP, "sp_SCE_EXCLUI_MOVIMENTACAO", Conn)

If conn.Errors.Count > 0 Then
	Call erroDB (conn.Errors, "")
Else
	'-- Submete para o arquivo de relatorio fazendo com que a listagem seja atualizada --%>
	<html>
	<body>
		<form name="formulario" action="rel_mov2.asp" method="post">
		<input type="Hidden" name="ssql" value="<%=request("ssql")%>"
		</form>
		<script language="JavaScript">
			document.forms[0].submit();
		</script>
	</body>
	</html>
<%
End If

Conn.Close
Set Conn = Nothing
%>