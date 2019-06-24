<!------- SCE ------->
<!--#include file="includes/global_SCE.asp"-->

<!------- SISLAB ---->
<!--#include file="../includes/bib_str.asp"-->
<!--#include file="../includes/padraoHTML.asp"-->
<!--#include file="../includes/global.asp" -->   <!-- constantes usada pelo menu -->
<!--#include file="../includes/Geral_Lib.asp"-->
<!--#include file="../includes/Sislab_Lib.asp"-->
<!--#include file="../includes/bib_mensagem.asp" -->
<%
Dim categoria, eq_id, s, rec

eq_id = request("eq_id")
categoria = request("categoria")
apagamovimentos = request("apagamovimentos")

'If categoria = CAT_CONSUMIVEL Or categoria = CAT_EQUIPAMENTO Then

	'-- Verifica se existe movimentos para o equipamento
	'-- caso exista, tem que perguntar se deseja excluir o item
	'-- e todas as suas movimentacoes
	if apagamovimentos = "" then
		if categoria = CAT_CONSUMIVEL then
			s = "select ISNULL(count(*), 0) from SCE_Movimentacao_Consumiveis "
			s = s & "where CON_ID = " & eq_id
		else
			s = "select count(*) from SCE_Movimentacao where EQ_ID = " & eq_id
		end if
		set rec = Env.oConn.execute(s)
		'-- existe movimentos, entao pergunto e paro a execucao deste script
		if rec(0) > 0 then ConfirmaExclusao eq_id, categoria
	end if

	if categoria = CAT_CONSUMIVEL then
		'-- apaga o consumivel e todo o seu histórico
		Call Env.StoredProcedure(True, objSP, "SP_SCE_EXCLUI_CONSUMIVEL")
		With objSP
			.Parameters.item("@CON_ID") = eq_id
			.Parameters.item("@USER_ID") = session("user_id")
			on error resume next
			.Execute
			on error goto 0
		End With
		Call Env.StoredProcedure(False, objSP, Null)
	else
		'-- apaga o equipamento e todo o seu histórico
		Call Env.StoredProcedure(True, objSP, "SP_SCE_EXCLUI_EQUIPAMENTO")
		With objSP
			.Parameters.item("@EQ_ID") = eq_id
			.Parameters.item("@USER_ID") = session("user_id")
			on error resume next
			.Execute
			on error goto 0
		End With
		Call Env.StoredProcedure(False, objSP, Null)
	End If

	'-- verifica se ocorreu algum erro
	If Env.oConn.Errors.Count > 0 Then
		'erroDB Env.oConn.Errors, "location.href='cad_acess_item.asp?eq_id=" & eq_id & "&categoria=" & categoria & "'"
		Call erroDB(true, true, true, Env.oConn.Errors, "cad_acess_item.asp?eq_id=" & eq_id & "&categoria=" & categoria, "../")
	Else
		response.redirect "cad_acess_item.asp?excluiu=1"
	End If
'else
'    Tela.SCE = True
'    Tela.SetNomeTela = "Cadastro > Exclusão de Item" : Tela.SetCaminhoRelativo = "../"
'    Call Tela.MostraCabecalho()
%>
	<script type="text/javascript">
        //alert('Categoria inválida !');
        //history.go(-1);
	</script>
<%
'    Call Tela.MostraRodape()
'End if



'-- Exibe alert para usuario confirmar a exclusao do equipamento, caso
'-- existam movimentaçoes para o mesmo
Function ConfirmaExclusao(eq_id, categoria)

    Tela.SCE = True
    Tela.SetNomeTela = "Cadastro > Exclusão de Item" : Tela.SetCaminhoRelativo = "../"
    Call Tela.MostraCabecalho()
%>
	<script type="text/javascript">
        if (confirm('ATENÇÃO !!!\n\nEste equipamento possui movimentações.\n\nExcluindo o mesmo, TODAS os seus movimentos, controles e históricos também serão excluídos.\n\nDeseja continuar ?'))
        {
            location.href = 'exc_item.asp?eq_id=<%=eq_id%>&categoria=<%=categoria%>&apagamovimentos=1';
        }
        else
        {
            history.go(-1);
        }
	</script>
<%
    Call Tela.MostraRodape()
    Response.End
End Function
%>
