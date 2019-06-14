<!--#include file="../includes/Sislab_Lib.asp"-->
<!--#include file="../includes/bib_mensagem.asp"-->
<%
Dim objSP
Dim mov_id, user_id
Dim Erro

mov_id = request("mov_id")
user_id = session("user_id")

response.Write "mov_id: " & mov_id & "<BR>"
response.Write "user_id: " & user_id & "<BR>"
response.End

Call Env.StoredProcedure(True, objSP, "sp_SCE_EXCLUI_MOVIMENTACAO")
With objSP
	.Parameters.item("@mov_id").Value = mov_id
	.Parameters.item("@user_id").Value = session("user_id")
	on error resume next
	.Execute
    Erro = Env.oConn.Errors.Count
	on error goto 0
End With
Call Env.StoredProcedure(False, objSP, "sp_SCE_EXCLUI_MOVIMENTACAO")

'response.Write "OI: Erro=" & Erro
'response.End

If Erro > 0 Then
	Call erroDB (True, True, true, Env.oConn.Errors, "rel_mov.asp", "../")
Else
	'-- Submete para o arquivo de relatorio fazendo com que a listagem seja atualizada --%>
	<html>
	<body>
		<form name="formulario" action="rel_mov2.asp" method="post">
		<input type="hidden" name="ssql" value="<%=request("ssql")%>"
		</form>
		<script type="text/javascript">
			document.forms[0].submit();
		</script>
	</body>
	</html>
<%
End If
%>