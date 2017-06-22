<!-- #INCLUDE FILE="includes/abre.asp" -->
<!-- #INCLUDE FILE="includes/conexao.inc" -->
<!-- #INCLUDE FILE="includes/bib_bd.asp" -->
<%
Dim categoria, eq_id, s, rec

eq_id = request("eq_id")
categoria = request("categoria")
apagamovimentos = request("apagamovimentos")

if categoria = CAT_CONSUMIVEL or categoria = CAT_EQUIPAMENTO then

	'-- Verifica se existe movimentos para o equipamento
	'-- caso exista, tem que perguntar se deseja excluir o item
	'-- e todas as suas movimentacoes
	if apagamovimentos = "" then
		if categoria = CAT_CONSUMIVEL then
			s = "select count(*) from SCE_Movimentacao_Consumiveis "
			s = s & "where CON_ID = " & eq_id
		else
			s = "select count(*) from SCE_Movimentacao where EQ_ID = " & eq_id
		end if
		set rec = conn.execute(s)
		'-- existe movimentos, entao pergunto e paro a execucao deste script
		if rec(0) > 0 then ConfirmaExclusao eq_id, categoria
	end if

	if categoria = CAT_CONSUMIVEL then
		'-- apaga o consumivel e todo o seu histórico
		Call StoredProcedure(True, objSP, "SP_SCE_EXCLUI_CONSUMIVEL", Conn)
		With objSP
			.Parameters.item("@CON_ID") = eq_id
			.Parameters.item("@USER_ID") = session("user_id")
			on error resume next
			.Execute
			on error goto 0
		End With
		Call StoredProcedure(False, objSP, Null, Null)
	else
		'-- apaga o equipamento e todo o seu histórico
		Call StoredProcedure(True, objSP, "SP_SCE_EXCLUI_EQUIPAMENTO", Conn)
		With objSP
			.Parameters.item("@EQ_ID") = eq_id
			.Parameters.item("@USER_ID") = session("user_id")
			on error resume next
			.Execute
			on error goto 0
		End With
		Call StoredProcedure(False, objSP, Null, Null)
	End If

	'-- verifica se ocorreu algum erro
	If conn.Errors.Count > 0 Then
		erroDB conn.Errors, "location.href='cad_acess_item.asp?eq_id=" & eq_id & "&categoria=" & categoria & "'"
	else
		response.redirect "cad_acess_item.asp?excluiu=1"
	End If
else%>
<html>
	<head><title>SCE - [ERRO]</title></head>
	<body><script language="JavaScript">alert('Categoria inválida !'); history.go(-1);</script></body>
</html>
<%
end if

Conn.Close


'-- Exibe alert para usuario confirmar a exclusao do equipamento, caso
'-- existam movimentaçoes para o mesmo
Function ConfirmaExclusao(eq_id, categoria)%>
<html>
	<head><title>SCE - [Confirmação de exclusão]</title></head>
	<body>
	<script language="JavaScript">
	if(confirm('ATENÇÃO !!!\n\nEste equipamento possui movimentações.\n\nExcluindo o mesmo, TODAS os seus movimentos, controles e históricos também serão excluídos.\n\nDeseja continuar ?')) {
		location.href = 'exc_item.asp?eq_id=<%=eq_id%>&categoria=<%=categoria%>&apagamovimentos=1';
	}
	else
		history.go(-1);
	</script>
	</body>
</html>
<%	response.end
End Function

%>
