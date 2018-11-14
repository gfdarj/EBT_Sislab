<!--#include file="../includes/Sislab_Lib.asp"-->
<!--#include file="../includes/PadraoHTML.asp" -->
<!--#include file="../includes/global.asp" -->
<!--#include file="../includes/controlesHTML.asp" -->

<!--#include file="includes/funcoesAux.inc"-->
<%
'adicionar aqui verificacoes de seguranca / acesso

dim objConn, objSP, ret

if( request.form( "cto_nome" ) = "" or request.form( "tpc_id" ) = "" ) then
	response.redirect( "circuitos.asp" )
end if

Dim cto_id
Dim cto_nome
Dim tpc_id
Dim AS_id
Dim cto_permanente
Dim cto_ativado

cto_id = request("cto_id")
If VVVNZ(ctp_id) Then ctp_id = Null

cto_nome = request("cto_nome")
If VVVNZ(cto_nome) Then cto_nome = Null

tpc_id = request("tpc_id")
If VVVNZ(tpc_id) Then tpc_id = Null

AS_id = request("AS_id")
If VVVNZ(AS_id) Then AS_id = Null

cto_permanente = request.form( "cto_permanente" )
If VVVN(cto_permanente) Then cto_permanente = Null

cto_ativado = request.form( "cto_ativado" )
If VVVN(cto_ativado) Then cto_ativado = Null

if IsNull(cto_id) then
	call Env.StoredProcedure( true, objSP, "SP_FAC_CADASTRA_CIRCUITO")
	with( objSP )
		.Parameters.Append( .CreateParameter( "RETORNO", adInteger, adParamReturnValue ) )
		.Parameters.Append( .CreateParameter( "@ctoNome", adVarchar, adParamInput, 200, server.htmlencode( request.form( "cto_nome" ) ) ) )
		.Parameters.Append( .CreateParameter( "@tpcID", adInteger, adParamInput, , tpc_id ) )
		.Parameters.Append( .CreateParameter( "@ASID", adInteger, adParamInput, , AS_id ) )
		.Parameters.Append( .CreateParameter( "@ctoPermanente", adBoolean, adParamInput, , cto_permanente ) )
		.Parameters.Append( .CreateParameter( "@ctoAtivado", adBoolean, adParamInput, , cto_ativado ) )

		.execute
		ret = .Parameters( "RETORNO" )
	end with
	call Env.StoredProcedure( false, objSP, "SP_FAC_CADASTRA_CIRCUITO")
Else
	call Env.StoredProcedure( true, objSP, "SP_FAC_ATUALIZA_CIRCUITO")
	with( objSP )
		.Parameters.Append( .CreateParameter( "RETORNO", adInteger, adParamReturnValue ) )
		.Parameters.Append( .CreateParameter( "@ctoID", adInteger, adParamInput, , cto_id ) )
		.Parameters.Append( .CreateParameter( "@ctoNome", adVarChar, adParamInput, 200, server.htmlencode( request("cto_nome") ) ) )
		.Parameters.Append( .CreateParameter( "@tpcID", adInteger, adParamInput, , tpc_id ) )
		.Parameters.Append( .CreateParameter( "@ASID", adInteger, adParamInput, , AS_id ) )
		.Parameters.Append( .CreateParameter( "@ctoPermanente", adInteger, adParamInput, , cto_permanente ) )
		.Parameters.Append( .CreateParameter( "@ctoAtivado", adInteger, adParamInput, , cto_ativado ) )

		.execute()
		ret = .Parameters( "RETORNO" )
	end with
	call Env.StoredProcedure( false, objSP, "SP_FAC_ATUALIZA_CIRCUITO")
End if

if( ret < 0 ) then
	call ErroBD( "Nao foi possivel adicionar/alterar o circuito (" & ret & ")" )
else %>
<html>
<body>
<script type="text/javascript"><%
	if( request.form( "cto_id" ) <> "" ) then %>
window.opener.location.href = "ed_circuito.asp?cto_id=<%= request.form( "cto_id" ) %>";
window.close();<%
	else %>
parent.location.href = "ed_circuito.asp?cto_id=<%= ret %>";<%
	end if %>
</script>
</body>
</html><%
end if %>
